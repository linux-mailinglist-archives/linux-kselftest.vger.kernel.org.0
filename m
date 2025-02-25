Return-Path: <linux-kselftest+bounces-27475-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37176A44614
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 17:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9E4719C6963
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 16:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490D419342E;
	Tue, 25 Feb 2025 16:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bmJTTIAL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A489D18C00B
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 16:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501091; cv=none; b=dFK3WJtjLkdKFKwQxhbkOytGGvpD2tjS5JjLlgPnC+PnmJpPgy/6yFygh/b64utT+a3pP5KhO5qlRQ1EFVybUHpXtOFVPzslnYa3spB+8QFveWyKLKAWv8JSidVnQ0GP1GiInbAg0ipzUVlRSrD9Kaj9Oc7RMXZEbqQqUkfif34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501091; c=relaxed/simple;
	bh=hAk7FCAx/w6pKvxv0B8lrlGIROAyRoacqbmqoEg4n68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PGM0s/InnyaXfMtgCWij3Br+DCWZKW6fzE2DIX6/tcS7KMM1X8fFaf52UaXFbK9bM+M9sHegiSBQ7hBpTnftxEkmzjVLXxTms3hVrjPLmREYTAv3Zu/IQGSpc7uV6unkOv/XCXRovYSp9mbpXM0J43QtysjIR7p5XuTovQdKaF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bmJTTIAL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740501088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KiHH6H+KruC7xciVnXHNTxqKXPhxem67ayxBxHk3Wss=;
	b=bmJTTIALcUBaXJKJmI3I6n6xv7NBS/K0pN1OJS10KpfG9TY7yEgRfT422NXMRGtstIQ2rI
	inN1W376WkZ37bfILmU+Ge/BkCQn7TVn0MbI2184jyudLV3RK53umtR6RIswZDp6muQwRL
	NP5RlW6QLdGeR7Ov0jT6ewOG7dzj6iA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-GKNBTO3sM-Ox0vY8ITXScg-1; Tue, 25 Feb 2025 11:31:27 -0500
X-MC-Unique: GKNBTO3sM-Ox0vY8ITXScg-1
X-Mimecast-MFC-AGG-ID: GKNBTO3sM-Ox0vY8ITXScg_1740501085
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-438da39bb69so42755765e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 08:31:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740501085; x=1741105885;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KiHH6H+KruC7xciVnXHNTxqKXPhxem67ayxBxHk3Wss=;
        b=EPNno74pYNaHRJvYBQciGFRBckkPGrcmFNqHle3+WKPsvg8o+rqXsGqL1CxRAUwBkk
         5guA4DJQxAX/icMjc+SdmukBhyrJrchjfaRsSWPOIPTHhutOZwQAlP1y8QRq63AAXtFx
         s5/BiXEuS8MT9nQ+0C2C08Z4O3bfQKUERMBeeTYDhpee6P//edaumblRIXl6h5eLUzaz
         AQXg5T6/CjDh6sN64cikMgM4EMQO5Vge2tO0W1Dg4BW+KoW5pVL4yQ28iUizNdiIW44D
         Tn42WY6XrFMWsc5dSdlCG5/tX6kDcJkBnCmA1mW97hbYDTt67uS75RX+NQkB0Ucoj6We
         VnXw==
X-Forwarded-Encrypted: i=1; AJvYcCWaL14p5ZE7ikFwMIH5HDS2On0XPXSY54mBcsUVPPlI7a91lRrX2WyxpG8av6z6Lb0SYJ99OLTjyQVr1i3Zyyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn7I5HyF2cOzoVcTlDG9ts0Rsza85C/V5IpeibXLkOQc53hATn
	iTsk1PmjtdmKFyKarczGLGVTkAxi0cp1VgaOyu6wPcZOtFqvBvcNcz8L2nVBB29HEYLhdqiJ4jP
	I2YmyPFpAcgFolLEEP8KDtC/3QjZvDCV/5odaXwCiMGlzzX7BoxKj+iCo9eI/zVY6zA==
X-Gm-Gg: ASbGncsF5Ocg0xQuAB++eXOliAZMCCWTmuA0y64imsXGFJaxYhZs/+lFivUa5WxiBwr
	yptWe+HT8KeD+E7TJNV+nDXOEG9ykue9A8Uc8tTWdYvq1UCyzaqYAjQH/NnQj9j6rmS6JpyWutc
	p+TWVThDxd+teceroSDg2XU/O6mTD/5ey/EdHzgOY18mzaHFRSEZ+oS82VCgm9ZVsid9yiPcj8g
	RtGsUysuJCVRQbVyQbc5R+WY/eJ98kByMnIdlh8okZ9QNYgIQXAAOk+OhMAMGuNUdldeazfXOY9
	CSvPYb1g48OHd6rv3HZEhnUvdl+YGa3Tfsj7C2TtOGt74+1MsnMnCca8IBX72S8x91HMB/qgRhV
	0bVAaPELbrpSFncXknw2hNWF2UWpZyOsBoDWxR3q1v1A=
X-Received: by 2002:a05:600c:3149:b0:439:608b:c4ad with SMTP id 5b1f17b1804b1-43ab8fd04eamr1860885e9.3.1740501084910;
        Tue, 25 Feb 2025 08:31:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5Ovw/WhihL86X2X1dawQx5RxIIYBwFLzc+siqsP5BW2QibCH2cUB0d0keIJUhLiTfXwu2rw==
