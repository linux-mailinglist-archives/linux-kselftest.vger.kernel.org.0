Return-Path: <linux-kselftest+bounces-13812-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6EE93328E
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 22:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6654283145
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 20:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E9A558BB;
	Tue, 16 Jul 2024 20:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOyw+RBf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1652023A8;
	Tue, 16 Jul 2024 20:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721160014; cv=none; b=fPOWjQRae02gaYiKfVQPcaXb8TaxcQcwOtmBv1nkDQpW9GsibPOB09NH8JgMxVEpK+F0LtK4muttwKgui/UtflEqunSZSMC4awB2leuiPuyFbe6L17wsLREhTHv8eCERUvDA4lnWWhqRWLQBuCa4B9K9h6j9ffBX/JUeaNHMn/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721160014; c=relaxed/simple;
	bh=LG/ZQBmXs9SpQQ+bru2nCXgrnDzPPVQlvlMF6cqC2gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UygnmTnD04bIM8PWr9PeZY01P6xp2moVbant2SrdAUb+fmL43j18t1R6D9EQaLYsKpInfvzKTAfKFBjqRGRCYUZg3wJyweC0D2raNZhMtBohmSsPRHpocOnGHVWYIO8JcQkemy2vJc16Mf6FaL6HN6sNoj1cHTnwGHhYWDeExIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOyw+RBf; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3cabac56b38so3876624b6e.3;
        Tue, 16 Jul 2024 13:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721160012; x=1721764812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0A5eNeu1koPgDi+YMtCXJr0UJyxu69RXmGV7v4l255I=;
        b=UOyw+RBfTb/DP8zK6nHBFDbt5TFRLzhO88z4oo2wAEwdmwo0qDXyuPY0gZQ2FE4Vsx
         jXDLIJGofK5OhfG+sd/edvM7mQVL5TtjqwN21y3SbjKSfNA+QmxIA6Gc8xtXx+jywatB
         XtnUvdYSerOK6uPAcWrFQOOabccATT7OlR6VuyVJIeEU/z2cvsJBPu/LPV9WWDNvkLmk
         cqkzb76yIwMdoG/53qbVIzdRgDsXi8WVrqMeB9jbtBl5k5INX2eGD1SIxqKCULMFmXfX
         en9rFcPmUtzyiaVz2Aw2rGbRTOwJV3v2AL+wS/UVi2dVRAxAjy0ErDRUFOpTSV3aO0Eb
         KIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721160012; x=1721764812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0A5eNeu1koPgDi+YMtCXJr0UJyxu69RXmGV7v4l255I=;
        b=kixcbSpu7HkUZEgdGcyINdoFixaDziljsKw+MwtnTIphfwzpJMJuKSq708awKxDyiw
         CUZnIGnPj5wXBrYB3iE+gVjnvWHPjYouKurkpF0PO64sh5GBQOj1++YguSaXyoShG5x5
         tmN4/h94zsqtT1lHByWgpZOZVFnrgg3uw5qK1fq4iL3bBit9UUdGbV9h9dPu8svFYobG
         HGwyEiAR4ZhVXWKHKkiRD/IgjtHsoIg+5O/MbAe3v1T3rWljzijjtPlCf7F47OUiLMit
         xI1ErIfHEEYO7Ltn3A7XqPRTOt9rO8le2jNmwwKlrpYEdb1pUhFvpnWjwGbLvne82nWg
         hfwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVb/AWrXAQ5Bnhs5hMFFXeLrBJtywpdh1NncOMUEyaWS1aHOVX2w37gX3v7EiGKqnpPx9GCddK/y0YYCfImZrzHDQpy4iFvWK/X8yggEcvSI4neYmZceuYEe1F02AGorsF7Xkr1G+mkY27PjXMotmtaTWAoeChJguddZxHBh6gEpyR9UQ==
X-Gm-Message-State: AOJu0YxRBAq7Yq/wTNznpOnEOdSndRtS2VuqKabM8Bp+hxa/BegvrBX7
	sX1NQ5vzzx3ZDvg2K/+mQCs9BDq1INloiztKNkxrCVhzxF2vULWO
X-Google-Smtp-Source: AGHT+IF/MPQE8ZNQ6Zj3W4mfQ7FqcdlhVcA5/FWQ02lDg3e7Ex4EoBWszBDbyZ/WyYrEnG6vXLAAmQ==
X-Received: by 2002:a05:6358:339a:b0:1aa:c9ba:4336 with SMTP id e5c5f4694b2df-1ac90325cffmr324198455d.3.1721160011871;
        Tue, 16 Jul 2024 13:00:11 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-78e386d7d14sm4384150a12.73.2024.07.16.13.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 13:00:11 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 16 Jul 2024 10:00:10 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: David Finkel <davidf@vimeo.com>, Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, core-services@vimeo.com,
	Jonathan Corbet <corbet@lwn.net>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
Message-ID: <ZpbRSv_dxcNNfc9H@slm.duckdns.org>
References: <20240715203625.1462309-1-davidf@vimeo.com>
 <20240715203625.1462309-2-davidf@vimeo.com>
 <ZpZ6IZL482XZT1fU@tiehlicka>
 <ZpajW9BKCFcCCTr-@slm.duckdns.org>
 <Zpa1VGL5Mz63FZ0Z@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zpa1VGL5Mz63FZ0Z@tiehlicka>

Hello,

On Tue, Jul 16, 2024 at 08:00:52PM +0200, Michal Hocko wrote:
...
> > If we want to allow peak measurement of time periods, I wonder whether we
> > could do something similar to pressure triggers - ie. let users register
> > watchers so that each user can define their own watch periods. This is more
> > involved but more useful and less error-inducing than adding reset to a
> > single counter.
> 
> I would rather not get back to that unless we have many more users that
> really need that. Absolute value of the memory consumption is a long
> living concept that doesn't make much sense most of the time. People
> just tend to still use it because it is much simpler to compare two different
> values rather than something as dynamic as PSI similar metrics.

The initial justification for adding memory.peak was that it's mostly to
monitor short lived cgroups. Adding reset would make it used more widely,
which isn't necessarily a bad thing and people most likely will find ways to
use it creatively. I'm mostly worried that that's going to create a mess
down the road. Yeah, so, it's not widely useful now but adding reset makes
it more useful and in a way which can potentially paint us into a corner.

But then again, maybe this is really niche, future usages will still remain
very restricted, and adding something more akin to PSI triggers is way
over-engineering it.

Thanks.

-- 
tejun

