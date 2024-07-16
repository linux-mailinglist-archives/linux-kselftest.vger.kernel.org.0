Return-Path: <linux-kselftest+bounces-13780-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C989327C8
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 15:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57EA91C224A3
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 13:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E187B19B3C9;
	Tue, 16 Jul 2024 13:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FHCRaNvP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837901991C2
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Jul 2024 13:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721137702; cv=none; b=H1IrcqOYUUZ3YGzsvz8Rvt30/pEENSfh0E2+18hQ1UL4YfCabl1wTqx68BHA3Hte3am/dXqCO8bJmv4TFE1Sc2oxcafS2c4O3NJR7JzKKVUOoFYBLs+K17kF34pQE4L19HpGqY/Cj7uCT0LhDPx5bBgVX3T/TY8bip1qhayMLMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721137702; c=relaxed/simple;
	bh=+xXEozYfMyVoueKNLz4iqAovWkEAAL1GA5tMVC+CR3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldXKnHnVv2DrvMUFxRR4n1NZdr+uLegy1nWvF37R9zKDmVMp5EN9/6d/WkqiKE9PwvLo4j+BuEqtpzebsVhXdv4FinvJBUAKBo+S/9N4rshI8VzxieQKJvqgOBQGeEI58APGYumuxMWiE3Qjc+DYvXVgLCUernYucdi2ZvML5Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FHCRaNvP; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52e94eaf5efso6856196e87.2
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jul 2024 06:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721137698; x=1721742498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KM8Ao0zGor69tQroBWIUZVg9uwOWjyC5j2aDW1h9Y7M=;
        b=FHCRaNvPY1qWnz0FApgTtqc4/GHXuNJ8LAdjdwz9kSo+ug7wSpcfLdCvywVfzXBKrF
         uvsJp9qnApNJHsXZrorFHhlPOWZj2EY8RkSS3BNf7ItlHfbLaaH6yv0Zrn8YJjPoEsn8
         kQybgBO2NRvMeCB98utJtua9TAWEX1LddCqHuf9Mt5/C90PI9q/fo1HEhEHqg7UWE00C
         H/dOYi2enwIUJ2JYf5TGgT/zv3CpDLOcSIB5Liwb/PMLpVNROhOsg+lZV1DbIoNEB9Yu
         QaOB5otXKmlMHSF5y6Bgohot+kfuwmZnK45qeFHCXXnv309eb4kMwYNUSnX8YuQs1Pos
         PclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721137698; x=1721742498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KM8Ao0zGor69tQroBWIUZVg9uwOWjyC5j2aDW1h9Y7M=;
        b=AvbxoOjgJwzLIx8lO0q3Poi8s+6lA6UIy/HkqnGBA4MyC690w9Y2qjQygY7kxvNuof
         JguItPbv2EiTxidr1iok+dhCqT9kJ0ZBF/cus1CI71UYeV6iSxYrCKfV75oDjNX0FPq4
         A+HHo3R8GAjIEObm/AwAoH3vKyAg/epVucGgKiHTZ7xSCfd5oLrAQjO2PzMQkdzt10DI
         Iigky/+xOwu5pe1OTP9wTsjgeqgeaqTxUnpFUjQUvnC6S50dCPy80MjSwNC2k/TGHKHs
         p0C8Jll5bHtLttpzSfwxDb5wFL6lW566nt9wOSRjNtQzIVWai0fikkGrbcZa3DzJcq03
         alKw==
X-Forwarded-Encrypted: i=1; AJvYcCVR38GfUlY7UAU7VKO+BBrgDx3P0AFnVdx0c4oE5AH3dfx6xqyJvTer+eo0f+VZZfXMQVIfJuUWSSVlbPcTLdMm4PNrceR9jG0IwA1MKON0
X-Gm-Message-State: AOJu0Yx+g/V2ZbYOWDQ6UeZ7rdKNeV9YaSm0pmOlz59OQim7dSPlMgZ/
	NopCsMZLnMhT/sv6gCZx/icBOmbCJCI2MqbeaRz/PkcKVAlsJokv4j5Dozk0jOE6lMvAX/WTMqK
	9
X-Google-Smtp-Source: AGHT+IHrF8A8QPHCkRg6cY7Pr6jUMY+YOeOSFYt/dignGbQ+OVrmY981I/Z9G5rwzM03nO4wL9x+2A==
X-Received: by 2002:a05:6512:1316:b0:52e:a699:2c8c with SMTP id 2adb3069b0e04-52edf038a3cmr1420761e87.45.1721137698585;
        Tue, 16 Jul 2024 06:48:18 -0700 (PDT)
Received: from localhost (109-81-86-75.rct.o2.cz. [109.81.86.75])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b26996c4asm5004378a12.74.2024.07.16.06.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 06:48:18 -0700 (PDT)
Date: Tue, 16 Jul 2024 15:48:17 +0200
From: Michal Hocko <mhocko@suse.com>
To: David Finkel <davidf@vimeo.com>
Cc: Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, core-services@vimeo.com,
	Jonathan Corbet <corbet@lwn.net>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
Message-ID: <ZpZ6IZL482XZT1fU@tiehlicka>
References: <20240715203625.1462309-1-davidf@vimeo.com>
 <20240715203625.1462309-2-davidf@vimeo.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715203625.1462309-2-davidf@vimeo.com>

On Mon 15-07-24 16:36:26, David Finkel wrote:
> Other mechanisms for querying the peak memory usage of either a process
> or v1 memory cgroup allow for resetting the high watermark. Restore
> parity with those mechanisms.
> 
> For example:
>  - Any write to memory.max_usage_in_bytes in a cgroup v1 mount resets
>    the high watermark.
>  - writing "5" to the clear_refs pseudo-file in a processes's proc
>    directory resets the peak RSS.
> 
> This change copies the cgroup v1 behavior so any write to the
> memory.peak and memory.swap.peak pseudo-files reset the high watermark
> to the current usage.
> 
> This behavior is particularly useful for work scheduling systems that
> need to track memory usage of worker processes/cgroups per-work-item.
> Since memory can't be squeezed like CPU can (the OOM-killer has
> opinions), these systems need to track the peak memory usage to compute
> system/container fullness when binpacking workitems.
> 
> Signed-off-by: David Finkel <davidf@vimeo.com>

As mentioned down the email thread, I consider usefulness of peak value
rather limited. It is misleading when memory is reclaimed. But
fundamentally I do not oppose to unifying the write behavior to reset
values.

The chnagelog could use some of the clarifications down the thread.

Acked-by: Michal Hocko <mhocko@suse.com>

-- 
Michal Hocko
SUSE Labs

