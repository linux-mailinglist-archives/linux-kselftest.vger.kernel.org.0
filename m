Return-Path: <linux-kselftest+bounces-8181-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A60328A700E
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 17:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E9C028589B
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 15:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBFF1311B2;
	Tue, 16 Apr 2024 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ALW1WFmy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7E21311A8
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282262; cv=none; b=oMTjfL8kvDGAvEs0EE5l39llNGAIqIO8s3ztfrcPlQq47L3flY+JooVj/swtEoOyupl4tUUzD/2tOT3GtcsYWMHbQuQoJOCkUntJ1yaIig40h1rgi2bP4OBQXl33iIywATA+rl69F4m/SNorXcw1Eezu8YbbkBJAffNlN2eZjb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282262; c=relaxed/simple;
	bh=6tXNn+CXz7BrPC+7REh0M85C6tQtokLLBLVNUiDpCcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvdFE4ip+GSwTLD0+Lw6AmAITm0KdIeZsAR+cbWEa+4Q6RZzQL+dU4MJGQpKzYGkggNOnct6urmL5vTLQGTkNntEi0SAZ4cJX8otmMQ2Qx8EpkBH39dtjwP11SU/J+XlfImk4Y5h9nyyA0p3M7knSjhikKF6z6r8M9wpMWhqi/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ALW1WFmy; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ed112c64beso3674448b3a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 08:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713282260; x=1713887060; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e9KltKjoXDfkbWSeu7VmS8Z2kEX/B6kq3EkTIupIde8=;
        b=ALW1WFmyGAOBjA26OuF6npmDJO4C0WJZosTD4MYfWG8D5NfMlDjDp5Z/yk4dEsFyvo
         r/Va3vED+wOFwaNLp+mlE7wmemJPf5gukirE1LlpBwVHeeq5YEuWRjUzz6jpmE3u7DgD
         F9M0/heNm3B66Yk3bJMKnwIuv8OSsMoa5TOryF5/JN6AXH8u2VW/hiEC+31E78Ihqq7c
         Qh+wqWva6PUdF0lu8OxFsX0+ngjGNYaJGpPncDdeBNP0Saexofr/55RHR93YnQCMU6SR
         X2Vs7iC4OPQm8a14lWFgW6RUUIsDGVLbTZH3N9WWnrp/PbJ+kzBi7J6Yias7XEZ71XlZ
         C3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713282260; x=1713887060;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e9KltKjoXDfkbWSeu7VmS8Z2kEX/B6kq3EkTIupIde8=;
        b=Eqa95PlcJ06LVYLQ+6sT/4pM/5VpUDwh7xyBSeJx13YOolec2S/eniGkPLIpo8kMXd
         Xp2VyROgkEFs21dICngupMAm4B7/G52KnzIDBu5rr3fWwUr5vNy+l1zGctebzKlfNq1c
         Zr3kntGYN4VST3jDgLXa1qLi97BthZ1cZNxkPC5MgQlu0HvfhGYI6GEhXo+sHvqIkvTJ
         ITTyi0myk2GD6wCo6IqBc5NPEfuncfdIR6SVzgmOQecYzrRL5dRSqB0q7gQ75qPdpETo
         0llZ2RiPQVYtOhq3z8aCT8TV2IOhcqRK4w23YxyYXvsIgGR0MgcOn0dsOOo3QrzWBj9M
         +BKg==
X-Forwarded-Encrypted: i=1; AJvYcCWCbVOuevPQcaDg0qffA9uquFno2D8mzi8lOXiGfJECe9A8LG0vd7+lXnfsftTwjYb/NYT9rUSX1JNicAxsZ4REuuw8jL139cf4RyPD4OT7
X-Gm-Message-State: AOJu0YyjyioVn/dsm1xGLeR8HP7y7K2hLjvIXBs0n5tZSWjx8aRcSg4+
	wXgGT7aIVQd+bMLDQKF3/ccYZsIhfl8I6gXKxQl8Wp/Rmf5Sgb2hTmmjTHbYNkI=
