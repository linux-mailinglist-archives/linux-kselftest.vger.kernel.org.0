Return-Path: <linux-kselftest+bounces-41078-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFCAB50915
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 01:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F7771C6200E
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 23:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B2F2857FB;
	Tue,  9 Sep 2025 23:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTeA5pIl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFB6286887;
	Tue,  9 Sep 2025 23:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757459787; cv=none; b=gIvEC9fWF2vg24uNjT6exKtCjtSiJ4t2WoMTz9W7qUcMvRtXTdupvRd1FWFcsTadAqtyVXFNxA1vTUDOuhzAPlnYZKSCztB0otOTc7H8dchyzX4GV7+wmQBPb3t+EuiNOU8UxwRsz1Cx6RhpldIoNAcAOs2abTFI2OActDVIJnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757459787; c=relaxed/simple;
	bh=2cmXDFZTP2N7nkjntGlSJDhStoIGq2QBtQF2XGCW7Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PS422O8EcjnxKK9yjTGFsgRBga2noyS9Yfs8eIJ6GkylNbpcTr6EWisrP0ObJno0B3LIS1jSf4ykWqlqCCnbqYQpsabodTy+h9/SvT+A7UL0CS0j+vnDT2cupBp1fFF1kxoKJXspubKC6jxvLkwAPXOqLnAPl3Jhz7VbCu4SICY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTeA5pIl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E4BC4CEF7;
	Tue,  9 Sep 2025 23:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757459786;
	bh=2cmXDFZTP2N7nkjntGlSJDhStoIGq2QBtQF2XGCW7Tw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RTeA5pIlFOKueEG9j3UnjmWhIxIg2GQ/AKRpSdRhibJXSNTUQrrqfWmm0fQ+CtQcL
	 xYB5pqiRO3dGwpe6c99HHUR02wNaoo/v85wMeH5ar8ZzF0ScF/5gxDEpgJfXa1+8W2
	 DhRhMbu7gnSVeR6lpE1qDxREajvzNwqMnQckJvNrq69V7LRlXrClz6NKdjGkdZeOwh
	 2LeiKIIj6hUvCtH343vpkDVO5UGJ3VizgXR2FI/365bWxwiMPlf2iH7CW6qYOj2dwC
	 aQw4Plz7mf67W4/9poaQCD93IPj4g670VKMART5MnE4Rw5wNWknKkW504L+aI9ZnH/
	 Pzquvkpjkeumw==
Date: Tue, 9 Sep 2025 16:16:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Calvin Owens <calvin@wbinvd.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Simon Horman <horms@kernel.org>, david decotigny
 <decot@googlers.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de,
 kernel-team@meta.com, stable@vger.kernel.org, jv@jvosburgh.net
Subject: Re: [PATCH net v3 1/3] netpoll: fix incorrect refcount handling
 causing incorrect cleanup
Message-ID: <20250909161625.470d2835@kernel.org>
In-Reply-To: <kmvkrqkkrbfctpramlchpwqikg2x3btb3debshabqctt7azu2j@tv4ziqd4gldh>
References: <20250905-netconsole_torture-v3-0-875c7febd316@debian.org>
	<20250905-netconsole_torture-v3-1-875c7febd316@debian.org>
	<aL9A3JDyx3TxAzLf@mozart.vkv.me>
	<20250908182958.23dc4ba0@kernel.org>
	<kmvkrqkkrbfctpramlchpwqikg2x3btb3debshabqctt7azu2j@tv4ziqd4gldh>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Sep 2025 13:17:27 -0700 Breno Leitao wrote:
> On Mon, Sep 08, 2025 at 06:29:58PM -0700, Jakub Kicinski wrote:
> > On Mon, 8 Sep 2025 13:47:24 -0700 Calvin Owens wrote:  
> > > I wonder if there might be a demon lurking in bonding+netpoll that this
> > > was papering over? Not a reason not to fix the leaks IMO, I'm just
> > > curious, I don't want to spend time on it if you already did :)  
> > 
> > +1, I also feel like it'd be good to have some bonding tests in place
> > when we're removing a hack added specifically for bonding.  
> 
> Do you prefer to have a separated bonding selftest, or, is it better to
> add some bond operations in the torture selftest?

Normal test is preferable, given the flakiness rate and patch volume
I'm a bit scared of randomized testing as part of CI.

