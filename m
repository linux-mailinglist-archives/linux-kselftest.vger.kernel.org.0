Return-Path: <linux-kselftest+bounces-7857-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD0E8A35F0
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 20:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F5E21C21BDB
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 18:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAE114F119;
	Fri, 12 Apr 2024 18:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="NJpSzMgO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D344814EC6E
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 18:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712947588; cv=none; b=ptiJoMcw0iDemUP2qwT1anydYcEoR+TTVnCCBajEo8P6tmK08DAAp1oUMa3OLdIKHzOHLqzZqmsdj5C/Lu6vAQ9wyg0Q334kfDnjJoDodB3xZ0nZr46R9U5dc0He5GTrusTgSWip4fk362rYNwZi5xDl5FBgOImDxXEJMHIUQlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712947588; c=relaxed/simple;
	bh=qKkswK18vpnSN345O9M11lS7tdby0F+ByaBIolhUUXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSVib03jPkJtzVqxSUp3Tw3T1FMtzXuEetXeHiIiqqhCjWERLWPExBu/Yyds1PZ7e1Wi+Qea87z41wCW3wGdJ3e9nVdITGb2JSmBbj9JalgYh/O6IWHoW79HfjMhyPeNXSgLTmHh81/fTc0fcrry4SjKymhTUyYoXwawnx2ofo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=NJpSzMgO; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e419d203bdso8761995ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 11:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712947586; x=1713552386; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jhdmuDh97ehxPhYQBh/JW7pvCSTVsjtJJK5Y5QDdmM8=;
        b=NJpSzMgO2NM1CljmTV21oKb+kmm/SZHqXiDfvfccELH/SOEs7LEzkEvsb+4qYM3vor
         tc5dpUplGL0hrzgmIr6cUzgu7DdjlhvGYRQyEfpvK/vcY+xeEs+r0jrh+ZmxnKMaOjxP
         fvXvex5wT0a35qa/W0E0GPNGAburVs8VktwlJEVe9eLVdgfZY+LiCLry4V4brkD864+t
         PRGJZY4gr4U8Ts6AuCSOGFV/QXYQbLLn/Banboqtkf3tlq0m714BaV8l4e1Ya33IJCRs
         XOR20todyiga2MsVgVNrnCm81n7gRgm5UfxM6em6f8b4uPm6nVO3Af9NST9YbXk6Wl4X
         ivww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712947586; x=1713552386;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jhdmuDh97ehxPhYQBh/JW7pvCSTVsjtJJK5Y5QDdmM8=;
        b=hlWz+R/25HcvvnNaQ2gQ6TnlG6UELsK4+k/mjL9L9KqzmP+0xoOx4dXTCReAzxKmV6
         DBv9tDw0R/aUvpB+KU+aymuIoOHCKk2voKp1/Oh3mRcazphs0uDlud8ule998jCE47ep
         4CGjrEEERaL9U+3gc9+jdYnFtSh8ob9UPrWeIpAnEwMwlj2CUIu9Ox6nBE0kegkZ2zoc
         mT1jOrPZAbLA7/aVh+m+NTEMAD/qnBdE6x58PSsfb3vmdnIo8YfgYi7JO6XDleUGTV63
         nr3ltFJaingopr0g8C6wRYC8GkF4EgLnzNlrYa9REDHVNoE6HzHqvfyYajhNNA2VNrIy
         KfAg==
X-Forwarded-Encrypted: i=1; AJvYcCUbOu7s3PzA4q2Ms4vRTRxBtSCY8llWNI6KUgQOook0+nf5a8iD1H9ohIsTG5a7Rx2KQ0Zzbpx4DE5hHj5T8PbFV3M9JRV6GpJTp/IjwKF7
X-Gm-Message-State: AOJu0Ywa9jJsE/AJQt3cmk8zcUPi8EbP+tlgidGqLabwZhTLPq3S0+7o
	sd/4P38kRwbnlsfNo7hkFvysVFPwNME24Yyx/0laCukwOVvoUgSFGPM5ybOrpj0=
