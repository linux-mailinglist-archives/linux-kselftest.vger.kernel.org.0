Return-Path: <linux-kselftest+bounces-25420-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2957A22BCD
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 11:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2863D188960E
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 10:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8741BD9CD;
	Thu, 30 Jan 2025 10:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJI3mmRS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0B81BD4F7;
	Thu, 30 Jan 2025 10:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738233518; cv=none; b=raUyqkI6Ykzu65WASAc6j0xuoI/ax2ciBPuhSjjHTmBLiXI4ywe7vabw3r39kAm6wSLELLEIoK1mMZPUDQmkDezLECVy5AgHStrcBILdOgx5s56kH3WH4h1ZEcpdBc1Mc54vtb/D6CYEmZCRcGIYq1KWOj1YWA5Q42bHZd1fpM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738233518; c=relaxed/simple;
	bh=cfJeMk0lgbXzXSzjGO2awe3WVWHNIxywXG1all8Lc/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctmlNankhdMDstjgQcgoHluoy4NIcHA8N92fr001gOdSjvNT5bSheLNGlTywi3dTjbAp71dla+a7TkbAG1EB4Wx6ZbG+bpRm+eW3ZA0Uj8CU8+HsLC1ojo2NnJGgRAEh4e2FT92jrnJxp/OSG9zGo/HZsCP72ZkLYJ9B6gAsQnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJI3mmRS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52CCDC4CED2;
	Thu, 30 Jan 2025 10:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738233518;
	bh=cfJeMk0lgbXzXSzjGO2awe3WVWHNIxywXG1all8Lc/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gJI3mmRSFoP2z8OXjYcF4y0bV3odPwW720Ux2YN0pFLSqBO83tNuDVHiskqqW8yRL
	 OZPFI/dGiy2RO584DdHlZCwGR6YFFZNaIHlRWEgA/8+/ZqdX6hdhdmUYYYcBFXn73t
	 JpQHxBDqAfp2QXuNhzn0ez5ieT/HxM1SaVOdoEMRePQQh0VAzqezcAQs75fFgpBByZ
	 FOBH7S+8JOP2i5S8zTojDw3+hD9lzVOJeNvsH3ngsSDcjM9xgi+jelCXJnvcJzDihA
	 QOZbMBiCaaq4yoQ4ArCKAW9MtECgMwEBTGM4x/if+T4c4Db/SEZRkqaop+As/SXItX
	 +piET7fjx3eOA==
Date: Thu, 30 Jan 2025 10:38:33 +0000
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
Subject: Re: [PATCH RFC net-next v3 6/8] netconsole: add support for sysdata
 and CPU population
Message-ID: <20250130103833.GJ113107@kernel.org>
References: <20250124-netcon_cpu-v3-0-12a0d286ba1d@debian.org>
 <20250124-netcon_cpu-v3-6-12a0d286ba1d@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124-netcon_cpu-v3-6-12a0d286ba1d@debian.org>

On Fri, Jan 24, 2025 at 07:16:45AM -0800, Breno Leitao wrote:
> Add infrastructure to automatically append kernel-generated data (sysdata)
> to netconsole messages. As the first use case, implement CPU number
> population, which adds the CPU that sent the message.
> 
> This change introduces three distinct data types:
> - extradata: The complete set of appended data (sysdata + userdata)
> - userdata: User-provided key-value pairs from userspace
> - sysdata: Kernel-populated data (e.g. cpu=XX)
> 
> The implementation adds a new configfs attribute 'cpu_nr' to control CPU
> number population per target. When enabled, each message is tagged with
> its originating CPU. The sysdata is dynamically updated at message time
> and appended after any existing userdata.
> 
> The CPU number is formatted as "cpu=XX" and is added to the extradata
> buffer, respecting the existing size limits.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


