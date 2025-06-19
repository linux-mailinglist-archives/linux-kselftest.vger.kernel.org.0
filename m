Return-Path: <linux-kselftest+bounces-35357-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CABEFAE02F4
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 12:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5061BC2EB1
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 10:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B262264C2;
	Thu, 19 Jun 2025 10:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCEgafZ2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472C822540A;
	Thu, 19 Jun 2025 10:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750330295; cv=none; b=gCwBcWCHCx1tYiZgRVWQI4Fy0wFDeD6da1pyHbxw3RDspr+ifPyKE0NegwCJJP3HlMYmE+qk3PgDoHUyRDmrgvfSeSt2RvEgOrdxJW4kWJx73IYWt8K3E4m9Z6Y7XU8f67yj4P0TmtAYPNGMpCAlN8lLdo9cSXTDm07ErKr0slI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750330295; c=relaxed/simple;
	bh=vIGV6Kvd52Ef9qot7jemyWD9wNYSa3u4hJJzJ38DIFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5GbxHZtLxh8eH3Nolfaz68Y5XkY/+0XEQ/tPSoqtREVE0694L4Fb8S9SgfLaw4RgbY2fmkdZBufomI0Ycbexh2jpzE+End0gAg1xRSeuTzdQ+4bJMUjGUWsZzVIaE8Uq3puCDgoUskknFq/tGrS/10DZIUunvcjvEuQaOOEV38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCEgafZ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A68C4CEEA;
	Thu, 19 Jun 2025 10:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750330294;
	bh=vIGV6Kvd52Ef9qot7jemyWD9wNYSa3u4hJJzJ38DIFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DCEgafZ263HD+9OBcwSOFDIMi0lxXlsITEvuvNzfYLaCUD19DcFrR5t0RPlXQAaPV
	 m0JwRRUgXfHXWHAikAJxO04xtFoVyTUfcSy/Or88eDLS0+7BYpENUw2rrwb8huQp0V
	 o/9jO6NNSSa/4cGEmjipN6jj+EtML0LAez59YE0+hk/8lEmaUsI83voXj4A+JOzA8Z
	 NrZuV496rQuNfu1lFBZJX3zJRpnQamXTFi3Bd6iXfHO2AsjuxI4ZqFHprll2yVMRDA
	 NAYN36SWmEkcBbPCLfdPGNOsmWvEp+OK6uN55SV9LzHz6mtpWKcxvSTzM2of2hUgr0
	 2wXX9Y+ju438g==
Date: Thu, 19 Jun 2025 11:51:30 +0100
From: Simon Horman <horms@kernel.org>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
	Lorenzo Colitti <lorenzo@google.com>
Subject: Re: [PATCH net-next, v2] selftest: add selftest for anycast
 notifications
Message-ID: <20250619105130.GJ1699@horms.kernel.org>
References: <20250619035116.3761921-1-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250619035116.3761921-1-yuyanghuang@google.com>

On Thu, Jun 19, 2025 at 12:51:16PM +0900, Yuyang Huang wrote:
> This commit adds a new kernel selftest to verify RTNLGRP_IPV6_ACADDR
> notifications. The test works by adding/removing a dummy interface,
> enabling packet forwarding, and then confirming that user space can
> correctly receive anycast notifications.
> 
> The test relies on the iproute2 version to be 6.13+.
> 
> Tested by the following command:
> $ vng -v --user root --cpus 16 -- \
> make -C tools/testing/selftests TARGETS=net
> TEST_PROGS=rtnetlink_notification.sh \
> TEST_GEN_PROGS="" run_tests
> 
> Cc: Maciej Żenczykowski <maze@google.com>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
> ---
> 
> Changelog since v1:
> - Remote unrelated clean up code.

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


