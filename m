Return-Path: <linux-kselftest+bounces-35310-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AAEADF3C6
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 19:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BF8918960F7
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 17:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A19A2F0C5B;
	Wed, 18 Jun 2025 17:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1u0rdaZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3C02F002B;
	Wed, 18 Jun 2025 17:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750267780; cv=none; b=NjCyofTG8jT2cuSgqhFV+tiggfu1RvZSq9KKUzilxC1BHnXvJrL101M8/xdjVQLSCr7j52Pynk0AADQmOBbHeb1gtvfEj103uBC8aksCAzwtPSjXaDpMbPENdFiICb/3ZG9+H3gFYGPdUrLITZxKutjFdA4AkJn5VJqMYpv1Ee4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750267780; c=relaxed/simple;
	bh=B8UGx6n9SphTqgbfuQGAAGxgsKX0Yj+9FZWFY2I3HAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ow0hwTRhFn2zpXOpyBnmUZTrfeU8BWz3jKBQfZcHMKkRa27g2QsbEGMGvVvMMXOw34ylHhgRMKLB3xCmJUMdmGNTD11ZsAfP+XVUcdq4I1vtPVLid8fRmFxBu/0x3e3QzsKDCD5IHMioc8HIaoFqWuVaK26MYtT7nBarlTML/E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1u0rdaZ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-313756c602fso1090694a91.3;
        Wed, 18 Jun 2025 10:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750267778; x=1750872578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHUg/jv+8yS9h0AdG3R183q7U86xb8yvD43XyhKBDE4=;
        b=Y1u0rdaZYKFbduReNz7SfvhbJMpiG92w2w0uIuhNLJunTCQ+TSY2s1aSZtAcnX9a5t
         KScDHBp1SfoiFgoA+UQk+c+ooQbpF5V+VX0v2nLbyTYsYLeuFfAHXhbJtzWo1rY542Ai
         wv7Bj072IZx/0qSYVRrH8Hsz1sk5LVwydifr/jj0kgU1DdUNhB6B5p0MXGX3McrLTehT
         DsbxOElC6KivWN0rw5tEsRL4wo0xH3OLPhTikZZJmmJMk1M/C4Q7ez21KZRuY7DbvPDb
         DLbo7zdDJrqQSIFk9gx08CWihARUA0Zla1WUgKUeFzkJmM+ftPjctrbtAZSP8n77wRRg
         ht7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750267778; x=1750872578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHUg/jv+8yS9h0AdG3R183q7U86xb8yvD43XyhKBDE4=;
        b=InxsdBLWvSFQ1HWA76ZGO8Bphv0E6VLEaQAqxRmZiHROIsAzwyYXu61KEUI1auoPEU
         aneafxV5QpI/ZLoMlXEFZurQgVgj+Zf21yHVGSXfpQnDfN+6A2c2U7ol1fukYOTOC+I1
         lA+LpT1uoCQYeH9kLqz+9TtE3BjT6mRzNGRw5wUJPkxKc1QQfAKF/q9zxZthRhjtxWmv
         w39WRWDPq+Dhe7/1nalRjWELQ74JXPcrheUdbeucmbbkfWV+jzcieHIYRnVYp8Gwoeh0
         RzSByMAr4P3AuwZSLZ/bg67MNJrBwLmVdbwZAlkWOAQvdUASJIPJUuwAMO0EubfcJ4vZ
         shVw==
