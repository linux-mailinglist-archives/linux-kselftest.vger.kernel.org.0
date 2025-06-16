Return-Path: <linux-kselftest+bounces-35087-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C664ADB5A5
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 17:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CC03188CED2
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 15:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273B7220F54;
	Mon, 16 Jun 2025 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GY6g8jwg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3169482FF;
	Mon, 16 Jun 2025 15:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750088340; cv=none; b=dfmEYV+cIlTML12wRgSO9OiO6dv3bhHVGZ3E5mGFRe7iWeF2n2i3DjOZEgi3EAyCG2DAFbA+zXfob4Vfl03IRKKYjvT2iigyqtkMmYUPeCDIFdluoEXpoQtPlJ5kAaP3Xfg3UVlKj47YhK01QB7dyS0qcLvjP8Ho8lprIE3tYHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750088340; c=relaxed/simple;
	bh=F8BcwaM+WtE8oZEsemH+lZITn+Dw3YFdoAc5CYBdnNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TH0jP/djQ8ETNdghJpxdMTpPItkwxrQBxVX2C6nypnIOsjFnkxInn8XAmOkVGfzUUkcD58++BH2eTNB80PFHnSShWFNUax6rbTwpq+ZUb3/ewC/P8vdilQh5iIPBKUD9qNfNSVtF6tPx1Ba/kxv7iiszF7NFCy0lBZTGnmYybnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GY6g8jwg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75272C4CEED;
	Mon, 16 Jun 2025 15:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750088339;
	bh=F8BcwaM+WtE8oZEsemH+lZITn+Dw3YFdoAc5CYBdnNE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GY6g8jwgBkalDRzhuY6Q7GoyO/bK8noe5AsFFZJQ7QZTjKrP3+zAxpbGtx+e+A93c
	 fL8cH0GciSbiWBveHx8K0E23kBGiRZcUQyFIImWyNTgKZ8okKyIEtIVvX8H5UPP1mF
	 7f24hRRGWkgmGqAhBdPXEp4l1zpssO9s1XHbrxk1Vqk7zRxMZ4S3/qdw6uUHryhysD
	 g3da3XEQ9egt6qr/Ept1i6nYSPu4t49uN90tTirtRnju6S1a8aIgUM9xHsuETT5H+F
	 iWvcxexMypYWygOAqXEYNoeNmlLLjXgQHrLDQoEILQIUNMR/z8rW9tQDh3lrfyVdH+
	 OJY9hp5tW9OqQ==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5533a86a134so4091329e87.3;
        Mon, 16 Jun 2025 08:38:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUNniLXmBTvhe8h4niXogvzA8QWp09CR7U5SgWwt144FxFqcvczcSzS7dPDHmEh4FK/hfbfmAiAWUNW@vger.kernel.org, AJvYcCX2GzlY1WZH1m0iWVvkS7vuxave5eAU5HJpWTwM6K+MPj/Y3E1uvamS6QPg2J0eIez69vTcwr8xzk0oAT0jg6Q5@vger.kernel.org, AJvYcCX7HPP6BlfrupB1ZBNfWh6YREEIJbatmFotSB6H0JL9Ld5OplSSyBdNSxHuoEm2ol/AAn1CLVc4LmU=@vger.kernel.org, AJvYcCXQ6QxeXsgvYbW3OCDwY6NboUHu8W8KPMsBDYuyb2ukmGItFKUT+v468STrt42Ia3/k92a1WGc2eWHr1eVQ@vger.kernel.org, AJvYcCXYXDDcX1/zd9CFi1KxxTozqOGtUHChBnpWPMxMhNngG/RIEvPES5Z1pKdWmsvMvxRNl4wIgFPAdxSSa+Rh@vger.kernel.org
X-Gm-Message-State: AOJu0YyE2XLvY1Rs47JT8prTFZbmfaMnVyGfGR5tvSpeKZsS5OdIiTdH
	oJL/1uWbcwYmPv0idegPcoQiat1hbRXgbPqYpENs8kTZE7ZFA1IYCId1f3ZCBvfkIo3rogBZNJA
	XJ1/HW3qClSr8OGKFhxkNvB5/Q5C4H5k=
X-Google-Smtp-Source: AGHT+IEi914yNdf7ItDxIuKSAhzqs66BT0pQ2P1yp+Fi9zjJkYGAgGwLeuM43Lf6chAvKr1xpfz1JcNzMuKSRXlMjL4=
X-Received: by 2002:a05:6512:b9e:b0:553:28f1:66ec with SMTP id
 2adb3069b0e04-553b6f2a05fmr2377754e87.31.1750088338110; Mon, 16 Jun 2025
 08:38:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611-kunit-kselftests-v3-0-55e3d148cbc6@linutronix.de> <20250611-kunit-kselftests-v3-7-55e3d148cbc6@linutronix.de>
In-Reply-To: <20250611-kunit-kselftests-v3-7-55e3d148cbc6@linutronix.de>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 17 Jun 2025 00:38:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNARYXKq9KyCczcY_VjwQG3QWEufV1McayHDnavvuU+JEhQ@mail.gmail.com>
X-Gm-Features: AX0GCFuUsGD9ADF5sHGYl1AePploex53t0fNoReQCDpmZEypT0Ao3cb2BMm8rbs
Message-ID: <CAK7LNARYXKq9KyCczcY_VjwQG3QWEufV1McayHDnavvuU+JEhQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/16] kbuild: introduce blob framework
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Nathan Chancellor <nathan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Willy Tarreau <w@1wt.eu>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 4:38=E2=80=AFPM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> Various subsystems embed non-code build artifacts into the kernel,
> for example the initramfs, /proc/config.gz, vDSO image, etc.
> Currently each user has their own implementation for that.
>
> Add a common "blob" framework to provide this functionality.
> It provides standard kbuild and C APIs to embed and later access non-code
> build artifacts into the kernel image or modules.
>
> Reviewed-by: Nicolas Schier <n.schier@avm.de>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Kbuild provides only a small set of syntaxes, yet it's flexible enough
to allow each Makefile to implement what it needs.
I aim to keep Kbuild scripts as simple as possible and avoid over-engineeri=
ng.

Instead, you can implement this in lib/kunit/Makefile.kunit-uapi or somewhe=
re.
That way, I do not have to be worried about what you do.

Also, your separate blob approach looks questionable to me.
In your approach, the blob (kunit-example-uapi.blob.o)
and the entry point (kunit-example-test.o) can be separate modules.
The entry point would be a small amount of boilerplate.
I would keep the user-program blob and its entry point in the same C file.
(and I may consider writing a macro for populating a blob + knit entry)



> ---
> Due to its closeness to kbuild this is currently added to its MAINTAINER =
entry.
> But I can also maintain it on its own.

Or, maybe do not add this.






--=20
Best Regards
Masahiro Yamada

