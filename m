Return-Path: <linux-kselftest+bounces-9813-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B17B8C1502
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 20:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 799031F2258D
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 18:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53117EF1C;
	Thu,  9 May 2024 18:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="G1C0l0pS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076757BAE4
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 18:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715280395; cv=none; b=jLGHXF/ijtlg5NVQBeLsTLwLjwP7DvM1D4L2q5HZbWBog5Tn9fHi31H2TbA6FGL7oDlHVH0jWVTHupveE1MK3NAQyaFi7zA8/Nur5ovNKu/Euy6NZxZRl4wiCVeAwAQnQtJKtdP8Fiy9HpktXOrt6SUxP1hbEnX9SItapr9h9Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715280395; c=relaxed/simple;
	bh=bVYyI3uNK8Ue9unjuecRzNC8ZDWp+FAsR3nmvBep48k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYcbBldhDSZ64PCOyaPX3d8lbQuycjc3DQqd40+8eFaWn8iXTYKXdQ2PXAGFc2eyl606fT9dPjnclTWwYfQaZMW+dZIttAPCCx3rr/YzQ8OTdhxe02QzaKSvlkw7hGb/GiUTRTil3trYwdpBCuMeH/bcflV3H22/2CaApzTFrDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=G1C0l0pS; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f467fb2e66so1130567b3a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 11:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715280392; x=1715885192; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8qs+zeJ73xYDCsb+04oKc8vKm2skXM6Yjmk5Cex/hmQ=;
        b=G1C0l0pSZ9WKAz3yBAJ34cjzN7oLHUiu/xl/t1kyW/hxNH3yObcTPTGas/rr/p2Z18
         /TXyiuu6/TX3ekHxPDwIu3N+lBaSAi9iKKdEFvy5eUnPV0f73jC564DS9vL+HnHwoIRm
         Ngy7IoO02hvOIrhdOLsNkc58Y8l05eJFsccJym3MqvSJb9SZOms5a843QXrC03zhxTIY
         0pi422VZEonhd7O2QA3fHRz5Tz7vQmjEX1CLFDGIf5eVOP8IBjTvmOhcY1I/WZ96zGqM
         a7BegrvAs4EmhgMXGWTAfqsbPYBtYIvgDf/muwMD0qsv1G2HjT+L28xrXuG7B5oakLsv
         oxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715280392; x=1715885192;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8qs+zeJ73xYDCsb+04oKc8vKm2skXM6Yjmk5Cex/hmQ=;
        b=qUl0fD0v+4YX1iusWFJ9PvlN4dEqvi1P7VyJnaoCwm3A31pOeYpLY9YID0j/N1J7Mw
         Wun9IDk4oQY6gEpqSZT44fL7OvQDDBvckyic+RqWK8vkWxpIztyzdGMDyDqScITjgBav
         f4jkUbnDTJvZt3KHZ3+pM3P+0PeMHgin4eHvxposQGLrYWTPAEomz6cJ/oiLr3v6yJ6D
         OhTLC9T0bh4LvR6DVVJz+Bq5SiVUMUTMuYmOne8Ze92eKikj/Iyt16po/v4upDMPZVgI
         +SIvoGw+4qINRIg9BWbl/K4d4lsKJUG6idINcE1dy5FuqWEZQ3CuJ+iC71/4FMVuAWJ6
         bAZw==
X-Forwarded-Encrypted: i=1; AJvYcCUokXnQR3OIlhJotVCfh9IgHba4dOLKpWbsKfJlIib6mXNKPBinqh8v1IcncGpZn+zNcVeVFMztPr0aPj48qZT713Hrv4i2I9ku5Qus0aQj
X-Gm-Message-State: AOJu0Yzebm9D1yo+erLRqyKUv7AzKAsEjInWyTc7MNVfC102EuOeQprO
	RSOpE4Zp1gwoMEyTtC+/1LokTcR5QwF6K04MY3Ejw3KgroF1BUvpCdKWIV/JZ+M=
