Return-Path: <linux-kselftest+bounces-35306-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 637D6ADF35C
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 19:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 642CB17EFEE
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 17:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE442F0045;
	Wed, 18 Jun 2025 17:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEh0qImt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C652F003C;
	Wed, 18 Jun 2025 17:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750266267; cv=none; b=Ux1gUt0heK6apYVbS2RKh+fD5zFMjo1PJ4bzks4PesHMvUZYvuLhxpp4Gxvz9Y1sRy7FjV2eH1CjDLWkVSA3Xp+hxGxqw1XnzDSJGQ5gef7pqHfNiXA9S/Ma5eGA0opxRznXWU0cZa5+5jw38G4e4/gXH83B7TvZhA1RYrTWJDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750266267; c=relaxed/simple;
	bh=bzVpmXFF+T69S76tPY21hKIVM7O6QGPZHJ4LN2Hdnks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YsIZeffCnuSxPzbPDxQOYZmtpN4VcQDmOgRpG46tdF8v/SkWc45xJL6MHYTBsAPbRvFq2duvHCj3w157biAcBTCnoVjzMoXhcwbxtE62VSgYJdCy4hSjVatrIBBeWdWgECMsnuWAnwIj6yWYkikaIkc4FfoNndR331ojaWiA0Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEh0qImt; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-313bcf6e565so1206660a91.0;
        Wed, 18 Jun 2025 10:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750266265; x=1750871065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzVpmXFF+T69S76tPY21hKIVM7O6QGPZHJ4LN2Hdnks=;
        b=AEh0qImtdpSfkESC8oA+ZCstXPfxnWHg0WoqOuhZXvyIJjmTWSiolayt+EL6hsLuUK
         1p6USlyPCb8k/jezbDPc0dtjZDNpamE4zfDunCchnir1yFQh1XKyBfPi+hNE9KcQND88
         bx6S34+RKWMDsxNoccd3bid9Jc0IQd9VzmcgxcmS0HL2cCkdqo8rR+7nuxqJCGl75tSx
         CJHnGFKb08XNWV7IC64uUBlD1naHHXs25sgs6yJaCOG99oL6Sg/Ovv2qHuBsdvKlwTZG
         yGfEq5Clr4FUT2z93MqMJFI/UNi3IvzClUbrCX7N4CBipHJfp4cCuj3x2gkh1Vz4lFuM
         f3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750266265; x=1750871065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzVpmXFF+T69S76tPY21hKIVM7O6QGPZHJ4LN2Hdnks=;
        b=OpSP7UDeBlRYqfyajB24nO1Ik5jP13pBGhkTA2KZHRdOQPDJ+06cIuW5HAGFVQ0i3L
         rTHk7vew/v/boUsaIKl+mKEkYvNjNcg44cB/7wxGjFmrpwGwfIK9NGGhF9ncretw1K2P
         Hy+LsfDjpeafb2/UqRhaVF9XBa20cYuYRwg2dXrPHWjD1XQmg5hSh961LzCjlMEzuGGa
         +ssZN6F8GcY4PRCcVWIyKHfyQquvQyzpueCp/TvLI8tizMKmVnwR4YhYNuRjiD+Erdt2
         Zc0MbRUfrPbRufBIi1HXFaCry0VtaEYA8FmEG/dQPQ3IXIJwzKIv36xwO+YWTSrWlNpZ
         Tcgw==
