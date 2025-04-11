Return-Path: <linux-kselftest+bounces-30499-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C739A851D5
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 05:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F24997A88CA
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 03:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318E526FA65;
	Fri, 11 Apr 2025 03:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0/S+iT0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0207F3D561;
	Fri, 11 Apr 2025 03:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744340612; cv=none; b=Dm4vPWqc3D/2a1tM/gL3/hBq4z4uLmDhMxSSy07ycHMOMWVrLC2bScrd+ltRlkbQcHVmeykeavbncQigR5tH89+2xmQ2dHSYl/4FGPxBDUQgGNQBCn2iTKykBylwbqlRVfwZ8ptJgIRMjUByQ1C9dT8UkHVrgoayUEPXKYZDL6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744340612; c=relaxed/simple;
	bh=x7fJxGlrgIpD1kPr8nv0xSitkK9QCXNS11kw5HlwFTE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N1BF8R09EDc+PGmo0mWpU/3Kf9Z+dvqCFZZVHb1zx4ReRfklZsyqAD0KR7h4QJLR/e1AtPautnOfWQ/pT840jYDjCL+L7vdPzPU4IIKchTv5X8RZfLmGXMf2KEje07vND0QFNafzYYTUyQ2omdsvuqeRSNitGZKXrcIvhaow65E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0/S+iT0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16F8C4CEDD;
	Fri, 11 Apr 2025 03:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744340611;
	bh=x7fJxGlrgIpD1kPr8nv0xSitkK9QCXNS11kw5HlwFTE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j0/S+iT0wN1v2pDhDGwYgA6Qj8CkETS/WHUxiM7qz+gd865ssRAgBsCrsNxycxw04
	 U+PU283dSUHkfDrguknWs09POEo86wFlfwcqSUhiP28Qx1KEyFcNgFeCUBa5ozKzan
	 7aDePtOO1g1XfALPStGnJu2HeULHNyILp3r44WklfMSV6io0UPLaWVfomH8AApkan0
	 MfKxbkhMPt1tnkz6ooGhVVVO9osPNLyMFeLtxI6sQz3mBCcyX1jOEBOR8mHpweyNhn
	 8S6EJy1laIP7yIAIWIui6Z3ADneA+GgvPJ3qMSl2Tc4LP5XV9kpGfsMvDIrMh7qiYt
	 d+Nx4QIXkAmjQ==
Date: Thu, 10 Apr 2025 20:03:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, Shuah Khan
 <shuah@kernel.org>, sd@queasysnail.net, ryazanov.s.a@gmail.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Xiao Liang
 <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v25 04/23] ovpn: keep carrier always on for MP
 interfaces
Message-ID: <20250410200325.5621a4f5@kernel.org>
In-Reply-To: <20250407-b4-ovpn-v25-4-a04eae86e016@openvpn.net>
References: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
	<20250407-b4-ovpn-v25-4-a04eae86e016@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 07 Apr 2025 21:46:12 +0200 Antonio Quartulli wrote:
> +	/* carrier for P2P interfaces is switched on and off when
> +	 * the peer is added or deleted.
> +	 *
> +	 * in case of P2MP interfaces we just keep the carrier always on
> +	 */
> +	if (ovpn->mode == OVPN_MODE_MP)
> +		netif_carrier_on(dev);

Any reason why you turn it during open rather than leaving it be before
registration? Now the link is down until first open, then it stays up
even if user closes?

