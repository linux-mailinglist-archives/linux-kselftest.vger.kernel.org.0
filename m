Return-Path: <linux-kselftest+bounces-43662-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C75EBBF76AE
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 17:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79AB218C82BE
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 15:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6235132F756;
	Tue, 21 Oct 2025 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HhIumMNl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31DC2F3606
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 15:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061051; cv=none; b=qBWRRs3zPt3mdLJ7ob7S3zqQGQaK5t6FQFck82VQCMbMbKtPlU329IRygpKDsX6kCHda7Prz94qIDAIfqXOV02Jc2fWhdb8B8upFSGKq0c7+yvXo52v9ssYll03/4U70YGbmTDjULadofCWau26SskCbs3TAMHavKxxWwO8L1hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061051; c=relaxed/simple;
	bh=4/l4+SlVpPCgIYTsJGQ2gH2usjlH2XkI4YAp9vdUzqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qtrcGutTfrTY99/CEY22Hh1zkYWgQ0QiME381v34RBhJVwZN9w72IqoTvWEC+rKo/S6zFH6kAhIYjqK3+chj17a5Ys0GLpxW9WxkkZkoAOT9yky0ZsHTvO+DKFhtO2TlkLuy7Tj2WixPMXL/9MMwg98aCL4uH5ANkkKD0c0inB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HhIumMNl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761061046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=L4XNx7SmcphwVa2FHvlNJ8vIAO/gR3f+gwX24U6J0nk=;
	b=HhIumMNl2gyENemX9mVeKdrj1/oG703ip3fm3G9lRRI5KH4n9nt509ZPuliHxOrjzFWTD6
	YsYkKi2MZ0S0PqrXI/eb7LKiiAw7nfuMPktAf8mQkTVnSDGHBTzyvWIzP2wZVZ1XCrfm7J
	3d3zhU8TTwzQfNadt8HhxJqmDfb8cCI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-bEnlapjQMQ-SJHZSlKVxBw-1; Tue, 21 Oct 2025 11:37:25 -0400
X-MC-Unique: bEnlapjQMQ-SJHZSlKVxBw-1
X-Mimecast-MFC-AGG-ID: bEnlapjQMQ-SJHZSlKVxBw_1761061044
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-470fd59d325so29630355e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 08:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761061044; x=1761665844;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L4XNx7SmcphwVa2FHvlNJ8vIAO/gR3f+gwX24U6J0nk=;
        b=ipf9CPLoQ39VGo6sfRrdWc3tQtszQgV16ZheZFJDpQ+r+KpT/jyifKwjBAtil1m9A3
         ie0L826i3Tfmxldd15UO7L6FXQ+X7H41x6OxxxXMIbFos5RkUBJE1gJEsnGBBDizC4rt
         9B6ELrtYPLTifk8iXFUjyURMJ4vzBNWHsMY/Hj28rlhNDBHFhcOQeHRERLt/zc+ahg8T
         ViOJfFWgknJPZbeQ1WlGLEM6xC7xFkzMtQej4gnmiPSvMiAiDDg1sNbZhNtMioRiNF8G
         rdXvTxSULjs5Ls3L2dRbqkWzrxShlYxai+E8jgoUJ0DLqXqAm3ijZuO+ZYSLUGBaBCTU
         kJJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq5Jvz+zWGwOFowFIyPYLPxs5WLwVJrCm1J41gsjropy1UaDe+povf81E4V08TongtD8JATp0EOHhdTdPthyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi/k27OYdwma+29MVM4/K5qGIx8kI1CnDMOepEah73GAp+J/GP
	ZAjg9g4b5nP0Qt+PSJ8qu1MBSnTeN/Ay0CTJ9gtPFfYJdAJbxwZxL1plWQer1p3+366jw4opIGj
	XHKFxECSW2QESTUu+smDOqXWTXVEiwfJtGgHJUrYGwJMGE7K5kBjBelVsKKIPeXxe9rA86w==
X-Gm-Gg: ASbGncs4lPtH23vghRJsg1m5exKEnbHLK4lKe+Av1zrnIARc8AQVZZfkuLiAKBCxnBb
	jJI+pw75qWy+qoz4oRECwfC1suyFElSE85MT47vx6Gg/S+akI79GJCH9cJJRsiNHxOzk2U4VuL8
	nTm3Qv48edWlRf5IVkcIrqjd/5Mu/l4rzzpULVwPnl+ft+daiGz+OODaTJV+M4oSoGuU4H/EGDg
	KyxLIIoTlXJ7OwUV7UOjR6bWsUg7FvXs8bYL8zIiBOrJlINVlStOxBrdX4g6nkPAv8qBmz40JnW
	uS1qFlir9tzxQvOXAI592lugvqp0s6kuLy+/bpPBKumAkuviapEV0rEQpRv8FjL7w3HsFpOjI8U
	e8ZWGy3lVUU55FE5ZrTf8ApjOp/g5bv/AQcsRxxjXlgsNJ0nyjU/H+wLqg/ZDUqAtYTW61aqbL9
	GrWnErw31tJG7I/M6G9ujewRmxU/c=