X-Google-Smtp-Source: AGHT+IFwxybYzCqREDQlA4G/991sEd0Qsau4lgiSO1q7Go2BFR9+aFqtd2m1c15qUgSnxQTpows9RQ==
X-Received: by 2002:a17:903:8ce:b0:1e4:70d0:9333 with SMTP id lk14-20020a17090308ce00b001e470d09333mr4440423plb.9.1712947586221;
        Fri, 12 Apr 2024 11:46:26 -0700 (PDT)
Received: from ghost ([107.84.152.28])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090322c200b001e447bf336esm3300373plg.282.2024.04.12.11.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 11:46:25 -0700 (PDT)
Date: Fri, 12 Apr 2024 11:46:21 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: Evan Green <evan@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 02/19] riscv: cpufeature: Fix thead vector hwcap removal
Message-ID: <ZhmBfaKXMMtolwSr@ghost>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
 <20240411-dev-charlie-support_thead_vector_6_9-v1-2-4af9815ec746@rivosinc.com>
 <20240412-tuesday-resident-d9d07e75463c@wendy>
 <CALs-HsuMZOMpDh8kwQx6FE2mawzt+qTD-WZ6Mvhrt+hUhkZimg@mail.gmail.com>
 <20240412-employer-crier-c201704d22e3@spud>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240412-employer-crier-c201704d22e3@spud>

On Fri, Apr 12, 2024 at 07:38:04PM +0100, Conor Dooley wrote:
> On Fri, Apr 12, 2024 at 10:04:17AM -0700, Evan Green wrote:
> > On Fri, Apr 12, 2024 at 3:26 AM Conor Dooley <conor.dooley@microchip.com> wrote:
> > >
> > > On Thu, Apr 11, 2024 at 09:11:08PM -0700, Charlie Jenkins wrote:
> > > > The riscv_cpuinfo struct that contains mvendorid and marchid is not
> > > > populated until all harts are booted which happens after the DT parsing.
> > > > Use the vendorid/archid values from the DT if available or assume all
> > > > harts have the same values as the boot hart as a fallback.
> > > >
> > > > Fixes: d82f32202e0d ("RISC-V: Ignore V from the riscv,isa DT property on older T-Head CPUs")
> > >
> > > If this is our only use case for getting the mvendorid/marchid stuff
> > > from dt, then I don't think we should add it. None of the devicetrees
> > > that the commit you're fixing here addresses will have these properties
> > > and if they did have them, they'd then also be new enough to hopefully
> > > not have "v" either - the issue is they're using whatever crap the
> > > vendor shipped.
> > > If we're gonna get the information from DT, we already have something
> > > that we can look at to perform the disable as the cpu compatibles give
> > > us enough information to make the decision.
> > >
> > > I also think that we could just cache the boot CPU's marchid/mvendorid,
> > > since we already have to look at it in riscv_fill_cpu_mfr_info(), avoid
> > > repeating these ecalls on all systems.
> > >
> > > Perhaps for now we could just look at the boot CPU alone? To my
> > > knowledge the systems that this targets all have homogeneous
> > > marchid/mvendorid values of 0x0.
> > 
> > It's possible I'm misinterpreting, but is the suggestion to apply the
> > marchid/mvendorid we find on the boot CPU and assume it's the same on
> > all other CPUs? Since we're reporting the marchid/mvendorid/mimpid to
> > usermode in a per-hart way, it would be better IMO if we really do
> > query marchid/mvendorid/mimpid on each hart. The problem with applying
> > the boot CPU's value everywhere is if we're ever wrong in the future
> > (ie that assumption doesn't hold on some machine), we'll only find out
> > about it after the fact. Since we reported the wrong information to
> > usermode via hwprobe, it'll be an ugly userspace ABI issue to clean
> > up.
> 
> You're misinterpreting, we do get the values on all individually as
> they're brought online. This is only used by the code that throws a bone
> to people with crappy vendor dtbs that put "v" in riscv,isa when they
> support the unratified version.

Not quite, the alternatives are patched before the other cpus are
booted, so the alternatives will have false positives resulting in
broken kernels.

- Charlie


