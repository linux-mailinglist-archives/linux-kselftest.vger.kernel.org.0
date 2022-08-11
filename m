Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2FD58FB26
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Aug 2022 13:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbiHKLQr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Aug 2022 07:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbiHKLQq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Aug 2022 07:16:46 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF3E72853
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Aug 2022 04:16:41 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id w11-20020a17090a380b00b001f73f75a1feso5042675pjb.2
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Aug 2022 04:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc;
        bh=lWAtsvqR20SvZs/lAQ3/5FZJ7xShg8lDyfgXMruPz7M=;
        b=pE3Q6N9rkk31lEyBtdVecOqxNRckQJpgJwycWRFPMmEX8L0GM8+OU3GtqHW76KoQeB
         CuHUwv54NuxTo8ouJx96L+igcoZCoT7SQKwvPvxBZci8NZonTJDSaa9zKDqa1Phvb839
         oydjUHbJEhDuHK9Y1fpFtIR0B32Src6TLiBXjMnv2zmBpZMhNSw58UyubNUi1knkrES5
         0naGnTVTvSfYOX5uy0EZUUgo62yn5gJ3vqecgORZT/44JjD0JUU122oskpmilqFMkoRt
         dd5Ql8fFiBJGaevFHlJp7iEm0IUeXLupLOoScRfeZatDdP5pfn2ABJhg23eUnwFO2nlC
         jQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=lWAtsvqR20SvZs/lAQ3/5FZJ7xShg8lDyfgXMruPz7M=;
        b=bo7pauyOixWzil6g/bTUdKCyfPZRZpK6zJlI2nOq7vqIkFIo6B/aSrMZVHnkekn/Lf
         Uk7MINIKdkNbiikaczn/FBFTOR+nsVMFfYXnWj18f1B1seOmAi3pu6GYMMpgPQj650Kb
         +vl1qSWy6ZXmYohUadbIk4x3NkjwhtkZpwMdOiaAjKSOfbsj4LOkeVxzAlv0hQoVqMpv
         EWjstocgWLAXOtUJR6lqrc38lFs7Nud7yg0L6Gk4fHGNG1HS0J0KrjxyxcmIEBXPuicJ
         thNC8XYZ5k2EcYheEBezfQkIRlJ++08TyKHWj0FvsKCCJqmgK3a4cO6vsw73geAfHXtG
         kvFg==
X-Gm-Message-State: ACgBeo2pu/ug+HfusWIkSy5AJ5C0lEjddsH3aaa0WYqLNDldwluEbl+v
        yXQjvTgX5hCT6kBeuB1Txd0=
X-Google-Smtp-Source: AA6agR7NLFVLg+v8uMYgYQZ1x/DpsnLfpoqACEVu/m+htyvZRl69d2mAd03T5jceHau0LCJL6pAeWg==
X-Received: by 2002:a17:902:a60c:b0:171:407d:16f8 with SMTP id u12-20020a170902a60c00b00171407d16f8mr4359004plq.58.1660216601346;
        Thu, 11 Aug 2022 04:16:41 -0700 (PDT)
Received: from autolfshost ([2409:4041:e93:d6ef:7c5:6a30:ff53:3228])
        by smtp.gmail.com with ESMTPSA id m10-20020a65564a000000b0041a6638b357sm11430237pgs.72.2022.08.11.04.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 04:16:40 -0700 (PDT)
Date:   Thu, 11 Aug 2022 16:46:20 +0530
From:   Anup K Parikh <parikhanupk.foss@gmail.com>
To:     skhan@linuxfoundation.org
Cc:     linux-kselftest@vger.kernel.org
Subject: [PATCH] Solve Kselftest patch task
Message-ID: <YvTlBGB6OSvwQ+AN@autolfshost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Most messages were perfect and so this is a minor pretty print change

Signed-off-by: Anup K Parikh <parikhanupk.foss@gmail.com>
---
 tools/testing/selftests/cpufreq/cpu.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cpufreq/cpu.sh b/tools/testing/selftests/cpufreq/cpu.sh
index 39fdcdfb8..fac318e8f 100755
--- a/tools/testing/selftests/cpufreq/cpu.sh
+++ b/tools/testing/selftests/cpufreq/cpu.sh
@@ -49,11 +49,22 @@ reboot_cpu()
 	online_cpu $1
 }
 
+#$1: number
+prettyprint_number_times()
+{
+	if [ "x$1" = "x1" ]; then
+		echo "once"
+	else
+		echo "$1 times"
+	fi
+}
+
 # Reboot CPUs
 # param: number of times we want to run the loop
 reboot_cpus()
 {
-	printf "** Test: Running ${FUNCNAME[0]} for $1 loops **\n\n"
+	local ptimes=`prettyprint_number_times $1`
+	printf "** Test: Running ${FUNCNAME[0]} $ptimes **\n\n"
 
 	for i in `seq 1 $1`; do
 		for_each_non_boot_cpu offline_cpu
-- 
2.35.1

