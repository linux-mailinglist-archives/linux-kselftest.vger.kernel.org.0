Return-Path: <linux-kselftest+bounces-13725-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7394D9313B4
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 14:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A0381F22EB9
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 12:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C467A18A95B;
	Mon, 15 Jul 2024 12:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VD3ldg5z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCBF2B9A3;
	Mon, 15 Jul 2024 12:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721045482; cv=none; b=SsDw62SUrP4PNQr1prn4pTOZubArMmdVBydH2txdvAEmOy1Pia2H69xdmMVHH0TrCxBJqPEJhlrtWPkqJhMqrt/NYfbrWTqN17Qw5E95fMAq6s6crtW65wLCIEfI1qmrM7zwvYC1oPgA57AvgLcs3Xym/T1fkf4wDxAiOwWzPZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721045482; c=relaxed/simple;
	bh=O+BTPTA2oAy1gEZ2DaoSdBiN0ot7oChtHLe94OpTykU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0b6v6bXuJsWFBcHyTEN/22U8pJCx67YqoduZQ1woYoedS33HgoZW/FaO5cdRQXWoNzbx45GPLGZro3ZuCBeexYhBls68U6qnf+AQ7mqloIUo+BcWjhRSyuMJLAMm+DnPEnIsw8G0x3bPQwQGjnTOR79hssVaEalqyJfdIDVPD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VD3ldg5z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91515C32782;
	Mon, 15 Jul 2024 12:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721045482;
	bh=O+BTPTA2oAy1gEZ2DaoSdBiN0ot7oChtHLe94OpTykU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VD3ldg5zv7dJ//KG+8TpbTMjO94tewAMEq48PEsxp7aCQX6cJA8rvQfRYDCtKw4Tb
	 XuQPigELKqJQBmTuPX1DJxHgJaKLIQZqjs3vHbccECtDl6LHW/qC1N/QSVc7Zmx1eP
	 Y6XqdJK7OLfkibnOfdMY/aUZlFenaQYFCXu281w4=
Date: Mon, 15 Jul 2024 14:11:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Pravin B Shelar <pshelar@ovn.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	zhujun2 <zhujun2@cmss.chinamobile.com>,
	Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-actions@lists.infradead.org, mptcp@lists.linux.dev,
	dev@openvswitch.org, linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
	stable@vger.kernel.org, Ignat Korchagin <ignat@cloudflare.com>
Subject: Re: [PATCH] selftests/net: fix gro.c compilation failure due to
 non-existent opt_ipproto_off
Message-ID: <2024071508-refrain-enjoyable-a505@gregkh>
References: <20240712235150.99175-1-jhubbard@nvidia.com>
 <682e293b-cc0d-4261-90a8-bc6f16df0992@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <682e293b-cc0d-4261-90a8-bc6f16df0992@nvidia.com>

On Fri, Jul 12, 2024 at 05:01:38PM -0700, John Hubbard wrote:
> On 7/12/24 4:51 PM, John Hubbard wrote:
> > Linux 6.6 does not have an opt_ipproto_off variable in gro.c at all (it
> > was added in later kernel versions), so attempting to initialize one
> > breaks the build.
> 
> This is the first time I've tried to fix something in linux-stable, and
> I'm not sure that I've made it completely clear. This is only for
> linux-6.6.y in linux-stable.

This worked just fine, now queued up, thanks.

greg k-h

