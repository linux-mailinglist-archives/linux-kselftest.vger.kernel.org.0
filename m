Return-Path: <linux-kselftest+bounces-25713-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56948A27924
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 18:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 771543A552E
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 17:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6B3217647;
	Tue,  4 Feb 2025 17:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ey8mhd/p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201B7216602
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Feb 2025 17:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691790; cv=none; b=Dl9Gmk6s78iI6rfvepbny33l+6EqrP8mYZj0ztkoNPYpWkX55S4GYn94HO+SBvvQml9wlHh2xJUL/zNw2kPQCRZ7fgyUSYppfgVZmNy6OjMt6YxTmo3HQIfLe2oB5RJjW2sidgyPqHPIFJPFhB5v0QmqInEuGAYq+mTiKF9f2yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691790; c=relaxed/simple;
	bh=m670b6vZ0EmsoJkmownLJxz8JU2YptA7G45HSbgfDp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ljb62DsdY7Mh1/Qny3ui83PwUFh0JxzsNQxWo641kpq/HKIjsnuLlRTpeL4wUr8tsOZ/J2AXaPi/Zlbma3HMxxlHKHO8fA3atxoG1oHLQJ0qno+95wdHeho3n4OGERHAQqzX1LMr1W0GGZOYvmCgnFU/wn7v86ug1ChoIIqcQ3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ey8mhd/p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738691788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y7rTv22+08/qF0nM+ECThVkoy0LVlXk9luYfrRe54qs=;
	b=ey8mhd/pYZA6DoNO4vZ54Y9nUxbUHyxdeNonzRQUgrCq5R6+bVyCR8VEQgzIOTgs3E4RRM
	A75/QZoG0qfU0kH8rWMVUopIP3ZRa8HeSF8jz5dq3ylkGNceyLJo7XmC/fVeG/InbD63jZ
	GsWuG8VEu4R6ryBXMNccsiNs5C90DRg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-dopMYptqP3SnK9e5wt_w4g-1; Tue, 04 Feb 2025 12:56:26 -0500
X-MC-Unique: dopMYptqP3SnK9e5wt_w4g-1
X-Mimecast-MFC-AGG-ID: dopMYptqP3SnK9e5wt_w4g
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43651b1ba8aso42248485e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Feb 2025 09:56:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738691785; x=1739296585;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y7rTv22+08/qF0nM+ECThVkoy0LVlXk9luYfrRe54qs=;
        b=wzs5rDlijCzQO0Zq9fmqTZyep+pc+H+y8wMmdiHKUVtFZ3PQ/HvlgtwYOiXgC9KigD
         m/2nZOzOoqX8a6a+RYeihfICeGRZNy4BX+cbmesBVDdULhh0OcpBROF2JuseobSsNR/R
         zaystn/1FJHeKP3LrP2xmmeavUI2sgFqPP4/F0haxaNhvfPSNzqQHgY8zLm2BzShqcAX
         jzjlJqGvHEXNKKea+jQ0LKmeYHFft0tpizTUdCclWySB6mSH1bS2Ly+x7Wysby7qU19r
         KgSQVGWefundgNoJN0TSpYtDt+aVmBV1g4CXcMslrYWfos97DdUHQCS8b+US9xv6IbL4
         t0Qg==
X-Forwarded-Encrypted: i=1; AJvYcCWhcTrocgci1oN/gSbYTEXnRL1A8FZZMg7n/rhND0SozKthDmH7/dckwNLTds4AfsAt0QRgceC7r0JOvMFKqTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRNzDmS5QZMWBKQxe98DFY4zmojEnRiipK1oBcBt3umTwaqReG
	k2R4eQMzTAor/ruzfLZ70Lc7G0ejVKvJTjHV9hx/6E9UnL3DuBMHnCYqrlBQ0PDh+oS+W7HPK32
	SM/ukxtJyLI2JZqvFSaee7MaLVXtcVgL7tJaSJg1J6j7THllSnZjBV3e+6d0U5LOtxQ==
