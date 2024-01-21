Return-Path: <linux-kselftest+bounces-3282-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BECE58357BE
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Jan 2024 21:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C1E281A45
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Jan 2024 20:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67EE381A9;
	Sun, 21 Jan 2024 20:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVUZzcIU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE551F603;
	Sun, 21 Jan 2024 20:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705869278; cv=none; b=jfniu7zDa3+ai5lYXeRNVrym1uP1Ra1f7u1ioPcSf5o16FngfJNADfVXy7EWKlT26zXOCXKBQm0O4WztvJtPqkpwPWIrs62XcTwzhCUbP6gIED/xJd5zI5CbKYgGZNxqfJUGWjezoNoQNHzLSX93LmcUOP1zngoMGPPq0LRzeVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705869278; c=relaxed/simple;
	bh=wkMKvcrcoH6Dsvg1ZB85Bjuh9puOjbsJxm5yFp5/Psw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwPoHWkUb24WWr2ykz3hOovSKm4KEgdYMb54UzrAgsGy+Y7fqiisoGrsdiPIqzCDLCHUUVgepJERsi0N89v//cMBaO9Rglc0+mYXDw+apaZsUHcgNVul7NTISNZa0uJ5XUnFiABQOWz3OjhvgrZBA4QqNO8IqqyNh0OLklC6bBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVUZzcIU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D92C433C7;
	Sun, 21 Jan 2024 20:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705869278;
	bh=wkMKvcrcoH6Dsvg1ZB85Bjuh9puOjbsJxm5yFp5/Psw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kVUZzcIUyENvO5l8hM31zJhjbCP/Mg9/kWBikK7fqjiz88kWfSwYsC3C7sR2i5vHl
	 pRWBgZ/LBxyAWsAOdQcah91XRg2NoDcfHECfEkCxAsqvZ3DCm9hM4nF7g3cbdYVVLO
	 YpHdJYjouM62KGkA06dV+Eck0f8yH4qaSqWCi5cefuXQev+brPLaewKjV5ELjb6NRu
	 fOXmserpbme1ON85lI1yM0wbVVbMpJ1nkmUJhaFA10M1B8eTP+MxDevTd5/fPVaYRB
	 X7OH2d8B4XfS7CXEfu3mez2+CJMZYwL1M4LBC3wg8zu7qhT1VUKQDyZBYVmwVz+x1I
	 za64XmMLBDL6w==
Date: Sun, 21 Jan 2024 20:34:33 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2] selftests: net: fix rps_default_mask with >32 CPUs
Message-ID: <20240121203433.GA119808@kernel.org>
References: <20240120210256.3864747-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240120210256.3864747-1-kuba@kernel.org>

On Sat, Jan 20, 2024 at 01:02:56PM -0800, Jakub Kicinski wrote:
> If there is more than 32 cpus the bitmask will start to contain
> commas, leading to:
> 
> ./rps_default_mask.sh: line 36: [: 00000000,00000000: integer expression expected
> 
> Remove the commas, bash doesn't interpret leading zeroes as oct
> so that should be good enough.
> 
> Fixes: c12e0d5f267d ("self-tests: introduce self-tests for RPS default mask")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - remove all commas
> v1: https://lore.kernel.org/all/20240119151248.3476897-1-kuba@kernel.org/

Thanks,

this version looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

