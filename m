Return-Path: <linux-kselftest+bounces-36532-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A03AF8E0F
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 11:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 453674A310D
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 09:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0873D2EA46C;
	Fri,  4 Jul 2025 09:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="jVCWmOYm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from jpms-ob01-os7.noc.sony.co.jp (jpms-ob01-os7.noc.sony.co.jp [211.125.139.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9F42BEFE2;
	Fri,  4 Jul 2025 09:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.139.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751620041; cv=none; b=KG3DWcLJ64ulIid0Vs51Ns70Wb0LB1H7JxZf/qy0QW3rdAU70KCTXp/VJrZyYV95r41w+MxVY9qKGhVHoGRWNdLvV5Y5FsEVXap0iZfduOzoEbBlhRvBRQhjOIEzwxmu7KzBkq2P9Q/h8YiRYyNYWXvy8Y0v8iHAZ2djXy7pjRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751620041; c=relaxed/simple;
	bh=n0W3S+BRQ8k/BssGRmGFb5TiMCTQPADsA5/ZErUq4pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhZx/AeGz0UlYzici1Yv7OMgSzi6TrTHoMlq6b1dUtUobZTljqAPfL+xKCA6BStPEluHYE8lNVKTMO9FIgDjxCVgDgkyBjFu4eWaOFdD4t9isghqOABQjrXic1QPuxfoaYd25d1BWKRP1va2IwQp1NqQNKWioJJIfhlqSBY8Sw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=fail smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=jVCWmOYm; arc=none smtp.client-ip=211.125.139.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1751620039; x=1783156039;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8X98rHJnNI81bCfKr7mPTnKQ7asBKAxpOZ/sD34yX/8=;
  b=jVCWmOYmVVoxMHJXTugDEKvQZnVb00NDxqnki8fOnJgPDOmWyXt8pKQx
   gEHk7vAS9pwYjxQfnW3AgYJm6HS1OdE3o5Yf6lbBqokuOXpndJS/9iUwi
   E7glNTeuZkHwk34X0EQK6aFvfuocamJbgdRekCcsJtrpqZYyffF4npcLN
   dPj0CMatXaYXrisuvaV793pVYT3N6HyUx/EOBHwLmgpjcXLjuLpGcE/SP
   V7KbWEIYZ9Y761/aum6kxCTaNlepWcrog/IQeKX9yQo2SP3AxJrwgL+vS
   /YbyoY2TAyaTQLXW11BVlWKR+gDKXdkQMDPuhuaL1QquopShVGN118vOM
   A==;
Received: from unknown (HELO jpmta-ob02-os7.noc.sony.co.jp) ([IPv6:2001:cf8:acf:1104::7])
  by jpms-ob01-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 18:07:15 +0900
X-IronPort-AV: E=Sophos;i="6.16,286,1744038000"; 
   d="scan'208";a="4682959"
Received: from unknown (HELO JPC00244420) ([IPv6:2001:cf8:1:573:0:dddd:eb3e:119e])
  by jpmta-ob02-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 18:07:14 +0900
Date: Fri, 4 Jul 2025 18:07:12 +0900
From: Shashank Balaji <shashank.mahadasyam@sony.com>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shinya Takumi <shinya.takumi@sony.com>
Subject: Re: [PATCH v2] selftests/cgroup: improve the accuracy of cpu.max
 tests
Message-ID: <aGeZwLAuysAmyX-q@JPC00244420>
References: <20250701-kselftest-cgroup-fix-cpu-max-v1-0-049507ad6832@sony.com>
 <20250703120325.2905314-1-shashank.mahadasyam@sony.com>
 <l3sal6zkvo4lqnfs6fepxytnrmqmqwfvtxudnjm53oigtuatpd@7czfeursgwyh>
 <aGcf0Prl-hVX2j4Q@JPC00244420>
 <aGd5lrUvm9Bhh-b8@JPC00244420>
 <wnoymxwdikh6iawrcvhewq6er4si75oqzjdbibhl6n57swq3ff@glkzfmbaots7>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <wnoymxwdikh6iawrcvhewq6er4si75oqzjdbibhl6n57swq3ff@glkzfmbaots7>

Hi Michal,

On Fri, Jul 04, 2025 at 10:59:15AM +0200, Michal Koutný wrote:
> On Fri, Jul 04, 2025 at 03:49:58PM +0900, Shashank Balaji <shashank.mahadasyam@sony.com> wrote:
> > > 1. We don't need to separately check user_usec because it'll always be
> > > less than user_usec^W usage_usec, and usage_usec is what's directly
> > > affected by throttling.
> 
> When kernel is not preemptible, I'd expect the system time may more
> easily excess the quota, so I considered the user_usage check less prone
> to false results. But...
> 
> > > 2. I changed the >= to > because, not that it'll ever happen, but we can
> > > let usage_usec = expected_usage_usec pass. Afterall, it's called
> > > "expected" for a reason.
> > 
> > Hmm, here is something interesting. The following patch adds printfs to the
> > existing code to see what user_usec, usage_usec, the expected_usage_usec used in
> > the code, and the theoretical expected_usage_usec are. On running the modified test
> > a couple of times, here is the output:
> 
> ...thanks for checking. I was misled by the previous test implementation
> (the expected_usage_usec had no relation to actual throttled usage in
> there). What you observe is thus likely explained by the default
> sched_cfs_bandwidth_slice (5 times the tested quota) and CONFIG_HZ.
> 
> So I'd say keep only the two-sided tolerant check. (I want to avoid the
> test to randomly fail when there's no gaping issue.)

Yep, patch v2 is doing just that. So, I assume I have your Acked-by?

Thanks

Shashank

