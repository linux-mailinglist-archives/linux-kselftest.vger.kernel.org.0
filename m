Return-Path: <linux-kselftest+bounces-23634-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3849F8916
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 01:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C250C16D2F9
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 00:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942802594B2;
	Fri, 20 Dec 2024 00:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1aXPaTi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4A8D530;
	Fri, 20 Dec 2024 00:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734655394; cv=none; b=FKvIyLBzKtCOjv2fZ1AQAQjjI4TiV4o9jbd+VTs+sTqUxXXu7vlGyOKIVtaqTtlRjN0fyylLCGQ+Z7qP+2g4OJjtO97v+Wgdn5hn3rh0ZEI0lNojD9nRUhe8RvTXKeZq/SHZS6ndO8A0sRMM6emn3fDccxW53hlvd56E9GZG0fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734655394; c=relaxed/simple;
	bh=SxhJCA6frG3hYERbZn10hcmb4eIUIqwX6zW3bIhY5ck=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=opWWllu4ayxnQqwpJTlV3w94unzcaDCrvY2V/bi0NgAffycBFy1aAmvEHkIdc97i6GiUJzQ3or4SuBv86sGE+TSWpRP0BjQK9iLXxBmMYvyND7BOLt5dyf8THBbeqbARvYYTaVMJboXaPWxkGS1QrLMjQz246gSP0cxteOfwSYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1aXPaTi; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7273967f2f0so1690637b3a.1;
        Thu, 19 Dec 2024 16:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734655392; x=1735260192; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FClpBZU+qWJqECPg3q2XBSmJK26HwO7yZcjNg058Aic=;
        b=H1aXPaTiw2HFncfkmzSxYJMpWJjh/U5PmKlsGpKb1sPPtI0T2gXaxG/Zasw6j6bbXv
         e4ItNUjfjzvZnK5RkQLM1h6ZIYnLsF2QNdlR9mq7xDCTLtF9FZ8aLS8WxOzC6TI5BPaP
         OQpjPo9xsIBfFA87IzKcM5VO9k1OI1RTxcDK6dXsmfI4v6ljwcvrwdBmFfXwwf1quJGb
         7rMj0HdSTdf8/XTq1bOx7t4m+A1YKh75Ojl2XiHWnRpUnsA+h3M5wXDUrMT+uY2j4a17
         ygJHRlwzV4xii/4+yPxCv2dLPxs/PNKsghZrHpk1P7i13zYpRqrjA1qn1oKJo1nbtjKc
         jmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734655392; x=1735260192;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FClpBZU+qWJqECPg3q2XBSmJK26HwO7yZcjNg058Aic=;
        b=xFInn5ZcAQ5JY77oN7TXfRbpm+GCyWiFtD74xjDOsypuON7Z79OVzq37i879ME4mqO
         rVWco1YV0MImVj8lKJvuJkx4ojEFKctKftc40PdWy0dLz1Z6r+0VN8SPd/e3LMcY6UjG
         EagZ+lWr1m8GQQcX4UUGuholrsn5hBsu/q7fBiI/sjdqcK1AWRMxz5jti6kK+OuCCj9t
         uKSj25/FVf6MEzicaMGH/QiQwMWDT/kDsahmz5X7pFfZmpG2/VZQ2sktvwb7YZC3lnZe
         hZZgjlWh0sQ0iB4GpdUFYPgV8eamg+fJUZ7GqggxI1taJcoQsw0n4xVIt/tdDSJAWNl7
         TMBg==
X-Forwarded-Encrypted: i=1; AJvYcCUCZt8js3f4euqKC/veAqqF163SyCqEVcEaHMh1Z4nnYcrRhW8TLCA5Fhj1xvRQLlhb03qm7otw+eUE4m3sWZCB@vger.kernel.org, AJvYcCUHXlMbMmeDBF6y6vSea8vLRlL2MxFBj8KNN0ZStwe387W8vsclnWL/od52+9bWp+G+oWs=@vger.kernel.org, AJvYcCXBTEsn3Hf8HICfdWBq4SFu0pPEhSOPboTzVkciZkW88N/mER9GBX574/02gTPypxvmu6hn0+eL@vger.kernel.org, AJvYcCXa7Dr9IIIAHRfYeLRtSkX9tWWDynLaKFDlLj0ligI7Tieau3+sgDtbI1ERG/KOpGVGHU2l/DanMVcVLI8M@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7/zQEPkFwEQdaQrrTVfY9zhw+ZJbuTtXdtGDnFooT4eywaMCx
	e7scNTZkOrw8qcXTUfHSkSrzszHkHr9Dc1ZBBXBY3VoidfJpMyfG
