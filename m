Return-Path: <linux-kselftest+bounces-9770-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D716C8C0BC8
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 08:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50CC51F2138E
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 06:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3E61272A8;
	Thu,  9 May 2024 06:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TtbtRhxC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19B41373
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 06:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715237804; cv=none; b=hOwzZYXGfcNl7lD/fmzopvXK3GloS3BpO9SHH3XUxhOuWBcleevVOHabYGpFafJSYbEf763Ghr+0m+rA5hwOguiSxsdyN9rzdiDE6kBzCqUKFqpqip5Bue6JiH5ZwSdtt5Qclps73uMcBZBnyJebGQeu1jaBfqC/vIlno6hCcJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715237804; c=relaxed/simple;
	bh=qMk1PdT+iPPJAba1vs0taTftishgYTmWVXA0TThaZfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W6U0AvZNlh+2g4Fw7HaIJmKnk9PT7fXm4nOh7QL8Z9N6F9aLKi6WozZx25TtVa8AzCfujLr0DUx2LWd1THV4SSLUi/+f4XpD7j/df8FOb+zHaTIJ/wq27yeXHoZr5ElJca1PonR6P1meCS5nKqS3DazI5emwq/IAkS8BOAfWjH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=TtbtRhxC; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-61be74097cbso5474117b3.1
        for <linux-kselftest@vger.kernel.org>; Wed, 08 May 2024 23:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715237802; x=1715842602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VaF65Mth8rDaiy1Bx7eDA2aD8YWaoQ7AgHRL/QGNHIg=;
        b=TtbtRhxCHBFjy6bHolE3ZrCu96bdCOh13MQ+kXrhp9dMfcPglz3SLoc4BrSbvlL4dX
         7MUoNBKH27UCtkjgWfVjl3thZFWqBpJqy5wZ3eNZDKn1+G/KxH7Ug+gdPDNO4Px/+HA+
         E93FUMS3jI6aXzlseFgT0y++0ck0Ewp72md4v0qvvfAB8/cD4M/oWU8zfJq8u+ILhxNR
         iPa+oWYEp6x8Zmvo7H+j1Y8tzsDTt+yqJAEFOVRNiuIclcXl7xLpDXXY/OWTmgTs8ogk
         mLISZcKSBgoFxKJJDp4uYddqwOfZ8u+jMfgZ5W7/K6FObwwwegBsWc7GGzhz1aQYQQOM
         bNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715237802; x=1715842602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VaF65Mth8rDaiy1Bx7eDA2aD8YWaoQ7AgHRL/QGNHIg=;
        b=F1pWyFs63EodWFd4YzjCxzVK57hWTyT22hNOtdJeVGRg7U6zaqx4ZjdtNVL5qgfxGJ
         Rn5gR2XXcsgZZ2LbuaS+UV723SK7WJoIbDNYG44Q/s5wQSgvrpSRZoeSEDl6n8dThXQa
         nL+yyGQhaIokhDhd6tqKLmGFytKZwDWkwyb2iLbbSIhLEXgXQI9jGeD8Am6AvJKdlozg
         FWkhpwfFAbcWc+APM0Qw/og5dFNfU4RlPYvRwNmYlc2MXlq++8YuQwczgJhGOroDfRWB
         gGBKcK1oJxEPyMQhgSbpnO9T8I4zchYbJs1AH/hi+RHe3D7roPabll2p+Alx8N1qNaZj
         efKw==
X-Forwarded-Encrypted: i=1; AJvYcCV0vG1i7WDc1px/sRa0pLqXPby/oSMmN8WQm2devNWJM9ywg3rqOKVp063en6WTbPDY0RqNHq54aOnFalUKJokMlA+MphNA4Xw21YEMt/GW
X-Gm-Message-State: AOJu0Yz0Htnx5Fpd4f+4IWgrFGRfsM0TUVQKtAGivCtzPAnIf/+FZtcf
	uruWXBn2WYXp42KHZCHDhjZHadaxkOr9ujQyfVq9ln+VvvZ/EVswF58vP0RypUkyvK7BHPL9f5X
	poJmoDOvdeTe/CIF86tVQQiytXYX1GmBIePLXqg==
