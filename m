Return-Path: <linux-kselftest+bounces-9909-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3108C19E7
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 01:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D40F1C216BF
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 23:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949F012FB0B;
	Thu,  9 May 2024 23:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Lx7l0FQi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512BC12DD82
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 23:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715297192; cv=none; b=YDkmaNmRq0BzGRZH3gfLBSaYuhKtZbgDPJBpVk6kDuPAoslHGMQBpjAYmpmNKh8iFPur/ZcvM1ZhxXIoQSmwi6LHWP5/0A+sEplICRHkigKlKw6Lnw2mSJFv1AsaRGKO9iIwCmfZB4D2JKbrN8OL/y13ycYKXP1u1Z7fm5pEP00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715297192; c=relaxed/simple;
	bh=TtTIVr+7zspIAFnpGX8YJqM+7kUQcGBFCu/z/SDDPAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBwUhUPWJKc7iYfmT5NtdVT7yvR/g9Y3t+cSriYXYxxVFndsmzZf2F3ceVyLisOblAmI0H7turmK3KGiOQi20kYkD3bVIAqvS36Hv7EE2craR1rDeXevL3a944CsADtm2eW9DjD5xON0i9st1dPG8B7qd6/rMY6e0eCEf042jNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Lx7l0FQi; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e4c4fb6af3so8867085ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 16:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715297189; x=1715901989; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KoGFJaD8EljLtrVmLvtlC7K76bro4/HY8QoalZin5IY=;
        b=Lx7l0FQi4l2AV47jWZ+VdWcHjpBJJ50cuf66IdLPN5DJBpFCsCL5cOb7Pd6WvraVrO
         fwDBtXG18LhZ+tqD5QD1EQV1xfuKIKiqMkXg6ttYPMwspAeLvjO/kTpBxz4Bs6mtU7VT
         ko1nj7g5RAuEErvxeIIehgBJ1O2GAGsEwNCKxaKe8aA+G223tRZURDCnpsxuvZ8yGqfe
         EHGVdlC+qp2S2Fh1UG4BROVluQtpvv9JxjX6RBgWzgg0nLkpImRL3eUN5PfGad2iwuWo
         76D4o3q9CSOiJPtXhAtY9LukNUJFx774Pe2WyzhPuZWnWUjUnA/Eq8fPTE0OiL9vEDYW
         skZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715297189; x=1715901989;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KoGFJaD8EljLtrVmLvtlC7K76bro4/HY8QoalZin5IY=;
        b=vxIQRBWIZP+qP8jyBmi+i9mZIuN/9cXkOgKu33rYNY1a02UrUjjZ5Jd487C7BkSDw2
         j04om3Na4Q2wiqRAtgNRpMlPW6bwduA66Kra5V2yW13h/mTbkryO2C5iu+8O0dNlXCUj
         uRsECUcV1RZ5qf2VwNlVrDZUMRkYFpsA8InbsmWyCJhIJgj8VtyN4I1T5C4Xydigv0Vv
         ogRbBXsJgjLFlQcNVk4VSWYYnkwumKzQnizTQeDCMFbCkGdkcgUeJl64Rrk0wYXB0JyW
         pU7NNqkv2nMU9zc+TlVDyEm91W0VTavmyjfq2XMIoLmIxgCteulPXVWW66anXFUA+sup
         2xYA==
X-Forwarded-Encrypted: i=1; AJvYcCXRL2KMnqZtPc8YNjo3bWwr04b0GXqhYth4IVhev95GM9FaSRrcxsSk6lmKONVMEQV39uYNVmqJJbp6MwVAIHxaVeOw1bM5wPoKXrqawyJL
X-Gm-Message-State: AOJu0YxDwsvaP58EFoxZ5S+MPYt5qjzObe3/vyHqdDyFiFoEUiEQulBu
	DK2Deg1tc1ggOehugufTF4uEdE1xNt28rs4wuEgFdz+CeJt3iHLEGHTFse9z41Q=
X-Google-Smtp-Source: AGHT+IEwp50qVSxIKzd3GeAEglFyHmirCQzUqIVxpG0w7MU50Y7SrsfbjsJXYlPTm4I0tHeIzltszA==
X-Received: by 2002:a17:902:c402:b0:1eb:e40:3f74 with SMTP id d9443c01a7336-1ef432a092emr15262985ad.32.1715297189377;
        Thu, 09 May 2024 16:26:29 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d1758sm19701355ad.28.2024.05.09.16.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 16:26:28 -0700 (PDT)
Date: Thu, 9 May 2024 16:26:24 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, paul.walmsley@sifive.com,
	rick.p.edgecombe@intel.com, broonie@kernel.org,
	Szabolcs.Nagy@arm.com, kito.cheng@sifive.com, keescook@chromium.org,
	ajones@ventanamicro.com, conor.dooley@microchip.com,
	cleger@rivosinc.com, atishp@atishpatra.org, alex@ghiti.fr,
	bjorn@rivosinc.com, alexghiti@rivosinc.com,
	samuel.holland@sifive.com, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
	corbet@lwn.net, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	krzysztof.kozlowski+dt@linaro.org, oleg@redhat.com,
	akpm@linux-foundation.org, arnd@arndb.de, ebiederm@xmission.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, lstoakes@gmail.com,
	shuah@kernel.org, brauner@kernel.org, andy.chiu@sifive.com,
	jerry.shih@sifive.com, hankuan.chen@sifive.com,
	greentime.hu@sifive.com, evan@rivosinc.com, xiao.w.wang@intel.com,
	charlie@rivosinc.com, apatel@ventanamicro.com,
	mchitale@ventanamicro.com, dbarboza@ventanamicro.com,
	sameo@rivosinc.com, shikemeng@huaweicloud.com, willy@infradead.org,
	vincent.chen@sifive.com, guoren@kernel.org, samitolvanen@google.com,
	songshuaishuai@tinylab.org, gerg@kernel.org, heiko@sntech.de,
	bhe@redhat.com, jeeheng.sia@starfivetech.com, cyy@cyyself.name,
	maskray@google.com, ancientmodern4@gmail.com,
	mathis.salmen@matsal.de, cuiyunhui@bytedance.com,
	bgray@linux.ibm.com, mpe@ellerman.id.au, baruch@tkos.co.il,
	alx@kernel.org, david@redhat.com, catalin.marinas@arm.com,
	revest@chromium.org, josh@joshtriplett.org, shr@devkernel.io,
	deller@gmx.de, omosnace@redhat.com, ojeda@kernel.org,
	jhubbard@nvidia.com
