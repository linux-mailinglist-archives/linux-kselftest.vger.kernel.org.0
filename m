Return-Path: <linux-kselftest+bounces-37255-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8DFB04071
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 15:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A76F87AB1C8
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 13:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D39252903;
	Mon, 14 Jul 2025 13:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W03nK/oI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80CE253356
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752500681; cv=none; b=h6Rg5d9G3we6ZOlPceh4eOOsCWITGYFM29J01QqsQjLoUt8tArBJjkZwsp1HhYyzZ8LyuEOmXYfBtfks4NvcUyZuw1V9F6r2rFdpyFR0D1yH9yWgv7LyV0WZkv10eGfBrw+WShlQEX5gNZ3rMaQm2SGkXAHAGsbCmrhz3FG35kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752500681; c=relaxed/simple;
	bh=L9rd/YFjBCYeu+vrNj99L08qC8r/zV90EKJEPXRCDgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tAxAViy7wosIjVPnRFv1oPY52/odKFIn0XLBYoEcqbBYhr+7RhM+g7lw9RX5Rd23NiosLfH3JoaTKdl3z5z8zW+c7Dus/lCM4ckJY+/fxoefZllgg9eyR0tg/izPy1dnNzRtFhvlZh7rqDh49EMoBzVb7+djGTxPyv7WHHU+dq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W03nK/oI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752500676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=X+GS2rPtBARL/ESHq8iljkHKPEQ7wONWjHbxi92M2D8=;
	b=W03nK/oIUtBXq74tSw4xOdQUL1TFQt4io7GTjLmFJHJCZ15dlgWifTF0/u7FLgnifHtBQ7
	hkLe7Q5sW6XdpibqF0GGq7h0tdEcRYnr5Hy4+mk6KIAw6nwehmqjdaXAypl54cJfS1tsml
	kKCaHYHCFQ7GnNYorToTUOFH9xQ7fhQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-9JYlI1akMUWEYraEgo71aA-1; Mon, 14 Jul 2025 09:44:32 -0400
X-MC-Unique: 9JYlI1akMUWEYraEgo71aA-1
X-Mimecast-MFC-AGG-ID: 9JYlI1akMUWEYraEgo71aA_1752500671
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-453817323afso27666455e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 06:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752500671; x=1753105471;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X+GS2rPtBARL/ESHq8iljkHKPEQ7wONWjHbxi92M2D8=;
        b=jJSB56xc/mKF47uw4OuKLmfV+oJpSs/ow0TlngYaVjw7S00lOXE1v4d6h8QRMqh2Wg
         8CgKwpWsIx7x6IavIZtNtwKOio8xf2r8QG+S3qo4jUvNXTZfzvu9+TxdYBv/KAsALGdP
         fKyolqBrOvc4i0ASo5knUVBfz9aJC7GwvR/3JLMjYkEtC0HKJ6AOHr7F+9/ol3gGRLs8
         1C6yPJsyqFMp7mNEWpviWJ/SECdpaWGYjwi5dxk3DHParbC/ovJd/qcFtNxIVMTiB+j0
         rtHLPu6J/18wbwVEkpwyuXCKdv749kEpFYY7lfo5aTlCURWd7J9dexPBUPtCJocIoRDh
         Lq2A==
X-Forwarded-Encrypted: i=1; AJvYcCXuoYI47XkaCOl2zmPUzir/LPp4cxWrn3z1SMUw6RWct3SxPz+zDDepl5F5FYVl755cwLl29AgTCT8hbJ9YXfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YygiA8v1CdEhMtVPN0gSv6P3mYvFtFReuug8Qm4uvIMnjHfrO7y
	Qibp9/H8AEU0+pZp05GwfZwIMDNQaI4DcjN/bxRQlNuSMvwsOdI2LiJjqGo/SMya6aR/z60Kdkf
	6Xe98AJRMOnmYd0AgQGPJKj4yO0tGNpLi9paIzMBpHgsuqH9uYWdggVGclmZr8Whj9TUmTg==
