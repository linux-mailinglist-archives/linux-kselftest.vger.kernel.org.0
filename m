Return-Path: <linux-kselftest+bounces-15403-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 774F3952E94
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 14:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5A11C23AED
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 12:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409291991B1;
	Thu, 15 Aug 2024 12:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvK/wCvh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F8A17C9B2;
	Thu, 15 Aug 2024 12:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723726405; cv=none; b=loeenkjq7UfaoL//2MoMRlZKGqFlE2qOphOlGiqYKT0F99K7NhRXV4mOstgkpJDzXtneYXBZLcbd0zV66PU5P1sFWP8ND0PraxgAVA7iDE5/wn4Z4+n+xWXOLdC4HRDOA1n04qWB8OqlFPDkbMm6i/6c/ZdnswZ8Y33i1bzEH84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723726405; c=relaxed/simple;
	bh=f/g/aJNdyW0MItoXVYRuTwBSK72KCqc+cG0gQXEGCPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=km4PSVEKkQ+0h+OPbfwGIfJFqm6h5Yg1PTlcyOWu1/kakn5Hjw0BomvrV4sm1ap8xCxAEt9kGAyU/H30jjo2IpM1l3/NgnvCiwzsCVsAVb11PiU7BeQ14qlHM5p8k/+3CJ4nchL4K2jKi3C9TFS82UFCZSIZvX3urYa4uv7paZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvK/wCvh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396B2C32786;
	Thu, 15 Aug 2024 12:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723726404;
	bh=f/g/aJNdyW0MItoXVYRuTwBSK72KCqc+cG0gQXEGCPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DvK/wCvhzw+MOs1FCBzpIsgRPxcDUYRg1htG68hf37t3HmygSoLvyIi0J257N5BJj
	 lcqODG7tRSEkHrZsHvR8b3IC1PuMyTxfH9H5FedpVXW5ZLsZDb8WMsq7vqTBpGnSRo
	 Q7NebT/rUcpI+1TQKWp9MpO0Q0Aygm5rOiEKRy1cT1S/e4t26/xfRDs47qopNti13j
	 sDV4pnZT/J9Kb3lzVzvOBGLtaMsht0M71XVpvwSLBkN/M1PkaZwI02V/Vf6q0gAy3J
	 2/VzeHwULQyjGcAYAhhQ5yPwfFvNmFej/2Q3xkonwe0Pby07/+a1WBU88gDX/9N5+o
	 YzYDsRW7OMibQ==
Date: Thu, 15 Aug 2024 13:53:21 +0100
From: Simon Horman <horms@kernel.org>
To: Abhash Jha <abhashkumarjha123@gmail.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kuba@kernel.org, shuah@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] selftests/net/pmtu.sh: Fix typo in error message
Message-ID: <20240815125321.GA632411@kernel.org>
References: <20240814173121.33590-1-abhashkumarjha123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814173121.33590-1-abhashkumarjha123@gmail.com>

On Wed, Aug 14, 2024 at 11:01:21PM +0530, Abhash Jha wrote:
> The word 'expected' was spelled as 'exepcted'.
> Fixed the typo in this patch.
> 
> Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>

I agree with the correctness of this change.
And I verified that with this patch applied,
coedspell only flags false positives in this file.

Reviewed-by: Simon Horman <horms@kernel.org>


