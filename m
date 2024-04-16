Return-Path: <linux-kselftest+bounces-8215-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB52C8A749B
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 21:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C64B28201D
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 19:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DEA137C25;
	Tue, 16 Apr 2024 19:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4R5Gztd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BE6137777;
	Tue, 16 Apr 2024 19:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713295413; cv=none; b=kVv6fHwszAe2P0Uif05dGJuhEk5yCeEKtDggujvw1/YylBB1WKz/I8fV7rvBkZbtxfty10MmRO0aFsxaqTsYrZ2jcHQGbWMRH66xEge/Vy9dxtyLj/ntnYx1btJHCHMQu2nLQ15B7rfnbH/RVvjmCyT6HLln4QG/ToFndijT9Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713295413; c=relaxed/simple;
	bh=IxFBhcBuXhAaWMYafyfOgtB9dObEv5wh3weokm48AQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6qh0fNUES6YxUSI6jH9tjVugOgcfg1dBDc9YfXJXkzAKrbrXq4LZyFQ4BfDZ0G0ywiqfQUZOKPYwqlA4C3o2lyD1wrnCO8xeQP9m08pZEKK+sfHoa1buTaCUOUO163YJjSSQa6qMy4BFl1oCzfUC6EgURVp3d25RhSnQBYjcE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4R5Gztd; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2a53e810f10so2972225a91.0;
        Tue, 16 Apr 2024 12:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713295410; x=1713900210; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ViIRHIDHyA9RsYj3V5deXpjEvZ4mPNUGbf3dBlxIbKw=;
        b=D4R5GztdQQ7fX9MvU+pfBdstkdsK2YWF8tg/+a9scAA8FZaWDIU67KJxgOobjhr9ZI
         eryHjkU1CAbTvIfV/sbP3oZBb/uN7CK7i/xTjCs+HEFELJaGBRdUvDkGa8VYuIHpDoHB
         K3fyZ3NQsDqrzfLh3YjZzBjcr3HOHEjnAHGAIXK6tjuap75rtQHNZ3hktRHTKbXVIYPV
         WM+glirb/KtKSHothhQkh85n+njq4t5u8OZcFl5eoooiyBD+kchEg3dzwSsp8KwfY6RB
         kgdA58/JjVnyjAAcE+4RrOCwKeLWtaMr86XNJzoNYJTtVwZHw9MyugemKXjcxpwUtdOl
         cpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713295410; x=1713900210;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ViIRHIDHyA9RsYj3V5deXpjEvZ4mPNUGbf3dBlxIbKw=;
        b=cC22ppDm0t7zugREsH3cpc36aPS0fiXDIK8gBpl2vnhtV4kWSqf0jQkMjOG6BDIJBO
         l1mSOwK7PzYDuLANdg7niozH/U9VgsahhCDOZtQP8MuF35AxxVEalrqm2/orYV+WnVdr
         35GACPQs7Wu4DvwmTzUdWtDUwzECKJmlUoC6NexOWbuBrn1x2mtmUNWWieb/OLCAa19Z
         0AwUcwi/aum+NmIRkw1NpAyuqbdCdQoFAik/bObtaDSXadOJaIOYnISgJ4N1IEIKbYsB
         QRWgbSg0H39afaAi33vo5HQO9XDSHn9kH7XVbLN6swMDe5d3xzLdv4S6oN4AJMkPhTkM
         D3tw==
X-Forwarded-Encrypted: i=1; AJvYcCVyx6QZZ9vRq11vRrcrCDz0yOo8roD/9sJ7WqLVHTpQzgqgU0jNYRqugHULy2mjdHQHty5iQ+vfbpNnvjoVndhJRI2M+WVYndK6jO7BbrKpb4qmCnx1dzsHUFnypdu1hw6JEIZ85xrd7+sb3Tw9qrfDNW2c9gomyUklje9kcnNoUk7J/GhSh49v
X-Gm-Message-State: AOJu0Yx6FPiiGs2FTuyHZkp9CCOPNEOyi9BR2giAPhDcBXayZuc6lPYL
	VdiKiUYwh14cEOeQtqw4kehPQrbhJB2Bb9H+fiYkzYfZRdjB3VbQ
X-Google-Smtp-Source: AGHT+IE2br9IFwohZaNTezS9EaNHNUE9a9LyHYvBDfqBixBaHoEaLGwVptV8CqJKNiQ4rQOiXRbRjw==
X-Received: by 2002:a17:90a:8c9:b0:2a8:2cce:9f46 with SMTP id 9-20020a17090a08c900b002a82cce9f46mr5757716pjn.30.1713295410026;
        Tue, 16 Apr 2024 12:23:30 -0700 (PDT)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id d13-20020a17090ac24d00b002a706910b05sm7471906pjx.9.2024.04.16.12.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 12:23:29 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 16 Apr 2024 09:23:28 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [PATCH v4 1/6] cgroup/pids: Remove superfluous zeroing
Message-ID: <Zh7QMGhNKMQR-OSz@slm.duckdns.org>
References: <20240416142014.27630-1-mkoutny@suse.com>
 <20240416142014.27630-2-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240416142014.27630-2-mkoutny@suse.com>

On Tue, Apr 16, 2024 at 04:20:09PM +0200, Michal Koutný wrote:
> Atomic counters are in kzalloc'd struct. They are zeroed already and
> atomic64_t does not need special initialization
> (cf kernel/trace/trace_clock.c:trace_counter).
> 
> Signed-off-by: Michal Koutný <mkoutny@suse.com>

Applied to cgroup/for-6.10.

Thanks.

-- 
tejun

