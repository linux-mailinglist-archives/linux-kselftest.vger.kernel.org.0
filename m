Return-Path: <linux-kselftest+bounces-27254-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDD3A4047E
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 02:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A78B423D14
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 01:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BB115855E;
	Sat, 22 Feb 2025 01:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICj0VUhj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D3F15689A;
	Sat, 22 Feb 2025 01:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740186285; cv=none; b=IQeIPayEeeutsvSq/iUf9iZ0cCdl2LmmAjx+CTxi4j47x5vftX0YBMswbP/d4hYZat9voNnEV739X9k2WePMBEnpzmkDHOZCAl3kmOUuyEnu2WjWgAlAWSZVXbOWv2lMeuIIM2wiGW9ls0ZZFtt2NDTSY5EIFS6YxomghFlmxcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740186285; c=relaxed/simple;
	bh=xSEFwPHHuqn6WOD27TUsOG/VeOL/M+h2JMArFQxwNPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Klb96wXYQCcqKiqM3xJthc5xjEH5IfNW51XvqbXbCjOevhXJOReZAlI7SBmgW91v5J5AvyAYcLdnxYnkgGyOLE9cBY345fjsLOMJAe0v8dpEYz/x33c30UY2HBwSuz3ajOrNZc1ESguU+euVD0FNLDU5QRujNP6ufvvii0nvKtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICj0VUhj; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-545316f80beso2488537e87.1;
        Fri, 21 Feb 2025 17:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740186281; x=1740791081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8JLpo6gPqmIQu0zuiirjXHwZLQHSKXUqPNibcTvgIQ=;
        b=ICj0VUhjzC95WMkax7Pc1RnbA4BjH9c0f/iVJH6OK1q0MI0SjW4Ni2nVDPqi05SFle
         r2LWiWXPH4un/tBmsaylw5i2iewTYgXfLVof+TMbPBctebubZgRjCHJ2LKBmifoFmgQg
         d7PFrf1OC7zp1UOSyUQJ7a4fsnM/82iTtSbvCt0oo3MV5imf28yXV4mB0C+2+HDtKLsQ
         zV9jiAg/6CilJAys+APV88HBHlZDTbcvbyYjk64gK/AkqAJYTN1voAUMhOrLo5oK3NiG
         nI1aYWjSoYb3Em4GbDbibgqqAC339G/HAIp6t8TJ1o6aFoIyxI52/1hj+WZuMLhhu9QL
         h+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740186281; x=1740791081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8JLpo6gPqmIQu0zuiirjXHwZLQHSKXUqPNibcTvgIQ=;
        b=svxltVerweujRv9QwfrC1Lpz91Mz6FMP5A/jAHb/e7uDgMYcpoXGbTqlasoTrD4zPS
         rjYGFvT92yn+8ZKrsM45kl0uv4dZ/miiQrFAdYWwU4J3PXEjYBRZ0Gb14YxrU6v+2IzI
         OW0ZhdF5FUDOiwat0H4U0KOBpSkACcfBDmCNuXj1KhGNIfatBO/clrCDIkHdmnXNnG25
         ek/VJui0zzqppaxS2yDyZt9SYGiYHihLJlcJz+qFau2nSiQT0SfNEthbWa+BmIxqq3mM
         BM0lHtFoYdhL5KivcEkjqyBCQZqCP61qIMVrEV+LDiJ0iij/m2QArjl/2RxO2C8gg9W9
         7zGg==
X-Forwarded-Encrypted: i=1; AJvYcCVms6aQvk9lwTxYRke7kNdGe6HmpqXuvLBwvReq6S1zBwcNdWbMNBc64Zm1mNumVz3w9YWmWZnPU9MpG1Yzv6z+@vger.kernel.org, AJvYcCWPs0O0+LKrIP7G12rtXWHvzjL48kEr4yrViGLtb8GB3uuBFPv7hKdGid6ojAhL74b2P/JP69ECLomjgJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEk8a+3q9BzfOLeomFbT4hF4tK+2n9WgW+bsqrC8uMlya8M5Da
	wIX3KjT8XcHhzZi1leMvAD3HVyVMtKIC2mgUfsGWf9H/IqHxMXW/RAFSr/z3VnSUjc8Etk9rQYm
	xg7qnX9u8ry2+PI7Fjm7PItP86fc=
X-Gm-Gg: ASbGncsOQZr4XU22ZWKQ7nV3tYx5kdvXYI1KzZmHqUwzE7ogiUGnh/aKy/n5b4wFLUz
	NKtIFyyek1JHZ7K8f2QqZpQoeOsqk9HH+BHSXsZLrfw2EJgCQXxbRCqn8p7DK4CNdgNNC4rbtcS
	JXr/0Sml/y7+ZyAELjv+3UL3ED72KphGvCXdzn37zU
X-Google-Smtp-Source: AGHT+IGBNPiBK1v8Us3bv1gNMHHoSYyg+zMKu9ngjXSCjnGfZVGpyumH2OLdxQjGjjisZObuShbQnlshRZPMS1MDlMU=
X-Received: by 2002:a05:6512:108b:b0:545:1240:24f5 with SMTP id
 2adb3069b0e04-54838ef8830mr1911247e87.28.1740186281335; Fri, 21 Feb 2025
 17:04:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217-fix-prime-numbers-v1-1-eb0ca7235e60@gmail.com> <174018582427.3369509.6023266709728991391.b4-ty@kernel.org>
In-Reply-To: <174018582427.3369509.6023266709728991391.b4-ty@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 21 Feb 2025 20:04:05 -0500
X-Gm-Features: AWEUYZmWse3-zILqxoP98Pjv6TObdBAr1xPQiPqLyd6LT3_YW1lyt_kKKgB8hxI
Message-ID: <CAJ-ks9n6s_nUzZ5NxLFuySskKCEf0cEXht1R0uP0iF2BN_4ZSg@mail.gmail.com>
Subject: Re: [PATCH] selftets: lib: remove reference to prime_numbers
To: Kees Cook <kees@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, oliver.sang@intel.com, oe-lkp@lists.linux.dev, 
	lkp@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 7:57=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Mon, 17 Feb 2025 08:30:44 -0500, Tamir Duberstein wrote:
> > Remove a leftover shell script reference from commit 313b38a6ecb4
> > ("lib/prime_numbers: convert self-test to KUnit").
> >
> >
>
> I fixed the Subject typos and applied to for-next/move-kunit-tests,
> thanks!
>
> [1/1] selftets: lib: remove reference to prime_numbers
>       https://git.kernel.org/kees/c/03d0e920d775
>
> Take care,
>
> --
> Kees Cook
>

Looks like you traded one typo for another ("selftestss"). :)


Tamir

