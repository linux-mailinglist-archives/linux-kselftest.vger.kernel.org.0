Return-Path: <linux-kselftest+bounces-33335-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC4CABC504
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 18:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA7F87AD38A
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 16:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4623A288537;
	Mon, 19 May 2025 16:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhqhzXWk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A04A28852D;
	Mon, 19 May 2025 16:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747673736; cv=none; b=HoYbZNEEai26A2Py2ZUo55Rf4aGHmGk8t3ziYz4p5yzazkmFpSfbe6Y8LJBCD4NyBgQzmJOxGu7eDyevvh+5LplqRFloO+eRnvwhCt14nW4klsYxqGnVKj7T0lEG+WOtDHmBVRQueEqAX7BztXAixKPXyAGPP3TMPxJDC+X4aKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747673736; c=relaxed/simple;
	bh=VzPNWlfyeCWo7o+KEHwNHpSZQp69P7Gy1mri66l5Kys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irK2l4ZKuW9GQ7Lcb+Y5MGocBILDuIVVp6zoB8xNR9aEqcfMzWImRMQdiwPEsHs4E8faH5CZUz25pbOFSZndr20IZ+mP9ZmkuXrVvpl1VKc855sI4Xu79vcgbfFOuw5chE+rjfGBNFW3C4ICTUxpl12uv+dAafqpCms0q9CtEAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhqhzXWk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 273DEC4CEE4;
	Mon, 19 May 2025 16:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747673734;
	bh=VzPNWlfyeCWo7o+KEHwNHpSZQp69P7Gy1mri66l5Kys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NhqhzXWkWyh1ZNOYnmnBsJpCAzy/JTCM2NOnyRc9xarl1uJ6yUEu4MvFndXBQPhaA
	 0fR5/K96WomU3ltcvv0YxiNR/3cbdgyHulNHnybsSOY0y1LEbfZWwnYb2HrdVQDq21
	 nQuVcuOS8VOEdpj/l6w6bFn+NZJxic95gUtXyQD3AnAAOGu3eZzsmLAJxdbTOmnhyY
	 SLZnHBKJNMMLmJKXaYZTR2YoYHB41kKYGpM2prWeoL6/cw9MVJY4NiBT2352o6JfP3
	 7VgJfwuGOgNy6Klr25esBKQmlpfh2lG0cuprEIp/+vJGkSn25hKk2QlKYoh7tPaC+N
	 Ma4wLFRbbPbSQ==
Date: Mon, 19 May 2025 17:55:30 +0100
From: Simon Horman <horms@kernel.org>
To: Sumanth Gavini <sumanth.gavini@yahoo.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
	willemb@google.com, petrm@nvidia.com, sdf@fomichev.me,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: drv-net: Fix "envirnoments" to "environments"
Message-ID: <20250519165530.GM365796@horms.kernel.org>
References: <20250516225156.1122058-1-sumanth.gavini.ref@yahoo.com>
 <20250516225156.1122058-1-sumanth.gavini@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516225156.1122058-1-sumanth.gavini@yahoo.com>

On Fri, May 16, 2025 at 03:51:48PM -0700, Sumanth Gavini wrote:
> Fix misspelling reported by codespell
> 
> Signed-off-by: Sumanth Gavini <sumanth.gavini@yahoo.com>

Thanks,

With this change this file appears to be codespell-clean.

Reviewed-by: Simon Horman <horms@kernel.org>

...

