Return-Path: <linux-kselftest+bounces-25459-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39808A23856
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 01:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 854E67A23BB
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 00:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329283FD4;
	Fri, 31 Jan 2025 00:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vv3OgX2O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B609B219FC;
	Fri, 31 Jan 2025 00:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738284510; cv=none; b=STgWX51uq3RTRcc85ngagNodexcXmlbGSiFpDfpziBXvtE+0ZHbenO8BXzKaDc9nVgUugBdErGrd73P8KGCJwscccOr6oYDqqm1z60FCAn9ocClM2LmyLZ27f/3TyvnK9kx+dQt7XNqels2a6S5rR84issAsTr4OmCKj+YS9KG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738284510; c=relaxed/simple;
	bh=+xMaN9yAbIcURitIBFnND01fmgks3Cq4Ks6qF6WqJ7o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F6hwy26WbUQRJLvShla1x/7lVxF6e6TpZwSlnLlb32oF8NcRXwPv0EdoYoZTffdAO41hAgL22uvM5mvy6UoTZxkZjMTO0gCs7lT1sxI/Ix0kKvFy12ICcYId88XCl1R7HIkv0x59FD/CPMRxHj4cGWKO6Ni+16s6RuXy/0PFy0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vv3OgX2O; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21628b3fe7dso26676625ad.3;
        Thu, 30 Jan 2025 16:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738284508; x=1738889308; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YtPvCO6S0II/KJMCKKK9WhQP/vAJCYUBd1iffzSjO/w=;
        b=Vv3OgX2O/w1Bf1lKEAbhZ9o0oNJ1N+rn/LlMTdKq5EnzlNTW8TGwPAMRSEBn2LwYeM
         VgacG6gvP1coBsdX7aZBZrJ2GT883nhAYHKsiYV48IjKD8dkBQNYYiP3oRSEhgtvztVg
         9mBW8X6X4Mmokndml5BhBGX+3CIq+YYUs5ekwv3BTV/pKnUb4w6gtxOSAvIkoIZHWDRD
         K0cwdEVP0I+6JfXQn7z+uUZJ78mG6ZC7RYtSbwNH2VEGVCSkPWe0NGvFXOA8vameG3aI
         b/OW/biwzy4o9Tj4Qoq4jMi6cvckMQfUnkuJ91Lw20PNmMZA8RLEJzRM2a01OPVH4KlD
         OImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738284508; x=1738889308;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YtPvCO6S0II/KJMCKKK9WhQP/vAJCYUBd1iffzSjO/w=;
        b=MTPSzDx7eMT2qK9crEf13K1pQzbDA2VE4qlywcryqThaiISKeOJIwplMpZ2+HlBb1S
         JemlkL9qyGRXPqdVCtQ5OYCv11NBVVJKIX5KuyuWgYmlqU95yJK2AjzwEz6UaY4PYYzg
         c8NztRVKC6gIWIaXIeYqmLlOcdjOo1frxeVmvDhuqn5pUqeApLJYyRGwmvMZ1BH94HoH
         DhuMR/77A0Jef2QEqzjoylNbMPTetnFSngyHA0ockz3zexQnFQeizdGcRPyEjflMH6CQ
         r3bYG65bY5k5T7b8anHDq8OoFzlj8jBmI+5bMBuj4JfUAxpJyPqWU9vjO6plrqCWQN0B
         zl6w==
X-Forwarded-Encrypted: i=1; AJvYcCUbSfOouG9BSadtSKqU8koFJd7jm5+As2LLUZIQayvIV6ZM7/pz28Txr9s6rLqrBDhu5bc7kelBGPEWyLTq@vger.kernel.org, AJvYcCV6+364UpWvcxJ9x7zpoYNNkxi6var499sr+IOd1V19BW+a4aT6JdRFKyNkmdMbYjnv0q8rAMaVeG7kBV2/uSXO@vger.kernel.org, AJvYcCXnIhX5JrdGide4H7x/7Dgk+j4PMRLRV//A1n+sPnq8SvQhEYQKggJyIO9Zqj5Q960b/ZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUdzi1goAJ936DQZITVD1vrbt+0lGmLrSeur2avf5KBr2hAukd
	HNXuyUaHAMbJh0uCamE/KPy3VXT/lbbNMVYM1gvQDahoUuKRSyMJ
X-Gm-Gg: ASbGncsP1gQqptUNtH0ThRf2fGRNGtqBd5bnnt6OmsQfNjHFvcDZemB7Gva7i8G48bZ
	5T9KAWvSjVLj+l1JSi7PEUKhm0supwblDQ7ocY6OuzmFcycgxzttkz+5IzLSwS7bgfd5IP9JzLv
	sjoppXJowghq5zCeRTro12XMsicvIbJunjQHpSlP6NUL1FcLx8rBnu591MYkK3B56rmjORdYoB7
	nzjQAPs9soRiyCtEjmp7t9az5Hjr8eaHSiF3xvGk2dYZf8NppVcEeqPH3p/Xa+F10lfdskJx8z9
	mfVXx6PUFjLX
X-Google-Smtp-Source: AGHT+IFF6eAT5w1vWPhpPcgEgSxowVdJfEet3pFu4xTXuLB5i+viKrOreK5sdyh578g1EBtx5geEAg==
X-Received: by 2002:a05:6a20:8415:b0:1e1:e2d9:3f31 with SMTP id adf61e73a8af0-1ed7a5fafe9mr12744457637.16.1738284507892;
        Thu, 30 Jan 2025 16:48:27 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ba2d6sm2128078b3a.109.2025.01.30.16.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 16:48:27 -0800 (PST)
Message-ID: <f70c352b558742a328449e941dc33237900fc74d.camel@gmail.com>
Subject: Re: [PATCH] selftests: bpf: Support dynamic linking LLVM if static
 not available
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Xu <dxu@dxuuu.xyz>, shuah@kernel.org, andrii@kernel.org, 
	ast@kernel.org, nathan@kernel.org, daniel@iogearbox.net
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, 	jolsa@kernel.org, mykolal@fb.com,
 ndesaulniers@google.com, morbo@google.com, 	justinstitt@google.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Date: Thu, 30 Jan 2025 16:48:22 -0800
In-Reply-To: <872b64e93de9a6cd6a7a10e6a5c5e7893704f743.1738276344.git.dxu@dxuuu.xyz>
References: 
	<872b64e93de9a6cd6a7a10e6a5c5e7893704f743.1738276344.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-01-30 at 15:33 -0700, Daniel Xu wrote:
> Since 67ab80a01886 ("selftests/bpf: Prefer static linking for LLVM
> libraries"), only statically linking test_progs is supported. However,
> some distros only provide a dynamically linkable LLVM.
>=20
> This commit adds a fallback for dynamically linking LLVM if static
> linking is not available. If both options are available, static linking
> is chosen.
>=20
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---

Tested in two configuration:
- when both static and dynamic libraries are available
  (linked against static);
- when only static libraries are available.

Tested-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