Subject: Re: [PATCH v3 04/29] riscv: zicfilp / zicfiss in dt-bindings
 (extensions.yaml)
Message-ID: <Zj1boEJG4ijcdNi0@debug.ba.rivosinc.com>
References: <20240403234054.2020347-1-debug@rivosinc.com>
 <20240403234054.2020347-5-debug@rivosinc.com>
 <20240410115806.GA4044117-robh@kernel.org>
 <CAKC1njSsZ6wfvJtXkp4J4J6wXFtU92W9JGca-atKxBy8UvUwRg@mail.gmail.com>
 <20240415194105.GA94432-robh@kernel.org>
 <Zh6c0FH2OvrfDLje@debug.ba.rivosinc.com>
 <20240509-cornflake-foyer-e6589c2bc364@spud>
 <Zj0aAiZiTrt9ACjj@debug.ba.rivosinc.com>
 <20240509-clatter-crewmate-9755669b9452@spud>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240509-clatter-crewmate-9755669b9452@spud>

On Thu, May 09, 2024 at 09:32:49PM +0100, Conor Dooley wrote:
>On Thu, May 09, 2024 at 11:46:26AM -0700, Deepak Gupta wrote:
>> On Thu, May 09, 2024 at 07:14:26PM +0100, Conor Dooley wrote:
>> > On Tue, Apr 16, 2024 at 08:44:16AM -0700, Deepak Gupta wrote:
>> > > On Mon, Apr 15, 2024 at 02:41:05PM -0500, Rob Herring wrote:
>> > > > On Wed, Apr 10, 2024 at 02:37:21PM -0700, Deepak Gupta wrote:
>> > > > > On Wed, Apr 10, 2024 at 4:58 AM Rob Herring <robh@kernel.org> wrote:
>> > > > > >
>> > > > > > On Wed, Apr 03, 2024 at 04:34:52PM -0700, Deepak Gupta wrote:
>> > > > > > > Make an entry for cfi extensions in extensions.yaml.
>> > > > > > >
>> > > > > > > Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> > > > > > > ---
>> > > > > > >  .../devicetree/bindings/riscv/extensions.yaml          | 10 ++++++++++
>> > > > > > >  1 file changed, 10 insertions(+)
>> > > > > > >
>> > > > > > > diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
>> > > > > > > index 63d81dc895e5..45b87ad6cc1c 100644
>> > > > > > > --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
>> > > > > > > +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
>> > > > > > > @@ -317,6 +317,16 @@ properties:
>> > > > > > >              The standard Zicboz extension for cache-block zeroing as ratified
>> > > > > > >              in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
>> > > > > > >
>> > > > > > > +        - const: zicfilp
>> > > > > > > +          description:
>> > > > > > > +            The standard Zicfilp extension for enforcing forward edge control-flow
>> > > > > > > +            integrity in commit 3a20dc9 of riscv-cfi and is in public review.
>> > > > > >
>> > > > > > Does in public review mean the commit sha is going to change?
>> > > > > >
>> > > > >
>> > > > > Less likely. Next step after public review is to gather comments from
>> > > > > public review.
>> > > > > If something is really pressing and needs to be addressed, then yes
>> > > > > this will change.
>> > > > > Else this gets ratified as it is.
>> > > >
>> > > > If the commit sha can change, then it is useless. What's the guarantee
>> > > > someone is going to remember to update it if it changes?
>> > >
>> > > Sorry for late reply.
>> > >
>> > > I was following existing wordings and patterns for messaging in this file.
>> > > You would rather have me remove sha and only mention that spec is in public
>> > > review?
>> >
>> > Nope, having a commit sha is desired. None of this is mergeable until at
>> > least the spec becomes frozen, so the sha can be updated at that point
>> > to the freeze state - or better yet to the ratified state. Being in
>> > public review is not sufficient.
>>
>> Spec is frozen.
>> As per RVI spec lifecycle, spec freeze is a prior step to public review.
>> Public review concluded on 25th April
>> https://lists.riscv.org/g/tech-ss-lp-cfi/message/91
>>
>> Next step is ratification whenever board meets.
>
>Ah, I did the "silly" thing of looking on the RVI website at extension
>status (because I never know the order of things) and these two
>extensions were marked on there as being in the inception phase, so I
>incorrectly assumed that "public review" came before freeze.
>Freeze is the standard that we have been applying so far, but if
>ratification is imminent, and nothing has changed in the review period,
>then it seems sane to just pick the freeze point for the definition.

Yeah I don't think wiki is that regularly updated.
But take a look at Ratification-Ready list of specs here
https://wiki.riscv.org/display/HOME/RISC-V+Specification+Status

>
>Cheers,
>Conor.



