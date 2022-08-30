Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D305B5A7082
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 00:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbiH3WUM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 18:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbiH3WUL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 18:20:11 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DA424088
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:20:06 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id j11-20020a17090a738b00b001faeb619f6eso5201376pjg.5
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=UI4OmQmR9sQA7gmj1l+KCwWtd2GoCQ+O3NdQp7yrdNo=;
        b=Y2OIwO5LuS2HwhMYuCBYf0GYwKgdpiShKssh+aazZImIauEqH6JXAftS3gtKk9/LnQ
         NBmgdT1OIICuONG4IFO7Eb49mhSttApoTZy+JK9wATYKy+b3wPGIgx3E21JuIAIdDzwS
         9WPXD+b6jWGMwiB7vpZNFpimGl8LXSjbUkkwVblWgmll9j//5mI7OCKrqS+0hExal78Z
         RKEheQl5WqfD8/xJyQDTR6QiwL3rwl0jo7vHe7lZFztEJLAGcy1NYvDLWEOVuqaYSZQf
         ByDZQqUcdub0BN/1mv/F0EjecxKyltRpbAqHOnWMGyCLyOHnPS+BRbDsODC0xQOODBfA
         XXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=UI4OmQmR9sQA7gmj1l+KCwWtd2GoCQ+O3NdQp7yrdNo=;
        b=YPuNSvNylUtPX/UT0NfBMNSZ83N2DZdpm8dVWweD8N16FXaKdmBcVyigz5bKBX0gxl
         3VU/puG2rghouDaghY0JpkYSMauEiFcwH6F7nPw+LcCBKJKdLcimUhm6cscEtKhn0Ki/
         cO6UhaMn5jS5BgjgvRphaGE/R+txek/DQRYEHnrqeifVvI7MfX4+ME60mn4EFDOz2wEA
         OyoNJ2MrTneMN8LFvqvB83PRuQEHEwBeHK6G0V1I/nM4m5b8nbJxkrdbEgaDXOdFX9cH
         Z27ozgiNopiYyRj10jUgu9tWPf8bJzyCU10ERf6ncIPAT1u5Xj9zcBRXzmAH5BHiyKfp
         23YQ==
X-Gm-Message-State: ACgBeo3oFJ1EdonSIACCBZ7lI7hRy0xNcj/sqJYyndOflKaS7NNURpO5
        J1s3wzwN/575Y8g+TNfBdD5LAZ8KpusMJl1UcL43aISaGllPcVUnqt07hHB7D7KwUxHHXQF6UwD
        /stTnXPn34rhCTe9z47BklHPeZVE9BrZTXrnJMUwjEQJUB0Eo4TKMTnxkpB6Jm80w0jBgaEo=
X-Google-Smtp-Source: AA6agR6Uzvh0P1N76w4nQ1rBpLF+zuxzX4pnDRJPPty9seQHvvtRyVj+1CTXhTL90+PuLdcTGp65xHvyhw==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a05:6a00:21c5:b0:52b:fc9c:295b with SMTP id
 t5-20020a056a0021c500b0052bfc9c295bmr23563210pfj.56.1661898005406; Tue, 30
 Aug 2022 15:20:05 -0700 (PDT)
Date:   Tue, 30 Aug 2022 22:19:43 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220830222000.709028-1-sagis@google.com>
Subject: [RFC PATCH v2 00/17] TDX KVM selftests
From:   Sagi Shahar <sagis@google.com>
To:     linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Sagi Shahar <sagis@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Ryan Afranji <afranji@google.com>,
        Roger Wang <runanwang@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Marc Zyngier <maz@kernel.org>, Ben Gardon <bgardon@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Matlack <dmatlack@google.com>,
        Peter Xu <peterx@redhat.com>, Oliver Upton <oupton@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Yang Zhong <yang.zhong@intel.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Peter Gonda <pgonda@google.com>, Marc Orr <marcorr@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Eric Auger <eric.auger@redhat.com>,
        Yanan Wang <wangyanan55@huawei.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Shier <pshier@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Zhenzhong Duan <zhenzhong.duan@intel.com>,
        "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
        Like Xu <like.xu@linux.intel.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
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

