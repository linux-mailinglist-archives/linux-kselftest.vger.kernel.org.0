Return-Path: <linux-kselftest+bounces-38286-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8197AB1B062
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 10:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19BCF189ACB2
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 08:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EF82571DF;
	Tue,  5 Aug 2025 08:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O43/yaDe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8058F1D416C
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Aug 2025 08:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754383644; cv=none; b=NSwQ7N/zFrx0AhT21qUbRdpRuYjKbtbep6/vFDtYKxs6+bVtI1i4mmbW+Xwxql9Iq5/mMnhJR7bL60S3yVKrMeirtkcgObkNwmOR8ZTA90u44w5G0ntRU3pdbGTHtJeByUvDc0sH1HxgqY33quebE9GAkqOVpYRGY10w4PRFO5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754383644; c=relaxed/simple;
	bh=/rzgFjNcLXGiambfnJVISiFiCLXry6c6+u0Y8+3bjho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FyFveEEuuQ5c/N487ihOvSkCNP+9o+pru8p4eXoIcOhzzEgLBqna+G0+/eMzEKfzWV3BzfW1Gud16LAEQHuRXfJaSovGs3BZ5gDLUwDiYG98G88VkLBXOC3W0jjOr0SCtihgo5TzFWNQ4JGv2UiI4nf30EDuB57zgE10eOTuvjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O43/yaDe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754383641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=74DKsi6Sdoce25+3npCDNQncP0FOfToMHedbAWacwec=;
	b=O43/yaDedTwDnKgK6N0hksWyS5qT8IAaXrZM0h6avSnVSVVZP6YvOlepF9ziiGCMsiovqQ
	QAT3HkS4YmxInLCbAA8yIUnS/5wUVPOamH1/KtYkoVKcreXIcoRfHFzlnLLJApFe0Kus4o
	x9ihmIBljqKMrBB3LHMUfKa7lcS+Kjc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-MYIGE32rMsipaKnYbIuNOQ-1; Tue, 05 Aug 2025 04:47:18 -0400
X-MC-Unique: MYIGE32rMsipaKnYbIuNOQ-1
X-Mimecast-MFC-AGG-ID: MYIGE32rMsipaKnYbIuNOQ_1754383638
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b7865dc367so3098114f8f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Aug 2025 01:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754383637; x=1754988437;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=74DKsi6Sdoce25+3npCDNQncP0FOfToMHedbAWacwec=;
        b=DOb7WjbimF0bBfuQ5LxERGxqgHkeJUDGcRpItoEDPldV5rOrlH52z5vC3hYR0yKJe5
         ryg9OcwW6rWoAunq6JgUcAfUUbJAcb1SKotQtt/dQ+RTmcyHnt6ty2Kyw/pilRgX9a6A
         HEGEm22AA51lDn5/UgdAht2YQfFBB/fys/PjniIb3aoVo22AElY7iCCtxT9LgxaJNx7n
         KFNs0xP3q3ZtR82EkjKsT3+LL2mwLNmpp4RuTvn4hJx5hcN7QwPJxj+u6a3SkoJ9ruHs
         rFRWk7Xonmg0qIn4JvzhWFGBfAX4W7ZVnJe5daeqj+FtEkAvdKs+6uAFJqJIXvibwqIb
         WUqQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0cjuldXv1u7TKKtmSuahnYhtPGRw3Sjto7mXuIvfvTs7z9dBN4GvBH/MhFhcCYAn4njTgIF0ambvokG0WXuo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1S56Y2+nnTHzLXDL4lTrpNQ9J2XgBdeMBotiPIPSJhkLvwajU
	3mQfgfEWyenfETkDUVnk6Rfz1Mt0pezb6pab9Jq/mrrnto6H4LUADp6/NkbL+yp5AToatPQL5a8
	6nu6IPo/e3Lo6U3o2o+yqOIQDqnDhknAUTcko3V4ETfrOTXwi466FWpvhltCnlh577bXz9w==
