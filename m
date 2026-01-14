Return-Path: <linux-kselftest+bounces-48917-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D73D7D1DED6
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 11:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26B473062BF1
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 10:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0818038E12F;
	Wed, 14 Jan 2026 10:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WS2mfg6M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E400B38E125
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Jan 2026 10:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768385349; cv=pass; b=AmPcju5DOvcXu6mex39lKowtIyFLCA7coV0EcT5/u+8yjfaoVSV9SL5+5m2LlWClnYOIxAKaTFtZyIM7fOrhisDOXoOm1RuzjYv6QpFImyxB2wuPAYMknnZjFF79+hZNuORvdJbSqcZI3duzjtvltAcDb7aH8D8uZ7LNbnyaeVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768385349; c=relaxed/simple;
	bh=cboAZC/N7GAkgRpHFH255dWg88gOhZq5k/rXBB7Or3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t0M2jV5KYFK/f4yZ6WC1NFB/HqeW1r1BiaBDwxxZBwD5N5iy4/WQd5sukq7kso+2aRpPjImIdVeZuf79g2h28bznWKG/9qhL1kG2bcF5pHaPn30H9HjV5lobdfOPBQJbITrVrs6MGWwhm0v7E1E9Xc92Sk5FNZHui2DpGfVM+XY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WS2mfg6M; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4779e2ac121so38185e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jan 2026 02:09:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768385346; cv=none;
        d=google.com; s=arc-20240605;
        b=APJjsb8sM2afYutfsUUxnEI4495ZGeVV/e/7Hh7f34dmlEv8Y8oon0nsq3dv+SDkDk
         Ii3gUOCZi9uAqUGTFmoEs7I7ZHOw0RnBvmcUI3qEM+13GJ7EpMlOBbc4q+CeyABHepis
         XxfNjCr18jxlZl4uETPUykA6ljINqOefVjeJimHW2TExaQX4pNNXf/bxli3vZG62Z83m
         jpR5UjmrrcRLhce3LnnUh8BRPJHlRRRWHAnEzODOZOgJyIIr+vJC9MiGYYgtVKNcyH//
         TSTMEX1gJ/0cWcBr4TpH9G+j3dhxx++ZuhkMj9qKB3Ipg3dRmswS7aFsxUH7+u3gFid2
         G2+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9I9WuN49vDzL3jcHM+WJ2QBCVFtv9a9q6bPtMasJkpo=;
        fh=mlEBreNQ5cKf+de7Fh+LWOv5tT6UL54hh97Jdj1IChI=;
        b=C/fxkP6wy0GpO+cFls3PxBYhAi37PKC2GmCC2UFAOOmA+unm8gKJC55YTjfpV1gOfQ
         1q5iOIB5yRk93exsavxSlPrzmPDYO3Km9tmkQJmH4ZeJsH+vtf2TIXKS2mnyhexQVCjX
         5XxA5F8Sm9YKe2yZN2JvYmg/CQCHqI7ENhtQoCO0dgFiRDs+ztLm/VlSgQyzLKQROecz
         RJDYbg6mnmDb9nHqwC+IbYa75UgKtWkscTPcEnUPL5B5hIDC0T5kzwxr50U8Jw6IalCO
         qwTLgl4ReERMRc3iKEfCkvWXPU3GCaxiARHTLzzUZPh95o0gEGt7QurEYLQm9i/yi/TH
         oWoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768385346; x=1768990146; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9I9WuN49vDzL3jcHM+WJ2QBCVFtv9a9q6bPtMasJkpo=;
        b=WS2mfg6Mholga+XaO3LxfBMg4FKpWFmyqEjQVIGBvI2yMufZGzr/Zu8+5AWvMK8ALX
         Ad/onzJ/+aCIJO2aEgo7O+ERV2n5IATh74K+K79iZGECOP47UibHgfvnUkVh9JizeL+g
         jLFoIYs9Gtds0IVI6fPi9wIs1VXXlx/ORnzHPIW3h62xuJpVhjOF9flBxwf8ErzJ1si7
         UXFcyGwgA/A4KM05swg+8ZCw4GFY9N0tv7ReZNaSM1x+4sv/3A+Q6sB7Eu7hQfCLjsjn
         ULDhs5GwgqYknpkV9dlFWLvilm1NNFzfttr83OpFSwmMAEcunDmuQ81nuwsazV91iZ1G
         mqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768385346; x=1768990146;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9I9WuN49vDzL3jcHM+WJ2QBCVFtv9a9q6bPtMasJkpo=;
        b=psxzJX/iD/Ltk8xwp1g/lFf49kTtDtsjueaZEqO4CNYSOxkJADOrijmkC+jsGJ42it
         vSbFKA4mpxydH8cvuw/KrVuGnbOjXWQaiJ/2bj1v6IE7K0FnGY1sRWzSg3tcSdlVzBtK
         X76rqfPmXXShZcUscs6x2AsOBUECIjchUZf9jscz12vKjiZH9NPy2KoES0NcNy5jP/ir
         wguuNU7w95gdBrjyLKVsEnaZpoBApdOm57WKJb6yYbfOLEQKyxmKUgC+VIy0rd+DkvKX
         wNsngWuH8RMcalCQEf8a98eh24Sc/xkwzFIS/C2wUSg+vOTz88IeEiZoVHotarSPlT2o
         BYoQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2m8KKF238RYp8tjyNtBvXkapt9Q0vmFvkmlD7Ye5vxajZ9OQGf7UaWnC1DLXN18rwWhPMK7XY1/MXiVrA4i8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLp4QvNu0IDqRn3w6M3eIo3niQM6kL3O6GL8B5npgmInnLv+NY
	iyWZxMzrxSVaPJhHAyzznH2Tnq3kX+FgMzQFvcsznMFymxfK8VYM5xe2L532zbvL3azGYA/2C13
	+6HEIxrk3ayj0nTzCc208eEZwvVearCx9yD19m7zd
