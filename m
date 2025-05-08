Return-Path: <linux-kselftest+bounces-32682-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56372AB04D3
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 22:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 575757B65DA
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 20:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7787428C01F;
	Thu,  8 May 2025 20:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RQnIrt8z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF52B221F1A
	for <linux-kselftest@vger.kernel.org>; Thu,  8 May 2025 20:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746736968; cv=none; b=q+koxZj9Bba65usOPjg4Q8vrOobVPvnUluhF5g/9X67260BuRb+a9DbTz+ml++qom/U6KRv7Grz2E0wDG8z6iBPaaGaIN4W89YJs9qg60XMD6UlvlyDmz0a0x1L7tAnfHAAcNfTbo/oFujNnZ5yTk1Ygth1XNv+gKgMGQS0kOV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746736968; c=relaxed/simple;
	bh=2WjSgAYTDhvbAta73SExM249Ul6aNo6XuJkBZUMjmhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ml00Ot8Ern0tQKN3LrCWof0JpaAfH0/lDcnIDG7+9uI5kYGl9nxSuUecm5IpaHQufZrcI4LIOlRAok5NxcrljfCjtmD0Xlzd/fgAPxBxK5dYoMFVVob46cH8qZ377hKsR9ZO5+OE6VnxwO2OANQ+SgZBEkmAOYis5C839G7hemw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RQnIrt8z; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22fa47f295dso10805ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 08 May 2025 13:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746736966; x=1747341766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WjSgAYTDhvbAta73SExM249Ul6aNo6XuJkBZUMjmhg=;
        b=RQnIrt8z03vWpaObewOf0ZDylNqahyW00XhFJkyQGxSik84kHsJz119Jj8jf3fNTFz
         roC1p3AcgMhroE7b/DKuILyJZ1Y1rQisxcKFU+3r+21SQ0bvNeyQiigpiY8pYLlY6Gfi
         MgksUdCTE6uduCB+fgWwh+asiKE6v6AvCaULEMCITFSzEbBGskmSQtc+T5vbNTtAGglf
         rU+sdHCiH5u1sdN4AlNyBBpojtFEuwew1YiLKNGQ2J1Mou6EFg3sfEg+DWL0en1YZr4n
         ynVPjuGieIUHN/ZFSCXRF4LmqtqfkALF1wcHmZTtM1CiE3Thm8AcksKiDmy4FT4z0M1X
         mQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746736966; x=1747341766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WjSgAYTDhvbAta73SExM249Ul6aNo6XuJkBZUMjmhg=;
        b=gnEgZA20gnaHyT8792prd2LNlS9oaKGWPDV7N7vJHGO0PuXXDxBmnM5zYQjRs6qm4l
         uPhl965GE9DE/E4eBlMgDV+ftuvh/tKv1xp6xfjrhVsP5dO92jm0xynyifKTU8B8bGPV
         sZclnXR6TZlPvnSVsLudgjHGGX4VT+5NAuH3+dTX6rizOVhp1qJ7srOdHNBZ60ZP/aFP
         h/ZjjDOljXX2XgT8ciOo7E8XotY/afhaPn8iM5T39N5AZLCJIwlP+ruwmMBiVPCGyQlg
         BbxYumpXPSsu0wumdjIGqV1wxS9qQc855EZYzr16pqJ8ATcSGHKnMfa6l7+q9Wem6bsK
         57fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSANLIzo68AxoSFw9abMFrcAYXRdvHxKUQ+OsGlgxHdnUBxv+wlUREevDyuUnBqFACLbeJlzgur2NkPwcOvAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD8aJ1/Et2U555qXqw6razNsl+I6HF/RxfB634f3m7Wk7GwAcc
	gtavArpHlDZoSgCQGNX5CtAGNT7pEFD168lDATYyt82NHAe5N+05j272tqPYWIHtZL5y330vmUw
	S1qXLA/bajW1xyFblC7mx+rVGioElgs406CT1
X-Gm-Gg: ASbGncsI0EgCWuP3zfRZMdRgWKmzV0rh57b4yrGGmWzlZQVH/LZJR1FQMSHL8MDMnJO
	PwRF6go2Pbb9qUUNsGe5fx9ihi8Qlm6c10FeH84XTVyi+XHqCcJP/P/QMTTK/imQzGw0RH4ew3v
	+bQ9lB7PpffiEmyu4mNSpsBxGwK6pp4dYnlyaeLigY5TQoq2jMzAE=
X-Google-Smtp-Source: AGHT+IGdOqXYobYdZKHXuDIEEOvNgsSbJwnLZmEFuT3awRjJJMwhBX74nhjfWYBMobjCH1pxPLr3WpVKK77rfK+2Xvw=
X-Received: by 2002:a17:903:1c3:b0:224:a93:704d with SMTP id
 d9443c01a7336-22fca87efcdmr917055ad.2.1746736965812; Thu, 08 May 2025
 13:42:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508084434.1933069-1-cratiu@nvidia.com>
In-Reply-To: <20250508084434.1933069-1-cratiu@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 8 May 2025 13:42:32 -0700
X-Gm-Features: ATxdqUHt7L8EEX_0vDGwwK1FdTdskqmrajC3kVKNUyPt_gFUFA5qLwMg3p8W5SU
Message-ID: <CAHS8izMkqMr6r6nYeDH9BgLWrf5_DsCibcg6-BcRhZiJQqiTyg@mail.gmail.com>
Subject: Re: [PATCH net v2] tests/ncdevmem: Fix double-free of queue array
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>, 
	Joe Damato <jdamato@fastly.com>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 1:45=E2=80=AFAM Cosmin Ratiu <cratiu@nvidia.com> wro=
te:
>
> netdev_bind_rx takes ownership of the queue array passed as parameter
> and frees it, so a queue array buffer cannot be reused across multiple
> netdev_bind_rx calls.
>
> This commit fixes that by always passing in a newly created queue array
> to all netdev_bind_rx calls in ncdevmem.
>
> Fixes: 85585b4bc8d8 ("selftests: add ncdevmem, netcat for devmem TCP")
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>

Thank you very much.

Reviewed-by: Mina Almasry <almasrymina@google.com>

Also, I think there was a discussion in v1 about increasing the amount
of memory that ncdevmem uses by default (currently it's 64MB) as Stan
suggested. I have it in my TODO list to implement that change but I
don't think I'll get to it soon. If you (or anyone) gets to it before
me, it's a welcome change. AFAIU it'll unblock you from running
ncdevmem on your driver which expects much more dmabuf memory
available.

But to be clear, that can be a follow up change. I think this is good as-is=
.

--=20
Thanks,
Mina

