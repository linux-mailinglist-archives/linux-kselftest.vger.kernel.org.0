Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B615332B0
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 May 2022 22:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241773AbiEXU5F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 May 2022 16:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240084AbiEXU5D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 May 2022 16:57:03 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FA336150
        for <linux-kselftest@vger.kernel.org>; Tue, 24 May 2022 13:57:01 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id w83-20020a627b56000000b005182702c297so8204781pfc.0
        for <linux-kselftest@vger.kernel.org>; Tue, 24 May 2022 13:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HEeApo5ALymfLav8MKuppOv54aHzpbE0xFgatZAbaOI=;
        b=kv0qmQnmNTU7x7HQl/EE7lkTLtRc9F7QeG5hYPIFCg7DoOswX6ZjqlRK2L5bLUzTJq
         rmh1u/FAyYQ5xcZubP/gSjXLd8yenwWSBlpAZJli4lAa9w+k4BW57chK/Uu+LH9YXxY6
         4yvJsFXJGxImE+cVVw4Fv5bqJsG9jFidqO/vrVqJ4sDfq2LIqV6ZL2tnO5rzLuaHlTj5
         falYT0h/ngENNnyBIVR/7sxuZ7J61o/ZArK50y3skVrHvoie/eABFdeINJaL3D3/wHOM
         5Y9ImSCkPczalysMqTzu8/WFixWASQnWYfvYaG7CJD2fJ2xaw3HJ5L9Has/SeubJpj/z
         B5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HEeApo5ALymfLav8MKuppOv54aHzpbE0xFgatZAbaOI=;
        b=iWe62WeAwFFbwH6oqW5UaBRC+d2K7RBxHvDZt3PM2FYNAto7GDm8tCa5ILSTR9jSsr
         2tQbg24M+vaU9kw5swdZwrA+RVYfc8rnzWInCPQqkaxzYaXEq9ck/2MPX8vMj5c17qdo
         02LuraZCT4471QVPS9Aojp0RZkzEZxAuu/fiEACgzvcrCzA2gmBzOq1R9Y1H9wmPZ2gE
         Nul88N4w+2yc9yX2JaT4dSCgyRrKayZgy/nvA228sqVBbbh6lDByuUZoobkfbZbLIjgm
         dQzdWH7u3fxZ83d+eSzACNzqbiz9vjW2cX0ZllAvBQgo/POk8pxh4rbs4+68HGTZyXcR
         VsnA==
X-Gm-Message-State: AOAM533RL6XyG0fc68ZgYWrW4Rn2+ztSidNts14zMzUOFU75OaFTRvLi
        dAzQpuXdk96H+qkaNWwjlmh5DGo3FkRWVIif
X-Google-Smtp-Source: ABdhPJxKXNWcvGU5h6fKtyB706UOewsJBMI8Pe35pY7Gpw9/aokAZ/4NW4rSKrVFi8BYUTcmnEz+3j7wQJk+8GxY
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a05:6a00:1acb:b0:518:986c:a7c4 with
 SMTP id f11-20020a056a001acb00b00518986ca7c4mr13256588pfv.2.1653425821110;
 Tue, 24 May 2022 13:57:01 -0700 (PDT)
Date:   Tue, 24 May 2022 20:56:43 +0000
Message-Id: <20220524205646.1798325-1-vannapurve@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [RFC V1 PATCH 0/3] selftests: KVM: sev: selftests for fd-based
 approach of supporting private memory
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

This series implements selftests targeting the feature floated by Chao
via:
https://lore.kernel.org/linux-mm/20220519153713.819591-1-chao.p.peng@linux.intel.com/

Below changes aim to test the fd based approach for guest private memory
in context of SEV/SEV-ES VMs executing on AMD SEV/SEV-ES compatible
platforms.

This series has dependency on following patch series:
1) V6 series patches from Chao mentioned above.
2) https://lore.kernel.org/all/20211210164620.11636-1-michael.roth@amd.com/T/
  - KVM: selftests: Add support for test-selectable ucall implementations
    series by Michael Roth
3) https://lore.kernel.org/kvm/20220104234129.dvpv3o3tihvzsqcr@amd.com/T/
  - KVM: selftests: Add tests for SEV and SEV-ES guests series by Michael Roth

And few additional patches:
* https://github.com/vishals4gh/linux/commit/2cb215cb6b4dff7fdf703498165179626c0cdfc7
  - Confidential platforms along with the confidentiality aware software stack
    support a notion of private/shared accesses from the confidential VMs.
    Generally, a bit in the GPA conveys the shared/private-ness of the access.
    SEV/SEV-ES implementation doesn't expose the encryption bit information
    via fault address to KVM and so this hack is still needed to signal
    private/shared access ranges to the kvm.
* https://github.com/vishals4gh/linux/commit/81a7d24231f6b8fb4174bbf97ed733688e8dbc0c

Github link for the patches posted as part of this series:
https://github.com/vishals4gh/linux/commits/sev_upm_selftests_rfc_v1

sev_priv_memfd_test.c file adds a suite of selftests to access private memory
from the SEV/SEV-ES guests via private/shared accesses and checking if the
contents can be leaked to/accessed by vmm via shared memory view.

To allow SEV/SEV-ES VMs to toggle the encryption bit during memory conversion,
support is added for mapping guest pagetables to guest va ranges and passing
the mapping information to guests via shared pages.

Vishal Annapurve (3):
  selftests: kvm: x86_64: Add support for pagetable tracking
  selftests: kvm: sev: Handle hypercall exit
  selftests: kvm: sev: Port UPM selftests onto SEV/SEV-ES VMs

 tools/testing/selftests/kvm/.gitignore        |    1 +
 tools/testing/selftests/kvm/Makefile          |    1 +
 .../selftests/kvm/include/kvm_util_base.h     |   98 ++
 tools/testing/selftests/kvm/lib/kvm_util.c    |   81 +-
 .../selftests/kvm/lib/kvm_util_internal.h     |    9 +
 .../selftests/kvm/lib/x86_64/processor.c      |   36 +
 .../selftests/kvm/lib/x86_64/sev_exitlib.c    |   39 +-
 .../kvm/x86_64/sev_priv_memfd_test.c          | 1511 +++++++++++++++++
 8 files changed, 1770 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/sev_priv_memfd_test.c

-- 
2.36.1.124.g0e6072fb45-goog

