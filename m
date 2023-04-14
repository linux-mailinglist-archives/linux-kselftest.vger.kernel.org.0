Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4116E2183
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 13:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjDNLBm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 07:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjDNLBa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 07:01:30 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B893A5C1;
        Fri, 14 Apr 2023 04:01:21 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id i8so8963359plt.10;
        Fri, 14 Apr 2023 04:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681470081; x=1684062081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0lXw7gUlhFeEgAAjqPZaP3dINO8+frpf9yOAVpBpus=;
        b=rOw8pFIl2ry+eW2Na6DgMXG0m73f+zmG7Te8I+Huy0OTCeDMpWUtCklYp7c1w/6Khf
         dQItwUAtFIHyzztFwJoWOXmdjvjgmj3KTCynYvVz1r5gRLIhQttoPlBsjRu4b6PZI8+g
         EE+bZPSrorkSQG/XWaKBYS1ehN3sspnHBxrn24ivUeRtkmdLXqFnUJ9FLrxdfaDjl02+
         Jn6heWCbyjBODnOEfco+VurbAUx4iWTivJrKsB9J5rNLNG37bSniL64UQtqw52HjbbvL
         3IxZpBdhVJCk86yXyuOTCEuROT83aDFSm4ErUgxEAtLBiwrnMZCj187NjCZr1AtuWt0A
         TIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681470081; x=1684062081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0lXw7gUlhFeEgAAjqPZaP3dINO8+frpf9yOAVpBpus=;
        b=lIjXd5lD0gEVksMP/mOgKbL/Ox+cnA9J8L+6f7UPqUy8A2s6unlPU8vjzJ6JJALQPH
         u0TLPCjsjQsQJzyKjWgDxpMRHLiCbfqe3VDsqwRFiLe4J+7rdonSzFxB+gINM3zXyFpK
         jd8vQHZD3esZ9I4zyintL9sZw74r6ycLmyY97EcElenKt65kegq63ad3TvVR+LacL9yW
         tA3Z7LniYP99knbFDChuF+Nu+nW1/CGFC7vtwu+a7eJc9g/0F9+0t+K5tNegMzTJpqyf
         WfsyO0JzRCFIQaoFjjQ+7uIOXEftdeOnsnolW1lR1mkFZTOUnASuqUbRhYAZ9iz2wYBs
         YcKw==
X-Gm-Message-State: AAQBX9dRIoV7Z8cH3t6hvRuJAKPWSHwcLXrx6T2aaHxCHJz25jCW8qBh
        rWO0ECGFo8/INo9Ny2SNasU=
X-Google-Smtp-Source: AKy350Z1Qj9SoLwP/z02WB2po6VGyCYszb3ZFkcQpt8EpZnYmP7Q4NqQDug+SKB2hTns/mou+EyjWw==
X-Received: by 2002:a17:90a:9113:b0:233:76bd:9faa with SMTP id k19-20020a17090a911300b0023376bd9faamr5158057pjo.47.1681470081182;
        Fri, 14 Apr 2023 04:01:21 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id r4-20020a170902ea4400b00194caf3e975sm2835821plg.208.2023.04.14.04.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 04:01:20 -0700 (PDT)
From:   Jinrong Liang <ljr.kernel@gmail.com>
X-Google-Original-From: Jinrong Liang <cloudliang@tencent.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Like Xu <like.xu.linux@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] KVM: x86/pmu: Add documentation for fixed ctr on PMU filter
Date:   Fri, 14 Apr 2023 19:00:53 +0800
Message-Id: <20230414110056.19665-5-cloudliang@tencent.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230414110056.19665-1-cloudliang@tencent.com>
References: <20230414110056.19665-1-cloudliang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jinrong Liang <cloudliang@tencent.com>

Update the documentation for the KVM_SET_PMU_EVENT_FILTER ioctl
to include a detailed description of how fixed performance events
are handled in the pmu filter. The action and fixed_counter_bitmap
members of the pmu filter to determine whether fixed performance
events can be programmed by the guest. This information is helpful
for correctly configuring the fixed_counter_bitmap and action fields
to filter fixed performance events.

Suggested-by: Like Xu <likexu@tencent.com>
Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
---
 Documentation/virt/kvm/api.rst | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index a69e91088d76..036f5b1a39af 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -5122,6 +5122,27 @@ Valid values for 'action'::
   #define KVM_PMU_EVENT_ALLOW 0
   #define KVM_PMU_EVENT_DENY 1
 
+Via this API, KVM userspace can also control the behavior of the VM's fixed
+counters (if any) by configuring the "action" and "fixed_counter_bitmap" fields.
+
+Specifically, KVM follows the following pseudo-code when determining whether to
+allow the guest FixCtr[i] to count its pre-defined fixed event:
+
+  FixCtr[i]_is_allowed = (action == ALLOW) && (bitmap & BIT(i)) ||
+    (action == DENY) && !(bitmap & BIT(i));
+  FixCtr[i]_is_denied = !FixCtr[i]_is_allowed;
+
+Note once this API interface is called, the default zero value of the field
+"fixed_counter_bitmap" will implicitly affect all fixed counters, even if it's
+expected to be used only to control the events on generic counters.
+
+In addition, pre-defined performance events on the fixed counters already have
+event_select and unit_mask values defined, which means userspace can also
+control fixed counters by configuring "action"+ "events" fields.
+
+When there is a contradiction between these two polices, the fixed performance
+counter will only follow the rule of the pseudo-code above.
+
 4.121 KVM_PPC_SVM_OFF
 ---------------------
 
-- 
2.31.1

