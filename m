Return-Path: <linux-kselftest+bounces-49195-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E69D38424
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 19:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7261B303C212
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 18:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F5F3A0B0D;
	Fri, 16 Jan 2026 18:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cts9ijlZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142BF283FEA
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768587605; cv=none; b=YjO80F3XNf5Rb6Mcve7iPabcgFhhu2SUmn0DqSEl3JN/yoXUe1CSHAiiMsNmNp9KwlRPLj29QcLDO7IP2XlXzcePSvpOQVb6bhWyklfL2dzSSzwee65WpTW6J0LJCByrtx/bsgSm+x/hvLfjiZbggaCXnE8v4C/k8TzNpgFwQck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768587605; c=relaxed/simple;
	bh=A78PClFzhM6Qp6sOakTzG6TH9zXvYBnzmblGVUYvJJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBK/MIyGRLUOJSt4yODrtkWtGSQfGZ6pE+P73VGxhoXGO0AhsSjKYgnMgRuIwupb14Ed0BlU3w1Gj3oenbAy8l85v6kEUPLbJqvrtr3wFaF/lISqMfAD6UHKptOr0/wQAqFuchf+G+FBusWRfUtlLd2u5Duncwf0p6+01kKgvqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cts9ijlZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF527C2BC86
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 18:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768587604;
	bh=A78PClFzhM6Qp6sOakTzG6TH9zXvYBnzmblGVUYvJJw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cts9ijlZ1yT25U3a26EgSOKXC/jRd2SIQnKYPUzZxjaHzxkDI+suiYYe/SSFEimb4
	 rGMgu0bDryQAPTPW297GXmM3xEkSGbMsJfzpmJV/29aGbwfdlZBrdP+2f/kYu/Igbx
	 l5dvkifS95VfJZZ50FiDXCm8sCsUzriQ+TaBITCckO5nqdLZMZ5zIw1cLpx2rdeogq
	 YM1J0/hai46xPfjG4G6VY/kd+7eVeXGJjJpZU0dg2FunB+8Kfz51BhSUadiHvjOzLY
	 TC7TNKHBVLlqyFhuVjTIX7ltDJDPuE22hWcK7g3vrAmg0gSs7qGPPbE3af3J+HUd5N
	 HdSZ8J9i3LBOQ==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-598f8136a24so2775034e87.3
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 10:20:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUrf7FUKtzdSS9EphR5DULgUCoGDSalWZY34Ph3F9gE1UhqMpK7GsaxZYw8NzljSNU3S9aWxAkXEqdS8yfXuMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpM3x6C+K9hSRREW6lvJQdBe2ZdSm3mf6ltpdM803arsALHmXQ
	G3BhcOSiPkkM0wQmPl/ZCxKwyJzGSYHI+7a7R4H1Zb8HYJW6m57IM/1XLwOw7JQbw3kKjwTjlrN
	t4R5pgqHJLI6mQpTMnVNgkgl45wDFM7F+hk9X3+6OPg==
X-Received: by 2002:a05:6512:2513:b0:59b:b59e:5866 with SMTP id
 2adb3069b0e04-59bb59e5893mr265640e87.26.1768587603300; Fri, 16 Jan 2026
 10:20:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116080235.350305-1-tzungbi@kernel.org> <20260116080235.350305-2-tzungbi@kernel.org>
 <DFQ45FWO4XHC.2BW7I9LGC76WT@kernel.org> <CAMRc=Medaqr5UPimc8o+VTy=9MgU5p8AXjArisQfBNqi7ktSGg@mail.gmail.com>
 <20260116160424.GA14499@pendragon.ideasonboard.com> <DFQ5W41X6Z7S.3V6FRPXYMDJ1F@kernel.org>
In-Reply-To: <DFQ5W41X6Z7S.3V6FRPXYMDJ1F@kernel.org>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 16 Jan 2026 19:19:50 +0100
X-Gmail-Original-Message-ID: <CAMRc=MfAZxzd2hjqgDsXBR+UxgkaEQX0vR5nNZ=a+5WccUb4GQ@mail.gmail.com>
X-Gm-Features: AZwV_QgZEwOQtGowmMJc-nCVnzez2lJWfnDDD9DSEfibkhEFIx5CfrKb_p3e-O8
Message-ID: <CAMRc=MfAZxzd2hjqgDsXBR+UxgkaEQX0vR5nNZ=a+5WccUb4GQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] revocable: Revocable resource management
To: Danilo Krummrich <dakr@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Linus Walleij <linusw@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chrome-platform@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
	Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 5:41=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Fri Jan 16, 2026 at 5:04 PM CET, Laurent Pinchart wrote:
> > Based on the discussions we had at LPC, the revocable resource manageme=
nt API
> > is not the right solution to handle races between device removal and us=
erspace
> > access.
>
> Please see: https://lore.kernel.org/all/DFQ5D44A0348.PZJIGPL972N@kernel.o=
rg/
>
> > It is however a possibly useful tool for races between producers and co=
nsumers
> > *inside the kernel*.
>
> Do you have an example for such a case?

Isn't the GPIO use-case - which the series on top of it addresses - one?

With fw_devlink=3Doff it's quite easy to trigger all kinds of crashes
with in-kernel users. I suggested using revocable in GPIO myself but I
won't accept it as long as it impacts performance over "naked" SRCU.

Bart

