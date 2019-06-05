Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C54F361A9
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2019 18:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbfFEQxK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jun 2019 12:53:10 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:45724 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbfFEQxJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jun 2019 12:53:09 -0400
Received: by mail-io1-f47.google.com with SMTP id e3so20739792ioc.12
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Jun 2019 09:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=xX3e7ZfyNUwwoZ0CO9bSPTf+jZmLHIr/mEve4KG0ewE=;
        b=IZDwcpmqXMmyNu3yXncjbeJ1RqDSyP80Q51p2GGuHzRmpf7wp8mdUGlmqg3pJFroXV
         O/ahXkKH/U0yh6gkBsW2i+JZATz2/p1TT9ihWWMTG+1gBCtSu2Xb6dJCnVSn+ifpfbr5
         4M1M1LEJxH09A7q3swrwi8F8CLl3LF1K0Dpus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=xX3e7ZfyNUwwoZ0CO9bSPTf+jZmLHIr/mEve4KG0ewE=;
        b=jv+f7A+1/K9A20ZadeXoEtjPkeMOFqYXGNGscAqxO+7IqKn1NG6WhoRKrt2NzsrWUk
         2qxnLjCOcKJ6U/iqj3JBSxwCAqALkiFsySECjDK0b7BCFqtXg8kqG5K/MGN5YbhVSPHO
         7+7izjLHXTonLrHPZHvN92yoav1k5SEAgE8UIQN+XTawTxyMaWnMYnE7gbsUl/rS+06L
         fUPsZc4p03tnsxT1FNA4+B9tRhWytJ3FWlMVX103UXaKaq2wQzh3i6WG9SrKo3FNpSJx
         w+YWvFTyXnZcO5K4uCs97KfUQleiAwS1sVot51uvRHgJdIMgbMoOp/MCPfSo4CLXx09n
         3HGA==
X-Gm-Message-State: APjAAAXblcDmilAFSfYztNviqetjNF3QoiTjkkEBUNllFBawy5Fm5Uqk
        zvwkClYHmlN7PVUo4HMy1ulpSw==
X-Google-Smtp-Source: APXvYqxxcSv26bY4ogKoEHC8jr1v8xcz1rLFJSAL7gHZaA2eEGaJ90c9NLu8AtTEMVQ3jJvKbH8IwA==
X-Received: by 2002:a5d:8c81:: with SMTP id g1mr25131184ion.239.1559753588725;
        Wed, 05 Jun 2019 09:53:08 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u187sm7290991iod.37.2019.06.05.09.53.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 09:53:07 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes update for Linux 5.2-rc4
Message-ID: <c5b4091c-b6bc-0eea-7f64-5334c80be8ed@linuxfoundation.org>
Date:   Wed, 5 Jun 2019 10:53:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------2CE3A6454A5D7648C72F9997"
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------2CE3A6454A5D7648C72F9997
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest fixes update for Linux 5.2-rc4.

This Kselftest update for Linux 5.2-rc4 consists of

- Alex Shi's fixes to cgroup tests
- Alakesh Haloi's fix to userfaultfd compiler warning
- Naresh Kamboju's fix to vm install to include test script to run
   the test.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------

The following changes since commit eff82a263b5cfa3427fd9dbfedd96da94fdc9f19:

   selftests: rtc: rtctest: specify timeouts (2019-05-24 13:39:58 -0600)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-5.2-rc4

for you to fetch changes up to bc2cce3f2ebcae02aa4bb29e3436bf75ee674c32:

   selftests: vm: install test_vmalloc.sh for run_vmtests (2019-05-30 
08:32:57 -0600)

----------------------------------------------------------------
linux-kselftest-5.2-rc4

This Kselftest update for Linux 5.2-rc4 consists of

- Alex Shi's fixes to cgroup tests
- Alakesh Haloi's fix to userfaultfd compiler warning
- Naresh Kamboju's fix to vm install to include test script to run
   the test.

