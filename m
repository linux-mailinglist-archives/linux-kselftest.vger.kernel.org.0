Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D8659A358
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Aug 2022 20:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350162AbiHSSBD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Aug 2022 14:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350829AbiHSSA1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Aug 2022 14:00:27 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C37108F18
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Aug 2022 10:47:23 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-334228502a8so88298387b3.20
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Aug 2022 10:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=68jCmlJPTWjEgDH8dkKvsN/Vy+R3D5xwsjHMw72NqNI=;
        b=NM4HyjtIBQ7etrlOFPYIvVk5AscNC7t026h95x4fzfrTKG/0tt7n8peKjYT7elXEKv
         5BSLtW4bMFgrN6ymudRaSc7o4eyszTLMILhkqSMcAqk71Belo4theQvOvFbAcyBdR8mT
         Y4QMGBFg2QZjPAMu4HURM9fZg+m22w7PyufoX4YXFtboyXUAJdt/ZV6gs285xyx7Iike
         tRhpzNBUbMUhjBe3WxyNncJ8Cs5trM/tdh/JmemktXFM6HyhKPNUeUbtacvl39ZlCxvi
         kXY9fTvnMgGaNeXrmCP5Z0gVeTtDXo8zc32GSnUCNmN2PrGd8kbdZhvTHmfWN1cMv30n
         VbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=68jCmlJPTWjEgDH8dkKvsN/Vy+R3D5xwsjHMw72NqNI=;
        b=7lTZEorL0fjGJ+bjdwd/ncPZMIMOr084M750xDXcTtEwBGOg6Wr+LpBlyDb0w7uPm1
         uC8FpmoXEJRnix7/nsxjLjpEzsESL3I6lQBkAfFmUlzrYbeXsIfPx3ugURwdiJXbrBe6
         /jrTQX8fksU59Q6RXB9aR03QOO3VXAp1dw0cG8ni+UHgRj1r8tNc7Vrc2igR/jv143kK
         7mv4luf3D/Hzbb5PQ5HEty7qXWfWo4bu/S/GJZE5w/TXbVQdBWl/943hrDxrqGft4XhC
         w5Cq8yVUbJs+izND64XNahi+SpH+hwW8CJW2ErxNDUGHEcPpolHxtRlA0x/GOaFsuvAc
         AH1w==
X-Gm-Message-State: ACgBeo1ZcHXkANPAzdjNl+6avBfok0+CLngO+DgyCtBxvgVPq1ptUhl4
        pONg/UT9W+8KMvwWviJa1KbN55YbrFQ1WiwE
X-Google-Smtp-Source: AA6agR6DIUG9NXvjt9p2KBgUlc6EhGutVC6loa8Jf8FHQddKVVlyc1IRm//fxEaRXHCuyKWYVdFq1MWl3jfvMPqb
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a25:bd3:0:b0:691:d47a:be78 with SMTP id
 202-20020a250bd3000000b00691d47abe78mr8120620ybl.574.1660931242410; Fri, 19
 Aug 2022 10:47:22 -0700 (PDT)
Date:   Fri, 19 Aug 2022 17:46:53 +0000
Message-Id: <20220819174659.2427983-1-vannapurve@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [RFC V3 PATCH 0/6] selftests: KVM: selftests for fd-based private memory
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shuah@kernel.org, yang.zhong@intel.com,
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
        diviness@google.com, maz@kernel.org, dmatlack@google.com,
        axelrasmussen@google.com, maciej.szmigiero@oracle.com,
        mizhang@google.com, bgardon@google.com,
        Vishal Annapurve <vannapurve@google.com>
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

This v3 series implements selftests targeting the feature floated by Chao
via:
https://lore.kernel.org/linux-mm/20220706082016.2603916-12-chao.p.peng@linux.intel.com/T/

Below changes aim to test the fd based approach for guest private memory
in context of normal (non-confidential) VMs executing on non-confidential
platforms.

private_mem_test.c file adds selftest to access private memory from the
guest via private/shared accesses and checking if the contents can be
leaked to/accessed by vmm via shared memory view before/after conversions.

Updates in V3:
1) Series is based on v7 series from Chao
2) Changes are introduced in KVM to help execute private mem selftests
3) Selftests are executing from private memory
4) Test implementation is simplified to contain implicit/explicit memory
conversion paths according to feedback from Sean.
5) Addressed comments from Sean and Shuah.

This series has dependency on following patches:
1) V7 series patches from Chao mentioned above.
2) https://lore.kernel.org/lkml/20220810152033.946942-1-pgonda@google.com/T/#u
  - Series posted by Peter containing patches from Michael and Sean.

Github link for the patches posted as part of this series:
https://github.com/vishals4gh/linux/commits/priv_memfd_selftests_rfc_v3

Vishal Annapurve (6):
  kvm: x86: Add support for testing private memory
  selftests: kvm: Add support for private memory
  selftests: kvm: ucall: Allow querying ucall pool gpa
  selftests: kvm: x86: Execute hypercall as per the cpu
  selftests: kvm: x86: Execute VMs with private memory
  sefltests: kvm: x86: Add selftest for private memory

 arch/x86/include/uapi/asm/kvm_para.h          |   2 +
 arch/x86/kvm/Kconfig                          |   1 +
 arch/x86/kvm/mmu/mmu.c                        |  19 ++
 arch/x86/kvm/mmu/mmu_internal.h               |   2 +-
 arch/x86/kvm/x86.c                            |  67 +++-
 include/linux/kvm_host.h                      |  12 +
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   2 +
 .../selftests/kvm/include/kvm_util_base.h     |  12 +-
 .../selftests/kvm/include/ucall_common.h      |   2 +
 .../kvm/include/x86_64/private_mem.h          |  51 +++
 tools/testing/selftests/kvm/lib/kvm_util.c    |  40 ++-
 .../testing/selftests/kvm/lib/ucall_common.c  |  12 +
 .../selftests/kvm/lib/x86_64/private_mem.c    | 297 ++++++++++++++++++
 .../selftests/kvm/lib/x86_64/processor.c      |  15 +-
 .../selftests/kvm/x86_64/private_mem_test.c   | 262 +++++++++++++++
 virt/kvm/Kconfig                              |   9 +
 virt/kvm/kvm_main.c                           |  90 +++++-
 18 files changed, 887 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/private_mem.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/private_mem.c
 create mode 100644 tools/testing/selftests/kvm/x86_64/private_mem_test.c

-- 
2.37.1.595.g718a3a8f04-goog

