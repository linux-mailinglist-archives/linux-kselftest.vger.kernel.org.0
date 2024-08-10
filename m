Return-Path: <linux-kselftest+bounces-15108-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6975694DAA2
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Aug 2024 06:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0130AB20844
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Aug 2024 04:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814D8139D04;
	Sat, 10 Aug 2024 04:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k96D8T4F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A7612F5A5;
	Sat, 10 Aug 2024 04:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723263553; cv=none; b=JKBp0ziwGTmSHGTQOrojVqzcW/AxNvxelFgf7Lkla3ly/NiaQj1GF8hRvGMT9wUrBkFz/eAxAJb8ECZrZ3GVFukYbrKHzEACIbxLJFfTLoUlbMWk1lgK56FNbiKySqGOG77BL2m4+pkgKRc/IAgqRX2ZL9LpoIbQmD9GWXBQ7ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723263553; c=relaxed/simple;
	bh=dQzfxZAD3qNzYbumf4DNUxhUH2jPoo74d3tLNMZfBBA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WhWtCdvfLul5f9tq4yHhAVqqOUVqBZl+6LfiBUrnUmmMHNAckfA6cLhGq9Cwh6K/BGvfwXZlA+MOHEe0hLsJirAtQjXEqyF4eQruOI5R4VLJJUnp6naooUZvhw805JokYbmMU3vXTIV6InguMk2QTmA4VRcsuMbK0XE2HX/lqzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k96D8T4F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6494BC32781;
	Sat, 10 Aug 2024 04:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723263552;
	bh=dQzfxZAD3qNzYbumf4DNUxhUH2jPoo74d3tLNMZfBBA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k96D8T4FRlJwFE1+CiUXtN9cpuzlL+gsWKrNIB6M6B5g0/y8Y0jZe3cxM64oFCtnF
	 zYwfMKLAje1XCsEEq3ti6wDqx+udqAxZmVwjnK8Y3F8IZTwZwtXlU3t3Grl+IPXBiZ
	 oTDXMcHVfEGqmhl63kIZKJCWFkwedrBmfHSi84+cTSLxuD2xqPuNeJoWiYRnlmErJH
	 2Lh3jMxnxuqyeKM7mfl7dpOHZNxYsvmU7QhMK6GUGHMHVD8t65KXvKCM7WxA0jZmAV
	 Xut/XJZh1gnQiouxZbdv+6yOpRl4LUf2PXXbmd5vKHtmy3k0mfGMlqC2q6bhqDobcW
	 g4+KhJ3b39lYw==
Date: Fri, 9 Aug 2024 21:19:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com,
 javier.carrasco.cruz@gmail.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 shuah@kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH v5 1/2] selftests: net: Create veth pair for testing in
 networkless kernel
Message-ID: <20240809211911.1445c965@kernel.org>
In-Reply-To: <20240809165326.382044-1-jain.abhinav177@gmail.com>
References: <20240808092309.2a811cf4@kernel.org>
	<20240809165326.382044-1-jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 Aug 2024 16:53:26 +0000 Abhinav Jain wrote:
> On Thu, 8 Aug 2024 09:23:09 -0700, Jakub Kicinski wrote:
> > A number of checks now return SKIP because veth doesn't support all
> > ethtool APIs.
> >
> > In netdev selftests we try to make sure SKIP is only used when test
> > cannot be performed because of limitations of the environment.
> > For example some tool is not installed, kernel doesn't have a config.
> > Something that the person running the test is able to fix by fixing
> > how the test is run.
> >
> > Running this test on veth will always SKIP, nothing CI system can do.
> > Please make the test use the keyword XFAIL instead of SKIP when
> > functionality is not supported by the underlying driver.  
> 
> Ack, understood. I will do that, one clarification though.
> Currently, the tests are using either PASS or FAIL and no SKIP. Based on
> the above suggestion, it seems that I have replace FAIL with XFAIL for all
> the tests that fail due to functionality not being supported by the
> underlying driver.

Right, sorry for lack of clarity.

Our CI doesn't fully trust the exit codes, so even though the test
exits with zero the CI parses the output and finds the "SKIP: ..."
lines. You need to replace those "SKIP"s in the output with "XFAIL".