X-Forwarded-Encrypted: i=1; AJvYcCU6shL75O+2xj/NuDxgPaNRtUz8Yjw60rjtmG58vMaYcMWQCSVefouNIZXnW++XdGYgOeQh6f83@vger.kernel.org, AJvYcCUBEqZ69Kr0l1A9btSaVnrOIEYWgI4Wb3LR/YWIUWY9BVlfHSmvWDXhDo/5jxU9mdyfzaT6a+oSCZON@vger.kernel.org, AJvYcCUPiZ2bAt4or15TnP8wi3KkdaWrwnuOmrw/rs1O8mxNCT1gWgZtFRyIF9oOEmgzMuog3txewp4dQ6w=@vger.kernel.org, AJvYcCUqvAi32SSXWGWPH1rV5RTMQHm6L+FLJyOW7uk9R8f+LH0fOdD78YtLKe0jIAdw7x/q0nn2yrRF8hrhOajN@vger.kernel.org, AJvYcCVVkkQ/xfkMj+Ayx0U5svgUhCOZAUuBKS2nCvD0UtfMv0V/ftM3qloTFoaiOAA6iSZ6uC2m4hzEZhxq@vger.kernel.org, AJvYcCW6DfEA9LpfnQf0BnyLnFQpXuhRje4+M2xQ7iUmDMnu3+3pLLBVSjR6FCY2IC0CVg10g5vYnxAH69kFUIg=@vger.kernel.org, AJvYcCWH5bXNR7QBrR8dvrwY3Lst0xXoto2tNG4d1gZObALtPFC2LejgxUJo9yHkKn0pWJMonUSkloUqP8WVDm7XKBxD@vger.kernel.org, AJvYcCWhxrYjY6gZ88rtJJJ1p5ZKWdK9EvHEpoTV6bahyrm5Q0fiB7ankxy8fierHrWjCUj/7ehxmds/8Bna/MfW@vger.kernel.org, AJvYcCWuFjBtYYY1E/xuQYuuJjAFQ51s9VUNJ+zrkaERb6q/VMcpkc6AaFMIqKkNxlySQ9Pk8Ui2eUmHypNIZTd8+hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPU8h+80HG2+tJrtJIe6IhyWnQpWyvBqG2JiGuc9EYWyydlddf
	c0CCmHb5jOXAUYov5CeFpnImVA0aRZcjfNQpBDacNRVHwh3tfF4c8V8TBcHjIGatd/xetWVPlNO
	vQzd4vhY3QnnYsO3MM2obuk7umHV/V4A=
X-Gm-Gg: ASbGncvoKynJvbT+aF+RuxYBCDUdexyV6TRetDTS0Z5ti4obQLI/9viYzMB4f7lfuwb
	5ybbeqzEEW//oh5MOBeSIBXbBXHX6M7IId9OQ05wosHMK8kv8YR0bAbm6h8acDtYu6rdHg2Gd7k
	USFzDsrDx6I3AqckzN3dioAmk7RDNFXPgFbMB5+49lQw4=
X-Google-Smtp-Source: AGHT+IFq9ZRT8EBGthi7dxIDQNclEwdJhDhFsEYu8DFI7x0ubODZrG0p5NckRqPFYz4ild8B+/dW6oREHry5ELX+Kuw=
X-Received: by 2002:a17:90b:4a07:b0:313:151a:8653 with SMTP id
 98e67ed59e1d1-3158c004765mr67329a91.8.1750267777769; Wed, 18 Jun 2025
 10:29:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615-ptr-as-ptr-v12-0-f43b024581e8@gmail.com> <20250615-ptr-as-ptr-v12-3-f43b024581e8@gmail.com>
In-Reply-To: <20250615-ptr-as-ptr-v12-3-f43b024581e8@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 18 Jun 2025 19:29:25 +0200
X-Gm-Features: Ac12FXxIuJv_kMbDdBqAZBwk2iCsUdqf0pxgEqDUQ6dB6Y-mWXL8-29ebiQ2HSg
Message-ID: <CANiq72mn6fFL86-7XjsovdjQ2ySiNNviP4dvE170FmK_4E19OQ@mail.gmail.com>
Subject: Re: [PATCH v12 3/6] rust: enable `clippy::as_ptr_cast_mut` lint
To: Tamir Duberstein <tamird@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	Greg KH <gregkh@linuxfoundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, 
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
	Breno Leitao <leitao@debian.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
	linux-block@vger.kernel.org, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, linux-mm@kvack.org, 
	linux-pm@vger.kernel.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 15, 2025 at 10:55=E2=80=AFPM Tamir Duberstein <tamird@gmail.com=
> wrote:
>
>  rust/kernel/devres.rs | 2 +-

Danilo, Greg: for completeness: if you don't want this, please shout. Thank=
s!

Cheers,
Miguel

