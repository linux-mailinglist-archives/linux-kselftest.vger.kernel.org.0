Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B484AF67D
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Feb 2022 17:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236777AbiBIQZN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Feb 2022 11:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236768AbiBIQZM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Feb 2022 11:25:12 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C615C0613C9
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Feb 2022 08:25:15 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C4F813F1E9
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Feb 2022 16:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644423911;
        bh=/xekYk/q8PDd5X+mZnZ/+eb+Bf0iUFVR8K4RtVmP8o4=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=U+gjmSlolYuUisQo0EDYIhK5RHaPwDdDvXikHufLFgBTfai88FvWmsUUsnmhJkFXu
         R1eAHAPiBgJByKS9ryg1Awn2zOSnG+ECzbMxHsjEbDAvJlm+CN5MDCa0+xQyFzlcnK
         uemSpDXlqnZJGjXjw//W36FVYRMPGixvZM/TSPmvlnVpw6dfdyU1X6SoE7Zs4H2wfz
         QtPpJgZTmot60G5y3+dbxJFnmRkLEIHcqv567Vg1P8CVsx+m/almcfdvbZiEnedGiP
         /sMcrk9f2Rxi/jHF2XaEnCp5+9RvlC2ht1p1/BSYnPt3GbXXK6ce1c+OiInk3wEqVy
         KXIJ5qCGMXjUQ==
Received: by mail-ed1-f72.google.com with SMTP id cr7-20020a056402222700b0040f59dae606so1652710edb.11
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Feb 2022 08:25:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/xekYk/q8PDd5X+mZnZ/+eb+Bf0iUFVR8K4RtVmP8o4=;
        b=op8jbkP0X1SYUkDnVM2zBGyUDbwaMDmVMxaSyI48TwKeazRUI7NEqujs8C8Zv0JZ/K
         NX/wV9s1O5dDqkUk+jAyUGQ9ZIrGrqV3+xgvYVhI5qdyjDXaXDB3fpK4oWtrfmu0c0w7
         YIcBucVGqtF1lNony8TESCPpEshteh0HBgYvfAp9icf1fkz3Abdkgiuc/pEW53gkioS3
         cOzTHwoEjwQQBCAUzbhSxEBq8ueB6SMB8uAf5NZkU9eGKtXLUSz0FLSDrenyKoOR2wlU
         A3wPvxXuH6mftKUtzQEXygvY06mE4Z5fOys/yAueAty1pBFbA7ynGIFi+vqcbZcdPJCP
         kuiA==
X-Gm-Message-State: AOAM530Yfhq3D3zN6Z+B9/6FZ5PhChQwTrzzJ4vcY8TXNMGp3zwJL544
        B7fkroCKGD6UEvRAZZt2rvOdhS0aGAp7aXIvGBkxrMwokusLav1gDBShBLS3EzfFsCrWY4ZG/Or
        r1FPuQNeqzOiIcpLCT+MW5GM0+g0f+s+tyOSUK0Pw5rY8EA==
X-Received: by 2002:a17:907:a409:: with SMTP id sg9mr2642419ejc.219.1644423910884;
        Wed, 09 Feb 2022 08:25:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzKvtjCZePVTEi6+XanNHWx67xsb5RlaQqVAD+8Rt87SKNwj0aCwZWrYYo6ZHiUBiw21MJl1A==
X-Received: by 2002:a17:907:a409:: with SMTP id sg9mr2642412ejc.219.1644423910718;
        Wed, 09 Feb 2022 08:25:10 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id d23sm6687575edv.79.2022.02.09.08.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 08:25:10 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, joseph.salisbury@canonical.com
Subject: [PATCH] selftests/ftrace: Do not trace do_softirq because of PREEMPT_RT
Date:   Wed,  9 Feb 2022 17:24:30 +0100
Message-Id: <20220209162430.286578-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Choose some other externally visible function for the test.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

I understand that the failure does not exist on mainline kernel (only
with PREEMPT_RT patchset) but the change does not harm it.

If it is not suitable alone, please consider it for RT patchset.
---
 .../selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
index e96e279e0533..1d0c7601865f 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
@@ -19,7 +19,7 @@ fail() { # mesg
 
 FILTER=set_ftrace_filter
 FUNC1="schedule"
-FUNC2="do_softirq"
+FUNC2="_printk"
 
 ALL_FUNCS="#### all functions enabled ####"
 
-- 
2.32.0

