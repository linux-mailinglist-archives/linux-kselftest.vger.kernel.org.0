Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D066929BA
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Feb 2023 22:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbjBJV6E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Feb 2023 16:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbjBJV6D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Feb 2023 16:58:03 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B7F7DD22
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Feb 2023 13:58:02 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id B0F636BFC2ED; Fri, 10 Feb 2023 13:50:33 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org
Subject: [RFC PATCH v2 18/19] selftests/vm: add KSM fork test
Date:   Fri, 10 Feb 2023 13:50:22 -0800
Message-Id: <20230210215023.2740545-19-shr@devkernel.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230210215023.2740545-1-shr@devkernel.io>
References: <20230210215023.2740545-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_NEUTRAL,TVD_RCVD_IP autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add fork test to verify that the MMF_VM_MERGE_ANY flag is inherited by
the child process.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 tools/testing/selftests/mm/ksm_tests.c | 53 +++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/ksm_tests.c b/tools/testing/selft=
ests/mm/ksm_tests.c
index 9667cb3b8c6a..a0a48ac43b29 100644
--- a/tools/testing/selftests/mm/ksm_tests.c
+++ b/tools/testing/selftests/mm/ksm_tests.c
@@ -44,6 +44,7 @@ enum ksm_merge_type {
=20
 enum ksm_test_name {
 	CHECK_KSM_MERGE,
+	CHECK_KSM_MERGE_FORK,
 	CHECK_KSM_UNMERGE,
 	CHECK_KSM_GET_MERGE_TYPE,
 	CHECK_KSM_ZERO_PAGE_MERGE,
@@ -126,7 +127,8 @@ static void print_help(void)
 	       "    For this test, the size of duplicated memory area (in MiB)\=
n"
 	       "    must be provided using -s option\n"
 	       " -C evaluate the time required to break COW of merged pages.\n"
-	       " -G query merge mode\n\n");
+	       " -G query merge mode\n"
+	       " -F evaluate that the KSM process flag is inherited\n\n");
=20
 	printf(" -a: specify the access protections of pages.\n"
 	       "     <prot> must be of the form [rwx].\n"
@@ -325,6 +327,47 @@ static int check_ksm_merge(int merge_type, int mappi=
ng, int prot,
 	return KSFT_FAIL;
 }
=20
+/* Verify that prctl ksm flag is inherited. */
+static int check_ksm_fork(void)
+{
+	int rc =3D KSFT_FAIL;
+	pid_t child_pid;
+
+	if (prctl(PR_SET_MEMORY_MERGE, 1)) {
+		perror("prctl");
+		return KSFT_FAIL;
+	}
+
+	child_pid =3D fork();
+	if (child_pid =3D=3D 0) {
+		int is_on =3D prctl(PR_GET_MEMORY_MERGE, 0);
+
+		if (!is_on)
+			exit(KSFT_FAIL);
+
+		exit(KSFT_PASS);
+	}
+
+	if (child_pid < 0)
+		goto out;
+
+	if (waitpid(child_pid, &rc, 0) < 0)
+		rc =3D KSFT_FAIL;
+
+	if (prctl(PR_SET_MEMORY_MERGE, 0)) {
+		perror("prctl");
+		rc =3D KSFT_FAIL;
+	}
+
+out:
+	if (rc =3D=3D KSFT_PASS)
+		printf("OK\n");
+	else
+		printf("Not OK\n");
+
+	return rc;
+}
+
 static int check_ksm_get_merge_type(void)
 {
 	if (prctl(PR_SET_MEMORY_MERGE, 1)) {
@@ -760,7 +803,7 @@ int main(int argc, char *argv[])
 	bool merge_across_nodes =3D KSM_MERGE_ACROSS_NODES_DEFAULT;
 	long size_MB =3D 0;
=20
-	while ((opt =3D getopt(argc, argv, "ha:p:l:z:m:s:t:GMUZNPCHD")) !=3D -1=
) {
+	while ((opt =3D getopt(argc, argv, "ha:p:l:z:m:s:t:FGMUZNPCHD")) !=3D -=
1) {
 		switch (opt) {
 		case 'a':
 			prot =3D str_to_prot(optarg);
@@ -811,6 +854,9 @@ int main(int argc, char *argv[])
 				merge_type =3D atoi(optarg);
 			}
 			break;
+		case 'F':
+			test_name =3D CHECK_KSM_MERGE_FORK;
+			break;
 		case 'M':
 			break;
 		case 'U':
@@ -867,6 +913,9 @@ int main(int argc, char *argv[])
 		ret =3D check_ksm_merge(merge_type, MAP_PRIVATE | MAP_ANONYMOUS, prot,=
 page_count,
 				      ksm_scan_limit_sec, page_size);
 		break;
+	case CHECK_KSM_MERGE_FORK:
+		ret =3D check_ksm_fork();
+		break;
 	case CHECK_KSM_UNMERGE:
 		ret =3D check_ksm_unmerge(merge_type, MAP_PRIVATE | MAP_ANONYMOUS, pro=
t,
 					ksm_scan_limit_sec, page_size);
--=20
2.30.2

