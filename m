Return-Path: <linux-kselftest+bounces-22460-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 206949D6312
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 18:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95214B215CB
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 17:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6714D1DED7F;
	Fri, 22 Nov 2024 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEV7aYQs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7B018AEA;
	Fri, 22 Nov 2024 17:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732296579; cv=none; b=iAr/RlFhg2TTEYns5vZuZbnUt/7HQM0zjqGbCI8La+eZvCj8+GmC98c24mdYvAYzBLFDpmWiQTeuxNkPmWs3/nWj9lYVuWjMjZtyF+wXfnwuqSTW/WUBcjVQaebANp4i0koMzBc0HmGDXry1ljeIDHfxGJKWtsGs/DfD91QlBaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732296579; c=relaxed/simple;
	bh=KQkPFztCcDV7zdWXKgZKGZBN8iACqDcgshPTqQ6/mtM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bBJMAf2kQWVzIpxMlEoYmKTZg2sVWlYgGWKSV6cuKIKSlmdthu7r6wV3xIVdS8/aO/j+jtTQCCOcQRna5v2WiyeyIZbyHiXMXGe4VtHMPNE/izqDzi7NF3aXKisEA7mvMBsNBIH3UKkW61X1r4rzhWM1P9eAhKqAdtLJiWPXDsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEV7aYQs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5892C4CECE;
	Fri, 22 Nov 2024 17:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732296578;
	bh=KQkPFztCcDV7zdWXKgZKGZBN8iACqDcgshPTqQ6/mtM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VEV7aYQsjkdF7yNiLEGZTq8gM+OuaHI3MaiW3+Uh6B/pxUAbSEPp9PkS4gB7KgXzw
	 ae80qO17LuJPdMtL9vqGj3pWlH+AYyGpH0qV2p61DPKWlPBtSHKIwRs//8Lrm2Luv6
	 mcN0GpzhK0SYnHzqtGg8B+lASd19mDUIES2j3IilHHElzL9vEsJoYxGi+HZtBjT87A
	 kmziBNwfQQmCo341Td6v3Iguy01GA5ASUFq9l4qv9TlurswPLB0EkZEOrz3z+sDysP
	 utUvrTrBdaVcTYRpgjI+K/CU6GDSQ6hn1A3/H52k2RRY58iGM0d6LCIXeQXBbq8Vlx
	 H1/5jJydzC8OA==
Date: Fri, 22 Nov 2024 09:29:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shuah <shuah@kernel.org>
Cc: Tim.Bird@sony.com, linux-kselftest@vger.kernel.org,
 workflows@vger.kernel.org
Subject: Re: [RFC v2] MAINTAINERS: split kselftest entry into 'framework'
 and 'all'
Message-ID: <20241122092937.6e63d488@kernel.org>
In-Reply-To: <cb5d1253-6b52-4c77-9022-7f4e6e50377c@kernel.org>
References: <20241115200912.1009680-1-kuba@kernel.org>
	<8192e307-b2b9-4c48-87e2-31073c084218@linuxfoundation.org>
	<20241118132324.3248c97d@kernel.org>
	<cb5d1253-6b52-4c77-9022-7f4e6e50377c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Nov 2024 07:56:25 -0700 Shuah wrote:
> > To me the dissonance between your admission that people don't CC the
> > current list (IOW status quo isn't great) and the resistance to change
> > is fairly apparent. But it is obviously your call.  
> My thinking is that people don't seem to CC the one mailing list
> we have and adding one more would add to the problem.
> 
> Are there other ways to solve the problem by using prefix like
> we do now for subsystem tests: selftests:framework?

I think the ideal solution would be to let people subscribe to code
paths rather the deal with mailing lists in the first place :(
That way we can fix this on the "mailing list backend" rather than
expecting people who submit code to do the right thing.

Konstantin did some work on auto-CC based on get_maintainer output,
whether vger would just fill in the missing CCs, but AFAIR he got stuck
on the need to modify headers which would break DKIM.

I should mention that lore/lei does support filtering / subscribing 
to paths etc, but from experience bringing folks into upstream
reviews - running lore/lei doesn't work for everyone. I also don't 
use it because it doesn't support the mbox format of my MUA :(

At the current state of affairs, since we can't fix the "receiver" side
easily, we have to shift the responsibility on the "sender" side.
Hope people run get_maintainer, and have well defined lists..

