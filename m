Return-Path: <linux-kselftest+bounces-47680-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AA7CCA996
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 08:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B707530140F0
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 07:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B8C238C16;
	Thu, 18 Dec 2025 07:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UtWQgTcB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kD6QzC6G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E07271448
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Dec 2025 07:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766042061; cv=none; b=HvnO09zD9bG3QJw52oKR7hO2LseCBDfduaEvCvldSCjunww/hFrrVmP536bXFg/gqE14Vv+dzc+eT6U6gSM97EDvXaGDlPEQALHoJMlNZvP5bEHl0k+P0159CM9BCxCjIwgKzocuDC6F/iUiCExQI9aqt4n6yU4IEPfVqnKXhrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766042061; c=relaxed/simple;
	bh=pdMUtduMXCj5whENGA9N7DnLbY+JEMVMPlaas2KdqgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zgfj1n5gb/FvIt1cByRPBTvcxjS6/QEXTCzen5eyWYqsiUjcY2peiKfHN0S5MHe4A9FuBqxsFmvNgiWY368SiILCfwpcWsiZLLB9wKcx8QHhzfkf+l7x9kWB0M+sg2mRYNDM4e31qnd4MnbRVg2k3G9IPXGquZs0stkepW3NzW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UtWQgTcB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kD6QzC6G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766042059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oNBsiLM1lI5WSv0gDo/xxnKGXTG+8RkXyoth8Hg52dk=;
	b=UtWQgTcBr3AZWEy1jhWAP0bDuaGCQJTMMT+/p6cmNv+M1uKaMgTdBPkIyWMqpCA5mM18As
	v/9Ym2hI8MvDZQXWBHIaiNrP18TtjDwSkCXXG+HoEcaw8F34EWgBWSpAaPprX9rcSvKg2q
	7V0BPshHNlmEzjZxVNeK9Mx1Ee7g9PI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-NPO1NmuiMHGwOIjMrysd0w-1; Thu, 18 Dec 2025 02:14:17 -0500
X-MC-Unique: NPO1NmuiMHGwOIjMrysd0w-1
X-Mimecast-MFC-AGG-ID: NPO1NmuiMHGwOIjMrysd0w_1766042056
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-430f5dcd4d3so155121f8f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Dec 2025 23:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766042056; x=1766646856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oNBsiLM1lI5WSv0gDo/xxnKGXTG+8RkXyoth8Hg52dk=;
        b=kD6QzC6GiQmYrdH4YxH7W2Gj77eHBrbcWvGvJrulBJpYs+ya+7f8fIv2uGgQ/O0B8m
         Fz5DMDxstvMDHrBdM9GMU7QwEwy3bf5WMX+/P6PwdEyqeYwxl/GWkR07iF9RrfU0o7lB
         3MPWhG8+PXQ7wScmUJ4OdtSas1SCuLGgmlcBJmnZnOVGOFO61pjbyxw0EKpdH8OQPT0E
         cR+jwyalByW5W7wGf55tLF07tR3HUrgxRmANRCgN9sr/UxY3IqtHidQgJLpgKs59WYJF
         b7aDvWN3u+6BOPkN/pKUbKUzmhkFmb2XRgZNpQFjxFFt27qUHL2OByawW7JVhtbUUAG+
         l33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766042056; x=1766646856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNBsiLM1lI5WSv0gDo/xxnKGXTG+8RkXyoth8Hg52dk=;
        b=V0INKff90WySqR+uJMzmnBOjiHd+83/1alLB6dOQBl++hS4BBC6UdKQbfSko0qspNb
         5WhzvKdnb7G5wS4G2VySlZ3TKexDUGmVi2vwb9YdKemTlh608+wqVrKoOL7WXwstQpr+
         16ecRf3Fobg23heZYWszQvcb2i6h0x9DxnYO3QzYyaxhD5FVV33B6JTboqK7JYdOPI9Y
         ZVNeGYf8oFP0MrtJQVZGoIftQLmMw73EkTNVka5bg/u3RRxdCH+nUlBmacP2SAvsulWU
         53MQN/80MqWEnFi/bDaGASSPijik6lZPd/Rxtac5dCfd0LXufjgg3F1WxeZLhWbAbt5L
         z7dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVHgIMVqaaLkqh5VrhWLcNBR9W/Of+7VJY0Qj5Z9EYu879ua/MT5nbHTsRnqBj+WcqCr5IMQlFtj4A+90NT0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1er6ufxeXWeCD7keLmO4Bf+1rBeyFPfaHIi1dLmK30LS4AqbV
	wEPsrqESMgLd3GccYGlnAafox/PTBa1AtHKxN8GDJdtCEg8LsnyhxNAY/4vp0NU51E3FAnz/m5/
	zMujOpbZAbuvwblvglaxUhAsyvBuvGtCjk07h6Q7sFurPa1IwW/vBPdHQR4fQHfZ3UlgzfA==
