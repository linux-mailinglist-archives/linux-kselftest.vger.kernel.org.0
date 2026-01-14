Return-Path: <linux-kselftest+bounces-48900-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDDDD1BD2E
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 01:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 316D7304A913
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 00:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348A321B191;
	Wed, 14 Jan 2026 00:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pRgcmhdN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979F61FDE14
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Jan 2026 00:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768350726; cv=pass; b=qjvrW21r8KXEbCLVkwy0UggcbtnDKkb7vHuPUrimyZVflhx5kQV52nBhamUp6//GQhCAe+S2D5FlDBOTblGeDwKJvBRwk5Tutb/0pjpN4/V5zT4H6UdnDrp8+NM/YyyreLOAzR8/u9AS9SyCSZZjGT5E7juUk4Vnh8Jdz17v6v8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768350726; c=relaxed/simple;
	bh=a6wUaDtICNxo6H184CHsvJN3aC8Z20MkNZw3ko+zU/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=GFkk8saVbO51wgpv+GVCd5gW7ncyRK7kBkNWkNO94alWaIttJg3hT0G6C2SEU3oJlwRQvRkP1Oyps4ND6Jw4G/EdZIwGBmU3p8ftES+RCz+0GAFTZUq5oUOz2ulG4cwd4Mw11QflZXrsNE5QSkD4St/eIj1uFV6FLcBETGRrU6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pRgcmhdN; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-652fe3bf65aso2164a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 16:32:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768350723; cv=none;
        d=google.com; s=arc-20240605;
        b=YEjStkh1a+Wn1b1sJnSxagU73pC2X3+Snhu3lwW+F5AcOIxBQig7E4DPe/B4U2beNR
         P9QPgOfg6yuxH9XkN+p2+lLOhQUzai1vxlbvpvi3gkPrOvVO79qc15r/HxtCVtFcvgK9
         bvIhEc/Oy0m5JSJ1Wo+0T2pvRxvzh/ecrwT5rve4Or4eI0o5gZCZjx7HXXkdHSLK/NL0
         v/r8/tIg30CXa1SPFpRUT4MjEojvokpKO65DHixK0mC3RlQNYD2/WOv1tO7Ls0jvWZrV
         B/2MtiJLXjm53Q8vqDX0EBM/VOfm0dASht7zszZvM9+gQwxeLDgnaVOLc/BNXNA6ketu
         yyyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a6wUaDtICNxo6H184CHsvJN3aC8Z20MkNZw3ko+zU/g=;
        fh=wX0FXt2eitLoRA2IHI8GxQDDujQt4Wi3jrNkpfSvUxs=;
        b=eOEQtykuYYW5t+rutTELQi77L7B1losj5mTkByy09DMayw4+cwlbIsXmmgHziBvXDE
         dWfDM4sNWo+ub7sLCZ92sMjzlyIdXtPl2x2eDDLu+NHeO8tNl54sCA66nSxq5zM81GOg
         Be+y4gt9vMVG2hsZNT1vKZ7m10qzGD9X9iW1HgCZ2XdrziORUToxSdUdx45QOCUyifZV
         XoZBDTdE3Qp+aKu1X1bZrFF2mvk6ru/skZ+HJp8eEfpqcTR4joyAucGSMETDatrRZanF
         LvhXb/E9gMOuT2moGAsYZ4Hm0QfgB62Sq04arZcsU+GKIz1rRksidwhXWr16kw4n6D7W
         I1cQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768350723; x=1768955523; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6wUaDtICNxo6H184CHsvJN3aC8Z20MkNZw3ko+zU/g=;
        b=pRgcmhdNUPbOibNcTKb9+S6YJQ+JT0Wi8eT/qOihKLblaBSZa0CvQ1J+nS5rwVXLBf
         A+K+yLvG4bOr8OxwQ844Q0uv0efk+K8sG/nzIbWwWco1yQjAzsfx8t+MvSHgwzJLn+gq
         LBMlyEV+e342uFRvv4CsOQDHni2LXnRwzncnL/xjFlJL3UvAjw12dKG+n7eYMnkmNt/F
         /V+A8eBoYJnHA+4UlXa9RTgAKozxqsNtL7jsUDXkX2ViLSeNnjwiCXLGjYoMK5RujEx0
         6Rpx0TttJBmiCsp5SwoMLVxyF+6CJiJcQufYnUwUqwFufIafD+QEoynmEY2WP7KzxxQH
         B8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768350723; x=1768955523;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a6wUaDtICNxo6H184CHsvJN3aC8Z20MkNZw3ko+zU/g=;
        b=YcFw77O3aybzdKpaVXXBtDx6u/oqo091XsYoP5dOLsTy18iC6yU9FrJvUk2KElITyD
         CUfiEEEQqVYEzH9lKSI3t65NKsbecg2aRCHXxuyXp0FM3BfOwFBFadlrD1qyAMXvzxpG
         +Q/+tuvJB6uLCb6ETeKxnWXEmC0frRtJnGDTFT4eAtex+9AcgM94pGix81BIBaUJVCLa
         gODKFPK25QIsTBRg/Szw9kCughzH/MwRwqCBiwFGwg/R5u2ZfQVKKma0gJpIGtLw9YRH
         aESEnesV+w5gVkK7nNCizy3kU0O3CajtfTiR/4DVU+SP9uimK59Jsf4JASJDzGkNTaGv
         PKKg==
