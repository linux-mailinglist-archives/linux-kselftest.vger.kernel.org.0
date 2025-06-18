Return-Path: <linux-kselftest+bounces-35311-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CB2ADF3CF
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 19:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EA38189FEA1
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 17:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C992EE981;
	Wed, 18 Jun 2025 17:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/cgD3NE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A50139D1B;
	Wed, 18 Jun 2025 17:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750267902; cv=none; b=G+R2UPO8QuRTDsXcFKYvTTbMWA8RzWeiD7eOvjWxmDTd2VUgYMFZsYNVCN6If7sd8WHukhFPFNXs94tmE1+iGJ4xUNarQEHEbEjP0eJ5P5AvBcs+8QspQvSC46RCzoRQ+ZKePQoYlXX/9g81lS6QCzXpAzm2cobHH9YcPN4cZJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750267902; c=relaxed/simple;
	bh=3pcAMlMl8h1kR3VIDgyOrJ661QWQ8zzbVejWzAIbdX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c7Arx9UDycW1PNmpTh5JolbQ8cDQGO4Fe4S59S0yPEybMMNWeDC+nOcCA91rtuAdq81JhXAtjo5M9ABHSuvYC+OGYxWXQLKaT0QURiDk3aFR2ZGWr9DcdfeSScgfNWpSV5Db7WODzs63yT+xv/ZAAR2OjJmESebd78NEjb4JGbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/cgD3NE; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-234a45e69c8so6035835ad.2;
        Wed, 18 Jun 2025 10:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750267900; x=1750872700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=giEZC4CA1Gs2zQVVLh4SgqvtfIsCHKQ3JeTi6+ZWRSQ=;
        b=B/cgD3NEKx+xFzmeW+shhJJf2SkBCFHetoopcAP2FWf3w5kJ3hYdiPYzTxDHUzN4sP
         wmAXYmjJ0vafGVIG14JlJJRhna44tzcJV0H5PQxYo9NdvvLM1Y8SS5m6OCSy2WIzvIl5
         MweJjorvxYH9R3rwFVOhu4T7ShCKsPurPYBQvLP1E0gfg7ABHJBmhqIeGzlrjewA0Kw5
         JRuN/a9ABb9j+eryH56hNw7JbTSDrYtCCYBKXVzCHnjFgGeo0S51Ksxnskn8OGxKmLH9
         8CjvkuB3Fja1VmJBsCxwwRlTJjthZTBdvEZcyXYU1eX1mUhVzzr5/XYppf5jxJVQSKPM
         8Fkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750267900; x=1750872700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=giEZC4CA1Gs2zQVVLh4SgqvtfIsCHKQ3JeTi6+ZWRSQ=;
        b=iHewI1HHboALCUBBVdZCy71bOPYw+K1/2LcoKJFuUBh+XK995GfyMQ966dUorh74Dx
         ZZDAXnpa2383YYT7CFjBJNt6jg4Nlv3BboCgAeLNSVSrz+SrMKEzfdeMWhkaxgu5k7mZ
         6ZX//xHOE0NYV8EY5zmrsguYKi5VVlDKxgqZOQS1YwaLU6D0t6SF5iUlqdUb11ZHQlRE
         A0Hp+Lp9ycnK6b0syJRIY4Ko7b8ARPyiNbO4Zcu6zxYnsbFaIJiQbFDeq+nIbozpi6bP
         fL7SDQI5H1phjNNvtOMwPJ6tZwn2Jfc3nu+ifu34PvbROvEuekxZKozBCWtQSUbYHM5u
         8t3A==
