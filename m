Return-Path: <linux-kselftest+bounces-11936-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 115BA908BE5
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 14:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85CEC1F2786C
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 12:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4076D199234;
	Fri, 14 Jun 2024 12:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CCkG1sXw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872FE1991D4
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Jun 2024 12:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718368916; cv=none; b=J6vk024etFV12P00k4GRIhbGkxcvjy2WPbfFWmnLGRc86d1K138AUKteNnlHCwAoTtTixVVaXu8DLHjpmBXPnuwxdFxPuwlM9Vh/bvm3bB1tQss9tq6ReUfXVQr3NtPEiOwbPj+qvLcmYvW30j0mS9sR/Exy1tGkH+obXkg9GIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718368916; c=relaxed/simple;
	bh=0Gb13gkJSeAxhZPpbBeTY7+9eGjCgDsDFH/5LBPUpJc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Gq2syy/SgydVEAbMHja76lYKNFXuFwrnF1MudrRPoIaAKr/g9VgA+KUUATHaIrqXrl/K6zmkHRrf61hlvaGfytZ4voP1XVa+DDZkj4kdfdlkZ05bdG1GdNaCGH8QZQQyUD+Na7dzDPa+QBHuPOlm4sB9mi0Sa2c+Ydr/viiaDQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CCkG1sXw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718368913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qVCa7RwQroi261t1F6XjVS7+W2uN0kc4IDTx0N1MMdo=;
	b=CCkG1sXwwaJA7Oq5UJ4hQVlpQ6ZLP2WvcEkSvr0fD7ktgqT5/eWt/F3w/oKYQpFN2foLlT
	hVC45mNHijuiiz63WEL4qBPzyPC+00E/qHkV2OYwlUTHWOaM4JDW7NPgFpnCFjS0LoPMEF
	LwaqtE6otIOhNddLFsRNPEXBk6tZvxE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-h7LoIgvPPU-LmREubAJFJQ-1; Fri, 14 Jun 2024 08:41:52 -0400
X-MC-Unique: h7LoIgvPPU-LmREubAJFJQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-35f1f8d48b3so1263515f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jun 2024 05:41:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718368911; x=1718973711;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qVCa7RwQroi261t1F6XjVS7+W2uN0kc4IDTx0N1MMdo=;
        b=Ep2aap1hzuEuu3B5RiFCAJbJEw9/fwrZLARvhlLhJvZcJwiXgZhWlA6COaDY4woIzi
         4yjr/MpNhvRai8bDkoNJJoQUNYlkM4yMY+J+iYh1MafRZswVyt2jAeVU3OwkQTheeYdL
         6TwT+v3MZFVx26koxqRjUVzLZVs5Zv9voCy+87RWH8Mh1nKsstP0yK/fA9X8XZ1rltNa
         37OqfW0Fh7DqpJESbWL0a6ZnqfB4n6K4wDlTZvSAMlRLckuOaGDb6+7Zh4FxMKY53Yg5
         19RvMueiWWUuoZqWI7WxQkpyEcS30af2jd/D9MX305SchN5UjZmlRb1y/hbbnAjujef3
         7ZJg==
X-Forwarded-Encrypted: i=1; AJvYcCW87hjSDk2AHpA/PI0NWb0gh+myMNm/OUbQxhQGs25L26HNZglMINWgBZVuhrMGB1XNlyrgI3jtHtDsryB87d3RuOP80n2XhA9q3an3cAcW
X-Gm-Message-State: AOJu0YwXGGuD7SCzUNIqEhN//YD5TWP2MId5K7ChxsFLHPPFYM2KNw1F
	yXMptKF9aGnt6QFqBeFVUNgpnXm/rL1XF2Wt68OD7ZAIBiI6yOdE2N7cqStyRUIutUfke0g7gu7
	vIKeHxDk23atgpAcPnGFJlKHe2MDMcYaVQQbDYmQFP8K1vwCGRxjB2smQ8tVWOhJL4A==
X-Received: by 2002:a5d:5283:0:b0:35d:bd46:960a with SMTP id ffacd0b85a97d-3607a764bf2mr1704158f8f.23.1718368911073;
        Fri, 14 Jun 2024 05:41:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDCXn202g0cRFTygkw8Oi1Eh/fwqFY0cLSIqyqzWBUKuRCdAAvjwjeStFj7/sd3j8BQHttjw==
X-Received: by 2002:a5d:5283:0:b0:35d:bd46:960a with SMTP id ffacd0b85a97d-3607a764bf2mr1704134f8f.23.1718368910688;
        Fri, 14 Jun 2024 05:41:50 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4f:2b00:69b5:3684:56c:6dd5? (p200300d82f4f2b0069b53684056c6dd5.dip0.t-ipconnect.de. [2003:d8:2f4f:2b00:69b5:3684:56c:6dd5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075104a0fsm4327929f8f.96.2024.06.14.05.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 05:41:49 -0700 (PDT)
Message-ID: <e6378446-6087-4ffc-9ce9-320c5e128bd6@redhat.com>
Date: Fri, 14 Jun 2024 14:41:47 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] selftests/mm: mseal, self_elf: fix missing
 __NR_mseal
From: David Hildenbrand <david@redhat.com>
To: John Hubbard <jhubbard@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jeff Xu <jeffxu@chromium.org>,
 Shuah Khan <shuah@kernel.org>
Cc: Andrei Vagin <avagin@google.com>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Peter Xu <peterx@redhat.com>, Rich Felker <dalias@libc.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20240614023009.221547-1-jhubbard@nvidia.com>
 <20240614023009.221547-2-jhubbard@nvidia.com>
 <1ea35568-bfe5-430e-9f4b-edef17f0b22b@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1ea35568-bfe5-430e-9f4b-edef17f0b22b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.06.24 14:28, David Hildenbrand wrote:
> On 14.06.24 04:30, John Hubbard wrote:
>> The selftests/mm build isn't exactly "broken", according to the current
>> documentation, which still claims that one must run "make headers",
>> before building the kselftests. However, according to the new plan to
>> get rid of that requirement [1], they are future-broken: attempting to
>> build selftests/mm *without* first running "make headers" will fail due
>> to not finding __NR_mseal.
>>
>> Therefore,  add ./usr/include/asm/unistd_[32|x32|64].h (created via
>> "make headers") to tools/uapi/, and change the selftests/mm files that
>> require __NR_mseal to include from the correct location. The way to do
>> so is to include <linux/unistd.h> instead of just <unistd.h>.
>>
>> [1] commit e076eaca5906 ("selftests: break the dependency upon local
>> header files")
>>
>> Fixes: 4926c7a52de7 ("selftest mm/mseal memory sealing")
>> Cc: Jeff Xu <jeffxu@chromium.org>
>> Cc: David Hildenbrand <david@redhat.com>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>> ---
> 
> If it works, great

... thinking again, are some of these headers arch-specific (IOW, 
generating them per-arch would result in something slightly different)?

In tools/include/uapi/asm-generic/unistd.h, we already do have 
__NR_mseal ...

-- 
Cheers,

David / dhildenb