X-Gm-Gg: AY/fxX7qqHvD723Gzir6DHN4BMNdZoIBlSkzQ9crhuLQ0MhjORnbrqAMxylce93j0l1
	8O8BjBAJKUg0U4RNiHCYISxwYecqft5J9FP5eVsbnd2dixUsddOZstNhgfKBNbh3DjmD8oAPJbU
	hJDNI9upnx6GFse60KRpWJC5XEvSWXN8U6S5VSuma9MMKctkwynmpriM1zukg8F0b1lNyQKBdUH
	F8GrUBZm8wa5pCJ7U0geKzfKbzS3cPiqiolUlgd+RIbjN+Uy/ZJ44E+F+BDWZsFYSuarZw3dbXi
	dOU/Ekj/CQ8tQH1cxrZvE0A4eKl1w0Gz2OfNG1lU8Iefg5OJ6ogI5XZBNv/PEQo6uiJHqSEu/pC
	D8oc8KWYhtWWu4QfbJ/WPMmzGqi9fnbEc9AMq5wLE
X-Received: by 2002:a05:6000:3113:b0:430:fbce:458a with SMTP id ffacd0b85a97d-432448b7f11mr2026715f8f.18.1766042056125;
        Wed, 17 Dec 2025 23:14:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmwvfPARt5/oktdF01vTTh+pbj0DvIQNLkJ0QsqlEvJKz7q81ZhZQ2a/z1plKZxslmFO/O2g==
X-Received: by 2002:a05:6000:3113:b0:430:fbce:458a with SMTP id ffacd0b85a97d-432448b7f11mr2026688f8f.18.1766042055684;
        Wed, 17 Dec 2025 23:14:15 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324493fe27sm3248198f8f.12.2025.12.17.23.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 23:14:15 -0800 (PST)
Date: Thu, 18 Dec 2025 08:14:13 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] sched_ext: Add a DL server for sched_ext tasks
Message-ID: <aUOpxVIQieTOMifV@jlelli-thinkpadt14gen4.remote.csb>
References: <20251217093923.1556187-1-arighi@nvidia.com>
 <20251217093923.1556187-5-arighi@nvidia.com>
 <aULQ7kPm-RqHWGDL@jlelli-thinkpadt14gen4.remote.csb>
 <aUMmuRI-ZljfDuh9@gpd4>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUMmuRI-ZljfDuh9@gpd4>

Hi!

On 17/12/25 22:55, Andrea Righi wrote:
> sched_ext currently suffers starvation due to RT. The same workload when
> converted to EXT can get zero runtime if RT is 100% running, causing EXT
> processes to stall. Fix it by adding a DL server for EXT.
> 
> A kselftest is also included later to confirm that both DL servers are
> functioning correctly:
> 
>  # ./runner -t rt_stall
>  ===== START =====
>  TEST: rt_stall
>  DESCRIPTION: Verify that RT tasks cannot stall SCHED_EXT tasks
>  OUTPUT:
>  TAP version 13
>  1..1
>  # Runtime of FAIR task (PID 1511) is 0.250000 seconds
>  # Runtime of RT task (PID 1512) is 4.750000 seconds
>  # FAIR task got 5.00% of total runtime
>  ok 1 PASS: FAIR task got more than 4.00% of runtime
>  TAP version 13
>  1..1
>  # Runtime of EXT task (PID 1514) is 0.250000 seconds
>  # Runtime of RT task (PID 1515) is 4.750000 seconds
>  # EXT task got 5.00% of total runtime
>  ok 2 PASS: EXT task got more than 4.00% of runtime
>  TAP version 13
>  1..1
>  # Runtime of FAIR task (PID 1517) is 0.250000 seconds
>  # Runtime of RT task (PID 1518) is 4.750000 seconds
>  # FAIR task got 5.00% of total runtime
>  ok 3 PASS: FAIR task got more than 4.00% of runtime
>  TAP version 13
>  1..1
>  # Runtime of EXT task (PID 1521) is 0.250000 seconds
>  # Runtime of RT task (PID 1522) is 4.750000 seconds
>  # EXT task got 5.00% of total runtime
>  ok 4 PASS: EXT task got more than 4.00% of runtime
>  ok 1 rt_stall #
>  =====  END  =====
> 
> v5: - do not restart the EXT server on switch_class() (Juri Lelli)
> v4: - initialize EXT server bandwidth reservation at init time and
>       always keep it active (Andrea Righi)
>     - check for rq->nr_running == 1 to determine when to account idle
>       time (Juri Lelli)
> v3: - clarify that fair is not the only dl_server (Juri Lelli)
>     - remove explicit stop to reduce timer reprogramming overhead
>       (Juri Lelli)
>     - do not restart pick_task() when it's invoked by the dl_server
>       (Tejun Heo)
>     - depend on CONFIG_SCHED_CLASS_EXT (Andrea Righi)
> v2: - drop ->balance() now that pick_task() has an rf argument
>       (Andrea Righi)
> 
> Tested-by: Christian Loehle <christian.loehle@arm.com>
> Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---

This new version looks good to me, thanks!

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Best,
Juri


