Return-Path: <linux-kselftest+bounces-37776-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32682B0CBCC
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 22:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64103170F80
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 20:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2774F23AB9C;
	Mon, 21 Jul 2025 20:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gK0BPkbB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E7922D785;
	Mon, 21 Jul 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753129528; cv=none; b=k9+/Pwwq3fR44vewa0NELbJM/u4vkf3PHPU0OQ++Fz8d+rPGE6L9aPF7OuEDfs0qeLwxkLsEoNt/iOdqSRaOgUWx0EsMZm+nlZqM8KtljpNoygNWz5evOKWOEiDEyRLCwAiMpYq4bnNpiN+t17U442g7G/EhO9ofXUi5IojcRh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753129528; c=relaxed/simple;
	bh=f8KRAlo0QLnfXVhaUwy/xRDf2SviIgIlGB4FAr6L1pM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HB+9BV7av6yqEcceLfmuUQlzMvaMSwk2V6QTK2RvKLa0WA4J84ihjwd/Ij8DZn+etQKnO99WyZDqjHSrn/Uf3nXkAYChbVRtfEOGnfeTKR5R80o9SGL+iCKHUD3FCTEARptOnKqbXZSWY0Q3HsWVSs0QAaNOAeEpixQoe3N9tgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gK0BPkbB; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-23c71b21f72so8225455ad.2;
        Mon, 21 Jul 2025 13:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753129526; x=1753734326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8KRAlo0QLnfXVhaUwy/xRDf2SviIgIlGB4FAr6L1pM=;
        b=gK0BPkbB8KOp1/QrvHvi//zobc/biVn35yw9J2zLBiwVW61l1RInz2gDeTY8O8rOxi
         08k6FXlu8OlGM8pvQugTpCl2c1pTXtNUA078+cGNly6wLMIwUuDJvsMPO+cVhndLU9LA
         YbaxF2vqDBrjogLAZGnvsrq6fdSfyRWwPzuOg/KmzxwRhmYyi3TUa5CM9ZUwYC/LEBnw
         Xcj5r9CAFEJKO/F321Ys+v+vDNCzD3hRXjxpqrVssSRHF6kbZl1FPopFnPtkL3HfXEKp
         wHtWbdHD7RQsR4Z9Y/QhiWqWcbIUe2LVoZdk8teu85VK+kNoN3WI3Mm0f79Y4Q9ObnRy
         Hq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753129526; x=1753734326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f8KRAlo0QLnfXVhaUwy/xRDf2SviIgIlGB4FAr6L1pM=;
        b=YucchFKbYr3fKAiWGB8G8+/AlaNO+Vex4ANMbYovJD5BsbMtoyN+gEB6JlmmN1OKKK
         2q4EnW+ki8dB6/lguAOfpuzma1BGqodQ82XJ8oEPYw+OmmHhy43WNEI0EJ4sMGKBoJOw
         V67MzMbcehnPYD2PQvLO/2Uqp+IdcsCfj+IMnH7ZtKgc0oZ5WwBpacc5qgpned1bdti9
         Z/lgvI/uHlcAjBIqDlUDP+IBb5Exap2EoNj//uGlks6QrgFur6yqSQ4ZWEPygX3ZD6UM
         GYjGauKrF6fwYJQjXeMMXdXDEqotZaQHie4Nm3YDDQVaHMEF71jE52L7ONHxcIQPxExA
         pF3A==
X-Forwarded-Encrypted: i=1; AJvYcCUBG+dmZv14avw/E3BEfPI7lM0p6/yPSWTU/XNVjgVkm+lvo8iUNqVpr0CWge7lA+Tp6/kYrEtJ0EhXFGzb@vger.kernel.org, AJvYcCVbN8FcBjO5htnKvbKvsILtkn7EWKbLZkKKYTUPUXt9KWwSUFSFPQz+hbWHxYYkQhSaDfxjM8CgR1j3Ow==@vger.kernel.org, AJvYcCWu67uOsYkk0qB1sOWsLPZHuPLPPh7GC5ekt5doZ4oI+a0MgweNQq2Wu7k/fQxWpx8tdobzQOk6JdnnREUWdaY7@vger.kernel.org, AJvYcCXqBISWs4P8lV+ysyVhNyT2qr8pAfV3BwcUvRpj1mYhsNwfEafqBnJOpnLr8StW8a8sDHPsE3jEZ8h7p4NGvZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMr8ZAXg0AuHLVNGl6PNF+0hSAmbDiVWUoAoA8JYHlT1NITCdF
	6AhREWCgDG/cdwwSaZUPsqAi0Kx6IxTvmQyZcp/NMCxZ2rROCcTRDTPO7Bzg9cO/ykk5vJ7JkKD
	hQHFLTg3/louhsCgDamHjM+4Lh40PpWs=
X-Gm-Gg: ASbGncvTbzould9UZs7cnrLTnwWulkhec4vvd9/HOqdhSVVOvHV6BFJf4mcHIZOFO6V
	ZDXZh2aqPoC0Vt+TLreUcekD+DxUqINlKTqtWZwaMjLS781JUL8AzBz2/gHYUtmXwW3ABySMTQ7
	iWqmg/Wg7Phj/4hPj6lMZi0B0OsAUvpD3Tsw56VnznuTHACHzB4ZPvPJjBOmHj4ExZdHQ3ainFc
	lGt3UGh
X-Google-Smtp-Source: AGHT+IEF5YN5432flc4/QE1zXKc1vo1Qf6L24RfKDUkpQAWK8t4LLjpclkw1eCW9FSShKm7fPI0nlYBcZRk2yoWmOxs=
X-Received: by 2002:a17:902:ecce:b0:236:9302:bf11 with SMTP id
 d9443c01a7336-23e24fb217cmr121257125ad.13.1753129525871; Mon, 21 Jul 2025
 13:25:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250719-core-cstr-fanout-1-v2-0-1ab5ba189c6e@gmail.com>
In-Reply-To: <20250719-core-cstr-fanout-1-v2-0-1ab5ba189c6e@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 21 Jul 2025 22:25:12 +0200
X-Gm-Features: Ac12FXx9U3N74aGu_SHuXKRdBAKhnaP347PEyM-2E4UxAJ_SLOxUcgsXScqoJqg
Message-ID: <CANiq72nxL9RORJA-w=rtnkwMKcXcLva3dGbMDLc71o1bqAHUsw@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] rust: use `kernel::{fmt,prelude::fmt!}`
To: Tamir Duberstein <tamird@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Jens Axboe <axboe@kernel.dk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Uladzislau Rezki <urezki@gmail.com>, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 20, 2025 at 12:42=E2=80=AFAM Tamir Duberstein <tamird@gmail.com=
> wrote:
>
> Subsystem maintainers: I would appreciate your `Acked-by`s so that this
> can be taken through Miguel's tree (where the other series must go).

Same here as in step 2b/5, i.e. Danilo's Acked-by was picked up for
things he didn't Acked-by.

I imagine it was automatically done by `b4`, but that is why we need
to be careful about automatically applying tags. I am mentioning this
mainly to confirm I am not confused and to avoid forgetting about it,
and also I hope it helps if you eventually apply patches yourself,
e.g. if you eventually take care of a branch yourself.

Cheers,
Miguel

