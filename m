Return-Path: <linux-kselftest+bounces-33209-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB74CABA384
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 21:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9EEA20337
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 19:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490F2224AEE;
	Fri, 16 May 2025 19:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bvu8m0c2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFA4220F5C
	for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 19:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747423185; cv=none; b=XETvT1R01i5h5sLR6J4FEtMsHi723XwaY+DyBAZfh02ZDz+h8+et1uTgZ+85GNJpAbrnL7Ybtq7ozdkWyhXiINlHKoR5on/DB15WLbHF8K+3FzKeVfIpv6n9luGb7HgM8jdfOnOaCepMCC4hYqn3uuRONuV5zCeoqiJ3JzDDJAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747423185; c=relaxed/simple;
	bh=FKLiif/NYo4VCvUncBjssFWxL/LJ6nkG6rgoluFfwFM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=T1wKsYCigd7Cj+oiyzjkiTll3GPWTAstZ4kvnAQIKjSUX2Djs3qO5BuQ3zHbRPlPaPAn7TTmsVrnfIMEbkBvQIFMz3DZTGPEwuhHDHhzn5+WKriffLcsJsfIcXJVolzdbKH5qikAhDJ0F7SBu04fI/mxTrh1TfLGe//301xPmOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bvu8m0c2; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b0ae9e87fe2so2812212a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 12:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747423183; x=1748027983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hN2YUVYySVsTQNinDLvk+KvphrnbG/y9JhtMhkOkFRg=;
        b=bvu8m0c2bd22x3WKs+UBvsKo4cjPBlOS2DHm1AKK3MDJHmP4dXROJm4jrY7yj7lMgy
         +QhCGPJtiCm5RuEkgtubTQ6tma5RQLPrMPTAMbGIjnWXA9U+9sag6QZG2ndTa/g6CTZa
         P+SU35uD2LXLQDqPwmE/KGTBZwYw0IlMLmr5hLPXMUfqG/qdnptdgsTtiwGU3M8x1kwb
         v9l1HIJmkTIPdUVxxN3NjFBtjUH/uQ0QO0bENsiGFwdQiXJUZ6RVW+NFNDLEctsWrbV+
         fWeBDPmzHIHveBVMM5F5VnSY0Njo+QIDaxkfJyGHWhf3DrzrswKBjWHS9CYxIC1Wn/j+
         jnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747423183; x=1748027983;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hN2YUVYySVsTQNinDLvk+KvphrnbG/y9JhtMhkOkFRg=;
        b=wDFcLOiEeKt7YKjdSFwzGvhRzTFxXm+0lXUlWA4GzyAVdeq50AquL5EyRNSVy18y32
         DquZSXBLCYB2Od18Rbw4aExC29NsHZVEfBLZLLjn6edNE+reujGKcVWsfrfcmYh2PTLy
         aIfgAMCXFPzNW3H/ZZFcgpbvROqQ9zwSaebNYW6Y9GDBiiQPxygBsMxmlwxyYtW5QfVn
         YpsaRleQWhbN9Hg+jMmAttRt277YHael/xwTf+azFTVcnwNxCbFCEtRsykH1vBcq+lGR
         EAPDJFPvrTzCd1ZvH+c1ONJO3z6KW2lKocRFv/GcVxWoWfzMEYUN61vAJKSZhIrSm+11
         KVLg==
X-Forwarded-Encrypted: i=1; AJvYcCX94Qu4c06CkQpPp57NLRT3Mf6OWHQH3Rpg82SCciZ81cauXWhaYmG7TeYWKOQdO/fx1h19Qvt/7vRm8DEae1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLnJfIo08p/Ui+anB66E4FVmiPWOdT4JW2lhvPgqSagFBOGd7E
	eFP1vYEND3kemP5IYjc+zHLYx4DeffSEuaKXEP3hv8JF8fuRWUksxKe8tZVI+14P3IANCCO0FYW
	buG72E7qEdw==
