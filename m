Return-Path: <linux-kselftest+bounces-48870-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA671D19B7D
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 16:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2885030492AF
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 14:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691E22D780A;
	Tue, 13 Jan 2026 14:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OpYL2D4L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EC02882D0
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 14:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768316359; cv=pass; b=FS7SsfL/R1CiSawkO2X/yFb1G6bNAfO0OcjO9Zn95AfSwWuPv0kYaYc+FJpnTo5G22WOpX24rH8kN2yP1WnEt0k5Zpbq7jMrGskp2vRkFv/rylOoNcwQIoMc43VLzBzOPx4UCVGXiDdLPFLdbKE/ZMgQR/fxhsjYO6EaVKwMsCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768316359; c=relaxed/simple;
	bh=zPf3YoW4m/woyXDwob6YFjb2tYc58F297IepxgIBakc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sx69U6gSUKuAQGCCWTZHVBDgts+pLc86t2NzYnpTVx1kykxsPTbWy/2nQWvD+x/Usc++fuLPRc4D8B3H/gaL3ha2fl1AW4F0j6CNAIMyPoCbc5+FiSkJvm9nTThLhFqfcm9p8PzL5hGT3dXgRQH+XQ2ZUDXxLPLQQdVaGKMo9YY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OpYL2D4L; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ee147baf7bso329551cf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 06:59:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768316355; cv=none;
        d=google.com; s=arc-20240605;
        b=amABGDqwBAJ2JV1jch57uggaXeXdIFJi3hE5Hy2aWInHIBfY9ypUhHxS9k5ztYwqHv
         J/zuEZVHzFFXP7sXxUD8QFITBbUCN77IOi5Rg3pgZ3FFspHTYT53ziWcUmg2cI8uBIa8
         kMT0Y65YvOE8ksU3r0f/5KzI0FJkp51JuaQq380eKcTmSkhlnXqCXg1OjjPmlSUahSEq
         GCzHszTlhSaEHJFbRO7jiQ/OsuOlpux5tEzO3JxXjZX4C/h5ERwUURZrRA6I414JzfNx
         kfcq1tw5/wKIpr2lmZ4NLztl5gA0fF8FxYdlVguWE3RYb6U2e4XAqA+gojJ+kadGeqqe
         bgjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pZlojhgCGQRJd86Bfq6GmjSuTaKdj0Ma2frE3Xf58I0=;
        fh=a+qKMl4AQx+APRJrkkToWyOnet32ZhGOehH9o371lHo=;
        b=Q3uWPl2yYewsviXvASaa+WKw7AT0Nk7l6ZOBWQGHgyp1SW4PJKGQUM3pJ8R1LOlX8P
         L1J0OYW/pWYrL3mMniJBC6y0cvcoH1qng8aTR1Z3ArpQRLyJVzvhzSMmSgkCCoU4Z+s7
         Tz1ne5bdl6L3RfGMFNAqPCkKxjn+8PmC6jU/PF2yhWrQW5nuW5gxMGTVbhqmp+ko9OOG
         RCJ5iGCS/PlsHJGKdqyJUClEbrxyfW5xC3DJ9fVD19ZsexzN1O57Ib6+LLxZFF342rCQ
         Ju33oTvJSOGC5o+lHBnHgPpAMwIBSf2r0hieCRRO6v5G6ulc0/kGifYPmwDEpz9Z0x2A
         sb1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768316355; x=1768921155; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pZlojhgCGQRJd86Bfq6GmjSuTaKdj0Ma2frE3Xf58I0=;
        b=OpYL2D4LPoDrU+QpNTzLqEcsYg22APbpR7Q09oqDR5BE2nxA1b1/zPdSnUGEdrl63h
         Owx/Rde+YVTFPcvnusAm4VDI1jQmJjwFVXhOD7mbaXhiIOqcodRHwGERIUyYiI7ZjDNC
         tSxCAH9bCoIuPdGqcfuScWsgSGFTEaZXGci1UIuqfAALpNmyuKA0Vb4tYwWLJa2qX6Hy
         5UJdHxzuPzFPWhg3hO/IikG0nCdmZXn8ST5Cr2wQ5hRk1FHlEx0dHB5NWPgSCS+FBl1t
         OyMXwWx3RmGNdlNfU/ORJX7YpNQhsykvlh2y47wFe4uuRF6x8F63DoAgK0tzylymzL52
         RBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768316355; x=1768921155;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZlojhgCGQRJd86Bfq6GmjSuTaKdj0Ma2frE3Xf58I0=;
        b=uriceVpHe/xIcGZVlt086VHCbnkaG3d7t9sTaFOHgIoWEON6JS8FPy/RMSZqMhk2mL
         ucau8JBhp8Nhsn9Sh2pd6HSHYis9jAyyBXKV/i27s5udyztTGNGs2RTDAuXeAWgYPmjG
         SHuXHIdnOADC1e9TNYWopy6H+RFbQSHTgvKTWLaxC97/9IkDDov8iIDO1+MFiAcB0Ta9
         Za/DN/3rPGpSE9zrFM3FrZaeLMxY3N/rmc6YNVklzGbpugQ20MgMLR7DmVUKk6guTFBe
         dppUFaPCqLzs8R44Vy8pvsaQ+0UEd1LESqL2IDOPZM+5FFnCczSegjdNY7gTMn3g7r7B
         j8NQ==