X-Gm-Gg: AY/fxX4Ps3jSvrJYFU9DIXshRdv9pvYHcki7dSUq5/Sr9orZve4y8NwiakepLQXg5mP
	jxzLOLCxJIeiMbmUzqnKWFY9yoQDu4kHp0h11aMPHYQcrGrzpP8Cz7pFop3wNeQ5SzqRk1G5F99
	Gip4W9sL989SQiVrH0KFUT9+TD4XJ0QlHwEI/A81yaV4hQpzrXAD8JxLxiERaBmpLcN/TOlB9B0
	VnLQJ8A+mkziQ7iDREnlVXbfmZ7Reio3G7AGfbZm/U4um9vsoOYXjbUa8D4sBO7xan1XUPeUDiL
	cTmyHtmeYt3Q8yWEhPaEL8/UIg==
X-Received: by 2002:a05:600c:4c09:b0:477:772e:9b76 with SMTP id
 5b1f17b1804b1-47ee452990amr280725e9.7.1768385345996; Wed, 14 Jan 2026
 02:09:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
 <20251223-kvm-arm64-sme-v9-19-8be3867cb883@kernel.org> <CA+EHjTwQ4fLBE1YXoB6M0eamSgGDW=nfLaC+-_surBfVbh3byQ@mail.gmail.com>
 <6f0e94ab-7c9c-4705-a90b-aea09ca629de@sirena.org.uk>
In-Reply-To: <6f0e94ab-7c9c-4705-a90b-aea09ca629de@sirena.org.uk>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 14 Jan 2026 10:08:27 +0000
X-Gm-Features: AZwV_QjZbcO1T13jUPtvWgDAfMEoLsYIn7-Rzu9SF6LWm46DZ1iruQdxKvCCi9Y
Message-ID: <CA+EHjTwJw0D2w3oGC_ZSJsciUgiACoLAcRQv+_QSsA_bJKYj+A@mail.gmail.com>
Subject: Re: [PATCH v9 19/30] KVM: arm64: Provide assembly for SME register access
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

On Tue, 13 Jan 2026 at 19:20, Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Jan 12, 2026 at 05:59:17PM +0000, Fuad Tabba wrote:
> > On Tue, 23 Dec 2025 at 01:22, Mark Brown <broonie@kernel.org> wrote:
>
> > > +void __sme_save_state(void const *state, bool restore_zt);
> > > +void __sme_restore_state(void const *state, bool restore_zt);
>
> > Would it be a good idea to pass the VL to these functions. Currently,
> > they assume that the hardware's current VL matches the buffer's
> > intended layout. But if there is a mismatch between the guest's VL and
> > the current one, this could be difficult to debug. Passing the VL and
> > checking it against _sme_rdsvl would be an inexpensive way to avoid
> > these.
>
> This mirrors the way that we've handled this for the SVE and for the
> host kernel.  We don't really have any good way to tell anything about
> problems if things go wrong inside the hypervisor.

I know this is how we've handled this for the SVE, but back then we
only had one VL and one mode to worry about. The chances of something
going wrong now are much higher.


> > > +SYM_FUNC_START(__sve_get_vl)
> > > +       _sve_rdvl       0, 1
> > > +       ret
> > > +SYM_FUNC_END(__sve_get_vl)
>
> > Since this is just one instruction, would it be better to implement it
> > as an inline assembly in the header file rather than a full
> > SYM_FUNC_START, to reduce the overhead?
>
> Actually this isn't referenced anymore so could just be deleted.  It
> mirrors what we've got in the host code, we have to hand assemble
> everything because we still don't require binutils that supports SVE,
> let alone SME, and that's done with macros that do argument validation
> which don't play nice with C.  Even with an assembler that supports the
> instruction using a SVE instruction from C code gets annoying.  It has
> crossed my mind to inline but it never seemed worth the effort
>
> > > +SYM_FUNC_START(__sme_save_state)
>
> > I think that this needs an isb(). We need to ensure that SMCR updates
> > are visible here. Looking ahead to where you introduce
> > __hyp_sme_save_guest(), that doesn't have a barrier after updating
> > SMCR. The alternative is to call the barrier where it's needed, but
> > make sure that this is well documented.
>
> I think we should put the barrier where the update that needs it is.

That's fine, but then we should at least document this.

Cheers,
/fuad

