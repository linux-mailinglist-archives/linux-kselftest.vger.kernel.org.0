Return-Path: <linux-kselftest+bounces-25416-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9EEA22BB3
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 11:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6716168014
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 10:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027D41BAEDC;
	Thu, 30 Jan 2025 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWP7xQrY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45AD1474DA;
	Thu, 30 Jan 2025 10:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738233413; cv=none; b=iALbWMIVafhuHhLQTHbLIlEeFEel9skhnSmoNU8oD1/+HhCnQK+7iTkFvhN3+/KapHo5EPisj5gC4pG3K335GEImTL3YBl7fyjQ4i+TFx6xplga8R7Mp6jYLtV4CHQVjRfvUJMaO+ZjZCnh+SfhhfLbLwORsbwtrMid8resLZN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738233413; c=relaxed/simple;
	bh=Q1g2XdY02x7VvZoUchhfn9NKrgAJum1W+VcUXx36XGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBRXZIj1955ma0V8nN823dZSSTsS2Kz/IM2/PIJ05Lxk2wo2q6dGPbvg8exM0QGHV7EIKuYb7L0ROQ+bAVKPVG+3AbC3toaynDlso5hnZJywplrFgHfvjOfd2fU039IIQnli5rSbcyXqI0A//rsycR8ehNHcMExauX7o2z1lynE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWP7xQrY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9265EC4CED2;
	Thu, 30 Jan 2025 10:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738233413;
	bh=Q1g2XdY02x7VvZoUchhfn9NKrgAJum1W+VcUXx36XGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jWP7xQrYy2jKICNEZ0uTZUmWvFOCS2AIBno9AucyFuDVXpyIPKBqHVdzdvli10BI/
	 AZMASTcyBplXWnvU6Bbyv5WNfT9fWMXgFdsXZfEmF4fnkMIHkqOO5VcZ6kCWpFtN4l
	 GCAbwjx5BU2TmWxXKuvXmaFuTxHU5eRfZFlIct2ar3zE5nwJTJuOcsOGwe9nG1Nelf
	 zX8eUHPUm3k6BXO5Kh379FLdMsmt91ckWiINDqSrdsJ2ePlEj4IC3SJSW2qaw0XLLX
	 myQ43tjiVScqnBgaeCfBLkCn6bFnQpdfsNKg9BQbY/bp+N1t8FMmmhcjINdf52bw7f
	 LLM92/G5drZ3g==
Date: Thu, 30 Jan 2025 10:36:48 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	rdunlap@infradead.org, kernel-team@meta.com
Subject: Re: [PATCH RFC net-next v3 2/8] netconsole: Rename userdata to
 extradata
Message-ID: <20250130103648.GF113107@kernel.org>
References: <20250124-netcon_cpu-v3-0-12a0d286ba1d@debian.org>
 <20250124-netcon_cpu-v3-2-12a0d286ba1d@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124-netcon_cpu-v3-2-12a0d286ba1d@debian.org>

On Fri, Jan 24, 2025 at 07:16:41AM -0800, Breno Leitao wrote:
> Rename "userdata" to "extradata" since this structure will hold both
> user and system data in future patches. Keep "userdata" term only for
> data that comes from userspace (configfs), while "extradata" encompasses
> both userdata and future kerneldata.
> 
> These are the rules of the design
> 
> 1. extradata_complete will hold userdata and sysdata (coming)
> 2. sysdata will come after userdata_length
> 3. extradata_complete[userdata_length] string will be replaced at every
>    message
> 5. userdata is replaced when configfs changes (update_userdata())
> 6. sysdata is replaced at every message
> 
> Example:
>   extradata_complete = "userkey=uservalue cpu=42"
>   userdata_length = 17
>   sysdata_length = 7 (space (" ") is part of sysdata)
> 
> Since sysdata is still not available, you will see the following in the
> send functions:
> 
> 	extradata_len = nt->userdata_length;
> 
> The upcoming patches will, which will add support for sysdata, will
> change it to:
> 
> 	extradata_len = nt->userdata_length + sysdata_len;
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