X-Forwarded-Encrypted: i=1; AJvYcCXst/hMuofB9SU2Wr0E6IPmeYI3g9RIBDYVnPLuOfDiQyu4jZOjRIfDbMyuCcS8ctwIUhwTjIxMb+mgwr4k5R4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1o2bf3nmZitOhGG37MCUBSUwRktPxtdxDQBRNY68XthK6az8C
	Z3fYJ0o6f94IvpQNK77K6lRnY6G7QHxaRqWubpg0mFDbfwQ5+v4+h4SxQvtdwK5OnXWT53PXmP2
	K67URksKKGoAoUFNiekQ3xVG5b6OJTMXCltvbaHjr
X-Gm-Gg: AY/fxX5DHqPBMZO1ZvgzGixfV3Mx4HHdDMOr2HRaTingi56Cnq3XfKjztzXkQcDF22v
	hAx814Xe6pGjNOppi8O74PSBHH8k9GaRPl/xG6gEu+Xp4uncD+mH3a0c2LvAMCaPDGRd2ITqCUg
	/JvT7dzZKYjLJb68vwFES+FdRkuSurT3DIGC04Pqa9A2lwUAMJwICzV66md9uJBacPQLMIfCSe6
	oRWrzQoHkYXAScGtqMeHuLH/1zf+RRJfbDeEe15+73xrP+cMdd3ekLWIcPPofF8g/7BzPJ0C4uM
	ViHRabxMMYQ9QvOAtFu+9ZoJjg==
X-Received: by 2002:a05:622a:1803:b0:4ed:ff79:e679 with SMTP id
 d75a77b69052e-5013b24c643mr4567491cf.19.1768316354656; Tue, 13 Jan 2026
 06:59:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
In-Reply-To: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 13 Jan 2026 14:58:37 +0000
X-Gm-Features: AZwV_QjSfPf_Qtos4PBfowPO8me3Hnm4jktWm-anHeSkcEqLyKFJ9qvABg5y_BU
Message-ID: <CA+EHjTxOKDZ+gc9Ru=HpcRb8O-AvRm9UJaWM1fZeoqSz0bLK=g@mail.gmail.com>
Subject: Re: [PATCH v9 00/30] KVM: arm64: Implement support for SME
To: Mark Brown <broonie@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>, Dave Martin <Dave.Martin@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Ben Horgan <ben.horgan@arm.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>, 
	Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hi Mark,

On Tue, 23 Dec 2025 at 01:21, Mark Brown <broonie@kernel.org> wrote:
>
> I've removed the RFC tag from this version of the series, but the items
> that I'm looking for feedback on remains the same:

Now that I've gone through the patch series (except for the
selftests), here are some of my thoughts at a high level.

The first one is something you have documented in api.rst:

> Changing the value of SVCR.SM will result in the contents of
> the Z, P and FFR registers being reset to 0.  When restoring the
> values of these registers for a VM with SME support it is
> important that SVCR.SM be configured first.

However, the order returned by kvm_arm_copy_reg_indices() is core,
sve, fw, then system. So this means that the VMM will need to hardcode
this order, rather than rely on KVM_GET_REG_LIST. It _is_ documented,
but it is tricky and it's easy to miss.

