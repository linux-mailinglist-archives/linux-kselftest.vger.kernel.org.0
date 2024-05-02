Return-Path: <linux-kselftest+bounces-9263-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2846B8B9C12
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 16:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8C12281D79
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 14:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EA313C684;
	Thu,  2 May 2024 14:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVWidDft"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A78C12DDBF;
	Thu,  2 May 2024 14:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714659041; cv=none; b=Kk3Xqe60rOSgr2ymd6SqqQI0iu93Weio4LVXaQh9LcEJHlRq1II3QxGVFheIg8RWO+jgqY/6/mdSIeF6raqt1DkdH1fk2XFqgSEkD593PszqRvChwHlHfRQQEpbQpZ3mNsuNDQP7RtDBQk2Z0HWRecEnrlwjID2FBUobP59dYl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714659041; c=relaxed/simple;
	bh=4OIcci68PgoLEQFpUS/m3wwXBwN0nXbzzXVzy2A+aiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxFNmfKs9x2sFSZ0ecTxLQA/xm62ffKuhUGpnOYboJYHsONnugxKD1UD27fkcGvpGR6Jf5b2T50JENdFh1O5CLR/49vgzBFYom1ryQ050vH62F54H5wlt+EZSqWjsp9t5usS6anp0tG3EzL4AoEWTMHvVCwaeJs6xwf6uSsqOrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVWidDft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C898EC113CC;
	Thu,  2 May 2024 14:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714659040;
	bh=4OIcci68PgoLEQFpUS/m3wwXBwN0nXbzzXVzy2A+aiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NVWidDftw05jfkQ9hjJNktUXWAp3LfBKGwXK56zDCOf7foRg4Ko31oj2XnZvy/QI3
	 yIevRo/G+YOGxFYseYjduzxRV/X64DG9k11+rQfxZqWWxoi+Atig5K8i2PsjceP/jO
	 yR/9VeWKEf4f9wS1KqOEc+EW0OqT1MGPaUtse7WjFxJil1CpCgghTwt88SagVxC8FM
	 /3ceLAxzcosPeNZwoW6OUrAggj19b0oAacl/x0Du0SlIg+tdUGZm/Vp9PpSIdkOVYn
	 k2RgCmq3AjmavVdNWBeTaWEppZmX4oQobSkEd5smpQmgGvegi/fTm4BmYFajcmgeGz
	 y4+gyKnE/QsFg==
Date: Thu, 2 May 2024 16:10:35 +0200
From: Christian Brauner <brauner@kernel.org>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Jakub Kicinski <kuba@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Mark Brown <broonie@kernel.org>, Shengyu Li <shengyu.li.evgeny@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Will Drewry <wad@chromium.org>, 
	kernel test robot <oliver.sang@intel.com>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v3 1/9] selftests/pidfd: Fix config for pidfd_setns_test
Message-ID: <20240502-ankam-suggerieren-b3ae553b9c63@brauner>
References: <20240429191911.2552580-1-mic@digikod.net>
 <20240429191911.2552580-2-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240429191911.2552580-2-mic@digikod.net>

On Mon, Apr 29, 2024 at 09:19:03PM +0200, Mickaël Salaün wrote:
> Required by switch_timens() to open /proc/self/ns/time_for_children.
> 
> CONFIG_GENERIC_VDSO_TIME_NS is not available on UML, so pidfd_setns_test
> cannot be run successfully on this architecture.
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Fixes: 2b40c5db73e2 ("selftests/pidfd: add pidfd setns tests")
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20240429191911.2552580-2-mic@digikod.net
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

