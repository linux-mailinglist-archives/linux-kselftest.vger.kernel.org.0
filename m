Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8F16E90DC
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 12:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbjDTKst (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Apr 2023 06:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234755AbjDTKsM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Apr 2023 06:48:12 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08714173F;
        Thu, 20 Apr 2023 03:46:47 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d9443c01a7336-1a66e7a52d3so7924165ad.0;
        Thu, 20 Apr 2023 03:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681987606; x=1684579606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucz1xYqm1NnRhQqZf/NHWVK0FuNxfx3TblIgxh14nj0=;
        b=YU1yuqWA1beCHR+/WoSpYyEhAgWVxMb3wPQqqrz+yDablssc0FlgD8jlB9iRqhjjSz
         eiUAcJfII0DeQtv5RMY1o2HjRVYg+AS+biIXN9g7l0vXlMAbaFYHHU9WFo/UEe1EK8LR
         0b+Uor6WXmLF7wbhAo3GDayQxBkFxI0FzyBsaf+IPD4HficYFf2Og0q9kxUVIgDd/HTp
         AyCHu68qt8kAgGqjHpwfmZoFr70/d4sPcQXMhqNzSHucLAHmaZRo9ISvMnbRwXa9Tixy
         7Xa1HUDDk1u6MiaU33c15KppS/1rVcx+zzRInDlKpgz5lsIIlGNvXObVhhTcTztcQjPa
         DW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681987606; x=1684579606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ucz1xYqm1NnRhQqZf/NHWVK0FuNxfx3TblIgxh14nj0=;
        b=JbWpSugKTu5kBiO09vtJmmUdQDK4mJH2Xx2vFvBqeJm+80P+0YRleVtj0ougJYti10
         R6vF+6z+qG1VMxwQXpwMqu4piaZWnjZCA5FPhkAv8V2zw4rdU1nK+q6BMkLwM8amoEUy
         ur7wdeh1VwHNM4dnToCwjNL5jVu7tArbjucuP9ICG7ILNwwiBkaleA+N/BiDaf3L9upP
         T3EXnXZU2HjZwjALIOOjE7CcoNJa62qjSg5loAvPMTl06OBSVchbbNapGkgvsvWYQiAA
         7z9B2w1ke4p8JlsORvyFLHmXqrLA3qzgTuNKongeAtT9oyUXeQcyFhKE01uwY+L2XA7a
         BfvA==
X-Gm-Message-State: AAQBX9cVPyh43LO4BjeSxW2iVyYFvwDZMdh4PalwCj8GfwhF0BnwFAXW
        9gugyW5RxSIFYkllS3YJBc4=
X-Google-Smtp-Source: AKy350aGYUTqpyJWeNKlNoKbyJpwRjY+6rT6xYPnyPu6gtZLQhghx1XM05BQt6Qkgsmg1qiD2li/Qg==
X-Received: by 2002:a17:903:246:b0:19f:3b86:4715 with SMTP id j6-20020a170903024600b0019f3b864715mr1206887plh.8.1681987606197;
        Thu, 20 Apr 2023 03:46:46 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id ju18-20020a170903429200b001a526805b86sm923735plb.191.2023.04.20.03.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 03:46:45 -0700 (PDT)
From:   Jinrong Liang <ljr.kernel@gmail.com>
X-Google-Original-From: Jinrong Liang <ljrcore@126.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Like Xu <like.xu.linux@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] KVM: x86/pmu: Add documentation for fixed ctr on PMU filter
Date:   Thu, 20 Apr 2023 18:46:19 +0800
Message-Id: <20230420104622.12504-5-ljrcore@126.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420104622.12504-1-ljrcore@126.com>
References: <20230420104622.12504-1-ljrcore@126.com>
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

From: Jinrong Liang <cloudliang@tencent.com>

Update the documentation for the KVM_SET_PMU_EVENT_FILTER ioctl
to include a detailed description of how fixed performance events
are handled in the pmu filter. The action and fixed_counter_bitmap
members of the pmu filter to determine whether fixed performance
events can be programmed by the guest. This information is helpful
for correctly configuring the fixed_counter_bitmap and action fields
to filter fixed performance events.

Suggested-by: Like Xu <likexu@tencent.com>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202304150850.rx4UDDsB-lkp@intel.com
Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
---
 Documentation/virt/kvm/api.rst | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index a69e91088d76..b5836767e0e7 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -5122,6 +5122,27 @@ Valid values for 'action'::
   #define KVM_PMU_EVENT_ALLOW 0
   #define KVM_PMU_EVENT_DENY 1
 
+Via this API, KVM userspace can also control the behavior of the VM's fixed
+counters (if any) by configuring the "action" and "fixed_counter_bitmap" fields.
+
+Specifically, KVM follows the following pseudo-code when determining whether to
+allow the guest FixCtr[i] to count its pre-defined fixed event::
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