X-Gm-Gg: ASbGnct47dQdeRNz0wpMBAEZLqVebTftyQPmbbJyuA0fkGgzT/UsVq7IDVLNe4lptqS
	/yNJ0n3n5/XgysxOL+8mFg4Ad/uTTf+axTIUlX9zqZTbfysav6JJ2fCcHNuOQWicQTB3J9R6tvg
	+b+ep0XQtRqwMLv95REQzX4u8Qc9uiAE0OvVuiI20fQx+qNvplur16iXtiqIGlF3taLppp+KlMk
	nP2MwZFHP7pC1T/In7Wm8GA3q0LdwyUt0yGGG42uSJweoh4q1Moe2TO+uh531wPisGCTQK2LP8P
	YKz5a/oRFo+GQYFzd8RDqUrt0eRqqLE/2u0=
X-Received: by 2002:a7b:c347:0:b0:436:6460:e680 with SMTP id 5b1f17b1804b1-438dc3cc9e6mr253181045e9.16.1738691785276;
        Tue, 04 Feb 2025 09:56:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCE1OD75AvFxX4Ocn0Vn8riU+bmAUBASRVK771tFjkbz9SV1IT6+srLah/Dv8CbvHWMOv8og==
X-Received: by 2002:a7b:c347:0:b0:436:6460:e680 with SMTP id 5b1f17b1804b1-438dc3cc9e6mr253180785e9.16.1738691784822;
        Tue, 04 Feb 2025 09:56:24 -0800 (PST)
Received: from [192.168.88.253] (146-241-41-201.dyn.eolo.it. [146.241.41.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438e245efbcsm193857215e9.33.2025.02.04.09.56.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 09:56:24 -0800 (PST)
Message-ID: <71336d4e-6a75-4166-9834-7de310df357e@redhat.com>
Date: Tue, 4 Feb 2025 18:56:21 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/6] selftests: ncdevmem: Implement devmem TCP
 TX
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Neal Cardwell <ncardwell@google.com>,
 David Ahern <dsahern@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
 sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk,
 Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>,
 Pedro Tammela <pctammela@mojatatu.com>,
 Samiullah Khawaja <skhawaja@google.com>
References: <20250203223916.1064540-1-almasrymina@google.com>
 <20250203223916.1064540-3-almasrymina@google.com>
 <c8dd0458-b0a9-4342-a022-487e73542381@redhat.com>
 <CAHS8izOnrWdPPhVaCFT4f3Vz=YkHyJ5KgnAbuxfR5u-ffkbUxA@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAHS8izOnrWdPPhVaCFT4f3Vz=YkHyJ5KgnAbuxfR5u-ffkbUxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/4/25 6:35 PM, Mina Almasry wrote:
> On Tue, Feb 4, 2025 at 4:29 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>>  .../selftests/drivers/net/hw/ncdevmem.c       | 300 +++++++++++++++++-
>>>  1 file changed, 289 insertions(+), 11 deletions(-)
>>
>> Why devmem.py is not touched? AFAICS the test currently run ncdevmem
>> only in server (rx) mode, so the tx path is not actually exercised ?!?
>>
> 
> Yeah, to be honest I have a collection of local bash scripts that
> invoke ncdevmem in different ways for my testing, and I have docs on
> top of ncdevmem.c of how to test; I don't use devmem.py. I was going
> to look at adding test cases to devmem.py as a follow up, if it's OK
> with you, and Stan offered as well on an earlier revision. If not no
> problem, I can address in this series. The only issue is that I have
> some legwork to enable devmem.py on my test setup/distro, but the meat
> of the tests is already included and passing in this series (when
> invoked manually).

I think it would be better if you could include at least a very basic
test-case for the TX path. More accurate coverage could be a follow-up.

Thanks,

Paolo


