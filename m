Return-Path: <linux-kselftest+bounces-5040-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2555885C068
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 16:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A3B51C2207C
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 15:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7CC762FB;
	Tue, 20 Feb 2024 15:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p2EhsI2l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117796A8A9
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 15:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708444546; cv=none; b=E2FZfldQkdjPeOXP5XdlFoeFJPUIiTbJo2AZgkkGvdtvKzyfj3iLPtS3zLjj5g/rU2K/8IIjTcmY71+wm1VH98sPeAwsSvO7E6IPgtpv/gJCIbo9EZQVb7g5l9nZyazE/J93fNXZXyfs3fQFyaOoxI7KzUl83yDDffgiNOwfZ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708444546; c=relaxed/simple;
	bh=Kz0GA9Y94W0SFhelWwox2nUv5tXBxEbev4X5jMa+djk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=dWHl9KTzRTzVW55eZ5yR0w3Sawj7gCmBjm3U3omHN2N2khFiX4+N8O/D97CwGnJW8v3i/ph+yYFr+FgUkYCWk2BeB9MWx4uIChlivEvGu914cdOXJJPVVvGuTPG9cuCmgmdQSu09YUD35xDZrS4TKWuZKeIjjVkBu7VRVP1JdWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p2EhsI2l; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60770007e52so59536407b3.1
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 07:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708444543; x=1709049343; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nkZ1YNi4HdlEBdTOsrosj2I/p2QRJpg3Qe1Xk4lNWF0=;
        b=p2EhsI2lVDdB7akSjITmV+58d9qTKwuMEdrSp3830ZiHSdU0mDJR+gTOMen74z130I
         R3iz4/oR8riFKKW7Eqeu06w77IeKsZC0d+W5tJD1PJSNQCl0+cP+uhMDc/w7DRefN2ne
         aQW3r8DfSGG1ZLO4NutXsF0wdIdY0QvVSRJWyjf6Go4P4gZRQH01amUDHTVfmMJhd/BW
         rhi1bD9k+EYoXy6/LTbqW8I2LRS0DmlN6E00DuLWi/9v5DVOLfA/XHBECVhYvZfGAs0Q
         0Q4jtgtN6XONO37Tlus7+J4PnzB2v7eUspOwU3r12hMZZJ0HR4dyzziUpyxEM9D1R7bN
         4NJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708444543; x=1709049343;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nkZ1YNi4HdlEBdTOsrosj2I/p2QRJpg3Qe1Xk4lNWF0=;
        b=wrxT13w6nQCgaQ6xRy+Kb5M5rcXgqvx6YRJaro1QzCeYkqo4PWO5bD6dlriCvYocTe
         IhZ+bwoJDj+qiSUjm+v4tiFv3uieRWPWzKIxnO5UZWgrWMVZdJu0caYipWl1Fcnrtqs+
         uOd2Abgw2hP8ns3pfF5+rPt8cD+oN/Tn0bqkNcV+phmuilj9rqvPVC8NT9iwT3bId2He
         YzW08ve1KFeTIqD/5w1OHgTaC1nXE5pElxtjT6hLedEn4YdR9S04W4lYyCgb7dOEE16W
         Rj2yQzo1I+0H70T7aaXVAOLZD2HZFwlIDfLgDVBrh0HL382fR90LmUoUK+TfyC3iEgBj
         jZ/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUrigmYKvU5yx3pAlflMY56qlupzeEmrAov3VFW7fvYXMBg578VWfRv6ACMGCgdqb5qhymnfAIEU3/W9lnvhbEF/WM1igoyEVE3d3ZOtQC
X-Gm-Message-State: AOJu0YxuRO0dEIvniNaoCBX3ybeaCrEVtNifyEZoOeHHnprewY1DHAIF
	8JDOwlawww/BbhdIeSCagylBJgRajH97+Yq2PaK2heOVSPQi0Q5/HET+pxWWSjR9hHcVyEPrPCO
	IUA==
X-Google-Smtp-Source: AGHT+IF1JkxDWJLA5wtljU6ntRBClVsQ/F9GLWL8bomcPlRftmO9ep/YZ1ByFg2cif0LNqgTe/Rychu4wWM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:ee0a:0:b0:608:66be:2f71 with SMTP id
 l10-20020a81ee0a000000b0060866be2f71mr302250ywm.9.1708444543193; Tue, 20 Feb
 2024 07:55:43 -0800 (PST)
