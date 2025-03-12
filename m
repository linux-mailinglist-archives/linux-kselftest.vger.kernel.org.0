Return-Path: <linux-kselftest+bounces-28822-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16605A5E0B5
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 16:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25AD83ACAA6
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 15:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C10253F11;
	Wed, 12 Mar 2025 15:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOmxNJdU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0B72528F0;
	Wed, 12 Mar 2025 15:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794120; cv=none; b=DBijpDGxAPiJU6qQ11NGRUnzLvx9TyACPDITSxrbd9Mg590duaQ4+fnHF842lRsaq8ZU1lmDVcidtRYWgTlZBBuLtIC+/mRKxSZaNdvL9RYFlWYpfzgk08wqJcneA65BOBD1261f829TvyiW09moxbhXHB1OitjkojqAV0f2CsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794120; c=relaxed/simple;
	bh=rVyI2hyXWnqjdQ/L5d1P7OfpuOy/O8xinkcb+3jPNQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SKvikvETPmjVhSBF0/1Kz5k7pO658zqcktdQsZVWZI10WNho716N4+hGW3WcwgqPhzSeb/w16At1f+4S9aQaDepbmzHf3SUpCBoxl7upNOqHvEfW2HT4XVLM+cgWWcrw41FT/vnCIoMWj3Xd2ro7pNSGX2hg1kMF51h8hDHvBjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOmxNJdU; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ff611f2ed1so12693a91.0;
        Wed, 12 Mar 2025 08:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741794119; x=1742398919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PSIc6zjw40CXJ+jdVdC/xrdJhQRSfGjxhYqyq3jHZow=;
        b=OOmxNJdUoT0n1ukdhU/QLcZTcPn3QsTESeqT6EOj6uH+8e8cDuf7ibi0LBEC05iIer
         +6HX5AeGFxZZ64TQOsCIUzwKWOw+KH3+TGssHG48yHn5tLvTuHlFaUFwFJ/5McY/mflS
         axuZfpYVMeXMdPopMfdUHrzq9cAP396ZLc7nMJ10gX4Cnehf3nkQvFBxhm4IV9tvzOdX
         8mem2B0sGxJjsqatyjhXkLCghHcOHCghvWORHgNA6zJQcr9cTwWGrwRomGD7sHk6LHZh
         50gcaL5KjIAj/ZmsUojTEAhXhR2xoktnMLkftx1t+nTIIKWg13wuniL2w/wSVKqOp2e9
         3ECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741794119; x=1742398919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PSIc6zjw40CXJ+jdVdC/xrdJhQRSfGjxhYqyq3jHZow=;
        b=CqWu2NNhjAQMS6nKu9PtNE5P3VJgYto9GBU8xyFcM7hA2AoylevG0TXpeO0pleHZRS
         heHSLsTrzlNVZsmrHEPA6LjLz0FT5EGIydkHMhYU2YUXRoXQNSQ7Z8/twZ8xV0cJN+Rr
         8D7A9a14hg/35vRgJKWHiq481PRA7RE61dmF+MNba1gEzR7UlbYvYS88035zLqndR1CK
         qLr00IZ8qOh+8zUA+pVNvAbTFpMscEpCwFp0M6nvKAhXX3cKriEaLSDGIFUDoUYUeGSm
         C7pksMb6Gf1oEjmWAot19FNtdozS2iJVpid+g1eJdi9Q96maCoR/iQqxMQd5rygfyQVO
         s40w==
