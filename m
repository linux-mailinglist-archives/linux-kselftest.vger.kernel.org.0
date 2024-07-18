Return-Path: <linux-kselftest+bounces-13854-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C7C9345B4
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 03:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A87BA28445D
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 01:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4EC10FA;
	Thu, 18 Jul 2024 01:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmfjzSSs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FD91BDDB;
	Thu, 18 Jul 2024 01:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721265893; cv=none; b=DnPbO9PZXTRJdCFDmmf7+1C+NyhphuWPk9dBko8aewjYiPb+NPF4zNx02F+1xgBPP/IdCE/I5DdWS6JY3g0INzLOO6Ltqr/0PJPlwyO22CtmCP8X/j9mPflWAOeNRE0VCCacsvQkjKab0V+gt0y47q010r1GiYpBSpLjq9rTuUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721265893; c=relaxed/simple;
	bh=MxdrzEI5TAw+xhe1QNg8OAKv+izkFV/DBdlkmjK0O9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktztXQmmuSpVgLpdtzyKifc2zltK19+OJn+Qm4yT8DaGbTmCwj8FhVZ+jZLvtJ+Pvf0RfOQLCDeBrnuzrJ+weS31e/Y/9I/Ex5mz1cI2OSqjnMJhFWQBpecJi1B9kqmqZf3hGsOnNtT7zdULIH9kdF/URmGdRx8CC4BZGoipnh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmfjzSSs; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c9cc66c649so171448b6e.1;
        Wed, 17 Jul 2024 18:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721265891; x=1721870691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gQNtnKrhFtO13VagV8HA7OXr7C3K2JA1TX8HuWa49AU=;
        b=VmfjzSSs2Lmrbw8pi0pQAqwDIygWg4L0wFKOZ3r3KIoNlhrDQsba2WNMwMQlGBvzPJ
         WhAd+aBB6hz92Lcbl99n1fmjE8qG/YtwK4hYC/dGlXWevEsJz02Uy4EdQ7lSLGvuEiHE
         +uJapFm8LDWIkjTI1570mel01T7b/lPNvJekTENRK4w9nUoaWntVKaPK5GiY4EKpN7Di
         eQ0hsPOL9KTmCaYgJK3aD/5qHDLujCVJSbaLdVLkpVx56Ihn+jujohyQ4vG3QOZc/rUN
         HNQchuxfiGGjY8Bazff8izcWGKCrav+5CQ04Cxgo91SlRda25SzbG238Rt/1dm4upP9n
         l/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721265891; x=1721870691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQNtnKrhFtO13VagV8HA7OXr7C3K2JA1TX8HuWa49AU=;
        b=h+VacZbWcFLh7NLYN8nHJHUBw2kofsIaSYxlIXdljRX13twPrZhQEN1amoCy7PmpFp
         ad39pDCqDhfPz2AsnlYICkAnuVFBweKUVCn+k05YRDghsiZBnaWPwclcRCfBNXKJvPQk
         9g6ZgDS1zK8o1jIz0k2ReDVnRJB3m9fSHpjCC5JYp8D2IHjj2nEcvuMMC4kpuWaDUUnE
         IrraUB68WvvvX+ZXRG+d26oo1qj72zp96UbZpzXo+3Lk5wlsM/6snQyO0+nxQ8XYkz2o
         2XkRXKJgIVBVonN8GNlTByED/9/6MnDHcyf6iDtQHwFOVmLbjbI10G8NHUh67A2feyvH
         aA7w==
X-Forwarded-Encrypted: i=1; AJvYcCUV0PsaROU5WxZ8e+sg9H8/Aj3ndfMV+OioqIo3/DpgdhLVgJrIJwGJpJtDeY51VHPCF0LG6raA2p0SK18R9Hod86Mfpr2SHYpfJwqsPh8qwkjBmEnXH4LxWtAl77BFnpvA07SlfoPPs8ELkj5Abhuh0hGiwOWebLLtf9Y/NxME4JXTlw==
X-Gm-Message-State: AOJu0Yx5xtD6b2Hm6WQFKttlhVTrDbups8Viwqf53WGffNBNY1OMZeTV
	GLoYTBW3d63lNt5WgIbGOgLFShiCu7Q/exg1hcmZOKG2y4Gm5tGo
X-Google-Smtp-Source: AGHT+IFskbJPGL4FR45rPVai7E+FgAv9lrfLD+0WVnqBaVOiIStnDRYbtBAbFfk7sXYaG+c0L+hS6w==
X-Received: by 2002:a05:6808:309b:b0:3d9:2cc5:190d with SMTP id 5614622812f47-3dad52936abmr3088964b6e.38.1721265890868;
        Wed, 17 Jul 2024 18:24:50 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-78e38c951c6sm6804246a12.61.2024.07.17.18.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 18:24:50 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 17 Jul 2024 15:24:49 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: David Finkel <davidf@vimeo.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, core-services@vimeo.com,
	Jonathan Corbet <corbet@lwn.net>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shuah Khan <shuah@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
Message-ID: <Zphu4SDGCJ-IExnf@slm.duckdns.org>
References: <20240715203625.1462309-1-davidf@vimeo.com>
 <20240715203625.1462309-2-davidf@vimeo.com>
 <ZpZ6IZL482XZT1fU@tiehlicka>
 <ZpajW9BKCFcCCTr-@slm.duckdns.org>
 <20240717170408.GC1321673@cmpxchg.org>
 <CAFUnj5OA0KaC54M9vd8W+NZJwz5Jw25u-BStO=Bi2An=98Ruwg@mail.gmail.com>
 <20240717204453.GD1321673@cmpxchg.org>
 <CAFUnj5OGJtR0wqOZVUh8QQ3gaw4gmatsEN1LcBdcwN_wx-LUug@mail.gmail.com>
 <85a67b00-9ae7-42a1-87e0-19b5563b9a0f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85a67b00-9ae7-42a1-87e0-19b5563b9a0f@redhat.com>

On Wed, Jul 17, 2024 at 07:48:40PM -0400, Waiman Long wrote:
...
> How about letting .peak shows two numbers? The first one is the peak since
> the creation of the cgroup and cannot be reset. The second one is a local
> maximum that can be reset to 0. We just to keep track of one more counter
> that should be simple enough to implement.

What Johannes suggested seems to hit all the marks - it's efficient and
relatively simple, the overhead is only on the users of the facility, and
flexible in a straightforward manner. I have a hard time buying the argument
that it's more difficult to use - the benefit to cost ratio seems pretty
clear. Given that, I'm not sure why we'd want to add something fishy that
can lead to longterm problems.

Thanks.

-- 
tejun

