Return-Path: <linux-kselftest+bounces-12409-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E0A911F14
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 10:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B33DB28805D
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 08:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D85216D9B1;
	Fri, 21 Jun 2024 08:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ef8SrTBG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8870139855
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Jun 2024 08:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718959443; cv=none; b=OCyyIBaM01k6o9hZ3G19UViqknTj8BqECCmIn9O9xnx3tzY2EuGcjlFQ9mSil2UxF4MIit3GOG94g2uOOE462nZxcuQeUSSKSOGYmN+6hg417lrd2RRWxoQpivyVG77NP/1I81BxR2jmuaZqm/lrrkCJ2Fizwdt4WIdGPNyQNgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718959443; c=relaxed/simple;
	bh=PUmN4XsW0Nz9edwBR5542tFh9arkVyDs5u6ltSHiJUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rCsGetiO1Ioam8zFJKZxtshAwS7reNam1s8bXC8EAzJg9SR21h2OrJaCgprODBf/ZXqYEZM3T+4Hq8SZOhIg435+UQZVSMcmVQvXlWyUPT+lQFo/roIvoO/FPtlJGr87sDO9+yx9IUft+ijo56YYo4XKI5/RBbTurln6uvbgrTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ef8SrTBG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718959440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VU90d8rIY7+e8nZJdYV+B/wIyrHGdSqZeVXkqOxNvFc=;
	b=ef8SrTBGL50vcveU5RLxXQDX3dm9vv5CNCKfw2z7jGGUcx/mD8HnYgQC6Hz0AVqMFFOVQG
	z6eB14Ige80vrwZpZQlw4Y0TjuGJ3u4GsDFO+7p+d6M/ZK0HHu0MwqaniQ51hKQziA7Jtv
	03tImzE0qq0YbYBpOUaXTU7o3xTH1Yc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-E0ta10KjNUa4VdHAsrj-iA-1; Fri, 21 Jun 2024 04:43:58 -0400
X-MC-Unique: E0ta10KjNUa4VdHAsrj-iA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-364be6c2468so746045f8f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Jun 2024 01:43:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718959437; x=1719564237;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VU90d8rIY7+e8nZJdYV+B/wIyrHGdSqZeVXkqOxNvFc=;
        b=J89at5MnwtjXoiKR1eReKvUkwQRB17uMB8d1mZG1Pmbb7Obeo4nNQSWtOXfJT+UCwJ
         7F53b9SkEPClRiyAm9adbuSzM0K3+qpPfWpfjddeLd+BnlZQlWveObuPW9qXWNopZlwj
         0NcQy6Tm8GNO0wdcClpJGwpZMqk5KlUvciaK53enrKM8didI3lmr36RD5WbeEum89yCS
         Ca8DSzZhNNocN8MspR4ohT8O+M1vqdjrb+G33JeMNBrxWTUI0NIBRLj6UtZ6ivlMvSvB
         F5/cYttnLQUAVROxzShIIPgok0KbT9nEdIbEqNmIEX096hOCAKSP5biPXAuzoi79FbRg
         MpFA==
X-Forwarded-Encrypted: i=1; AJvYcCVdyt/0WdODPZgq+SblbeooHKl1CwWXGmBu+DQmmE0uL72fhlYEQjG6hlPEArElbInEQCUnF4Ze1GEzdc/a86b7Vyda/lMhbGJ0i3vaxSMF
X-Gm-Message-State: AOJu0YzhM9bEoPOD2Sk6sD+1H2z9Dp+2UEctTJP6a3kuhR1DasV3CjjY
	ddrUzwNtB8O8fXxmyemC32tjlBmiP8IHdOkuJ8ymqm9fsoDsaqwl5L0ToglQUsKOozch0F71V7G
	9bJDuj5Ktbd3eWkPSg2We3ufU+dxmHHRo5pFpmhpA3kz2YHLfqNJg7vczHalnxRRYFg==
X-Received: by 2002:adf:ea01:0:b0:35f:1bc3:50b0 with SMTP id ffacd0b85a97d-36319a855bamr5420989f8f.63.1718959437639;
        Fri, 21 Jun 2024 01:43:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiasjYrLg90qQVpUX0kw3ikfNJqrMMvB9SgRGxmoh8eFyR1j+l0uMDDPJS1zuvGqqtRVJD+w==
X-Received: by 2002:adf:ea01:0:b0:35f:1bc3:50b0 with SMTP id ffacd0b85a97d-36319a855bamr5420970f8f.63.1718959437216;
        Fri, 21 Jun 2024 01:43:57 -0700 (PDT)
Received: from ?IPV6:2003:cb:c725:e600:4063:2059:fd18:9d65? (p200300cbc725e60040632059fd189d65.dip0.t-ipconnect.de. [2003:cb:c725:e600:4063:2059:fd18:9d65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36638f86566sm1069864f8f.64.2024.06.21.01.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 01:43:56 -0700 (PDT)
Message-ID: <4c8b81a0-3a76-4802-875f-f26ff1844955@redhat.com>
Date: Fri, 21 Jun 2024 10:43:55 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
To: Fuad Tabba <tabba@google.com>, Sean Christopherson <seanjc@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 Elliot Berman <quic_eberman@quicinc.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, maz@kernel.org, kvm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com
References: <20240618-exclusive-gup-v1-0-30472a19c5d1@quicinc.com>
 <7fb8cc2c-916a-43e1-9edf-23ed35e42f51@nvidia.com>
 <14bd145a-039f-4fb9-8598-384d6a051737@redhat.com>
 <CA+EHjTxWWEHfjZ9LJqZy+VCk43qd3SMKiPF7uvAwmDdPeVhrvQ@mail.gmail.com>
 <20240619115135.GE2494510@nvidia.com>
 <CA+EHjTz_=J+bDpqciaMnNja4uz1Njcpg5NVh_GW2tya-suA7kQ@mail.gmail.com>
 <ZnRMn1ObU8TFrms3@google.com>
 <CA+EHjTxvOyCqWRMTS3mXHznQtAJzDJLgqdS0Er2GA9FGdxd1vA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CA+EHjTxvOyCqWRMTS3mXHznQtAJzDJLgqdS0Er2GA9FGdxd1vA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> Again from that thread, one of most important aspects guest_memfd is that VMAs
>> are not required.  Stating the obvious, lack of VMAs makes it really hard to drive
>> swap, reclaim, migration, etc. from code that fundamentally operates on VMAs.
>>
>>   : More broadly, no VMAs are required.  The lack of stage-1 page tables are nice to
>>   : have; the lack of VMAs means that guest_memfd isn't playing second fiddle, e.g.
>>   : it's not subject to VMA protections, isn't restricted to host mapping size, etc.
>>
>> [1] https://lore.kernel.org/all/Zfmpby6i3PfBEcCV@google.com
>> [2] https://lore.kernel.org/all/Zg3xF7dTtx6hbmZj@google.com
> 
> I wonder if it might be more productive to also discuss this in one of
> the PUCKs, ahead of LPC, in addition to trying to go over this in LPC.

I don't know in  which context you usually discuss that, but I could 
propose that as a topic in the bi-weekly MM meeting.

This would, of course, be focused on the bigger MM picture: how to mmap, 
how how to support huge pages, interaction with page pinning, ... So 
obviously more MM focused once we are in agreement that we want to 
support shared memory in guest_memfd and how to make that work with core-mm.

Discussing if we want shared memory in guest_memfd might be betetr 
suited for a different, more CC/KVM specific meeting (likely the "PUCKs" 
mentioned here?).

-- 
Cheers,

David / dhildenb


