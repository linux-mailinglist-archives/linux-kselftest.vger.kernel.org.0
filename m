Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBD74B445F
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Feb 2022 09:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242073AbiBNIhq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Feb 2022 03:37:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiBNIhp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Feb 2022 03:37:45 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61ADDDF61
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Feb 2022 00:37:38 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 494D53F1D1
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Feb 2022 08:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644827857;
        bh=UeS9MvqP+4XVHpHzzOg6ayahqyEHPitjbY58dkpAMu0=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=NSjk2lG0p10BZUmenmlcPDzGQ8q5zoAeU6qrz5jfY3klFki7z2tdZJqA5oMyBAcU+
         txrN5ghpRoS6QzFdiZGhk5cgmMc4i1hgGHLAoaAfVu11AT52wajDEaMWk+1gHqMHoy
         LgRFJS0p9QWhvlvR+fN7C+rl0VF2c9l7OzA53QyhnaJpxjaR1cs9jRagA2r4KwEw8b
         dhY5lYP3y1i/ki/ERc5VPpes9kW8laje3Br/HjVq20nZyVIRGPAWXt76IMUAfCG2yZ
         c3xCBcfvRTmytWDs7UREgXmWfpHXfDm/q6In9BEEr84KHauJFojpfyr4+TI2pUX7fa
         3qHdJG990LpTA==
Received: by mail-ed1-f70.google.com with SMTP id r11-20020a508d8b000000b00410a4fa4768so2531427edh.9
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Feb 2022 00:37:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UeS9MvqP+4XVHpHzzOg6ayahqyEHPitjbY58dkpAMu0=;
        b=2YL8Uev5B7vHaRxMm02TMWAsCQJEj/COzEY7Vcvg5lKAAfI7pqjLczoNkRp6fJu2W2
         Zudryho78D8oHifFxB9Hp0ej8tm0G0jI4iTQaAFRn7CpNY07SNGZ3ZmuztKu2YgJcCD+
         4x+Jugm5tQXPpkMvwpBQfNCwjTDFr4JM36axER7/1ejHRExoMC6ccWYpynGCLsVmBU8m
         PndddnzaPHM8YN7lXZ9CzG8UdhRdv7v5JlPqFFviSFegPE7XLOleUTmvxU1sRWbiKlTr
         NtnZoCliwWa/Ol2j1ldu1KHGu8MatgfCne1M8DqmPeKhs/2VNAH3V6sgiMRE4E0gzdAy
         rNAA==
X-Gm-Message-State: AOAM531A892on/Ej8CaFHWz6RYmJXDhshgZjAn4paw9KGNrcTFL2Mt3c
        1luys8C70xtzEfK4obOBHdnaA/KCLgv8wSR9y4MjI0Xgn9EAd3G9PYuyxIiaPQVixCIKFGD1a/l
        GHtfEfxHtwFMgfTqwoWZ9zeTm25pSBuOAtUT4OjVnKTXiTQ==
X-Received: by 2002:a05:6402:4313:: with SMTP id m19mr14313657edc.320.1644827857010;
        Mon, 14 Feb 2022 00:37:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx9hR1XFJB05UFJug9MAC7FCA5IP+wUp4mjQ048N34QgP+jdO/yTjWnA6oWYkRX7X+tyG4Qzg==
X-Received: by 2002:a05:6402:4313:: with SMTP id m19mr14313649edc.320.1644827856877;
        Mon, 14 Feb 2022 00:37:36 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id er9sm10310087edb.77.2022.02.14.00.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 00:37:36 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, joseph.salisbury@canonical.com
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v3] selftests/ftrace: Do not trace do_softirq because of PREEMPT_RT
Date:   Mon, 14 Feb 2022 09:36:57 +0100
Message-Id: <20220214083657.165921-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The PREEMPT_RT patchset does not use do_softirq() function thus trying
to filter for do_softirq fails for such kernel:

  echo do_softirq
  ftracetest: 81: echo: echo: I/O error

Choose some other visible function for the test.  The function does not
have to be actually executed during the test, because it is only testing
filter API interface.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

---

Changes since v2:
1. Rephrase commit msg, after comments from Sebastian.
2. Add review tag.

Changes since v1:
1. Use scheduler_tick.
2. Add review tag.

Notes:
I understand that the failure does not exist on mainline kernel (only
with PREEMPT_RT patchset) but the change does not harm it.

If it is not suitable alone, please consider it for RT patchset.
---
 .../selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
index e96e279e0533..25432b8cd5bd 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
@@ -19,7 +19,7 @@ fail() { # mesg
 
 FILTER=set_ftrace_filter
 FUNC1="schedule"
-FUNC2="do_softirq"
+FUNC2="scheduler_tick"
 
 ALL_FUNCS="#### all functions enabled ####"
 
-- 
2.32.0

