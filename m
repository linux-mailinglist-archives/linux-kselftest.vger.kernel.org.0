Return-Path: <linux-kselftest+bounces-35720-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A5CAE72EE
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 01:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10EFB7AF981
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 23:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D5F26056C;
	Tue, 24 Jun 2025 23:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dpx2yDtQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BB721771B;
	Tue, 24 Jun 2025 23:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750806898; cv=none; b=i6mjFbqTA12OsDO+TPtV6pORlvG9fX2GuXq7igNvzuaBRnnXduBkJjHYtiCBTqu9WtbxzN8ZWrs3HSoyMTnxGxX/ZM8In0fCzALEe80zQyKkbwhQqqyXL8OB+HIfQkoBv198bcq1XDCtPumKgaQYciboElotySyHUp34M7eIZTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750806898; c=relaxed/simple;
	bh=tpA+8+gYwATgyNOXC3jMo4G2JYGwzWB3fYC5UYtpeVo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OaVEpQppHYUXV/UHrRly/oo7iy9/yddFUJ17llbi6Ja6pxFV2hwOFjvQdLqdffqmLz2yKRGi6yXGrAPMsPjioaghHqCwMopEVSyTDx54GlOJC72o9drSK1NeT87AWCxOJ+w6NuuBq/7AP4RaACDySzBp5LApq0k3sOoGma30HWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dpx2yDtQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F46FC4CEE3;
	Tue, 24 Jun 2025 23:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750806898;
	bh=tpA+8+gYwATgyNOXC3jMo4G2JYGwzWB3fYC5UYtpeVo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dpx2yDtQd/vJlfWF1B4S/88rEQNCiCn6u2/4pZxv8DYZkoJVedg63uwhUDMalXuVf
	 WkGbo4tkO3gmRKfVSESZADWEA4pm+x1UPSWqetkwJk0nhp2nJICFZ3cl9S2+jIY5XL
	 rMpc9aCdIPfr99IuiWZwBg+YzwV7TKxaWFA2z5L/fJjpfanbiAmIwHymN+8zFB+Wjk
	 AGnVwJ+sMH7p+UBcqR5J62u8n8XsCLS3HTsj818qc2x1n7HEaPqvJEBmaB4/9jNLEh
	 g01b048nhxNBjfM2iAi2rz7onZsBLcf3/EJ+hZ3m0nx3w8ENOpgmASD3Hk/Z/jVxDb
	 ZlpcBWJkCBT/A==
Date: Tue, 24 Jun 2025 16:14:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: davem@davemloft.net, donald.hunter@gmail.com, netdev@vger.kernel.org,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org, andrew@lunn.ch, shuah@kernel.org, sdf@fomichev.me,
 gal@nvidia.com, noren@nvidia.com, ahmed.zaki@intel.com,
 wojciech.drewek@intel.com, petrm@nvidia.com, danieller@nvidia.com,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 03/10] netlink: specs: ethtool: replace underscores
 with dashes in names
Message-ID: <20250624161455.49077638@kernel.org>
In-Reply-To: <20250625010715.4cbcae07@kmaincent-XPS-13-7390>
References: <20250624211002.3475021-1-kuba@kernel.org>
	<20250624211002.3475021-4-kuba@kernel.org>
	<20250625010715.4cbcae07@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Jun 2025 01:07:15 +0200 Kory Maincent wrote:
> > Fixes: 13e59344fb9d ("net: ethtool: add support for symmetric-xor RSS hash")
> > Fixes: 46fb3ba95b93 ("ethtool: Add an interface for flashing transceiver
> > modules' firmware")   
> 
> Why do you use fixes tag? You are not fixing something broken but standardizing
> the python naming.

To direct them within stable releases. I think it's worth pushing
this change into 6.12 LTS in case someone packages YNL out of there.
One could argue this is a breaking change for Python users.

