Return-Path: <linux-kselftest+bounces-45937-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 893B7C6C3D2
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 02:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CE2B934FA34
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 01:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DA5222562;
	Wed, 19 Nov 2025 01:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdnPHm6q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF59129CE9;
	Wed, 19 Nov 2025 01:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763515506; cv=none; b=pSY5sIS4k7pWInBZ/msxJ+o29i2LGZWP+dRCbqdHXmtrQNwprPi/HyH8zhRJusfekvLzRuY4g3D0+Q0gClS9iWk+jUMynp2E7cEsFvGV6ZPF1vY0Nwmit6ENFaCJfrmCnlOBah0W0aJ8t1jmW00PdYt2O8ZRiXkAMNY5Oun+PUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763515506; c=relaxed/simple;
	bh=WALjlL1a4JQT4R/4pq8RmkRx17wGlyqFe8eYRFAdKVA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QDbE+sl1F5Ze4Yy0u00Swr/XGgjmKEthBKNieaOgzCRraS2wz/v8Z8R8uupHIiHi1sAhA3Fkdkmw3+8lvBK5EDAvumeCNbs6sKykmQ3Go7SLE7A1170xNV4XOUKPe/b2mUSGjfS/gix+5zMYdJHPbjLH9HGWoQ1nDbZOLP/oNVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdnPHm6q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C918C2BCB0;
	Wed, 19 Nov 2025 01:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763515505;
	bh=WALjlL1a4JQT4R/4pq8RmkRx17wGlyqFe8eYRFAdKVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qdnPHm6qDxx5eD5L6MZ3mBoe/ygPfN8DUFrMo9z+AX7KnFLqxbK926nK4Oyv3CsVL
	 qHdYfgK+zaHXpXHXx+47mNwB0VqGcZM6HREx/7gfDlCGA/7x1jlLkr+rlMBOAMCcmt
	 JUV5/IKnFW7Ss8mK18jp2EFAQ3n4P895qrxixRzoMSjl/74A6eFr46wS/FJiHTbmJf
	 syFFaK00TvNFVzxe0I/yk99lRtYZA+4QLZhUUHxoueU+7FXlfzNxTARzhLn8ZNOR9L
	 9fJKx3eCitFS0WHeb18W/r9ujHQVw/sbGzmPtM1+5xb4BRSre994vapJ4KrnHuKp+E
	 1IR5Lbd/LQo4g==
Date: Tue, 18 Nov 2025 17:25:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
Cc: <netdev@vger.kernel.org>, Simon Horman <horms@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <andrey.bokhanko@huawei.com>, <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>
Subject: Re: [PATCH net-next 13/13] selftests: drv-net: selftest for
 ipvlan-macnat mode
Message-ID: <20251118172502.68835278@kernel.org>
In-Reply-To: <20251118100046.2944392-14-skorodumov.dmitry@huawei.com>
References: <20251118100046.2944392-1-skorodumov.dmitry@huawei.com>
	<20251118100046.2944392-14-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Nov 2025 13:00:45 +0300 Dmitry Skorodumov wrote:
> Subject: [PATCH net-next 13/13] selftests: drv-net: selftest for ipvlan-macnat mode

drv-net: means the test is under drivers/net/ not net/, just net:

> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index b5127e968108..ff28012d34db 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -203,6 +203,9 @@ YNL_GEN_PROGS := netlink-dumps
>  TEST_GEN_FILES += $(YNL_GEN_FILES)
>  TEST_GEN_PROGS += $(YNL_GEN_PROGS)
>  
> +TEST_PROGS += ipvtap_macnat_test.sh
> +TEST_FILES += ipvtap_macnat_bridge.py

Please add these at the appropriate spots in the sorted list.