X-Received: by 2002:a05:600c:1e1f:b0:46f:b42e:e38d with SMTP id 5b1f17b1804b1-4711792a2admr124898895e9.40.1761061043903;
        Tue, 21 Oct 2025 08:37:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC3Ou7fO+S2/Nmjwjz5SUjJ9OhpSFk+6BtYv7TJRJbyItQGBbbudeiO9N85CmNh9nSNHimAQ==
X-Received: by 2002:a05:600c:1e1f:b0:46f:b42e:e38d with SMTP id 5b1f17b1804b1-4711792a2admr124898525e9.40.1761061043399;
        Tue, 21 Oct 2025 08:37:23 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496afd459sm19717555e9.1.2025.10.21.08.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 08:37:22 -0700 (PDT)
Message-ID: <042629f9-f295-494e-8fbd-e8751fcbe7c0@redhat.com>
Date: Tue, 21 Oct 2025 17:37:20 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 PATCH 1/3] Documentation: add guidelines for writing
 testable code specifications
To: Chuck Wolber <chuckwolber@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Gabriele Paoloni <gpaoloni@redhat.com>,
 shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 gregkh@linuxfoundation.org, linux-mm@kvack.org,
 safety-architecture@lists.elisa.tech, acarmina@redhat.com,
 kstewart@linuxfoundation.org, chuck@wolber.net
References: <20250910170000.6475-1-gpaoloni@redhat.com>
 <20250910170000.6475-2-gpaoloni@redhat.com> <878qifgxbj.fsf@trenco.lwn.net>
 <85166a8a-ad54-42d0-a09f-43e0044cf4f4@redhat.com>
 <CAB=6tBQP3aCDWch4ZcEYMqFsJ4OKXSyC_hb9V9hA7ZZty7vFeQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CAB=6tBQP3aCDWch4ZcEYMqFsJ4OKXSyC_hb9V9hA7ZZty7vFeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20.10.25 23:02, Chuck Wolber wrote:
> [Reposting with apologies for the dup and those inflicted by the broken Gmail
> defaults. I have migrated away from Gmail, but some threads are still stuck
> there.]
> 
> On Mon, Oct 20, 2025 at 7:35 PM David Hildenbrand <david@redhat.com> wrote:
>>
>>>> +------------
>>>> +The Documentation/doc-guide/kernel-doc.rst chapter describes how to document the code using the kernel-doc format, however it does not specify the criteria to be followed for writing testable specifications; i.e. specifications that can be used to for the semantic description of low level requirements.
>>>
>>> Please, for any future versions, stick to the 80-column limit; this is
>>> especially important for text files that you want humans to read.
>>>
>>> As a nit, you don't need to start by saying what other documents don't
>>> do, just describe the purpose of *this* document.
>>>
>>> More substantially ... I got a way into this document before realizing
>>> that you were describing an addition to the format of kerneldoc
>>> comments.  That would be good to make clear from the outset.
>>>
>>> What I still don't really understand is what is the *purpose* of this
>>> formalized text?  What will be consuming it?  You're asking for a fair
>>> amount of effort to write and maintain these descriptions; what's in it
>>> for the people who do that work?
>>
>> I might be wrong, but sounds to me like someone intends to feed this to
>> AI to generate tests or code.
> 
> Absolutely not the intent. This is about the lossy process of converting human
> ideas to code. Reliably going from code to test requires an understanding of
> what was lost in translation. This project is about filling that gap.

Thanks for clarifying. I rang my alarm bells too early :)

I saw the LPC talk on this topic:

https://lpc.events/event/19/contributions/2085/

With things like "a test case can be derived from the testable 
expectation" one wonders how we get from the the doc to an actual test case.

IIRC, with things like formal verification we usually don't write  in 
natural language, because it's too imprecise. But my formal verification 
knowledge is a bit rusty.

> 
> 
>> In that case, no thanks.
>>
>> I'm pretty sure we don't want this.
> 
> Nor I. If you find any references in our work that amount to a validation of
> your concerns, please bring them to our attention.

I guess, as the discussion with me and Jonathan showed, the cover letter 
is a bit short on the motivation, making people like me speculate a bit 
too much about the intentions.

-- 
Cheers

David / dhildenb


