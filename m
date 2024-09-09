Return-Path: <linux-kselftest+bounces-17516-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EEA97145F
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 11:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D21491F23839
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 09:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792B11B3B1A;
	Mon,  9 Sep 2024 09:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CDmhO7aB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6778C1B373B;
	Mon,  9 Sep 2024 09:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725875408; cv=none; b=B1Xj+Uxeb/tvEkF0dfUS3hvESCIkPJDWOzGa7Q7xmmhFS3mYYanxl2zQiu1pVjizOy5uGsMNdmxxpQzVO6TWy7xY0ZL8byIosu1y1BJU1McYmJ2CZ5LEMHAU3/A8AhVNpc9eyuOzgdXXdq705Y4e5rL4UCXPfZ9kzHoTYBIiraE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725875408; c=relaxed/simple;
	bh=YNEEoZK0F87nnuxlA8ZOVCpm884g6LkdLyjxpguwzQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z2ZJCYOmD6OfofwX5ZKOUw0rop0BtCpwmVR6KeoT3VsilpCCMUGU/rpPE3hulFEj8hJ9lSEW/WfJmdcbNErtXCc3UVPtsVrsdKD++aRdQPJsj7GbKOgfAo1OdqPVreprDYYzxINUCrhn12tQ9fjup73k/tV6Kx9J7LE8pIxTTTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CDmhO7aB; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BC657E0009;
	Mon,  9 Sep 2024 09:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725875403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+n6jIuUoupEYC9it7jynGsfYtTffkj9K1qGvau67Xdk=;
	b=CDmhO7aBGHlWdZiCpFPQW01csa4AVN722IUzlJyMVnxEH6+cWYz86FQ8OxAiz2420sGBW8
	n4mM+Xeiq3XWkr26A66LjKTVKEUcOwxxzuN8fGsnQz+MqezxXXmz8FbHupp2jM5wyNTII+
	3/91pxDCRwhqKtCdAH7UM0lrmRZqVlt6K8TzvIooik6D1oYcZ1zX5et1JOwT+nQJm6Sr0O
	ftBYMd31fOBewjDuxkkM8qGAf9Y06pe0J0ErzX7ejhx+ytUd7NOMW8PgcUl1M1pLMJnA/s
	PTf2WOuAATZlWj1jXZgZy4p/5p8WR6R3Z9x84E9Svbgp4FU5N3qoihxdVLR7wQ==
Date: Mon, 9 Sep 2024 11:50:01 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-crypto@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-fscrypt@vger.kernel.org, linux-scsi@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, Richard
 Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH RESEND v2 06/19] mtd: tests: Include <linux/prandom.h>
 instead of <linux/random.h>
Message-ID: <20240909115001.2b05a5ce@xps-13>
In-Reply-To: <20240909075641.258968-7-ubizjak@gmail.com>
References: <20240909075641.258968-1-ubizjak@gmail.com>
	<20240909075641.258968-7-ubizjak@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Uros,

ubizjak@gmail.com wrote on Mon,  9 Sep 2024 09:53:49 +0200:

> Substitute the inclusion of <linux/random.h> header with
> <linux/prandom.h> to allow the removal of legacy inclusion
> of <linux/prandom.h> from <linux/random.h>.

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

>=20
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>

Miqu=C3=A8l