X-Google-Smtp-Source: AGHT+IFcRu416dvzSI2zoj2G7WcOFjTosCWbtC1c8KEzGSwEnHegTPHoEH/G3MULJAHlFRyEU5wzPOnrCvubOCTr4OM=
X-Received: by 2002:a81:928c:0:b0:61b:3304:cdc7 with SMTP id
 00721157ae682-62085a747b9mr50296887b3.29.1715237801602; Wed, 08 May 2024
 23:56:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412-zve-detection-v4-0-e0c45bb6b253@sifive.com>
 <20240412-zve-detection-v4-7-e0c45bb6b253@sifive.com> <20240418-brook-chili-4d3e61d1a55c@wendy>
 <20240418155256.GA2410@sol.localdomain> <20240418-ultimatum-yam-11de4b063b83@spud>
 <20240418173203.GA1081@sol.localdomain> <20240418173946.GB1081@sol.localdomain>
 <20240418-sterling-sanding-d59c3b0a2aaa@spud>
In-Reply-To: <20240418-sterling-sanding-d59c3b0a2aaa@spud>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Thu, 9 May 2024 14:56:30 +0800
Message-ID: <CABgGipU74TA3KgCH4pPuRefbnYt3q6RKcQwfyspenisEtY6eqw@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] riscv: vector: adjust minimum Vector requirement
 to ZVE32X
To: Conor Dooley <conor@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Jonathan Corbet <corbet@lwn.net>, Evan Green <evan@rivosinc.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Shuah Khan <shuah@kernel.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
	Vincent Chen <vincent.chen@sifive.com>, Greentime Hu <greentime.hu@sifive.com>, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Joel Granados <j.granados@samsung.com>, 
	Jerry Shih <jerry.shih@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Conor,

On Fri, Apr 19, 2024 at 2:26=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Thu, Apr 18, 2024 at 10:39:46AM -0700, Eric Biggers wrote:
> > On Thu, Apr 18, 2024 at 10:32:03AM -0700, Eric Biggers wrote:
> > > On Thu, Apr 18, 2024 at 05:53:55PM +0100, Conor Dooley wrote:
> > > > > If it would be useful to do so, we should be able to enable some =
of the code
> > > > > with a smaller VLEN and/or EEW once it has been tested in those c=
onfigurations.
> > > > > Some of it should work, but some of it won't be able to work.  (F=
or example, the
> > > > > SHA512 instructions require EEW=3D=3D64.)
> > > > >
> > > > > Also note that currently all the RISC-V vector crypto code only s=
upports riscv64
> > > > > (XLEN=3D64).  Similarly, that could be relaxed in the future if p=
eople really need
> > > > > the vector crypto acceleration on 32-bit CPUs...  But similarly, =
the code would
> > > > > need to be revised and tested in that configuration.
> > > > >
> > > > > > Eric/Jerry (although read the previous paragraph too):
> > > > > > I noticed that the sha256 glue code calls crypto_simd_usable(),=
 and in
> > > > > > turn may_use_simd() before kernel_vector_begin(). The chacha20 =
glue code
> > > > > > does not call either, which seems to violate the edict in
> > > > > > kernel_vector_begin()'s kerneldoc:
> > > > > > "Must not be called unless may_use_simd() returns true."
> > > > >
> > > > > skcipher algorithms can only be invoked in process and softirq co=
ntext.  This
> > > > > differs from shash algorithms which can be invoked in any context=
.
> > > > >
> > > > > My understanding is that, like arm64, RISC-V always allows non-ne=
sted
> > > > > kernel-mode vector to be used in process and softirq context -- a=
nd in fact,
> > > > > this was intentionally done in order to support use cases like th=
is.  So that's
> > > > > why the RISC-V skcipher algorithms don't check for may_use_simd()=
 before calling
