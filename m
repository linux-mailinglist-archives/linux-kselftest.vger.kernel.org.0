Return-Path: <linux-kselftest+bounces-13787-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91357932E7E
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 18:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C261D1C22038
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 16:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9CB19EEAB;
	Tue, 16 Jul 2024 16:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcvvVvpX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8871DFF0;
	Tue, 16 Jul 2024 16:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721148255; cv=none; b=qUncU5z63mZXUiLVKFiYSnk85Y5Izw9ldCwaeyBp1uumFhxHVfZIS+NUNaPo+RrB14YkQyGDv+yVBmIdjMLoiyOENbhTSXPTcb33bwDJTHdZ4hCYXtXXHc7lJQLYWg9pZevAKP1AhGb2wdPZXxd6y3Bfon0R2dB8AlnnOTLrEmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721148255; c=relaxed/simple;
	bh=JdlcOhdHJ1u5TFZGRXNCQADr44dreFjHhauhrU0D5o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhlSBflGSwha6zkJA0fe3PiFJJ6djOrKnvVP7wH+FWL0VAUpfId2UkU8tfv4zgeZTLDP+1P7353LxC3WLU/QYVDLfdF10BYVfKUwoNkNVe8AUNL9xJ4JXpuTg4Ia3W2Q1EEAQ260NrLMyJzV99Ga13IAW1xlmV7eXYFQ8VZYaRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcvvVvpX; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fb3cf78fa6so35779965ad.1;
        Tue, 16 Jul 2024 09:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721148253; x=1721753053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o+CNye71moJTbH6lgtmPaTmt3WinfyunEpCx02RJRQ0=;
        b=kcvvVvpXWlfIvgN03mTyMNz9TyEHfkC1LrQSs+DcLUSyGd8ijwJWeZsIKUxzycKCUq
         qH9CEUjVaFDvwqr3oEuDl1c3xRb3RYABaGokHFfYcmtdwzj9QGVc5d9byMAkb4lW8Dn6
         QN3m5d9ofRZ12nK7VNDHuaa1gCfHZySz43jqaNDzMePcDAhFC/QfWJ6UGxAIUXl9XlrF
         RBuo8UpYxQDP0evRsJgs7BYQSNSCwdjnK5DSnBk5kNEbqyaFE0fx6VQnebxhL6RPSxSl
         qiN7+U22xu6ltf+rURazcsY5X7RYdabl/2rv3tFxnRg+LINzN0ty7jSZ6FhLWSBJgh7F
         nyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721148253; x=1721753053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+CNye71moJTbH6lgtmPaTmt3WinfyunEpCx02RJRQ0=;
        b=AetQgXkRKiJIqhus+SXPfv7r8vGaY7l9/wqLbT0CHabJ3eMMEs0HBoknXETOh0owh0
         w+F3xUmtNjUIDFqc4//Y0mAQ74QqLQZYM9IQyslJpCJ3miGUPGfVVV1+ujP7daW3KeLS
         TmUjmI67AxtJBNrYHpLspVejR2CU6bslqbmlbJGfZffwGt9iBjcGbQwms22F9F4GreFd
         2DA/Xekrj3n4Cg92kgZuRjPJT7C33A40R3GRVKIS6NRcit1NtHE3QQ4N1CQ6sIi4VeCY
         m9/D1FBIIyrx7kPQYOYTAtPIHtJ/OpHWK3erplIYZRLE2RsLQqaz80rs66TCNZAZKu4B
         1JkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjSTKODg/yuAYlSgBCJ5ShuNfKT94SHWBlN6x1VL5vTPysFrsMNmAX1/GE0L/BEXRLREBphoQJmr4yPPOgeCxC2mAW3Uoy/F7xJOkJqo4mQPpBhi5eS2JGvoX7EAMaGDrG9BP3vVNBtfaojSxv8lKBPeOON+BthjP9tDkjXfNafp5o2A==
X-Gm-Message-State: AOJu0YyX8thlm1/ABNb/VCrdeFC4OcM7ZJbRjy0bG8XJEwD9+MAYft2N
	NL9Wc8aLDPVizCozNoZqvGcjgTuaBiutpBkbe/smGgudTE/PXT/rGoBg8g==
X-Google-Smtp-Source: AGHT+IFJTbkJ4XB7m4WaS7/c2xk1R7iNNXoVb9NqqFwlW+JzGTrtgh//VsiTNurobqayni9p4YzZYA==
X-Received: by 2002:a17:902:d50b:b0:1fb:7f2c:5644 with SMTP id d9443c01a7336-1fc3d93bb64mr22987525ad.31.1721148252947;
        Tue, 16 Jul 2024 09:44:12 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc27378sm60382695ad.158.2024.07.16.09.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 09:44:12 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 16 Jul 2024 06:44:11 -1000
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
Message-ID: <ZpajW9BKCFcCCTr-@slm.duckdns.org>
References: <20240715203625.1462309-1-davidf@vimeo.com>
 <20240715203625.1462309-2-davidf@vimeo.com>
 <ZpZ6IZL482XZT1fU@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpZ6IZL482XZT1fU@tiehlicka>

Hello,

On Tue, Jul 16, 2024 at 03:48:17PM +0200, Michal Hocko wrote:
...
> > This behavior is particularly useful for work scheduling systems that
> > need to track memory usage of worker processes/cgroups per-work-item.
> > Since memory can't be squeezed like CPU can (the OOM-killer has
> > opinions), these systems need to track the peak memory usage to compute
> > system/container fullness when binpacking workitems.

Swap still has bad reps but there's nothing drastically worse about it than
page cache. ie. If you're under memory pressure, you get thrashing one way
or another. If there's no swap, the system is just memlocking anon memory
even when they are a lot colder than page cache, so I'm skeptical that no
swap + mostly anon + kernel OOM kills is a good strategy in general
especially given that the system behavior is not very predictable under OOM
conditions.

> As mentioned down the email thread, I consider usefulness of peak value
> rather limited. It is misleading when memory is reclaimed. But
> fundamentally I do not oppose to unifying the write behavior to reset
> values.

The removal of resets was intentional. The problem was that it wasn't clear
who owned those counters and there's no way of telling who reset what when.
It was easy to accidentally end up with multiple entities that think they
can get timed measurement by resetting.

So, in general, I don't think this is a great idea. There are shortcomings
to how memory.peak behaves in that its meaningfulness quickly declines over
time. This is expected and the rationale behind adding memory.peak, IIRC,
was that it was difficult to tell the memory usage of a short-lived cgroup.

If we want to allow peak measurement of time periods, I wonder whether we
could do something similar to pressure triggers - ie. let users register
watchers so that each user can define their own watch periods. This is more
involved but more useful and less error-inducing than adding reset to a
single counter.

Johannes, what do you think?

Thanks.

-- 
tejun