X-Google-Smtp-Source: AGHT+IHjbqEIuZDaQq2w9Zoiig06iUykGfM1lby32o7AsLyS6nUiqZcnCSixtwRJbNTMp1w+E1dL3DR8U3tS
X-Received: from pjyp5.prod.google.com ([2002:a17:90a:e705:b0:30e:7783:edb6])
 (user=afranji job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2ecf:b0:30e:8fe1:f787
 with SMTP id 98e67ed59e1d1-30e8fe1f8bfmr2110199a91.5.1747423182803; Fri, 16
 May 2025 12:19:42 -0700 (PDT)
Date: Fri, 16 May 2025 19:19:20 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <cover.1747368092.git.afranji@google.com>
Subject: [RFC PATCH v2 00/13] New KVM ioctl to link a gmem inode to a new gmem file
From: Ryan Afranji <afranji@google.com>
To: afranji@google.com, ackerleytng@google.com, pbonzini@redhat.com, 
	seanjc@google.com, tglx@linutronix.de, x86@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	tabba@google.com
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	shuah@kernel.org, andrew.jones@linux.dev, ricarkol@google.com, 
	chao.p.peng@linux.intel.com, jarkko@kernel.org, yu.c.zhang@linux.intel.com, 
	vannapurve@google.com, erdemaktas@google.com, mail@maciej.szmigiero.name, 
	vbabka@suse.cz, david@redhat.com, qperret@google.com, michael.roth@amd.com, 
	wei.w.wang@intel.com, liam.merwick@oracle.com, isaku.yamahata@gmail.com, 
	kirill.shutemov@linux.intel.com, sagis@google.com, jthoughton@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

RFC v2 addresses comments in RFC v1 [1]. This series is also rebased
on kvm/next (v6.15-rc4).

Here's the series stitched together for your convenience:
https://github.com/googleprodkernel/linux-cc/tree/kvm-gmem-link-migrate-rfc=
v2

Changes from RFC v1:
+ Adds patches to make guest mem use guest mem inodes instead of
anonymous inodes.
+ Changed the name of factored out gmem allocating function to
kvm_gmem_alloc_view().
+ Changed the flag name vm_move_enc_ctxt_supported to
use_vm_enc_ctxt_op.
+ Various small changes to make patchset compatible with latest version
of kvm/next.

As a refresher, split file/inode model was proposed in guest_mem v11,
where memslot bindings belong to the file and pages belong to the inode.
This model lends itself well to having different VMs use separate files
pointing to the same inode.

The split file/inode model has also been used by the other following
recent patch series:

+ mmap support for guest_memfd: [2]
+ NUMA mempolicy support for guest_memfd: [3]
+ HugeTLB support for guest_memfd: [4]

This RFC proposes an ioctl, KVM_LINK_GUEST_MEMFD, that takes a VM and
a gmem fd, and returns another gmem fd referencing a different file
and associated with VM. This RFC also includes an update to
KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM to migrate memory context
(slot->arch.lpage_info and kvm->mem_attr_array) from source to
destination vm, intra-host.

Intended usage of the two ioctls:

1. Source VM=E2=80=99s fd is passed to destination VM via unix sockets.
2. Destination VM uses new ioctl KVM_LINK_GUEST_MEMFD to link source
   VM=E2=80=99s fd to a new fd.
3. Destination VM will pass new fds to KVM_SET_USER_MEMORY_REGION,
   which will bind the new file, pointing to the same inode that the
   source VM=E2=80=99s file points to, to memslots.
4. Use KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM to move kvm->mem_attr_array
   and slot->arch.lpage_info to the destination VM.
5. Run the destination VM as per normal.

Some other approaches considered were:

+ Using the linkat() syscall, but that requires a mount/directory for
  a source fd to be linked to
+ Using the dup() syscall, but that only duplicates the fd, and both
  fds point to the same file

[1] https://lore.kernel.org/all/cover.1691446946.git.ackerleytng@google.com=
/T/
[2] https://lore.kernel.org/all/20250328153133.3504118-2-tabba@google.com/
[3] https://lore.kernel.org/all/20250408112402.181574-6-shivankg@amd.com/
[4] https://lore.kernel.org/all/c1ee659c212b5a8b0e7a7f4d1763699176dd3a62.17=
47264138.git.ackerleytng@google.com/

---

Ackerley Tng (12):
  KVM: guest_memfd: Make guest mem use guest mem inodes instead of
    anonymous inodes
  KVM: guest_mem: Refactor out kvm_gmem_alloc_view()
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

David Hildenbrand (1):
  fs: Refactor to provide function that allocates a secure anonymous
    inode

 arch/x86/include/asm/kvm_host.h               |   3 +-
 arch/x86/kvm/svm/sev.c                        |  82 +------
 arch/x86/kvm/svm/svm.h                        |   3 +-
 arch/x86/kvm/x86.c                            | 218 ++++++++++++++++-
 arch/x86/kvm/x86.h                            |   6 +
 fs/anon_inodes.c                              |  23 +-
 include/linux/fs.h                            |  13 +-
 include/linux/kvm_host.h                      |  18 ++
 include/uapi/linux/kvm.h                      |   8 +
 include/uapi/linux/magic.h                    |   1 +
 mm/secretmem.c                                |   9 +-
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../testing/selftests/kvm/guest_memfd_test.c  |  43 ++++
 .../testing/selftests/kvm/include/kvm_util.h  |  31 +++
 .../kvm/x86/private_mem_migrate_tests.c       |  93 ++++++++
 .../selftests/kvm/x86/sev_migrate_tests.c     |  48 ++--
 virt/kvm/guest_memfd.c                        | 225 +++++++++++++++---
 virt/kvm/kvm_main.c                           |  17 +-
 virt/kvm/kvm_mm.h                             |  14 +-
 19 files changed, 697 insertions(+), 159 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/private_mem_migrate_tes=
ts.c

--=20
2.49.0.1101.gccaa498523-goog


