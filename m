Return-Path: <linux-kselftest+bounces-19753-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EA199F33A
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 18:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0362B22EE8
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 16:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2041F76C9;
	Tue, 15 Oct 2024 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFW+sTyt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B7E1F6668;
	Tue, 15 Oct 2024 16:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729010924; cv=none; b=pCttVxgXhvuRJ9jQyB/zObLofYPQE6dRrtklo0MmDb5I4f2iniHjhrcaxTgsRY1l6E9/asKhXxyi77t0GcaXCKujooj4eU5vohTLjMG34ijXgRbmedJaMNJoPwztPKYFfkWup8PbOiur2R+TZeFy/UgEwaKdFzNI+5jG4zOWES0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729010924; c=relaxed/simple;
	bh=sZgmHv7WOct0dDmINL6cHDdyXXKW+oXErjp5naFf/J0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z37400ZlgIDQNnNQnSoIOMRGrBHX8jSBHm9yuIuOVhn7VxcKjHJ5mrTJcOf1vL2m8Y0sZhTtHwf97/qZFhcfq0ZioYZjKMLfawGBlGwQeNYc2MWaT8L4BzQRt59x/jsbI/FcL1rSG41bqhC9tGReRyumbCuk3VTGhyQVzO5W4CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFW+sTyt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77303C4CEC6;
	Tue, 15 Oct 2024 16:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729010923;
	bh=sZgmHv7WOct0dDmINL6cHDdyXXKW+oXErjp5naFf/J0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qFW+sTyt9jCaEfWRHArr3mg7h1ao/4pKK7jjNpoj0x5N7luTViZAMm3nMTnyAxVCP
	 FDBIofWjYfFfpPl/xnHx/c1EXE4H/K1v8VpBw3O5mXMwD6LWiXPRxadMzIyXQdWDnQ
	 +zKN4Ibkxnq97wR3x9fOjM8dGTB3BuDojgr1Vtaa5HbJ7Yw30XXVLF5jmtucELlZyT
	 XNvvRzM7lO20E1iR4XsXNFPRzYHRY0rtfKIWQJhqLtZz1XY6XvXyLB5pX+HUt9tWne
	 fVAanrU6EdYrhF40Y/fMX2fZGcnXhBuhArcypBAJCLO4OVO6waesUXc4zDiZhmt8d+
	 PyNGHNQCRDD2A==
Date: Tue, 15 Oct 2024 09:48:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>, Liam Howlett
 <liam.howlett@oracle.com>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "mingo@redhat.com"
 <mingo@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>,
 "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
 "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
 "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>, "bsegall@google.com"
 <bsegall@google.com>, "mgorman@suse.de" <mgorman@suse.de>,
 "vschneid@redhat.com" <vschneid@redhat.com>, "jiri@resnulli.us"
 <jiri@resnulli.us>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>, "shuah@kernel.org" <shuah@kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, Pei Li
 <peili.io@oracle.com>
Subject: Re: [PATCH net-next v1 0/3] Threads support in proc connector
Message-ID: <20241015094841.2acd5a50@kernel.org>
In-Reply-To: <1CCDA7B3-F43B-485A-9950-85AA272D79B1@oracle.com>
References: <20241013170617.2139204-1-anjali.k.kulkarni@oracle.com>
	<20241015090148.72e83f7f@kernel.org>
	<1CCDA7B3-F43B-485A-9950-85AA272D79B1@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Oct 2024 16:22:24 +0000 Anjali Kulkarni wrote:
> Thank you! However, looking at the MAINTAINERS file,
> drivers/connector/ is listed under NETWORKING DRIVERS.
> Hence sending on net-next is the most appropriate place?   

Hm. It was done relatively recently in

commit 46cf789b68b25744be3dc99efd4afce4a5381b5c
Author: David S. Miller <davem@davemloft.net>
Date:   Thu Sep 10 08:40:13 2020 -0700

    connector: Move maintainence under networking drivers umbrella.
    
    Evgeniy does not have the time nor capacity to maintain the
    connector subsystem any longer, so just move it under networking
    as that is effectively what has been happening lately.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

There wasn't much development in this code for a long while,
so I guess it was done just to make sure patches don't fall
thru the cracks. But you seem to be trying to develop it more
actively.

Okay, if nobody else who want to take these patches into their tree
raises their hand - we can try to continue to process the patches,
as long as Peter or someone else with the expertise acks them.

