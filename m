Return-Path: <linux-kselftest+bounces-23842-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3630BA0030F
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 04:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAB723A3BFA
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 03:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B281AF0CD;
	Fri,  3 Jan 2025 03:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJW8dQUk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D523B2CAB;
	Fri,  3 Jan 2025 03:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735874207; cv=none; b=NSNs2luqmE0aK+SV/dx63p0JPq8t/0jY9vlQZhrAiYztGXr9LyLKy5KNuT9qpCwZluqMMDWOWaEFLKYJzvjgT7Q1i6ONt+ppQxNV0Q+D6txfDG9N2L9uyMT9iU7MZaV8Q+oH9VGIKhdPYeu4ceZ0VkTs/yB3Bolk+JwEfJ7P33Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735874207; c=relaxed/simple;
	bh=qi7JI1JoSTf9QWnZeIMj9y4gbbCJNBtvx4XKxJSF0Dg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gnoGYtsWwJc3+dB1xPp28TBT+FlooKTNYqssVQ4Vep4pUNFLuL/egmuPwj/GtRvx1MhtTEHxPX6baO5EfYQyvhd9E55JHmRL/dIsjG9y8ouTYXwJ7TYGhBXVNyjz5nzZ0gbYAlE1hoPZJwGW/RGQ80t7qjbqzF4wbk2kWo3VQA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJW8dQUk; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2efded08c79so12984199a91.0;
        Thu, 02 Jan 2025 19:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735874205; x=1736479005; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rlRGOxy2rUT4x3ItKjxZ+LNvTnpFOxrf/pSzEl8Eq9g=;
        b=FJW8dQUksaSv1mBj+miQivRa2tt0fKIpxwSPSsX2EErQc0BGTsMLf1pLMvPdjm8sMa
         GnvCUHspq+9mpooCOH9zSx5TsTBekGZ9eaofhVZT2QLdInQXKAzbPWXqF05YTysPQdy7
         FoYjgrPviGcfiFdBHhcTXJ9rl9YODLW1kg0aKnXcTqPa6AzcR+72ovjXurtQJLSFoqJc
         n8fZZ+Q56valXWgtw5X2EL7pRk1R3Bwv7MyIgpzdAYxAdGaiZi3Sz45qP16/hXyzj9dp
         ykmCPwCHI09qtFgVZIM2TX7eov8GWE7awmS9nolD8tGM29Xvv36nHSRj7DeowXMPyKI/
         x4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735874205; x=1736479005;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rlRGOxy2rUT4x3ItKjxZ+LNvTnpFOxrf/pSzEl8Eq9g=;
        b=je/y3v7Vr9ZzTVCpIDl7cjTzfWHAttQ8lYDvTN2UdPxTcfXKKxaHzHVn8QeBsSMw+p
         C+9M8LMdqCKHIO4tEwW4sqCAk8mU9K7z8u54du5Rd1NkUAVlv+VbG2KdYqkEcK+sTXQV
         WGWc/I2nZZ1+PTI7Nmr9trTJY9iw2x0GHgzPZkp7UXVLmAIC2CcgCJBF42iCTnJznquS
         ixPSeyniQFcOaMSj5EsgbGq2Pt5SJqQp9xeAtq1yufXDJeHxx8wTuejXlSPjzUjPC9fk
         lMQMKXk20HtLQuEym/rSGZP1dkD+kwOseK8XvxLzt4RPhbberyseiMzRYCpsLjCNaFge
         6MPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUKb/7WXlNX6yFh8vaYxqJ/rIZ0gHnHwUyS371bv1P/iuBkWvnYYGu+EC+NRhefVEu0BrClInhTWlZ3eA3OqRb@vger.kernel.org, AJvYcCWrcUCpFKWFOu0FXJShBaqzAlmX7zj/2OJYkwQtPtYLTm+3uexuC2/OmYU/46dTD2sEpJ0=@vger.kernel.org, AJvYcCXnSC3ov6YuaUTWoWvFnKVPX+eB6bJHFcZG/u3nxgvo6Xgc7nF/8GFJhwBQjzPCD9vO9b3pOTFeW1A+QvdT@vger.kernel.org
