Return-Path: <linux-kselftest+bounces-35316-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 246D3ADF53D
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 19:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC3B16710B
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 17:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DAE2F49E7;
	Wed, 18 Jun 2025 17:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xb2D0QJ8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B61B3085C4;
	Wed, 18 Jun 2025 17:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750269408; cv=none; b=fY+UFGJgDNdmnA4XWBjeEQp/mKIJq40wSqvI/KSlZmFp2qyVQoaZHnCLX28EIFxPsoYn/m1sNwVu6Ez1JRSB8EoW1WIw8fcotxs5ZGiH5VhCAuQdiE8rhbJZ9wGQgKMSs6lnVuW5Bx8ymoIvzOvNP9sC/GprJER94zlVCKRoQc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750269408; c=relaxed/simple;
	bh=RFrhjba+jX00ww6cE0VuGNNBUQaISwhdA2R1o+tAwj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eqVM4/wu2zc8mXUmtJ7/fKK+KS4fZ+df3J+564o56kwgvEZioAPajzsY/564Zem0rEftZUC94dBCDe5iPpIFROPaWyzThmhair8q7IWx9Ht3MHsuX/5tBlFNvZJnPEvTu+QbDxsUeKm3DOofQgJ85NQFZWvsXmgjzcjLsSEwKPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xb2D0QJ8; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-553b5165cf5so6287812e87.0;
        Wed, 18 Jun 2025 10:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750269405; x=1750874205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFrhjba+jX00ww6cE0VuGNNBUQaISwhdA2R1o+tAwj8=;
        b=Xb2D0QJ8GxQMnCx45mpG2T8ERq5a/qqwOec18vYtxcLmHx0k3kFkTmLJDgnPa46exj
         yuTp/tckFGfp2BD8j0TUVsYAu1tnidvbIV8AW2f1RB1YGZsYQ5CN4mI8xkpVKzpITGOF
         X//CnqzKy2loc3X9bNWUR8cs4Ngju3z9N//5E00nqqNBqVVRRrRMk2VsLei1C8HS8rs9
         6IebSp+wVjn7KXkQSUgHmP4J+0UK0p3c8FqtYcB8+xSWdD5tRhPvuBm9ppTkPEpbbcDX
         hecaH85n+gQsiuvyLUKiySfnouuZbkDzaQx971/4MPWyslXbC6UqbnPRJYmhCKv4lbqt
         Bjkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750269405; x=1750874205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFrhjba+jX00ww6cE0VuGNNBUQaISwhdA2R1o+tAwj8=;
        b=PlHzVttt1AlLs4axR+Dz+x/P18qe4UI9Bt/zJGo2YIddJL76Hm/yJxPln6V+F2X6jL
         GmuA+b1WQ0nwXFtAHx+qfB0rSY9YYao4x+pTEy9C5TT6NyXOMDYB27OfGHb0euj2EREk
         a8cC82tkQdZWIGs/lrfcr3SZkcGz798Hd221ZSFhQULpJ0zJM/6zXkvo6GER2AlBov7v
         6cMiq67ohz5seK6vo4W3EJ3WngsnGLiO1VUPYlga266H7sqAnJhuCWp4CS0yV3TO8TrS
         JC3NAtMNypjwg7Z3etaiwMLF0koYDmLZw7+alyHnSkjtQLKCDPUXj7J4Px8l3mLhoMPb
         Kgew==
