Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51886929CE
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Feb 2023 23:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbjBJWEC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Feb 2023 17:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbjBJWEC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Feb 2023 17:04:02 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6920D7E025
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Feb 2023 14:04:01 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id AC6A26BFC2EB; Fri, 10 Feb 2023 13:50:33 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org
Subject: [RFC PATCH v2 17/19] selftests/vm: add KSM get merge type test
Date:   Fri, 10 Feb 2023 13:50:21 -0800
Message-Id: <20230210215023.2740545-18-shr@devkernel.io>
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

This adds the -G flag to the ksm_tests to query if prctl has been used
to enable ksm merging.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 tools/testing/selftests/mm/ksm_tests.c | 37 ++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/ksm_tests.c b/tools/testing/selft=
ests/mm/ksm_tests.c
index 386a0929c8a3..9667cb3b8c6a 100644
--- a/tools/testing/selftests/mm/ksm_tests.c
+++ b/tools/testing/selftests/mm/ksm_tests.c
@@ -45,6 +45,7 @@ enum ksm_merge_type {
 enum ksm_test_name {
 	CHECK_KSM_MERGE,
 	CHECK_KSM_UNMERGE,
+	CHECK_KSM_GET_MERGE_TYPE,
 	CHECK_KSM_ZERO_PAGE_MERGE,
 	CHECK_KSM_NUMA_MERGE,
 	KSM_MERGE_TIME,
@@ -124,7 +125,8 @@ static void print_help(void)
 	       " -D evaluate unmerging time and speed when disabling KSM.\n"
 	       "    For this test, the size of duplicated memory area (in MiB)\=
n"
 	       "    must be provided using -s option\n"
-	       " -C evaluate the time required to break COW of merged pages.\n\=
n");
+	       " -C evaluate the time required to break COW of merged pages.\n"
+	       " -G query merge mode\n\n");
=20
 	printf(" -a: specify the access protections of pages.\n"
 	       "     <prot> must be of the form [rwx].\n"
@@ -323,6 +325,31 @@ static int check_ksm_merge(int merge_type, int mappi=
ng, int prot,
 	return KSFT_FAIL;
 }
=20
+static int check_ksm_get_merge_type(void)
+{
+	if (prctl(PR_SET_MEMORY_MERGE, 1)) {
+		perror("prctl set");
+		return 1;
+	}
+
+	int is_on =3D prctl(PR_GET_MEMORY_MERGE, 0);
+
+	if (prctl(PR_SET_MEMORY_MERGE, 0)) {
+		perror("prctl set");
+		return 1;
+	}
+
+	int is_off =3D prctl(PR_GET_MEMORY_MERGE, 0);
+
+	if (is_on && is_off) {
+		printf("OK\n");
+		return KSFT_PASS;
+	}
+
+	printf("Not OK\n");
+	return KSFT_FAIL;
+}
+
 static int check_ksm_unmerge(int merge_type, int mapping, int prot, int =
timeout, size_t page_size)
 {
 	void *map_ptr;
@@ -733,7 +760,7 @@ int main(int argc, char *argv[])
 	bool merge_across_nodes =3D KSM_MERGE_ACROSS_NODES_DEFAULT;
 	long size_MB =3D 0;
=20
-	while ((opt =3D getopt(argc, argv, "ha:p:l:z:m:s:t:MUZNPCHD")) !=3D -1)=
 {
+	while ((opt =3D getopt(argc, argv, "ha:p:l:z:m:s:t:GMUZNPCHD")) !=3D -1=
) {
 		switch (opt) {
 		case 'a':
 			prot =3D str_to_prot(optarg);
@@ -792,6 +819,9 @@ int main(int argc, char *argv[])
 		case 'Z':
 			test_name =3D CHECK_KSM_ZERO_PAGE_MERGE;
 			break;
+		case 'G':
+			test_name =3D CHECK_KSM_GET_MERGE_TYPE;
+			break;
 		case 'N':
 			test_name =3D CHECK_KSM_NUMA_MERGE;
 			break;
@@ -841,6 +871,9 @@ int main(int argc, char *argv[])
 		ret =3D check_ksm_unmerge(merge_type, MAP_PRIVATE | MAP_ANONYMOUS, pro=
t,
 					ksm_scan_limit_sec, page_size);
 		break;
+	case CHECK_KSM_GET_MERGE_TYPE:
+		ret =3D check_ksm_get_merge_type();
+		break;
 	case CHECK_KSM_ZERO_PAGE_MERGE:
 		ret =3D check_ksm_zero_page_merge(merge_type, MAP_PRIVATE | MAP_ANONYM=
OUS, prot,
 						page_count, ksm_scan_limit_sec, use_zero_pages,
--=20
2.30.2

