Return-Path: <linux-kselftest+bounces-35028-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8F9ADA3AA
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jun 2025 22:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E34C6189070B
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jun 2025 20:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092E227FB07;
	Sun, 15 Jun 2025 20:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOH9mKX7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A63C1DE8B3;
	Sun, 15 Jun 2025 20:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750020117; cv=none; b=iDx0KEixg4Q4tesCNK4tezhOlYzFViVtNFlHf5DYsYtBT7/u/XJAJl6BauCZafyLGAC1lZqKKQf7pwitWLygKhNVP0rBlU71FTkhQGCyZXatjtGwJ0GqmEVboB66ogPkdKZARETz1wVlso2vH/39V7EEpir8hQs8kJ1PW9s0QKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750020117; c=relaxed/simple;
	bh=a4gyRtdEznwSU6cfA3mXkQrTb8MEPimItIe4DbY/b/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bf/Q/KWXUCGENMO4mT3wFlNjtzIePebsh+CTSLEjOLEmSXt2xJblee7V5bbIZXspbhlL7W6sLZN1TSqel9q9AruJTcEgKy9wKn5To8+ro/1oIn7tAT7YDkCuoTB6rX+fTL2JtomhN68AeP5JSSpviO3WnFVY/4/8U6mFtbHxC9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOH9mKX7; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-32ac42bb4e4so34195381fa.0;
        Sun, 15 Jun 2025 13:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750020114; x=1750624914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8tUEHrU+aAiCA1wzd/2v+KwHHK/16tsTm7dd1xb+Qw=;
        b=gOH9mKX7RycUlzhO7U+MdAkiUFx58GZOpJTAPsXvRl2+hb2L+qgXqkApg4/aTnO6bi
         FLx6hBm3wDSi2vGVpPeTPo5Gu0hzLjxAGWnP3TOVzB/BKiD6ldyYb/DgPddGTZrEy8RQ
         5Gbo2ChmUCzSs6XDPv3wxS+ETp2KU7Dzkvac2o/i8t8Khcv7ZlfPKdiSug4uA+MdXI0A
         06vm9ynKfZGUqArnQOxgMx0rzrJUEikSENafDTPm8UP5u3Xvh4hFBv14nuJFEZHxfHw5
         pCC0OBHRo/m+kEw+aPoX8Q+eiCsR0YUlig0roHTFkn8q85TIEipnT2WsNx3pfJPCWOcH
         abbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750020114; x=1750624914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8tUEHrU+aAiCA1wzd/2v+KwHHK/16tsTm7dd1xb+Qw=;
        b=Srao99apaGx55OAHPMCVx22STgxqBp7F7nStobWZOZGAnsf6qL/gClz3a/4LnCMuIO
         CXbThHKvHRPATwoTsPozZBrj5rlQ3eqm2g/uyfiLpg+4jvo73/sLFpF5Vv3O+qSQTwM0
         UTcv6yZ7D31+YXuOt5hOv/LiDWY0oFzgp/SAzQNghyhJIzf7m5TUloDKYqhZMh1mlcfc
         eeHChFR1NmtpSfnKhvm+qSDXpKlS3vcgnMy0j/TGtxbfkDB9SKhoBmDpWsZxMTQG7kgk
         tK3PCaNY5X0Y1d2uWFafcbOXd8INZ0803G/xvUowUgS+9S5unjtyKmcZ9VVHvHnl0YAN
         P/Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUGzcyhSK4VaUjx/VqJ+OjDPOEf0bpHRZZ/WnQRdLdC7RkmfH+Z+7Yy+t5fR3TIW4QvfoFRzMLvi+gWMlBp@vger.kernel.org, AJvYcCVCFey7PtXPa33QEDTQZfGbM+YE/Q7d21xk3Dy3dKkv2cN1lfAMtDiSI73Hg/Xiizetgrt5cuW/fV22@vger.kernel.org, AJvYcCW4K787SXjJlZ1crxnyDmDXijPRVm6QmtZBHYVvEt9VpSkxQNnOVSVH6a8BgmVRrwafOYae1PO2dP7f@vger.kernel.org, AJvYcCW8zjFdV8dodHghcEMde/5aGoKsEIUigB5WaURFgKOlEp2j8o6gUbtj5U2mdBZ4azTnNQ1lr+NB@vger.kernel.org, AJvYcCWu6dxmMWxLrJZek2hlxjmyHAxJzGFSCXMT9jRblNJn9puAs54E4YBZc2fbllhXh/VUzNVRVz13r52riFmp@vger.kernel.org, AJvYcCXRj0D2ceSyj0aaqgeCCYRpfVQiKaWWSj42/8xf03DL5ORhSqo016F/lklgDlb6u3xN44iKUJ3aKre1ZqM=@vger.kernel.org, AJvYcCXvcWRGPESO98hPKmWc1BCjwny9VohD9sTPKPiS3HtrTSVNz3CEZKY/8Uu1CBobmvaSCeteq97J3Pf1fwJzp0EK@vger.kernel.org, AJvYcCXxpqgfl0myLRXY1WGqeWHVm0tkBh0hTfI2V2tGa6d37ZxOZ6MLdBgPyupzT/VWUhnsBRIHG7QHN9swDRwHsZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPC24ZMGdId1eMXAe6Xjnznr14A6BRW9lDT+OCYUlzG9TVoPPa
	4MqWoO4FtLPr4j9uhr3VuYzWHBIYWlzK9FSDFM29oQM+cD/ONlTLo5jv+YlAY4VqYiXaE7s498l
	QTEYpHxLB4hq52NlWkE8X8ayuiKvBAcU=
