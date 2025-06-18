Return-Path: <linux-kselftest+bounces-35302-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C56ADF2DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 18:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A443189C919
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 16:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA332EE96F;
	Wed, 18 Jun 2025 16:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGCZuuqi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB411D5AB7;
	Wed, 18 Jun 2025 16:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750265172; cv=none; b=DOUyzvRD1vFAybnZ04lcEAwlkzIBkK36SgenJC3Eh2pta0/Hm5kL3+m7Rx9QoQQHTnlMIIkomYMsWBFYJis43bMRktleOaDkb/wlcS6b2ljDOjhfcLCrXxrUktf44T2P/FMNzUeYoXwM0XNQn3s8PCeCBOxL0Ku+oeYKPkx/qTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750265172; c=relaxed/simple;
	bh=TWzALV9LPqlus+Az62QmQW8i9ILqyK/dHFh5EdSLL0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bb/xzrlYRQ4DUEt41mvacgWKDnYCoZWR+P6E1PmEbdm+uF738QOJaefylC+t2xiEo4OUMQx+ORTafhfcikt77QNTd8ttOHbO1Pt8lLPlEsgrCZIZI82fOdF8DUthHe5RGRisznrftFznoBdfUSfflsoVe09XYYCZ3+rwC7d05OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGCZuuqi; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-313dc7be67aso951739a91.0;
        Wed, 18 Jun 2025 09:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750265170; x=1750869970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWzALV9LPqlus+Az62QmQW8i9ILqyK/dHFh5EdSLL0k=;
        b=aGCZuuqipaBcL3m1lLCsYwzFJD+5VHQvR2GZ7WB/eGF1g9StLSoP8elXIXbm+z9uJ3
         kTmlzZY6pTZH4iUczsD5VNbHhx1UvY+h4Chgo6KdimwupPPAOUO8OaZE0Kv5qcd5mHj3
         rRFHR8Dsg/yAtKs3J1BNATgQmli9oUp8dssE63fx3J96JKViACTFj7g253RZTnUqR4yX
         s8ar4y8VwQ3IUJV9bRiUQRgZeaDmdx4tJql2zwvWNPIhj/xVfGCceRaYYxw1dziMpzPf
         tp/DYKB+xo+UH+JnifYUoWZARd2bRgi2guTFOUEt8Ldw9PmpySyF6KeCUuih/iXa4sx/
         y6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750265170; x=1750869970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWzALV9LPqlus+Az62QmQW8i9ILqyK/dHFh5EdSLL0k=;
        b=jrZswja+t/bCK8WUS4aTh6/eOOQm90CJds9j/HJsVgJsBdy0DDlED5LinTC1AYiq+K
         +wdEV4R2Q9SlSMt6Y+tlP6Ghos3/LLz+BCwfFKb17e5MXxS5JscwyI8DLqmOcu5v5DkF
         HS994zY+OnEK+G3suuILEDWRSHqX/KY4SFJeIMmFrhwIacNegtPrl5nfeDye+EiGwcAp
         YRGqJAZFjb67fxuCQJ9G385zc8yXJrSgZXxQs2440pkkX5RV8nxU+nPbdBqAkMtCZu70
         uauqeeXA8Isc+PQk+jIKgS2nfBNm7vJrr+mTibgaheESnOz5BY5zJyGe5ObNUZjjSYlt
         P75Q==