> > > > > kernel_vector_begin().
> > > >
> > > > I see, thanks for explaining that. I think you should probably chec=
k
> > > > somewhere if has_vector() returns true in that driver though before
> > > > using vector instructions. Only checking vlen seems to me like rely=
ing on
> > > > an implementation detail and if we set vlen for the T-Head/0.7.1 ve=
ctor
> > > > it'd be fooled. That said, I don't think that any of the 0.7.1 vect=
or
> > > > systems actually support Zvkb, but I hope you get my drift.
> > >
> > > All the algorithms check for at least one of the vector crypto extens=
ions being
> > > supported, for example Zvkb.  'if (riscv_isa_extension_available(NULL=
, ZVKB))'
> > > should return whether the ratified version of Zvkb is supported, and =
likewise
> > > for the other vector crypto extensions.  The ratified version of the =
vector
> > > crypto extensions depends on the ratified version of the vector exten=
sion.
>
> That's great if it does require that the version of the vector extension
> must be standard. Higher quality spec than most if it does. But
> "supported" in the context of riscv_isa_extension_available() means that
> the hardware supports it (or set of harts), not that the currently
> running kernel does. The Kconfig deps that must be met for the code to be
> built at least mean the kernel is built with vector support, leaving only
> "the kernel was built with vector support and the hardware supports vecto=
r
> but for $reason the kernel refused to enable it".
>
> I'm not sure if that final condition is actually possible with the system
> ending up in a broken state, however - I'm not sure that we ever do turn
> off access to the VPU at present (after we mark it usable), and if we do
> it doesn't get reflected in has_vector() so the kernel and userspace woul=
d
> both break, with what a crypto driver does probably being the least of
> your worries.
>
> > > So
> > > there should be no issue.  If there is, the RISC-V core architecture =
code needs
> > > to be fixed to not declare that extensions are supported when they ar=
e actually
> > > incompatible non-standard versions of those extensions.  Incompatible
> > > non-standard extensions should be represented as separate extensions.
> > >
> >
> > It probably makes sense to check has_vector() to exclude Zve* for now, =
though.
>
> I think you might actually be better served at present, given the code ca=
n
> only be built if the core vector code is, by using
> riscv_isa_extension_available(NULL, v). That way you know for sure that
> you're getting the ratified extension and nothing else.
>
> Prior to this conversation I thought that has_vector() should return true
> if there's a standard compliant vector unit available - given all users
> Andy added only need Zve32x.
>
> > I am just concerned about how you're suggesting that non-standard exten=
sions
> > might be pretending to be standard ones and individual users of kernel-=
mode
> > vector would need to work around that.
>
> I am absolutely not suggesting that non-standard extensions should
> masquerade as standard ones, I don't know where you got that from. What
> I said was that a non-standard vector extension could reuse riscv_v_vlen
> (and should IMO for simplicity reasons), not that any of the APIs we have
> for checking extension availability would lie and say it was standard.
> riscv_v_vlen having a value greater than 128 is not one of those APIs ;)
>
> > I think that neither has_vector() nor
> > 'if (riscv_isa_extension_available(NULL, ZVKB))' should return true if =
the CPU's
> > vector extension is non-standard.
>
> riscv_isa_extension_available(NULL, ZVKB) only checks whether the extensi=
on
> was present in DT or ACPI for all harts. It doesn't check whether or not
> the required config option for vector has been set or anything related
> to dependencies. has_vector() at least checks that the vector core has
> been enabled (and uses the alternative-patched version of the check
> given it is used in some hotter paths). That's kinda moot for code
> that's only built if the vector core stuff is enabled as I said above
> though.
>
> We could of course make riscv_isa_extension_available() check
> extension dependencies, but I'd rather leave dt validation to the dt
> tooling (apparently ACPI tables are never wrong...). Either would allow
> you to rely on the crypto extensions present only when the standard vecto=
r
> extensions unless someone's DT/ACPI stuff is shite, but then they keep th=
e
> pieces IMO :)

Should we check if "v" presents for vector crypto extensions in
riscv_isa_extension_check()? We are not checking this for now. So a
kernel compiled with RISCV_ISA_V still has a problem if its isa-string
includes any of vector crypto ("zvbb, zvkg, etc") but not "v".

>
> Hope that makes sense?
> Conor.

Cheers,
Andy

