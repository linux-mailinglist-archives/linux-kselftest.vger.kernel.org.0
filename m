Return-Path: <linux-kselftest+bounces-35307-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79A0ADF37C
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 19:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A9587ABD93
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 17:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A932F49E0;
	Wed, 18 Jun 2025 17:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMNw+bd1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE40F2F3C39;
	Wed, 18 Jun 2025 17:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750266378; cv=none; b=OglTGCtMxs+40PsWr3D8674fIP95X/cqjakTwj67jw60J43p7stmaHvHJSQ+gHFqEYt2JL0U/PQbBeG9T8BZak2/azqKwVvxElrz94jRJmcMTWdZvebpBdhZ6f5ZKios94579xo/rjv8zS741zevLJ35NeBMePPsXdFfN4auuJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750266378; c=relaxed/simple;
	bh=IQ+ULoaBxec9yBNcJflV6Y412Q8N+SG1nYyU9X2N3BA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rKCQrqhnaRYQWA3kny73sr8Br7ihlbA6yqc5FeYQYAV7RsDfAgCACP0Eq9TTcDuvBooLtnNGpSZYZJrIbilQNaL8omKd7kI2CkCc8x3/m+Ytwcy95+egDezJUiY0Xk2xCxmSYfvvADYQkz0WVMFWUdXChGrwDI5FofokaQtO/2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMNw+bd1; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-31306794b30so1219814a91.2;
        Wed, 18 Jun 2025 10:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750266376; x=1750871176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQ+ULoaBxec9yBNcJflV6Y412Q8N+SG1nYyU9X2N3BA=;
        b=aMNw+bd17oB2mRBMP9PpnA6AQ8Ho9uqvYex3nmeyC/adeOvbz6uSTEmTLuI5ZkVfe1
         TdKFi925cbXx+nOigqlCp0wd6fDaz2GYLago1z3Fj1BYIXduMi2luWefiNShFCzVbPXE
         AtP8mqKPvbddMgT7SlPti98IDyA5vnoN10EZnBB8lu0ovz/RAz04QanLbBSRifV+FwLF
         4mgzzEaLQLLsGWcNOTQDaAj0U5g5LVLyqWPTdmvJLaWw10ad9cWxKo2eCBq210Epjcd/
         livTLE4NVQ8mD7yug9mDYrWHEhvmcn4Mftkg9AyO6CSPENEFPd0Uafei/1VBz4WLOyjP
         rpQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750266376; x=1750871176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQ+ULoaBxec9yBNcJflV6Y412Q8N+SG1nYyU9X2N3BA=;
        b=NCupsxCCOxYKwjCEfKidNU6KmA2AzAoRx1wR5i2/YiCpgYIesCWSJdonl85HCb79V7
         lV9AsZOsmqLlTRUUgCG0TLxI8VJoQpjG83e2rKodzdu1HBOgSDOB1cWs2yGPqesUhyNb
         9mvsf4ptoE6MVyUjEXB2btPU7OZVSo2nXuUDgkl9xFZjkrlPs/MERDJwu5BxVh/S7dvp
         /ay9RKQZ/kSm7C68luJsiRHgOZGu/RcBXYtckoMyE3XqztadIlbjXzx0tF32f7dsgoHC
         iQG6c90HRdTcTctEB7l33CC1hwDl0YX8x8lT75Phzeryb9ljwBLNFvBgkfccJTeX3I1E
         EGEg==