X-Forwarded-Encrypted: i=1; AJvYcCV0gr9PuafHqiJw/RMQlD9xkRE8mBhGMbYaafjFIzt5lq82y4jS4W5H1AREZYqe5eicskLRi7dWpWLoJqlU@vger.kernel.org, AJvYcCV7JH4wuiHFENYJSLh6b7dB123KAiR4y2zURz3Dt/A/4DoMQfEAllGnThFh5PrMSfarFh6AYJz2Y3UykNDcfaze@vger.kernel.org, AJvYcCVmpyHX+W8l1ChCD04tBy2jEqDRUbbT58RDllNRtChTtTbNkShuueNFLhrtfONN79bBqZAHEfZlMCrG@vger.kernel.org, AJvYcCW1jkbUT2V6GWLowJ2jGn4S+zewV7359OjSDTkG3sL85JnJjOd7/EI5MPi5chsFyBJo25cvE0st2MpegZYw@vger.kernel.org, AJvYcCWkh5u4uhVu8riVc+aEBOKiFaN+eFGSnvr+L2tjizXrNHAKepJNosmo9l17uKpa7F8mG88oJdBmz7Xf@vger.kernel.org, AJvYcCXAxdGpKnU+6xcIspsvh/ezXhDJNJ0z5GhJlBuuhNve71+S9mDRKjmhSY02ugXBCvOJzRFG1Yk6ZGN9htwjY8I=@vger.kernel.org, AJvYcCXem8Ku5RKo+ILnKL+mZAuNOkS5i167FGk5mg+7af2YXwPaezADDvOn8l9mH0MUA6KayRV54KV5pYPm+AY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmirRtv5k08SqGeMLg01zVTswXbYR711ScADJcmE32bvwpIAsT
	W2Il7KMjgLZZl1UZam56OhMSOB2lusy6wnaNATNZsgt/autNsa1zxB7uRZQ5U287A8aE5XaRL7L
	8h8jouNabdwBT4ITqB7Pap4gEB38=
X-Gm-Gg: ASbGnctzIwWk5Q/slZOOAsr13ZBYlCVm9qlhBkIxfDfv5ZjnD9/Hhek3xIRIjgVrzqv
	nh7SMVUSjCjAVkYXIOOmQHtqIQPW6KfQHJFrC1mXbmiNwngR7ajBYBx9Kle1g0LVCZVicaiucGr
	IONxNkcUbfZTNIOXPn/XScWDk2DMmeZhJQ03VR
X-Google-Smtp-Source: AGHT+IEt32npMpSqc+oYfdWpGkaYjwOFJINr1egP2ot21DLx4xWJJGYwPyDhSVWDhviXTKqL4pePrdaK2WSZoTZqHL4=
X-Received: by 2002:a17:90b:1a90:b0:2ff:682b:b754 with SMTP id
 98e67ed59e1d1-300a2b70cb9mr9440235a91.2.1741794118639; Wed, 12 Mar 2025
 08:41:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309-ptr-as-ptr-v2-0-25d60ad922b7@gmail.com>
 <20250309-ptr-as-ptr-v2-5-25d60ad922b7@gmail.com> <D8EDP4SMQG2M.3HUNZGX8X0IL7@proton.me>
In-Reply-To: <D8EDP4SMQG2M.3HUNZGX8X0IL7@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 12 Mar 2025 16:41:45 +0100
X-Gm-Features: AQ5f1JoZBLbz_9g1m5DAAT9P0cIviCXCDpXwY5moXYtRUgpKeuGx2DKNWmq7oaM
Message-ID: <CANiq72mB+PHCfq6M9=2SjiX27=vdahkK-Rm6zDJtCg8TtuEi=w@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] rust: enable `clippy::as_underscore` lint
To: Benno Lossin <benno.lossin@proton.me>
Cc: Tamir Duberstein <tamird@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 4:05=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> This feature has just been stabilized (5 days ago!):
>
>     https://github.com/rust-lang/rust/issues/131415
>
> @Miguel: Do we already have a target Rust version for dropping the
> `RUSTC_BOOTSTRAP=3D1`? If not, then I think we should use this feature
> now, since it will be stable by the time we bump the minimum version.
> (not in this patch [series] though)

We don't (in any case, while we will not use languages unstable
features soon, we will still need tooling features).

So please feel free to use it, but it seems it is only unstably const
since 1.85.0, no?

Cheers,
Miguel

