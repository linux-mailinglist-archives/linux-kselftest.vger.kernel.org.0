Return-Path: <linux-kselftest+bounces-34529-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2A8AD2A86
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 01:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5EC13A4D4F
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 23:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE7622B8AA;
	Mon,  9 Jun 2025 23:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snNA452v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FFB22A4CC;
	Mon,  9 Jun 2025 23:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749511693; cv=none; b=HxfN2XUi38tjH4uoSmPu8Pde+JUpfYXxcN0BTy0dNwFZ0at59i+7uaexjcJTR+mNsevegjleWZQryDckuzcqZxoRxN9QRJNyO4omCCGjGC//0eDO7Sc3+HYmDszJb8mDyj3t2CebEIIR0n/w2HimDw0Lb0MgGqAEFxHuomZ4jVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749511693; c=relaxed/simple;
	bh=s81oEcid/OEGvazYHy8C4bU29ApBKyS/u//Zxdr+YSI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bSfMTAvaQO2e8HlLvSIh30HuhR6PLmwwPAYWDdWk6AeKMDNNZBLhFyitvrQ+muGsIO39zaUZLJi99ZJysrsraI/CK95fcBEx6HIdm/vPNG7gLwmNosgmjJlI2teIlJ8mX1XwYuVpg4Bu6F06V2DWRY/Y1JiyA6R3yg87jdXSgBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snNA452v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BB6C4CEEB;
	Mon,  9 Jun 2025 23:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749511693;
	bh=s81oEcid/OEGvazYHy8C4bU29ApBKyS/u//Zxdr+YSI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=snNA452vJDcTsUcu6tEaoLgPVCt5nY/vTJEtQEddO3eHDykMbeJw2wQvLi84lceNF
	 LeyMPxzhW8qOwCBhYaKI9qdpZswIS0yTdwPro/JldTQV/cif9J7s7jqmfnNo5oYXAW
	 GyH36l/5SQl28xlVrVUQXuLfNldnP2JZb5hwMckmHSqC/p9IYgRc7b1qFReOrOs+/8
	 4EP2xZu0gtto4+wRinGw+mgt+c4CzX6XvjmMCsVuKIN9aXrlpc+tB0OM3tmtsqA0Z6
	 8Imiiv4wJ7xsMvgh1bfErer6kopdZAv29VUuiowYmio8vdGm8AfbOSxYLzYhCdQ2YX
	 rhqAXX1auWhFw==
Date: Mon, 9 Jun 2025 16:28:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, skalluru@marvell.com, manishc@marvell.com,
 andrew+netdev@lunn.ch, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, ajit.khaparde@broadcom.com,
 sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 tariqt@nvidia.com, saeedm@nvidia.com, louis.peens@corigine.com,
 shshaikh@marvell.com, GR-Linux-NIC-Dev@marvell.com, ecree.xilinx@gmail.com,
 horms@kernel.org, dsahern@kernel.org, shuah@kernel.org, mheib@redhat.com,
 ruanjinjie@huawei.com, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 oss-drivers@corigine.com, linux-net-drivers@amd.com,
 linux-kselftest@vger.kernel.org, leon@kernel.org
Subject: Re: [PATCH net-next v2 0/4] udp_tunnel: remove rtnl_lock dependency
Message-ID: <20250609162811.020322be@kernel.org>
In-Reply-To: <aEdsBhZ4C--0ohYj@mini-arch>
References: <20250609162541.1230022-1-stfomichev@gmail.com>
	<20250609153817.14d7e762@kernel.org>
	<aEdsBhZ4C--0ohYj@mini-arch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Jun 2025 16:19:34 -0700 Stanislav Fomichev wrote:
> On 06/09, Jakub Kicinski wrote:
> > On Mon,  9 Jun 2025 09:25:37 -0700 Stanislav Fomichev wrote:  
> > > Recently bnxt had to grow back a bunch of rtnl dependencies because
> > > of udp_tunnel's infra. Add separate (global) mutext to protect
> > > udp_tunnel state.  
> > 
> > Appears to break the selftest, unfortunately:
> > https://netdev.bots.linux.dev/contest.html?test=udp-tunnel-nic-sh&branch=net-next-2025-06-09--21-00  
> 
> Argh, should have run it locally first :-(
> Looks like there is a test that sets up pretty high sleep time (1 sec)
> and expects entry to not appear during next 'ethtool --show-tunnels' run.
> 
> Gonna double check and remove the case if my understanding is correct.
> Don't think there is much value in keeping the debugfs knob just for the
> sake of this test? LMK if you disagree; otherwise gonna repost tomorrow.

Hm, I see you partially deleted the sleep support in patch 3.
Maybe it's easier to keep it since we now always sleep?
No strong preference, tho.

