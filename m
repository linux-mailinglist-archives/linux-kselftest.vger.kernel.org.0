Return-Path: <linux-kselftest+bounces-7494-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3367989DFF3
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 18:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 558C61C22068
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 16:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BF713D63D;
	Tue,  9 Apr 2024 16:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="cFbC+aHp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BB513D631
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Apr 2024 16:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712678570; cv=none; b=JhStWUEKEa1wdzU7mel3zTu92hvaF8I+dutLG5AOZRiPsdNCjlRF1jxQGM9ioQoqDvV1/uyEEDF8SO9+kIx5MAC3MXLsL5HyGiM112944Ss56YTmAaMTSeStqT2Vy4NtygPtC7E6JqGNcDseWA6KDBHZ9YUH95J4BmJ802hjJQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712678570; c=relaxed/simple;
	bh=dyL+TLXIFrRx9Lp5PrForFMQ5coJeHhlaD95G4Nkex4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A06CWKcA/kDlT8l0Ty0D0FURRo8CLuQUfhtPPjmNdIfWF/QRIuMbSd+Yc7HyjbNjz/BCmOrruOrvLh7jprxEORLQ+TI7nSpKpCpl7VnqLemxzgmvAk2YnAjPVfBc5VonC6HZPhnKUkROdORB36NXYKfgiDO3jWwpWCAK+zcMec4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=cFbC+aHp; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-22edbef3b4eso1144072fac.3
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Apr 2024 09:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1712678567; x=1713283367; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cqPDnUUjz+kqldNCaECmKcsoHhRA5eglyoZJn6Trgmg=;
        b=cFbC+aHp4L0u99cQueshGb2OyxJygUyW51VW1PlaL42GL5fVSk8i6pKHcDcMNFQy8b
         dvRcySxYAOd9RLXXzSK7cMTp2WnL9/RjeWGNtre+Bvw648YJJH8jC8ByiFuw3ScLTt57
         W/vBdHsBQUaDYB/EYie3Q8tyFt31KpsQy1xCa+S8Dq/2JzTrfF724TMBFgD+kvSBIeMW
         kk+j6jERo8QvKYvXir0aeTJKwWs5JGGxdwHtVuD42GKXfuTww0g8XrIANMPLZU0E4xFr
         eCzHoUxTMia0C1GXgDaqF4xmiEX2gjCoH+QBNTBHCUcLf4ETCCOaX6lxyyvzZaDGxnIz
         0CMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712678567; x=1713283367;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cqPDnUUjz+kqldNCaECmKcsoHhRA5eglyoZJn6Trgmg=;
        b=vBjWhTBXtdzqhfDX8KbruL5PJp6bVCjTXRONrsNt8xXNABkfl7C9EbdFlj7bqU5L3D
         CNjcw/m5fSmnGotEsFiyrrFIoG2YUI0RBOZy0dB2OZDvg0zmN394JQk+Z4tekCCND9CY
         L+4ItObyAM2vx0MPsmdew58mQy0Z9VVAz6zMUNJKigWVscxdnX/Si0Liba//48P3lWHQ
         YOWcqVnUTVLcD5UnZ6X9K4WOn4YiOWlwbxc/VPJuq0O5NAfIW2a6VdaUQ0KEqQUfBw23
         5n2QwQnUpZ3EIb4gFQFoOb1zWtboKYYFPHrzS4BR/IM8wjGeXHPqFdaBP+3GzRoF/ja7
         eEWw==
X-Forwarded-Encrypted: i=1; AJvYcCWYswTE0+bT3DSf+hE2QRHdqhhsv8lJkJWmhJE2hDnNZYXzCdyTLv2E8pcD5qRNX7wCMlKHDdRYJuMhicx4/bd97jZg1lYhv4OWFIYYfvU+
X-Gm-Message-State: AOJu0YwudE0geCuQAEISlg1J+DLxyhUk4jAd4TE2t4lXQJggD6tlG0cK
	AQ9D78OLdLrAgWiF9MB//6p/MH/inHa1WoqyXxM0KJbSWWFkFk/HRm/iiY9FzkQ=
X-Google-Smtp-Source: AGHT+IEGoBrNhBqtGIUytEyqGsTfxZZgidVeUlPKiXIyqqZM8wDHEt7Se1Z5Tgf7yF4UEbMKRsx9Xg==
X-Received: by 2002:a05:6870:3753:b0:229:f403:136e with SMTP id a19-20020a056870375300b00229f403136emr13014545oak.56.1712678567546;
        Tue, 09 Apr 2024 09:02:47 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:6db8])
        by smtp.gmail.com with ESMTPSA id i10-20020ac871ca000000b00434af976d2dsm1785597qtp.88.2024.04.09.09.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 09:02:46 -0700 (PDT)
Date: Tue, 9 Apr 2024 12:02:41 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Tejun Heo <tj@kernel.org>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Zefan Li <lizefan.x@bytedance.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Subject: Re: [RFC PATCH v3 2/9] cgroup/pids: Separate semantics of
 pids.events related to pids.max
Message-ID: <20240409160241.GC1057805@cmpxchg.org>
References: <20240405170548.15234-1-mkoutny@suse.com>
 <20240405170548.15234-3-mkoutny@suse.com>
 <ZhQvmnnxhiVo1duU@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZhQvmnnxhiVo1duU@slm.duckdns.org>

On Mon, Apr 08, 2024 at 07:55:38AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Fri, Apr 05, 2024 at 07:05:41PM +0200, Michal Koutný wrote:
> > Currently, when pids.max limit is breached in the hierarchy, the event
> > is counted and reported in the cgroup where the forking task resides.
> > 
> > This decouples the limit and the notification caused by the limit making
> > it hard to detect when the actual limit was effected.
> > 
> > Let's introduce new events:
> > 	  max
> > 		The number of times the limit of the cgroup was hit.
> > 
> > 	  max.imposed
> > 		The number of times fork failed in the cgroup because of self
> > 		or ancestor limit.
> 
> The whole series make sense to me. I'm not sure about max.imposed field
> name. Maybe a name which clearly signfies rejection of forks would be
> clearer? Johannes, what do you think?

The max event at the level where the limit is set (and up, for
hierarchical accounting) makes sense to me.

max.imposed is conceptually not entirely unprecedented, but something
we've tried to avoid. Usually the idea is that events correspond to
specific cgroup limitations at that level. Failures due to constraints
higher up could be from anything, including system-level shortages.

IOW, events are supposed to be more about "how many times did this
limit here trigger", and less about "how many times did something
happen to the tasks local to this group".

It's a bit arbitrary and not perfectly followed everywhere, but I
think there is value in trying to maintain that distinction, so that
somebody looking at those files doesn't have to rack their brains or
look up every counter in the docs to figure out what it's tracking.

It's at least true for the misc controller, and for most of memcg -
with the weird exception of the swap.max events which we've tried to
fix before...

For "things that are happening to the tasks in this group", would it
make more sense to have an e.g. pids.stat::forkfail instead?

(Or just not have that event at all? I'm not sure if it's actually
needed or whether you kept it only to maintain some form of the
information that is currently provided by the pr_info()).

