Return-Path: <linux-kselftest+bounces-46658-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDE6C8F215
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 16:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5653034F83E
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 15:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B63333456;
	Thu, 27 Nov 2025 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sldNJaW/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E88334373
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Nov 2025 15:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764256025; cv=none; b=hmz1ch4CIZNIj1/O+4MGrIuQdkgF/1fxzP5pDEtT8XU0Nlz0Cu/Wh124Xw7XCHoVYE4M0Fs+rOt/IC1RPQaZWqffVJuO2CM34Jsp3zhNgMsO8k1+07rs1+zTtEn+wZQAXcwkcFXjt2CEvB14ko3kt18FMTMG6s86E3oqUEBTqUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764256025; c=relaxed/simple;
	bh=O3Jl0TedBRVRfVhZgOJdrLKqQHfxK+5HmiN/P10lDXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aFkJpw3HGDo1UJAygotll0ELG1syRrWC4endvA5l4l33W+sQc6idwaU0L91avvdv1hHi1vHPBkuF94UKLeOH0KnRNLdHEO4pXh3IRlHrxTcVzq0yO1VWBTRvqVM3Mjcs+oBSfscDI6ATsv/R2hP3A0c/d2OoMntDwsKIZAjYhyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sldNJaW/; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-640c9c85255so1320507d50.3
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Nov 2025 07:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764256023; x=1764860823; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o9j9JckZewB0T/evvAwAYflbY/oMjYUWYlwvg8R/JAM=;
        b=sldNJaW/mtHUk78eRyP2lAEuPxOVWCzUy34HKQc/0B5GXWG56q2ha5vgocIRVwl74n
         /3dcW/6l7FjFIbfofeKt/0akG5TOwa0eP31I6hQ53kXoBexKm1WAwg4J103a+j2X3I2S
         2c+NuSx8sP3POpaNzZrv0c/kYzfrL8VJEcc4fT8V6Mm8DcChWlximDOZZoeymr8diehT
         V/kxDRBF1Y0mLoBCJf88TYLMNK7+kQj8Y7bqnfL+/DiZ/1xxmJ0J2A47JpWlb/PPvchH
         kmGVgaj5CMHQkL4CsUhepeDuuoaUd+ZhttYIDhHyoh7kcJYUshRM2EP1K5hzyb8e2op6
         yt6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764256023; x=1764860823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9j9JckZewB0T/evvAwAYflbY/oMjYUWYlwvg8R/JAM=;
        b=vdKHL7M+2c4rz4lSWHVwR8HkvjZnWKuHv8XcgkaSyXnH7+D2MFGqW+kvkHtRG/B8ZI
         8vfoIVWn0Ha7oejDbhWKQliylIVlr7zxW7KiPxMiKsgum1XH+8z007OyfqAZmZJJd5rm
         rh+qfEJy4M4U3nBUf0W72GwjYOBXH9AikMpIHLCBAWlxrHyDwZELdwTBtcpnAwYzZdBC
         gavNF81hSdx7NA34p7Iur/ZF0kCW2Gv+miBpY3ur4rky2xIJc/+YxossfRncyejpM01v
         cWSewvFb7rLFyVED0uSIi9QokmeO+EV2YmzsW4AymdA6jf41NWKwq2Ojm5Cj4A18ft0e
         gHRw==
X-Forwarded-Encrypted: i=1; AJvYcCW9sA2n45v5HYFQW3iN2Dp+1dAuVgXrFmK+6+Sr3LnyFVmrvEZpzLBm1AzflTX3PyysqsyH91UYB2OC/hEJEx8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw01vl5bnNaZfRICOJ4N/R78cO5PMidbar7Dddm3Mzx7bBBGyIG
	RiOa9K/G8Kpypa4ivXFtlFvzaVxgYo6Vh4jSKqVRa7TZEft0GTQTLpd9wVI7IQOU6e+T1QU76sf
	8whLiOXfL6rZS/hd2kjnUfXId4bvgTUBYLqbMMMbMJA==