Date: Tue, 20 Feb 2024 07:55:13 -0800
In-Reply-To: <20240215152916.1158-1-paul@xen.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240215152916.1158-1-paul@xen.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <170838297541.2281798.7838961694439257911.b4-ty@google.com>
Subject: Re: [PATCH v13 00/21] KVM: xen: update shared_info and vcpu_info handling
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	David Hildenbrand <david@redhat.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw2@infradead.org>, Shuah Khan <shuah@kernel.org>, 
	kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Paul Durrant <paul@xen.org>
Content-Type: text/plain; charset="utf-8"

On Thu, 15 Feb 2024 15:28:55 +0000, Paul Durrant wrote:
> From: Paul Durrant <pdurrant@amazon.com>
> 
> This series contains a new patch from Sean added since v12 [1]:
> 
> * KVM: s390: Refactor kvm_is_error_gpa() into kvm_is_gpa_in_memslot()
> 
> This frees up the function name kvm_is_error_gpa() such that it can then be
> re-defined in:
> 
> [...]

*sigh*

I forgot to hit "send" on this yesterday.  But lucky for me, that worked out in
my favor as I needed to rebase on top of kvm/kvm-uapi to avoid pointless conflicts
in the uapi headeres.

So....

Applied to kvm-x86 xen, minus 18 and 19 (trylock stuff) and 21 (locking cleanup
that we're doing elsewhere).

Paul and David, please take (another) look at the end result to make sure you don't
object to any of my tweaks and that I didn't botch anything.

s390 folks, I'm applying/pushing now to get it into -next asap, but I'll make
sure to get acks/reviews on patch 08/21 before I do anything else with this
branch/series.

Thanks!

[01/21] KVM: pfncache: Add a map helper function
        https://github.com/kvm-x86/linux/commit/f39b80e3ff12
[02/21] KVM: pfncache: remove unnecessary exports
        https://github.com/kvm-x86/linux/commit/41496fffc0e1
[03/21] KVM: x86/xen: mark guest pages dirty with the pfncache lock held
        https://github.com/kvm-x86/linux/commit/4438355ec6e1
[04/21] KVM: pfncache: add a mark-dirty helper
        https://github.com/kvm-x86/linux/commit/78b74638eb6d
[05/21] KVM: pfncache: remove KVM_GUEST_USES_PFN usage
        https://github.com/kvm-x86/linux/commit/a4bff3df5147
[06/21] KVM: pfncache: stop open-coding offset_in_page()
        https://github.com/kvm-x86/linux/commit/53e63e953e14
[07/21] KVM: pfncache: include page offset in uhva and use it consistently
        https://github.com/kvm-x86/linux/commit/406c10962a4c
[08/21] KVM: s390: Refactor kvm_is_error_gpa() into kvm_is_gpa_in_memslot()
        https://github.com/kvm-x86/linux/commit/9e7325acb3dc
[09/21] KVM: pfncache: allow a cache to be activated with a fixed (userspace) HVA
        https://github.com/kvm-x86/linux/commit/721f5b0dda78
[10/21] KVM: x86/xen: separate initialization of shared_info cache and content
        https://github.com/kvm-x86/linux/commit/c01c55a34f28
[11/21] KVM: x86/xen: re-initialize shared_info if guest (32/64-bit) mode is set
        https://github.com/kvm-x86/linux/commit/21b99e4d6db6
[12/21] KVM: x86/xen: allow shared_info to be mapped by fixed HVA
        https://github.com/kvm-x86/linux/commit/10dcbfc46724
[13/21] KVM: x86/xen: allow vcpu_info to be mapped by fixed HVA
        https://github.com/kvm-x86/linux/commit/16877dd45f98
[14/21] KVM: selftests: map Xen's shared_info page using HVA rather than GFN
        https://github.com/kvm-x86/linux/commit/95c27ed8619b
[15/21] KVM: selftests: re-map Xen's vcpu_info using HVA rather than GPA
        https://github.com/kvm-x86/linux/commit/5359bf19a3f0
[16/21] KVM: x86/xen: advertize the KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA capability
        https://github.com/kvm-x86/linux/commit/49668ce7e1ae
[17/21] KVM: x86/xen: split up kvm_xen_set_evtchn_fast()
        (not applied)
[18/21] KVM: x86/xen: don't block on pfncache locks in kvm_xen_set_evtchn_fast()
        (not applied)
[19/21] KVM: pfncache: check the need for invalidation under read lock first
        https://github.com/kvm-x86/linux/commit/21dadfcd665e
[20/21] KVM: x86/xen: allow vcpu_info content to be 'safely' copied
        https://github.com/kvm-x86/linux/commit/dadeabc3b6fa
[21/21] KVM: pfncache: rework __kvm_gpc_refresh() to fix locking issues
        (not applied)

--
https://github.com/kvm-x86/linux/tree/next

