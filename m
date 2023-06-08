Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CCD727ED9
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jun 2023 13:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbjFHLei (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 07:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbjFHLeg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 07:34:36 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D97583;
        Thu,  8 Jun 2023 04:34:35 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id 98e67ed59e1d1-25676b4fb78so268452a91.2;
        Thu, 08 Jun 2023 04:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686224074; x=1688816074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hYkpzdCbWh+eQgWxe3n3N+6lA3Jl6cnlNf1r2AHxRsk=;
        b=O6cZyBgz4zna9mbthyeOV5zlT04YyoA9Rs0mMniENpyOXs4DoHR1bHk3x6BaEJy9no
         SDOM+aHTrompYSc3SZYHd0febNeP9F+SQDulgR/l3OsZGTN4oOerkGDgw7igIu57xZzB
         8JMrjfpYi5nBSaZBGzvOoeocfqaMAzVJx3W827yHym7IeU+ACIf2cPOXChFUs6VsC9Ut
         PEvJ1aii7MVdCTWF5gK0GszBdFsRpTyrnSEV/vubzdhLXeWgmwtV+iOWIPPkGw6UC8m/
         4hEqsjOiJlWmiHhLlrf+WJDlBMDotC0hEhsthSNDUJ6DIT8FtEr7X9xfarTz9wG2cXXp
         b5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686224074; x=1688816074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hYkpzdCbWh+eQgWxe3n3N+6lA3Jl6cnlNf1r2AHxRsk=;
        b=jUKj2hVT+uKEiF1LXNQeHE1tO0nBs9o6G9NSqFdgEDRO1bmykWdq4BSk4N870zPwGy
         s9uWC7dcf+Eq7nFOsmIUBqzdq/HyJIJANpgViV/3ZHPmXYRBTjaO644m9rlp0omo6CFQ
         +6HueZuvoxv1kVwCEwYOe+lQTa3r823ZPJz8BY5Xvqi/yxTiElgIkYWZlKLMfNxiLgk5
         /PCxy+a2EcQBPjgTMDARRIeVo4MQCReUcocc8gj8OcYlMxYa+rkjJTtz6lJoTOQfYJxx
         u4wWcHCA4RLHhUIkBB7voIujX8ibUNOC3c31OELh030EXOQeiO0BCxYvyetVvphdx3Uf
         l0Ow==
X-Gm-Message-State: AC+VfDw2VQdC+k36oteyhBMkBW+lllMegvkBmpBmiGno9ojJGJrHoMHl
        uOfytFiFgqqd645N/XmIU8s=
X-Google-Smtp-Source: ACHHUZ7uJQMwUDnxXgeqAP4WRd9/9hkWnSt6fNJvgQcKuiM+cUC+VXn7ME4w9h8qPqU1oQHY6RWahQ==
X-Received: by 2002:a17:90a:a08e:b0:255:a904:7a7b with SMTP id r14-20020a17090aa08e00b00255a9047a7bmr4127968pjp.26.1686224074441;
        Thu, 08 Jun 2023 04:34:34 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id qa2-20020a17090b4fc200b002310ed024adsm2900456pjb.12.2023.06.08.04.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 04:34:33 -0700 (PDT)
From:   Jinrong Liang <ljr.kernel@gmail.com>
X-Google-Original-From: Jinrong Liang <cloudliang@tencent.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] KVM: selftests: Add tests for PEBS and MSR_IA32_DS_AREA
Date:   Thu,  8 Jun 2023 19:34:18 +0800
Message-Id: <20230608113420.14695-1-cloudliang@tencent.com>
X-Mailer: git-send-email 2.40.1
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

Hi,

This patch series introduces two tests to further enhance and
verify the functionality of the KVM subsystem. These tests focus
on MSR_IA32_DS_AREA and MSR_IA32_PERF_CAPABILITIES.

The first patch adds tests to verify the correct behavior when
trying to set MSR_IA32_DS_AREA with a non-classical address. It
checks that KVM is correctly faulting these non-classical addresses,
ensuring the accuracy and stability of the KVM subsystem.

The second patch includes a comprehensive PEBS test that checks all
possible combinations of PEBS-related bits in MSR_IA32_PERF_CAPABILITIES.
This helps to ensure the accuracy of PEBS functionality.

Feedback and suggestions are welcomed and appreciated.

Sincerely,
Jinrong Liang

Jinrong Liang (2):
  KVM: selftests: Test consistency of setting MSR_IA32_DS_AREA
  KVM: selftests: Add PEBS test for MSR_IA32_PERF_CAPABILITIES

 .../selftests/kvm/x86_64/vmx_pmu_caps_test.c  | 171 ++++++++++++++++++
 1 file changed, 171 insertions(+)


base-commit: 31b4fc3bc64aadd660c5bfa5178c86a7ba61e0f7
-- 
2.31.1