X-Gm-Gg: ASbGnctJT+ocTEKoM242H3DSen76/sHTd2slTCBzDotWBE+l6smcSHcBSqlrSuvpLw+
	HfYXErO9vpk5QY+sMYXtKvKVgR7bL3kl1T2nVZgyNNMH9n1nqzgJLJpq/hIGnfoYr5+qAGECB9B
	EgXyiH3eU/fhyEmfSW+E92A7a1t7tnWsDDhtYCrHf77l0RoqHusB4K8AxNQBZOYJbaY8HIAB10O
	cfMLg==
X-Google-Smtp-Source: AGHT+IF17qm+FSbVV14Pg7FJ215dDeNSyp0hu+3UB0vAUnPJ/I/b7hzjcOF97wvz/4vYu6TXyZ0HeK2zzMOU3xxjgxE=
X-Received: by 2002:a05:651c:507:b0:32b:3cf5:2ff3 with SMTP id
 38308e7fff4ca-32b4a5a5c9cmr14597681fa.22.1750020113944; Sun, 15 Jun 2025
 13:41:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611-ptr-as-ptr-v11-0-ce5b41c6e9c6@gmail.com> <CANiq72m1ZWxPgCda1C-8X5XOvEq9Z9JfJZqhU4ZUzZ64=N+2fQ@mail.gmail.com>
In-Reply-To: <CANiq72m1ZWxPgCda1C-8X5XOvEq9Z9JfJZqhU4ZUzZ64=N+2fQ@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 15 Jun 2025 16:41:17 -0400
X-Gm-Features: AX0GCFsBQDbpDdusKYtZ8m3QzN_wjkIx6XFjpQUGjjmQDdCD-7AoaM2XitZK-IE
Message-ID: <CAJ-ks9=eWA-CCJn32cVQZhBnz=dgjPTt6av0Uw2m+_nfRXYcbA@mail.gmail.com>
Subject: Re: [PATCH v11 0/6] rust: reduce `as` casts, enable related lints
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Benno Lossin <lossin@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
	linux-block@vger.kernel.org, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 2:14=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Wed, Jun 11, 2025 at 12:23=E2=80=AFPM Tamir Duberstein <tamird@gmail.c=
om> wrote:
> >
> > This series depends on "rust: retain pointer mut-ness in
> > `container_of!`"[1].
>
> Not anymore! :)
>
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>
> Thanks for rebasing, Tamir, I appreciate it.
>
> This has a bunch of hits in configfs, cpufreq and Nova [1]. I guess
> you built without those enabled.
>
> Could you please fix those? Since this affects other maintainers that
> we need to ask the Acked-by to, let's try to at least give them the
> final state.

Oops, I missed this email! I will send v12 shortly with these fixed.
Is there an easy way to enable all the relevant rust configs?

>
> Thanks!
>
> Cheers,
> Miguel
>
> [1]
>
> warning: reference as raw pointer
>    --> rust/kernel/configfs.rs:429:9
>
> warning: reference as raw pointer
>    --> rust/kernel/configfs.rs:467:9
>
> warning: reference as raw pointer
>    --> rust/kernel/configfs.rs:479:9
>
> warning: `as` casting between raw pointers without changing their constne=
ss
>    --> rust/kernel/configfs.rs:564:48
>
> warning: reference as raw pointer
>    --> rust/kernel/configfs.rs:721:39
>
> warning: reference as raw pointer
>    --> rust/kernel/configfs.rs:764:35
>
> warning: reference as raw pointer
>    --> rust/kernel/configfs.rs:783:35
>
> warning: reference as raw pointer
>    --> rust/kernel/configfs.rs:764:35
>
> warning: reference as raw pointer
>    --> rust/kernel/configfs.rs:783:35
>
> warning: using `as _` conversion
>    --> rust/kernel/cpufreq.rs:650:45
>
> warning: `as` casting between raw pointers without changing their constne=
ss
>    --> rust/kernel/cpufreq.rs:650:45
>
> warning: using `as _` conversion
>   --> drivers/gpu/nova-core/driver.rs:22:64
>
> warning: casts from `u8` to `u32` can be expressed infallibly using `From=
`
>    --> drivers/gpu/nova-core/regs/macros.rs:267:26
>
> warning: casts from `u8` to `u32` can be expressed infallibly using `From=
`
>    --> drivers/gpu/nova-core/regs/macros.rs:267:26
>
> warning: casts from `u8` to `u32` can be expressed infallibly using `From=
`
>    --> drivers/gpu/nova-core/regs/macros.rs:267:26
>
> warning: casts from `u8` to `u32` can be expressed infallibly using `From=
`
>    --> drivers/gpu/nova-core/regs/macros.rs:267:26
>
> warning: casts from `u8` to `u32` can be expressed infallibly using `From=
`
>    --> drivers/gpu/nova-core/regs/macros.rs:267:26
>
> warning: casts from `u8` to `u32` can be expressed infallibly using `From=
`
>   --> drivers/gpu/nova-core/regs.rs:35:65

