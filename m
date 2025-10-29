Return-Path: <linux-kselftest+bounces-44247-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F61C177A6
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 01:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 066381C26C07
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 00:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D851DDC28;
	Wed, 29 Oct 2025 00:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeMkeJor"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CB31D63E4;
	Wed, 29 Oct 2025 00:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761696524; cv=none; b=tD7dT0hy0VSZVNCWtOgDZ5xvsriBlCMFQk+7n1k/2+7Tied+RnwByvx+rLqjEYHOcjCHcCoof3K2WRHgqnZqx4o0q9oR7WvBqbb/JMFLFX8Tc9bxNecf5P7iRD8+UhPgrT+iI6GAXy9Lpd0rwn43fI7w4PrPXk9CQAA18iFzjGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761696524; c=relaxed/simple;
	bh=qEiYyKozecfeo83I5FVNC3qRO4tj4kVQPdT7HZ0bS08=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hHwhlVJ33huvgug2l9iPHDnSXZzmhKoSyqVLLyWn+P/GegwHN3AlcztH4VLh/UglwhZhau5c3tr7NPmNkXqHO21hb9wvMnYQ8CFJf6acTIXVAiWSb0ZQ4p92AM+u5kaYLtxiClW0oOPYg6WPAAKbIMQuosPhej4qaxn2/edVSis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeMkeJor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1D6C4CEE7;
	Wed, 29 Oct 2025 00:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761696524;
	bh=qEiYyKozecfeo83I5FVNC3qRO4tj4kVQPdT7HZ0bS08=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jeMkeJor/+Uq3t9AnY+wccZDzAkhDRNVWeHHfaZxXEI0/e6o2rslWiFEhUM7FnQHH
	 HHbhpAbk4JNyoC767NYeWd66QDgR53j6oFkWxVM6EiHozM+mqryKS0NodyIxy5B7+U
	 VTehJ4MdkRUOntCWK1IVeDM5waO3FEbwctvotbz1ciNQIXy3ot9aCUpEaz2bw22DBC
	 /OnnPz9yVT3DPgtcwUTKq6Jsm5cwCPxe+IzY29de/l9Efjc81iJCrUQj5C6SOxMJHF
	 9wqwSbueacFlVgWtehPMgWIgyg5OBwgYo3NUUGsmTyXEAZrKfAoGjPsq8Gvc+fYmP8
	 kq7D8MXEvSQHA==
Date: Tue, 28 Oct 2025 17:08:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Wang Liang <wangliang74@huawei.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 shuah@kernel.org, acardace@redhat.com, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 yuehaibing@huawei.com, zhangchangzhong@huawei.com
Subject: Re: [PATCH net] selftests: netdevsim: Fix ethtool-coalesce.sh fail
 by installing ethtool-common.sh
Message-ID: <20251028170842.3fdaea7e@kernel.org>
In-Reply-To: <aQD52zzmW1YDC1iH@horms.kernel.org>
References: <20251027043007.1315917-1-wangliang74@huawei.com>
	<aQD52zzmW1YDC1iH@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Oct 2025 17:14:03 +0000 Simon Horman wrote:
> > +TEST_FILES := ethtool-common.sh
> > +
> >  include ../../../lib.mk  
> 
> Hi Wang Liang,
> 
> As per commit f07f91a36090 ("selftests: net: unify the Makefile formats")
> I think the desired format is as follows (completely untested!):
> 
> TEST_FILES := \
> 	ethtool-common.sh \
> # end of TEST_PROGS

I believe we (intentionally) allow simple single entry assignment like
in this patch. But there have been bugs in this check which I only fixed
last weekend so please LMK if I'm missing something..

