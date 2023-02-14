Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543EA696D2C
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Feb 2023 19:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjBNSqV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Feb 2023 13:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjBNSqU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Feb 2023 13:46:20 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCD623D9D
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Feb 2023 10:46:19 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id z8-20020a170902834800b001990ad8de5bso9590411pln.10
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Feb 2023 10:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tsn4VsTJ4gltk0gVzC2/ImEH2n2wT6RUydHqF84UaYc=;
        b=gLsTJpXJNRR+TuApw3gpdyFV2WBSpjJlPEhgdqd1yPJ5zWm1MoY3qIecWYLSPegQlG
         Up1uiTKKkRY2p2MweH2qmYHZIifyUmrpSOaoZN6nUecM+TfU7ggPJWbT7oup5u4HjZl2
         AJpl9NLp4ZL8+uNSax+sN4q6F7mxDv5Sbuocs65qz4Otd/MWxjzqInoj8vf8/ITNlY5M
         msnWuFup3Vq3m2CAd7QbG3f/JD7HQFawJZvJFzFHGngTL/O5XeKtkoYKN33fIoP4IzOS
         C4owZboF0mYZ9MIYvEnfF+zeSI9bepqAU+Cw+OdG+SrlAWmhD7MgJe7rNZdYL/dvsEEk
         vYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tsn4VsTJ4gltk0gVzC2/ImEH2n2wT6RUydHqF84UaYc=;
        b=HUcnhQILhdtquosrVqr+sLynHxKDZB+zXsmwEzUZeODaOS1KThbBtip19+s5x6rJdq
         65fnG5NXAbiMYedKq69d6tCugPd3iGGoCOGlSvBECcUt3pyyT7S8IicSFDR6uspHp8wF
         rs/0PmxOC1bDrAG5RSEhSqvA8I2s1OEb+9XHFud73j7O4MzksblCIZB6hhB7ew6Jbnh4
         ZosutYnBSLmpns5VQS3sAyaEHi7EaAjK+waA+yXZQuGvmlOpeJakpSd7bZlM2W6ySG/8
         01wtAhRz13kFGmeiAGPfN5jHt8P3FGJPPVQdLH7Xoxu7xCqj83Elq5aPeU/vlm1dvMHG
         3+3w==
X-Gm-Message-State: AO0yUKUFak1sbPBi2KjLbroKSORO5HowaLd2+dWPAFk/8lL3cR3lSh9i
        tBucR3oi9Y6EVlPhIqAzdr9iQfzK5nvR
X-Google-Smtp-Source: AK7set/iuTfU6K6EnADabcRuRTAK4ALOh0y7RaA7Ry0cP3zcs8h2SCdb9UMe3iIHuS8C3p10chfpwIHb+w+k
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a17:90a:6e49:b0:230:c4f5:8577 with SMTP id
 s9-20020a17090a6e4900b00230c4f58577mr115175pjm.20.1676400379215; Tue, 14 Feb
 2023 10:46:19 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Tue, 14 Feb 2023 18:45:59 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230214184606.510551-1-mizhang@google.com>
Subject: [PATCH v2 0/7] Overhauling amx_test
From:   Mingwei Zhang <mizhang@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
        Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

AMX architecture involves several entities such as xstate, XCR0,
IA32_XFD. This series add several missing checks on top of the existing
amx_test.

v1 -> v2:
 - Add a working xstate data structure suggested by seanjc.
 - Split the checking of CR0.TS from the checking of XFD.
 - Fix all the issues pointed by in review.

v1:
https://lore.kernel.org/all/20230110185823.1856951-1-mizhang@google.com/

Mingwei Zhang (7):
  KVM: selftests: x86: Fix an error in comment of amx_test
  KVM: selftests: x86: Add a working xstate data structure
  KVM: selftests: x86: Add check of CR0.TS in the #NM handler in
    amx_test
  KVM: selftests: Add the XFD check to IA32_XFD in #NM handler
  KVM: selftests: Fix the checks to XFD_ERR using and operation
  KVM: selftests: x86: Enable checking on xcomp_bv in amx_test
  KVM: selftests: x86: Repeat the checking of xheader when
    IA32_XFD[XTILEDATA] is set in amx_test

 .../selftests/kvm/include/x86_64/processor.h  | 12 ++++
 tools/testing/selftests/kvm/x86_64/amx_test.c | 59 ++++++++++---------
 2 files changed, 43 insertions(+), 28 deletions(-)

-- 
2.39.1.581.gbfd45094c4-goog

