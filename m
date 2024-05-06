Return-Path: <linux-kselftest+bounces-9547-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F5F8BD461
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 20:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307E01C220B5
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 18:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45742158845;
	Mon,  6 May 2024 18:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="mFMPkPoy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from serval.cherry.relay.mailchannels.net (serval.cherry.relay.mailchannels.net [23.83.223.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAAC15821F;
	Mon,  6 May 2024 18:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715018947; cv=pass; b=iiqzk1Nb22P2G8x/TrDuyJsT/N+cI2qxOFZVdsEjLDu2HFUjwFNTQvwzmPP3f4HwLUetRbxpDsprv1cvgqjs8dUsV7eSZr6OkRx1+RzLQ3d6ySgvFyiuWs00N5StVh/Io2HLN4f/2Vo3HIqSsBJzEHuNN98t4zVpOrLPTLszUO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715018947; c=relaxed/simple;
	bh=68qXLP+eVFBNZ3DoGjJOqqauF+0Za5z/s/VN7tKVQfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcwViE5LmFs+Hmn6L5iRcaXHLwNgV1+BfM8Zft0KnN1RJuXF5yp/3gLRfc8C0AyvB9XfLIsBrxfX6uzQ9GC5L30FIbVfdKMU8CycdmmuAwl9MYeYMx9UVt/jnhYgCVJ4amTfDq72hFcVY4r06sw6rfkJMZQEyiBUDE/4xy5b4Lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=mFMPkPoy; arc=pass smtp.client-ip=23.83.223.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id EAFFB43B8B;
	Mon,  6 May 2024 16:13:39 +0000 (UTC)
Received: from pdx1-sub0-mail-a205.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 5B03143774;
	Mon,  6 May 2024 16:13:39 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1715012019; a=rsa-sha256;
	cv=none;
	b=vJSMT1kScKcngTQJqRsp9Zz6KDnOhYBfO2uNGDYmM+D/FoSyYpr2cG0V9BMCbSx7zJcPPV
	3PDpggt2Bx+mlU0Q8jzAXCEDQyM6c7zstuXdMR1re6WZGUg9JjLIXjEWrN4EZFPxyA96ad
	FrYU+CdTppiuEdx6A5SyoYr/FWGiALJIlYBmcIPD4W5vSOVo4Shy1cbC8BgCE+D+4WsMA8
	VppsmqehmxHA5qDJMqWaV+cWhMdqye4vkcgmM+jWM0wVBxctf/PHz0XeV9TtDRIVeMMuP2
	FLfXROyfbZlflPQiTmSM+Nx/cvXJYX9cyqThMvLEukeeuIF6eZaaEJjSXMjdNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1715012019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=68qXLP+eVFBNZ3DoGjJOqqauF+0Za5z/s/VN7tKVQfU=;
	b=1remKSxbguFaVYzfns6YSyVY3e67fyIG9Vwp1Dgd5PJO8pAMqHi58NZeQXMKLi9DBL3YGf
	dCCUgDkGWqJkyep4Xn4f3zdInNnvISEJNPavTeZ3MaDbpmmRXrGX10c7Kef+YVo77IW1JJ
	fpOTYP5xKGL700XcBXxcmBS+D7T2ZyOTrY3Hez3/CcXPXHCP11KFcdkYzrFbwJrIh2CNyB
	1tXIPxhJa3O18W37k9YaMvaNs6Zdj/EZ4AY4eS/X6Q65lYfkAXhrsTtgbQVg3A9twg1e3z
	gCJF4xlEh8YHTBXzpmlOaicZDEIGmXBwUsNKno7szE9cNQdLg9TCj4R6RSFJtw==
ARC-Authentication-Results: i=1;
	rspamd-5d55749bb4-bp2gv;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Army-Battle: 0f90245f25a5cde6_1715012019744_1900881551
X-MC-Loop-Signature: 1715012019744:224400567
X-MC-Ingress-Time: 1715012019744
Received: from pdx1-sub0-mail-a205.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.119.153.203 (trex/6.9.2);
	Mon, 06 May 2024 16:13:39 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a205.dreamhost.com (Postfix) with ESMTPSA id 4VY60L3d1mzDF;
	Mon,  6 May 2024 09:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1715012019;
	bh=68qXLP+eVFBNZ3DoGjJOqqauF+0Za5z/s/VN7tKVQfU=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=mFMPkPoyJIC1AJUa6jDXzZHagJEjrWf8lHKtiRHodEwj/+t9JHSws24nE4ynOwgSD
	 I+Nkdp1tM1Kk7WwVseuf1F69iBe3C555gEpo6uts4j9w5FCQbAKrvPkSQhx4TQia3z
	 mE1RS7+CmhZUV1qfA8EHpU1DuczAtffbGty1OMfesh7FYrcbSxKc1XSWCP0CrngbFJ
	 jJqqbEdyzWEP/Iea81q8FGQ+20sB9tPyf2FUYv4z5iagY5jr60YxTZpHxduxPdGm9G
	 zZhRVWJXAs2na2d4vvbcGuWu239JaVa0lh7OLuPsHNSU7ZMbleeDF2CDnLT7ZfNzxf
	 RKqv4VCFrGr+Q==
Date: Mon, 6 May 2024 09:13:35 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	=?utf-8?B?QW5kcsOvwr/CvQ==?= Almeida <andrealmeid@igalia.com>,
	"Nysal Jan K . A" <nysal@linux.ibm.com>,
	Mark Brown <broonie@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH 0/3] selftests/futex: clang-inspired fixes
Message-ID: <20240506161335.d6vzvsx74xx4mg7p@offworld>
References: <20240503041843.99136-1-jhubbard@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240503041843.99136-1-jhubbard@nvidia.com>
User-Agent: NeoMutt/20220429

On Thu, 02 May 2024, John Hubbard wrote:

>Hi,
>
>Here's a few fixes that are part of my effort to get all selftests
>building cleanly under clang. Plus one that I noticed by inspection.
>

lgtm - feel free to add:

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