Looking at copy_sve_reg_indices(), there's a special case for
KVM_REG_ARM64_SVE_VLS, which forces it to appear before the other SVE
registers. So I wonder if we need to do something at the level of
kvm_arm_copy_reg_indices(), or do some sort of post-processing to the
list, to avoid this problem.

>  - The userspace ABI, in particular:
>   - The vector length used for the SVE registers, access to the SVE
>     registers and access to ZA and (if available) ZT0 depending on
>     the current state of PSTATE.{SM,ZA}.

One issue I see here, from a VMM's perspective, is that the amount of
data transferred via KVM_GET_ONE_REG/KVM_SET_ONE_REG depends on the
guest's current architectural mode. So now the VMM needs to first
figure out what that is, before being able to SET/GET when
saving/restoring a VM state.

Before this series, SVE just assumed a maximum amount of data and
zero-pad the rest. SME state is bigger, but in practice, do we expect
many cases where the VL sizes between modes would be drastically
different that it would make a difference in terms of storage?

Other than that, I think the asymmetry of VLs might be a painpoint for
users. The problem is that there is no guarantee that the set of
vector lengths supported for SME match or the set supported for SVE.
But I wonder if there's something we can do to help. Maybe a discovery
IOCTL that returns the entire matrix of supported configurations (SVE
VLs, SME VLs, and their intersection) to simplify VMM decision-making?

One final note, I think the pKVM code will change a bit, especially
since the pKVM SVE code has changed in Android. But since none of this
is upstream yet, your changes are consistent with the existing code.
I'll have a closer look at that code on the next respin.

Thanks,
/fuad





