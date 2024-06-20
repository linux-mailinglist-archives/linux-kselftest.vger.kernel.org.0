Return-Path: <linux-kselftest+bounces-12328-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6410B91079F
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 16:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3A9C2810A1
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 14:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652C91AD4B1;
	Thu, 20 Jun 2024 14:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsLLcnH5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E4C1AB91B;
	Thu, 20 Jun 2024 14:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718892662; cv=none; b=EPkl7qIAPlE0aTOMUWUsOVf/qvUCMJOhu9qFfXLBPUTmiImlEuKLyZh3lLYCkwYMgN6jGn5d+jPxZH82KW5/9+uT353JOJOP9tfbD2dj5dPjVxYQPKdjdpXeDdLEFSJKKMlEtyQe2KO0R3Y1Rz0WLNop8SrfK+AzQBf6Qo33Bq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718892662; c=relaxed/simple;
	bh=aW+XK4t/S2Wp+P0aaahubszuXaeo7UPV6ZebItanu7g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AExZf9hi65cIkVcFg7zXtMimRXJX1kicnPWGjO6kvKf0uEk8X131jVZZ12sMG01VIBUvoo+JG8yXwdBG11VD2eo3ZRcZ5UO8zP4XE0rs9AvTQw6Je5M5KPP9QlfgHn+qiocmCEJJWUWSnga1y77vPo7WDIPtN9NytlRPPXIPVAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rsLLcnH5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32244C2BD10;
	Thu, 20 Jun 2024 14:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718892661;
	bh=aW+XK4t/S2Wp+P0aaahubszuXaeo7UPV6ZebItanu7g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rsLLcnH5OgosSXeWf6oP6ICY4h+X4IUMR1Dkel1FMXf/lsRsfUhUgIgV/iexyep3R
	 AtvrdNZi78Fsz5CctvOSv3yq4uOitTlVZl863e0Gc2P8LrdLLKCsS+6xB4kIGnenXY
	 Pi9BHPi6EhJxY3WZpkTeSzDn4/OK0RjkCET/+CbH/azfKnADeUJMs9Fk6fAQLzwyfK
	 lwCrieWb96oxt02GIX363WpkJXE83JechaAHSI8C+Pw7ax9Vb+ONjRImVRmUm/gFOw
	 G9f4t6lJplXugiag4awxGRmU/HRyYjzx5FfZDg0cE+tNSrXVKfGhXsZ8DqQwezE+i+
	 e8NTLw1ENcghw==
Date: Thu, 20 Jun 2024 07:11:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, matttbe@kernel.org, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 shuah@kernel.org, petrm@nvidia.com, pabeni@redhat.com,
 linux-kselftest@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net] selftests: virtio_net: add forgotten config options
Message-ID: <20240620071100.2dc3d75d@kernel.org>
In-Reply-To: <20240619061748.1869404-1-jiri@resnulli.us>
References: <20240619061748.1869404-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Jun 2024 08:17:48 +0200 Jiri Pirko wrote:
>  CONFIG_VIRTIO_NET=y
>  CONFIG_VIRTIO_DEBUG=y
> +CONFIG_NET_L3_MASTER_DEV=y
> +CONFIG_IPV6_MULTIPLE_TABLES=y
> +CONFIG_NET_VRF=m
> +CONFIG_BPF_SYSCALL=y
> +CONFIG_CGROUP_BPF=y
> +CONFIG_IPV6=y

I sorted them alphabetically when applying, hope you don't mind.

