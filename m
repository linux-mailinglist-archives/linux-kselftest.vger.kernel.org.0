Return-Path: <linux-kselftest+bounces-48807-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 126DBD15FE7
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 01:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95A1F30299C2
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 00:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B71723BF9B;
	Tue, 13 Jan 2026 00:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yzge7/5h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BAF19D092
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 00:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768264239; cv=none; b=h0bmJKDL1XrlggxMVbkK1qWSvJnaMwCaiB6tQWtK5GvWeepZYYbH7R7QeLwvgk9bWGqxfofGkJKu2muYxqgLSrwsvQ1Z7jBtYI71b+wwJc9UjzhWHve/AMVkLfq5Q43LzczYeaAWSG8KWEkBBJ4bQZ1Pna90taVRggKVRvIRsMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768264239; c=relaxed/simple;
	bh=Z55azhBqb+eYmuyst7BrcTN2e+iwhv1VBIGSzB2TzsU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SRxJUM1vZIjLBDR8bFSrefaBMigxLiN/kyeWvgZNetCoCLwtcFW0zg0+NFqtFlr1U1jelQzAXvOCTP5wd0RHLNuE4xV4k2DDpGEOTQXod/FK9cwrZbIXSvzsuFiuBVyUdGvf+Ujd5L0SGq/6euhwiiL6nyG/8v97d5kgmhwGmJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yzge7/5h; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34e5a9f0d6aso5240943a91.0
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 16:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768264236; x=1768869036; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tTGelH1EjMWzWWpPI7L+r4iRVRFfJX23VrUbdCcWEwY=;
        b=Yzge7/5heNHiX/Qjf1ZR9NJ4k0QZ/s4+Ovkc60bLZU1EYne+VvIbkpjSkEnjb8lVTQ
         XVv+U3zW11B0St0r7c8wu+zzELinyP4mxXgEDF6+uU1K1qqoNnb09PzoKhy7FBs9xbTP
         mF75E5JNJD2Dond3mWZ3bVVO/yf4S7Ynl54ty+JCfEdgjBjkOgOfldjLimz+rz1F41yE
         RO4iYjeWTX79qtWDWS6PGvxc7oeoDTB/KVIZOPPucw5vM9j5Fz6K1QUwIhddpchrUA+U
         MD33yO7l59qZLB8cqcl7+Mg3aS5tnUkevm5sVlGhIVYfzFdWDN+OIjNMAv9MyLJ9ITpk
         FRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768264236; x=1768869036;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tTGelH1EjMWzWWpPI7L+r4iRVRFfJX23VrUbdCcWEwY=;
        b=Z/xlCgr8CTxJUKrkosLjnC14MoGTzdAaPMoV/I8wYY2mmcyQetLigUWPlLdG2MCuUS
         2njYMXwaZodDuBVZ6Zg+3aiXkNpedmwvb1AMKmSoscfEHgXXRg25huCVugowwSZxCOP7
         H20u/yRShd9OaPTlOxfv0DeLjprnLcIgoZatORT8R0EQzfur7+Vi1ZI7ra9zyMbOyv3u
         R6xbnZbqoMh0G4ALMZMqxnS0qSR3R0dBzu+5I0Ajt3mULB/kgTFvwG9vbVjQUmTzei6G
         VT70qyVbdxylpeGF2xpFt/KNgiNmMyIbmEOt6FdpkM09C5ajIS7rpOIx+7+6CJHKrZwu
         V+qQ==
X-Forwarded-Encrypted: i=1; AJvYcCW++4/8+VjY0P5Sqf6CjpGrx+JeokZ7i7/MchMQ8p4uQLK69XMbX6yWJAKwDBTsx4WpvKk8NgC89X72OHHSpZk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt57CLNgka7PySEURO6I8BpjlvmOLSJ2AiM09CjeB5FZv4ecOe
	DOkqJtPL5fgFjma3Rn9srS9Li5QbFVzJ4uilifES8/plpHdqD41SOByGkJBI8siNsBRIZW0mKMn
	jDz/236H2GQhLQw==
X-Google-Smtp-Source: AGHT+IENkMl8pjN3xq/gUoO6a727rAcJVu3CiOBxXc3YxC6E+VpQFzDU6ky3j8dX95NrKpzdsK4WBAWf3VBi4Q==
X-Received: from pjbch23.prod.google.com ([2002:a17:90a:f417:b0:34c:d9a0:3bf6])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:17ce:b0:32e:72bd:6d5a with SMTP id 98e67ed59e1d1-350fd12c181mr990901a91.1.1768264236116;
 Mon, 12 Jan 2026 16:30:36 -0800 (PST)
