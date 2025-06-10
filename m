Return-Path: <linux-kselftest+bounces-34624-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 032ECAD44D0
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 23:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9983A3D59
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 21:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1A3266B6B;
	Tue, 10 Jun 2025 21:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8pmgUpy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD1D2367CC;
	Tue, 10 Jun 2025 21:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749591147; cv=none; b=i1ISwm/j+gzutDtDtC84MRIll78iUNYjmGtnSnVZNsBZ1OZl/XvZ3Fx4bOHtwbnGgbi0wH8Woc4g8eX4gbu2bMGO6SfI1c1DW8Dr/ZWvNVpzWkH6S4QWszySgX1M9UMKNYtkfmq04uqeVLwAxbxvvMBgZtdzwF60NozbPn3l/qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749591147; c=relaxed/simple;
	bh=nvDn3BbqLfDGtA2pH6SUj2o9HarQnk0yCX2iKuOiew8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PcINlofc2sL+YK/VlHzskNYdH7gnL4EQ8zTogYxPLJyqMr1m7n76u47PqyR2EBZPxQKm0GUjPRPd8BfuioJvigFa8Z/3O7E59nLvZ73E8R/kG3eZvaqJXlRZIVAUEtpYrzmME3aGTrtTjvJTwanftwtcmFWF+Ut3wYeFTogsh9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8pmgUpy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53538C4CEED;
	Tue, 10 Jun 2025 21:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749591146;
	bh=nvDn3BbqLfDGtA2pH6SUj2o9HarQnk0yCX2iKuOiew8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I8pmgUpysQcsWXKy9aoqjk6GurlKMD6B3ijCqF2z2YCAheKA6cFCoTRJaT2FBrLDY
	 qHTASG5uUVfCTVkj919gJCHODCzq4/8QA2B008ldg174zJSDBmAcBW1DTpxyNMFRuL
	 9458z/FlTfbkslQWLd8vy8oWG2+sGAk5C2asYF7db7aiLFMZuW1EaCAbWzi8fyq5pj
	 iJOm8jXHC8/i3O1soNclIMMD0ggZH5ylPzrmE9u8ZC/ERAIkeuFg5k3kZf9WUYzc4x
	 vHvA8vSAREEnChzAD0OO+9ksOEPyFrCD3a2lzZE3DXVRfb/58U/67AhJ6KkanucAlc
	 ZXQurogbCs4hg==
Date: Tue, 10 Jun 2025 14:32:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, Andrew Lunn
 <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Joe Damato <jdamato@fastly.com>,
 <linux-kselftest@vger.kernel.org>, Nimrod Oren <noren@nvidia.com>
Subject: Re: [PATCH net v2 2/2] selftests: drv-net: rss_ctx: Add test for
 ntuple rules targeting default RSS context
Message-ID: <20250610143225.7dde37a9@kernel.org>
In-Reply-To: <20250609120250.1630125-3-gal@nvidia.com>
References: <20250609120250.1630125-1-gal@nvidia.com>
	<20250609120250.1630125-3-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Jun 2025 15:02:50 +0300 Gal Pressman wrote:
> The test was written by AI, and reviewed by humans.

Please use pylint and avoid adding new warnings:

tools/testing/selftests/drivers/net/hw/rss_ctx.py:788:0: C0301: Line too long (103/100) (line-too-long)
tools/testing/selftests/drivers/net/hw/rss_ctx.py:769:12: W0707: Consider explicitly re-raising using 'except Exception as exc' and 'raise KsftSkipEx('Not enough queues for the test') from exc' (raise-missing-from)
-- 
pw-bot: cr

