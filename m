Return-Path: <linux-kselftest+bounces-46392-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C69F0C816B8
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 16:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9B964E5A6A
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 15:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0383148DF;
	Mon, 24 Nov 2025 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BK8KdfI9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808C6314A7B
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Nov 2025 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763999302; cv=none; b=Bmj6uzfEGMzgboNvnEcaWnusW6skE+pEb9c/S79NrBm7ISWW9Pyf00n2dK57lSez7yllmtx+VCBa6OB98InoYWDJwSzaNY5NymS7+YHYms6k9blFIANJxGcxQSVolEAcsfEP29am+XHtrGhrv7YJt0R5AuQ4Yjc/ipP0SECZGLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763999302; c=relaxed/simple;
	bh=k18PGx7b9UQSd+RHbvmvjkc795gJID3d8ne1906zMdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tPM06ENli1NbCzYvgKOJH+s8/JSZBFlqkcKHpNEndKUg/1cTqBciBX/1AwAsuqqkYn2LansPwI18n8oZ+V27X1Z1TuMU8fMNQg0znVY/SonnurpHVVqqeQmJFIS8WsRGkWE8wReBjSjx8/omjMhmJY5sXdSxKPoTHOv5JqPIqkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BK8KdfI9; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-63fc6115d65so3574366d50.0
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Nov 2025 07:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763999298; x=1764604098; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dhe14QqCiQiiyB/p8iyIjb6+UGtDhSJERPBSMqZWZ34=;
        b=BK8KdfI9Cl/taNmr763LKb8oX3RRAe44b0+rxu0p4A+ttReNl6ieICm7ZiB3rUsRt/
         UtAIYiYuVv87KPSsuSBvi/z42xYwLTkOSOgBzOAH10q22JremGKPwdDATwumIq0F2JUO
         Gnc9TxKe3KbCaabyMWfBhGI3XrSx3JOImi2edQnG7wfigPF7fFbRMrGrHDWdwFODheBb
         ZKKOYzbVBi24he1ur13PiADtV8DGXdZ8+GEY4ABUPAlh6EpLMeUkvlIeFVE9ylOhUz0N
         n9TyWFYqNl0bZ+hxy20eB8QxWxlqQGuqYSwcs3E4aO0qDXQ4kr7vBMqRmRNBThbX/kum
         5ggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763999298; x=1764604098;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dhe14QqCiQiiyB/p8iyIjb6+UGtDhSJERPBSMqZWZ34=;
        b=v/6uyilsjG3g6ApAlH3+pyVA9ANSSK9o9U/fP+0uvTJAwut4GqRzBBAB8z5+IVnZnC
         sgBGExOVBanX+T54Q6up91CCovYvPrDHj+CyL1RRpZjnL2WGQRKQJWak63gaN/dd1Mup
         FGtMKrvmWHyyTCYW6zN63TMBUOupRHnsQLDSqe4lq6B5F17pBmWlIi9MEo5Bi+k2pkL8
         6JPhqivnNNzpmJS+Vz5KTbmZ5PGVuS/vX1PdTqOXJ7xgbrvP/QV7fmg4Ys5DGRT87i1X
         eFU5/GxTHMbDa4h4RjG4JGLJV+kmaAfoA1ka8vhmL/wTaUgXcDypfWdgNmOzt/iy75VM
         I+VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO6cVe9b17qwpWh0WRd9+wGsgPpzFcaQID4977O+Wj6mzecfI7orgWMYm1bidxENDwt0N51RkNkTmivwPVbvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqMrK97mNPmlZyUiYSN6H0K9/DljguMbhD1fKLle4XSoFMkuNb
	7NSDwrAmf14+Nef3qYYlu2Nb44qBd95ho3NNuSuw7L1JeX03CmH4rStUBPwFCbeHHJ0cI9zO95T
	DT3/30et8CfIusZDD5bYvjYZ0aM4y3lz3wXGGKYsCrA==
X-Gm-Gg: ASbGncvlOOYmrTWLW7h0S+frlUSFdHdDw/x9kx2ISNIG1b9qi9Gv8p0U1qgzvsl3owc
	onZGiVyp6bMc4dZrcYqxcNLI4l/SuJSLpNvC2fO8iL3zBAh/AqiNPaTxYZT+uCqUb5ybyYLns5o
	DH78oX/cMxe7pC/XtFqhQ/FG7bO4OSL4lfneooq6RJqtTGH7lbo0z4hoZBZqrbQmVbob9ZyDX+1
	3iQ6l5pdJADWtTNrkL/tUqtim3I14e3AMUg6qtdVsTVB1uyRXzMxJ39h58hEkDbUelt8YcMT1Pb
	36LRs+Y=