X-Forwarded-Encrypted: i=1; AJvYcCV+TGEDKoB5o4/s55ef0XTCYTDS4Ulom0knI+/9j5vmVMTegAnMoUAB9uuN2ZYZ+4HvpZ9YkfmF@vger.kernel.org, AJvYcCVl5OkcEjFaxxAyz7Msm97ktlDi25B0GLSV3MRn7ZYeC0hS89Sd8KQV4JRnRkW0IHeW8Xnj8bd7DwbARneJmJY=@vger.kernel.org, AJvYcCWBRAqeuJsWoIlHHH+RONyY7M0Tt/GVsj/DiEglyvtsq+8ClJ0/Ah8ylQle5+bSRWJjD8TJPpkmDxDhnwnC@vger.kernel.org, AJvYcCWTuJBEUjFLbD+Yk+U6sj05qaYH6AEkF3Talp5G2aPWQuaz4tqepAJ2r1bvs38Y4Bn5CMu9pv/o+hYW@vger.kernel.org, AJvYcCWewu+N3s5d6XAmaM5VRfmUDS0KiOFnUMCYDxZRkeJvkWYPzyH/Q5Ov01ochR+HTsFF1fifJpQE8lc=@vger.kernel.org, AJvYcCXQDYJwO1XPpGeJZgZKlwTaeL8BPPASxC3TytT8lo6R8r3GrR0Grw5M8E8YuFPjY59INwU4cZVSMtSnjuHvTFHE@vger.kernel.org, AJvYcCXV3t9Kd82vq1geBRARDOT+rzPineWN6jrLVb7d/0bt/PUCXnsKxqryjoMcJAJvKJb9ZB8zFardgn7T3wc=@vger.kernel.org, AJvYcCXxaPuSksMUNMexPqMJUGAH9KbrWZVgcJngNJmGBCdFtZlp+HkxaAnvg2O1eUYt88eKrwD6boW6794xiME4@vger.kernel.org, AJvYcCXzYx7bGc1qaqdRhs8RkIqFgKVk4iK1918vroBkzF4lAPq14QmrbO6pG6qEexX238bER8wNgFnKaDiE@vger.kernel.org
X-Gm-Message-State: AOJu0YwSQ4XlFPaUz/NAy7Na2HhHlPlvETow6QDPJWS/yjbYuNXk36o9
	a7ijRUDy7QIBtHTJ50BfsdkfQ+MLJuER3ClVPTdH0PD9nhXOAuRKpog6vbZePNw+XvkjYy8wl3W
	WjsAeyEhqPyuz4vUKIjiFgXqfdSW9+mg=
X-Gm-Gg: ASbGnctkhi5XogupM9Vs8gKBei1w031iAwdNexC8LyWIBFvl9/zq0VT2odlAV+RqDgT
	MO4Pl6jMQDccOEbQyYsmxg+3BlUMvPOIccRR5jszD/7wcZy5a6xriKPZTh7pjutt/yB1ewJ33IT
	tJ/xpg041fMOGbgsYbBihUfd6htXGxARSktMiDgA/5HlM=
X-Google-Smtp-Source: AGHT+IElAYFQ7bmLDzGoK+LouyDOjrVrsskRPo8QHb8hQdYz3Xniksj2pUSBRZd+2TWCbtZwG0l3dCw6erP0uN8kpG4=
X-Received: by 2002:a17:903:11c9:b0:236:7333:f1a0 with SMTP id
 d9443c01a7336-2368ee1cc91mr46098835ad.14.1750267899755; Wed, 18 Jun 2025
 10:31:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615-ptr-as-ptr-v12-0-f43b024581e8@gmail.com> <20250615-ptr-as-ptr-v12-2-f43b024581e8@gmail.com>
In-Reply-To: <20250615-ptr-as-ptr-v12-2-f43b024581e8@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 18 Jun 2025 19:31:26 +0200
X-Gm-Features: Ac12FXx7GupXW8Bt-WgcYO-htZmUwVX0jAEiTk6mVy23gMLCIJ6y3H_HjinHnSQ
Message-ID: <CANiq72m1vd65BtF0gn1E6SSq=Xp9JTznZn-Yawd0yMMQdjPRYw@mail.gmail.com>
Subject: Re: [PATCH v12 2/6] rust: enable `clippy::ptr_cast_constness` lint
To: Tamir Duberstein <tamird@gmail.com>, Danilo Krummrich <dakr@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
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
>  rust/kernel/drm/device.rs       | 4 ++--

Danilo: for completeness: if you don't want this, please shout. Thanks!

Cheers,
Miguel

