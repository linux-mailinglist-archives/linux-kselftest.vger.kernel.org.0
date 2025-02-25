Return-Path: <linux-kselftest+bounces-27428-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94291A43B4C
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 11:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF4D17A9B08
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 10:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3DF267AE2;
	Tue, 25 Feb 2025 10:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtsbpNzI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7F826619A;
	Tue, 25 Feb 2025 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478846; cv=none; b=aShwxN9bZ8mLiKXss2fZopFZvjxCjTsCpBJkBjgELGwP9C28hAen1cz3DUJ87l1vY/yQnUog6Q8BRny8im69TqGLdhaeAsCfUO/Vo55onENYAwwTjJ3CJ12ptH9tsHjozpVrzGHW12QF8WsTzdiAGz6bBNXkC8VZcwsr1f4Z1Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478846; c=relaxed/simple;
	bh=kyUFWZqPCMaTtGi0AYxd4Ds8rEc0AhEN3Zag6xPOC+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6ZUu7aMpFc3CI4L6zZSJQ3ghKQ91LdEZaxwDiX5ylrHLLhUCrxARBY91Bmrw8b6uOzC+TgtCXjOUunxqh+qZq/YbUmGMaX/KIO4G7mDlz+V2CIJVk9nR0iXNElsnNwdwn2fGxFWXEKAS1g2ZhbhyRM8v4/tixGfFi/ZE/nfUZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtsbpNzI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED0EC4CEDD;
	Tue, 25 Feb 2025 10:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740478845;
	bh=kyUFWZqPCMaTtGi0AYxd4Ds8rEc0AhEN3Zag6xPOC+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CtsbpNzIVrnZ1ihBmEFtbxbi9+tayY7/jmxyeBFqKO9FMcgHEu/fWrhTsgWo5IRKX
	 whvT3OPEU5fSb83FlUp92lxxX859wydRVdQ1rJqX34R8zB5MMb1Y8BL32iuyzlt4xl
	 ogfdWnZp//qY6xl9KiTEZRys4bs4R3dPzGjk/fcHnVC1UO7WJ7DYp3VSQLsgr3LK20
	 wPKxAa5yFGazngLG96eHVCYu916zajBVMg4pbsNQyY2yk/hRhdfEPUbLyaUKoKxOsp
	 6fTspCV883ccESNivQ+3ecMXXEWAm66tOZ0xWSuSkakfEyK/jHd8IVeZbYDL3xCTbg
	 8ge344+agEvkw==
Date: Tue, 25 Feb 2025 10:20:40 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH net-next 4/7] netconsole: add configfs controls for
 taskname sysdata feature
Message-ID: <20250225102040.GP1615191@kernel.org>
References: <20250221-netcons_current-v1-0-21c86ae8fc0d@debian.org>
 <20250221-netcons_current-v1-4-21c86ae8fc0d@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221-netcons_current-v1-4-21c86ae8fc0d@debian.org>

On Fri, Feb 21, 2025 at 05:52:09AM -0800, Breno Leitao wrote:
> Add configfs interface to enable/disable the taskname sysdata feature.
> This adds the following functionality:
> 
> The implementation follows the same pattern as the existing CPU number
> feature, ensuring consistent behavior and error handling across sysdata
> features.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


