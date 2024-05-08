Return-Path: <linux-kselftest+bounces-9693-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAAF8BF93C
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 11:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A070C1F22746
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 09:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698F44C3D0;
	Wed,  8 May 2024 09:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqqniQcv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C67574400;
	Wed,  8 May 2024 09:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715159269; cv=none; b=D2unMkPnWDFbpG48eKv9O77UW7CItSdjRujTNQ9Iv3Ke8wIQaRBpfV21+vFuHyD0fJKgL3PHAyq+JknJ5mT5L79W7kvVgHY+rxiCLSLFFV5ILQWhueAbSSMyT+FezBWhtCtQF8Pi1LrIVcji/l/W0LRRGTfgUvelk2D4Jajavhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715159269; c=relaxed/simple;
	bh=mtmLSqgoKjfYqqbnBEPAlO9QXmb0/5zNhYFOFAvhFPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtPyZ0IRU3TFBEoQ/w681DBqTceD8jcWssPZJXlz15bnQHMLgyXw3m2pAUwoMNydC2fezfCmePln4Qs+M8waxI+SY91Jnt4TnH0dgzuD/hxRnYwD+kq7QyV/AU5nJ9h9WYwLClzukGZFFv1wZMK9FI1Rj1M4EYJ7xs0aCaLdGDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqqniQcv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE82C113CC;
	Wed,  8 May 2024 09:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715159268;
	bh=mtmLSqgoKjfYqqbnBEPAlO9QXmb0/5zNhYFOFAvhFPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hqqniQcvryMhrXtdNqe9qeYb4knp6WYhEDB0F7hx+A0lSvoKxNuORreodVHuXEPYY
	 lKsDyA91CQD87r1QA1lpj92KV5+WTNGKYJrPeC9AU4ndIuYXrvVB+upH7CUAhuYyHC
	 qBxxcgMz/4LoH0O3tC3O/53fVFr2fT8ZPEoO4ZvZRN7mQr1XVy1lNJDdZHmHFAieCb
	 iEBOV/mGXx4MXMC/6P0+YVm2CvBG++d7RD0r2v4FO05puJaoklKxdBpejWOcqi1Wd7
	 A4aveUA6o7s4KVelIWBS4tumjJ5u9jGUNyI54KwbEn/wUXusp4guKLgOzg4WaRHCxw
	 0/v+N5c6/FsiA==
Date: Wed, 8 May 2024 10:07:44 +0100
From: Simon Horman <horms@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] test: hsr: Call cleanup_all_ns when
 hsr_redbox.sh script exits
Message-ID: <20240508090744.GB1736038@kernel.org>
References: <20240507091155.3504198-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507091155.3504198-1-lukma@denx.de>

On Tue, May 07, 2024 at 11:11:55AM +0200, Lukasz Majewski wrote:
> Without this change the created netns instances are not cleared after
> this script execution. To fix this problem the cleanup_all_ns function
> from ../lib.sh is called.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Reviewed-by: Simon Horman <horms@kernel.org>


