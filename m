Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B91E522828
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 May 2022 02:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239214AbiEKAIY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 20:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiEKAIX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 20:08:23 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89312ED4B
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 17:08:21 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id o8-20020a17090a9f8800b001dc9f554c7fso331888pjp.4
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 17:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=dNbuTkyCU7vGFCoTsA664uRiY2J5liUoITH0qkWIFzA=;
        b=UnseLFLzO9W0l5JlYK+1pZQ6JC+DosIx+0fntsgSeA0m3izeVHHQFC90U1vn8Jk/DQ
         B1CsUwqVqGZB26akMlbFTPJiv40VFo8/7Yu+nx+k++gC1z/dfsdOWogC/LBsKml0Gs4a
         eo7bS1PVA3oUB4f8Rg1KR+9xoN/I7+UVhR1chUV765VUhChynWt3VHWlw0r3R1coIf5p
         mOwQiMF2ZcqdTYvdP/pNU2CKCnCVpiWWfjLucUJwCkAcebr6qKMZ7qnQCdiFfuxWFIMq
         kZ89TKd8QzQ98UH+HWxLk9p1AiyRJtXF1iS5Yo0Y4GFDIfuPxXDX0ZvEPfoLO6G0dmYd
         iDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=dNbuTkyCU7vGFCoTsA664uRiY2J5liUoITH0qkWIFzA=;
        b=xIludAn8UE7e1PSFPIsnfH5tRAlY9KUSaw3CsHgZGvm1K2liWylVHHWCvdzSO5dFTa
         ShgdyPilmijTOzzwuxjt9+hPG/O33xpGicKQQMEGE6NybBpUmweeDDFZtgo45tnHNWAJ
         gbc3W0WiCEg0+N7qZ/dcnuT9BXu0oYAptPwbMwhUXJ7ww8rR59WvGKnJcU+UFIVxVYTF
         /n3W/4REQ0kyL9LXpLlfobscBPqdyviT9/OXV2yyCvd+y3tCaBmHrV9xzhCK8d3t0dPS
         KTkKF7iqyOOlbBk91063Mhvip7ZX58ZmQNj9Bkx/Zf9MUptsp/Hm1/Y/JCwc3yWHLGkT
         oyVw==
X-Gm-Message-State: AOAM533ZPvHIZSjiMmfA7ybk2vryUUf0W2qZv5fBRiM8wd5H3DwiizKs
        CQ1wX1x34VSfvzZZCITWs5jlFWxTcSS2ephF
X-Google-Smtp-Source: ABdhPJw3owLfgfZAtsGQO5jBYr1h8XAIQ4b1CvTrkLICgc6kV0PqhJkSCXusqz878VEn6FCZQ/2+GaJT1BOXVRec
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:90a:e510:b0:1d9:ee23:9fa1 with SMTP
 id t16-20020a17090ae51000b001d9ee239fa1mr55515pjy.0.1652227700562; Tue, 10
 May 2022 17:08:20 -0700 (PDT)
Date:   Wed, 11 May 2022 00:08:02 +0000
Message-Id: <20220511000811.384766-1-vannapurve@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [RFC V2 PATCH 0/8] selftests: KVM: selftests for fd-based approach of
 supporting private memory
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shauh@kernel.org, yang.zhong@intel.com,
        drjones@redhat.com, ricarkol@google.com, aaronlewis@google.com,
        wei.w.wang@intel.com, kirill.shutemov@linux.intel.com,
        corbet@lwn.net, hughd@google.com, jlayton@kernel.org,
        bfields@fieldses.org, akpm@linux-foundation.org,
        chao.p.peng@linux.intel.com, yu.c.zhang@linux.intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com,
        michael.roth@amd.com, qperret@google.com, steven.price@arm.com,
        ak@linux.intel.com, david@redhat.com, luto@kernel.org,
        vbabka@suse.cz, marcorr@google.com, erdemaktas@google.com,
        pgonda@google.com, nikunj@amd.com, seanjc@google.com,
        diviness@google.com, Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This v2 series implements selftests targeting the feature floated by Chao
via:
https://lore.kernel.org/linux-mm/20220310140911.50924-1-chao.p.peng@linux.intel.com/

Below changes aim to test the fd based approach for guest private memory
in context of normal (non-confidential) VMs executing on non-confidential
platforms.

priv_memfd_test.c file adds a suite of selftests to access private memory
from the guest via private/shared accesses and checking if the contents
can be leaked to/accessed by vmm via shared memory view.

Updates in V2:
1) Tests are added to exercise implicit/explicit memory conversion paths.
2) Test is added to exercise UPM feature without double memory allocation.

This series has dependency on following patches:
1) V5 series patches from Chao mentioned above.
2) https://github.com/vishals4gh/linux/commit/b9adedf777ad84af39042e9c19899600a4add68a
  - Fixes host kernel crash with current implementation
3) https://github.com/vishals4gh/linux/commit/0577e351ee36d52c1f6cdcb1b8de7aa6b5f760fe
  - Confidential platforms along with the confidentiality aware software stack
    support a notion of private/shared accesses from the confidential VMs.
    Generally, a bit in the GPA conveys the shared/private-ness of the access.

    Non-confidential platforms don't have a notion of private or shared accesses
    from the guest VMs. To support this notion, KVM_HC_MAP_GPA_RANGE is modified
    to allow marking an access from a VM within a GPA range as always shared or
    private. There is an ongoing discussion about adding support for
    software-only confidential VMs, which should replace this patch.
4) https://github.com/vishals4gh/linux/commit/8d46aea9a7d72e4b1b998066ce0dde085fb963a7
  - Temporary placeholder to be able to test memory conversion paths
    till the memory conversion exit error code is finalized.
5) https://github.com/vishals4gh/linux/commit/4c36706477c62d9416d635fa6ac4ef6484014dfc
  - Fixes GFN calculation during memory conversion path.

Github link for the patches posted as part of this series:
https://github.com/vishals4gh/linux/commits/priv_memfd_selftests_rfc_v2

Austin Diviness (1):
  selftests: kvm: Add hugepage support to priv_memfd_test suite.

Vishal Annapurve (7):
  selftests: kvm: Fix inline assembly for hypercall
  selftests: kvm: Add a basic selftest to test private memory
  selftests: kvm: priv_memfd_test: Add support for memory conversion
  selftests: kvm: priv_memfd_test: Add shared access test
  selftests: kvm: Add implicit memory conversion tests
  selftests: kvm: Add KVM_HC_MAP_GPA_RANGE hypercall test
  selftests: kvm: priv_memfd: Add test avoiding double allocation

 tools/testing/selftests/kvm/Makefile          |    1 +
 .../selftests/kvm/lib/x86_64/processor.c      |    2 +-
 tools/testing/selftests/kvm/priv_memfd_test.c | 1359 +++++++++++++++++
 3 files changed, 1361 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kvm/priv_memfd_test.c

-- 
2.36.0.512.ge40c2bad7a-goog

