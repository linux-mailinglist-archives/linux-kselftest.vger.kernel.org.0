Return-Path: <linux-kselftest+bounces-30123-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDA1A7C25F
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 19:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 929BA189D703
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 17:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D0B214A7A;
	Fri,  4 Apr 2025 17:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+AVct5s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D776813D539
	for <linux-kselftest@vger.kernel.org>; Fri,  4 Apr 2025 17:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743787539; cv=none; b=WUgjj133beyQK5SJZIsxd/s8VOEitkmdWKrmr7P/6FAFcXhOkeOFhubmtcPfKibd8/VuiZW6AHNRFfbuIC6V1NWNy/WAND50rd2qRzNhz+mauWFtMnn0q2+OH8+lJHF+PIksT2J9k3lc/73i4FUUfkKTJYo9ycz9EuItrGPUkRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743787539; c=relaxed/simple;
	bh=UIONdw5KXPgsmLhBGCkNGI+fIM7vKA5uHxq4ySw2mXA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=s4otgR3d69jdpNdGNSoiUxC5kcrKFuCmOKSPzQDKTpuIBLoNYfjs8L8Mz9CaRJCDRqfD9DogCjvpTqFiKc1HbFIEYur8kxm9eE14h+61N2j/NyiQPEXYu8IclDlB+DCpVDeePWxgnYL9swhRr/h4xNixwWG620enmNqTXLOB0FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z+AVct5s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743787536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zY1OdvQqmeKzz5CfMBTTTFp4WcoqAgk+p41C7P+KQBs=;
	b=Z+AVct5s9URF6i9nDm+/GyP9PESXVy0zxt7HlRXExEu6BdE995eWhtUHPE8MIgXsDBqsHm
	3t1iuXUnrbjt6rlJIFSvLjvCb4Q8HFo/YGOSJzdXn6Eq0NomObLaq4oFdmLyz6RZ59vPEB
	RDweDkjBrDK9JR/D+fdVa3uQQ+/zEc0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-itqkRHSGOmGLqMkaXhKkgQ-1; Fri, 04 Apr 2025 13:25:35 -0400
X-MC-Unique: itqkRHSGOmGLqMkaXhKkgQ-1
X-Mimecast-MFC-AGG-ID: itqkRHSGOmGLqMkaXhKkgQ_1743787535
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-476a8aff693so52657181cf.3
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Apr 2025 10:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743787535; x=1744392335;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zY1OdvQqmeKzz5CfMBTTTFp4WcoqAgk+p41C7P+KQBs=;
        b=vhPyBkRHnHmAOTMRjvZEGdeYJHCz6yopv/WmpLw8NAZvJtvRZQveYEBLe3wlghhs8z
         T09USBGt6kZQq/hekKu56Syxofj71Xt3MT+WVeermG1hBJU7ytG+8OpDk75uryFxdYbM
         hzRC1u8nE9GGkw01UIg1LWncyeLDrBkwZzWbrlecRFrOEvP+w9K/3m0ZelskIGxrS0U0
         EeB4Jlgc4k7vjDQ0ZvhQrJlBLbwXOr7Tytt74j9ogmi8+XTykf8W44ORrfr8FKDR34nH
         BjRWTRykOVzX4c0a7Q5PNTRDyqtkn7B3zYdqaxjXCVj2mrSvNnRUrvbkJNtSSQqGxqTk
         SONw==
X-Forwarded-Encrypted: i=1; AJvYcCXAPcWpcDEQB9LQ7hfQ8v29crjDlAah8lNWVAYapPSzQpSjEJqaN0Fh21dMcyBG0P5q+isOImAo88GItpRcq2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx53UtB+MZCRy/2BVsrCcbA2uinGP5RB+r2IrKF08x067g5Hyxi
	oJ7zhwpOUy5IWQFhpD/mawU5VvueeE4MG4mcLbDmDIPgC604hAwV9KOpm+92moCI1aWKrWT7iI0
	SHUac4WvZ771lX5EjPVEKhOPuQgsNJFKVPPIBeq6aWoG7kx7+XHxVAjDUyR3W6YNruw==
X-Gm-Gg: ASbGncs8ASIwY3OILTBWrSJJM19qXWmrTRvWugzm9IdPN/XseEwtawLBjvIPsnW3axK
	JOQBIdP+jxtHlsU7GpIm+hBny/cz1c3T7qYakoVIWNjltyyWKMhPxLqkCathxbN0N5PB8LcN7vC
	3DtV7yD3+TizmUgBRo6QNYD3uAUiE+FNfOqAxsXvCtcUMKlGcw5RHl4e4wBFFlBDwqK/gik0yy2
	QjSnPWSpjBhs2A0MuqM5eYgrlHov22cQq+j8sSrOMSzz3Zh1nFFOY6fWPQbPE4SnNbUwPeHRTTt
	Iw/ojEl9q0Z1UeuDY6c3Z+ojocVdG//z/Pj3T4e+AY4VCrZmLq0ZUDdIeciQHg==
X-Received: by 2002:a05:622a:24c:b0:478:de14:135a with SMTP id d75a77b69052e-4792595adafmr51652001cf.20.1743787534887;
        Fri, 04 Apr 2025 10:25:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPaEDXj6BQIt1pawQwBSb2n8E48wuGD6upHv6D0WAjJO96YQubjDzEqlaf96Y8LIMcvLc1vg==
X-Received: by 2002:a05:622a:24c:b0:478:de14:135a with SMTP id d75a77b69052e-4792595adafmr51651691cf.20.1743787534569;
        Fri, 04 Apr 2025 10:25:34 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4791b0883f1sm25312231cf.42.2025.04.04.10.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 10:25:34 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <1ac51e8e-8dc0-4cd8-9414-f28125061bb3@redhat.com>
Date: Fri, 4 Apr 2025 13:25:33 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] memcg: Don't generate low/min events if either
 low/min or elow/emin is 0
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
References: <20250404012435.656045-1-longman@redhat.com>
 <Z_ATAq-cwtv-9Atx@slm.duckdns.org>
Content-Language: en-US
In-Reply-To: <Z_ATAq-cwtv-9Atx@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/4/25 1:12 PM, Tejun Heo wrote:
> Hello,
>
> On Thu, Apr 03, 2025 at 09:24:34PM -0400, Waiman Long wrote:
> ...
>> The simple and naive fix of changing the operator to ">", however,
>> changes the memory reclaim behavior which can lead to other failures
>> as low events are needed to facilitate memory reclaim.  So we can't do
>> that without some relatively riskier changes in memory reclaim.
> I'm doubtful using ">" would change reclaim behavior in a meaningful way and
> that'd be more straightforward. What do mm people think?

I haven't looked deeply into why that is the case, but 
test_memcg_low/min tests had other failures when I made this change.

Cheers,
Longman

>
> Thanks.
>


