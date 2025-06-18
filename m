Return-Path: <linux-kselftest+bounces-35317-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E532BADF554
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 20:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CC17403E27
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 17:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3046E3085C4;
	Wed, 18 Jun 2025 17:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etEYw0G5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E3F3085A8;
	Wed, 18 Jun 2025 17:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750269469; cv=none; b=BIwV7L3xQ0xO6l3Lmdpq7tykPD2H3PuXShJ8dujX50LD3GoIhEPiJk1jMKfee4KaHBsBmBTdF+p/LAXN3rH+SFeZl+qma+YsX90odJvwy7xWg4D7Z3s24w4kU+g941Jm1yZWwj8TnlELYlljiH+6LMV96L6yFzXTteqiRtNP3Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750269469; c=relaxed/simple;
	bh=xvbpCHoh061DVA2zXXba49YyPXgWLFHdq9S5LqMpTVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CI9GMf5KRTMYtyI5nCfQWiW4RqBII+MYRHRESd/QKdUr0KI3dd5XqQlD3BG4llieifG+B2BVubuWcd0iSYM8AqsgxhLpS8sAFL9EUXbW/QFBNIUcoi0WerbeNuTS3EwoNFO6m2UKDNtRN4WO91mL6lPCnf2ZqOqsyuPYEb043hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etEYw0G5; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30f30200b51so80308091fa.3;
        Wed, 18 Jun 2025 10:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750269465; x=1750874265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvbpCHoh061DVA2zXXba49YyPXgWLFHdq9S5LqMpTVY=;
        b=etEYw0G577ly5SNH3rtJjZvvmKXQekICL8HvahtNfQhC/MwFY+570ji1ZPAy0hmjgF
         o9JWL6/kF5vKBL+IOjT09kH/KPku9pXgd4q4I1n19EpSAqCy8lWKVzeNdF6LpCsL3Giy
         oO+TUuJmwlKjb6LFteFQxyX8jcj6rD7QcxIVv49ieu47jIDHMilC6NejrF7Yh6DxevEp
         bIuZsuDivYy7dO+3NDIK4E4D7E9Q4s3ODTQfkkkKqjPpp3ksJrbdCntpf0t6DLRnM3YT
         rfWmkZtVR0LL/UntfkVnrRbz1qf33vpkH+Y5t5WMrLLpF0jBL9aJVW7VbvXtJUPadrGn
         P+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750269465; x=1750874265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvbpCHoh061DVA2zXXba49YyPXgWLFHdq9S5LqMpTVY=;
        b=pOEro0jL2qdpuv7D2zz6gRuOrXw+JB0J74lKbUEv9jS9Fjs4G8XQBtuLldOdlnHJ83
         ibHlX0gqNFI8WzbNt/ZBp94yBEwUyuW95AqKP0oh2OL+/RDeNhuE9PP6bSsFbAV7MUYY
         fh8KMPngDWYGvaiRRq0YjUiEHAxyPGWaxyiMCh3TWcvFLk2JWFT5T/waj1Myvgw9Kd5V
         7C2BO/p8fsaSxOBAJLQlV0FMWQ+vHKCv8lkf5OQl6G8V48+sUokdAOmxU5WAcEzbn1KM
         T/K6k7mrWNVzdL0VV5l7JLyrshQxMHOK8jBQ+Ek0Rd1kmYm/ZWqDtR23HSfaEGBAz1ry
         efeA==