X-Forwarded-Encrypted: i=1; AJvYcCUzjnYvM3Py2q+pyggbuEJ7sGOjwRaIXreSP2biYiYca+L6Cxa0bCOL1RPkooGdP2j787mh2sEKS2coNAOmrUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3ibxmKAlHLbn8TNLGvahRG356mn4vE9G6NVWIGRRf+HGITzT9
	si0NiNqB+shj5BW2Lh0TMl5TTGOy8x869uN3L+a7zeLjM28pvnVaUkRdzqS4a6Fj3soHlgCcEK/
	wKQAxa8E5gHZ7WyiGOoWEDW8UEDutqSRJi+/O4Gt+
X-Gm-Gg: AY/fxX4kTlmhaVGIfhz6+BkQd+KbV9qD9lWWMEi9KVcZfwiohVJ3UNJg46eJVOf2yqj
	JD28UQ1M6rrGJ59i4FNDcyzemcyYHar/mcR9KVe0+K6+Jm0gU3BJnZmGJds2DqD1eBmA5CUjlqB
	0iNGJ6URJHOQUznvD5rvWtes/3tuOdz1vY8UUqqgNPrgH+nQjBHyQtLlaDSrZIHgIRfq18FaJUH
	P2OxhQi15Ucw9F2i4jDDKxu7iYCDmLiz8cZskz6CPX8cZOVZJC8dJqMC5XZrTYhoDjbJeo=
X-Received: by 2002:aa7:d399:0:b0:640:4aeb:b4d3 with SMTP id
 4fb4d7f45d1cf-653eb8b91e0mr16246a12.2.1768350722680; Tue, 13 Jan 2026
 16:32:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113003016.3511895-1-jmattson@google.com>
In-Reply-To: <20260113003016.3511895-1-jmattson@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 13 Jan 2026 16:31:50 -0800
X-Gm-Features: AZwV_Qj48k15LymrU0ga_vbUw3bTYYBlGdp6Pdii9Imxn230GNLk5A_U70QLjgs
Message-ID: <CALMp9eTLS6_HhWTkf-baga77=0zNq6KUBYtvY0WNuGs3ts2Ptw@mail.gmail.com>
Subject: Re: [PATCH 00/10] KVM: x86: nSVM: Improve PAT virtualization
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Avi Kivity <avi@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, 
	David Hildenbrand <david@kernel.org>, Cathy Avery <cavery@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 4:30=E2=80=AFPM Jim Mattson <jmattson@google.com> w=
rote:
>
> KVM's implementation of nested SVM treats PAT the same way whether or
> not nested NPT is enabled: L1 and L2 share a PAT.
>
> This is correct when nested NPT is disabled, but incorrect when nested
> NPT is enabled. When nested NPT is enabled, L1 and L2 have independent
> PATs.

Yosry points out that this series does not correctly handle saving a
checkpoint on a new kernel and restoring it on an old kernel. In that
scenario, KVM_SET_MSRS will restore the L2 PAT, and the old kernel
will not restore L1's PAT on emulated #VMEXIT.

I have also discovered that not all userspace VMMs restore MSRs before
nested state.

Ironically, I think the way to correctly deal with compatibility in
both directions is to go back to the architected separation of hPAT
and gPAT. Accesses to IA32_PAT from userspace will always have to
reference hPAT to properly restore a new checkpoint on an old kernel.

Cooking up v2...