----------------------------------------------------------------
Alakesh Haloi (1):
       userfaultfd: selftest: fix compiler warning

Alex Shi (3):
       kselftest/cgroup: fix unexpected testing failure on test_memcontrol
       kselftest/cgroup: fix unexpected testing failure on test_core
       kselftest/cgroup: fix incorrect test_core skip

Naresh Kamboju (1):
       selftests: vm: install test_vmalloc.sh for run_vmtests

  tools/testing/selftests/cgroup/test_core.c       | 7 ++++++-
  tools/testing/selftests/cgroup/test_memcontrol.c | 4 ++++
  tools/testing/selftests/vm/Makefile              | 2 ++
  tools/testing/selftests/vm/userfaultfd.c         | 2 +-
  4 files changed, 13 insertions(+), 2 deletions(-)

----------------------------------------------------------------

--------------2CE3A6454A5D7648C72F9997
Content-Type: text/x-patch;
 name="linux-kselftest-5.2-rc4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-5.2-rc4.diff"

diff --git a/tools/testing/selftests/cgroup/test_core.c b/tools/testing/selftests/cgroup/test_core.c
index be59f9c34ea2..79053a4f4783 100644
--- a/tools/testing/selftests/cgroup/test_core.c
+++ b/tools/testing/selftests/cgroup/test_core.c
@@ -198,7 +198,7 @@ static int test_cgcore_no_internal_process_constraint_on_threads(const char *roo
 	char *parent = NULL, *child = NULL;
 
 	if (cg_read_strstr(root, "cgroup.controllers", "cpu") ||
-	    cg_read_strstr(root, "cgroup.subtree_control", "cpu")) {
+	    cg_write(root, "cgroup.subtree_control", "+cpu")) {
 		ret = KSFT_SKIP;
 		goto cleanup;
 	}
@@ -376,6 +376,11 @@ int main(int argc, char *argv[])
 
 	if (cg_find_unified_root(root, sizeof(root)))
 		ksft_exit_skip("cgroup v2 isn't mounted\n");
+
+	if (cg_read_strstr(root, "cgroup.subtree_control", "memory"))
+		if (cg_write(root, "cgroup.subtree_control", "+memory"))
+			ksft_exit_skip("Failed to set memory controller\n");
+
 	for (i = 0; i < ARRAY_SIZE(tests); i++) {
 		switch (tests[i].fn(root)) {
 		case KSFT_PASS:
diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 6f339882a6ca..c19a97dd02d4 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -1205,6 +1205,10 @@ int main(int argc, char **argv)
 	if (cg_read_strstr(root, "cgroup.controllers", "memory"))
 		ksft_exit_skip("memory controller isn't available\n");
 
+	if (cg_read_strstr(root, "cgroup.subtree_control", "memory"))
+		if (cg_write(root, "cgroup.subtree_control", "+memory"))
+			ksft_exit_skip("Failed to set memory controller\n");
+
 	for (i = 0; i < ARRAY_SIZE(tests); i++) {
 		switch (tests[i].fn(root)) {
 		case KSFT_PASS:
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index e13eb6cc8901..05306c58ff9f 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -25,6 +25,8 @@ TEST_GEN_FILES += virtual_address_range
 
 TEST_PROGS := run_vmtests
 
+TEST_FILES := test_vmalloc.sh
+
 KSFT_KHDR_INSTALL := 1
 include ../lib.mk
 
diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 5d1db824f73a..b3e6497b080c 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -123,7 +123,7 @@ static void usage(void)
 	fprintf(stderr, "Supported <test type>: anon, hugetlb, "
 		"hugetlb_shared, shmem\n\n");
 	fprintf(stderr, "Examples:\n\n");
-	fprintf(stderr, examples);
+	fprintf(stderr, "%s", examples);
 	exit(1);
 }
 

--------------2CE3A6454A5D7648C72F9997--
