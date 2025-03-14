Return-Path: <linux-kselftest+bounces-29073-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EFFA61DE0
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 22:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF017461E86
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 21:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B371ACED3;
	Fri, 14 Mar 2025 21:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qhg4gZjR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92845BA38
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 21:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741987185; cv=none; b=Z4FEl57H/8WxMy0go14aKWlTiFy89cQdkn63QiXQYtpRFLt9mviHU1UPQE4LDbVY0bPILF8ucbYfAcRgQfd0WgMlcRfM+ez8fbniW1iQ5h3BgxxIVCfltf+J/gegYgkKwLeQ7zqtTU4QJNpzaP08XheIPMbJxc+bjKmiPQE4wBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741987185; c=relaxed/simple;
	bh=jqf7FEeHXNTJtC+4+XGwm1i96R01W9/xBY5heljHbQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cHF98gzPtj9WnrDAdRyiRSIPG03a0JWO9eRcYeXYC3PBXGfIh9hMNSTHeot1ATZw0EVZRVIgiXZrcDew5TctbXxB3e7IhL8RcoLJW/ia7iB00PMDQk9/txNbolpu5hgRxZkKY6zP30rhlnhA9fA1v4YHjKq3IIO+JAChyL2Ithg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qhg4gZjR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741987182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=M/YRvGQ/SRgXi0h5Ytl4wU6SKIBqP9xfS93kGdAJRbs=;
	b=Qhg4gZjRpGTpnUgMAdkCpUPAWXai85dbPK2Niv0Un0/VG1p7OPapgzk66JcjVeE5ZTRjti
	/vbdecP8RGu2BOtMqi2Nk3FG29lvKeuzdhJP8GjUg2y5sAixnCDwtL1jQCYQ1OmhDTuXro
	DpSvDFDZ7estkp/Gc5yzGolmlsuH6dk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-O_JwVugmNu2lw5XDaH9B0w-1; Fri, 14 Mar 2025 17:19:41 -0400
X-MC-Unique: O_JwVugmNu2lw5XDaH9B0w-1
X-Mimecast-MFC-AGG-ID: O_JwVugmNu2lw5XDaH9B0w_1741987180
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-438da39bb69so1484145e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 14:19:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741987180; x=1742591980;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M/YRvGQ/SRgXi0h5Ytl4wU6SKIBqP9xfS93kGdAJRbs=;
        b=hvTrTCcRpafQizjFyU23q9BJbcnahhH+7EJWJF5FiABtzj7Khsig/jRFEgukP/fsPh
         lGRBB36613KkF3qAb41ihdppjaXRd/EkK7byrCJ34f66mROHHKRH+pNkC1v1uU0LPFlF
         KkI1fK2G++IaSaINzG9bud46hfvN8XSG1PwegBoRt0ULV1KWIJUVsbMV9BHYQCQ5i8NN
         KFSCuWVuKOKPTbp/V/+RoxL99TnkbAN8Sl9UWwaY4kHikeDZ5WCQleb9B1qqgh0R5Bb7
         Hq8aTNX4s9ayoaPfsad66rku06xbOvk/qzQ8qklTwzvYJ/p8T7/H2uuo/gSZVphN3F6u
         N5sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa7ZC92CwyjJvvIPSQqxuIknFkEerojL6fdkjHNTosPyKRMSd0LHthq0amkILksAf40VL+v+nnUEgrAR/ndm0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+XCl01lhgWh/Hq3+w8wia2ikQnSxv5M7iblGkGX1OE5B+8OSQ
	KuoKQb986Kx8dRDJQX7W5szB85wHocxonVGtQyS7hPKXs9v5P3Lp2epatbclta2quSwi/+kkrNN
	yDQg8kCxfAutQQlg+9+yTVEUIHeX8eyH87+gNYsmvjlr6rltkNe7O1VhiFtfXPXLHNeYUfzFqXC
	/S
X-Gm-Gg: ASbGncsFYh5UpgfMCzlivmFgWO7TmX2chlNLhOcj6jnQHlogQAlDetBEzP1QhuU8Rte
	ZGlgLDWTkKtsdEnj6pbjrUFE998U1QMxFOfz9fjz6zDSNMlof+3KcWEYUIvODEHhrA9H7CrvpEW
	28cAb34SjIYtd/l1lPw2G3v5tPu/Wlbjcbn4JGMa08FschIBqzPalB1mhwjXf4FQYoNHnKL/DSv
	m8hB1xHxInHBPmh/yGJmO0TyBWEd4Tnfvr/8l7Squ6ZQzLdfSCIbU2+To9+a3Wy4FLmj6+LB9Eb
	pE3nvGTioyR3vk+aOwtRI/4tXEH8M7BxGi6j7i585phR/1NpNEDrJXK34kTF+wVbsska/PvpiLz
	fUXKWOTJDh0Ab++VIl3guFak4YrWq6ZXzlH034hrFpBc=
