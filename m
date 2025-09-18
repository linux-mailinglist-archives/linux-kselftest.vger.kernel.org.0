Return-Path: <linux-kselftest+bounces-41749-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BD4B8159E
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 20:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AED3B583978
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 18:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C1C2FF664;
	Wed, 17 Sep 2025 18:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SWqPVX8a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890182FE59E
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 18:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758134059; cv=none; b=QZ3p3TPlvXm0kZb20gPedUAKUIEQOK307rjxlf4m24nKcUOF/+X3o/9yoe69cupCLFo2rKdX3vkEvn1G+HoutPyQRukerwyPb0+LbGENwxXPw/sI9tBMfgKlyICPZdvqJFRi4lYEAhcE1UXMnYHOWujgm1JBzh79IHaXOi5cjf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758134059; c=relaxed/simple;
	bh=3bnYGSqJJ0U3uhuPWHaq2lHDzYWemc/ZBgK/vRSmd3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P2RRO0Xu/AvKXC7JvxWniU0gTnNPJJwXM5TnRfrgWZvI2sbDbwcQG7m4NM7Kg5Gh9KXuaXfXb+zvkiDCaSY6rGJDzmwAJ8PetFF+Vps//eLjgYl0nxOj5JDUqAPlroCzY8MUwnOjpC3lLFo1ubb8h2YEcH7zCewa3dLg6uMU5iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SWqPVX8a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758134056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DGFF1TGksFvJE01BynPWTlxwwJdIv5IyqKnRBO/qFac=;
	b=SWqPVX8a0VcZFkS3DNk5UjyeSaUQYtuXJk7kjQdIpqj+461CyUWzRtPVRg/BHVOFa5NnLX
	/tWp3gDQYwFWSn2Q8cIO1dnXE+IVYcMDgosDsrWK/26EKAoE6wRSxnXj0o12GxjSNGcjzm
	MjdZT3k9hf2eKC0eDG9gt14+cqCKuPE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-Ss-zPbyKPx2S6I0JRJrzHQ-1; Wed, 17 Sep 2025 14:34:15 -0400
X-MC-Unique: Ss-zPbyKPx2S6I0JRJrzHQ-1
X-Mimecast-MFC-AGG-ID: Ss-zPbyKPx2S6I0JRJrzHQ_1758134054
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45de27bf706so547925e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 11:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758134054; x=1758738854;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DGFF1TGksFvJE01BynPWTlxwwJdIv5IyqKnRBO/qFac=;
        b=MlRh7vgsYyQsYYP/nfsF58GdDO/OdahtFZUh0JatcPjQSQr0avzzVzdygJTcRbGNuY
         BSK5qjVysdiRP7LNwvjexsnz4Ej3/62tbW3HFvKyXLAlF7k/+y0AhNGEu3r+ktW4Q6Jl
         5oStlaw7g6lNTZFXvprwEjqx7lz2UNDXCjTZmYWxTm4OqiT9RnBOWgVwoRZ+GW2NK6Cf
         mF2/OINAI+SDs+EpUu+b4pgBmo7PNsUxFmCl1/Qlte93/ECiovh8ju4Yf7dJPUUNKDVV
         tRUNCz/aJlohohaiqpBFPgs/PlN2bS4hKJ3tX5UM2HPpcsVoECARt3Zsops5PAOX6GA5
         zOzA==
X-Forwarded-Encrypted: i=1; AJvYcCV7x0OIz6QRo4KONjvgIDVFerBJ640FW0HtOSJNEY5Cnrvo05PZITwoEUlg2ECWeNyzyojCjxMup+ZbQg8CDeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpxCQf16temriT09df6zKJzYkQ5N/d8OSchJ4JNsmhmpHkjd69
	Zm1I9yzclJrzD7IsGGvzGy5OYy1paCyi1Z4qSwj7xQdTi+R0fPWzcOpXou2PmUfOyQZgDVvzIJx
	T40Td7iAVblfnaIb9fDNLitJWqJ2CIFnTCjnsBfJi+s52E05Zc3RgeF3v6Xi4MtKhC2KttQ==
X-Gm-Gg: ASbGncs+QRqU+v4eDtmiz3+4fzHe+feXIdxdSMw5qerylkj2oQtpmPM05n7en3fijWH
	x+gBf12bRHt28BnnNPNiBDoU4L4BnFlRwi4g9sMEWzG32fbhV68sUrJcEYi/JYKqNtQTPF1YfhE
	FkMFQjbc65zf6sgIvVB1v79gm7kWaw4UtxrHLgNMriJNISbdNiotgrVnxkFA8f83Cgat6Yge6lv
	fxOorptzJmzCMPesrd1Cs+UOtj1S6CbHg/TIhcNhBrX/sAprkV5pAIeD+weFpTbl+ZnXj4flJD4
	ZIvsi8mft7dM+uEKBfODOfQyTqVQd//LzDuFdoc99VluegvNsFyJAmGiEyRcndo1BFGF9iI=
X-Received: by 2002:a05:600c:3b09:b0:45f:2d2a:e323 with SMTP id 5b1f17b1804b1-461fc6674f9mr32666685e9.0.1758134054030;
        Wed, 17 Sep 2025 11:34:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHedDcjLH9XDvUmI6R0DJmIUBsC8vdl45mHXNEs7FKudkuR4KrH37oiCo8ZAPtPFj7zk/sQEg==
X-Received: by 2002:a05:600c:3b09:b0:45f:2d2a:e323 with SMTP id 5b1f17b1804b1-461fc6674f9mr32666305e9.0.1758134053593;
        Wed, 17 Sep 2025 11:34:13 -0700 (PDT)
Received: from [192.168.3.141] (p4fe0f678.dip0.t-ipconnect.de. [79.224.246.120])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f527d6cdsm7187695e9.12.2025.09.17.11.34.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 11:34:12 -0700 (PDT)
Message-ID: <322fd5d2-d7f4-40d8-8a06-6e7c5e9ef180@redhat.com>
Date: Wed, 17 Sep 2025 20:34:10 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] mm: add assertion for VMA count limit
To: Kalesh Singh <kaleshsingh@google.com>
Cc: akpm@linux-foundation.org, minchan@kernel.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org,
 pfalcato@suse.de, kernel-team@android.com, android-mm@google.com,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915163838.631445-7-kaleshsingh@google.com>
 <eb7820ed-3351-4cb5-8341-d6a48ed7746f@redhat.com>
 <CAC_TJvctkyGEKv8mVE83D2DzCd-HiXh9co_DuZfwuF86FJoiJw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CAC_TJvctkyGEKv8mVE83D2DzCd-HiXh9co_DuZfwuF86FJoiJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> Can't that fire when changing the max count from user space at just the
>> wrong time?
> 
> You are right: technically it's possible if it was raised between the
> time of checking and when the new VMA is added.
> 
>>
>> I assume we'll have to tolerated that and might just want to drop this
>> patch from the series.
>>
> 
> It is compiled out in !CONFIG_VM_DEBUG builds, would we still want to drop it?

Due to the racy nature I think any kinds of assertions would be wrong. 
Without any such races possible I would agree that the checks would be 
nice to have.

-- 
Cheers

David / dhildenb


