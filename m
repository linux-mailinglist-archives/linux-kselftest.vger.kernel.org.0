Return-Path: <linux-kselftest+bounces-18211-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA4997E86C
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 11:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3E76B20586
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 09:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56CB194A44;
	Mon, 23 Sep 2024 09:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QblQaMIz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CD21946B9
	for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2024 09:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727083161; cv=none; b=rK0LmPeJdgY99NKa168l75qca3d7FReU39q3kc8k2yCYHfKV/2vPJyTGH0mpYPS4vM+FCGw1zPi7/YsgglYEfX3C7zvIhlMaO/AQKMmMH5tvN2qBYQ2zCtn+Qs7vtBd8P9E59GSHMqEXQk3HlMwdR08zRTqnA1C40VDzBAvFffU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727083161; c=relaxed/simple;
	bh=B3l/swgMf574HH64zSYfiVu/QiFNrAq4Z16UV6S+QtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AosoSVmjRECm7vCtUrQNSlWnBOrticjdWdaVEqxaxWInjezmFNP/PQGqzma4uX/uJthcpTZ/aVaao7HOoJd9fSa9foapZtCQTuYaRwCBmy2uQX5t8z/vEkyiNnV1M92rYpjGob/IXudlo0hWZuJuWbn23VNNwOytxUqqtQtIOg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QblQaMIz; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-374c4c6cb29so4094592f8f.3
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2024 02:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727083158; x=1727687958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3l/swgMf574HH64zSYfiVu/QiFNrAq4Z16UV6S+QtA=;
        b=QblQaMIzanz4vcpxR4tinf4AJ/ZLQh5LqiPgyQFVSjNiF1AH4+SE4103PysS7ew3bt
         f1XjQY8fFkhDxqYJIpZ9YsdcHe+h6I3JZqZCMM1cqOU5FbAkqgMvl6VCi+AdpD88TS31
         c31rbGk3vNRET+47HB3asSp0x/HM26Tdlmn9CbRy63x189E2ocm0rlsbSI9DSN65n0Gf
         JAC7A9t3DDMLLQFlKU0QDNl1APdfvMePrpxH7g6PQb/Nr63UKB/hflB9w5VQL8azfrZl
         ymBa77BKtbsKPQaLWkw6JOQciI66QTAb+OIDH8iC7ErcseCqOy7/TDNMJsRHuE0ROO2j
         Y/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727083158; x=1727687958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B3l/swgMf574HH64zSYfiVu/QiFNrAq4Z16UV6S+QtA=;
        b=URyis8q6IHcaHFLXlaUw1PgJLU+UXa0gnV2tCR+dBATqFwI/W+NbQ8r4d/mXMhDBLH
         Qe+lj1s2xvBnQm1HP5uqYy9Fie9fDsUHG5bn4II4wIuprtsnzX5MsRcCe3jPWkg7Gu1R
         5A6dg/A6sD4vubNljxykTRxvg9moU4JvUoZQByouuGjwwrbmtmpMTIDeV4oh8Jl9J1tu
         QBOYys4mspqtMub+vnDG+MYJRbnxrrp3VMJpmNq+0o+NgKJmFR+B39WwlZgoKo+zzo2P
         Cyk6A4pnRm0zRDcGr6NEjVB0WFpL+8NSkftaa+0ypIfXfpEgPxo5Wxt4Rw7wKNWOBKxo
         o+Ow==
X-Forwarded-Encrypted: i=1; AJvYcCVMXFHXVYvza91neSoDqUwpL/qsMsW4oit8BnidppDAvBCrjDfLo3ILnkYQPYwEsPyIfGJKFjDLyEH+zjpsfSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyPPCFGlb8oh46F1WHhKjS0TKrFA5dtFkVtrvfNJQivPb5qmlI
	sUEDE7vozO+gYbsaek5R15wakbmzpMemgpiipsodigROGMwmFSq0hnQ1lp51KIyuKj4AoxnTmWq
	4MS26iQ81U9N4ygfG7jFjB+wKQHk+li3FILxS
X-Google-Smtp-Source: AGHT+IG8mTC7dZL5MuqZKSFkhdYrDhY5fQw3AdXSlqu/ln2d+nUSR0gl5ejLSmoHcOVCy570O482RNIR3NkEQQXC1dQ=
X-Received: by 2002:a5d:4144:0:b0:374:c29a:a0d6 with SMTP id
 ffacd0b85a97d-37a422533bemr8151963f8f.2.1727083158117; Mon, 23 Sep 2024
 02:19:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913213041.395655-1-gary@garyguo.net> <20240913213041.395655-6-gary@garyguo.net>
In-Reply-To: <20240913213041.395655-6-gary@garyguo.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 23 Sep 2024 11:19:05 +0200
Message-ID: <CAH5fLgj2_8ej2Xs8rSj1rasYj6S+oQcoh7=+vRnfdZXz71Obxg@mail.gmail.com>
Subject: Re: [PATCH 5/5] rust: cleanup unnecessary casts
To: Gary Guo <gary@garyguo.net>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Trevor Gross <tmgross@umich.edu>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, 
	Michael Vetter <jubalh@iodoru.org>, Finn Behrens <me@kloenk.dev>, 
	Valentin Obst <kernel@valentinobst.de>, Danilo Krummrich <dakr@redhat.com>, 
	Yutaro Ohno <yutaro.ono.418@gmail.com>, Wedson Almeida Filho <walmeida@microsoft.com>, 
	Asahi Lina <lina@asahilina.net>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 11:33=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> With `long` mapped to `isize`, `size_t`/`__kernel_size_t` mapped to
> usize and `char` mapped to `u8`, many of the existing casts are no
> longer necessary.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

This is great!

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

