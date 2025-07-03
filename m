Return-Path: <linux-kselftest+bounces-36366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39794AF6744
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 03:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 878524A7EA6
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 01:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7965D15853B;
	Thu,  3 Jul 2025 01:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="r6Iy0lyY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from jpms-ob02-os7.noc.sony.co.jp (jpms-ob02-os7.noc.sony.co.jp [211.125.139.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EC724B26;
	Thu,  3 Jul 2025 01:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.139.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751506891; cv=none; b=PoIX/QYCyGAls1yzkY/+G00f57KpcjkpnHR190fD5wjUYoQuRTaCqaBpTtLChnF9Z1yFAhBIzK34ffvI35aOUWdnRphIIl4eH0bOXpCw94WNHfeF+YGYXOs8bBl0bHIt77n6qfEnNNyduOjNu/mJGtD39CjOqpNBf/ApFDOT7fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751506891; c=relaxed/simple;
	bh=2EceiW0EBoYu3OMAf0fB5Q4prjSjyExozqB+r6b+7U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVUTJmIG9VrDPaeR2W7JXlp9GCr/A62viL4G2gWDOudI+zijhDCwaaF3y8j1Yuc68J0u7Lm2ELTbuZkVm0bOUK121UjhOmk7M3zh8K4iKV9iDTD1z35brVx0z5Z1rfSH4/JtOtES0zpL33/gjkuGgVageeEMo86OCyw3eAUK+ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=fail smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=r6Iy0lyY; arc=none smtp.client-ip=211.125.139.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1751506888; x=1783042888;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=BCu3mx1TAsqBn24Mp2CrmUIIO7P1rfXinDh/8nC5uu8=;
  b=r6Iy0lyY+NtmiQJkIdhiS5tNGC6ZHUlaNGbxsGncN6N5Xc8Hdci3u8Jw
   wS4KvHT8a9R3w/z01+v3+ao5/zYw4oCLBYRfIP0Hcud1+eIzC1nmpRsLx
   FwmEb7ubvtYbpB4c7x8JwCwjQvMflNnZA8CuS5xzKSvYmzUBL3/JDOvVm
   tDZmHAUNdH9B0eqjUN5mDwvDuUKwU4+voXTH6dZuR7Wk55J06778tby/r
   ZW6uK3g+iCFz2dNBl1pskx8JMJ42CMWihAA72JrMUjonT7IOtKBlHPFME
   2iZ6/ilzsm/ZXDnCEe7FJpBomQ1T87SLRmH1e7Ev/Xg19OMW0ndYDfvjO
   g==;
Received: from unknown (HELO jpmta-ob02-os7.noc.sony.co.jp) ([IPv6:2001:cf8:acf:1104::7])
  by jpms-ob02-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 10:41:21 +0900
X-IronPort-AV: E=Sophos;i="6.16,282,1744038000"; 
   d="scan'208";a="4014289"
Received: from unknown (HELO JPC00244420) ([IPv6:2001:cf8:1:573:0:dddd:eb3e:119e])
  by jpmta-ob02-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 10:41:21 +0900
Date: Thu, 3 Jul 2025 10:41:17 +0900
From: Shashank Balaji <shashank.mahadasyam@sony.com>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shinya Takumi <shinya.takumi@sony.com>
Subject: Re: [PATCH 0/2] selftests/cgroup: better bound for cpu.max tests
Message-ID: <aGXfvfKOjWlH3d0q@JPC00244420>
References: <20250701-kselftest-cgroup-fix-cpu-max-v1-0-049507ad6832@sony.com>
 <4bqk62cqsv3b4sid76zf3jwvyswdym7bl5wf7r6ouwqvmmvsfv@qztfmjdd7nvc>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4bqk62cqsv3b4sid76zf3jwvyswdym7bl5wf7r6ouwqvmmvsfv@qztfmjdd7nvc>

Hi Michal, 

Thanks for the reply!

On Wed, Jul 02, 2025 at 02:34:29PM +0200, Michal Koutný wrote:
> Hello Shashank.
> 
> On Tue, Jul 01, 2025 at 11:13:54PM +0900, Shashank Balaji <shashank.mahadasyam@sony.com> wrote:
> > cpu.max selftests (both the normal one and the nested one) test the
> > working of throttling by setting up cpu.max, running a cpu hog process
> > for a specified duration, and comparing usage_usec as reported by
> > cpu.stat with the duration of the cpu hog: they should be far enough.
> > 
> > Currently, this is done by using values_close, which has two problems:
> > 
> > 1. Semantic: values_close is used with an error percentage of 95%, which
> >    one will not expect on seeing "values close". The intent it's
> > actually going for is "values far".
> > 
> > 2. Accuracy: the tests can pass even if usage_usec is upto around double
> >    the expected amount. That's too high of a margin for usage_usec.
> > 
> > Overall, this patchset improves the readability and accuracy of the
> > cpu.max tests.
> > 
> > Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
> 
> I think you're getting at an actual bug in the test definition. 
> 
> I think that the test_cpucg_max should either run hog_cpus_timed with
> CPU_HOG_CLOCK_PROCESS instead of CPU_HOG_CLOCK_WALL to make sense or the
> expected_usage_usec should be defined with the configured quota in mind
> (i.e. 1/100).  (The latter seems to make the test more natural.)

Going with the more natural way of sticking to CPU_HOG_CLOCK_WALL, the
second patch does calculate expected_usage_usec based on the configured
quota, as the code comment explains. So I'm guessesing we're on the same page
about this?

> With such defined metrics, the asserted expression could be
> 	values_close(usage_usec, expected_usage_usec, 10)
> based on your numbers, error is around 20% so our helper's argument is
> roughly half of that. (I'd be fine even with err=20 to prevent some
> false positives.)
> 
> I think those changes could even be in one patch but I leave that up to
> you. My comment to your 2nd patch is that I'd like to stick to relative
> errors and keep positive values_close() predicate that's used in other
> selftests too. (But those 95% in the current code are clumsy given two
> different qualities are compared.)

Do you mean something like,

	if (values_close(usage_usec, expected_usage_usec, 10))
			goto cleanup;

using the positive values_close() predicate. If so, I'm not sure I
understand because if usage_usec and expected_usage_usec _are_ close,
then we want the test to pass! We should be using the negative
predicate.

And sure, I'll send v2 as a single patch.

Thanks

Shashank

