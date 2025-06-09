Return-Path: <linux-kselftest+bounces-34525-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A02AD2971
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 00:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D973A2D78
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 22:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EB2223DC9;
	Mon,  9 Jun 2025 22:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxifVN7F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E951FECC3;
	Mon,  9 Jun 2025 22:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749508699; cv=none; b=Jva16E6POSNdyIEzazbxinSgejY1iaUkUI3II0hAQdb8VNt2lZZmwK8KJoaM2CaTjefStdMNQ/e090Mlk/gbMze923D+uCG0rLvmcGXjwvTXg6L/O2kjWkRNS+tTssuSdAa6wqWKw8x4JTNDZsokKS1m/RpekCdXFgHk6gObziQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749508699; c=relaxed/simple;
	bh=JBXmNJeT/xZX3RurxwwkpLVdwAYpNQhCQiA1mKMKOUs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kFeY6yxTfGIPhnPYRvbD6kQjxqhmYTRhvUY3Pv8sT9Kbwta4DBrk3f2B5F/nPX6RG+/43XQgZtuXUTq+24YmeEdJpoxNQ9uBxZKi8bnSBW2bVKeRgZVwo378u7HtbdWHPT5nKSj3kKSNkNJ7fmP96SNdtTmDddZuHrVGaLmqT0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxifVN7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19131C4CEEB;
	Mon,  9 Jun 2025 22:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749508699;
	bh=JBXmNJeT/xZX3RurxwwkpLVdwAYpNQhCQiA1mKMKOUs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AxifVN7FeC65QCVf7TUYkIjnE/rIZ52inY/Wee1YAJ7ODWu66fPTScZ/3VoyrdBMm
	 Upw846Twc/EGGPQSKiwLiME9e2F7IaHSVtpwNlvIAhOSgNfk+NTI7xtpHmJzuolqC8
	 HVkTxCvhR5A5wEh3eoMUqg0zNDUx7L3L3NDeuLfFLzCRpGTsgek0eGEUJ9WZewwxF4
	 xlbzpl6iNxR3OcduOF+Wqzotm6AyXM3v1OEg/MPHN6FSvPedw2Y1527H4G0VS+r3W1
	 VUJNtPtDPN1hRI8W+MyuR5AFTmAoQ9ybpBhcd1EBdYrjaxXnrajNr8m6kyaQY9hv44
	 XNHBAk/TtwWwg==
Date: Mon, 9 Jun 2025 15:38:17 -0700
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
Message-ID: <20250609153817.14d7e762@kernel.org>
In-Reply-To: <20250609162541.1230022-1-stfomichev@gmail.com>
References: <20250609162541.1230022-1-stfomichev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Jun 2025 09:25:37 -0700 Stanislav Fomichev wrote:
> Recently bnxt had to grow back a bunch of rtnl dependencies because
> of udp_tunnel's infra. Add separate (global) mutext to protect
> udp_tunnel state.

Appears to break the selftest, unfortunately:
https://netdev.bots.linux.dev/contest.html?test=udp-tunnel-nic-sh&branch=net-next-2025-06-09--21-00
-- 
pw-bot: cr

