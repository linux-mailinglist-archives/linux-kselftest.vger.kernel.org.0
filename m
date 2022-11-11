Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B21624FC4
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 02:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbiKKBmy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Nov 2022 20:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbiKKBmx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Nov 2022 20:42:53 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E24D63154
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Nov 2022 17:42:52 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id x16-20020a63b210000000b0045f5c1e18d0so1870046pge.0
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Nov 2022 17:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TAHihsTyfGyAOhGUW7I4wir9NV3xrHHtanIUEi5rljw=;
        b=ctVUY+NuP8bjPDhX7vuhDJvm2n25aX8oAUBCZdazRVXluVmP2yFQNgL+fjvTiAE9xc
         4ynf3N8CCEFL5RljMwLCl3O5hJDYjH2EaLiXkOCV3+11QdPEv0794VY3V9S5THhl66FW
         nCNCPuFc/nfO+hwhcG8yOjc8CJw6yyeeJE72502RbwENwKbX7jcZtHlpMmGuy9L/QEwh
         SZU2FC2Aje8OKXZJUaym3TvV+tfZggBmCPaLSk7h+e0eLbUaspI5+4cnTbSltIJwgWDy
         jHAfK8k1GJgWseBKRl3xxDzuw03JbTtfuvFxL702lzXG/8BkQAEjuzlkLRknd2hNZIfA
         LjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TAHihsTyfGyAOhGUW7I4wir9NV3xrHHtanIUEi5rljw=;
        b=omCB4RsV16gPFpDJA//M28lSNP/PLnmmkLr5UpydMUT35TS0wOciPDEerFb1bBCxaJ
         rn3j07dewO+g8TkniSwtH+Nu+jKyQrFxEcmuC5ESQ4QE8/5KUG5Q9o9i43IZ++mVzjOc
         yvjBNewjS4pdZ+zq+7VpaBQjOh03+0k7+xfevEdWpDdhlPWrLKCOqaLtI+KswPHuZT0f
         +oEdo+t27p5gLtfymsNkA/88z6Y1pI0eCu1hxlYW7d+6slubs108+/Zeky0UDTua+xKf
         rUPLL5bztMsAlbs1LJbkRi9aeB0Jwv33viqOyfVpgOtWYUm6su7j08Alp25TT7IlJBPR
         60Xw==
X-Gm-Message-State: ANoB5pmZTpzjoUbnVwgJmwOUDU1Yzn+iyBQa6l+cXjRb84roBFEMOlUY
        RuzN6MFgzXzuEns1e46XnS+bCe6QCcPozccN
X-Google-Smtp-Source: AA0mqf52xLE3aMk5fS5x1WInkfim/45aB6RnUca127I+fO5id2BwMfEKoajVorUywyMwwNE39hKAh1Z0O/EkuHrJ
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a05:6a00:1581:b0:56b:d19f:33f8 with
 SMTP id u1-20020a056a00158100b0056bd19f33f8mr386838pfk.17.1668130971513; Thu,
 10 Nov 2022 17:42:51 -0800 (PST)
Date:   Fri, 11 Nov 2022 01:42:38 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221111014244.1714148-1-vannapurve@google.com>
Subject: [V1 PATCH 0/6] selftests: KVM: selftests for fd-based private memory
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shuah@kernel.org, yang.zhong@intel.com,
        ricarkol@google.com, aaronlewis@google.com, wei.w.wang@intel.com,
        kirill.shutemov@linux.intel.com, corbet@lwn.net, hughd@google.com,
        jlayton@kernel.org, bfields@fieldses.org,
        akpm@linux-foundation.org, chao.p.peng@linux.intel.com,
        yu.c.zhang@linux.intel.com, jun.nakajima@intel.com,
        dave.hansen@intel.com, michael.roth@amd.com, qperret@google.com,
        steven.price@arm.com, ak@linux.intel.com, david@redhat.com,
        luto@kernel.org, vbabka@suse.cz, marcorr@google.com,
        erdemaktas@google.com, pgonda@google.com, nikunj@amd.com,
        seanjc@google.com, diviness@google.com, maz@kernel.org,
        dmatlack@google.com, axelrasmussen@google.com,
        maciej.szmigiero@oracle.com, mizhang@google.com,
        bgardon@google.com, ackerleytng@google.com,
        Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series implements selftests targeting the feature floated by Chao
via:
https://lore.kernel.org/linux-mm/20221109041358.GA118963@chaop.bj.intel.com/T/

Below changes aim to test the fd based approach for guest private memory
in context of normal (non-confidential) VMs executing on non-confidential
platforms.

private_mem_test.c file adds selftest to access private memory from the
guest via private/shared accesses and checking if the contents can be
leaked to/accessed by vmm via shared memory view before/after conversions.

Updates in V1 (Compared to RFC v3 patches):
1) Incorporated suggestions from Sean around simplifying KVM changes
2) Addressed comments from Sean
3) Added private mem test with shared memory backed by 2MB hugepages.

RFC v3 series:
https://lore.kernel.org/lkml/20220819174659.2427983-1-vannapurve@google.com/t/

This series has dependency on following patches:
1) V9 series patches from Chao mentioned above.

Github link for the patches posted as part of this series:
https://github.com/vishals4gh/linux/commits/priv_memfd_selftests-v1

Vishal Annapurve (6):
  KVM: x86: Add support for testing private memory
  KVM: Selftests: Add support for private memory
  KVM: selftests: x86: Add IS_ALIGNED/IS_PAGE_ALIGNED helpers
  KVM: selftests: x86: Execute VMs with private memory
  KVM: selftests: Add get_free_huge_2m_pages
  KVM: selftests: x86: Add selftest for private memory

 arch/x86/kvm/mmu/mmu.c                        |   4 +
 arch/x86/kvm/mmu/mmu_internal.h               |   4 +-
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   2 +
 .../selftests/kvm/include/kvm_util_base.h     |  15 +-
 .../testing/selftests/kvm/include/test_util.h |   5 +
 .../kvm/include/x86_64/private_mem.h          |  37 +++
 .../selftests/kvm/include/x86_64/processor.h  |   1 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  58 ++++-
 tools/testing/selftests/kvm/lib/test_util.c   |  30 +++
 .../selftests/kvm/lib/x86_64/private_mem.c    | 211 ++++++++++++++++++
 .../selftests/kvm/x86_64/private_mem_test.c   | 190 ++++++++++++++++
 virt/kvm/Kconfig                              |   4 +
 virt/kvm/kvm_main.c                           |   2 +-
 14 files changed, 555 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/private_mem.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/private_mem.c
 create mode 100644 tools/testing/selftests/kvm/x86_64/private_mem_test.c

-- 
2.38.1.431.g37b22c650d-goog