X-Forwarded-Encrypted: i=1; AJvYcCU3/edkqy8ierCgiOjXlir2A0NMjbefLEiZOUiapo2SVgfRsAVo6NMA8Omuj2PawbhHiMtIDVpPdHapoOFMjm0=@vger.kernel.org, AJvYcCURghL3pi+U7jQIqAFV5gDStOmv7xWfGEhK2faYblXfWWYgqOOvi4duyHmu2KZHbJezTA63YiWY@vger.kernel.org, AJvYcCVALGLI+nDIAtqfL16wyWjzxaPUnAVZRQ+btxPfUzko1ZwVdk0YVPtvbccxAhyBbz7b3KQpmSE+nZzWJeKy@vger.kernel.org, AJvYcCVXoOYu4v28HYmPgojy5P7XHxZwIUJ40tatBQo8cj8Slvs//g+1afdiYpN/v1VvmHQaL/BTaWAuKQI=@vger.kernel.org, AJvYcCVlXLd61+d2cF39opuT1cYOaLhnVytylDF9VACUdFfsqxnscCzDoDuUrOSisiXoMqtY9BMYifJHWFEyjAY=@vger.kernel.org, AJvYcCVr3bj8BOlXmQuenW0kFmz2jHuHca69uLvfxEwXbikzKMWZNQHYNhUL/LLqTypsnZdkMYQLbI5W7Kgl@vger.kernel.org, AJvYcCVrJp1ATnR4x+V3vquvCiHZWXUgogGEhc22x27vEkhnjwAJJXZZvtfMErxvyMpQyDZ/3zwggoICs8oL@vger.kernel.org, AJvYcCVu7EounMLxyTZCFbEjN66ZgURr06tWUF6fp1L1M5t/+UZBjieSKCTE2I4CP6FErZ2O2BymbhoDqOr7LWTqTfI+@vger.kernel.org, AJvYcCX0U2Yh4fVsInrUHHTNF3cgEipA0+/mWzeXNgina7gvJXxEUzON4Qmy8gfnnKTHB42A1/xDTTHFWrw3iOSb@vger.kernel.org
X-Gm-Message-State: AOJu0YyCXBif5VwQpt/011aQ/BNFhw8ayBUqQMLkZyWimlnYJ4UFMxhy
	PnAUoGZXpHNWEdhOG0sTEsPbyjiMQtVsPt2LHV53ijFrqFUa0qnnliaTTKumHsXY1etR9ErFn+d
	ECEq1RrpayTN0N+cGnDhV8JE8tZ43WME=
X-Gm-Gg: ASbGncs9yUJJa1Pejiop1kuN8/XW3cofiBxO1rdjVAfYs5pwTnTIdNd0ST44Ga7eUAL
	zPHX/Nk/YTZ9xFnkjBx8KHgK7Wt3XLsVsiEYu99Y+Bg/W+JQklUhJwivujp/YRIWwLyzAyTTcqz
	j3OU1ko5TEN1KAVpIW+J236pSMAzatca4uDm78vUkyjKs=
X-Google-Smtp-Source: AGHT+IGLPSVFYPhvf1j/K9i5Ol5itQWfSDa0TfKsaOdtXXSM6IGI5PpH0AQX2y0lYKJIABjfvnv4mQ4chj2kWgpmo4Q=
X-Received: by 2002:a17:90b:4d12:b0:310:8d79:dfe4 with SMTP id
 98e67ed59e1d1-31425ae54f4mr4444282a91.4.1750266265350; Wed, 18 Jun 2025
 10:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615-ptr-as-ptr-v12-0-f43b024581e8@gmail.com>
 <20250615-ptr-as-ptr-v12-4-f43b024581e8@gmail.com> <CAJ-ks9k0vAw9UHx-s9uD9u0LufvgnojtrFoG=AH40Gp9HnxEDg@mail.gmail.com>
In-Reply-To: <CAJ-ks9k0vAw9UHx-s9uD9u0LufvgnojtrFoG=AH40Gp9HnxEDg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 18 Jun 2025 19:04:11 +0200
X-Gm-Features: Ac12FXzqpoYx_1GdDyAZ3UU1L_A1NGXd58Gt0NSR1KeeHmAk1xTtSvY9Na-qvaw
Message-ID: <CANiq72n4rr-S5NtFECxpd8FzkZvE8mg++p0qWDLK7+C0ru1Tew@mail.gmail.com>
Subject: Re: [PATCH v12 4/6] rust: enable `clippy::as_underscore` lint
To: Tamir Duberstein <tamird@gmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Christian Brauner <brauner@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Greg KH <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
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

On Wed, Jun 18, 2025 at 3:51=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> @Danilo Krummrich could you please have a look for nova?

Alice, Christian, Danilo, Greg, Tejun: it would also be nice to get
Acked-by's for your (other) bits.

Thanks!

Cheers,
Miguel

