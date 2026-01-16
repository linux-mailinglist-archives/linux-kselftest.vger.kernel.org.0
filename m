Return-Path: <linux-kselftest+bounces-49161-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AE3D3329C
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 16:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75DBB30D3312
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 15:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3819C339868;
	Fri, 16 Jan 2026 15:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bcq+5Yqs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097DF338902;
	Fri, 16 Jan 2026 15:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768576802; cv=none; b=X3wV33kvCLJQjTD+0huP3weQU4jykciOJvX9K9pczxOWBtJMnRbm3sAP0lbjRxpNVWDP4rBkGYzhbyuRgbqhVdd8x/7o1X/C3mZvT/EoMpT9c49rZMNSh2LLVZEuE3/Q2qL+2v3FlsUzxSTT5jn9TI0VPSE9ZiYcEOlwNgOQFwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768576802; c=relaxed/simple;
	bh=Xrev5MrzwMuNK8ZyHK9QGpG4TDphc4gM6pw7fwVg1aA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=SZVgZzNvqdO9Y8UNkCbDYKtOpiFNa2VVEcg5cdi7m2jtFgVgGho4INbYlluijmVxpvc1uaG7D6y/RUsdzFLZfsOEVcd+PSC6WHGFJEmxnBKuLlkvey/82iS4x7sFq8Xe7R/NT055nppHn0eXKptlc++Vj87yxBwuZSpKTls3zV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bcq+5Yqs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EBBEC19421;
	Fri, 16 Jan 2026 15:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768576801;
	bh=Xrev5MrzwMuNK8ZyHK9QGpG4TDphc4gM6pw7fwVg1aA=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=Bcq+5Yqsepx5SVHchj0haO760xwU4jyXLFqIyPbSfeOiDz7SzD+lHAOnSGpA5NdcD
	 9tn3lZPKqSjNaamxYclnDxbDrFF9P1e1fheu7RZifJGAnXOu1D+Efb4qUFRfqVuLVf
	 dZpbwF2srN1Hs3m0TnV32rIpWeikkHH0/UPnMviQJUfkXVoXG1KPbkXPeSI0b/UZFZ
	 f+xXQpfne6xUIZApyP+KXB3Kx6GV5/JvHPlt/UIbdAaAZdBIPXxvsm8+K25aEarno8
	 IFhhIPTlxPgCYdzsu86ZRGLGjwcVvp5fikUqCSG0NJiw27HAPlqJKpvlhRSeJ9Em91
	 OJZVWIrrq7uIw==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Jan 2026 16:19:56 +0100
Message-Id: <DFQ45FWO4XHC.2BW7I9LGC76WT@kernel.org>
Cc: "Benson Leung" <bleung@chromium.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 "Bartosz Golaszewski" <brgl@bgdev.pl>, "Linus Walleij" <linusw@kernel.org>,
 "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan" <shuah@kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <chrome-platform@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
 "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>, "Wolfram Sang"
 <wsa+renesas@sang-engineering.com>, "Simona Vetter"
 <simona.vetter@ffwll.ch>, "Dan Williams" <dan.j.williams@intel.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, <linux-gpio@vger.kernel.org>
To: "Tzung-Bi Shih" <tzungbi@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v7 1/3] revocable: Revocable resource management
References: <20260116080235.350305-1-tzungbi@kernel.org>
 <20260116080235.350305-2-tzungbi@kernel.org>
In-Reply-To: <20260116080235.350305-2-tzungbi@kernel.org>

On Fri Jan 16, 2026 at 9:02 AM CET, Tzung-Bi Shih wrote:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a671e3d4e8be..fd683c62012a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22517,6 +22517,13 @@ F:	include/uapi/linux/rseq.h
>  F:	kernel/rseq.c
>  F:	tools/testing/selftests/rseq/
> =20
> +REVOCABLE RESOURCE MANAGEMENT
> +M:	Tzung-Bi Shih <tzungbi@kernel.org>
> +L:	linux-kernel@vger.kernel.org
> +S:	Maintained
> +F:	drivers/base/revocable.c
> +F:	include/linux/revocable.h

NIT: I think we should add this include to the DRIVER CORE entry as well.

