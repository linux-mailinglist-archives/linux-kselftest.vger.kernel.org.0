Return-Path: <linux-kselftest+bounces-18804-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E64198C4C9
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 19:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AA7DB21D69
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 17:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30DC1CB501;
	Tue,  1 Oct 2024 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZncx9rm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103A81C242E;
	Tue,  1 Oct 2024 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727805027; cv=none; b=mxwQrFKZs8nPc9cHMh5+M9jGwTiTfrlcLE0Tk/y8v+Kh8mCBlIpwAAK9RPaLm467qw7XonG5pP//TIY5bEPLlJKIBZyv5HVWL3b0gPydL+ODUjOTKnkGz2bzobMPW7Fgjg32rnCjFXwARJO4BOHBqlhCt2qDE4Ji1WPB0siRv1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727805027; c=relaxed/simple;
	bh=LCWVpajAikQ+toPAXwPJaPLnAy7DAfal7nkQHKA9yws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bd3eb51sARYYf52flxX/W3jOuTI2TXd1/npQMzIiZr7+14f4SZoEviSaFbyyLpk+s8kDeDA/j9S66cfFC2eVzlNGCIs3bHpDBqQMzUyGpVNolJrRtWsDq05y34QGRX9KLzo16Kyi9df5qKva1RPsgKmNtyMZS8HJXX0+Y+uf86c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZncx9rm; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c87c7d6ad4so5986961a12.3;
        Tue, 01 Oct 2024 10:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727805024; x=1728409824; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LCWVpajAikQ+toPAXwPJaPLnAy7DAfal7nkQHKA9yws=;
        b=TZncx9rmzCC3RsuKfMGEg7IYKTVJxeh62b4SN5sOlwHFs/WLa8XQYhHUb3aDcNZzjz
         sgOOiN/g50/GqX4tH01mZNYZRe2eYyIQMwaCZosh1IALhNIn0KXih14fnSaSQtoUzhu7
         Fanux1la9WZIeseBrcKmE8Ye5C8SDmTzalCXionLZJjGYPZwOTiTMgVJRlENYKQkrUhs
         zYb71ctorNdJxzACffhWLkx81PhPkdVCCDEN9wXvIjO50bOImOzqCF/DVbVXX1gjOrmj
         BrWfT0E6FjIZipMdbWzR4P+foua99px1nnMe3SaF2LVup20N+Uk1gH4axxACNkqEQ0a1
         MRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727805024; x=1728409824;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LCWVpajAikQ+toPAXwPJaPLnAy7DAfal7nkQHKA9yws=;
        b=F177nG8PMomVlKLkCn0w9R1NjrFmkL3zUK3xKXLqZ7FdTl9Fps6CBRP1M/jtseuB2P
         uZMBNRv+rnJHK+jw6MsQsWPed5DPbgvEygZ9kPYXY+XNt0pYh3eZRYUHAJuuGUHbSfNF
         xF8fR4gnU2qYd7u3AFYVSmKxT71+CghwmViwBSlv7GcGpPhQerabOLsOjfmAgnTXHoDd
         KqvtyR6PM6FTLDHVSfjgSyP6JYHiWpDjaYFTe4g8oyhDfea4o2IVgBqmdZZAQPM3MbA8
         3P6dSreLv2WFYiZHRf7hY2BqAbRyNQRhkm+o242G0cj1/UumqVxb6ZUGT5i6xO14g9Mq
         jYqA==
X-Forwarded-Encrypted: i=1; AJvYcCUUjc/IsQnCTMzV+mu66lG2NMf8o/6YPloLNhzQ0Y6LArp0HRpkxXNcXN9d2rCJ1tu28VZHteIl6SbjwgsTWdWI@vger.kernel.org, AJvYcCUuicqR6EIWa9dVIYBI2Ns1Fe4L4z5X/4NiOVPUBWYXrzQHVUkfhLKa37VFtHbVjnoPnFLAzouhf6gRMDp5@vger.kernel.org, AJvYcCXVqqA3yGds0RzJ3N4Dr5MP6XTIEG1DK9Gi7JER2yviRqSMNOHcOlo8oz37y8N9p1kbky58snFC@vger.kernel.org
X-Gm-Message-State: AOJu0YyxhK/lF00mXzQ/ZbGSSh/H7/d6g2lAniZQeDRIKgyt8wQWtgJn
	zZR9uGN6yNkfu1ggxm0dgtHsXM7jqd4mkcksxGbGXEWHiNrVeh4fVntC0FpJi0DrHqE1DrVWtMa
	z0DgaB3MGb0E2DG3cBtFBTdSQKnQ=
X-Google-Smtp-Source: AGHT+IFgvIzj7DBl0y5N2epf79BbIYuUEEl/ozcyirEICsugUX7UEjuzXWtbCf1MWErSoG6HsTmK+nS4lMWP8PuwFYM=
X-Received: by 2002:a05:6402:210f:b0:5c5:ba82:c3b1 with SMTP id
 4fb4d7f45d1cf-5c8b1b8b391mr139688a12.29.1727805024017; Tue, 01 Oct 2024
 10:50:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923142006.3592304-1-joshua.hahnjy@gmail.com>
 <20240923142006.3592304-3-joshua.hahnjy@gmail.com> <xmayvi6p6brlx3whqcgv2wzniggrfdfqq7wnl3ojzme5kvfwpy@65ijmy7s2tye>
 <CAN+CAwO8XEAkoBDc03Zveaci9hASaFvk8ybQ2Mwoy_VacqgRfA@mail.gmail.com> <4l4afsuzqd6vowki7ldafoikpyw5sfwcvhhpeaezwhdmdj54bc@fhp6yt3ygq3r>
In-Reply-To: <4l4afsuzqd6vowki7ldafoikpyw5sfwcvhhpeaezwhdmdj54bc@fhp6yt3ygq3r>
From: Joshua Hahn <joshua.hahnjy@gmail.com>
Date: Tue, 1 Oct 2024 13:50:12 -0400
Message-ID: <CAN+CAwP048b_cbw1jQf4Z0eGatbkaVW=AbL2MqjaDnuDZM-1ig@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] cgroup/rstat: Selftests for niced CPU statistics
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	lizefan.x@bytedance.com, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"

> My motivation comes from debugging cgroup selftests when strace is quite
> useful and your implementation adds the unnecessary fork which makes the
> strace (slightly) less readable.

This makes sense, thank you for the context. I hadn't considered debugging
considerations much, but I can imagine that it becomes harder to read
once the code & strace becomes clogged up.

> > Do you think that this increase in granularity / accuracy is worth the
> > increase in code complexity? I do agree that it would be much easier
> > to read if there was no fork.
>
> I think both changes (no cg_run or cpu_hog_func_param extension) could
> be reasonably small changes (existing usages of cpu_hog_func_param
> extension would default to zero nice, so the actual change would only be
> in hog_cpus_timed()).

I think I will stick with the no cg_run option. Initially, I had
wanted to use it
to maintain the same style with the other selftests in test_cpu.c, but I think
it creates more unnecessary unreadability.

Thank you again,
Joshua