X-Google-Smtp-Source: AGHT+IFXLeEni9mHEbFQTU/eUct/W0PzmxnSk74uTOG+KIQijx0uZ3p8CfFH9qpt1kJGYDocY45XWQwqsmbH09VD3mM=
X-Received: by 2002:a05:690e:18d:b0:63c:f5a7:40f with SMTP id
 956f58d0204a3-64302acb21dmr6404480d50.67.1763999298028; Mon, 24 Nov 2025
 07:48:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902-kvm-arm64-sme-v8-0-2cb2199c656c@kernel.org> <20250902-kvm-arm64-sme-v8-11-2cb2199c656c@kernel.org>
In-Reply-To: <20250902-kvm-arm64-sme-v8-11-2cb2199c656c@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Nov 2025 15:48:06 +0000
X-Gm-Features: AWmQ_blKJPr9UiZ03PNJYKVppsgjz7HVl46QteqBVXyuwWp-raNgrqIbXILR-YA
Message-ID: <CAFEAcA_GJ7gzn7aMCZYxHnJWvx4tHSHBKsOxtQ7NTb4gPjkMJQ@mail.gmail.com>
Subject: Re: [PATCH v8 11/29] KVM: arm64: Document the KVM ABI for SME
To: Mark Brown <broonie@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
	Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Sept 2025 at 12:45, Mark Brown <broonie@kernel.org> wrote:
>
> SME, the Scalable Matrix Extension, is an arm64 extension which adds
> support for matrix operations, with core concepts patterned after SVE.

Hi; apologies for not having got round to looking at this earlier.

