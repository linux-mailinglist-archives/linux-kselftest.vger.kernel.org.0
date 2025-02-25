Return-Path: <linux-kselftest+bounces-27430-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B7DA43B85
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 11:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE7741882503
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 10:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE431266F08;
	Tue, 25 Feb 2025 10:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CU9KQ8Ca"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E27114A4F0;
	Tue, 25 Feb 2025 10:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478878; cv=none; b=Ma18VwbZ/CCD2bjhXJ5ByPjKj0uFUMx9Hu0DFWM5DJwL0/ZR4HIOF9GMcLlGJGB/Az+CcskI/WPIrOCvDmYns+uRz9uDcZC6i9x7FvpjsDVh3U5AjIBHr5Mt2t/9jlGFCfLqSRgtnuexFSXvdALDnP2nCCgnYVrRxmDkQubgNUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478878; c=relaxed/simple;
	bh=5eJtVYwXg0GH2hO2C2QIL4k8TmKa2vRf5r3orB5Yrsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tW1pfgYiYx0PlXZtJKJNag/HdRsqcbWOMuSkZE9lftbwU6agGgLLK/Aq0SBIYCM95h4p2xdNtYRkb2ah4ICxNYplFawq6PIC9uo9A5Zv/Ht8A/AMW67ZLD9ZZTjoS0N54Wa7zxJLgxg01pD2epJPxGq50DJYjJkjJpFPk6Re+Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CU9KQ8Ca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9738FC4CEDD;
	Tue, 25 Feb 2025 10:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740478878;
	bh=5eJtVYwXg0GH2hO2C2QIL4k8TmKa2vRf5r3orB5Yrsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CU9KQ8CahQ5/vyBjAi6Y+fWU5EThjHwuXwQCzzoDhPVzlmJWhjvsz8SC6EGnOoMFK
	 N2oO43BcdupD9cVi4Hiu4Z+tlDcF2b16ppo/wDL3Wev+OKLy2VjTRnE1nFMEW8liuT
	 huKz1oG6LpGmobN0U7c+FwRGDeRpQNXaqBtuX5dCgcgqQatWjImxC+TpXfEzxcXM8T
	 BnOFZ6NoZO9OHUPnpbANiHX6HIfmPJE5dsOIjIvrLY0jkEfxbAtT3dxIrdcNsgrCdV
	 059Mni6SdlIelUH4Qobw2b8bgeWYtUr/pQ6D0lQPQOlyjPBwlf79NjBo+4V5kgAdzw
	 m2iBCXRBN9lGg==
Date: Tue, 25 Feb 2025 10:21:13 +0000
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
Subject: Re: [PATCH net-next 7/7] netconsole: selftest: add task name append
 testing
Message-ID: <20250225102113.GR1615191@kernel.org>
References: <20250221-netcons_current-v1-0-21c86ae8fc0d@debian.org>
 <20250221-netcons_current-v1-7-21c86ae8fc0d@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221-netcons_current-v1-7-21c86ae8fc0d@debian.org>

On Fri, Feb 21, 2025 at 05:52:12AM -0800, Breno Leitao wrote:
> Add test coverage for the netconsole task name feature to the existing
> sysdata selftest script. This extends the test infrastructure to verify
> that task names are correctly appended when enabled and absent when
> disabled.
> 
> The test validates that:
>   - Task names appear in the expected format "taskname=<name>"
>   - Task names are included when the feature is enabled
>   - Task names are excluded when the feature is disabled
>   - The feature works correctly alongside other sysdata fields like CPU
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


