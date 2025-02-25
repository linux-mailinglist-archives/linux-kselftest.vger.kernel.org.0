Return-Path: <linux-kselftest+bounces-27481-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864F6A44740
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 18:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EA837B1DD9
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 16:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17C920C02B;
	Tue, 25 Feb 2025 16:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z4uUfH49"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550D21A2389
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 16:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740502105; cv=none; b=bAjUTc4eC5rorL9fRkRbAFPnHmiHvFtBgekz6Pdyou3KvwWj6D/4YaCXjS6xvDV88QeZvc/iNiDsIGhuzBrtiuUPok8lPaAzywBPxcImLLs4NoKplwsSzuG6Rzrhd6QLbUdrQNPMAyHkGYoTp1UtJT/uCpCRBE+ptecaIvhuXSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740502105; c=relaxed/simple;
	bh=QLeXofl8oz+1YDj2uHG9Af1DIWMS8S6ol/g/+nY++FQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kmw6e7y9CkOyIujBKs3PDc4D2dWt31wyvMAz7i1cArG4DrJdUZPPo2Za/+AVfi2LsEestGYAMhCI6QmV4MZ1JmGdRb3jnyY1Dlzk/QSYfT0z+NGq0wh0lrtckHylurZJtK96cHWMbEzYfSkrSX99cnjr23w0xFVhlvuyyvYyeDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z4uUfH49; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740502103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jw2CX8GJqxuLRFAFx88zTCcWlXcKTO/rHj8BJTgdWyk=;
	b=Z4uUfH494yPKf+qWMKBmLoNxiI948PB3j16TGiZaRDoTA6wdKzq/SC/oNJzzORITsJvrYv
	jrissvshBpo4KYV1rZfT5nfgKJ/MOIpjtOgj94kB4S6IQB8yREvzSo5VTTbV9YuoxFZWmH
	HSKcZuLTKMjUm2R9EKLP069+Ypfy5v4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-l053ePB6OQeY-YgjtBGbQQ-1; Tue, 25 Feb 2025 11:48:21 -0500
X-MC-Unique: l053ePB6OQeY-YgjtBGbQQ-1
X-Mimecast-MFC-AGG-ID: l053ePB6OQeY-YgjtBGbQQ_1740502100
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-439858c5911so27922885e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 08:48:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740502100; x=1741106900;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jw2CX8GJqxuLRFAFx88zTCcWlXcKTO/rHj8BJTgdWyk=;
        b=K0yx2B1xOud61ZhwM4dxJ1kSSWJh2raDZayZWZAMjxYIyj4xuJ+NfG7rJ0fYYk9D+A
         Z/U3uNWETnIVpbgWptNAPNHYdgQy4KlUWgjz1ALth9j4wUXHxjBZ+qPEwYJHHcYMKrxm
         G7MAmPo+865E7zoNiaVPDewq6m/cA1IxzdHM+WeyDRshuZb7EKp0HmFeJNcIemgZJcJh
         wvib24GiyS60M/VfVKzhIPPLXAYqOAttfLKxt4r/hB6xUGHkkm9zHwGBXLdWreFM98y8
         6L4PChYl0mIwvWnFoN38dduM8Q92v4UGc0cubkx6KAqzdElJdlLHjiWOZq525owjjJvN
         PZUg==
X-Forwarded-Encrypted: i=1; AJvYcCWsnXifOuaLBr+GVbcfCWCjgtwnbUq8e8nS7pLI5BtzQ2g8Eg4OG84trOMQT8jcDkDHzYSK2DbWF4M/nRajft8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9g0qYqKAhu/J0vFlamN1dzTqNqI5wraAJSvCDDsvwJSnwWNcp
	A2Q7yCnz0Xm7n7wp72p7wZHGDhheZ+JSo8p8Hcah//8K3vfq463lmH/MDkbgUKaN7ureznI3o8n
	4hjl42j9kOYOWoDGBPZk46psaFOdC1cR94/+N6rhkarx01j1TlSWLZBKdkBbGLdjMcg==