I haven't actually tried writing any code that uses this proposed
ABI, but mostly it looks OK to me. I have a few nits below, but
my main concern is the bits of text that say (or seem to say --
maybe I'm misinterpreting them) that various parts of how userspace
accesses the guest state (e.g. the fp regs) depend on the current
state of the vcpu, rather than being only a function of how the
vcpu was configured. That seems to me like it's unnecessarily awkward.
(More detail below.)

> If SME is enabled for a guest without SVE then the FPSIMD Vn registers
> must be accessed via the low 128 bits of the SVE Zn registers as is the
> case when SVE is enabled. This is not ideal but allows access to SVCR and
> the registers in any order without duplication or ambiguity about which
> values should take effect. This may be an issue for VMMs that are
> unaware of SME on systems that implement it without SVE if they let SME
> be enabled, the lack of access to Vn may surprise them, but it seems
> like an unusual implementation choice.
>
> For SME unware VMMs on systems with both SVE and SME support the SVE
> registers may be larger than expected, this should be less disruptive
> than on a system without SVE as they will simply ignore the high bits of
> the registers.

I think that since enabling SME is something the VMM has to actively
do, it isn't a big deal that they also need to do something in the
fp or sve register access codepaths to handle SME. You can't get
SME by surprise (same as you can't get SVE by surprise).

> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  Documentation/virt/kvm/api.rst | 115 +++++++++++++++++++++++++++++------------
>  1 file changed, 81 insertions(+), 34 deletions(-)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 6aa40ee05a4a..94a22407a1d4 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -406,7 +406,7 @@ Errors:
>               instructions from device memory (arm64)
>    ENOSYS     data abort outside memslots with no syndrome info and
>               KVM_CAP_ARM_NISV_TO_USER not enabled (arm64)
> -  EPERM      SVE feature set but not finalized (arm64)
> +  EPERM      SVE or SME feature set but not finalized (arm64)
>    =======    ==============================================================
>
>  This ioctl is used to run a guest virtual cpu.  While there are no
> @@ -2601,11 +2601,11 @@ Specifically:
>  ======================= ========= ===== =======================================
>
>  .. [1] These encodings are not accepted for SVE-enabled vcpus.  See
> -       :ref:`KVM_ARM_VCPU_INIT`.
> +       :ref:`KVM_ARM_VCPU_INIT`.  They are also not accepted when SME is
> +       enabled without SVE and the vcpu is in streaming mode.

Does this mean that on an SME-no-SVE VM the VMM needs to know
if the vcpu is currently in streaming mode or not to determine
whether to read the FP registers as fp_regs or sve regs? That
seems unpleasant -- I was expecting this to be strictly a
matter of how the VM was configured (as it is with SVE).

>         The equivalent register content can be accessed via bits [127:0] of
> -       the corresponding SVE Zn registers instead for vcpus that have SVE
> -       enabled (see below).
> +       the corresponding SVE Zn registers in these cases (see below).
>
>  arm64 CCSIDR registers are demultiplexed by CSSELR value::
>
> @@ -2636,24 +2636,34 @@ arm64 SVE registers have the following bit patterns::
>    0x6050 0000 0015 060 <slice:5>        FFR bits[256*slice + 255 : 256*slice]
>    0x6060 0000 0015 ffff                 KVM_REG_ARM64_SVE_VLS pseudo-register
>
> -Access to register IDs where 2048 * slice >= 128 * max_vq will fail with
> -ENOENT.  max_vq is the vcpu's maximum supported vector length in 128-bit
> -quadwords: see [2]_ below.
> +arm64 SME registers have the following bit patterns:
> +
> +  0x6080 0000 0017 00 <n:5> <slice:5>   ZA.H[n] bits[2048*slice + 2047 : 2048*slice]
> +  0x60XX 0000 0017 0100                 ZT0

What's the XX here ?

> +  0x6060 0000 0017 fffe                 KVM_REG_ARM64_SME_VLS pseudo-register
> +
> +Access to Z, P or ZA register IDs where 2048 * slice >= 128 * max_vq
> +will fail with ENOENT.  max_vq is the vcpu's maximum supported vector
> +length in 128-bit quadwords: see [2]_ below.

What about FFR registers ? Is their ENOENT condition the same,
or different?

> +
> +Access to the ZA and ZT0 registers is only available if SVCR.ZA is set
> +to 1.
>
>  These registers are only accessible on vcpus for which SVE is enabled.
>  See KVM_ARM_VCPU_INIT for details.
>
> -In addition, except for KVM_REG_ARM64_SVE_VLS, these registers are not
> -accessible until the vcpu's SVE configuration has been finalized
> -using KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_SVE).  See KVM_ARM_VCPU_INIT
> -and KVM_ARM_VCPU_FINALIZE for more information about this procedure.
> +In addition, except for KVM_REG_ARM64_SVE_VLS and
> +KVM_REG_ARM64_SME_VLS, these registers are not accessible until the
> +vcpu's SVE and SME configuration has been finalized using
> +KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_VEC).  See KVM_ARM_VCPU_INIT and
> +KVM_ARM_VCPU_FINALIZE for more information about this procedure.
>
> -KVM_REG_ARM64_SVE_VLS is a pseudo-register that allows the set of vector
> -lengths supported by the vcpu to be discovered and configured by
> -userspace.  When transferred to or from user memory via KVM_GET_ONE_REG
> -or KVM_SET_ONE_REG, the value of this register is of type
> -__u64[KVM_ARM64_SVE_VLS_WORDS], and encodes the set of vector lengths as
> -follows::
> +KVM_REG_ARM64_SVE_VLS and KVM_ARM64_VCPU_SME_VLS are pseudo-registers
> +that allows the set of vector lengths supported by the vcpu to be
> +discovered and configured by userspace.  When transferred to or from
> +user memory via KVM_GET_ONE_REG or KVM_SET_ONE_REG, the value of this
> +register is of type __u64[KVM_ARM64_SVE_VLS_WORDS], and encodes the
> +set of vector lengths as follows::
>
>    __u64 vector_lengths[KVM_ARM64_SVE_VLS_WORDS];
>
> @@ -2665,19 +2675,25 @@ follows::
>         /* Vector length vq * 16 bytes not supported */
>
>  .. [2] The maximum value vq for which the above condition is true is
> -       max_vq.  This is the maximum vector length available to the guest on
> -       this vcpu, and determines which register slices are visible through
> -       this ioctl interface.
> +       max_vq.  This is the maximum vector length currently available to
> +       the guest on this vcpu, and determines which register slices are
> +       visible through this ioctl interface.
> +
> +       If SME is supported then the max_vq used for the Z and P registers
> +       while SVCR.SM is 1 this vector length will be the maximum SME
> +       vector length available for the guest, otherwise it will be the
> +       maximum SVE vector length available.

I can't figure out what this paragraph is trying to say, partly
because it seems like it might be missing some text between
"is 1" and "this vector length".

In any case, the "while SVCR.SM is 1" part seems odd -- I
don't think this ABI should care about the runtime vcpu state,
only what the vcpu's max vector lengths were configured as.
My expectation would be that the max_vq for VMM register
access would be the maximum of the SVE and SME vector lengths
configured for the vcpu.

thanks
-- PMM

