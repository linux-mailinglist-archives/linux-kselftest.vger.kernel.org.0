Return-Path: <linux-kselftest+bounces-5445-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D36A867CB8
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 17:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 588DF28A02D
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 16:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F8612C800;
	Mon, 26 Feb 2024 16:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwXAmHKN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C4212AAEF;
	Mon, 26 Feb 2024 16:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966387; cv=none; b=FNRemwDUZBcKhmhr42Y3uIdVlfRd0ICfTFDL4SUqKfCALYwIm+MGyCogSUiUH9OA1HhxmQwbzvN5Od+Ui1s3cHBVneHMxqSkCNm26V46pYGohSNoQwCOnnwduwd5mREMOuMO3cIOS7aggef50O/Qykn07+VmsVgBxjaki+DL0xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966387; c=relaxed/simple;
	bh=uvXVPnvYD/yAKKfwAi1xFd+k3dhGavlaDorjhvkq7Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iVrmI9U6ZiVDGdlXT9TsbSPdJ4mbtHfCsGgI4rqCT6JwKAkMWl6qgtxWRMOhG8Al5EI5Wxd0/89y1apyXKiWwpYX5Zqc9DjqX6Yam7E1uH4h+nAB4UP4PUSbdTP7leCL6TNVmW3Y9g5tDArWDQi5TSjApZsTY0Ro2brhldBMiDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwXAmHKN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28803C433C7;
	Mon, 26 Feb 2024 16:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708966386;
	bh=uvXVPnvYD/yAKKfwAi1xFd+k3dhGavlaDorjhvkq7Gs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rwXAmHKNONsVopUVRQfWkmT1rzgKqKMz1/k9Ed8mh/S8vYzB0qVwuqpr5mq+7Mrzf
	 KmTAguLpzq4quLCYIB6riF/275aDXB7kF5Audz99YU+FK1FgoKfvRPW0LKtcSvWea6
	 BT9bPQfmUjxzPU9a8LGBXHuvmyauccNruCnTs1Z581GfjHbe8B2/ZndtOW9OXoxf4v
	 RUeDPndZbk33EI0w3KdqXplVCU0GiP8+HMLnofcIcGlCSmSjshX73WNlyZvPuj9GvA
	 GkBUXKK+KAmsu/SFyT3hSbTo0lnuggAxWaG8LacP15awnBDbQSnWt8mjL88CFhTaQh
	 aDzZJYYvCMWvQ==
Date: Mon, 26 Feb 2024 08:53:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-security-module@vger.kernel.org, keescook@chromium.org,
 jakub@cloudflare.com
Subject: Re: [PATCH net-next v3 00/11] selftests: kselftest_harness: support
 using xfail
Message-ID: <20240226085305.67ad776a@kernel.org>
In-Reply-To: <20240226.Juthoojee3qu@digikod.net>
References: <20240220192235.2953484-1-kuba@kernel.org>
	<20240223160259.22c61d1e@kernel.org>
	<20240226.Juthoojee3qu@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 26 Feb 2024 17:27:34 +0100 Micka=C3=ABl Sala=C3=BCn wrote:
> > would you be able to take a look at those changes? landlock seems to be
> > the sole user of the "no_print" functionality in the selftest harness.
> > If the patches look good I'll create a branch based on Linus's tree
> > so that anyone interested can pull the changes in.. =20
>=20
> Hi Jakub,
>=20
> I missed your patches before this series.  I just sent two patches to
> clean things up before you change them.  This should simplify your
> patches and improve the overall maintenance.  I'd appreciate if you
> rebase on top of them.

Nice! vfork() is a bit scary so I'll give people a couple of days to
review and then post a combined+rebased series.

