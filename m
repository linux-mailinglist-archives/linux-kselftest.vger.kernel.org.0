Return-Path: <linux-kselftest+bounces-26431-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B7DA318F7
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 23:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1791660AC
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 22:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D881B272909;
	Tue, 11 Feb 2025 22:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSsPSOiV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A68272906;
	Tue, 11 Feb 2025 22:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739313818; cv=none; b=uJLYPN4fa+2U0rEmXK3IErXybXfs2BsayDHy1bD0w1O43LjdTJnIdD20Zu+zomFtm0/p9T9y2gRni+y4dXt19gp8B5WQIJyWsO5kHcnhcVUQ1UGiYcdGv+TEXmZ9CzFP51zxXrKq8qxFXJZeGGIvGeh4SsduE62zAZ1R8BvjZwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739313818; c=relaxed/simple;
	bh=+P0q4a0fkVM7lU5+Wd/g02zcF7Ptx6plpBHI4r4wCY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PioVW811w3mvadfUlSAHA0HkbxDmWvBJgWkoxz/WGZLeFRY0vkTW3eqOo/lZhu2kuGayKr06N3oOiYQ8AePgRGc4kvmsqub+BVlRVvc/mgKKB2skS3+zn64K09QLZ/THh5tzxWae7k7Ywuwf2RB2Z/mO0HF0UzFV1+LgJq23vBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSsPSOiV; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30762598511so59759151fa.0;
        Tue, 11 Feb 2025 14:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739313815; x=1739918615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+P0q4a0fkVM7lU5+Wd/g02zcF7Ptx6plpBHI4r4wCY4=;
        b=XSsPSOiV03qBOMIcpWZHrILgSkrQKy/x8RQdlTr5qjED/IrHCquVMMVdIYTXjbLECd
         XtgeEFjNgtEA5Y5Kadn8axlxg7CZ80MMj/4PpFyFoE/PRb5p5sdAyCjM8F7JlQ94Fp87
         iKab8wyu4AJyVR2MSeoyZZlgDETYUq6oKcy1PuQ1TqkoNVTLVvrGVDnJ4UfNQmSUnfQZ
         OgRGh/svChaFPqPe/sACcLFk6UKkGaArar9NvE8Xy8aYbiuXBTOkcbqMoHl2zTC+NAkA
         cLSKPwP6IsXzrqvgel8VX3KYjhNpJYWUsqRQvtLZMBD1iRpfybwxX5CXCDGJZySnZTt5
         zRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739313815; x=1739918615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+P0q4a0fkVM7lU5+Wd/g02zcF7Ptx6plpBHI4r4wCY4=;
        b=sUcPrjvrF92F2fgBv8/UhbIoTHKFVh3xz/WG9EXOj/dE41uPXOaoSl+DzXyXXUZE8F
         tf4uLSew3F0fruzwkjABF8zyysyFcLp4hZ8swsjp84p+jzfdbKhL+L1cdzqIZzZHMc3R
         AnBoAS8iZXQ9FSs/qvXP6wC0X2GiJFnhIOV6Dbeix7IqLdWFKxBECQ98VWDN2JkDJbCc
         lRDkFuTdEA/IgG4895ZB65010dD6OAdH5YUpLbK0YfBcVrL6ppttLNktFRB/Zj7HGXK6
         E4sQilMtKQprqkkp/yCiLkekH8YTDHOrzgOSJPVLmtirTwXWZ3seEf5Qjd7SdLQ+EpJF
         Nu1g==
X-Forwarded-Encrypted: i=1; AJvYcCUa2haqIKQjBH7/IUH2XXHNy2TYeOjSBQqgQdBVttdGFQVaSSE+fVS8Ubo9F7Ubnmz+lsTNHr/NPTO6v9vpeocq@vger.kernel.org, AJvYcCXF+QkGpPO9nLjobAkoFX1edtVKROi7PvGBx7OQeQbUM+w2BXeQ6Agw3nehm2oQrTYfr79krkzJnHeL5iY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2No+oUL3iwruv+///1sBJxQpvWdl5MsTnCPgjQLfcLSs6FY8C
	D/GlPWhuBNiSkxbVFkdgkbVt58ffBwbDggxY1omrd78a/FRWfx5iBq4zeoBTHw3sEk/PSc5kXS9
	MHk9ggI1UvD+WO/qhXPvNcgeXB3M=
X-Gm-Gg: ASbGncuTzMJ4dceb7nFXyY8nckgmuwVLDdzRKoK1YQ5ub8nWef3V5IXCPj9wcjlsx6q
	8uSvn9Arp/Hft9et5Ey3rl7o9bkxuGDTLnz6nNaOeb/XjSeuxvbldmgEMYH+dFFTQSWxVz6lvSw
	UH4IlMHMk2T42h
X-Google-Smtp-Source: AGHT+IELdGNHUDK0UfZymCdzCGQppus55YE/nCQaFiA7ChFaTnW2wACEvhwP4JP61G9fF7ZueB1/JebEtHfPflOAhrg=
X-Received: by 2002:a05:651c:2205:b0:308:e8d3:7571 with SMTP id
 38308e7fff4ca-3090377bb96mr4324741fa.31.1739313815030; Tue, 11 Feb 2025
 14:43:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-ww_mutex-kunit-convert-v1-1-972f0201f71e@gmail.com> <Z6vRIZk7DsSNooFZ@boqun-archlinux>
In-Reply-To: <Z6vRIZk7DsSNooFZ@boqun-archlinux>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 11 Feb 2025 17:42:59 -0500
X-Gm-Features: AWEUYZmdVD87KgQWGbxD7rE2mUUzNYneLqMuLXWmOxVvy_-_F7I4uqgkp4eVj00
Message-ID: <CAJ-ks9=EfdCenpTjSdsaGhbUyJ99JYEL_nY0Y8RqzOxXKYWY5A@mail.gmail.com>
Subject: Re: [PATCH] ww_mutex: convert self-test to KUnit
To: Boqun Feng <boqun.feng@gmail.com>
Cc: David Gow <davidgow@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 5:38=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> Hi Tamir,

Hi Boqun, thanks for taking a look.

> On Mon, Feb 10, 2025 at 10:59:12AM -0500, Tamir Duberstein wrote:
> > Convert this unit test to a KUnit test.
> >
>
> I would like to know the pros and cons between kunit tests and
> kselftests, maybe someone Cced can answer that? It'll be good to put
> these in the commit log as well.

David Gow gave a pretty detailed answer in
https://lore.kernel.org/all/CABVgOS=3DKZrM2dWyp1HzVS0zh7vquLxmTY2T2Ti53DQAD=
rW+sJg@mail.gmail.com/
for a similar patch.

David, what do you think about enumerating these reasons in the KUnit
documentation? This is the 3rd of these patches that has received this
question. It'd be a shame to have every commit enumerate KUnit's
reasons for being.

Tamir

