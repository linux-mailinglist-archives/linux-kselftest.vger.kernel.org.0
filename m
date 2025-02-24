Return-Path: <linux-kselftest+bounces-27345-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C5FA420AE
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 14:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C6F23AA7F5
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 13:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14E524887A;
	Mon, 24 Feb 2025 13:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q95ce8fp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC6723BD1F
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Feb 2025 13:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740403747; cv=none; b=NndwZwpd4IjZ/him5mRpYeIWZ+mqFVwJFHUKM8JmBmLfrTjGQVPmK0gcUG7zLw6RpkwvBOgOKGe5DR/6D0F68qUiuCdWIJ6VHib+3kErNEWgnrAIHCqZks7TEQEY3ocz7PF5JkSSx+PhAFonbXFotJvlJ05FbnBr/BuFgUqMKdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740403747; c=relaxed/simple;
	bh=SBcwAmLOhXm7SuSpgbHUaHrQW6ieoWUMEQUGkG068aA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gw0hqskAqWAsczzcnxRBU3WCsoM3HOuRJtmCAjNdiauJJJUiWaDFhSZCnLDqqhvzyt6LzOlUBvocCUNFz1hvQEqbgIrON1zFDHsabtuMpn6bxi2lXcR0ZCctCuz0rBQleB3JtLfKXTzJyb43QnIvdNf39fXSCVoAUvEK4YWKcQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q95ce8fp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740403744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eQf6Y228NlzTJoJrZZHGNU+9jrYkErx43Lx9XgAhQCk=;
	b=Q95ce8fpQV7bCEDD4FkpygQJlaqPKooPPMDdupAofC8d0zl+vMlVikGWYmIncLFqm2upmI
	MBQVlMov7KrtHorLg2Cz9DJU83hgk7ze589oiQX24Icf+zPE31x6MmKmrvdKnxQRXRNpmP
	t0FCKT6lid/Ya7bAjUd27iNFpONGJDo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-vhh9HkiRN9iOh6VsAlVCiA-1; Mon, 24 Feb 2025 08:29:03 -0500
X-MC-Unique: vhh9HkiRN9iOh6VsAlVCiA-1
X-Mimecast-MFC-AGG-ID: vhh9HkiRN9iOh6VsAlVCiA_1740403742
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4399c5baac3so31210635e9.2
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Feb 2025 05:29:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740403742; x=1741008542;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eQf6Y228NlzTJoJrZZHGNU+9jrYkErx43Lx9XgAhQCk=;
        b=gVKsj3ZVgPJA5gIfU9LUp6q+upi41jt1LWNBbQBH79hHSKcJ8a/TG73tk1nhJBvEHF
         rgZfyhZ3gu+UbAk1F9d9TZAeKLnKMrcGptCIvfwjNUf+nt6TYjyz3b1oW8WxVjDYZu5W
         J6Vb5iR4CIx37Iri4SF2Hn6lEAuki0GLx9n37jOvSS5ylNxxIyT1jDNYe17y6B4UOiCQ
         Ez4z+dTQvaTrBm1Y1VIkjam95e60zcPu4DZuC45U0dJ1ma8hDDDxFKw7yw8j6VAPTYYW
         AUBh6jVyeQBTairjwBXuF8202caVM48h2Z7QbP3tORTiIpcodVQxLnVaEhsHyIoXKZNf
         xbRA==
X-Forwarded-Encrypted: i=1; AJvYcCW3un+fhThlcFNkLeNPYtyEU/bS9kxi0MD1EQqwiRcV3vL+PwJ/diEcGRkdoieG6eIOUM48oGhjLAiMuHaE2yI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf822gD8AOgHqV8NEKMfdsET9jUmt90raFyxZW1E3UCJ185LRJ
	NNsbbRPefhGXJUxYPNXDW8q8cdBi/lU3vrVxzgM2IXoJM1F+uavNu5xySxZs38QnRKI4dE8SXM3
	y7Ikuxd/0jLI+2s1Gh63ExFvZMjJAlzFdjq8C9VrKHSEzB4eo9pRKOCz+WHfCbkWJYQ==
