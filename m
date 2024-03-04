Return-Path: <linux-kselftest+bounces-5863-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F3A87112C
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 00:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 973741C22505
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 23:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5CA7CF33;
	Mon,  4 Mar 2024 23:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNkU4TeL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9067B7D06E;
	Mon,  4 Mar 2024 23:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709595544; cv=none; b=HAAtvaywxjtSBluZsT0FGPyxKjyW3ic50PQ3Vjdh/wYelTIjXkKbu4rP4+in51j63K2YRiGgE/LNi1mZk9Pt1z2Lc+lSXFxCpH7KYyLzYve4nKIc/fdJPz9hGvsgy4tyTtv1zJLljXM+itHc8ZDCSn48B/K+goQniON906HlIJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709595544; c=relaxed/simple;
	bh=ilwqlWqCQDWZzjycLw1f8qmydL+kgbSGdmaBJ2z2whw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ta0szmNAVqWql8JMhKPpe8SEyGnaseuvu08BrDOfN9PybGihdO0DqlzqfiFN/tveeTJLync/41TqwihQvGhxjO3AsFG9rUrDMYSCsg87nLdpP8unltGfqZAsdgSz2wc3mtiu5ybvltzMGxtdL6fUxvIrA/lsOSyXGA1wyQtezus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNkU4TeL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9505C433F1;
	Mon,  4 Mar 2024 23:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709595544;
	bh=ilwqlWqCQDWZzjycLw1f8qmydL+kgbSGdmaBJ2z2whw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YNkU4TeLvFE/zlGE9KlnZd/DFXPQD3s5dEiePHEK+szo5zzhTlxbxi7NGGsDvCjGM
	 2ARjaJOgLP/QeUDAZ5R7v+FASS6PLD5AqhGUqpoRltqMdd3q62sn88exyEc9qB01eW
	 gSQxkfg9/thZjnnsJLd4igYlPBPzaXVxUSbGYGHmrbIhUctd2PLcVh5w/IOy52kV6g
	 CGkAezNo6vpPnAsfVH3E4P3CP9Ob8QZLcwZa8qU7ppNiw24SgtWX+fpJw7w/ASEcJ3
	 qnF4MCCxCHyw1n04L/aQHYtLnV+mWJYBWyo9qeQVdu2uPVAFLcnAPtnNwVzS8jOcs8
	 KVH6Fe8SUW0lg==
Date: Mon, 4 Mar 2024 15:39:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, mic@digikod.net,
 linux-security-module@vger.kernel.org, jakub@cloudflare.com
Subject: Re: [PATCH v4 00/12] selftests: kselftest_harness: support using
 xfail
Message-ID: <20240304153902.30cd2edd@kernel.org>
In-Reply-To: <202403041512.402C08D@keescook>
References: <20240229005920.2407409-1-kuba@kernel.org>
	<05f7bf89-04a5-4b65-bf59-c19456aeb1f0@sirena.org.uk>
	<20240304150411.6a9bd50b@kernel.org>
	<202403041512.402C08D@keescook>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 4 Mar 2024 15:14:04 -0800 Kees Cook wrote:
> > Ugh, I'm guessing vfork() "eats" the signal, IOW grandchild signals,
> > child exits? vfork() and signals.. I'd rather leave to Kees || Mickael.=
 =20
>=20
> Oh no, that does seem bad. Since Micka=C3=ABl is also seeing weird issues,
> can we drop the vfork changes for now?

Seems doable, but won't be a simple revert. "drop" means we'd need=20
to bring ->step back. More or less go back to v3.
No preference here, Mickael?