X-Google-Smtp-Source: AGHT+IHSkbFTtM14eAz4leAGtq7pP+xnyJh4LBmDtig93VWvmXkOMQqIKOUJFRYjpBP4l5vncaDl3Q==
X-Received: by 2002:a05:6a20:7486:b0:1af:889e:8b06 with SMTP id adf61e73a8af0-1afde10ad77mr864261637.35.1715280392190;
        Thu, 09 May 2024 11:46:32 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2afa7b5sm1607660b3a.163.2024.05.09.11.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 11:46:31 -0700 (PDT)
Date: Thu, 9 May 2024 11:46:26 -0700
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
Message-ID: <Zj0aAiZiTrt9ACjj@debug.ba.rivosinc.com>
References: <20240403234054.2020347-1-debug@rivosinc.com>
 <20240403234054.2020347-5-debug@rivosinc.com>
 <20240410115806.GA4044117-robh@kernel.org>
 <CAKC1njSsZ6wfvJtXkp4J4J6wXFtU92W9JGca-atKxBy8UvUwRg@mail.gmail.com>
 <20240415194105.GA94432-robh@kernel.org>
 <Zh6c0FH2OvrfDLje@debug.ba.rivosinc.com>
 <20240509-cornflake-foyer-e6589c2bc364@spud>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240509-cornflake-foyer-e6589c2bc364@spud>

On Thu, May 09, 2024 at 07:14:26PM +0100, Conor Dooley wrote:
>On Tue, Apr 16, 2024 at 08:44:16AM -0700, Deepak Gupta wrote:
>> On Mon, Apr 15, 2024 at 02:41:05PM -0500, Rob Herring wrote:
>> > On Wed, Apr 10, 2024 at 02:37:21PM -0700, Deepak Gupta wrote:
>> > > On Wed, Apr 10, 2024 at 4:58 AM Rob Herring <robh@kernel.org> wrote:
>> > > >
>> > > > On Wed, Apr 03, 2024 at 04:34:52PM -0700, Deepak Gupta wrote:
>> > > > > Make an entry for cfi extensions in extensions.yaml.
>> > > > >
>> > > > > Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> > > > > ---
>> > > > >  .../devicetree/bindings/riscv/extensions.yaml          | 10 ++++++++++
>> > > > >  1 file changed, 10 insertions(+)
>> > > > >
>> > > > > diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
>> > > > > index 63d81dc895e5..45b87ad6cc1c 100644
>> > > > > --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
>> > > > > +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
>> > > > > @@ -317,6 +317,16 @@ properties:
>> > > > >              The standard Zicboz extension for cache-block zeroing as ratified
>> > > > >              in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
>> > > > >
>> > > > > +        - const: zicfilp
>> > > > > +          description:
>> > > > > +            The standard Zicfilp extension for enforcing forward edge control-flow
>> > > > > +            integrity in commit 3a20dc9 of riscv-cfi and is in public review.
>> > > >
>> > > > Does in public review mean the commit sha is going to change?
>> > > >
>> > >
>> > > Less likely. Next step after public review is to gather comments from
>> > > public review.
>> > > If something is really pressing and needs to be addressed, then yes
>> > > this will change.
>> > > Else this gets ratified as it is.
>> >
>> > If the commit sha can change, then it is useless. What's the guarantee
>> > someone is going to remember to update it if it changes?
>>
>> Sorry for late reply.
>>
>> I was following existing wordings and patterns for messaging in this file.
>> You would rather have me remove sha and only mention that spec is in public
>> review?
>
>Nope, having a commit sha is desired. None of this is mergeable until at
>least the spec becomes frozen, so the sha can be updated at that point
>to the freeze state - or better yet to the ratified state. Being in
>public review is not sufficient.

Spec is frozen.
As per RVI spec lifecycle, spec freeze is a prior step to public review.
Public review concluded on 25th April
https://lists.riscv.org/g/tech-ss-lp-cfi/message/91

Next step is ratification whenever board meets.

>
>Cheers,
>Conor



