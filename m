Return-Path: <linux-kselftest+bounces-32291-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C17AA88FF
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 May 2025 20:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5C8A175249
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 May 2025 18:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3F417A31D;
	Sun,  4 May 2025 18:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrW9hL5K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7179CA32;
	Sun,  4 May 2025 18:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746383992; cv=none; b=af9VR2ADeEhPidLfdHlMQGljAilaASvFbHFU1aIjtvyZL39mt0H/OjyuFLvja7ctIv4gPWRRnIOT1TTyLVi1V9/GyTE36V6pTxe7PxaEWlA8LbVeMlZIuduRdaA/XMTxo2R/EMTxRBBXuwGwIbe/rIaER5FfngxBNF0o/cuHo34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746383992; c=relaxed/simple;
	bh=fSmJoF223a3Dtn5gS6dQbZAefH3Jw/yNUXcDpZtV9lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDRIwgN931u0foyk8h4GPNi6vq76IzM12Wo519b5wWqgolGx7il3at5Johx50WXfn2AogHHiMtrAiMa8qI6N/FWIjn+i0MjqIo0E+G382Zkxkz6SblyMiRzQ0KMHSj450pb6/rbxOXvyyhq4DmtDVxbvlrOJl3HfOqf7KgDqnHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrW9hL5K; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30c091b54aaso31580651fa.3;
        Sun, 04 May 2025 11:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746383988; x=1746988788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSmJoF223a3Dtn5gS6dQbZAefH3Jw/yNUXcDpZtV9lg=;
        b=mrW9hL5K+MS3A25nyGaW9rXJy1o7ZDK//7SWd+VS2cuhmcC4mVH6QgJAOd27LpwwLk
         KQEvohhvjqNmOjj2NQ7OWZm7taAdAzSKPj/8CFz2OtBhsYjvYF+Z8G8n4xuVJmvHvH73
         Ue7lCAPhgEGaVa/N2mdCq/v1v2SzhSursvjz9bOZGHvocLEIqzr7B/C+gpNyEuqVu2a2
         lnsvHFtX2TrxOA0ZLIDW/n4HiXCLedthiBpdquaoHPicHZFV7T7+wt906jpX4BW/2LzI
         5xrY9P2KS+8lvdBINBAA3FhURHviJeQSKcAh73eT9Ck5lWOZJVf5VvoOlxPO8+rXCN1Z
         m7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746383988; x=1746988788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fSmJoF223a3Dtn5gS6dQbZAefH3Jw/yNUXcDpZtV9lg=;
        b=fRVY8C2XvUH7HmDzfUkZMX5d9grNYca7XPHUkzUruuzVOBwSI29rVQhAWnGDSY51D5
         6+a40GuwWgt8sNw1KjSKMu8a1X5F2Mp+d96qogOc8QKYOUqU0wolAicy0ll2V7GzcCFd
         jHZFNrfMZsnX1AiBcYhztqeTsQUUqpwNBqWOJ69AzGrcfzNTCtzA/jOnsqB1e/waXnqv
         4oAMfhD1UapcP9xOGUhryLnNsGLQJ6XvVvd+mgRsdmDm3vsahjZzuNTkpEhgnmrJ8dSC
         vN/fUoTchczi1n0s1vIWtnIzNdpmLPBQ8jsZsaAM485OQTLCuGwmFzjnwo2wkILFzQOn
         8cGA==
