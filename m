Return-Path: <linux-kselftest+bounces-36533-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8A3AF8E34
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 11:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAF371CA7F66
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 09:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3E52EF9CB;
	Fri,  4 Jul 2025 09:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="Z1pG+42B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from jpms-ob01-os7.noc.sony.co.jp (jpms-ob01-os7.noc.sony.co.jp [211.125.139.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB5B2EF66B;
	Fri,  4 Jul 2025 09:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.139.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751620561; cv=none; b=HwyxoEPzQrvJV8qe/dv2iHxY00A3aqQ9dLX8OAZLG6GmCY8FVBIl29rc1ZovbrySA691XgNBlz2Qu5B0kLYeK/OUzA2Y+2HPFtXH68xvmEJK0bk4VUjoqTyFJwPbM6CzyjgKiFcTDi//FkLfJCli0YFAiSsABXlwqCAAO3dnUL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751620561; c=relaxed/simple;
	bh=5/rnuy+1f9ZFp0QSN91h1vj2LZOYoPBNuzCVHxWsUKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+8tm35dop3kjd/MgfaakFF6ElVYKheKC4q9UHVehgkszTLLVSdjsFMa/pfI7AOx8WEVYk5C57ajli/rME8i7JgCABIdae+97tbd4WTX00YyRySo1AHdzDGZHqHUW7D0lyB1HETqhsmNYH+X7t7miBSWrBTTuiNc0ZFRjY2WSpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=fail smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=Z1pG+42B; arc=none smtp.client-ip=211.125.139.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1751620559; x=1783156559;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=btYJQmsa0mQHvJvl4VaCgrJUwxKb2AyZxRtp+4lLNe0=;
  b=Z1pG+42BTKjwvjfh2S9Vkhjxm8Lf4D56v1zFYocbngBaaF8qT+72hJLE
   KhAQFH6dTcFbc01fIlbtzONMzVteG5iqx44vvWAD69IF9AGrhq4rmx2/H
   q4j4AGvgZN2+UEDXnbylr+OIFtO4PN+E0CLH7o8EMkLgd04obBJ582RU8
   G0JVLougheh/KBsb0bWNiuAWrWH0JU0BU2DVcVhQK9/LC3pFlm0agubIr
   FqkhBGRnw8o/trmGST1jPyO1MQ2d5E+/+CjeL4AvMOALAynU8PRZzAtoP
   tCaMVtnNb79xGDVO/cwImkzQc04nFfS3XfT7Am0mr9UJBz+8qsQZnw50w
   w==;
Received: from unknown (HELO jpmta-ob01-os7.noc.sony.co.jp) ([IPv6:2001:cf8:acf:1104::6])
  by jpms-ob01-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 18:15:56 +0900
X-IronPort-AV: E=Sophos;i="6.16,286,1744038000"; 
   d="scan'208";a="3335550"
Received: from unknown (HELO JPC00244420) ([IPv6:2001:cf8:1:573:0:dddd:eb3e:119e])
  by jpmta-ob01-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 18:15:56 +0900
Date: Fri, 4 Jul 2025 18:15:54 +0900
From: Shashank Balaji <shashank.mahadasyam@sony.com>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shinya Takumi <shinya.takumi@sony.com>
Subject: Re: [PATCH v2] selftests/cgroup: improve the accuracy of cpu.max
 tests
Message-ID: <aGebynaCuASn3t4s@JPC00244420>
References: <20250701-kselftest-cgroup-fix-cpu-max-v1-0-049507ad6832@sony.com>
 <20250703120325.2905314-1-shashank.mahadasyam@sony.com>
 <l3sal6zkvo4lqnfs6fepxytnrmqmqwfvtxudnjm53oigtuatpd@7czfeursgwyh>
 <aGcf0Prl-hVX2j4Q@JPC00244420>
 <aGd5lrUvm9Bhh-b8@JPC00244420>
 <wnoymxwdikh6iawrcvhewq6er4si75oqzjdbibhl6n57swq3ff@glkzfmbaots7>
 <aGeZwLAuysAmyX-q@JPC00244420>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aGeZwLAuysAmyX-q@JPC00244420>

On Fri, Jul 04, 2025 at 06:07:12PM +0900, Shashank Balaji wrote:
> Hi Michal,
> 
> On Fri, Jul 04, 2025 at 10:59:15AM +0200, Michal Koutný wrote:
> > On Fri, Jul 04, 2025 at 03:49:58PM +0900, Shashank Balaji <shashank.mahadasyam@sony.com> wrote:
> > > > 1. We don't need to separately check user_usec because it'll always be
> > > > less than user_usec^W usage_usec, and usage_usec is what's directly
> > > > affected by throttling.
> > 
> > When kernel is not preemptible, I'd expect the system time may more
> > easily excess the quota, so I considered the user_usage check less prone
> > to false results. But...
> > 
> > > > 2. I changed the >= to > because, not that it'll ever happen, but we can
> > > > let usage_usec = expected_usage_usec pass. Afterall, it's called
> > > > "expected" for a reason.
> > > 
> > > Hmm, here is something interesting. The following patch adds printfs to the
> > > existing code to see what user_usec, usage_usec, the expected_usage_usec used in
> > > the code, and the theoretical expected_usage_usec are. On running the modified test
> > > a couple of times, here is the output:
> > 
> > ...thanks for checking. I was misled by the previous test implementation
> > (the expected_usage_usec had no relation to actual throttled usage in
> > there). What you observe is thus likely explained by the default
> > sched_cfs_bandwidth_slice (5 times the tested quota) and CONFIG_HZ.
> > 
> > So I'd say keep only the two-sided tolerant check. (I want to avoid the
> > test to randomly fail when there's no gaping issue.)
> 
> Yep, patch v2 is doing just that. So, I assume I have your Acked-by?
> 
> Thanks
> 
> Shashank

I forgot to add the fixes tags:
Fixes: a79906570f9646ae17 ("cgroup: Add test_cpucg_max_nested() testcase")
Fixes: 889ab8113ef1386c57 ("cgroup: Add test_cpucg_max() testcase")

Should I send a v3 with your ack and the tags?

Thanks

Shashank

