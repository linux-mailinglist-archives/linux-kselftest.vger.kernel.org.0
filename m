Return-Path: <linux-kselftest+bounces-29435-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C447A693ED
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 16:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2392D88530B
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 15:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1439B1DD0E1;
	Wed, 19 Mar 2025 15:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1SavQQx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5F11DD0C7;
	Wed, 19 Mar 2025 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742398825; cv=none; b=tIGkVA6/ezjPs9NFNyjn+8FYwg8vy31vdK/nbn+/YXMJhY2AR389+tW0Ve8UbIPWcDVshWAn4A5txBCuLagvC+5Czb29a3LxH65aSAXlP8VMtocmOjPK5hGLvFm1Ag/Z0N2Hshx8cuw2ACk4ag+If2ci+uEi2VOF9k/qijE/iBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742398825; c=relaxed/simple;
	bh=wAoeFN6hAbWVxku5OhniHiXhkdAt6x6CK2DxmwanrQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kESkwLe04jHurj6lp4AXfkPMQwNyodufnXP5a6nqNxvnA2TXRIaYYkO+tpHjHcl//ynmrJFtve1cf5axAgM34TKqM6Xo2VQgSMqx1rIEkSRtVRRw0k/Tpii8emctT9qzkXepUajtcbuaCJ2N/hFi8cX/OUrj6bs+Kdov98YLxGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1SavQQx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B5DC4CEE4;
	Wed, 19 Mar 2025 15:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742398824;
	bh=wAoeFN6hAbWVxku5OhniHiXhkdAt6x6CK2DxmwanrQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o1SavQQxpm/oyzrgoKXokY1GXh1740OzKvorCW8kcMtdhp0MaCYxO2Fwb6qFL9QdN
	 Wm3yZgt83sUEwBGs4YQ1/V8WFK9Urv+hPRD23vUqOr/QF+wkPw9wzko7bPnxgJNSRE
	 Z+Wjcc5g7aV/Gk/ZGple7H+yVLMzNRnTZAj0MM0peixzg3SVl5M6MeZnGZXjPoHfNb
	 VEWj/XYjHkR7pb8yt1xxAzpvhfBGVoK4cra4PIhxyeMjuK8QKXL4xPthu55M/nllaC
	 JoKHGJzRWdlsEX4bnHEppmC9EOhUTNYUCbaE3Zi1Kf7I9ZdxBGZrd7D2tJxBirY7GA
	 IS7eSwliqVXUQ==
Date: Wed, 19 Mar 2025 15:40:17 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	Manu Bretelle <chantr4@gmail.com>, kernel-team@meta.com
Subject: Re: [PATCH net-next 1/6] netconsole: introduce 'release' as a new
 sysdata field
Message-ID: <20250319154017.GF768132@kernel.org>
References: <20250314-netcons_release-v1-0-07979c4b86af@debian.org>
 <20250314-netcons_release-v1-1-07979c4b86af@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314-netcons_release-v1-1-07979c4b86af@debian.org>

On Fri, Mar 14, 2025 at 10:58:45AM -0700, Breno Leitao wrote:
> This commit adds a new feature to the sysdata structure, allowing the
> kernel release/version to be appended as part of sysdata. Additionally,
> it updates the logic to count this new field as a used entry when
> enabled.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