Hello,

This is v2 of the patch series for TDX selftests.

It is based on v5.19-rc8 and Intel's V8 of the TDX host patches which
was proposed in https://lkml.org/lkml/2022/8/8/877

The tree can be found at
https://github.com/googleprodkernel/linux-cc/tree/selftests

Major changes vrom v1:
- rebased to v5.19
- added helpers for success and failure reporting
- added additional test cases

---
TDX stands for Trust Domain Extensions which isolates VMs from the
virtual-machine manager (VMM)/hypervisor and any other software on the
platform.

Intel has recently submitted a set of RFC patches for KVM support for
TDX and more information can be found on the latest TDX Support
Patches: https://lkml.org/lkml/2022/8/8/877

Due to the nature of the confidential computing environment that TDX
provides, it is very difficult to verify/test the KVM support. TDX
requires UEFI and the guest kernel to be enlightened which are all under
development.

We are working on a set of selftests to close this gap and be able to
verify the KVM functionality to support TDX lifecycle and GHCI [1]
interface.

We are looking for any feedback on:
- Patch series itself
- Any suggestion on how we should approach testing TDX functionality.
Does selftests seems reasonable or should we switch to using KVM
unit tests. I would be happy to get some perspective on how KVM unit
tests can help us more.
- Any test case or scenario that we should add.
- Anything else I have not thought of yet.

Current patch series provide the following capabilities:

- Provide helper functions to create a TD (Trusted Domain) using the KVM
  ioctls
- Provide helper functions to create a guest image that can include any
  testing code
- Provide helper functions and wrapper functions to write testing code
  using GHCI interface
- Add a test case that verifies TDX life cycle
- Add a test case that verifies TDX GHCI port IO

TODOs:
- Use existing function to create page tables dynamically
  (ie __virt_pg_map())
- Remove arbitrary defined magic numbers for data structure offsets
- Add TDVMCALL for error reporting
- Add additional test cases as some listed below
- Add #VE handlers to help testing more complicated test cases

---
Erdem Aktas (4):
  KVM: selftests: Add support for creating non-default type VMs
  KVM: selftest: Add helper functions to create TDX VMs
  KVM: selftest: Adding TDX life cycle test.
  KVM: selftest: Adding test case for TDX port IO

Roger Wang (1):
  KVM: selftest: TDX: Add TDG.VP.INFO test

Ryan Afranji (2):
  KVM: selftest: TDX: Verify the behavior when host consumes a TD
    private memory
  KVM: selftest: TDX: Add shared memory test

Sagi Shahar (10):
  KVM: selftest: TDX: Add report_fatal_error test
  KVM: selftest: TDX: Add basic TDX CPUID test
  KVM: selftest: TDX: Add basic get_td_vmcall_info test
  KVM: selftest: TDX: Add TDX IO writes test
  KVM: selftest: TDX: Add TDX IO reads test
  KVM: selftest: TDX: Add TDX MSR read/write tests
  KVM: selftest: TDX: Add TDX HLT exit test
  KVM: selftest: TDX: Add TDX MMIO reads test
  KVM: selftest: TDX: Add TDX MMIO writes test
  KVM: selftest: TDX: Add TDX CPUID TDVMCALL test

 tools/testing/selftests/kvm/Makefile          |    2 +
 .../selftests/kvm/include/kvm_util_base.h     |   12 +-
 .../selftests/kvm/include/x86_64/processor.h  |    1 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |    6 +-
 .../selftests/kvm/lib/x86_64/processor.c      |   27 +
 tools/testing/selftests/kvm/lib/x86_64/tdx.h  |  495 +++++
 .../selftests/kvm/lib/x86_64/tdx_lib.c        |  373 ++++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 1666 +++++++++++++++++
 8 files changed, 2577 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/tdx.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/tdx_lib.c
 create mode 100644 tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c

-- 
2.37.2.789.g6183377224-goog