X-Google-Smtp-Source: AGHT+IFNgClAgjt5IgadPoPwJJY8jHfiJ4L4eLugbC5yjDCPSYARmT9MsoiuwN97dJz0uoqxOuQM5A==
X-Received: by 2002:a05:6a21:1014:b0:1a9:c2a1:3ae2 with SMTP id nk20-20020a056a21101400b001a9c2a13ae2mr11175898pzb.4.1713282260198;
        Tue, 16 Apr 2024 08:44:20 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id q24-20020a62e118000000b006ecf76df20csm9154539pfh.158.2024.04.16.08.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 08:44:19 -0700 (PDT)
Date: Tue, 16 Apr 2024 08:44:16 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Rob Herring <robh@kernel.org>
Cc: paul.walmsley@sifive.com, rick.p.edgecombe@intel.com,
	broonie@kernel.org, Szabolcs.Nagy@arm.com, kito.cheng@sifive.com,
	keescook@chromium.org, ajones@ventanamicro.com,
	conor.dooley@microchip.com, cleger@rivosinc.com,
	atishp@atishpatra.org, alex@ghiti.fr, bjorn@rivosinc.com,
	alexghiti@rivosinc.com, samuel.holland@sifive.com, conor@kernel.org,
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org, corbet@lwn.net, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, krzysztof.kozlowski+dt@linaro.org,
	oleg@redhat.com, akpm@linux-foundation.org, arnd@arndb.de,
	ebiederm@xmission.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	lstoakes@gmail.com, shuah@kernel.org, brauner@kernel.org,
	andy.chiu@sifive.com, jerry.shih@sifive.com,
	hankuan.chen@sifive.com, greentime.hu@sifive.com, evan@rivosinc.com,
	xiao.w.wang@intel.com, charlie@rivosinc.com,
	apatel@ventanamicro.com, mchitale@ventanamicro.com,
	dbarboza@ventanamicro.com, sameo@rivosinc.com,
	shikemeng@huaweicloud.com, willy@infradead.org,
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
Message-ID: <Zh6c0FH2OvrfDLje@debug.ba.rivosinc.com>
References: <20240403234054.2020347-1-debug@rivosinc.com>
 <20240403234054.2020347-5-debug@rivosinc.com>
 <20240410115806.GA4044117-robh@kernel.org>
 <CAKC1njSsZ6wfvJtXkp4J4J6wXFtU92W9JGca-atKxBy8UvUwRg@mail.gmail.com>
 <20240415194105.GA94432-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240415194105.GA94432-robh@kernel.org>

On Mon, Apr 15, 2024 at 02:41:05PM -0500, Rob Herring wrote:
>On Wed, Apr 10, 2024 at 02:37:21PM -0700, Deepak Gupta wrote:
>> On Wed, Apr 10, 2024 at 4:58 AM Rob Herring <robh@kernel.org> wrote:
>> >
>> > On Wed, Apr 03, 2024 at 04:34:52PM -0700, Deepak Gupta wrote:
>> > > Make an entry for cfi extensions in extensions.yaml.
>> > >
>> > > Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> > > ---
>> > >  .../devicetree/bindings/riscv/extensions.yaml          | 10 ++++++++++
>> > >  1 file changed, 10 insertions(+)
>> > >
>> > > diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
>> > > index 63d81dc895e5..45b87ad6cc1c 100644
>> > > --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
>> > > +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
>> > > @@ -317,6 +317,16 @@ properties:
>> > >              The standard Zicboz extension for cache-block zeroing as ratified
>> > >              in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
>> > >
>> > > +        - const: zicfilp
>> > > +          description:
>> > > +            The standard Zicfilp extension for enforcing forward edge control-flow
>> > > +            integrity in commit 3a20dc9 of riscv-cfi and is in public review.
>> >
>> > Does in public review mean the commit sha is going to change?
>> >
>>
>> Less likely. Next step after public review is to gather comments from
>> public review.
>> If something is really pressing and needs to be addressed, then yes
>> this will change.
>> Else this gets ratified as it is.
>
>If the commit sha can change, then it is useless. What's the guarantee
>someone is going to remember to update it if it changes?

Sorry for late reply.

I was following existing wordings and patterns for messaging in this file.
You would rather have me remove sha and only mention that spec is in public
review?

>
>Rob

