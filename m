Return-Path: <linux-kselftest+bounces-11071-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807788D6C53
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Jun 2024 00:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ABB1284464
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 22:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A12F7EF10;
	Fri, 31 May 2024 22:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Rqya7Xjh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15111757EE
	for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 22:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717193506; cv=none; b=mRSnE9AFj8yW4dGNSDKdXKjY5FRK7s5wjg91jjTdgiiTKAYjR2bWnHqzo7gRFYz+xG63ZgKht4auxFv/yu2hoDmpvdCal4p5cbaaXkfAFhmCAFgmDOzSNkvdtyd3X2LKwWnIulpYuRrMVFgNAPMlBHZB9jQIPYNEcIcKiBLih2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717193506; c=relaxed/simple;
	bh=N4wW+7bTRwqJCWqumNvlz2syET/F3JCFTu2RMfc9AIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UK4GuHiucEGPmnOdF8ZXWNS/vZBIcdHssmGlA1d8EYRmy8mxUQae6pb0ziRjVlw6Yua/yGtdlSqy7YmXE1j1Unz3+2jT0mleFk3kfE6gGfeJAdOUtTlTdvZ4aZgVHi1Rum704t+HDrLHaToQHs357Qj6nlYgpgW9Gk7SxM+3Mf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Rqya7Xjh; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: technoboy85@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717193502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nBnF/4yXH0rOH3TjrZYGoTuyn2JfhCmeI33/Ncg2NT0=;
	b=Rqya7XjhWIKnIIz3ZpcFiziD9xcIDntei/ZA6lQ0ANRBJonR/m74Dx4mcnj7PuJZjNTfj5
	vlaPM6XgOcybLrtDnWaUTlbsROT9MZQbIKVAuGSL2xWFD4mgC9ctTwFWv25ofBTOPCBltD
	xa1rzZuzK8DMDQZezig+cS97bTZkcZc=
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: davem@davemloft.net
X-Envelope-To: edumazet@google.com
X-Envelope-To: kuba@kernel.org
X-Envelope-To: pabeni@redhat.com
X-Envelope-To: shuah@kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-kselftest@vger.kernel.org
X-Envelope-To: teknoraver@meta.com
Date: Fri, 31 May 2024 15:11:36 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: technoboy85@gmail.com
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Matteo Croce <teknoraver@meta.com>
Subject: Re: [PATCH net-next v2 1/2] net: make
 net.core.{r,w}mem_{default,max} namespaced
Message-ID: <kza36u3rvnxjl5bodh3ecgrkcnm2x3qolzi6j7o24tfoboonap@z7o6xwv6oimt>
References: <20240530232722.45255-1-technoboy85@gmail.com>
 <20240530232722.45255-2-technoboy85@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530232722.45255-2-technoboy85@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, May 31, 2024 at 01:27:21AM GMT, technoboy85@gmail.com wrote:
> From: Matteo Croce <teknoraver@meta.com>
> 
> The following sysctl are global and can't be read from a netns:
> 
> net.core.rmem_default
> net.core.rmem_max
> net.core.wmem_default
> net.core.wmem_max
> 
> Make the following sysctl parameters available readonly from within a
> network namespace, allowing a container to read them.
> 
> Signed-off-by: Matteo Croce <teknoraver@meta.com>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

