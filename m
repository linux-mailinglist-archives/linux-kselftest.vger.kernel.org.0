Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99964752BF3
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 23:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjGMVRt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 17:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjGMVRs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 17:17:48 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CFA2D58
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 14:17:45 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbc5d5746cso11153065e9.2
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 14:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689283064; x=1691875064;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nYnx/VDo8lOzEkd9RFmD+hOFqRYo9o9+grAoqaC0M7M=;
        b=rLPmayOWzc6g9V910/q65nAuOjv00BAzsVc6mSA3lR0UWmv1lKPpxAH2Aab7J0z+Aq
         DoZ3QmD9/bqByDzA8UvfhuoDOg0LF09+jj13aeqiKONl0qANDzxgLpwCoiQs5MwMCL/8
         cdIXQ4Ed82QlAbNgMzo/kWfthEGfwBwUYbW3UnKd3BnRiPMNZu5fAAcM4f4NX117JN6Y
         LNXh3yiJJECnC+45b1CCU1L9/4UEAel3HQ0rXqRjr23xxQd6nh02TMvdV1OkGGhISXog
         JTJDvLxvlYAj+3bPRs1NH6MCSlJ9Srfe8p69z6lDtBxKExRFXlDJC6gaYtMj7ktSQJxh
         Mkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689283064; x=1691875064;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nYnx/VDo8lOzEkd9RFmD+hOFqRYo9o9+grAoqaC0M7M=;
        b=R6bZWCLYKBMD6YsCKqD963e6ITUTzRof04NgN1pbKtfqbwjpoA+6vvBolLKYFFI+Hf
         tADpK32uSzrdAp1wWhuNeZbkPM/kaoYOoysiI0M6to5TMeEeI2lEY8B6s2rrY3LeGCZH
         RnwVXmffnZ61v9xiKpWypTPqwyT9sLqc3oTEz/Yb8b4dJ1RfI8tuNgb1loQPVGPl2WBE
         6py6r0RcqhVgRpowa3nIhR+yWkTnMjxlP3SzYfwj6bMnZB9Z7NR4U+vo20tQDLyXTCx2
         PNXW5gsRpiLnQieL/MsjX5gOGFYqNum7coe0jLDNGopI64URNP3nqkj2sn1kgpp2cu/o
         xWsg==
X-Gm-Message-State: ABy/qLYX3wQX3fQzuNbgDpCOKEKawB6WcdQfAdtuAwtQKy/3OyJXg9ns
        kbjpErs0JxB6zSDGm+p7u0jhKQ==
X-Google-Smtp-Source: APBJJlHeiVWzk4vdAI2ZN1b5nV0LGC0UwmaZEvJCTS/gMBXCGRbwK8bTiEpYGGZ853jMECajY/qKhQ==
X-Received: by 2002:a7b:cc15:0:b0:3fa:9561:3016 with SMTP id f21-20020a7bcc15000000b003fa95613016mr2331758wmh.30.1689283063981;
        Thu, 13 Jul 2023 14:17:43 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m20-20020a7bcb94000000b003fbfea1afffsm8734136wmi.27.2023.07.13.14.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 14:17:43 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Thu, 13 Jul 2023 23:16:44 +0200
Subject: [PATCH net 1/3] selftests: tc: set timeout to 15 minutes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230713-tc-selftests-lkft-v1-1-1eb4fd3a96e7@tessares.net>
References: <20230713-tc-selftests-lkft-v1-0-1eb4fd3a96e7@tessares.net>
In-Reply-To: <20230713-tc-selftests-lkft-v1-0-1eb4fd3a96e7@tessares.net>
To:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>, Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Paul Blakey <paulb@mellanox.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        mptcp@lists.linux.dev
Cc:     Pedro Tammela <pctammela@mojatatu.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1433;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=aRf2NUlWpQteg42pbw7DyQllMQTrdJ1OPx8sg9BiW2M=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBksGn1E1CyU82GEtiTz9Kn3atBqLCeF8gHpWsl/
 QfpMKoJ40OJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZLBp9QAKCRD2t4JPQmmg
 c/WRD/9f1JjmbA0ekElLhLbwzV9QM7ML9tP6qiaEiGIRxESQJvVnvwoBM74lJGLNLwoxh1RTPM7
 BazpQpnWcvtP1g7+T5PLIajJ9xNxBasm+wLsssacLKdxMc4KkKZ9N4j4gg71aaWrNaM22Gsu9DO
 x5K148C72MuH7vzcg1qKfmSUl3nLkzB+FYCIoHLl7Rm40IWR3ccHOdiw1lkGoABBHCYzjMUZkSR
 5HjtOkWwjuWMurPnW3JNrSYBtDszpC33kjxz9PJH6+mWYxG9f9YRMOX5+umyyTnRUeAQ6/78BBB
 X3Ux4Aa3T4g1AIlUFJls0Drv8mX4fkf0qfi+brN4XGI3KSq6MLVqdl6fCSnRbN5Ab4NhWw0ZqhJ
 SYcAiecUnZWjpz1GNOA9utPRGzEy+z4mXXKOjjLpOxVRahOMwjXzdYg03VaJ2EIH5nMTfwzL+Fv
 j4IPDaulMsxNThGDll6SSx9jjYM3IZYAk4Vv6RH6te9TiXmv39crSUJaCraIAYFS3t0ZDnXjIgQ
 OljCjFLAtHfBn6bj4Yu5MWLHiM0uXVHvUpljYAj/Rk7rGymqVpXmjUr4CbPTM1Dsor2JwGwzLR0
 KghInxltcEu0T+ui9/rzcjCAr5SCzVGSzhBamCR3CRttgCxmGdcmEHtTOUuR6d0jOFK28wnNkRE
 zgAHC1Q6JIX0V7g==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When looking for something else in LKFT reports [1], I noticed that the
TC selftest ended with a timeout error:

  not ok 1 selftests: tc-testing: tdc.sh # TIMEOUT 45 seconds

The timeout had been introduced 3 years ago, see the Fixes commit below.

This timeout is only in place when executing the selftests via the
kselftests runner scripts. I guess this is not what most TC devs are
using and nobody noticed the issue before.

The new timeout is set to 15 minutes as suggested by Pedro [2]. It looks
like it is plenty more time than what it takes in "normal" conditions.

Fixes: 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second timeout per test")
Cc: stable@vger.kernel.org
Link: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230711/testrun/18267241/suite/kselftest-tc-testing/test/tc-testing_tdc_sh/log [1]
Link: https://lore.kernel.org/netdev/0e061d4a-9a23-9f58-3b35-d8919de332d7@tessares.net/T/ [2]
Suggested-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/tc-testing/settings | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/tc-testing/settings b/tools/testing/selftests/tc-testing/settings
new file mode 100644
index 000000000000..e2206265f67c
--- /dev/null
+++ b/tools/testing/selftests/tc-testing/settings
@@ -0,0 +1 @@
+timeout=900

-- 
2.40.1

