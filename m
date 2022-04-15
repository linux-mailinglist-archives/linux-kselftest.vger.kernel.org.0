Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8AB502DC5
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Apr 2022 18:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349532AbiDOQeY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Apr 2022 12:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243507AbiDOQeX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Apr 2022 12:34:23 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C659FC6272
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Apr 2022 09:31:54 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id e189so8795820oia.8
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Apr 2022 09:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=pqvzZriBexnb3dTylqBqJsPxraE3tG2um5dSfrVfcK4=;
        b=iOEz3x8Z5i7XaP5WoupZj+zZM9SAcWo9yiJzKmd9YPjxjtDmBXzsUg1pFIfAS+wvMJ
         1TBS3NqaJUjDjaSa9g4gMh0/WJQdcci2WgUADRlTrbPTOr70mcNevlfoXpYNENxWfbFG
         EHiyoYpNIHo2CcZotZsR7y93jEF1LzxASvVTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=pqvzZriBexnb3dTylqBqJsPxraE3tG2um5dSfrVfcK4=;
        b=3SNFeeWWmJODcpj9kXVpEhCN3IdAhYJjMdP1N6zS/ZUaInwG/90GH6+6iCHw2NTf4a
         W+iyB0yxLOkbvHwg9LKRdncJc/hLozuCO6C82+j1Kod23YEXRvd4Mh8X8rInWtyeztTk
         wTYlIev30JJKcD2L7xCdlD1bvVkwWCQ6p3mDwR0tYOQq6vcUKxYG8fD8SRnO44/VmnNU
         kPpGMAQsc0sycOK8IrfeCaghnJMa6BaySZnPfITDQ/FQunWqTKDP5MG0Kv5EXEb5Sk39
         dArX331eWdOA74qWt94tCB/gmwCVXjag/RxkZCsgUwYDZEqctSytH20ujS60Wmgj77Da
         H6tg==
X-Gm-Message-State: AOAM533hFSNt8Rkqe8m0Ir2ENYtG4k8i0uA93C6siq/xQReJvRoZ2oHk
        0CNRHtu2sSrDpn8FtKDaNgBAhzV8/xgCVA==
X-Google-Smtp-Source: ABdhPJwe//uT5w4loxD+P4rBi0KJh/lS7dSBtamroE/I+6cJ+VknoekxfBPjg+PyFtXNtmVq80baUQ==
X-Received: by 2002:a05:6808:1709:b0:2f9:30ec:c95b with SMTP id bc9-20020a056808170900b002f930ecc95bmr1887836oib.240.1650040314065;
        Fri, 15 Apr 2022 09:31:54 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id z3-20020a056830290300b005b2316db9c9sm1189608otu.30.2022.04.15.09.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 09:31:53 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest update for Linux 5.18-rc3
Message-ID: <c7ff0298-f0d7-2159-2af0-4c94abc5c52d@linuxfoundation.org>
Date:   Fri, 15 Apr 2022 10:31:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------5F0255C4A9D090820370A2E0"
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------5F0255C4A9D090820370A2E0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest update for Linux 5.18-rc3.

This Kselftest fixes update consists of a mqueue perf test memory leak
bug fix. mq_perf_tests fail to call CPU_FREE to free memory allocated
by CPU_SET.

diff is attached.

thanks,
-- Shuah


----------------------------------------------------------------
The following changes since commit 79ee8aa31d518c1fd5f3b1b1ac39dd1fb4dc7039:

   selftests/harness: Pass variant to teardown (2022-04-04 13:37:48 -0600)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-5.18-rc3

for you to fetch changes up to ce64763c63854b4079f2e036638aa881a1fb3fbc:

   testing/selftests/mqueue: Fix mq_perf_tests to free the allocated cpu set (2022-04-12 13:54:49 -0600)

----------------------------------------------------------------
linux-kselftest-fixes-5.18-rc3

This Kselftest fixes update consists of a mqueue perf test memory leak
bug fix. mq_perf_tests fail to call CPU_FREE to free memory allocated
by CPU_SET.

----------------------------------------------------------------
Athira Rajeev (1):
       testing/selftests/mqueue: Fix mq_perf_tests to free the allocated cpu set

  tools/testing/selftests/mqueue/mq_perf_tests.c | 25 +++++++++++++++++--------
  1 file changed, 17 insertions(+), 8 deletions(-)
----------------------------------------------------------------

--------------5F0255C4A9D090820370A2E0
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-fixes-5.18-rc3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-fixes-5.18-rc3.diff"

diff --git a/tools/testing/selftests/mqueue/mq_perf_tests.c b/tools/testing/selftests/mqueue/mq_perf_tests.c
index b019e0b8221c..84fda3b49073 100644
--- a/tools/testing/selftests/mqueue/mq_perf_tests.c
+++ b/tools/testing/selftests/mqueue/mq_perf_tests.c
@@ -180,6 +180,9 @@ void shutdown(int exit_val, char *err_cause, int line_no)
 	if (in_shutdown++)
 		return;
 
+	/* Free the cpu_set allocated using CPU_ALLOC in main function */
+	CPU_FREE(cpu_set);
+
 	for (i = 0; i < num_cpus_to_pin; i++)
 		if (cpu_threads[i]) {
 			pthread_kill(cpu_threads[i], SIGUSR1);
@@ -551,6 +554,12 @@ int main(int argc, char *argv[])
 		perror("sysconf(_SC_NPROCESSORS_ONLN)");
 		exit(1);
 	}
+
+	if (getuid() != 0)
+		ksft_exit_skip("Not running as root, but almost all tests "
+			"require root in order to modify\nsystem settings.  "
+			"Exiting.\n");
+
 	cpus_online = min(MAX_CPUS, sysconf(_SC_NPROCESSORS_ONLN));
 	cpu_set = CPU_ALLOC(cpus_online);
 	if (cpu_set == NULL) {
@@ -589,7 +598,7 @@ int main(int argc, char *argv[])
 						cpu_set)) {
 					fprintf(stderr, "Any given CPU may "
 						"only be given once.\n");
-					exit(1);
+					goto err_code;
 				} else
 					CPU_SET_S(cpus_to_pin[cpu],
 						  cpu_set_size, cpu_set);
@@ -607,7 +616,7 @@ int main(int argc, char *argv[])
 				queue_path = malloc(strlen(option) + 2);
 				if (!queue_path) {
 					perror("malloc()");
-					exit(1);
+					goto err_code;
 				}
 				queue_path[0] = '/';
 				queue_path[1] = 0;
@@ -622,17 +631,12 @@ int main(int argc, char *argv[])
 		fprintf(stderr, "Must pass at least one CPU to continuous "
 			"mode.\n");
 		poptPrintUsage(popt_context, stderr, 0);
-		exit(1);
+		goto err_code;
 	} else if (!continuous_mode) {
 		num_cpus_to_pin = 1;
 		cpus_to_pin[0] = cpus_online - 1;
 	}
 
-	if (getuid() != 0)
-		ksft_exit_skip("Not running as root, but almost all tests "
-			"require root in order to modify\nsystem settings.  "
-			"Exiting.\n");
-
 	max_msgs = fopen(MAX_MSGS, "r+");
 	max_msgsize = fopen(MAX_MSGSIZE, "r+");
 	if (!max_msgs)
@@ -740,4 +744,9 @@ int main(int argc, char *argv[])
 			sleep(1);
 	}
 	shutdown(0, "", 0);
+
+err_code:
+	CPU_FREE(cpu_set);
+	exit(1);
+
 }

--------------5F0255C4A9D090820370A2E0--
