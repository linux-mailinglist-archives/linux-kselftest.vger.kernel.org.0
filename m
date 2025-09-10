Return-Path: <linux-kselftest+bounces-41111-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE0DB51177
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 10:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 005E93AA9E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 08:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD53C310631;
	Wed, 10 Sep 2025 08:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkOVVzKY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB2330F544;
	Wed, 10 Sep 2025 08:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757493297; cv=none; b=tgb2EfGmzxBTM5LIdgJhHluzLbKu8QokrQe9rVrgbYFtjSmZGdl6d0pRGq2X5c371e7qRmgkaWYAoARQuS3mXCCUPEwEWz1fB5lpH4qLEwczg514WIwnuJF6dQh1Jgy4SuW7re3fZ08Qsfk2+3o913QVRl377XIcHdVWhTyyjpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757493297; c=relaxed/simple;
	bh=4QAG60rhY1BUK6WDwvitwG7AUkjFIxwKaqdtQEqZR1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xjt1OHzJNNgNlLtQII6HCf2YTwNs9hEiGLetSIW9VhTuSVpuG19tsnKb6bOrsxGCTF3u6oK156ZwusG6YJKXUfJPjZhxb1S1aZWaQ9mjRgl7vs0Cs3wN9X6XYdNYgHhTeehza0lASVhyBmzE9MvfdJ0HUqTIyjtnnd3nYExVv6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkOVVzKY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7204C4CEFC;
	Wed, 10 Sep 2025 08:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757493297;
	bh=4QAG60rhY1BUK6WDwvitwG7AUkjFIxwKaqdtQEqZR1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tkOVVzKYH/aTIgxWF4kHUpgw/Sr35WBaz6MjU3YyNZ6n9kceMj3TveMZDR+XbR/Q4
	 tbrI1USQY+cKNdlTByq4F85zX37savMVFkfW0Dn4h43UnsUbhCqUM5rdjJU/MdbctG
	 sIv4wAvNP9dQzRdbaFjN5l6vsVh83hn402czeWb0w6a8VY4beYqjtootbvrW7wEW0r
	 WkaMOyEwWE42aRDe5NBgBCOkS+CGp0nIoNoeruyZfKegsIA3e8YxKPsniLqc2wrdYK
	 /HAg5K63qbE8HNYfgxjWCNZZCH9ALuZhaL81KdA9csvmu1+I9+HxQ10nY5ZAFgOG08
	 wnVJjb4nUOufg==
Date: Wed, 10 Sep 2025 09:34:51 +0100
From: Simon Horman <horms@kernel.org>
To: Carolina Jubran <cjubran@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net 1/2] selftests: drv-net: Fix and clarify TC
 bandwidth split in devlink_rate_tc_bw.py
Message-ID: <20250910083451.GG20205@horms.kernel.org>
References: <20250909101353.3778751-1-cjubran@nvidia.com>
 <20250909101353.3778751-2-cjubran@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909101353.3778751-2-cjubran@nvidia.com>

On Tue, Sep 09, 2025 at 01:13:52PM +0300, Carolina Jubran wrote:
> Correct the documented bandwidth distribution between TC3 and TC4
> from 80/20 to 20/80. Update test descriptions and printed messages
> to consistently reflect the intended split.
> 
> Fixes: 23ca32e4ead4 ("selftests: drv-net: Add test for devlink-rate traffic class bandwidth distribution")
> Tested-by: Carolina Jubran <cjubran@nvidia.com>
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Nimrod Oren <noren@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


