Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F794B0877
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 09:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237415AbiBJIeq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 03:34:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbiBJIen (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 03:34:43 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9D2220
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 00:34:45 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8DEF63F33A
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 08:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644482084;
        bh=pGebfukMA0/cVNt1ZjmZH/7cNrKPzwQS8ExlqEeW/aA=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=lwnSlTzfmpcEx9Wh36NnaX5DTSjRKDDTSBLIpAHIIGq4aCPoLHqmzXK6fq9x2w87B
         ceH1NQTB/RzDnb5QxFV/xbjqiS9gsYRLZyv0OaPDd3x5+n7xqatCyAn2GmSwJiTDnU
         5sIaexIyYDdk44tcpi5fzaJWSRb98SYa8fTpz8V1KfpQDSogkxaNJ11jH+7nc3MKmC
         18ySKAXkD2VxDsxV+arS2Ygom7EljaUB9kNtpi/lFfhUlbb++urf1NCcRCEnuZBf2v
         nPSiddECJuJSGzPZP9lglkqY33oc3hXYuEtnRDNb/58/lMK0ugOYEMBQ/pMy/Ox4kY
         cQBR2KfUZJrPg==
Received: by mail-ed1-f69.google.com with SMTP id ed6-20020a056402294600b004090fd8a936so2899278edb.23
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 00:34:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pGebfukMA0/cVNt1ZjmZH/7cNrKPzwQS8ExlqEeW/aA=;
        b=IJF4bco0z+7udNA72LX0nWSmzH3F5hdOeFss6CpwrWPlVaTiO0Q7/dNFgi3EpTMNZ5
         XtG3mbMQXqcTZh+iP68ak639PxT+LB8+vqpyScXDWUc/JGj7iInNZulbV8rkDu7WHZYg
         qC7Z1wAahwgqEl+EI7cIgITviFz7eS3619BuHpU1kw4HU3Jl5YSbMiEdT634oBBaD1s/
         N9HZCQWXsSELoyiRtzKWYG/iU3M8DzwyDPR7b8LjLKDDnw87FxpWFcOE9yE9LqWFNzaD
         fmu/xuSKeIkjh06HmkOux2230zoh81NPt2TbhzkWBAN/1ZV8U+OVvbs4uL6BxZ1PedcD
         XrIQ==
X-Gm-Message-State: AOAM532HIuSQWPHLIRZou8bBBlpXFw7c/UOYEvjnRF5No3V2eMArDrAH
        bXX9qUq1sMyWLlgW//2jVmHvLlz5PNo6yk+hy+CB8ejxK89OIXHayBx/4LdR9TmaWxW9o25g+Oi
        TbkoEr2o/M3IzUVUXOqfZTIiiU0NHvvbP7RxHmGslD3X3mQ==
X-Received: by 2002:a17:906:648a:: with SMTP id e10mr5362017ejm.608.1644482083896;
        Thu, 10 Feb 2022 00:34:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxi63reSP6zKskv4B7VSWKJyO4DkjBtRkrM6w8hTZY1HnS05jKb54fS63VtY8oyNWSo8tLgdA==
X-Received: by 2002:a17:906:648a:: with SMTP id e10mr5362002ejm.608.1644482083651;
        Thu, 10 Feb 2022 00:34:43 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id r22sm9289438edt.51.2022.02.10.00.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 00:34:42 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, joseph.salisbury@canonical.com
Cc:     Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v2] selftests/ftrace: Do not trace do_softirq because of PREEMPT_RT
Date:   Thu, 10 Feb 2022 09:33:56 +0100
Message-Id: <20220210083356.11212-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The PREEMPT_RT patchset does not use soft IRQs thus trying to filter for
do_softirq fails for such kernel:

  echo do_softirq
  ftracetest: 81: echo: echo: I/O error

Choose some other visible function for the test.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

---

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

