Return-Path: <linux-kselftest+bounces-36771-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1F9AFD8F7
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 22:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8192C563685
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 20:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621CC2417E0;
	Tue,  8 Jul 2025 20:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNopeUXm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295F923C519;
	Tue,  8 Jul 2025 20:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752008156; cv=none; b=KHxVAP/SSPW44zU1uUh94hNSBv3Q0QuxnbwhCqApI60WpH2erFUtQ7ChNTt66Jk/fSyDM8Y8Fq6DlDMSrb9m33R3KypMXgAJfpQ3SP13nDF4Ntt6EYRSQoJUcxTZgr/RO2Q05QOBRSsgLD+QcRKnPEd4/OhqYGedZufc2GijmWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752008156; c=relaxed/simple;
	bh=JQ6WPYPsaeo0QDlrcov2ufiT4eXiNgMBM87Kv4nPAqY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QLIwnQZxMhc/7/OsbtDXeQJHTm9zDom9XFFheDNsGHJpaZWpr0TDjvKT34/kFpbaIzghUp1rnV0IfVWYxRvg5bsfoS50KZ7qjZx3Zw99vXX4mOUklk2rlUr1sYHaSc2lHci8kycG+lhkzpowYz1Qz7rCjslhKwygRy81F7hhLF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNopeUXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C4DC4CEED;
	Tue,  8 Jul 2025 20:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752008155;
	bh=JQ6WPYPsaeo0QDlrcov2ufiT4eXiNgMBM87Kv4nPAqY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VNopeUXm3LeHpd0sxC05Qr2gj6Ty2jCwXuhq0fhw0kqRybarEkb0DWhcoTMCMEhBw
	 OARozBp7ZtV06Gu2mmu/2cS7brlQyGTlkq1qXMO9luEn0ZAtlCEP2vCpcIa5rXUuUN
	 BF3w2faTnV8YnibvFeCHDdhvuyHVxSfrHP3cS9dQsjDyDqGxBsyoTXdrEmatqT6nrh
	 vRnoB3D+ZMUMdRhRezE7pq0pVYlr7TQgcpp7kdRQReBgIwFsWYqur1nhVbBKoE4Lu/
	 0MzfVDC7/t5op+DyYcy34ie9yF7q13TUmxyiVtXMSa/0MTeWE9rSPE3RTBoYsdd2h3
	 yf2fvfhF4bPAQ==
Date: Tue, 8 Jul 2025 13:55:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Florian Fainelli
 <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/3] netdevsim: add support for PHY devices
Message-ID: <20250708135553.7fb9eeac@kernel.org>
In-Reply-To: <20250708115531.111326-1-maxime.chevallier@bootlin.com>
References: <20250708115531.111326-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Jul 2025 13:55:27 +0200 Maxime Chevallier wrote:
> Here's a V2 for the netdevsim PHY support, including a bugfix for
> NETDEVSIM=m as well as a round of shellcheck cleanups for
> ethtool-phy.sh.
> 
> The idea of this series is to allow attaching virtual PHY devices to
> netdevsim, so that we can test PHY-related ethtool commands. This can be
> extended in the future for phylib testing as well.

Appears to break the build for BPF CI:

https://github.com/kernel-patches/bpf/actions/runs/16150854854/job/45581507731
-- 
pw-bot: cr