X-Forwarded-Encrypted: i=1; AJvYcCU8UXvbnzvwA6f92NdmgqjLmiQqaSKv1GHUSmJm3zirvNfSzDmSavt2eT0E6hrFv1aKN+3yCZc4gbEUjOw=@vger.kernel.org, AJvYcCUBHLTbIa3FWCvmaTxAVSCF4aKrFoS1WWMQb/5vqs01ARgfpIhuxMpvHjC3zDF2EF0oSMLisS3PCCr1Bo0oGRg=@vger.kernel.org, AJvYcCUS21MgcasJfI9onWE8J2LhjpPLmRrxejS+jd5fxyoKi7VuI/eV1s/F5/V4OF4F6N5wO0A8jpyF7M8=@vger.kernel.org, AJvYcCUaHMZa3FK3TrX/Kd6VR8KEf9DKU+Dr/hfyR+TToVtXCMol5zUEVxkVq0FY6fjEoQzsWiE+GR6Q0KEJ@vger.kernel.org, AJvYcCUig7si4J9bDM6TeUlpm6sujiRKLhAWAVPzoD98eFD4L4izsqktq56Mc8HDa9TkIpls38HTz7xRjTq2@vger.kernel.org, AJvYcCVo788FUnFx56+f/ekS0A70MX/cc7fyG5csZ9pgGSDs5lnZO74FWWlNKbss6W/Wj4TfU/9GdA6PTG0UxUMi@vger.kernel.org, AJvYcCW5U0ExC39JQqoZufrqWuyt9f8U1sOU3U+Fa3xWtjbaLdeV7CMrdMwHvQzH1b/wNUwoITR7AFmF@vger.kernel.org, AJvYcCWKTgCpOlZqoJy5Zc8kR1/qNFwBq2FBvMIuy+NE0APET2pH6RVRlp6xFAt35gPXBJ9+awuww1JYsAJdDZlC@vger.kernel.org, AJvYcCXHyGEOUdtznX2h14tMpy47ukDHKQ07hPMohrFYWwmgjZReUV8TM97aaQO4GdRBBrIeL8hkt3PW2W9ClCck1RX4@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk1DpYJc8qOVx3a1eEfZ/WF3N/SibmvWmtgzGIjFXQIYRkeAh+
	AlESiKu35QtNv3PSDuzMg0eQoFc5KkXsNaSnRX7/t7ZcUcUWc0JkUZ9mYdDzAh3h4ZSVMiiR0Pb
	dBb/4xjFuwIMQ+GO4Gsun/OmUgEFOtuc=
X-Gm-Gg: ASbGncuMYO1iYYC2nw4lNfsXW7J2qesT33Kdr+rX3NSzG1cp1HpBkYjENMcHeZF1YMQ
	tbUtlhLIMiltQoH9iaxbmb1UvAT4O2pkL1k0c9tZTxX6YEYHggBFUVLTHzDoJ8Cs0yL5ERXW7cI
	iCqfGCXcgLTFOj5q+1lszoX73U4HTXp09dObFY9fi5LXE=
X-Google-Smtp-Source: AGHT+IHirtqhFXsuURYJFw2U0NHBhqBhBYGB1DxViI/aU8M6gaMBzEOkQBGGBiqg7VHDZ1qURJrmwHpGk9SmvSWMmek=
X-Received: by 2002:a17:90b:5825:b0:30a:80bc:ad4 with SMTP id
 98e67ed59e1d1-31425261c29mr3942028a91.0.1750266375986; Wed, 18 Jun 2025
 10:06:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615-ptr-as-ptr-v12-0-f43b024581e8@gmail.com>
 <20250615-ptr-as-ptr-v12-5-f43b024581e8@gmail.com> <CAJ-ks9=P=N=5L8yre_C7xKoEt=t0f=Sf3ZY5POHuhb_3+5GO3w@mail.gmail.com>
In-Reply-To: <CAJ-ks9=P=N=5L8yre_C7xKoEt=t0f=Sf3ZY5POHuhb_3+5GO3w@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 18 Jun 2025 19:06:02 +0200
X-Gm-Features: Ac12FXyBNxzN0lq5c5vwJkk5sgyraS1J6su2qYnb3x7QnOeHycaA3OMq8R_Q0z8
Message-ID: <CANiq72nkN4u3tTihF9MQFtFe4AizBvb_Te9oSLtvOjNfzxq3QQ@mail.gmail.com>
Subject: Re: [PATCH v12 5/6] rust: enable `clippy::cast_lossless` lint
To: Tamir Duberstein <tamird@gmail.com>, Jocelyn Falempe <jfalempe@redhat.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>
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
	Nicolas Schier <nicolas.schier@linux.dev>, Frederic Weisbecker <frederic@kernel.org>, 
	Lyude Paul <lyude@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Benno Lossin <lossin@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
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

On Wed, Jun 18, 2025 at 3:52=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> @Danilo Krummrich could you please have a look for drm and nova?

Jocelyn, Tomo: it would also be nice to get Acked-by's for your bits.

Thanks!

Cheers,
Miguel