X-Gm-Gg: ASbGncuj/IOvAuw51G5xvcfZWkITaxX+5XMA6kNXJAq/U67DOUNVntDWgOrQqVwj133
	jgu6/n/6bfjqRvGMwsbdFZLsHr7xz16TDmU6J0gAsCf/If9xwFyyTDEtm3/bSuPD4Fq6fHWHMyO
	HB+l3ff8xXR181IhKzfu1A9W2Nix4s1v4+u6TQNFe7ZzC8tG/ZWgKIs/j/aa++AulkVh+DRRYWd
	hzXer4YqZQ25zekqOyie63CktebA/8PZ0RseRqTNXiK0L7X6fe4AdFsDIus1V5h8iEzf6XCFv34
	3eKyQo5+X6QmbLzL0NTkhCBmDUDHopQhNECKOwznJ0VTRjqVrBYYe8bMrNjQZRDGafwYrRzXnL4
	HSndqfevLkm/KWlu9c/2+n0YUuHIBGeHkNcBOn3cfZKFisgezF/8nmnsbcfqNP+jkRuU=
X-Received: by 2002:a05:6000:430d:b0:3b7:899c:e867 with SMTP id ffacd0b85a97d-3b8d94d48a4mr8220576f8f.59.1754383637620;
        Tue, 05 Aug 2025 01:47:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqrJg7MtUAalV8y4XTX4pkvb/9bodwHXpDbLB7WlsGshFzRZyKWTYExc9xDh2hxm3vN0GP1w==
X-Received: by 2002:a05:6000:430d:b0:3b7:899c:e867 with SMTP id ffacd0b85a97d-3b8d94d48a4mr8220545f8f.59.1754383637141;
        Tue, 05 Aug 2025 01:47:17 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2b:b200:607d:d3d2:3271:1be0? (p200300d82f2bb200607dd3d232711be0.dip0.t-ipconnect.de. [2003:d8:2f2b:b200:607d:d3d2:3271:1be0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589edf5638sm197947535e9.4.2025.08.05.01.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 01:47:16 -0700 (PDT)
Message-ID: <24bbd9df-efa7-4090-a696-1eb40904ad85@redhat.com>
Date: Tue, 5 Aug 2025 10:47:15 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftests/mm: pass filename as input param to
 VM_PFNMAP tests
To: Sudarsan Mahendran <sudarsanm@google.com>, linux-kselftest@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, trivial@kernel.org
References: <20250805013629.47629-1-sudarsanm@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250805013629.47629-1-sudarsanm@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.08.25 03:36, Sudarsan Mahendran wrote:
> Enable these tests to be run on other pfnmap'ed memory like
> NVIDIA's EGM.
> 
> Add '--' as a separator to pass in file path. This allows
> passing of cmd line arguments to kselftest_harness.
> Use '/dev/mem' as default filename.
> 
> Existing test passes:
> 	pfnmap
> 	TAP version 13
> 	1..6
> 	# Starting 6 tests from 1 test cases.
> 	# PASSED: 6 / 6 tests passed.
> 	# Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Pass params to kselftest_harness:
> 	pfnmap -r pfnmap:mremap_fixed
> 	TAP version 13
> 	1..1
> 	# Starting 1 tests from 1 test cases.
> 	#  RUN           pfnmap.mremap_fixed ...
> 	#            OK  pfnmap.mremap_fixed
> 	ok 1 pfnmap.mremap_fixed
> 	# PASSED: 1 / 1 tests passed.
> 	# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Pass non-existent file name as input:
> 	pfnmap -- /dev/blah
> 	TAP version 13
> 	1..6
> 	# Starting 6 tests from 1 test cases.
> 	#  RUN           pfnmap.madvise_disallowed ...
> 	#      SKIP      Cannot open '/dev/blah'
> 
> Pass non pfnmap'ed file as input:
> 	pfnmap -r pfnmap.madvise_disallowed -- randfile.txt
> 	TAP version 13
> 	1..1
> 	# Starting 1 tests from 1 test cases.
> 	#  RUN           pfnmap.madvise_disallowed ...
> 	#      SKIP      Invalid file: 'randfile.txt'. Not pfnmap'ed
> 
> Signed-off-by: Sudarsan Mahendran <sudarsanm@google.com>
> ---

Thanks!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


