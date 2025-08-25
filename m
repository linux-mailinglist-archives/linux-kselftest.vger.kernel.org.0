Return-Path: <linux-kselftest+bounces-39880-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B84B34AD8
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 21:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 393171B20DCB
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 19:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE9E25A357;
	Mon, 25 Aug 2025 19:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ehTz4Jzx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993311E32DB
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 19:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756149697; cv=none; b=at75U/pmGgi8wl+fcvZcr6ht8uve3BLl9CQRe2qV3eclbCP2AUqJIXMEaPU9wg5UYEa10nFJ5ZHnB1bBMvco/5x806ARVy6zIJTDme+uunVMkQY/UJHATLEZmIx1XTvCL47aglNwOAhxnOvDfc2QVpvOra77qgXnEzQq7XujsmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756149697; c=relaxed/simple;
	bh=gAd8R6P+ashAsKOaoPBAZslHm4lpM/gr56AhKeUPw6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bWN10RB5g3d4iFhN3lvSzvDYegT6GbtsZnRWUnlUcMr39fEsABSNcXHGs3Hmy65P5nkpRfse27DhGmj9jNjKis74Ftu6OKV0fhaZC5Hmiz6pfG/qj4ExLyOZDroRPuhGPvZJ2b74jhsL83XSn4CfZNuNGv8uioHdgxwUKDXPYoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ehTz4Jzx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756149693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4973FsADhzdVXNTFjytsdhgtYARkFQAq+eNa6ZCfdrA=;
	b=ehTz4JzxxqI74pvKkZzVAvcqFC1txxbhjNnrMZburw7cQ2/lhoL8/bcy6U4wj9BVsgBo9b
	C4dSBpiIiPqWUcqf9jvOkRWS+jpIClPjqUhbyO4TSurDQ+fNZYJraH8tG92icr0/pKnwU9
	pdl5wh1DN9dwxG8xEwFaCLq8KvOSMFw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-REzWwSu0MgSHoSO5wDPxOw-1; Mon, 25 Aug 2025 15:21:32 -0400
X-MC-Unique: REzWwSu0MgSHoSO5wDPxOw-1
X-Mimecast-MFC-AGG-ID: REzWwSu0MgSHoSO5wDPxOw_1756149691
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3c8406fb5e1so1517970f8f.3
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 12:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756149691; x=1756754491;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4973FsADhzdVXNTFjytsdhgtYARkFQAq+eNa6ZCfdrA=;
        b=VN32JTWBafoT3G7e7b1ipjrBN46EilZWnajDBrlqGJq8wmcL7DBXr8pKgUHrU/FDtN
         7UhQ7ze7mTgDSs83XbUtv8ve8c+v2j5kIUeQ/U1p/VJ0aCV+wDWzW1f0V7NfH62cSPLW
         kP7Z3FfKaVx/IxVbm1ddqi46qNi/qv10Cnt7tlMCLarUsy8wN4xrvPqAtRZwdWhq/COO
         G9Il9es0PAAA6iLiVDVWjWewFy06E66AS6k3I6GbeQiYiA0Gc0Yt6I3Ph3vACsXUcB2Z
         02wpcOvkHVqp3m09y1Z/7p9QqLsVQRg1OC40Hqc5aDKjOjMiBBek5gPBenapyjNZ/5BG
         O4OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfCpjj2+VO1lAfx54BC2/pKfi1XLbgEnMoNlu12+GGFCXyIeO6TMDPcntPiEVPaoAEcol0dljpQI7UXbO9gwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUIg5qvBvdE5WmP4iTC+S5N0DysvuxwaisNsHvQFtqIqynnyCe
	4oneSk5oqwC94d604V7l/9Eu7pp+j2E/fQqCbB1856IVYxxHbpE1IquJzd6POg/ppeT2QuxJxrY
	GJN/SwCuRJD2P7wlW2G8lfe07WuLcJUfxZW44UmY5GA4iMOrhoGKzBK9aYJ5NHipzhZM/9A==
X-Gm-Gg: ASbGncudXDxZ8Yje2EJD/K4tun2isOgcsv0my7jcIQs3oEJyT3Lr2yftPyr2EKvRvrZ
	mvPeWulKmVgXHkz5V+DyuQm66R7sa6OfFjkWPQXmBSY2EO7OX45qp9Oh4t2Dr/cRctOrGH8Z1Uh
	wbRc3RmGXDuFpyuuEtVy6nhpEqfg6EK3vaqT74vHaw6KI6oIP5R0Id+Wmy9btZYB1Msn1wcQlWh
	6u9wgXfwdDc47PRnewE8oMAVIsaC6CgXCBLlcJdQy2TprsO6BFTVp82e0YGjUvDnEbBra7ljzxF
	OUGeWRYXnY73eF8JweFJb9N+biBYVk55ldPGf3O37FRAtcc6I7jyEaFz16NNcBX3xqPzUdrIuNy
	p9M+ctEv6gAvrF/YKM4UPeaU0EuXf6pd+AGOC9VTRuj4gCZ4D/mp04R6lKKMKFyqMAEk=
X-Received: by 2002:a5d:64ce:0:b0:3b7:9ae0:2e5e with SMTP id ffacd0b85a97d-3c5da83c912mr7364283f8f.9.1756149690791;
        Mon, 25 Aug 2025 12:21:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjWNW6Xu5QSvFxBNL/CfYdsPBPx9ubozM5lZ0V7FvEndNA7Hp/scIrCJusDS+aryhQ7TGOyw==
X-Received: by 2002:a5d:64ce:0:b0:3b7:9ae0:2e5e with SMTP id ffacd0b85a97d-3c5da83c912mr7364272f8f.9.1756149690332;
        Mon, 25 Aug 2025 12:21:30 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4f:1300:42f1:98e5:ddf8:3a76? (p200300d82f4f130042f198e5ddf83a76.dip0.t-ipconnect.de. [2003:d8:2f4f:1300:42f1:98e5:ddf8:3a76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70ef55aabsm12458636f8f.23.2025.08.25.12.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 12:21:29 -0700 (PDT)
Message-ID: <c512ddc5-0d04-4af8-8b26-2c671e43a3f8@redhat.com>
Date: Mon, 25 Aug 2025 21:21:28 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: use calloc instead of malloc in
 pagemap_ioctl.c
To: I Viswanath <viswanathiyyappan@gmail.com>, shuah@kernel.org
Cc: akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
References: <20250825170643.63174-1-viswanathiyyappan@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250825170643.63174-1-viswanathiyyappan@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.08.25 19:06, I Viswanath wrote:
> As per Documentation/process/deprecated.rst, dynamic size calculations
> should not be performed in memory allocator arguments due to possible
> overflows.
> 
> Replaced malloc with calloc to avoid open-ended arithmetic
> and prevent possible overflows.
> 
> Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


