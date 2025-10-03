Return-Path: <linux-kselftest+bounces-42743-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5775EBB836E
	for <lists+linux-kselftest@lfdr.de>; Fri, 03 Oct 2025 23:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C9603C7C36
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Oct 2025 21:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460EF26FDB2;
	Fri,  3 Oct 2025 21:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4it4l2f+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2240926C393
	for <linux-kselftest@vger.kernel.org>; Fri,  3 Oct 2025 21:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759527280; cv=none; b=IlJws9PVZfYXa0Ynl9reoxfFHUcDlfjrjVwvUXaNsGGqYrCyRnjC3t9ouARokynGlikzrEuTOKin0Hsk9kiRhjuAyczm4GedXHdwbhHYjcsjf+E59KxQ3UVqc9oc1Bih/sWQWgFru6OpqJ6WwonQVJtinnrxSLeZB/ocsK94ICk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759527280; c=relaxed/simple;
	bh=i2NrTqq/SkzZHBEgQ7eO1+wlsUWMi9F4A/jiIevvQwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IegLFIb3ID54gw0HULdMahV33pcx89PV9PPa2g/Kh/p9TWqyIwy452B62yH6pJ5fV17+53DR1rcQSPqHeEgnqR/gpEucYSMizWVUtUqbub6rw8QAxTxWkFSPPfwpGOu58b4auMGSxCM4MagBl6PTrdd5KKj/w7jWNTxw9YnuIEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4it4l2f+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e3bcf272aso19135e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Oct 2025 14:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759527275; x=1760132075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AolOsZu5isQ6acd/8wA384z0bhlwgTK8nhLOayCIhiU=;
        b=4it4l2f+4qMmRp6nM0+0wbgkH1qyspj7CkB26kKzkuLPHWY4c2HB4DXztN9U1RvWr+
         /1nq507aj8Uw1ZUb7vY1eAYWPgnNFKAA4Mk9uiKV4kpvBgvBYBZLKHJBd0T9plsuhxRp
         T8Iv0zqmoTs7lmTb9IWaYailaq5iyLutUcgd587p1/RKjIy1vOBvUVBlLB8uFVQnh+8F
         rFKSWP6iMrM2oRo+XruVkU1X3ntSQ32fqjh6kGy3kV3BFJzdMG9CdMwB2LyDqnV09nqW
         b1Ar8ygyvt/eGrHYgr4q0xHFhpLsqCRv1jPk84RdcUN8OmIdRS5g5f2g0U6tHNlGyhbl
         lBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759527275; x=1760132075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AolOsZu5isQ6acd/8wA384z0bhlwgTK8nhLOayCIhiU=;
        b=xSFJF4F5Yyt6E1fvmQ5EHWaDaqfciVUPxjE9XLnjGKTjZc8yV5yt3BXwt3cMWUWm8m
         Us5mlN31bLt7LR9wJV9tvFRjxpCgCqqpYpMDrJvc++0ki4W6WIN53kT4G8JXv7rw6vka
         UQFZXw1pOkPwbrRLS/O8bUUrrzTiQz2jmZ9iMX/GRHZQTt77zp6+mduyIY3Z6nrRa6jT
         S6Gz+QPWbFV4oTSL0vwCfkYHqM/cD4OKqK4x2OkIinMTvOnilQsyEizgX4xixc9uZaAq
         IjKSScrZ/ax/hM1qtI/DUgbkxX+6wi533iiOo3S/t1G/uljaZCB1SV9E89awyTu0ABG/
         OALg==
X-Forwarded-Encrypted: i=1; AJvYcCVYhvshTDk9IMIkkPibV4qBlD0Z9mnKgZwOe93zQd4rKotKzKiV4RolbwzAoZO3ZjlUsTLCLFzhyrlHAaIHFDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSDGB5ZywGqe4bqLi3q6Ga40gBrc4j73R8yLuwXBACtVFkcin/
	/I6WWqZ9ke6/+tEUdKx/kvr6fOJln5ryM+m6xJC2/MepcvgjcDikATuq/g9G15eylU0ciLYJLQG
	F+g9SroTSBBmYaCpjtIlSXK1ksrxHBIb/j319m+Dz
