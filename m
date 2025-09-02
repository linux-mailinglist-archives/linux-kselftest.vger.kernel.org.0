Return-Path: <linux-kselftest+bounces-40662-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9BFB410AF
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 01:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C39E7A883C
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 23:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA75E274B42;
	Tue,  2 Sep 2025 23:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJiipTzI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1523D987;
	Tue,  2 Sep 2025 23:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756855263; cv=none; b=Ronz4ofIq3ynCdHF+WU3U84w3sKOiqHwd7xyrRLCi3m45+HYA7EJxAzS3oNexBJex/cmjEgTpL267MZI2Iwe1bTUVQr96mOiifWjKerge81n7Zrfg62DUxtLmNLB/L5jItLVO0YPB7LE+rMV/92ZdviK6jroPyCuxFvb4RpcoxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756855263; c=relaxed/simple;
	bh=7hyfGJ/SDzUbn9Jlo1GS4IxYyhXJHn4aBY2j9cEHOAE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XpL28SeWk37IdvKT/UrppRBcKrJcsv4e1KsqI8n9A6ZO2XJt6h9v+g0MskBBzC5cbkTmH42W+U/wL4P1PuxudzorCmtBCVLnf2C4Q7IYuu2F3xwKCmhrF191TPeKVHnGOpR6ovSUJh3+NroWRqwAyUigx1jJ9BRWt8mwo7649fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJiipTzI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DB7C4CEED;
	Tue,  2 Sep 2025 23:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756855263;
	bh=7hyfGJ/SDzUbn9Jlo1GS4IxYyhXJHn4aBY2j9cEHOAE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VJiipTzIEnNHsXp2w5PaOng51OP9xYCylfOzYK4BZpDBLxLOBwIqzNAk5L2w8zUWw
	 cHJm8bwNagEbxgV6A4w6CJJrziUyvo/BstPB92oHpclRaCUJf4U8xL3xUvcTjFZe8t
	 BH8LvezKz5y473cTSYHK9/NlgFLAXRWagdztebEsK+Hd8GGtI3hXbr/V4ezsUkS5zP
	 122UUZSUahq4zqL0X6kkihxS/B7sNMpBVlrD6Gu3HF7DnaEc1WQMc0UvPN+/qCkfiV
	 uuPHG2s+KcBzqHZ/x1EmqP/tOm1p92rB4uKBqGYr81Ie+XStfhHxVcZxlEsxMR7ixC
	 ax9q+w+1rAspw==
Date: Tue, 2 Sep 2025 16:21:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Carolina Jubran <cjubran@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Gal Pressman
 <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "Cosmin Ratiu"
 <cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Mark Bloch
 <mbloch@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH 3/3] selftests: drv-net: Relax total BW check in
 devlink_rate_tc_bw.py
Message-ID: <20250902162101.5c78cc88@kernel.org>
In-Reply-To: <20250831080641.1828455-4-cjubran@nvidia.com>
References: <20250831080641.1828455-1-cjubran@nvidia.com>
	<20250831080641.1828455-4-cjubran@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 31 Aug 2025 11:06:41 +0300 Carolina Jubran wrote:
> Because the measured total is the sum of two iperf3 streams that do not
> always start or stop at the same time

That's solvable, tho? iperf3 has --json support, it will give you 
the b/w readings in the configured intervals (1sec by default).
With the interval based samples at hand you should be able to select
only the period in which b/w is stable ("middle" of the test).

While at it it may make sense to switch to lib/py/load.py wrappers
rather than threading the python locally in the test.