X-Forwarded-Encrypted: i=1; AJvYcCU9Bmd6euUAqB+vISlGDriKVjpl08iq+SIoAz0iF6lWd17Qu1RRnUAPRa3bc3n89cQ8NNtxhAQE6Kb8Cxo=@vger.kernel.org, AJvYcCUW+vFFtyCWMNx2h2ZUboiwRCLeEVB5AgaQ3yHaIvlXrgooTRS/uDHwmexajhdRsC/Y7D+swm1d47M=@vger.kernel.org, AJvYcCUv0SMyo+0bc58606Wy+V6lVa1eoxMyp1DQB2E+KVN7vV8XvSKcgMaED1bWsfnXwRYx37ikmKseB36Z@vger.kernel.org, AJvYcCV9vnWtAXQUuEcHaqnTINav6myGZWGKc3WvdkXaQIbBet9iO+EYEAYo1G0uF8wWbUiPqXn0e5WlmDc8+wfn@vger.kernel.org, AJvYcCVPEJmoybRkd5IiwJMWuGBS9234MPYlsaF07d2ExfBM3ctoJg2G5s3yAkZ+pKwId/vEwUJhhtBFmPw7eHVi@vger.kernel.org, AJvYcCVevuNZzRC1k4WLJEZPiROzOIwk2Yg1hGiQcd6KYuE81CjAZjjxjsvpnHV3qRSgs0SAdsjjzHudWln5KNsf4Rg=@vger.kernel.org, AJvYcCVv1XT1vWGqNxruaHtfPbKZGiJl3beFyfGK7f/bYf7A12UFgKUuSSR41joEZGUJvd2y7EnqvsJr@vger.kernel.org, AJvYcCX6prJ6pnc8fxIPUYXaucbOLimk/j76q8InFNZo3HXhGHDmFpiLPcoKzqxEdbvDSn7O3eM9XASPmtzt@vger.kernel.org, AJvYcCXvKpZ8uYoMyZV6rEldKHpLnWsvZwdyS8fRlUrHkpGepf3SujeCs2xcx5fJhRaACMRAxkthtr5DstyN0FcFz1A4@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0QJpKFciLn8qcO2evtXRhmvVIPyLbxVThy6vkVS0kpWiLHo7k
	ValFjAfXj+2j9WpqqK/uBjIN2tPcoGP22et7TUais/DKZhZqjVj9Rye6TzClqVHlMpRF1fnp5nY
	GhB+KZtfjl+Kh1ThuTgUeHd4zjbOmMzc=
X-Gm-Gg: ASbGncsj878HpFmROhLOj07Bj+vU3zavbYtwOOIxw9psaOKO29EKNB/YTBTtwIx0Efq
	Q07KWd8SHjTAaNyZ4EOzksuYgYrV9BAQGGrhh/Tf5M1vFbSfz2NJnfVIqDfIamPkCDnnpsC6RIy
	D/DAvlOd5tpBXzB7kUa++hbh20oEcHoF1djvrS9dH5u6I=
X-Google-Smtp-Source: AGHT+IH4x/Zjj/Cn6AIOjbJXWQhaDWLSiy8g/xgpU0nYUpfFSqLNbZ8aoqW6DTm7BekXvLqQRHOksCgncGYgycyl5qg=
X-Received: by 2002:a17:90b:2dcd:b0:312:e9d:3fff with SMTP id
 98e67ed59e1d1-3158bb43769mr25041a91.1.1750265170069; Wed, 18 Jun 2025
 09:46:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615-ptr-as-ptr-v12-0-f43b024581e8@gmail.com>
 <20250615-ptr-as-ptr-v12-1-f43b024581e8@gmail.com> <CAJ-ks9=6RSaLmNmDBv-TzJfGF8WzEi9Vd-s=1wyqBcF7_f7qQQ@mail.gmail.com>
In-Reply-To: <CAJ-ks9=6RSaLmNmDBv-TzJfGF8WzEi9Vd-s=1wyqBcF7_f7qQQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 18 Jun 2025 18:45:56 +0200
X-Gm-Features: Ac12FXwfspeQ5n1WfjhtITwDVCEc5U5DXhUfzAvB1x6rILKw_9XGVLNl3gdX3Es
Message-ID: <CANiq72kgnKH2SSp76EdPeysExBWasqhTyf1JyReR65g6FMsidA@mail.gmail.com>
Subject: Re: [PATCH v12 1/6] rust: enable `clippy::ptr_as_ptr` lint
To: Tamir Duberstein <tamird@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, David Gow <davidgow@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
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

On Wed, Jun 18, 2025 at 3:54=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> @Andreas Hindborg could you please have a look for configfs?
>
> @Rafael J. Wysocki @Viresh Kumar could you please have a look for cpufreq=
?

Thanks Tamir.

Christian, Danilo, David, Greg, Tejun: It would also be nice to get
Acked-by's for your bits. Thanks!

Cheers,
Miguel

