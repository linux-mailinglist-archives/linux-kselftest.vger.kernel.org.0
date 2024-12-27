Return-Path: <linux-kselftest+bounces-23778-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 816359FD707
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Dec 2024 19:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 287231884186
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Dec 2024 18:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EAA1F892C;
	Fri, 27 Dec 2024 18:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MK9UEz1J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E9345005;
	Fri, 27 Dec 2024 18:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735324892; cv=none; b=opl0VQHBpjS7ZcCQHccRHeg5kkRIcJn9KtcUa7Uo/eNf0CBG7I3uAXfw01xc7YBEgErC49mHk+NPZx9+EJOZL4Fr7OFKZM6cquB64VXgqaidmhHQYjAnVblAyO/Sw+YZv9Ek3eXdBbQVYwcoMliKSbwPb/GMB2sqzwkPHTrkJcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735324892; c=relaxed/simple;
	bh=CzowpDg7vD/IHfkVEGqV4EfJUag5ZgNX4RwbtwxMFu0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lfcil8/FNF3gUz0NgeDZ98jSuMf01nhwvAkbCzwWxlXe/GAtGiu8qXSm74wzXfwvju0v5n+x1On3WFxe49mZ1Y9UVtbtv+FA9EXHkWRvPbyDjOCany1NNnwukeO7VJU1zPLVVM2qeXcmjtEJ8JUY6iPSeRbV6WE3fq74sN3miMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MK9UEz1J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303EBC4CED0;
	Fri, 27 Dec 2024 18:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735324891;
	bh=CzowpDg7vD/IHfkVEGqV4EfJUag5ZgNX4RwbtwxMFu0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MK9UEz1JfqTGoB/6wmRsia3l2hKYdNYJJB5hJALnSJYtxOO1gEZR4WvGpQpKeOVLo
	 NO/7ypklxq2wJ1pDMmU9hkM1sLWHZgcJJ5GBh5pC3DKfCcPP651fCZjPMFLSn359TP
	 zW0lpLkPY9Dl4h8jTqDMOvU3jI06RT2rcLuYF+1pgx4aaG46tEC8JcR1iJQsYdaWzN
	 +9Xi751f2JmO/KADWZ7YN2rvYUdW1E2MMk7OiGoxKmDiBVrJ7RYH/x/Onc5+nyDXKA
	 8BIj00m15dABDI8rAfva/EWbjcr/uWuKXHVmCNSKEPyOIQvMneynh/NE3V7VgH9lX8
	 A1D6xVRHjKNMQ==
Date: Fri, 27 Dec 2024 10:41:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Soham Chakradeo
 <sohamch.kernel@gmail.com>, Willem de Bruijn <willemb@google.com>,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 linux-kselftest@vger.kernel.org, Soham Chakradeo <sohamch@google.com>
Subject: Re: [PATCH net-next 0/4] selftests/net: packetdrill: import
 multiple tests
Message-ID: <20241227104130.78b4a961@kernel.org>
In-Reply-To: <676ada6afb03_a069c294d6@willemb.c.googlers.com.notmuch>
References: <20241217185203.297935-1-sohamch.kernel@gmail.com>
	<20241218100013.0c698629@kernel.org>
	<19df2c4d-c40c-40c5-8fec-bb3e63e65533@redhat.com>
	<676474a0398f0_1f2e51294ad@willemb.c.googlers.com.notmuch>
	<20241219180144.7cf5226c@kernel.org>
	<6768dd1289ee2_3cff202943a@willemb.c.googlers.com.notmuch>
	<20241223085033.5926d1a6@kernel.org>
	<676ada6afb03_a069c294d6@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Dec 2024 10:59:38 -0500 Willem de Bruijn wrote:
> > > Thanks. It does not seem to resolve the flakes.
> > > 
> > > At this point I think the best path is to run them in debug mode to
> > > get coverage, but ignore errors. With the below draft patch, error
> > > output is still logged. For instance:
> > > 
> > > # tcp_timestamping_partial.pkt:58: runtime error in recvmsg call: Bad timestamp 0 in scm_timestamping 0: expected=1734924748967958 (20000) actual=1734924748982069 (34111) start=1734924748947958
> > > # ok 2 ipv6 # SKIP  
> > 
> > Makes sense. Can we make this XFAIL instead of SKIP, tho?
> > Not exactly accurate but we try to use SKIP for reporting env / setup
> > problems like missing commands. We have FAIL_TO_XFAIL and
> > xfail_on_slow() in the lib for netdev bash tests, already.  
> 
> Sounds good. I'll add a ktap_test_xfail() to stay with that API.
> I see no clean way to make use of xfail_on_slow directly.

Ack.

> When net-next reopens, unless the noisy dash is annoying.

No huge rush, once we mark the test as ignored it's not very annoying.
As long as we have a fix before the next merge window we'll be good.