X-Gm-Message-State: AOJu0Yxveg6hA1oZisJ8oKtjWfWZoXNun4oDKkS3lT7YgdZK1G4S4DUC
	R56H1/vtyHYFKt/SklyveyGXPXzQUWqDmeDU37DjlCpce8CXhyUK
X-Gm-Gg: ASbGnct6set3If3GI0+gLMmoiObMhHC4k8Xn590qqFLWRj7Ga4MpTYmh9dSfqCkuTJI
	vMOMFwk2bJ4T92VSOJTcmqaHdc4lTw6cdl7VzGAl0rFqAQ7glQoXhGKNMNUw45kdpBMe0w7ci4U
	oTwXJe1OPRI6tu9GoTb6C3K5aYttgG96DuXNFoZalbHUejX1hSl6wBZsbjODX5vS6T8Pe4W348q
	SzW65vSmJev32j93Zpa5k/SyG7hl0tuhR94mdAqc1gs3JYRSsVBRA==
X-Google-Smtp-Source: AGHT+IFlJmYH111jyVDw3jrEyTjjW2e4N8ndRDeF9bLCsTjByGVKyQKN6J5cDte7JI/pRJopdGdVng==
X-Received: by 2002:a05:6a00:1152:b0:725:f4c6:6b71 with SMTP id d2e1a72fcca58-72abde9eb64mr75697047b3a.20.1735874204976;
        Thu, 02 Jan 2025 19:16:44 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad90c13esm25134065b3a.190.2025.01.02.19.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 19:16:44 -0800 (PST)
Message-ID: <cf0da119ef36fed757198a870952763a0cf48513.camel@gmail.com>
Subject: Re: [PATCH bpf-next v6 5/5] bpf: selftests: verifier: Add nullness
 elision tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Xu <dxu@dxuuu.xyz>, andrii@kernel.org, ast@kernel.org, 
	shuah@kernel.org, daniel@iogearbox.net
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, 	jolsa@kernel.org, mykolal@fb.com, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 02 Jan 2025 19:16:39 -0800
In-Reply-To: <478d188ecd9ac004ffae6fba969b71364adbab1a.1734667691.git.dxu@dxuuu.xyz>
References: <cover.1734667691.git.dxu@dxuuu.xyz>
	 <478d188ecd9ac004ffae6fba969b71364adbab1a.1734667691.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-12-19 at 21:09 -0700, Daniel Xu wrote:
> Test that nullness elision works for common use cases. For example, we
> want to check that both constant scalar spills and STACK_ZERO functions.
> As well as when there's both const and non-const values of R2 leading up
> to a lookup. And obviously some bound checks.
>=20
> Particularly tricky are spills both smaller or larger than key size. For
> smaller, we need to ensure verifier doesn't let through a potential read
> into unchecked bytes. For larger, endianness comes into play, as the
> native endian value tracked in the verifier may not be the bytes the
> kernel would have read out of the key pointer. So check that we disallow
> both.
>=20
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---

Nit: a few cases are omitted from these tests:
     1. a key is not a pointer to stack;
     2. a key is not a constant pointer;
     3. value on stack is not a spill;
     4. precision mark for stack value;

     I think (1) and (4) are worth testing.

     For (4) I think matching log messages about marking stack slot
     precise should be sufficient (register and slot index numbers are
     not guaranteed since tests are written in C, but regular expressions
     could be used in __msg using '{{' '}}' brackets, e.g.: '{{r[0-9]}}'.

     An alternative would be to write a test case where precision mark
     matters (a branch before map lookup with invalid key value used
     in a branch that is verified second). Such test would have to
     be written in inline assembly to guarantee code verification order.
     This might be an overkill.

[...]

