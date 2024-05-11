Return-Path: <linux-kselftest+bounces-10082-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E66E8C2E62
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 03:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D824BB22FAC
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 01:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FB4BE71;
	Sat, 11 May 2024 01:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VW9GZ6DP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB98DD52E;
	Sat, 11 May 2024 01:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715390592; cv=none; b=VEG+Hsulft+dYX+PmW2K79eXRb9PtwCC3as6bSnaDzFfgYnTjxlemfgUU8/slTXCkRFQ9gL30QRzwC6jlu59nISD7vospyaB1MkM3mXw9LxTt7kyO9IXPyGHLVzPZgI47eQCmRvZtZL1I1ZmEaZxPblX59qYQuamBYF75mkKkKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715390592; c=relaxed/simple;
	bh=lv/ukgoXwoeNdIt6ZCsrBD7oFLj8Ef+OhBYuWC1lN0s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uDmjAoqURmpWxqgdWmZ1m9P/80GEQ7mz83WxVUk7aWP6o1gUikru4Bv1twq2XETpx31+JYIfFmt8s9t57EIIrsiXnNiLDb33aue6krgwkJ20odroxW1Nh6HiZ5TGcp361GOtyCX89WDyVLIavMdAqWGnnlzA3X37M06Xwjq47Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VW9GZ6DP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47D7C113CC;
	Sat, 11 May 2024 01:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715390592;
	bh=lv/ukgoXwoeNdIt6ZCsrBD7oFLj8Ef+OhBYuWC1lN0s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VW9GZ6DPc/bFpX3n0a1Vi6GUlBTCTq2CE4phk09enug1JTgAYHA0dHerS8OInEFt5
	 dz4AeElXSYUo3Ti0Y8wi8BYnhoxfw9+rSFYPIAPLtv9xz6u5t6WROmhM8SfKQK2rJW
	 NuO1R9nOL4eUBh5umiXV7dEYSdPXxyQjt7AM1MTuJf+awR2pFmVAZZALgd5H14xBcB
	 lzJCIkAv/DM+gPWtk8qJQywgDCk7GnpMkx0MXGMC3ZnoUsCtubq4uxxxxA7cBGxkMU
	 sU7OBkQmendq7zXI28BKQpS4iO65BASNx2+Mc11ziG7UNgcwOPFfCuP07o4pgWKrD7
	 j1/TuodI+Bmew==
Date: Fri, 10 May 2024 18:23:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] selftests: net: fix timestamp not arriving
 in cmsg_time.sh
Message-ID: <20240510182310.31be1bf3@kernel.org>
In-Reply-To: <663d8b4e19c1b_13d894294d7@willemb.c.googlers.com.notmuch>
References: <20240510005705.43069-1-kuba@kernel.org>
	<663d8b4e19c1b_13d894294d7@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 09 May 2024 22:49:50 -0400 Willem de Bruijn wrote:
> >  	struct sock_extended_err *see;
> >  	struct scm_timestamping *ts;
> > +	unsigned int ts_seen = 0;  
> 
> nit: mixing unsigned long and unsigned int

Fixed when applying, thanks!

