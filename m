Return-Path: <linux-kselftest+bounces-3152-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FD38309E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 16:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 770991F23745
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 15:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC05121A05;
	Wed, 17 Jan 2024 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRvN89fy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26D11DFCA;
	Wed, 17 Jan 2024 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705505998; cv=none; b=eY+ZVRSaPIBv3S/RbBqLG9zBUQK418+6UHzY/7x9KaCvQ/geKX8dRR/GjE2ReZkuOAMom+UdDDmi6Hrnju9MRHuIL3DNvCGdt5d95mbNe51fXHqiVhy3odhzGa7aXnEZzgYtfo88VpuK7dEPwPJmnQi2MwK4lhjny7VrBUpXMtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705505998; c=relaxed/simple;
	bh=Mrzf0S4QoA53jQW73OsDytgZ14E4MCArNPlJZXPSAew=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=BU4tdKZK90OXfWCkST9dtY7olv6TQRkSQMnGzINW1tQQtbmq1blwxsgulZAi7CDWbrKO73UGkRRH7DUkusuQzOPuzeWVyGeygYtPTJzUQX4jbLpepXs+HS6uB4ngUmj+yhndJNFn+bpQEqm28CHh+Ea3Ae1LnnKgER9wQPnRMew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRvN89fy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C61C433C7;
	Wed, 17 Jan 2024 15:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705505998;
	bh=Mrzf0S4QoA53jQW73OsDytgZ14E4MCArNPlJZXPSAew=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pRvN89fywnijTPoh9VUHSTvtLGEhTYwGppyXRPt7eQeJ26MscCNT6EmzcNL6RG5fE
	 iDns7LCSB/B5vXqFVATEtuQmMftHP0D6IyDj94e+MUDgWjfRuBVDFOOvB07ZXE61sI
	 GGoZb9i+dg5pkh5rOZ3PRW7yiSm8kreDRE8Dqj9iRCKssfny3G2E4jT5gE8O8RMmAN
	 3viC8mwjzj5yPnUrJX4O5yS3oxqljfcMfpoiWpKTrIDnw3YJYPEbh/lghdiaIh+3ne
	 sCLehFpg2/XLdBhS5ANih4/P5Wn8a83JTse94udYzQCErcCydF3CrzcMNKj+ofijax
	 4xar33/fueGjg==
Date: Wed, 17 Jan 2024 07:39:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 shuah@kernel.org, jiri@resnulli.us, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: netdevsim: add a config file
Message-ID: <20240117073957.783fbe2a@kernel.org>
In-Reply-To: <9716ed0c1a9f06256d42ed493cda6b7a43cdaee2.camel@redhat.com>
References: <20240116154311.1945801-1-kuba@kernel.org>
	<397aaa82985c749f03d0c6dc034e479d49df1b32.camel@redhat.com>
	<20240116103430.600fdb9c@kernel.org>
	<9716ed0c1a9f06256d42ed493cda6b7a43cdaee2.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jan 2024 10:32:19 +0100 Paolo Abeni wrote:
> > Even if we force kill it after we see a crash
> > I didn't see in the docs how to continue testing from a specific
> > point.  
> 
> I think something like the following should do:
> 
> cd tools/testing/selftests
> make TARGETS="net drivers/net/bonding <...full relevant targets list>" O=<kst_dir> install
> cd <kst_dir>
> 
> ARGS=""
> for t in $(./run_kselftest.sh -l| sed -n '/<test name>/,$p'); do
> 	ARGS="$ARGS -t $t"
> done
> ./run_kselftest.sh $ARGS # run all tests after <test name>
> 
> Probably it would be nice to add to the kselftest runner the ability to
> check for kernel oops after each test and ev. stop.

I wasn't aware there's a way to list tests! That should work well
enough we can run them one by one with make, that's fine.

./run_kselftest.sh only seems to work for installed tests, tho,
in tree it says:
./run_kselftest.sh: Could not find list of tests to run (~linux/tools/testing/selftests/kselftest-list.txt)
So perhaps the wishlist item would be "make list_tests"?