Date: Mon, 12 Jan 2026 16:29:55 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260113003016.3511895-1-jmattson@google.com>
Subject: [PATCH 00/10] KVM: x86: nSVM: Improve PAT virtualization
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Avi Kivity <avi@redhat.com>, Alexander Graf <agraf@suse.de>, 
	"=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>, David Hildenbrand <david@kernel.org>, Cathy Avery <cavery@redhat.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

KVM's implementation of nested SVM treats PAT the same way whether or
not nested NPT is enabled: L1 and L2 share a PAT.

This is correct when nested NPT is disabled, but incorrect when nested
NPT is enabled. When nested NPT is enabled, L1 and L2 have independent
PATs.

The architectural specification for this separation is unusual. There
is a "guest PAT register" that is accessed by references to the PAT
MSR in guest mode, but it is different from the (host) PAT MSR. Other
resources that have distinct host and guest values have a shared
storage location, and the values are swapped on VM-entry/VM-exit.

In
https://lore.kernel.org/kvm/20251107201151.3303170-1-jmattson@google.com/,
I proposed an implementation that adhered to the architectural
specification. It had a few warts. The worst was the necessity of
"fixing up" KVM_SET_MSRS when executing KVM_SET_NESTED_STATE if L2 was
active and nested NPT was enabled when a snapshot was taken. Aside
from Yosry's clarification, no one has responded. I will take silence
to imply rejection. That's okay; I wasn't fond of that implementation
myself.

The current series treats PAT just like any other resource with
distinct host and guest values. There is a single shared storage
location (vcpu->arch.pat), and the values are swapped on
VM-entry/VM-exit. Though this implementation doesn't precisely follow
the architectural specification, the guest visible behavior is the
same as architected.

The first three patches ensure that the vmcb01.g_pat value at VMRUN is
preserved through virtual SMM and serialization. When NPT is enabled,
this field holds the host (L1) hPAT value from emulated VMRUN to
emulated #VMEXIT.

The fourth patch restores (L1) hPAT value from vmcb01.g_pat at
emulated #VMEXIT. Note that this is not architected, but it is
required for this implementation, because hPAT and gPAT occupy the
same storage location.

The next three patches handle loading vmcb12.g_pat into the (L2) guest
PAT register at VMRUN. Most of this behavior is architected, but the
architectural specification states that the value is loaded into the
guest PAT register, leaving the hPAT register unchanged.

The eighth patch stores the (L2) guest PAT register into vmcb12_g_pat
on emulated #VMEXIT, as architected.

The ninth patch fixes the emulation of WRMSR(IA32_PAT) when nested NPT
is enabled.

The tenth patch introduces a new KVM selftest to validate virtualized
PAT behavior.

Jim Mattson (10):
  KVM: x86: nSVM: Add g_pat to fields copied by svm_copy_vmrun_state()
  KVM: x86: nSVM: Add VALID_GPAT flag to kvm_svm_nested_state_hdr
  KVM: x86: nSVM: Handle legacy SVM nested state in SET_NESTED_STATE
  KVM: x86: nSVM: Restore L1's PAT on emulated #VMEXIT from L2 to L1
  KVM: x86: nSVM: Cache g_pat in vmcb_save_area_cached
  KVM: x86: nSVM: Add validity check for VMCB12 g_pat
  KVM: x86: nSVM: Set vmcb02.g_pat correctly for nested NPT
  KVM: x86: nSVM: Save gPAT to vmcb12.g_pat on emulated #VMEXIT from L2
    to L1
  KVM: x86: nSVM: Fix assignment to IA32_PAT from L2
  KVM: selftests: nSVM: Add svm_nested_pat test

 arch/x86/include/uapi/asm/kvm.h               |   3 +
 arch/x86/kvm/svm/nested.c                     |  74 +++-
 arch/x86/kvm/svm/svm.c                        |  14 +-
 arch/x86/kvm/svm/svm.h                        |   2 +-
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/svm_nested_pat_test.c   | 357 ++++++++++++++++++
 6 files changed, 432 insertions(+), 19 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/svm_nested_pat_test.c


base-commit: f62b64b970570c92fe22503b0cdc65be7ce7fc7c
-- 
2.52.0.457.g6b5491de43-goog


