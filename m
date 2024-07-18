Return-Path: <linux-kselftest+bounces-13873-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED019348B4
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 09:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5FE61C2124F
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 07:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D49768E1;
	Thu, 18 Jul 2024 07:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Bx7jI98m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FAC745CB
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Jul 2024 07:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721287305; cv=none; b=XfHfH2g4W9vERGKvG28V53UPSBXGORL3NSM4BiP/h4DekO2aHDeiAzwaA/ZczpnTeFxrDggGGgUpobXIGMTEiV44hSyK4hcAafKtopqdRKq+7YRegPCQFcnl5nDaOnOIMVPdHd7rJBexAnO5O0TLZMz8HDqBYOUm7WLBD1IOpgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721287305; c=relaxed/simple;
	bh=QVa3X98w8qyr8FW0n7dAND2AxvsnqzpDtMSU7c9ZPvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UlGQoar6IkIY1PfYv2niMfUNb7uohFjzFWBWBNOO49vyYyQoeOHaF96J242vBQd/O0GPJ2xRAN90gws9Vlp4ofxNVpV5TvT+2Snz8GYAwPt+0kXKf0A97DbNiK6SWbmXpEOZHoIUBS+P4inzwfxsvT7QVz7YCX9g7Rosxxc8Kjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Bx7jI98m; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-58b0beaf703so440054a12.2
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Jul 2024 00:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721287302; x=1721892102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z36h3EgWdW0oeGo8MwGOQHC0vdVkypcTjZjQ6VZXxVU=;
        b=Bx7jI98m2uAugcAu/DA4b2jO+dWPh7Xsk/BNOnTaz8v7Swj20+Vf+XSsLu2Qqu1an3
         Xpad0rqUtJ5WBN3FdpVz7ofIW+x3XmZYNWFmPfij4rnVAyu3LCmMvFjFnX7KHncEbBXL
         2NbpTsTZTNkQFyoxlvkN539FDzBwfJVfJgMwb7teoetnsVRvWp069jgFlVLZHkRgnxIa
         Lz6VHpD0aof0+rWMNIOOdipFi9yiM0Wd4LJG24DjkmUTSNGvuqDo5CvJ3ToVvBv+18Re
         NwaHaY7/mZowuRaOmJ/AlrLvQCmji0U08pNpTIGuMOiEDHSqoU07z7Lk2eV+Ur/JHYvT
         P4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721287302; x=1721892102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z36h3EgWdW0oeGo8MwGOQHC0vdVkypcTjZjQ6VZXxVU=;
        b=egRf6IF4H4K85uwRQ0BCIaI9zW+nRmeOzooDNbgyY5O4TGh1lkpBqu3TKJpl8e1zV4
         VzzT/iKAFNXfYeEUL6XkdL7UQ0e7lwaKC7wmpavib2MiNH3kmI3Us5jewlMVV1IL8RTn
         DyvsM/iPdSZcrpf6QaKs9nkNtRqjsiSw5h1Vz6asby286HSrpd84YTHiMUVB0dGmXrYO
         6H6D6km+cJfJXctNY/Ap1Yelvopr2pI//YWksP3LoYzmS2R8V0KoNzYBbqVVn+1Th7Cg
         mgZKHYTDhOt+RLDMwfj7gzJsHqGkdjWIA2HE2sFu1OqH/6tbOAQAjG8GJmlh1hq1DVrY
         qerw==
X-Forwarded-Encrypted: i=1; AJvYcCUF3VIi6dbvlzw0bCHDRbTlIxmj6ZrA8NAaOgLJez8es65VAWI4SS2AgvVhK//LVj51WE8VXaQkbDXIqS+JG1ZB0XmGhGIxTbymtOKpGj+k
X-Gm-Message-State: AOJu0Yz18TxcXx3YNs9CVeljPRQVEWQSZJGDBeNDVDEAfihQmljfVwr0
	+ciDy1fQh0w/eJEP3kbdLplZFKbWX7qVzyRbYI36qXz2Gq7+dC0YckJebTA4AbQ=
X-Google-Smtp-Source: AGHT+IF97x7bn4mYrwvYkME2x6ecrHUwJBDJGcc/b2qRODahL6q5Up4jRxMNik+dgw6dPDV5AHUrtA==
X-Received: by 2002:a17:907:76f0:b0:a77:f5ca:f847 with SMTP id a640c23a62f3a-a7a011199famr260206966b.3.1721287301660;
        Thu, 18 Jul 2024 00:21:41 -0700 (PDT)
Received: from localhost (109-81-94-157.rct.o2.cz. [109.81.94.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc820e3dsm528650066b.194.2024.07.18.00.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 00:21:41 -0700 (PDT)
Date: Thu, 18 Jul 2024 09:21:40 +0200
From: Michal Hocko <mhocko@suse.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: David Finkel <davidf@vimeo.com>, Tejun Heo <tj@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, core-services@vimeo.com,
	Jonathan Corbet <corbet@lwn.net>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shuah Khan <shuah@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
Message-ID: <ZpjChBcIFUFulH91@tiehlicka>
References: <20240715203625.1462309-1-davidf@vimeo.com>
 <20240715203625.1462309-2-davidf@vimeo.com>
 <ZpZ6IZL482XZT1fU@tiehlicka>
 <ZpajW9BKCFcCCTr-@slm.duckdns.org>
 <20240717170408.GC1321673@cmpxchg.org>
 <CAFUnj5OA0KaC54M9vd8W+NZJwz5Jw25u-BStO=Bi2An=98Ruwg@mail.gmail.com>
 <20240717204453.GD1321673@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717204453.GD1321673@cmpxchg.org>

On Wed 17-07-24 16:44:53, Johannes Weiner wrote:
[...]
> The problem is that once global resetting is allowed, it makes the
> number reported in memory.peak unreliable for everyone. You just don't
> know, and can't tell, if somebody wrote to it recently. It's not too
> much of a leap to say this breaks the existing interface contract.

I do not remember any bug reports from v1 where there was a max usage
misreported because of uncoordinated value reseting. So while you are
right that this is theoretically possible I am not convinced this is a
real problem in practice.

On the other hand it seems there is a wider agreement this shouldn't be
added to v2 and I do respect that.
 
> You have to decide whether the above is worth implementing. But my
> take is that the downsides of the simpler solution outweigh its
> benefits.

While this seems quite elegant I am not convinced this is really worth
the additional code for a metric like peak memory consumption which is a
very limited metric in a presence of memory reclaim.

Thanks!
-- 
Michal Hocko
SUSE Labs