X-Gm-Gg: ASbGnctwQV1+skw+DbGR0m3Uk8rahrSsj3TJi6/Hewfg+Aj/o3m380jN7rfgW2+PADf
	CscApTFlHTETNvEKLpS42ytTPW2pOU8YI5xhD7QGqQ4tIjNri5rGDSAwxJdexX4UZ61yU/93K2R
	F7OQo+kQBQ/4rbBOG8pCC7UeQ/m/7R7AhUqViiCtW5YuPm5lfYbuk6OIU/ik2p3UAK357FWsVRL
	1hjFdKkZN1spFo4gyZDFfjh/w8xLlS5Pcx1Qnsb/NYcfsCrOmXzJKNLkx8p+W0smjMY6RIKtn8J
	xRPVFl8=
X-Google-Smtp-Source: AGHT+IHHC3TA3BDEKz1Boac0NTiWYyt+flxmZT6PTXjUa++o72xiNnPUk5Q0m5OYYK/RY+j32Ae80Q==
X-Received: by 2002:a05:6a00:3996:b0:725:9d70:6ace with SMTP id d2e1a72fcca58-72abdd8c362mr1083098b3a.6.1734655392044;
        Thu, 19 Dec 2024 16:43:12 -0800 (PST)
Received: from ?IPv6:2620:10d:c096:14a:6d82:facf:302d:61b7? ([2620:10d:c090:600::1:12c7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8164desm1945124b3a.18.2024.12.19.16.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 16:43:11 -0800 (PST)
Message-ID: <d0b5e424445f498fdedca04fd4b0f138fbb6ae36.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 4/5] bpf: verifier: Support eliding map
 lookup nullness
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, andrii@kernel.org, 
 ast@kernel.org, shuah@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com,  martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org,  sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,  bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org
Date: Thu, 19 Dec 2024 16:43:08 -0800
In-Reply-To: <f7taicw6c3f3yae4d6lrdagv26jiuihumklo4tkmqduvauargi@ld4bcmsbbiqn>
References: <cover.1734045451.git.dxu@dxuuu.xyz>
	 <92065ca054beccd6d0f35efe9715ef965e8d379f.1734045451.git.dxu@dxuuu.xyz>
	 <CAEf4BzaqCgW9keiT+tJUBQWT6Q+jMwuvn4O2ZghO0c+ZvACNrw@mail.gmail.com>
	 <zow3q3nhlz6vedbni3upag5yr7zzrhyiqysl5nwyubebmbwojk@th7kbm62x36g>
	 <31b0c85dbf85486df116ade20caf8685843899b4.camel@gmail.com>
	 <CAEf4BzaEOBtrSWZTx40AdT=SQY6Qaia405KWgU-NowaqNdmpkA@mail.gmail.com>
	 <kghvgxu5wdkupssnq7dy5upuf2wscsxgsnwl2yoam4mwk3h5pn@wjjsliwg6fzl>
	 <a2999d8b4827516fe4bfd17646d2284580712d08.camel@gmail.com>
	 <f7taicw6c3f3yae4d6lrdagv26jiuihumklo4tkmqduvauargi@ld4bcmsbbiqn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-12-19 at 17:40 -0700, Daniel Xu wrote:

[...]

> > Ok, thinking a bit more, the best test I can come up with is:
> >=20
> >   u8 vals[8];
> >   vals[0] =3D 0;
> >   ...
> >   vals[6] =3D 0;
> >   vals[7] =3D 0xf;
> >   p =3D bpf_map_lookup_elem(... vals ...);
> >   *p =3D 42;
> >=20
> > For LE vals as u32 should be 0x0f;
> > For BE vals as u32 should be 0xf000_0000.
> > Hence, it is not safe to remove null check for this program.
> > What would verifier think about the value of such key?
> > As far as I understand, there would be stack zero for for vals[0-6]
> > and u8 stack spill for vals[7].
>=20
> Right. By checking that spill size is same as key size, we stay endian
> neutral, as constant values are tracked in native endianness.
>=20
> However, if we were to start interpreting combinations of STACK_ZERO,
> STACK_MISC, and STACK_SPILL, the verifier would have to be endian aware
> (IIUC). Which makes it a somewhat interesting problem but also requires
> some thought to correctly handle the state space.

Right.

> > You were going to add a check for the spill size, which should help her=
e.
> > So, a negative test like above that checks that verifier complains
> > that 'p' should be checked for nullness first?
> >=20
> > If anyone has better test in mind, please speak-up.
>=20
> I think this case reduces down to a spill_size !=3D key_size test. As lon=
g
> as the sizes match, we don't have to worry about endianness.

Agree.