X-Gm-Gg: ASbGncsfUBPUoXQGf3WZJ9tgIt5xtAM2Xu7aQLYWvWVtLNCLmvc8ghVHsgFB/hGGZsS
	Y6ZXot1qriB0FULYNFqzhXp1+VxQM9rbBDM8rCYBNYfDt255sExLxOkKvEmT0uif6FtYcJRFQOy
	JNOqrTpODilJxzyxzNaw2mu8YEfAXuAzRNqekVVpPHw/FmRtRUsq3ls7vx/CtGBYcx54+LTaw8V
	ciPQV/ZzjnhASQ0AeJnm5W+qvjMPVD5QlerpnBZl6u/qFll63rXFw7+m2Y5tDWvwoHo6QsE2IkE
	ON7X1y0JMTBJRBmQ4WOgFmGJxYIvvDztQPkI5rsRG59itUq6srWPC/y6lBBjxUL5V7DLZi2eeIE
	Q+kHx7rMVVZF2mnhSIcFBneSYAMadr5Lj3+VYBpf9iDo=
X-Received: by 2002:a5d:59a3:0:b0:38d:e15e:17e9 with SMTP id ffacd0b85a97d-38f6f0b2161mr20087647f8f.35.1740502100269;
        Tue, 25 Feb 2025 08:48:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8sdF4FkFqdZXDiyQJpYRdr9jotf0bgjSy0tUCoeN9Ynzu8FAq0ynzblVc1iJsuqV0PE3uGw==
X-Received: by 2002:a5d:59a3:0:b0:38d:e15e:17e9 with SMTP id ffacd0b85a97d-38f6f0b2161mr20087605f8f.35.1740502099887;
        Tue, 25 Feb 2025 08:48:19 -0800 (PST)
Received: from ?IPV6:2003:cb:c73e:aa00:c9db:441d:a65e:6999? (p200300cbc73eaa00c9db441da65e6999.dip0.t-ipconnect.de. [2003:cb:c73e:aa00:c9db:441d:a65e:6999])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab15476f0sm32638635e9.23.2025.02.25.08.48.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 08:48:19 -0800 (PST)
Message-ID: <48ffe442-5015-44fe-bbd6-708ba8500505@redhat.com>
Date: Tue, 25 Feb 2025 17:48:17 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] mm: permit guard regions for file-backed/shmem
 mappings
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, "Paul E . McKenney"
 <paulmck@kernel.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>, Juan Yescas <jyescas@google.com>,
 Kalesh Singh <kaleshsingh@google.com>
References: <8d643393-ddc0-490d-8fad-ad0b2720afb1@lucifer.local>
 <37b606be-f1ef-4abf-83ff-c1f34567568e@redhat.com>
 <b5b9cfcb-341d-4a5a-a6b7-59526643ad71@lucifer.local>
 <0db666da-10d3-4b2c-9b33-781fb265343f@redhat.com>
 <62c0ba1c-7724-4033-b1de-d62a59751ca5@lucifer.local>
 <a49d277e-128c-4853-bdeb-3a94134acbf6@redhat.com>
 <6eb33b5d-3040-4637-b627-48f8f78e4e28@lucifer.local>
 <b30a6306-d62b-4515-add8-4550d044501c@redhat.com>
 <c0e079bd-a840-4240-93ae-0ee2755d425a@lucifer.local>
 <e0954e13-2c7d-447c-ba86-19875c74bc3b@suse.cz>
 <3102ab3b-67b6-4047-9db7-e83c3b9c1c53@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <3102ab3b-67b6-4047-9db7-e83c3b9c1c53@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> As for compatibility with VM_LOCKONFAULT, do we need a new
>> MADV_GUARD_INSTALL_LOCKED or can we say MADV_GUARD_INSTALL is new enough
>> that it can be just retrofitted (like you retrofit file backed mappings)?
>> AFAIU the only risk would be breaking somebody that already relies on a
>> failure for VM_LOCKONFAULT, and it's unlikely there's such a somebody now.
>>
>>
> 
> Hmm yeah I suppose. I guess just to be consistent with the other _LOCKED
> variants? (which seem to be... undocumented at least in man pages :P, and yes I
> realise this is me semi-volunteering to do that obviously...).
> 
> But on the other hand, we could also expand this if you and I see also Dave feel
> this makes sense and wouldn't be confusing.

Just my 2 cents: one thing that came to mind: an existing library would 
have to be updated to use the _LOCKED variant if the app would be using 
mlockall(future), which is a bit unfortunate -- and if it could be 
avoided, it would be great.

But yeah, devil is in the detail ...

-- 
Cheers,

David / dhildenb