>   - The use of a single finalisation for both SVE and SME.
>
>  - The addition of control for enabling fine grained traps in a similar
>    manner to FGU but without the UNDEF, I'm not clear if this is desired
>    at all and at present this requires symmetric read and write traps like
>    FGU. That seemed like it might be desired from an implementation
>    point of view but we already have one case where we enable an
>    asymmetric trap (for ARM64_WORKAROUND_AMPERE_AC03_CPU_38) and it
>    seems generally useful to enable asymmetrically.
>
> This series implements support for SME use in non-protected KVM guests.
> Much of this is very similar to SVE, the main additional challenge that
> SME presents is that it introduces a new vector length similar to the
> SVE vector length and two new controls which change the registers seen
> by guests:
>
>  - PSTATE.ZA enables the ZA matrix register and, if SME2 is supported,
>    the ZT0 LUT register.
>  - PSTATE.SM enables streaming mode, a new floating point mode which
>    uses the SVE register set with the separately configured SME vector
>    length.  In streaming mode implementation of the FFR register is
>    optional.
>
> It is also permitted to build systems which support SME without SVE, in
> this case when not in streaming mode no SVE registers or instructions
> are available.  Further, there is no requirement that there be any
> overlap in the set of vector lengths supported by SVE and SME in a
> system, this is expected to be a common situation in practical systems.
>
> Since there is a new vector length to configure we introduce a new
> feature parallel to the existing SVE one with a new pseudo register for
> the streaming mode vector length.  Due to the overlap with SVE caused by
> streaming mode rather than finalising SME as a separate feature we use
> the existing SVE finalisation to also finalise SME, a new define
> KVM_ARM_VCPU_VEC is provided to help make user code clearer.  Finalising
> SVE and SME separately would introduce complication with register access
> since finalising SVE makes the SVE registers writeable by userspace and
> doing multiple finalisations results in an error being reported.
> Dealing with a state where the SVE registers are writeable due to one of
> SVE or SME being finalised but may have their VL changed by the other
> being finalised seems like needless complexity with minimal practical
> utility, it seems clearer to just express directly that only one
> finalisation can be done in the ABI.
>
> Access to the floating point registers follows the architecture:
>
>  - When both SVE and SME are present:
>    - If PSTATE.SM == 0 the vector length used for the Z and P registers
>      is the SVE vector length.
>    - If PSTATE.SM == 1 the vector length used for the Z and P registers
>      is the SME vector length.
>  - If only SME is present:
>    - If PSTATE.SM == 0 the Z and P registers are inaccessible and the
>      floating point state accessed via the encodings for the V registers.
>    - If PSTATE.SM == 1 the vector length used for the Z and P registers
>  - The SME specific ZA and ZT0 registers are only accessible if SVCR.ZA is 1.
>
> The VMM must understand this, in particular when loading state SVCR
> should be configured before other state.  It should be noted that while
> the architecture refers to PSTATE.SM and PSTATE.ZA these PSTATE bits are
> not preserved in SPSR_ELx, they are only accessible via SVCR.
>
> There are a large number of subfeatures for SME, most of which only
> offer additional instructions but some of which (SME2 and FA64) add
> architectural state. These are configured via the ID registers as per
> usual.
>
> Protected KVM supported, with the implementation maintaining the
> existing restriction that the hypervisor will refuse to run if streaming
> mode or ZA is enabled.  This both simplfies the code and avoids the need
> to allocate storage for host ZA and ZT0 state, there seems to be little
> practical use case for supporting this and the memory usage would be
> non-trivial.
>
> The new KVM_ARM_VCPU_VEC feature and ZA and ZT0 registers have not been
> added to the get-reg-list selftest, the idea of supporting additional
> features there without restructuring the program to generate all
> possible feature combinations has been rejected.  I will post a separate
> series which does that restructuring.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> Changes in v9:
> - Rebase onto v6.19-rc1.
> - ABI document clarifications.
> - Add changes dropping asserts on single bit wide bitfields in set_id_regs.
> - Link to v8: https://lore.kernel.org/r/20250902-kvm-arm64-sme-v8-0-2cb2199c656c@kernel.org
>
> Changes in v8:
> - Small fixes in ABI documentation.
> - Link to v7: https://lore.kernel.org/r/20250822-kvm-arm64-sme-v7-0-7a65d82b8b10@kernel.org
>
> Changes in v7:
> - Rebase onto v6.17-rc1.
> - Handle SMIDR_EL1 as a VM wide ID register and use this in feat_sme_smps().
> - Expose affinity fields in SMIDR_EL1.
> - Remove SMPRI_EL1 from vcpu_sysreg, the value is always 0 currently.
> - Prevent userspace writes to SMPRIMAP_EL2.
> - Link to v6: https://lore.kernel.org/r/20250625-kvm-arm64-sme-v6-0-114cff4ffe04@kernel.org
>
> Changes in v6:
> - Rebase onto v6.16-rc3.
> - Link to v5: https://lore.kernel.org/r/20250417-kvm-arm64-sme-v5-0-f469a2d5f574@kernel.org
>
> Changes in v5:
> - Rebase onto v6.15-rc2.
> - Add pKVM guest support.
> - Always restore SVCR.
> - Link to v4: https://lore.kernel.org/r/20250214-kvm-arm64-sme-v4-0-d64a681adcc2@kernel.org
>
> Changes in v4:
> - Rebase onto v6.14-rc2 and Mark Rutland's fixes.
> - Expose SME to nested guests.
> - Additional cleanups and test fixes following on from the rebase.
> - Flush register state on VMM PSTATE.{SM,ZA}.
> - Link to v3: https://lore.kernel.org/r/20241220-kvm-arm64-sme-v3-0-05b018c1ffeb@kernel.org
>
> Changes in v3:
> - Rebase onto v6.12-rc2.
> - Link to v2: https://lore.kernel.org/r/20231222-kvm-arm64-sme-v2-0-da226cb180bb@kernel.org
>
> Changes in v2:
> - Rebase onto v6.7-rc3.
> - Configure subfeatures based on host system only.
> - Complete nVHE support.
> - There was some snafu with sending v1 out, it didn't make it to the
>   lists but in case it hit people's inboxes I'm sending as v2.
>
> ---
> Mark Brown (30):
>       arm64/sysreg: Update SMIDR_EL1 to DDI0601 2025-06
>       arm64/fpsimd: Update FA64 and ZT0 enables when loading SME state
>       arm64/fpsimd: Decide to save ZT0 and streaming mode FFR at bind time
>       arm64/fpsimd: Check enable bit for FA64 when saving EFI state
>       arm64/fpsimd: Determine maximum virtualisable SME vector length
>       KVM: arm64: Pay attention to FFR parameter in SVE save and load
>       KVM: arm64: Pull ctxt_has_ helpers to start of sysreg-sr.h
>       KVM: arm64: Move SVE state access macros after feature test macros
>       KVM: arm64: Rename SVE finalization constants to be more general
>       KVM: arm64: Document the KVM ABI for SME
>       KVM: arm64: Define internal features for SME
>       KVM: arm64: Rename sve_state_reg_region
>       KVM: arm64: Store vector lengths in an array
>       KVM: arm64: Implement SME vector length configuration
>       KVM: arm64: Support SME control registers
>       KVM: arm64: Support TPIDR2_EL0
>       KVM: arm64: Support SME identification registers for guests
>       KVM: arm64: Support SME priority registers
>       KVM: arm64: Provide assembly for SME register access
>       KVM: arm64: Support userspace access to streaming mode Z and P registers
>       KVM: arm64: Flush register state on writes to SVCR.SM and SVCR.ZA
>       KVM: arm64: Expose SME specific state to userspace
>       KVM: arm64: Context switch SME state for guests
>       KVM: arm64: Handle SME exceptions
>       KVM: arm64: Expose SME to nested guests
>       KVM: arm64: Provide interface for configuring and enabling SME for guests
>       KVM: arm64: selftests: Remove spurious check for single bit safe values
>       KVM: arm64: selftests: Skip impossible invalid value tests
>       KVM: arm64: selftests: Add SME system registers to get-reg-list
>       KVM: arm64: selftests: Add SME to set_id_regs test
>
>  Documentation/virt/kvm/api.rst                   | 120 ++++++++---
>  arch/arm64/include/asm/fpsimd.h                  |  26 +++
>  arch/arm64/include/asm/kvm_emulate.h             |   6 +
>  arch/arm64/include/asm/kvm_host.h                | 163 ++++++++++++---
>  arch/arm64/include/asm/kvm_hyp.h                 |   5 +-
>  arch/arm64/include/asm/kvm_pkvm.h                |   2 +-
>  arch/arm64/include/asm/vncr_mapping.h            |   2 +
>  arch/arm64/include/uapi/asm/kvm.h                |  33 +++
>  arch/arm64/kernel/cpufeature.c                   |   2 -
>  arch/arm64/kernel/fpsimd.c                       |  89 ++++----
>  arch/arm64/kvm/arm.c                             |  10 +
>  arch/arm64/kvm/config.c                          |  11 +-
>  arch/arm64/kvm/fpsimd.c                          |  28 ++-
>  arch/arm64/kvm/guest.c                           | 252 ++++++++++++++++++++---
>  arch/arm64/kvm/handle_exit.c                     |  14 ++
>  arch/arm64/kvm/hyp/fpsimd.S                      |  28 ++-
>  arch/arm64/kvm/hyp/include/hyp/switch.h          | 168 +++++++++++++--
>  arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h       | 110 ++++++----
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c               |  86 ++++++--
>  arch/arm64/kvm/hyp/nvhe/pkvm.c                   |  85 ++++++--
>  arch/arm64/kvm/hyp/nvhe/switch.c                 |   4 +-
>  arch/arm64/kvm/hyp/nvhe/sys_regs.c               |   6 +
>  arch/arm64/kvm/hyp/vhe/switch.c                  |  17 +-
>  arch/arm64/kvm/hyp/vhe/sysreg-sr.c               |   7 +
>  arch/arm64/kvm/nested.c                          |   3 +-
>  arch/arm64/kvm/reset.c                           | 156 ++++++++++----
>  arch/arm64/kvm/sys_regs.c                        | 140 ++++++++++++-
>  arch/arm64/tools/sysreg                          |   8 +-
>  include/uapi/linux/kvm.h                         |   1 +
>  tools/testing/selftests/kvm/arm64/get-reg-list.c |  15 +-
>  tools/testing/selftests/kvm/arm64/set_id_regs.c  |  84 ++++++--
>  31 files changed, 1367 insertions(+), 314 deletions(-)
> ---
> base-commit: 3e7f562e20ee87a25e104ef4fce557d39d62fa85
> change-id: 20230301-kvm-arm64-sme-06a1246d3636
>
> Best regards,
> --
> Mark Brown <broonie@kernel.org>
>