X-Gm-Gg: ASbGnct3x3pXf7QXtGa758DAN3fYrjCGCcQPSK2c4JHe9kp8+HELGe/iY5laZakXIKT
	oaYkOCyvmgremHUIjuho9lFmOX90E5tgYVOH5dma2aSF6M5xQ6Sy60WKVS6XZgsnK4q1Ccuif7a
	/2T1gBkXUsnQMII7PkFZYomeut/ILWOOZ/g5vOUVd2O0VoCY0V8a+zE2dW434o5hzogNhr7yyak
	NFrkkzKejkeokAGmMJWFPli4MzUEaFRxXWT9QW+TV6yYLP96Z+xPNiyd/XqVOJaVHePhyA1dTQX
	Fn53jXcoJh8Pjam1UVxLrYaXbN76dENIcd/ArYek7ykgaUdSmrFX/RIfTenhsKUl6FY2Zw9CNs6
	/4miAXDVFpnroQx7OJZi/s+jMJ5XCY3JLfc/EzwEp7cA=
X-Received: by 2002:a05:600c:348f:b0:439:84f8:60d7 with SMTP id 5b1f17b1804b1-439b5be9481mr97441715e9.10.1740403742107;
        Mon, 24 Feb 2025 05:29:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEvfT48u+juiWf/b5QeqEgC1SQv5+fYvQpSRDnJKCIbVgHU6sf5JviBzi8IDSQrr0+xOC7dw==
X-Received: by 2002:a05:600c:348f:b0:439:84f8:60d7 with SMTP id 5b1f17b1804b1-439b5be9481mr97441525e9.10.1740403741792;
        Mon, 24 Feb 2025 05:29:01 -0800 (PST)
Received: from ?IPV6:2003:cb:c735:1900:ac8b:7ae5:991f:54fc? (p200300cbc7351900ac8b7ae5991f54fc.dip0.t-ipconnect.de. [2003:cb:c735:1900:ac8b:7ae5:991f:54fc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02f2475sm106060155e9.20.2025.02.24.05.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 05:29:01 -0800 (PST)
Message-ID: <dfdc09c1-fc66-4c78-9ff7-93fb2a1b6ee1@redhat.com>
Date: Mon, 24 Feb 2025 14:28:59 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fs/proc/task_mmu: add guard region bit to pagemap
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Kalesh Singh
 <kaleshsingh@google.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
 "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
 Juan Yescas <jyescas@google.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-api@vger.kernel.org
References: <cover.1740139449.git.lorenzo.stoakes@oracle.com>
 <521d99c08b975fb06a1e7201e971cc24d68196d1.1740139449.git.lorenzo.stoakes@oracle.com>
 <857b2c3f-7be7-44e8-a825-82a7353665fb@redhat.com>
 <cd57ed04-c6b1-4df3-a5cb-a33078a08e74@lucifer.local>
 <09d7ca19-e6cc-4aa9-8474-8975373bdebd@redhat.com>
 <e687dd75-b76f-4eab-805d-7b1bb18b1365@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <e687dd75-b76f-4eab-805d-7b1bb18b1365@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> My thinking was, that if you have a large VMA, with ordinary pagemap you
>> have to copy 8byte per entry (and have room for that somewhere in user
>> space). In theory, with the scanning feature, you can leave that ...
>> scanning to the kernel and don't have to do any copying/allocate space for
>> it in user space etc.
> 
> That makes perfect sense!
> 
> I think this one will go a little lower on priorities + I'll come back to it but
> I"ll put it on the one reliable todo list I have, the whiteboard in my home
> office :) everything on that list at least eventually gets looked at, majority
> get done.

Sounds good. I'm sure Android folks will speak up in case they require 
more efficient scanning.

> 
>>
>> --
>> Cheers,
>>
>> David / dhildenb
>>
> 
> Great minds think alike though ;) as soon as I saw this I did think about
> extending it, but seems I mistakenly dismissed for uffd reasons.
We should probably look into cleaning up + improving the documentation 
around the pagemap scan feature at some point. Well, something for 
another day :)

-- 
Cheers,

David / dhildenb


