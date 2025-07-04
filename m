Return-Path: <linux-kselftest+bounces-36491-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E54F8AF84D0
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 02:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44769560009
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 00:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8308CEEB2;
	Fri,  4 Jul 2025 00:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="GRRE+5iu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from jpms-ob02-os7.noc.sony.co.jp (jpms-ob02-os7.noc.sony.co.jp [211.125.139.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E856D17;
	Fri,  4 Jul 2025 00:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.139.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751588823; cv=none; b=JHPrrm5+KgVDQyay7KqY4wRmF2ug89i5CkKwoc31v3Zz/EAXnc9LvxBh7d7IqW1qUSQgwFLLd9zYbMDCusUxGF8auFaI6VtFic1KtvPHYO6nDKcMHoqSZPdWLXw96ZnrubNZHOzIwrB6YBRB4AyrsOcQt/D/WqNXk4/Cc714Cy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751588823; c=relaxed/simple;
	bh=BSzohEbES7uLxAvGJxNFa60vU3v/GMbyjfN5SySMFXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHOX/QLFeR3MPVHI5CpZ2uUxYMQUiFgXH4yF4VdjLXEoM5JOGGPu3rFLhhwlFX3g1I97GIK2bj3pTwxIv0n7SquLfMsNm6sP5UeRfaqIq6OTk+5T8b+N+tYM+zZUl5mpYDiYQX4xMUklSag/eluCyTaIN4GdtRcX/3OP90d3bVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=fail smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=GRRE+5iu; arc=none smtp.client-ip=211.125.139.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1751588821; x=1783124821;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=rH/YAVAFRBh1vpkwFj/70i6IUSEQ9hEzAcVy+/le/Uc=;
  b=GRRE+5iuV3gRXrjQ5o+vn4+vYw/WcslH8ZlJe1gqAt7LuOCmTcuaHnST
   +8T1ToDGSfXoEXHRTDFvtBzwVYyXSvgwpmDdKCiqED43cjFN5ify1Ep+e
   ygdS+ky97eH7Ep3/aaFd3SJcmHK/6wr/d4G7pI6t/TbUG/0Nnf4slV+R0
   ZZe9nxK3rKS4/1+H5Uw7tedN7p2qv9GeG7rHsgKwYwYyXxk75IczugmCv
   bxZFQ+B392Q+2LcOk3JE5NCXODhmAkIojjpAdfqby9fGwJh+ikJ67fiuS
   KRyVWNwfjFQKXh1gi72+536MV3UFOLDCBLIEodkYR1OkPmjTcjVoByjPp
   A==;
Received: from unknown (HELO jpmta-ob02-os7.noc.sony.co.jp) ([IPv6:2001:cf8:acf:1104::7])
  by jpms-ob02-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 09:26:59 +0900
X-IronPort-AV: E=Sophos;i="6.16,285,1744038000"; 
   d="scan'208";a="4466966"
Received: from unknown (HELO JPC00244420) ([IPv6:2001:cf8:1:573:0:dddd:eb3e:119e])
  by jpmta-ob02-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 09:26:58 +0900
Date: Fri, 4 Jul 2025 09:26:56 +0900
From: Shashank Balaji <shashank.mahadasyam@sony.com>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shinya Takumi <shinya.takumi@sony.com>
Subject: Re: [PATCH v2] selftests/cgroup: improve the accuracy of cpu.max
 tests
Message-ID: <aGcf0Prl-hVX2j4Q@JPC00244420>
References: <20250701-kselftest-cgroup-fix-cpu-max-v1-0-049507ad6832@sony.com>
 <20250703120325.2905314-1-shashank.mahadasyam@sony.com>
 <l3sal6zkvo4lqnfs6fepxytnrmqmqwfvtxudnjm53oigtuatpd@7czfeursgwyh>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <l3sal6zkvo4lqnfs6fepxytnrmqmqwfvtxudnjm53oigtuatpd@7czfeursgwyh>

Hi Michal,

On Thu, Jul 03, 2025 at 05:58:48PM +0200, Michal Koutný wrote:
> On Thu, Jul 03, 2025 at 09:03:20PM +0900, Shashank Balaji <shashank.mahadasyam@sony.com> wrote:
> > Current cpu.max tests (both the normal one and the nested one) are inaccurate.
> > 
> > They setup cpu.max with 1000 us quota and the default period (100,000 us).
> > A cpu hog is run for a duration of 1s as per wall clock time. This corresponds
> > to 10 periods, hence an expected usage of 10,000 us. We want the measured
> > usage (as per cpu.stat) to be close to 10,000 us.
> > 
> > Previously, this approximate equality test was done by
> > `!values_close(usage_usec, duration_usec, 95)`: if the absolute
> > difference between usage_usec and duration_usec is greater than 95% of
> > their sum, then we pass. This is problematic for two reasons:
> > 
> > 1. Semantics: When one sees `values_close` they expect the error
> >    percentage to be some small number, not 95. The intent behind using
> > `values_close` is lost by using a high error percent such as 95. The
> > intent it's actually going for is "values far".
> > 
> > 2. Bound too wide: The condition translates to the following expression:
> > 
> > 	|usage_usec - duration_usec| > (usage_usec + duration_usec)*0.95
> > 
> >   	0.05*duration_usec > 1.95*usage_usec (usage < duration)
> > 
> > 	usage_usec < 0.0257*duration_usec = 25,641 us
> > 
> >    So, this condition passes as long as usage_usec is lower than 25,641
> > us, while all we want is for it to be close to 10,000 us.
> > 
> > Fix this by explicitly calcuating the expected usage duration based on the
> > configured quota, default period, and the duration, and compare usage_usec
> > and expected_usage_usec using values_close() with a 10% error margin.
> > 
> > Also, use snprintf to get the quota string to write to cpu.max instead of
> > hardcoding the quota, ensuring a single source of truth.
> > 
> > Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
> > 
> > ---
> > 
> > Changes in v2:
> > - Incorporate Michal's suggestions:
> > 	- Merge two patches into one
> > 	- Generate the quota string from the variable instead of hardcoding it
> > 	- Use values_close() instead of labs()
> > 	- Explicitly calculate expected_usage_usec
> > - v1: https://lore.kernel.org/all/20250701-kselftest-cgroup-fix-cpu-max-v1-0-049507ad6832@sony.com/
> > ---
> >  tools/testing/selftests/cgroup/test_cpu.c | 63 ++++++++++++++++-------
> >  1 file changed, 43 insertions(+), 20 deletions(-)
> 
> 
> > -	user_usec = cg_read_key_long(cpucg, "cpu.stat", "user_usec");
> > -	if (user_usec <= 0)
> > +	if (usage_usec <= 0)
> >  		goto cleanup;
> >  
> > -	if (user_usec >= expected_usage_usec)
> > -		goto cleanup;
> 
> I think this was a meaningful check. Not sure if dropped accidentally or
> on purpose w/out explanation.
> 
> After that's addressed, feel free to add
> Acked-by: Michal Koutný <mkoutny@suse.com>

Sorry about that. I dropped it accidentally. This check should be okay,
right?

	if (usage_usec > expected_usage_usec)
		goto cleanup;

1. We don't need to separately check user_usec because it'll always be
less than user_usec, and usage_usec is what's directly affected by
throttling.
2. I changed the >= to > because, not that it'll ever happen, but we can
let usage_usec = expected_usage_usec pass. Afterall, it's called
"expected" for a reason.

Thanks

Shashank