X-Gm-Gg: ASbGncva48Pc/t67PJ0PBD/aEBGcNMxInVDpi4tPTK2dL6VLG0Ef7WTgVW7tHnVVjwB
	xWN84cIOLmy2Wb6STycfPTdt7bTArJGhLTE1AAs950i/1I0Nr0te2UblvciXd0oPm2sLGwq2d7R
	wVUgPRNB0r12VnzG6zuUzk53RKOptUOpjmRfae72YRd6ZPpM6lUpwo67kyzX7S3mGyeSTAyPcru
	WM2dq9wtycaVn6Xb7K7emHbLQb1Cv4o42DQZ1XdsEQ4Nyfo/0B5Yye8FJiyjpihehrCBWF1kFIB
	gNE=
X-Google-Smtp-Source: AGHT+IG+g888nHbRtas0R01E+jPK4UfBpLJ8GQnOWINQky6xv5HWVReEjuHHu18tH8G5o/mleUJVD+7aBJEJSt2Urkg=
X-Received: by 2002:a05:600c:8582:b0:45f:2e6d:ca01 with SMTP id
 5b1f17b1804b1-46e789ad00amr340925e9.4.1759527275228; Fri, 03 Oct 2025
 14:34:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731205844.1346839-1-jiaqiyan@google.com>
In-Reply-To: <20250731205844.1346839-1-jiaqiyan@google.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Fri, 3 Oct 2025 14:34:23 -0700
X-Gm-Features: AS18NWC200qL2INhmKRcSigwRYSlRaKCFejFFI6CifV04SzXltQ6LUTRzublc7I
Message-ID: <CACw3F51QG70YpSfWaj_gQjAwoPcZ6uFa5dfd+Ave5PxQYDt-Ew@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] VMM can handle guest SEA via KVM_EXIT_ARM_SEA
To: maz@kernel.org, oliver.upton@linux.dev
Cc: joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	catalin.marinas@arm.com, will@kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	shuah@kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	duenwen@google.com, rananta@google.com, jthoughton@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marc, Oliver, and other upstream friends, can you help review this
patch series? I would really appreciate any comments and feedback.

[sorry for resending, as previous msg was sent as HTML]