X-Forwarded-Encrypted: i=1; AJvYcCVLPOs7rGCpxFDoHWP1cVgxcfksyUSnYnyAJ+Tfc78yTyiltNZPMBNgbbw2Qc+SBOnxE4fcReFHaamWxAyW6S8=@vger.kernel.org, AJvYcCVm24naX2e3vfGZCP7KQQKBgKe8vIwpPGCZTbXXtLgzZ707ok6PSqA+SH9teewZ/8uNoMqRI2zlQXyCPd0axer5@vger.kernel.org, AJvYcCXQFMzXLLv9CFjzyOjQK4gleLe3ZhR4+BQBcpLxUTn3iarZFm68LUns6dIDMMkSlWkQGJyeAc6BpYdl6nk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwyw5hHexmMxfBFbgBMyrUZwfU2+eEo20P7nih7Lbp+U5nwQSM
	c/YXkMHymeisQnKrpJzrXhES9UW3ylQdLCa1Pj0sk8bK9Cx+d6TNY4T4QAXBFMaYO701hjVoRfP
	LOWWcQBB/WKQci+FqwJB5ocTyTZc=
X-Gm-Gg: ASbGncv6A2+vr2wtbgxxWbCzuVa0+QNgUVWrumZY2DT1IQ9sJO6CHbhGpQzPsvi4/iX
	qN3jnM8F5aGGO5A3Tj6DFyS6CVOjLIAJ2Hz0MbHmbuH4O6YQjZo1sI416Wm/gvzfjpghBNBAhH0
	b2NnQATSsxRwR7SbhcDV+Sly531q70cQDsjoyXNIpBNzCwQzf2I1/AuyA=
X-Google-Smtp-Source: AGHT+IF4M252xpX64YiVVcGHS9b+FT406Ul4BsQtwfMEvjsaMrNFKI3eMF3kQqHHsd1qjhEeBhwQr83pT5kbhQTpBlg=
X-Received: by 2002:a2e:be29:0:b0:30b:d4a9:947c with SMTP id
 38308e7fff4ca-321db78d465mr15329091fa.24.1746383988320; Sun, 04 May 2025
 11:39:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502215133.1923676-1-ojeda@kernel.org> <20250502215133.1923676-5-ojeda@kernel.org>
 <CAJ-ks9k=uxxumgEU84-54u8OxxJVBsUprGk7Ht31ndoumHB95w@mail.gmail.com> <CANiq72=Q_Vbfh6YhDsNeCBDPZ-q1d2HNfaTj4azAsd2Q-zPfEw@mail.gmail.com>
In-Reply-To: <CANiq72=Q_Vbfh6YhDsNeCBDPZ-q1d2HNfaTj4azAsd2Q-zPfEw@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 4 May 2025 14:39:12 -0400
X-Gm-Features: ATxdqUFE1jEFBjmHs0_RQkTHweg7qOHsrW6y-33PA37grM4akOLYLMlMBtRrJbo
Message-ID: <CAJ-ks9mAgR3N+cxL6H5XhAN-iWM=T66vuWr=LEozj8bqofBf6g@mail.gmail.com>
Subject: Re: [PATCH 4/7] rust: str: convert `rusttest` tests into KUnit
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, Rae Moar <rmoar@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 4, 2025 at 2:31=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sun, May 4, 2025 at 7:31=E2=80=AFPM Tamir Duberstein <tamird@gmail.com=
> wrote:
> >
> > Is that true? The build host is often easier to work with. There's a
> > number of host tests on the C side that exist precisely for this
> > reason.
>
> Even for tests that could run in the host (pure functions), if you
> test in the host, then you are not testing the actual kernel code, in
> the sense of same compile flags, target, etc.
>
> Moreover, you have UML, which gives you access to other APIs.
>
> As for "easier to work with", I am not sure what you mean -- KUnit
> does not really require anything special w.r.t. building the kernel
> normally. In a way, these restricted host tests actually are an extra
> hassle, in that you have to deal with yet another test environment and
> special restrictions.

All good points.

> But which host tests are you referring to?

One example is https://github.com/torvalds/linux/blob/59c9ab3e8cc7f56cd6560=
8f6e938b5ae96eb9cd2/tools/testing/radix-tree/xarray.c.

It might be that these are necessary because the xarray tests don't
use kunit, and so are pretty inconvenient to run. As you might have
guessed, I discovered these host tests when my patch porting the
xarray tests to kunit broke the host-side build :(

