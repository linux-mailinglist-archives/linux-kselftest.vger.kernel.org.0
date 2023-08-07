Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7827877332B
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 01:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjHGXBb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 19:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHGXBa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 19:01:30 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0DD10F4
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Aug 2023 16:01:28 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-55c7bb27977so5033170a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Aug 2023 16:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691449288; x=1692054088;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ss/71oxFBRdAW2cxcHK7UY62Gn+6jbKx5vE5M9l/SE4=;
        b=RRW/dV5l+QziKsyhbbcF4AZKL0bIjPOef7yRlt2G1D1+ZLFr9EXprdfji5tAeSRYC5
         zngWiXG3xOEMy7WXlxUFGNwEymvu7pLx4ta778nDj3+qIL/6TiRrAxyPuFZYfLbvqE8G
         bEc6SH5czQ/0cxaC6vnWcChbq2/tjkSG4TQySEzm2bZIHJMOZGXwADCmlTTE5PLfX9AB
         EleRnHqXH42bDshPJF3zoHFdpSLmeWcyfXo2AqrrBduVvAnG6F6rWOsqEibgbvSBxyZu
         /v+TPBGTJiJYYIVnr0B+h+/1DWqjR832+Skd0FWvENVSFlcsihi9lP8Cc3mzikqU5SoY
         rsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449288; x=1692054088;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ss/71oxFBRdAW2cxcHK7UY62Gn+6jbKx5vE5M9l/SE4=;
        b=KPsFuo6zbNHhVRJFfPyu2eyumF7wL7R6d4NeBr9LaPAEo1zXetVJ2LGZGTAoP70vOs
         MSp2daUXcieek2WzmoaS+40TEQngq8O4uPuvOZyDT9Iv5X22VYz0iDcFDGJ8wOn0CFKm
         3TpzgTKPO7xvz177hC1Ru+HS0QQSHRQmeJeAzUOY0/9GPQPcx3vfWqN4I6eihDle9SoY
         tPufYkOW/iCmbmJ+WaBoBd8ICWsEubfkEetr6R14EwFi9mpFkDbdFD3NeVUiOa6XJNth
         f06mSydICJZCKBRt+DVYuPW8iL/VPkj1FvLPmLsOI7QorJsw8BWIoD3SvxkaKUKsaXl6
         vwrg==
X-Gm-Message-State: AOJu0YxOCfE0/uAlIPQ++UN20l04fnTMi9siCCBdWGX1G//vUoAYMUMv
        DP4KmFU1Cy0/Jm/pt4pQ2G8CC1LtX0UfEeEbOQ==
X-Google-Smtp-Source: AGHT+IEzjtpf8AaW7s8r5/nKbT6iYWlzhuR5P2NLXFgZ6/dGRQCOjgAf5RIjHAKxGwzyFRfVBgh8oOkjIhF4fGg42g==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a63:7d04:0:b0:563:e826:823b with SMTP
 id y4-20020a637d04000000b00563e826823bmr47777pgc.6.1691449288296; Mon, 07 Aug
 2023 16:01:28 -0700 (PDT)
Date:   Mon,  7 Aug 2023 23:01:03 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <cover.1691446946.git.ackerleytng@google.com>
Subject: =?UTF-8?q?=5BRFC=20PATCH=2000/11=5D=20New=20KVM=20ioctl=20to=20link=20a=20gmem=C2=A0inode=20to=20a=20new=20gmem=20file?=
From:   Ackerley Tng <ackerleytng@google.com>
To:     pbonzini@redhat.com, seanjc@google.com, tglx@linutronix.de,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shuah@kernel.org, andrew.jones@linux.dev,
        ricarkol@google.com, chao.p.peng@linux.intel.com, tabba@google.com,
        jarkko@kernel.org, yu.c.zhang@linux.intel.com,
        vannapurve@google.com, ackerleytng@google.com,
        erdemaktas@google.com, mail@maciej.szmigiero.name, vbabka@suse.cz,
        david@redhat.com, qperret@google.com, michael.roth@amd.com,
        wei.w.wang@intel.com, liam.merwick@oracle.com,
        isaku.yamahata@gmail.com, kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

This patchset builds upon the code at
https://lore.kernel.org/lkml/20230718234512.1690985-1-seanjc@google.com/T/.

This code is available at
https://github.com/googleprodkernel/linux-cc/tree/kvm-gmem-link-migrate-rfc=
v1.

In guest_mem v11, a split file/inode model was proposed, where memslot
bindings belong to the file and pages belong to the inode. This model
lends itself well to having different VMs use separate files pointing
to the same inode.

This RFC proposes an ioctl, KVM_LINK_GUEST_MEMFD, that takes a VM and
a gmem fd, and returns another gmem=C2=A0fd referencing a different file
and associated with VM. This RFC also includes an update to
KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM to migrate memory context
(slot->arch.lpage_info and kvm->mem_attr_array) from source to
destination vm, intra-host.

Intended usage of the two ioctls:

1. Source VM=E2=80=99s fd is passed to destination VM via unix sockets
2. Destination VM uses new ioctl KVM_LINK_GUEST_MEMFD to link source
   VM=E2=80=99s fd to a new fd.
3. Destination VM will pass new fds=C2=A0to KVM_SET_USER_MEMORY_REGION,
   which will bind the new file, pointing to the same inode that the
   source VM=E2=80=99s file points to, to memslots
4. Use KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM to move kvm->mem_attr_array
   and slot->arch.lpage_info to the destination VM.
5. Run the destination VM as per normal

Some other approaches considered were:

+ Using the linkat() syscall, but that requires a mount/directory for
  a source fd to be linked to
+ Using the dup() syscall, but that only duplicates the fd, and both
  fds point to the same file

---

Ackerley Tng (11):
  KVM: guest_mem: Refactor out kvm_gmem_alloc_file()
  KVM: guest_mem: Add ioctl KVM_LINK_GUEST_MEMFD
  KVM: selftests: Add tests for KVM_LINK_GUEST_MEMFD ioctl
  KVM: selftests: Test transferring private memory to another VM
  KVM: x86: Refactor sev's flag migration_in_progress to kvm struct
  KVM: x86: Refactor common code out of sev.c
  KVM: x86: Refactor common migration preparation code out of
    sev_vm_move_enc_context_from
  KVM: x86: Let moving encryption context be configurable
  KVM: x86: Handle moving of memory context for intra-host migration
  KVM: selftests: Generalize migration functions from
    sev_migrate_tests.c
  KVM: selftests: Add tests for migration of private mem

 arch/x86/include/asm/kvm_host.h               |   4 +-
 arch/x86/kvm/svm/sev.c                        |  85 ++-----
 arch/x86/kvm/svm/svm.h                        |   3 +-
 arch/x86/kvm/x86.c                            | 221 +++++++++++++++++-
 arch/x86/kvm/x86.h                            |   6 +
 include/linux/kvm_host.h                      |  18 ++
 include/uapi/linux/kvm.h                      |   8 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../testing/selftests/kvm/guest_memfd_test.c  |  42 ++++
 .../selftests/kvm/include/kvm_util_base.h     |  31 +++
 .../kvm/x86_64/private_mem_migrate_tests.c    |  93 ++++++++
 .../selftests/kvm/x86_64/sev_migrate_tests.c  |  48 ++--
 virt/kvm/guest_mem.c                          | 151 ++++++++++--
 virt/kvm/kvm_main.c                           |  10 +
 virt/kvm/kvm_mm.h                             |   7 +
 15 files changed, 596 insertions(+), 132 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/private_mem_migrate_=
tests.c

--
2.41.0.640.ga95def55d0-goog
