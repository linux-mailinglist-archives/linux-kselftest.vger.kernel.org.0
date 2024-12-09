Return-Path: <linux-kselftest+bounces-23042-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 644329E9830
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 15:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A8D4283BA1
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 14:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC931A2395;
	Mon,  9 Dec 2024 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9NKN6As"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432B71A238D;
	Mon,  9 Dec 2024 14:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733753063; cv=none; b=gxAHqIADBOg74f4UFDwlhdXpI8kSqDRqH78BrLcGHPXpatA/IR7TmsZtRlYj8Q3LOEIQQXuNdm/qdEAMK7PmcGNWvZ/UU7xdUV2puOy8IteZTeiBfbdZjKCem6GJWcAOgNrSCeK7cgMohjEguXySJ+ETqoTvyTpw/zmb+Pq8VDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733753063; c=relaxed/simple;
	bh=Blh9M++NexbuUr8YjiL5Frn5yP0TgePe9v6IIz6PckE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YqoDOATOPfeJRCFvzOMT0dbO3RY1neL5xSBMHLnow1CMytxhg1S/s8ME3IEmjQ69krWIiEDWhoVxCgk91ga8jwQqAH9K7NULo+7eJdiTtr75woAU62lUpzqdxyjoKU8el3oMzikoioB7VGd/OJz5PRmgOzFEG5bNBvSIsX6xATc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9NKN6As; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d3e6f6cf69so2819488a12.1;
        Mon, 09 Dec 2024 06:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733753060; x=1734357860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRIB2nsp6XQvGTjRfj9gLmtwiHmX0VmfSp+/67N6bk4=;
        b=e9NKN6Ash4BbhXwu05ZtZiH0myEAyZkuR14Yw0JrWIausskjZ/lHJcGV0DVyUvfCgg
         y2JKhoaI3p/qifMiYEqx537nW+JoT3owQC+mMT0GPMCkmOxuwSHF9XU0jvoZ+GaBcwAk
         wWTKNr2KvgW4i8R15fugP5W/s0McTJpY7hZsMdUlGE9olAzbyxrqEVF41TrELl96alae
         Q8G5kGjdiBCuFFqE4F+SDRGZdcgZ0Yluj5by8RM62wbXr0gqXwtwL6VjKlcntVxsRAL6
         WEAzKkTjqcAPhV4jMCEqo1yoOP0iizCEcmVdDwbBbaVRNccvydEtv5pNC5cf6pHqbQ7Y
         lDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733753060; x=1734357860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRIB2nsp6XQvGTjRfj9gLmtwiHmX0VmfSp+/67N6bk4=;
        b=cv5F+9TNqui5j79m7ZoXCI4rDrFfIL+eWQV24je8OhnEkzXzld823E/nbYKz2fE2Ag
         I8CXYrPWharOvUqh+/ZiWBZEspRURMC4Kle+bDLsh9Rje041roGByUmnvmNz5uhJ7M4m
         FcIuofoSAqBV+2JFUCV6/hOM0yxr5eWxbwq6euQ4OQNx79Xaa6H288OLuGeAS1PEf4Rr
         uWyvlzK6+mqNITDQy4stdlXAfapI+Qquceh6JH7Df1xUuu7SHPJ2nciyScyPNpZj+ytX
         pAwS52iev8m9KPQl6UR1qkBx0J5UJRizqiKcYUb1E9+JSKJeQfTxQ4Z1JgQtg6t2S3av
         8DvQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7NmQ2zgoZ7D/cbpes7wNUPNuLKZtERE6uzsKr/9iqDvIk4S87NiRJGBH0YgXRB1eF0/DQ5ky3wIeWXIydkRfU@vger.kernel.org, AJvYcCWYx/e75fjA4Wqu/GMVAYnO5BU9j0Zv3BG53aTl8U+7yIAilJbFHYp7DXfpfZDkVmCF1PUVky9d6Dnbj+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YziFxAr5Gmhk/OeWmpF9+1BcMvZfbrGHfCNtErpGsXzxMfgshoB
	OVE5i/hOxID+H3IKa5aMgm+JHa7AlG/M+/St3dTuWbaKl91tw+cyTAjkQVetyH7YWw+UDtI+JIR
	y/y1lDzkBfvnnZu3+hdYOb5NP5d8=
X-Gm-Gg: ASbGncs9YJYUOXkh+HvXSZbWQGmmwHZs0qQUQhWRjL1n4oX/iNITng8ZSbwoLGE8QkZ
	PoCq6KwsevX9jdCD8a6qoho+9SkNqeX4=
X-Google-Smtp-Source: AGHT+IF6X/kzxH3Ns+wbjh/5Xo1lmvVUUhvP4Yyf7YNVCDvPnVicgmfDSkqPzdtR5TSI3rJCAqzK2xJLJuc/ivp5hCk=
X-Received: by 2002:a05:6402:11d3:b0:5d2:2768:4f10 with SMTP id
 4fb4d7f45d1cf-5d3be6fc21amr11979842a12.17.1733753060004; Mon, 09 Dec 2024
 06:04:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209105237.10498-1-o451686892@gmail.com> <3279e669-1ee2-4792-9e10-8b40928de6b4@sirena.org.uk>
 <CAHk0Hov5k37=MtTBLWTj+Dwm4EXE0xGJS1Uc8xgyLtJxusqsww@mail.gmail.com>
 <c05f6ad8-2dc1-4ddb-b9c1-b2cddfe78819@sirena.org.uk> <CAHk0HotQ-=s+-FHh8pAOg10ivcRwqChG735qgDvuQd=4B1QQNA@mail.gmail.com>
 <678a223f-c4c7-4752-84b0-609acaa33ad6@sirena.org.uk>
In-Reply-To: <678a223f-c4c7-4752-84b0-609acaa33ad6@sirena.org.uk>
From: Weizhao Ouyang <o451686892@gmail.com>
Date: Mon, 9 Dec 2024 22:04:08 +0800
Message-ID: <CAHk0Hour4i92j70+C-x7BNGFoLhDEYW-1prU=R6rAX9T9T7auA@mail.gmail.com>
Subject: Re: [PATCH] kselftest/arm64: abi: fix SVCR detection
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 9:51=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>
> On Mon, Dec 09, 2024 at 09:26:01PM +0800, Weizhao Ouyang wrote:
>
> > > If we don't have SME we should be skipping over all the SME code and
> > > never even looking at the value of SVCR.  Looking at the current vers=
ion
> > > of the code it does that, it branches to check_sve_in if SME is not
> > > enabled.
>
> > Yes we should skip it, this is just a minor tweak based on the
> > current implementation, after all, we manually passed its value by
> > svcr_in.
>
> It's a fairly trivial tweak to make...  in any case, it looks like we
> also need the same change in the save path.

Yeah. I have encountered this issue with both QEMU and FVP. I can
help to add a check_sve_in similar to the fp testcase for the abi
testcase.

BR,
Weizhao

>
> > Which latest code version are you referring to? I think check_sve_in
> > is in fp testcase, not in the abi testcase. (checked the -next tree)
>
> Ah, yes sorry.

