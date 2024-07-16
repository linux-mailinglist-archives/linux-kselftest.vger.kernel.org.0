Return-Path: <linux-kselftest+bounces-13811-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8171B93327A
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 21:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B313F1C22EDC
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 19:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A943D0D5;
	Tue, 16 Jul 2024 19:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlMw2hd0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C1B28DD0;
	Tue, 16 Jul 2024 19:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721159641; cv=none; b=FFL4BWmw/mR8gsQ198NlIqcc4W6BK06nySy+tK3vv2dY7lyrwWpQNWON56bKSXmlm2zLFx9zunE54hYrpRPX67W4QM7M9SAgsga6js9qwvJh9t5C0MN/BuwZHZ6XhABawCBrPoyYz9QKPhVWMHd70w8njxPKK8j+IV6AfiaEWDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721159641; c=relaxed/simple;
	bh=vbcUatTQLinZ8Fv4tinWHiuvojXCKcsLM0i8nhNT4AU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fa8rCa7TZKzzkklAU9iBbkfuIqlDj2QgRG3nJFYaXAMa72lPtdAVjH938+/1swwHtmJTjki1Z+ftOMKs3/K7RDOgnvc5W0/bBijnihLOc/uDM32Phie7fsiOMHbHPbAAVeQrM6gktnnc81F0krN9jZpcUPSz4+2wP3kaGaQPQU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlMw2hd0; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70af8128081so4044524b3a.1;
        Tue, 16 Jul 2024 12:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721159640; x=1721764440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=trHVS38r80yv12O1rHCGnBDY8VUPQgUXPZhLTpyH52U=;
        b=jlMw2hd0areBoEgmwb0etVXW9wSjjVW2Jz4HPQh0ptKxeUdODgt67hzt1yoEzbXNZX
         7W5NR9HurLXO3YF7v1w1pX15kK87Db099xe09QpAItTLhQQnO/HBJm6ZDGV0an0rbQz7
         +EJtMGmY+AxClMWIbwh1hdTQWZE6dmOvWHwEJX3nJKDoZLHT7utpylNLqMtjeZjsy6+7
         m+YMgNfVozDLoQHDRMENn56h/Juz2pZRgs+GhvYGZQy3JtPykuybtncx8KmqtoyOL8Nw
         SbRs/7TD8HFsfRCsknNW5LTSaN6uTcSSor82H1h2DuFYWfTGerU9tnVC/Gqgf/cWjN8I
         zibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721159640; x=1721764440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=trHVS38r80yv12O1rHCGnBDY8VUPQgUXPZhLTpyH52U=;
        b=kufpP46WcYvIfASnKaHZ0/txWeE0BIniH49MoNO+nNLOiVXc02CsiP5biQ2NwD0l8i
         tA3Z0XSP6hNovf6qQxk0H5M6giss8e9ZdysvHxlvZ3Yb7wSJYr0aOomT3uIN8bw/YxuJ
         wVdFHz8jaqCMYizQRHt3322gqmNZAvmYhBhWzTlHIy6Os6VngCEu13B/8Pba4772fB5o
         01NqMZ+cpcjJo6fK3NjX66FTXjl2TjbyjQn790aG4aLu4uIqAuMPxJXhHSCsL2sq6z3r
         uPfZZjXZDe5SEVgIvIPV9Ch7z34MIA7afZKRaEE4izLRkMLfP5IwR2WbR9nM09CYHjE1
         UlXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD29GYHEfodDF6TA+3gYQ54+L0KNK0Lxgc6tlGfSWy/xhg5d9UHh1IeGNXap0Cj/sdEK4Az8iGrcG+NHC1QTnH/UBilEwRP1qzmOAm2DucQYw0nM1AqFSlcLB9VxfHAqC3TuJu1zsrCiHQnVqC70amIoaHnbfHlDaNdVE6/r4pBrdMqQ==
X-Gm-Message-State: AOJu0Yy/RrausKr+W/Pq61DVelAt2GE2n6EMLTuHghaKMlzSBH20bIGy
	SLudwfSbvJxa+CY23dsEfKqrX6AAXfOeAX2uZ1+22+Ea0TUJwdfn
X-Google-Smtp-Source: AGHT+IHmRwDHFqb7YkRcFIioTkfaqe3efTv5oVOWhxzSALptn2WaXr/+/MZscuMGo9/0wLUWYwomQA==
X-Received: by 2002:a05:6a00:2e06:b0:708:11f:d153 with SMTP id d2e1a72fcca58-70c1756e298mr3782891b3a.0.1721159639548;
        Tue, 16 Jul 2024 12:53:59 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ec7ecb2sm6709689b3a.103.2024.07.16.12.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 12:53:59 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 16 Jul 2024 09:53:57 -1000
From: Tejun Heo <tj@kernel.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Michal Hocko <mhocko@suse.com>, David Finkel <davidf@vimeo.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, core-services@vimeo.com,
	Jonathan Corbet <corbet@lwn.net>,
	Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
Message-ID: <ZpbP1TV_MBaoWG0o@slm.duckdns.org>
References: <20240715203625.1462309-1-davidf@vimeo.com>
 <20240715203625.1462309-2-davidf@vimeo.com>
 <ZpZ6IZL482XZT1fU@tiehlicka>
 <ZpajW9BKCFcCCTr-@slm.duckdns.org>
 <ZpanW41dQ8DimbA3@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpanW41dQ8DimbA3@google.com>

Hello,

On Tue, Jul 16, 2024 at 05:01:15PM +0000, Roman Gushchin wrote:
> > If we want to allow peak measurement of time periods, I wonder whether we
> > could do something similar to pressure triggers - ie. let users register
> > watchers so that each user can define their own watch periods. This is more
> > involved but more useful and less error-inducing than adding reset to a
> > single counter.
> 
> It's definitely a better user interface and I totally agree with you regarding
> the shortcomings of the proposed interface with a global reset. But if you let
> users to register a (potentially large) number of watchers, it might be quite
> bad for the overall performance, isn't it? To mitigate it, we'll need to reduce
> the accuracy of peak values. And then the question is why not just poll it
> periodically from userspace?

I haven't thought in detail but it's the same problem that PSI triggers
have, right? PSI seems to have found a reasonable trade-off across accuracy,
overhead and usage restrictions? Maybe peak usage isn't as widely useful and
it doesn't justify to engineer something as sophisticated. I don't know.

Thanks.

-- 
tejun