X-Gm-Gg: ASbGncsq9hpSidhYLKXIMa1IShLpw2XVpGw2SvW+G5h8OXgpifQAUtkcyWUA96CrQMI
	UpGT6znN1ki1MR8PJ6iKlHumv/Forz72gxyLL7/fPcC76bNR2hg1cA/VfkJq96h7NlxH8NYusoZ
	7jwZJAvDhxX/zBjKe8TdQ1otIIz/FsvXxzfPY6otdvKb0pb56rclYzF0h2L71O8p/ysCzd5Y7jd
	JdXuCuonan1yiuSaWghbEdqhBQUOQkIcsid7O0a7sDdsmcrFFmHecRCIIin4H0xiQribpZg0XZy
	A+8uISMhanAN5VfOm94XHNf9OqqTZYgYrwxdRAtPR4LegYZpZKEou2SNoyF9284Z0/wdYVB7Yba
	xBOyz1Sya93d3sjwlGfQ2ZjgDH5klBCZZ3HSyn05SEBbgCiiOmbV4tjW6rw0ulRZW
X-Received: by 2002:a05:600c:821a:b0:456:207e:fd86 with SMTP id 5b1f17b1804b1-456207f008bmr21906005e9.2.1752500671101;
        Mon, 14 Jul 2025 06:44:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3ScZAKbeGoqX2wP9/gRIpia/X8+PS57jXCXwanug3eBTNK8Z/wPQG4PIBWgLe3XbF2i1MEw==
X-Received: by 2002:a05:600c:821a:b0:456:207e:fd86 with SMTP id 5b1f17b1804b1-456207f008bmr21905615e9.2.1752500670671;
        Mon, 14 Jul 2025 06:44:30 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f38:ca00:ca3a:83da:653e:234? (p200300d82f38ca00ca3a83da653e0234.dip0.t-ipconnect.de. [2003:d8:2f38:ca00:ca3a:83da:653e:234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d732sm12689842f8f.52.2025.07.14.06.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 06:44:30 -0700 (PDT)
Message-ID: <4a3e0759-caa1-4cfa-bc3f-402593f1eee3@redhat.com>
Date: Mon, 14 Jul 2025 15:44:28 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: refactor common code and improve test
 skipping in guard_region
To: Mark Brown <broonie@kernel.org>, wang lian <lianux.mm@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, SeongJae Park <sj@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 Jann Horn <jannh@google.com>, Liam Howlett <Liam.Howlett@oracle.com>,
 Shuah Khan <shuah@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 gkwang <gkwang@linx-info.com>, p1ucky0923 <p1ucky0923@gmail.com>,
 ryncsn <ryncsn@gmail.com>, "zijing . zhang" <zijing.zhang@proton.me>,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org
References: <20250714130009.14581-1-lianux.mm@gmail.com>
 <a3457ab8-8bb7-4a43-913e-2eb73149ff20@sirena.org.uk>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <a3457ab8-8bb7-4a43-913e-2eb73149ff20@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.07.25 15:39, Mark Brown wrote:
> On Mon, Jul 14, 2025 at 09:00:09PM +0800, wang lian wrote:
> 
>> Move the generic `FORCE_READ` macro from `guard-regions.c` to the shared
>> `vm_util.h` header to promote code reuse.
>>
>> In `guard-regions.c`, replace `ksft_exit_skip()` with the `SKIP()` macro
>> to ensure only the current test is skipped on permission failure, instead
>> of terminating the entire test binary.
> 
> These two changes look fine but they're not really related so should be
> separate patches.  Looking briefly at guard-regions.c I see a bunch more
> use of ksft_exit_ functions that ought to be fixed as well, but your fix
> is good.

The FORCE_READ() could be factored out separately, and as part of the 
same patch, replace the "asm volatile("" : "+r" (XXX));" usage in

* cow.c
* hugetlb-madvise.c
* migration.c
* pagemap_ioctl.c
* split_huge_page_test.c

-- 
Cheers,

David / dhildenb


