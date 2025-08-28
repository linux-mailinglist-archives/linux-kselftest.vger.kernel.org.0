Return-Path: <linux-kselftest+bounces-40205-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D49F3B3A750
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 19:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B1677C5B62
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 17:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DCF334708;
	Thu, 28 Aug 2025 17:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjASwD8F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAD82BE04D;
	Thu, 28 Aug 2025 17:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756400830; cv=none; b=uQe7+YszZGGqRNe2rb9oQHJhTtQ726ZFMv2QdMQfMWd0qJeC+7Xtm17N3ZoPwdaUD3QDGvKuG/qgT27iXfFkEWv/GBStIyb5Fiaa6Qx1ZTDtvghccvfVbf6sl0EkzSuWMQhLn498djuK6z5QWvpOEgXFDJKI1PqK8LD25cXOCxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756400830; c=relaxed/simple;
	bh=3gTzFS2mfkWv9GDGZCaEYaViGLlDDzJmcWrY8AgI1ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEHwtU3Gr+0tCbVHMQqtA+T/pyG+2U6AoMZ0juhvpHObQnseijR9MUx4GpGiKk5FsZaMxBkzFhIpwHL/stKr07+FFNSNhgEahhhkaxBmcc6gU/DefjkmamqQeLlb+6XJCf0kkqDYxRAlplCYZZXqEXJqjFiQ5suqk7Pirt/3src=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KjASwD8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57763C4CEEB;
	Thu, 28 Aug 2025 17:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756400829;
	bh=3gTzFS2mfkWv9GDGZCaEYaViGLlDDzJmcWrY8AgI1ZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KjASwD8Fod9VpVIWomPQqQjZ/3XcCfNtZ3yQnC31pSOb5j18UBt2ZT0nX266J+Qs7
	 G7cIfaqPNNlxAxQoBFTUf1/J8ajG3hBNWn6gqLn7EY7qKxNpD6LEtgkYojoqfOmjpG
	 VH2zHLXuNjx1hLNVbgIPorddi+5hYWPhg8g+aAPBuFHaRHY3L0AK/EHTOmwSQhIzkh
	 hLyfst1/UOFOUt69nZljsOeezCxPu7tDpj/q7tBgejRpR24pmnc0GqzN4wMXSe3Vfe
	 NSkAkDn7meUtCWikvReJMxYGr1n8PWN61VG1UOtOzVqFcL1oum8Grw1X7kJDNRpOY4
	 wr2vsacJd/7Vg==
Date: Thu, 28 Aug 2025 18:07:05 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shuah@kernel.org,
	ecree.xilinx@gmail.com, gal@nvidia.com,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: drv-net: rss_ctx: fix the queue
 count check
Message-ID: <20250828170705.GB31759@horms.kernel.org>
References: <20250827173558.3259072-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827173558.3259072-1-kuba@kernel.org>

On Wed, Aug 27, 2025 at 10:35:58AM -0700, Jakub Kicinski wrote:
> Commit 0d6ccfe6b319 ("selftests: drv-net: rss_ctx: check for all-zero keys")
> added a skip exception if NIC has fewer than 3 queues enabled,
> but it's just constructing the object, it's not actually rising
> this exception.
> 
> Before:
> 
>   # Exception| net.lib.py.utils.CmdExitFailure: Command failed: ethtool -X enp1s0 equal 3 hkey d1:cc:77:47:9d:ea:15:f2:b9:6c:ef:68:62:c0:45:d5:b0:99:7d:cf:29:53:40:06:3d:8e:b9:bc:d4:70:89:b8:8d:59:04:ea:a9:c2:21:b3:55:b8:ab:6b:d9:48:b4:bd:4c:ff:a5:f0:a8:c2
>   not ok 1 rss_ctx.test_rss_key_indir
> 
> After:
> 
>   ok 1 rss_ctx.test_rss_key_indir # SKIP Device has fewer than 3 queues (or doesn't support queue stats)
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