X-Received: by 2002:a05:600d:e:b0:43c:ec28:d303 with SMTP id 5b1f17b1804b1-43d1f0a4287mr57881165e9.5.1741987179830;
        Fri, 14 Mar 2025 14:19:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7UzLfdBHiKkf80fimMtV90C5w67C079NQtLLpN6oXwwd78VGR2gRumFtRI+6ax6rJbx7bDg==
X-Received: by 2002:a05:600d:e:b0:43c:ec28:d303 with SMTP id 5b1f17b1804b1-43d1f0a4287mr57880945e9.5.1741987179469;
        Fri, 14 Mar 2025 14:19:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c745:2000:5e9f:9789:2c3b:8b3d? (p200300cbc74520005e9f97892c3b8b3d.dip0.t-ipconnect.de. [2003:cb:c745:2000:5e9f:9789:2c3b:8b3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fdda152sm29019175e9.1.2025.03.14.14.19.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 14:19:38 -0700 (PDT)
Message-ID: <86f91949-9972-4b0f-903e-cfa36bcd9926@redhat.com>
Date: Fri, 14 Mar 2025 22:19:36 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/10] selftests/mm: Skip gup_longerm tests on weird
 filesystems
To: Brendan Jackman <jackmanb@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
 <20250228-mm-selftests-v3-8-958e3b6f0203@google.com>
 <08023d47-dcf4-4efb-bf13-5aef3c6dca14@redhat.com>
 <Z8mYG8eQnMsOA4c1@google.com>
 <16023193-6cb4-46d1-91c4-43342e7e6d30@redhat.com>
 <CA+i-1C3srkh44tN8dMQ5aD-jhoksUkdEpa+mMfdDtDrPAUv7gQ@mail.gmail.com>
 <41923b80-55f4-44b6-bc59-60327e5308f4@redhat.com>
 <Z9FHEdZoYbCMoj64@google.com>
 <15cc0c1d-2b02-41de-bf48-3c57cee97c53@redhat.com>
 <Z9RRkL1hom48z3Tt@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z9RRkL1hom48z3Tt@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.03.25 16:56, Brendan Jackman wrote:
>>> Even if it's a bug in QEMU, I think it is worth working around this
>>> one way or another. QEMU by far the most practical way to run these
>>> tests, and virtme-ng is probably the most popular/practical way to do
>>> that.
>>
>> I'm afraid yes. Although allocating temp files form 9pfs is rather ...
>> weird. :) One would assume that /tmp is usually backed by tmpfs. But well, a
>> disto can do what it wants.
> 
> Ah yeah but these tests also use mkstemp() in the CWD i.e. the
> location of run_vmtests.sh, it isn't /tmp that is causing this at the
> moment. (At some point I thought I was hitting the issue there too,
> but I think I was mistaken, like just not reading the test logs
> properly or something).

Ah, yes run_with_local_tmpfile() ... jep, I wrote that test, now my 
memory comes back; we wanted to test with actual filesystems (e.g., 
ext4, xfs) easily.

> 
>>> I think even if we are confident it's just a bunch of broken
>>> code that isn't even in Linux, it's pragmatic to spend a certain
>>> amount of energy on having green tests there.
>>>
>>
>> Yeah, we're trying ...
>>
>>> (Also, this f_type thing might be totally intentional specified
>>> filesystem behaviour, I don't know).
>>
>> I assume it's broken in various ways to mimic that you are a file system
>> which you are not.
>>
>> Your approach is likely the easiest approach to deal with this 9pfs crap.
>>
>> Can you document in the code+description better what we learned, and why we
>> cannot even trust f_type with crappy 9pfs?
> 
> Sure, I will be more verbose about it.
> 
> I've already sent v4 here:
> 
> https://lore.kernel.org/all/20250311-mm-selftests-v4-7-dec210a658f5@google.com/
> 
> So I will wait and see if there are any comments on the v4, if there
> are I'll spin the extra commentary into v5 otherwise send it as a
> followup, does that sound OK?


You can just ask Andrew to fixup the comment or description in a reply 
to the v4 patch. Andrew will let you know if he prefers a resend.

Thanks!


-- 
Cheers,

David / dhildenb


