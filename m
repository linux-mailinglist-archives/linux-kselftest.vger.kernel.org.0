Return-Path: <linux-kselftest+bounces-25390-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D9FA2238F
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 19:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B546818875D3
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 18:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44E41DE2DC;
	Wed, 29 Jan 2025 18:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HYYbS+Q7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9997618FC84
	for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2025 18:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738173894; cv=none; b=TWPX+EaNYmlVeVho9NCKPCAD22zl3d2/J09bfGCpit8KeDio3QJXIedE7C8HGpvrKbSlSksQH2RILALYzU4WNH3PjTYFK1kmPDcO+1sXny15Dz0BAVpmfD9Ivfu5FepPB5RWMVSdEROsNhArgC8jdAwMKC7/iKSyuCqY6c3NZn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738173894; c=relaxed/simple;
	bh=vGUZkzsYJzlfiCbfaQdJIp8peKxgyVJOrV+s+LvLFao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QiuNlrOLbVzhP6tm89oHkAfZZ3/6T/Ynss40Omoquxtq7a8SJsgiGwrCLIcEA9tA8vkyOpEURadinOR9Woz5KowEm7A9w9Q8OsdZ5nRPGYfVaKtVmwoIeOJvpzPQpKlhYwNRQqlzuMd/CvLPMxl1RoXYQuQoxdk6fyHVo4o6hwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HYYbS+Q7; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 29 Jan 2025 13:04:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738173880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9VBTQ1irDiGRVITmSXE+fKQ0+oae2DHults3vu8twLI=;
	b=HYYbS+Q7GOR+CavazC7KLnOa4Bd/kCOu/sV11RSNag2GojNxBtB5LZIhlzVbYA3G3OQEF7
	nTVLV6cdPrt7tcmFwHdVvTtB6t0g4r/5y1QODa2J+n3Yp04sz2u5okZc6k7BjxJebvagE4
	my97jWYC/ROSfNJ5PtDvo2dBYUSZ5xE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-bcachefs@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 11/21] bcachefs: improve the eytzinger0_find_le tests
Message-ID: <ajfehauvtid4d7pqy7o3uhe6p7buohwe542wqddkwpdq62lr4g@6cgcfpzcyag3>
References: <20250128163859.1883260-1-agruenba@redhat.com>
 <20250128163859.1883260-12-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128163859.1883260-12-agruenba@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jan 28, 2025 at 05:38:48PM +0100, Andreas Gruenbacher wrote:
> Rename eytzinger0_find_test_val() to eytzinger0_find_test_le() and add a
> new eytzinger0_find_test_val() wrapper that calls it.
> 
> We have already established that the array is sorted in eytzinger order,
> so we can use the eytzinger iterator functions and check the boundary
> conditions to verify the result of eytzinger0_find_le().
> 
> Only scan the entire array if we get an incorrect result.  When we need
> to scan, use eytzinger0_for_each_prev() so that we'll stop at the
> highest matching element in the array in case there are duplicates;
> going through the array linearly wouldn't give us that.

For test code, wouldn't it be simpler to iterate over the test array,
testing with every element as a search value? There's enough corner
cases in lookup that I think it'd be worthwhile (and probably add some
extra test values, e.g. first/last emelements +1/-1).

> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  fs/bcachefs/util.c | 41 ++++++++++++++++++++++++++++++-----------
>  1 file changed, 30 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/bcachefs/util.c b/fs/bcachefs/util.c
> index 3fe9a3b8c696..c772629783f3 100644
> --- a/fs/bcachefs/util.c
> +++ b/fs/bcachefs/util.c
> @@ -782,29 +782,48 @@ static inline int cmp_u16(const void *_l, const void *_r)
>  	return (*l > *r) - (*r > *l);
>  }
>  
> -static void eytzinger0_find_test_val(u16 *test_array, unsigned nr, u16 search)
> +static void eytzinger0_find_test_le(u16 *test_array, unsigned nr, u16 search)
>  {
> -	int i, c1 = -1, c2 = -1;
> -	ssize_t r;
> +	int r, s;
> +	bool bad;
>  
>  	r = eytzinger0_find_le(test_array, nr,
>  			       sizeof(test_array[0]),
>  			       cmp_u16, &search);
> -	if (r >= 0)
> -		c1 = test_array[r];
> +	if (r >= 0) {
> +		if (test_array[r] > search) {
> +			bad = true;
> +		} else {
> +			s = eytzinger0_next(r, nr);
> +			bad = s >= 0 && test_array[s] <= search;
> +		}
> +	} else {
> +		s = eytzinger0_last(nr);
> +		bad = s >= 0 && test_array[s] <= search;
> +	}
>  
> -	for (i = 0; i < nr; i++)
> -		if (test_array[i] <= search && test_array[i] > c2)
> -			c2 = test_array[i];
> +	if (bad) {
> +		s = -1;
> +		eytzinger0_for_each_prev(j, nr) {
> +			if (test_array[j] <= search) {
> +				s = j;
> +				break;
> +			}
> +		}
>  
> -	if (c1 != c2) {
>  		eytzinger0_for_each(j, nr)
>  			pr_info("[%3u] = %12u\n", j, test_array[j]);
> -		pr_info("find_le(%2u) -> [%2zi] = %2i should be %2i\n",
> -			i, r, c1, c2);
> +		pr_info("find_le(%12u) = %3i should be %3i\n",
> +			search, r, s);
> +		BUG();
>  	}
>  }
>  
> +static void eytzinger0_find_test_val(u16 *test_array, unsigned nr, u16 search)
> +{
> +	eytzinger0_find_test_le(test_array, nr, search);
> +}
> +
>  void eytzinger0_find_test(void)
>  {
>  	unsigned i, nr, allocated = 1 << 12;
> -- 
> 2.48.1
> 