X-Gm-Gg: ASbGncvJbYhMevW10ceVgQtexj7qpbEUIXbhPEdrKRAk/s4XXmQqWxSByshLycoL7FE
	v1DjizMGdcvdoEPz/Eiha2dg6Z5VloR/Dt0AJRC2yWUTVGP6tFI9yWz4Wg4eXT5JPvlanxQmKm5
	y7kWYSPzjMXQCm2WFZqQ/oPdYQZfHMcojGucc/gqRTCoTBus0R3CVWYpxF8Zfp+cf77IPF/gr3f
	TcH+aYG04nV+SkEHevzKvOJ6x1HFEhInKVvMuPX+L0WEDZ7oZf5zIDdYQRXeAYaa+MK3Adn
X-Google-Smtp-Source: AGHT+IHOZv1XVUaCpJ1GafgJ+Q4ufaODDINZzVe7OUjEEvUjTH0ObsXn/Gn7AJqtRSZdFMpWXb50BEdfVotDE3qezIw=
X-Received: by 2002:a05:690e:1581:10b0:641:f5bc:68d3 with SMTP id
 956f58d0204a3-6432940d24amr6552660d50.80.1764256022644; Thu, 27 Nov 2025
 07:07:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902-kvm-arm64-sme-v8-0-2cb2199c656c@kernel.org>
 <20250902-kvm-arm64-sme-v8-11-2cb2199c656c@kernel.org> <CAFEAcA_GJ7gzn7aMCZYxHnJWvx4tHSHBKsOxtQ7NTb4gPjkMJQ@mail.gmail.com>
 <df712591-397e-422b-b9c9-fbf080cad9aa@sirena.org.uk>
In-Reply-To: <df712591-397e-422b-b9c9-fbf080cad9aa@sirena.org.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Nov 2025 15:06:50 +0000
X-Gm-Features: AWmQ_blQNCtlqrFl6oR-29ayIeVzxjSMrcpdxqL32ABrh38kpa7m6Xz9ardxRBI
Message-ID: <CAFEAcA8LGwm-6JEhtKTq1E_da-T=H-aBX9-8LMJOAQpK5J+NfQ@mail.gmail.com>
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

On Mon, 24 Nov 2025 at 20:13, Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Nov 24, 2025 at 03:48:06PM +0000, Peter Maydell wrote:
> > On Tue, 2 Sept 2025 at 12:45, Mark Brown <broonie@kernel.org> wrote:
>
> > > SME, the Scalable Matrix Extension, is an arm64 extension which adds
> > > support for matrix operations, with core concepts patterned after SVE.
>
> > I haven't actually tried writing any code that uses this proposed
> > ABI, but mostly it looks OK to me. I have a few nits below, but
> > my main concern is the bits of text that say (or seem to say --
> > maybe I'm misinterpreting them) that various parts of how userspace
> > accesses the guest state (e.g. the fp regs) depend on the current
> > state of the vcpu, rather than being only a function of how the
> > vcpu was configured. That seems to me like it's unnecessarily awkward.
> > (More detail below.)
>
> That was deliberate and I agree it is awkward, it was introduced as a
> result of earlier review comments.  I had originally implemented an ABI
> where the VL for the vector registers was the maximum of the SVE and SME
> VLs but the feedback was that the ABI should instead follow what the
> architecture does with the vector length and potentially presence of the
> vector registers depending on the current streaming mode configuration.
> It sounds like you would prefer something more like what was there
> originally?

Yes, that's what I would prefer. The "varies by current CPU state"
approach seems to me to be not the way we do things right now,
and to be awkward for the VMM side, so it ought to have a really
strong justification for why we need it.

Generally the VMM doesn't care about the actual current state of the
CPU, it just wants all the data (e.g. to send for migration). We don't
make the current SVE accessors change based on what the current SVE
vq length is or whether the guest has set the SVE enable bits -- we
have "if the vcpu supports SVE at all, data is always accessed via
the SVE accessors, and it's always the max_vq length, regardless of
how the vcpu has set its current vq length".

What's the benefit of making the way KVM exposes the data
bounce around based on the current CPU state? Does that
make things easier for the kernel internally?

-- PMM

