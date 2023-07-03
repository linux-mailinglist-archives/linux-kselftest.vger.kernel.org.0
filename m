Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5ACC746166
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 19:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjGCR1t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 13:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjGCR1r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 13:27:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FCBE5E;
        Mon,  3 Jul 2023 10:27:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E58A81FF9C;
        Mon,  3 Jul 2023 17:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688405263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tdTsxfSnc5J48DYVbkQ319BZmwsMm6KxF6jWIimyuF0=;
        b=P7mpWSSd6ugptxFXneoMnbkGa/9Ezend+8I1KTyUljga8e4aHu3drlKDPsmevTBxtFolWw
        hSuim1r1I+6KwQd9CNykqFQXkYtst0IqU+Hlw3VJOXcSayzmMIxPfpQ9/ThquUenGMMNnC
        +u5XVCNLhgaKsSntBIawBRTs+jTlGew=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BBFD21358E;
        Mon,  3 Jul 2023 17:27:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wJENLQ8Fo2QqHgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 03 Jul 2023 17:27:43 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH v3 2/3] selftests: cgroup: Minor code reorganizations
Date:   Mon,  3 Jul 2023 19:27:40 +0200
Message-ID: <20230703172741.25392-3-mkoutny@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703172741.25392-1-mkoutny@suse.com>
References: <20230703172741.25392-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

No functional change intended, these small changes are merged into one
commit and they serve as a preparation for an upcoming new testcase.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 MAINTAINERS                                       | 1 +
 tools/testing/selftests/cgroup/cgroup_util.c      | 2 ++
 tools/testing/selftests/cgroup/cgroup_util.h      | 2 ++
 tools/testing/selftests/cgroup/test_core.c        | 2 +-
 tools/testing/selftests/cgroup/test_cpuset_prs.sh | 2 +-
 5 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e0976ae2a523..03bec83944c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5260,6 +5260,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git
 F:	Documentation/admin-guide/cgroup-v1/cpusets.rst
 F:	include/linux/cpuset.h
 F:	kernel/cgroup/cpuset.c
+F:	tools/testing/selftests/cgroup/test_cpuset_prs.sh
 
 CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)
 M:	Johannes Weiner <hannes@cmpxchg.org>
diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index e8bbbdb77e0d..0340d4ca8f51 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -286,6 +286,8 @@ int cg_destroy(const char *cgroup)
 {
 	int ret;
 
+	if (!cgroup)
+		return 0;
 retry:
 	ret = rmdir(cgroup);
 	if (ret && errno == EBUSY) {
diff --git a/tools/testing/selftests/cgroup/cgroup_util.h b/tools/testing/selftests/cgroup/cgroup_util.h
index c92df4e5d395..1df7f202214a 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/cgroup_util.h
@@ -11,6 +11,8 @@
 #define USEC_PER_SEC	1000000L
 #define NSEC_PER_SEC	1000000000L
 
+#define TEST_UID	65534 /* usually nobody, any !root is fine */
+
 /*
  * Checks if two given values differ by less than err% of their sum.
  */
diff --git a/tools/testing/selftests/cgroup/test_core.c b/tools/testing/selftests/cgroup/test_core.c
index 600123503063..80aa6b2373b9 100644
--- a/tools/testing/selftests/cgroup/test_core.c
+++ b/tools/testing/selftests/cgroup/test_core.c
@@ -683,7 +683,7 @@ static int test_cgcore_thread_migration(const char *root)
  */
 static int test_cgcore_lesser_euid_open(const char *root)
 {
-	const uid_t test_euid = 65534;	/* usually nobody, any !root is fine */
+	const uid_t test_euid = TEST_UID;
 	int ret = KSFT_FAIL;
 	char *cg_test_a = NULL, *cg_test_b = NULL;
 	char *cg_test_a_procs = NULL, *cg_test_b_procs = NULL;
diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index 2b5215cc599f..4afb132e4e4f 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -10,7 +10,7 @@
 skip_test() {
 	echo "$1"
 	echo "Test SKIPPED"
-	exit 0
+	exit 4 # ksft_skip
 }
 
 [[ $(id -u) -eq 0 ]] || skip_test "Test must be run as root!"
-- 
2.41.0