X-Received: by 2002:a05:600c:3149:b0:439:608b:c4ad with SMTP id 5b1f17b1804b1-43ab8fd04eamr1860585e9.3.1740501084515;
        Tue, 25 Feb 2025 08:31:24 -0800 (PST)
Received: from ?IPV6:2003:cb:c73e:aa00:c9db:441d:a65e:6999? (p200300cbc73eaa00c9db441da65e6999.dip0.t-ipconnect.de. [2003:cb:c73e:aa00:c9db:441d:a65e:6999])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab1533104sm32895065e9.5.2025.02.25.08.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 08:31:24 -0800 (PST)
Message-ID: <46ebee03-b9dd-4500-9f07-60804d4dfd32@redhat.com>
Date: Tue, 25 Feb 2025 17:31:22 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] mm: permit guard regions for file-backed/shmem
 mappings
To: Vlastimil Babka <vbabka@suse.cz>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, "Paul E . McKenney"
 <paulmck@kernel.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>, Juan Yescas <jyescas@google.com>,
 Kalesh Singh <kaleshsingh@google.com>
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
 <fbfae348-909b-48fa-9083-67696b02f15e@suse.cz>
 <8d643393-ddc0-490d-8fad-ad0b2720afb1@lucifer.local>
 <37b606be-f1ef-4abf-83ff-c1f34567568e@redhat.com>
 <b5b9cfcb-341d-4a5a-a6b7-59526643ad71@lucifer.local>
 <0db666da-10d3-4b2c-9b33-781fb265343f@redhat.com>
 <62c0ba1c-7724-4033-b1de-d62a59751ca5@lucifer.local>
 <a49d277e-128c-4853-bdeb-3a94134acbf6@redhat.com>
 <6eb33b5d-3040-4637-b627-48f8f78e4e28@lucifer.local>
 <b30a6306-d62b-4515-add8-4550d044501c@redhat.com>
 <c0e079bd-a840-4240-93ae-0ee2755d425a@lucifer.local>
 <e0954e13-2c7d-447c-ba86-19875c74bc3b@suse.cz>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <e0954e13-2c7d-447c-ba86-19875c74bc3b@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.02.25 16:54, Vlastimil Babka wrote:
> On 2/18/25 18:28, Lorenzo Stoakes wrote:
>> On Tue, Feb 18, 2025 at 06:25:35PM +0100, David Hildenbrand wrote:
>>>
>>>>>>
>>>>>> It fails because it tries to 'touch' the memory, but 'touching' guard
>>>>>> region memory causes a segfault. This kind of breaks the idea of
>>>>>> mlock()'ing guard regions.
>>>>>>
>>>>>> I think adding workarounds to make this possible in any way is not really
>>>>>> worth it (and would probably be pretty gross).
>>>>>>
>>>>>> We already document that 'mlock()ing lightweight guard regions will fail'
>>>>>> as per man page so this is all in line with that.
>>>>>
>>>>> Right, and I claim that supporting VM_LOCKONFAULT might likely be as easy as
>>>>> allowing install/remove of guard regions when that flag is set.
>>>>
>>>> We already allow this flag! VM_LOCKED and VM_HUGETLB are the only flags we
>>>> disallow.
>>>
>>>
>>> See mlock2();
>>>
>>> SYSCALL_DEFINE3(mlock2, unsigned long, start, size_t, len, int, flags)
>>> {
>>> 	vm_flags_t vm_flags = VM_LOCKED;
>>>
>>> 	if (flags & ~MLOCK_ONFAULT)
>>> 		return -EINVAL;
>>>
>>> 	if (flags & MLOCK_ONFAULT)
>>> 		vm_flags |= VM_LOCKONFAULT;
>>>
>>> 	return do_mlock(start, len, vm_flags);
>>> }
>>>
>>>
>>> VM_LOCKONFAULT always as VM_LOCKED set as well.
>>
>> OK cool, that makes sense.
>>
>> As with much kernel stuff, I knew this in the past. Then I forgot. Then I knew
>> again, then... :P if only somebody would write it down in a book...
>>
>> Yeah then that makes sense to check explicitly for (VM_LOCKED | VM_LOCKONFAULT)
>> in any MADV_GUARD_INSTALL_LOCKED variant as obviously this would be passively
>> excluded right now.
> 
> Sorry for the late reply. So AFAIU from your conversations, guards can't be
> compatible with VM_LOCKED, which means e.g. any attempts of glibc to use
> guards for stacks will soon discover that mlockall() users exist and are
> broken by this, and the attempts will fail? That's a bummer.
> 
> As for compatibility with VM_LOCKONFAULT, do we need a new
> MADV_GUARD_INSTALL_LOCKED or can we say MADV_GUARD_INSTALL is new enough
> that it can be just retrofitted (like you retrofit file backed mappings)?
> AFAIU the only risk would be breaking somebody that already relies on a
> failure for VM_LOCKONFAULT, and it's unlikely there's such a somebody now.

Exactly my thinking I didn't have time to phrase during that 
conversation. IMHO, we were careful with MADV_DONTNEED because it was 
... around for a little bit longer :)

-- 
Cheers,

David / dhildenb


