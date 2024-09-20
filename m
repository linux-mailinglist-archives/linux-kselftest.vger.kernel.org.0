Return-Path: <linux-kselftest+bounces-18172-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BECA897D779
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 17:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D0D1F2535F
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 15:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C901C6BE;
	Fri, 20 Sep 2024 15:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="oSXETlY7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29EA15E8B
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Sep 2024 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726846295; cv=none; b=iW1xHhd0ot1maeK3tKV8R2CFW3fVR6aORxlD2sc0L5rJAYlBgAKA9sPZSCqtMrmz1HzvzL82Ooh7271MEC/OSaH4D4UgBv3uj7TfpguHJB8Z7v0yXicRIGYFx+mAqgrRyVNoMyUJhhRE5bPoQQ4Wm8Q3r5OKJJLLvgqlhuG5qOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726846295; c=relaxed/simple;
	bh=b/4DM9nOKvhNieHiEOmyrHnQ4cnvFgoFHf0Das1RbtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IiqjEl+GZIW1Cnh8+VooJOh4LJ61ctn0GJEL1k/6Q1UXCoGnUryKfEEy1vWR5JezK8xb0HNUMkFAfPC6I6mj19EspdHBYZF7xb/mBcnXumg1MSjV9SllbpzJI+Z7kaFJ75hSOfqlgFJY0gyoCCg8i9jZTdq5Q9JFxAh/r0dWev0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=oSXETlY7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B97AC4CEC5
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Sep 2024 15:31:34 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="oSXETlY7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1726846291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b/4DM9nOKvhNieHiEOmyrHnQ4cnvFgoFHf0Das1RbtM=;
	b=oSXETlY7ZS2cquG1sQxz9aR3F9MRaGGoeS0Y5fzLU9nHJsrISWm84b6hjOZpZppZdloc91
	2JdySOU7Gb1A+c/JpdanwCxh1ZwdOrO/FC6aj7RsHpEJYbDBeLJMVKrvYe5hL4QXtFr2+Z
	/xnXYqRJLkGJImNmD9LBxwTLcOuxkmU=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3d9680bf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linux-kselftest@vger.kernel.org>;
	Fri, 20 Sep 2024 15:31:30 +0000 (UTC)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5e1b50fea4bso1217183eaf.2
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Sep 2024 08:31:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXiuTfkCo9M6e1ExRfvZrHramyYNptt4u29T6r5+huLeu1ySwPwgLgAVTMrbQ8Yh8Bw1qYs6Ysr0rQY0lnPKcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjEGo5ugPDqowTbL3OZVYE4KUAMSt3TEL0ciyOOG2tJWRte5FG
	2gINf4ra+KCxy+aAO/nK/ER7tNef0luMbaFu5vaYUwRbky52xD1H0KVHTry2jlaYNFyfJ7eK0sQ
	Uh6PoYT8eAte7ouYzOuTeUyWjAaU=
X-Google-Smtp-Source: AGHT+IHYAOklpF4QyNtZXEC1Pc5F2wB4B3Kgss44/xneSYo1L2h3XFqMO7GKU4Vytip6cr4H84HLWF0ACjjVa720IRQ=
X-Received: by 2002:a05:6870:71d4:b0:260:f5ab:62ff with SMTP id
 586e51a60fabf-2803d18d7c3mr2402219fac.44.1726846289857; Fri, 20 Sep 2024
 08:31:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919111841.20226-1-liaoyu15@huawei.com> <20ef1a1d-db00-44a7-a550-0b293d6e0d0e@linuxfoundation.org>
 <0010d5c7-388e-d648-8320-83b9fd16e615@huawei.com> <3e3507d8-f17c-4af8-83cb-682190f5bf67@csgroup.eu>
In-Reply-To: <3e3507d8-f17c-4af8-83cb-682190f5bf67@csgroup.eu>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Fri, 20 Sep 2024 17:31:17 +0200
X-Gmail-Original-Message-ID: <CAHmME9p9iy+d2wx3vpD1XbVde9WvcJ1agTOqcNw4z=WABVn5XQ@mail.gmail.com>
Message-ID: <CAHmME9p9iy+d2wx3vpD1XbVde9WvcJ1agTOqcNw4z=WABVn5XQ@mail.gmail.com>
Subject: Re: [PATCH] selftests: vDSO: fix compile error for vdso_test_getrandom
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Yu Liao <liaoyu15@huawei.com>, Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org, 
	liwei391@huawei.com, broonie@kernel.org, linux-kselftest@vger.kernel.org, 
	Xie XiuQi <xiexiuqi@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Indeed probably <sched.h> is what's wanted here.

Shuah - I was taking patches for this code during the 6.12 development
cycle, because it all interacted with the dev work I was doing. But I
think that's died down now and things can return to normal. Do you
want to take these like you usually do now? Or is that annoying
because your tree won't be based on them for another cycle, so I
should still do it? I'm okay with doing whatever you want.

Jason

