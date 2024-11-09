Return-Path: <linux-kselftest+bounces-21732-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8679C2F83
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Nov 2024 21:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A41FF2820CD
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Nov 2024 20:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766CA19F471;
	Sat,  9 Nov 2024 20:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZPSddN6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E37D13BC12;
	Sat,  9 Nov 2024 20:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731184366; cv=none; b=HbecqsgoYnFIluvzRD6mr3myALRKlLkAOhgiOrBLXWejeBip0uSbJBq4+i5wdwVK5aLushk41BCSJrlbyxKb12JvLLkmqvM4T0AAH3bnPFvArJ6YhQiEyVAvCkz+72YtsyAnjArxD+6CjWM/jYGmpL7wCwZv/OSQUszD+3roAAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731184366; c=relaxed/simple;
	bh=8xpxyEfI555geThWq9tsO1QjLFbEyBXqujrrvnAdajY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kH0zPWTZ02xSfnS2WLqeldojHByGCfS3NaIEH2xjpHX2C9z2SAkLLYQzIHSnVetcD/6UJqzVx9Mr46M9WK+LtSOAmDiknxO97tljDq3rI0RPGehi07CE50rnJ9UsJ4hpuPICiVeStjumn0vyavIIZWsPx52ugVXfrAkAGf8NZ9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZPSddN6; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20cb8954ec9so4170265ad.3;
        Sat, 09 Nov 2024 12:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731184364; x=1731789164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txlj4/on3Ga9QXI0Vgih7uY95lnyqtcv0s2L9FFiS/0=;
        b=lZPSddN63YLgCwLexGZBCHb4BQ/9RlXTbl2tCxU9LLiMcMjz0MsEgLOIVFl0WZIPEQ
         1qCJLrtsVEJzreR2Fvlw1XOnPvQ+jAWm+moqtEHZHoqSFkhfm45HV+G5d3oWJLB/3qwj
         vpKKzFZLEBHVwjC+bN/iyAsekfBPsVGStrkasLhm8CMO6pmmOAX3y26VJHCumDAUGFcv
         lwoOxJnP4Vp2jhQSALDFDJnpkwxZWD+mLvT+ltlq7Cyk5XtyAHELkahGm7Gkk1skGOcC
         xYIwRUGu8o6o87Pim/F2zVqPJPc5IaPpkIom8ur2BWok13JDoYyxQbtdawY7PXMfy4Gp
         b7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731184364; x=1731789164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txlj4/on3Ga9QXI0Vgih7uY95lnyqtcv0s2L9FFiS/0=;
        b=aOfKuSi7rIbYmMAM+Rrt9U1wWMSU3UlwrrM81HOywiX2luoPfR7gzeAImcV60McnVg
         N3Y+xmJoK+82sfg+0z3w3Sc1MD9p22xx3mVZlJP4GDBce+cyjGBEqZouSDVGAh1ZIJbU
         7Fvghxx9Kampm4cvVjzDBVW46B9uCfO85PsXhZ/qORg+G3EkgLFezzhj4xjul8V3DZ5+
         vyfq3u9O3JRWt/tqSnNZpS7B+USMP1q40g3Tyx7m1rIi2r7ZdSCSYP8OvnX++x+1HSAU
         r0Zy+aGeWdTpqYAQS+sa1HoONaC9CL1q4gb8MrGxMdnBhUcU4ikaSJw67qSRP3O7A3EP
         lRIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBwIXn86J0iT7GIyhi6A1FN8L0GotDxBQvIfCbpqOfq/flcvmSnx9liXxz6AJsydPzodFkB21bfaCRM1k=@vger.kernel.org, AJvYcCVbOYmwe3NVT9LrsmDmEhWaqJXrGA21rBrWJICUGaFQqXdR/iKo2CPPHu7IXpOdGu4hk6HwXBEKM92GtR3hwGSJ@vger.kernel.org, AJvYcCW21S/vF7kwgvqcH7JNEQWLin9j66WEeaXk25eTnsqB2aYNWwiRMtwusOg0e0cH0cWlBgAh3F4LWZC9S9LGTRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVQysvEL+XOQXCzPwBsL9RpZbrVZ3Sgt41GYApLzHw05PiJxoJ
	1ztlylN+ZSe3r2bVIj/O3QXRF3eiZXrn7F3kzfRwf2Cv5OsGqYsDvq0gQVa/najm8qZytrlqUBe
	leTREeR1PhmJIJh40rZQCz7ghL6E=
X-Google-Smtp-Source: AGHT+IHBcFg3hYK28O/uquSXklX+ZaazN5F5oi/XKmnhVr71as4eEqMd8emvbhC6Y0ZBhIgfi3Ojg1DgmNOZehrFfaA=
X-Received: by 2002:a17:90b:4b43:b0:2e2:cd5e:b25 with SMTP id
 98e67ed59e1d1-2e9b1680927mr4264455a91.6.1731184364243; Sat, 09 Nov 2024
 12:32:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101064505.3820737-1-davidgow@google.com> <20241101064505.3820737-2-davidgow@google.com>
 <ZyUUGNywoADngOwM@Boquns-Mac-mini.local> <CABVgOSmAj0hwVF0cKmzK_wS96Q4hgbe0t5L2dHFpcZpqrHev4Q@mail.gmail.com>
In-Reply-To: <CABVgOSmAj0hwVF0cKmzK_wS96Q4hgbe0t5L2dHFpcZpqrHev4Q@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 9 Nov 2024 21:32:31 +0100
Message-ID: <CANiq72=-8mq0ke-_K_a1syX6QRyQXRKNka6GLKWuMHAOn236JA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] rust: kunit: add KUnit case and suite macros
To: David Gow <davidgow@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	=?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Benno Lossin <benno.lossin@proton.me>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Matt Gilbride <mattgilbride@google.com>, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 9, 2024 at 9:18=E2=80=AFAM David Gow <davidgow@google.com> wrot=
e:
>
> Is there somewhere else we can put the attribute to support this
> without having to either disable the warning, or use the experimental
> feature globally?

Yeah, on the item, e.g. https://godbolt.org/z/oo8osadn4:

    const _: () =3D {
        static mut X: i32 =3D 42;

        #[allow(unused_unsafe)]
        static mut S: *const i32 =3D unsafe { core::ptr::addr_of_mut!(X) };
    };

Cheers,
Miguel

