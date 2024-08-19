Return-Path: <linux-kselftest+bounces-15650-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42841956E1F
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 17:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB7FE1F22EE3
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 15:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8D916D311;
	Mon, 19 Aug 2024 15:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ei4cphZe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806B52D045;
	Mon, 19 Aug 2024 15:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724079774; cv=none; b=X0/6nf+Ei/oJkcD4LzW8hStkDe8t0MELONnCKZxtHoONsyY46nRbAjNDW57zzw3XrLP9uMRgQhz5XVPUWmjJNPHaq757WBHGsGsUM4FqyXUtcfeBwzP5zvgTvpoNh8RHGtt2VQUx3WJ7LMbCM/ZEW16uzpFUjSTU/4Htax3rIvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724079774; c=relaxed/simple;
	bh=z8WU0XzEzlQ+uAlhL7P0tKAi/MI8243f7k3AOnyv4hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQ/LfNeUaGzR4sjmrgva4RdPLyyd1+46llgmmmIgkJRPfn6flS8jTjBUBBz8ttkRVnfDQIguWqAI4KV6CbS0AzNQlupESS3xnfGmaVGBQWEanxPRS54RJqcJsxKjyvNyXSOc73kNZRlMplF3MpEpSJ4pjNzTAJw0gKddxAC6wMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ei4cphZe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23BEC32782;
	Mon, 19 Aug 2024 15:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724079773;
	bh=z8WU0XzEzlQ+uAlhL7P0tKAi/MI8243f7k3AOnyv4hk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ei4cphZe6maWl/9Vsd1/5ZbKPQNbsNd2siuJzgNMhjp7nmv0dAjRv36785MPX13BF
	 vTkADrkDsJMsTdHr6huDHQ7tEZ2Oiw/PuWdgcImgD4xfKD+TlaRA2NxYqJbZ55Payi
	 oV5YtaIgzcK8fPLRKg/UrDRDbhPmD32LEDRhqkHdvNbc22OgP4CO9IM3p/Q2tTgpOs
	 f+rawZ365yCrUgEilgMib4gpstgrz0ln1Ybw+Xk5pygtxEfQZ39I/ofRQyk47aafie
	 7tVShKgYWQ1ppXf0GfkbMhdrdwisaDTyL4idO2NCBwii4075kcI/bF2IlfFSuF33IK
	 4R7mNCBSBJi8w==
Date: Mon, 19 Aug 2024 16:02:49 +0100
From: Simon Horman <horms@kernel.org>
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH v8 net-next 1/3] selftests: net: Create veth pair for
 testing in networkless kernel
Message-ID: <20240819150249.GG11472@kernel.org>
References: <20240819121235.39514-1-jain.abhinav177@gmail.com>
 <20240819121235.39514-2-jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819121235.39514-2-jain.abhinav177@gmail.com>

On Mon, Aug 19, 2024 at 05:42:33PM +0530, Abhinav Jain wrote:
> Check if the netdev list is empty and create veth pair to be used for
> feature on/off testing.
> Remove the veth pair after testing is complete.
> 
> Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