On Thu, Jul 31, 2025 at 1:58=E2=80=AFPM Jiaqi Yan <jiaqiyan@google.com> wro=
te:
>
> Problem
> =3D=3D=3D=3D=3D=3D=3D
>
> When host APEI is unable to claim a synchronous external abort (SEA)
> during guest abort, today KVM directly injects an asynchronous SError
> into the VCPU then resumes it. The injected SError usually results in
> unpleasant guest kernel panic.
>
> One of the major situation of guest SEA is when VCPU consumes recoverable
> uncorrected memory error (UER), which is not uncommon at all in modern
> datacenter servers with large amounts of physical memory. Although SError
> and guest panic is sufficient to stop the propagation of corrupted memory=
,
> there is room to recover from an UER in a more graceful manner.
>
> Proposed Solution
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The idea is, we can replay the SEA to the faulting VCPU. If the memory
> error consumption or the fault that cause SEA is not from guest kernel,
> the blast radius can be limited to the poison-consuming guest process,
> while the VM can keep running.
>
> In addition, instead of doing under the hood without involving userspace,
> there are benefits to redirect the SEA to VMM:
>
> - VM customers care about the disruptions caused by memory errors, and
>   VMM usually has the responsibility to start the process of notifying
>   the customers of memory error events in their VMs. For example some
>   cloud provider emits a critical log in their observability UI [1], and
>   provides a playbook for customers on how to mitigate disruptions to
>   their workloads.
>
> - VMM can protect future memory error consumption by unmapping the poison=
ed
>   pages from stage-2 page table with KVM userfault [2], or by splitting t=
he
>   memslot that contains the poisoned pages.
>
> - VMM can keep track of SEA events in the VM. When VMM thinks the status
>   on the host or the VM is bad enough, e.g. number of distinct SEAs
>   exceeds a threshold, it can restart the VM on another healthy host.
>
> - Behavior parity with x86 architecture. When machine check exception
>   (MCE) is caused by VCPU, kernel or KVM signals userspace SIGBUS to
>   let VMM either recover from the MCE, or terminate itself with VM.
>   The prior RFC proposes to implement SIGBUS on arm64 as well, but
>   Marc preferred KVM exit over signal [3]. However, implementation
>   aside, returning SEA to VMM is on par with returning MCE to VMM.
>
> Once SEA is redirected to VMM, among other actions, VMM is encouraged
> to inject external aborts into the faulting VCPU.
>
> New UAPIs
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> This patchset introduces following userspace-visible changes to empower
> VMM to control what happens for SEA on guest memory:
>
> - KVM_CAP_ARM_SEA_TO_USER. While taking SEA, if userspace has enabled
>   this new capability at VM creation, and the SEA is not owned by kernel
>   allocated memory, instead of injecting SError, return KVM_EXIT_ARM_SEA
>   to userspace.
>
> - KVM_EXIT_ARM_SEA. This is the VM exit reason VMM gets. The details
>   about the SEA is provided in arm_sea as much as possible, including
>   sanitized ESR value at EL2, faulting guest virtual and physical
>   addresses if available.
>
> * From v2 [4]:
>   - Rebased on "[PATCH] KVM: arm64: nv: Handle SEAs due to VNCR redirecti=
on" [5]
>     and kvmarm/next commit 7b8346bd9fce ("KVM: arm64: Don't attempt vLPI
>     mappings when vPE allocation is disabled")
>   - Took the host_owns_sea implementation from Oliver [6, 7].
>   - Excluded the guest SEA injection patches.
>   - Updated selftest.
>
> * From v1 [8]:
>   - Rebased on commit 4d62121ce9b5 ("KVM: arm64: vgic-debug: Avoid
>     dereferencing NULL ITE pointer").
>   - Sanitize ESR_EL2 before reporting it to userspace.
>   - Do not do KVM_EXIT_ARM_SEA when SEA is caused by memory allocated to
>     stage-2 translation table.
>
> [1] https://cloud.google.com/solutions/sap/docs/manage-host-errors
> [2] https://lore.kernel.org/kvm/20250109204929.1106563-1-jthoughton@googl=
e.com
> [3] https://lore.kernel.org/kvm/86pljbqqh0.wl-maz@kernel.org
> [4] https://lore.kernel.org/kvm/20250604050902.3944054-1-jiaqiyan@google.=
com/
> [5] https://lore.kernel.org/kvmarm/20250729182342.3281742-1-oliver.upton@=
linux.dev/
> [6] https://lore.kernel.org/kvm/aHFohmTb9qR_JG1E@linux.dev/#t
> [7] https://lore.kernel.org/kvm/aHK-DPufhLy5Dtuk@linux.dev/
> [8] https://lore.kernel.org/kvm/20250505161412.1926643-1-jiaqiyan@google.=
com
>
> Jiaqi Yan (3):
>   KVM: arm64: VM exit to userspace to handle SEA
>   KVM: selftests: Test for KVM_EXIT_ARM_SEA
>   Documentation: kvm: new UAPI for handling SEA
>
>  Documentation/virt/kvm/api.rst                |  61 ++++
>  arch/arm64/include/asm/kvm_host.h             |   2 +
>  arch/arm64/kvm/arm.c                          |   5 +
>  arch/arm64/kvm/mmu.c                          |  68 +++-
>  include/uapi/linux/kvm.h                      |  10 +
>  tools/arch/arm64/include/asm/esr.h            |   2 +
>  tools/testing/selftests/kvm/Makefile.kvm      |   1 +
>  .../testing/selftests/kvm/arm64/sea_to_user.c | 327 ++++++++++++++++++
>  tools/testing/selftests/kvm/lib/kvm_util.c    |   1 +
>  9 files changed, 476 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/kvm/arm64/sea_to_user.c
>
> --
> 2.50.1.565.gc32cd1483b-goog
>