X-Forwarded-Encrypted: i=1; AJvYcCVGE0O5CzwcqwcaJOPwDrHWbHH3W6Nz7ynolXro1QPqEH37PPiPsqZcBXfETEw29zFczk6gLlnjKfOyNRM8PRk=@vger.kernel.org, AJvYcCVYvzGCZhSsm/MLJyvqcPrDNaTIFWzgQP9O5TFTFckKRmsL8c+ZW1TzJV6iHQFiBbVvsS2yjf2JFBhTBTY=@vger.kernel.org, AJvYcCVoa+j6uWQ+CSQxfuCrR/GSNPy34Ly6WTt9XmijAmp8u9QqT0Zfz399tMGEntqeCHfaw4QalXoNeCRD@vger.kernel.org, AJvYcCW/i8kXyAYyaM1gcVBmokE1wz9fDS4WST7DRKtGIERR2r4kb+VMTAw8/+O+RY4lBLqQd+6Ril+4dU6yu1vS@vger.kernel.org, AJvYcCW3cX1Fh3YDoTTbDVYkQTMkWAtLiLuOzrjz3VYwhJcnRN+QrlfLeMLZtZyKDzjrlxOF30nC1g/ux4o=@vger.kernel.org, AJvYcCWUzFdkD2yLnxiMBxTA/FA/K86ztEldhZa4EEnzM2zIPRTbjLn5DdBuQue6bfkO8qNxF0+JEMhey5CN1JHe@vger.kernel.org, AJvYcCWsdSK517a33Vnrqi+bXA3xW0qGtv6e+sxmGXJGFhel+i/mS6eYvOOk039207iCj810PFgU+V5mUfAH@vger.kernel.org, AJvYcCXV1L09CtXED3HLpmjloF0Hp1k3lMmrdERLEUa0VW10zuvwEaL8CyEDaE1H+8EUATR6unh+2PPv@vger.kernel.org, AJvYcCXdL3X2u8A12WLR+ukxs1wG/fJUamPQT2jgALZ+9+3NOwuVmXh2YpLQcjuWASZtV2VJ3BkGW2cUbgsfM9oo6tdX@vger.kernel.org
X-Gm-Message-State: AOJu0YwnzdpDRWHyh/AP6Q2kGbPKdtO77mEbP5NUsPrqSIZ14w4SP1Kn
	Mxlgvw38C9cBVS7cOTnbENeVRpp+i1CRV8Ho1A6R3g7mR8kVAsw/vNyZX7INTMnlVuVJibC7zKG
	iX9mjSk8RJ6Tg+3u+0svXey35xTOAi20=
X-Gm-Gg: ASbGncs6u6xAl6rSKuBQbjdnjz28fRHL1Yq+gPAdTKI3/FdSvQPKsn8z+xF3Kq68cCv
	PZAWZpHBLpkVewuzwE0At9QO8dYyw9H5FPi3Tk4Q2EV+gvr6HrU1YBD/SHfzzjokxfO2IMwJmCV
	xkqSErNS6dAa4ql5FeFXBYTQ5jg5oxTGbP3DPqkaacxxC6OWfKs0NVZ22Dz4M=
X-Google-Smtp-Source: AGHT+IFGH5gYRz7HzyAkXc6xFQTZHx1HyKujaRGU1VWJSVoGv01/xHq7AkSOADDbcwptpLJI4NKBOCX7lc78OHe1zqc=
X-Received: by 2002:a05:651c:a0b:b0:32a:8591:6689 with SMTP id
 38308e7fff4ca-32b4a2d830bmr47463571fa.7.1750269465105; Wed, 18 Jun 2025
 10:57:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615-ptr-as-ptr-v12-0-f43b024581e8@gmail.com>
 <20250615-ptr-as-ptr-v12-1-f43b024581e8@gmail.com> <CAJ-ks9=6RSaLmNmDBv-TzJfGF8WzEi9Vd-s=1wyqBcF7_f7qQQ@mail.gmail.com>
 <CANiq72kgnKH2SSp76EdPeysExBWasqhTyf1JyReR65g6FMsidA@mail.gmail.com> <ccbc2a76-20fe-4f70-b69b-9d05b59f24b8@kernel.org>
In-Reply-To: <ccbc2a76-20fe-4f70-b69b-9d05b59f24b8@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 18 Jun 2025 13:57:08 -0400
X-Gm-Features: AX0GCFshtGegkfZ_3VnmKgAk7O_-RQpc08IGr2vNv8IcZdaPQIit0uo4DnD-Ozw
Message-ID: <CAJ-ks9kkmmHtMz0rubwEqGLu_08+gSzsG09gphVZ5e8Ccc77SQ@mail.gmail.com>
Subject: Re: [PATCH v12 1/6] rust: enable `clippy::ptr_as_ptr` lint
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	David Gow <davidgow@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tejun Heo <tj@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
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

On Wed, Jun 18, 2025 at 1:44=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On 6/18/25 6:45 PM, Miguel Ojeda wrote:
> > On Wed, Jun 18, 2025 at 3:54=E2=80=AFPM Tamir Duberstein <tamird@gmail.=
com> wrote:
> >>
> >> @Andreas Hindborg could you please have a look for configfs?
> >>
> >> @Rafael J. Wysocki @Viresh Kumar could you please have a look for cpuf=
req?
> >
> > Thanks Tamir.
> >
> > Christian, Danilo, David, Greg, Tejun: It would also be nice to get
> > Acked-by's for your bits. Thanks!
>
> For the whole series and the bits I maintain:
>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
>
> --
>
> Independent from that, won't this potentially leave us with a lot of warn=
ings
> from code that goes through other trees in the upcoming merge window? How=
 do we
> deal with that?

I think the idea was to take this during rc so that all trees have it
by the start of the next merge window. I'm not 100% clear on the
kernel mechanics here, but that's my understanding.

