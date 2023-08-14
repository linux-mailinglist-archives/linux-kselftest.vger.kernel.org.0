Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D14177B707
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 12:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbjHNKqd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 06:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbjHNKqC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 06:46:02 -0400
Received: from out203-205-251-53.mail.qq.com (out203-205-251-53.mail.qq.com [203.205.251.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A93DD2;
        Mon, 14 Aug 2023 03:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1692009955;
        bh=umFsdvDAuvz1J8EoJo1lr2CqjYOfjh1XPn/9tPSiG4Y=;
        h=From:To:Cc:Subject:Date;
        b=xFJ6BehuCpx83twfFIAQ7Or3PYxyyNfZYb3G6zlD9PTD3iEamNckUK/PAS/BKBbUo
         PgicPDmem6m6eOhXkD2LU72EZ7its13ndR7/0QO909DIOngj1YnuerfYZ+wNXwwNmL
         TOoYCP0NOkxIbMg2mGngdDjoD3Ldrd3x+VCCyUmE=
Received: from localhost.localdomain ([39.156.73.12])
        by newxmesmtplogicsvrszb1-0.qq.com (NewEsmtp) with SMTP
        id B74184DB; Mon, 14 Aug 2023 18:45:52 +0800
X-QQ-mid: xmsmtpt1692009952t89pqxxic
Message-ID: <tencent_64FC724AC5F05568F41BD1C68058E83CEB05@qq.com>
X-QQ-XMAILINFO: N+tZcXNNUKPOOU6mrYt7eWO5IlTUiooyQVOdfe5Xk6wjeGjCYen6UhWbYnGIdH
         /nqtCJeRFxzlETRA6KlREZfPDs2OcddzVgoJrlkvjg2wH46gEDwy8kGxKWRu6/nx0WfLHmqAdGly
         w5WWWEaQbY8uTZjoPFXYBGlgM8mjtZPj3xN5o4Wm2abicfRQ1dF9NUCbTjDklWgj38rwfJJgzjsd
         uPSK6mGYpqe99cJUJheEx2aaz+5lea04tzsa3QuCthHpwYp5MTHeD1yECBuLdJksPt2HW/i/8YRd
         qBMwyOylGGNdQ7o2B2fQ26/ocNR768d4I32hgLjX4z35FE0OQZE7uUipppqE6pkgXmrmcdDv/Oi4
         rTELURsWNdmfXJHlN24ga8PeJscUoXbxlX31kJfKKpGwqO60R2TB3IEC4uvL+CzAsPBLHr3Xh5hU
         TINsI3DBwAWW2Eo47/v/3WCYiKI+w8MNRzyRQST6YG4UMPIqgjHGJEIx0CYLvZMQyrsqZPo/2rnt
         W/OgTuYeyn0BaBRLcm0FB+LhjPFwkM7CLxlv8u+08qKRqca9qKrFtCXXuqlhcZ31J4hhAOSqr117
         qS1NyFr2IiP10tKDBg8lme9IqqYS2fRCgDr8LEBw6GujUjZLoGVZ6baaE56nNZVEZfp1RQhUufDN
         eCeRLTJ392h+vIqmZtUrVLaXV+FZTPJowV0MBhvRw6jgXM0GQfQ51d71+a2V5ujvKLcIRDQJifjg
         IuCQMfYtYW3JbHil2So4IY6kslGk39llFx+pmPlZQz0DZTpXDQfZx6tcUm1d20rQXV9Z2K7KQOTU
         9f+IAuDvr5IsclD5j0ywsoIJPKUBv7Y+MWp51TnvGSjnQgl1MqqKkgFet3arDLze4lTeclDS8Zxu
         jAAFzqeBpQlfdiCDfrnHAbKOMYwkSwX6NRv9XQxDWYaeoDU7wjPqDa/tsm+9Ee4SfCdISbwwgwFN
         ipUB6Wt7iZ4KAFUBYdK88FTVbUylGkgb52LC7tFEzw/qvzQWhWQpAikCikxBywJjXpzojpG9TcC9
         CFOWZzzA==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From:   Rong Tao <rtoax@foxmail.com>
To:     akpm@linux-foundation.org
Cc:     rongtao@cestc.cn, rtoax@foxmail.com, Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] selftests/mm: fix uffd-stress help information
Date:   Mon, 14 Aug 2023 18:45:50 +0800
X-OQ-MSGID: <20230814104550.62846-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

commit 686a8bb72349("selftests/mm: split uffd tests into uffd-stress and
uffd-unit-tests") split uffd tests into uffd-stress and uffd-unit-tests,
obviously we need to modify the help information synchronously.

Also modify code indentation.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/testing/selftests/mm/uffd-stress.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index 995ff13e74c7..e40b6d7d2c0e 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -53,21 +53,21 @@ pthread_attr_t attr;
 	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
 
 const char *examples =
-    "# Run anonymous memory test on 100MiB region with 99999 bounces:\n"
-    "./userfaultfd anon 100 99999\n\n"
-    "# Run share memory test on 1GiB region with 99 bounces:\n"
-    "./userfaultfd shmem 1000 99\n\n"
-    "# Run hugetlb memory test on 256MiB region with 50 bounces:\n"
-    "./userfaultfd hugetlb 256 50\n\n"
-    "# Run the same hugetlb test but using private file:\n"
-    "./userfaultfd hugetlb-private 256 50\n\n"
-    "# 10MiB-~6GiB 999 bounces anonymous test, "
-    "continue forever unless an error triggers\n"
-    "while ./userfaultfd anon $[RANDOM % 6000 + 10] 999; do true; done\n\n";
+	"# Run anonymous memory test on 100MiB region with 99999 bounces:\n"
+	"./uffd-stress anon 100 99999\n\n"
+	"# Run share memory test on 1GiB region with 99 bounces:\n"
+	"./uffd-stress shmem 1000 99\n\n"
+	"# Run hugetlb memory test on 256MiB region with 50 bounces:\n"
+	"./uffd-stress hugetlb 256 50\n\n"
+	"# Run the same hugetlb test but using private file:\n"
+	"./uffd-stress hugetlb-private 256 50\n\n"
+	"# 10MiB-~6GiB 999 bounces anonymous test, "
+	"continue forever unless an error triggers\n"
+	"while ./uffd-stress anon $[RANDOM % 6000 + 10] 999; do true; done\n\n";
 
 static void usage(void)
 {
-	fprintf(stderr, "\nUsage: ./userfaultfd <test type> <MiB> <bounces>\n\n");
+	fprintf(stderr, "\nUsage: ./uffd-stress <test type> <MiB> <bounces>\n\n");
 	fprintf(stderr, "Supported <test type>: anon, hugetlb, "
 		"hugetlb-private, shmem, shmem-private\n\n");
 	fprintf(stderr, "Examples:\n\n");
-- 
2.39.3