X-Forwarded-Encrypted: i=1; AJvYcCUmdYTcCwtlqbwtlGExSM+pN4t/iDLK/En8/CNg8jIuz8kYW+M9qj7XlQEA5+fbo0bhxqTfhSXW@vger.kernel.org, AJvYcCUr0cdkjxRNfFxxZPddoRDmraK3dBePz7v8dgYPJnId4ZFVLdF8cDEkjoDsRFGlO6T06RbwUebO3xQj4lXDCelq@vger.kernel.org, AJvYcCVxfpvQNGUsW85170qcZb00QaAHj3If8JU7VtXAMhNNx686RSBmaYb96ymxEz62VLYwVSpV+wDAtSfTNbwh@vger.kernel.org, AJvYcCWcj1RxCJ4KSmZFY94kQ5AyTI1UHdAqV4qKMbjzjMlavY005+wcjT2CjL1e9HpjxJHYH1pUCeact941@vger.kernel.org, AJvYcCWmhvApDhADzWuHPhPVO30NURY7EVDI/tJthe86AlWd/lrkqc2xWiCv202wl7G7CjKxWkbpJBtPA+eJasq8@vger.kernel.org, AJvYcCWpO3/cy0QeGSjDTzJFakc7lGK7clCoyRm46EdEuo2tsE2Ywpz0amx7J++mOiPVrdC8NzlqElrIN/he@vger.kernel.org, AJvYcCX3M1Eio2t0SxwioB3xc01+mfQl1YZLPPEvfWCyAhpx+LxKo8LmJefFq5X8WfQg0lJ4SLU8xeFMmlytOpY=@vger.kernel.org, AJvYcCXRB6DSdQK91kDKfekRPhXnhUOYudgdrhOie455DkjQBBBgNnqBJP0UuJ9Xnargjtt/KRKbMq4OqSM=@vger.kernel.org, AJvYcCXWaKwUGuT3IJF1s43PWtLuyB9EKfOsLfGUM9ku8vrsysbgdPOezqa/6crD4KRSHkV+7gIoxdVUOL7ZmxLFk08=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK67Bg7NxW4RQfeRT7ZR67idwLHCcMYXWUXH3OIhwm4mNlCuy7
	n8fhLFGtD/DaYJXWvn1KUoGI9Ry2sIZNc86bRDTvj6h0+524oHdRofDQFwKDLdo+dYCZGSKHClb
	DXnZcdLOcjaicAJ6nFRmYWw0E74SlnoM=
X-Gm-Gg: ASbGncttUPiG/X93FePL+dNkjOdHhoLo9YYSMkvpL+9srhvaqMY4r4xiwBUNaqYhRfW
	+sdYQ8r+h4lEqQNRp5mTZZupe3AqFX3Mufxrlg8foQzBp8hMij9r9gKFStzbDBBmMnQS48Fljup
	Gac96w1AcWwpr7aLnvI+o3WhABfUDK5TcSOrvpbKY03nXaJqHuRwP4SD2SpnFDE64IMpnBdg==
X-Google-Smtp-Source: AGHT+IFYpQNeIBg62gf2bJKGY02IKzd8mHZl9tpr1i/aaJGRezLkroXz7FNXVmmWP0ibkJJnM2113j3XPbjKe0XRBDs=
X-Received: by 2002:a2e:a7c1:0:b0:32b:53b1:c86a with SMTP id
 38308e7fff4ca-32b53b1ce9fmr41415971fa.24.1750269404558; Wed, 18 Jun 2025
 10:56:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615-ptr-as-ptr-v12-0-f43b024581e8@gmail.com>
 <20250615-ptr-as-ptr-v12-4-f43b024581e8@gmail.com> <de30bc80-3dc9-4fac-afe8-bf6b0df42ea9@kernel.org>
 <CANiq72mOHbxt3xOJw8f=j184TRYs9y3wvcopH-h6P2SLe4jVNQ@mail.gmail.com>
In-Reply-To: <CANiq72mOHbxt3xOJw8f=j184TRYs9y3wvcopH-h6P2SLe4jVNQ@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 18 Jun 2025 13:56:08 -0400
X-Gm-Features: AX0GCFtQa8QSLL1IyAtkspzHqh-LWDey5MUYh6_rGpgLIHwPpEpm3BqmaQGaU5c
Message-ID: <CAJ-ks9nnNjBfzCasOtFZGXBj=UKqZxuyh3-Emj3yFrz=9f8tmg@mail.gmail.com>
Subject: Re: [PATCH v12 4/6] rust: enable `clippy::as_underscore` lint
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
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

On Wed, Jun 18, 2025 at 1:50=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Wed, Jun 18, 2025 at 7:38=E2=80=AFPM Danilo Krummrich <dakr@kernel.org=
> wrote:
> >
> > Shouldn't this be `c_long`?
>
> Yeah, agreed, it is clearer -- I mentioned that for similar ones in a
> previous version.

+1

Miguel, would you mind taking care of this on apply? Quite a big
series to send again.

Cheers.
Tamir

