Return-Path: <linux-kselftest+bounces-7222-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 316F7898E36
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 20:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45D51F2115E
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 18:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69F1131199;
	Thu,  4 Apr 2024 18:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6ZbSYFj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E45E130A57
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Apr 2024 18:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712256344; cv=none; b=SWlkCNysNJerz28TOW0RvwSMGZ4PK77oG8eJb3UNg95bYfLbtdULep5Cjt/PgD054wikfQ3fUSftMdO0Me8foREH9g6DDokxglkGLY8gF5knt8/xFH2Hb4h2srKLLLGFDlGeNgAJ4yU0ztOD+qaVlodm+z+AR7ydZxHQLPD/ZZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712256344; c=relaxed/simple;
	bh=YEZl3q1yTtHHvXmwpJPizfDKb035qKkATo3/f18BQ8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zoi9XYZKYgXyvRsad+se51DdMTJP0VI6BeudJL1lTGQwDv23xpwRfATx0Oj9w6yQtpgQ+2ztB+e9pcTcZUrwXzCoLYfgEnRE11tEr1WfOavInLc4UdrX9bvb9TgQQ+LPZPjIjARG9ZufUUWvi8TQ+OrLnAh2h1fszUAjtOehpqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b6ZbSYFj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712256342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=P4CFFV+alXdlCyG25YnJ9l+lNB6f5pGDPyHcNnnheEo=;
	b=b6ZbSYFjS8Gx8gbpTbYLSSKMwFyLAqhaVi7MyFqVL9xNGqfahlF3xEAxaZadD8FP4UKR4y
	vlY40Xww0AOhL1vDWNiQ/3KXQyIjmlazhD2y9RqOmm+2209UsUiZBQYQaNJZ4Id26QVyWc
	ud5W0s3Rt/nAQrC+fB6QTpFC1YiuSoI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-uEkFS5A0OwSCHukmDxRdCQ-1; Thu, 04 Apr 2024 14:45:40 -0400
X-MC-Unique: uEkFS5A0OwSCHukmDxRdCQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d6ef704b35so12842631fa.2
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Apr 2024 11:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712256339; x=1712861139;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P4CFFV+alXdlCyG25YnJ9l+lNB6f5pGDPyHcNnnheEo=;
        b=rijcMBpCg6/Rd3rWzsy7pGzdN8dDvuSX1xCGmyAUEkAfurB5T7XSBcRfykW/O+NxC5
         sT/17EHJTuOZCQhF6wC6EQ4zIMoG8dizw7J65OrcOakj3NnpVcjRuVy5wZx/dEaotz0h
         0DzFDnqFG97L3qds3oN7SFqLfKnG8w+9xnSvXSRrhAo5O4oxWNcuCxlZoQw2pYAfyyHi
         QtqZ8hpccKZMQZBqrrNUwpfdapRPKVfqC2D6KP2rUB49Ivgzu1RoMoMjag/1Cl6a0HT9
         RrxVyd5RF1+KMItnrWJ4kAjj81IciWJ9QaFVShzy2bVZudjNxFurllJYaXKaT3cz3hzi
         tm9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVH9kSzBqe2q8d13OzVGgu1grHMgY8pFpMIKMFYY0f6D9ubrBAG8f5Divl6vc1QDYEfx9/8hO33OKNgQWHvCQCw0MDBqzL+uetGY/x913Jk
X-Gm-Message-State: AOJu0YwsnVypFO49PEssMxPZBLMhoIkGGAIwWnS0RVQQgvjhyxSnoXH4
	BaWtHDOMRlfyraxnmki9WT1Mvyjn1dFcGbLvxzZg5+jRJq3VEefDnld7q9jv0R8BnjKvVq6UZ8U
	qQF7Vw3TaN7mXwGTRh1Noe7iNj9b4aMkhqQUEqMY+ivd4I1wqdZvKAH/1CHQUPPMIsA==
X-Received: by 2002:a2e:9058:0:b0:2d8:2d48:18f7 with SMTP id n24-20020a2e9058000000b002d82d4818f7mr2547848ljg.9.1712256339255;
        Thu, 04 Apr 2024 11:45:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlatkvsg0q9AcaDAZlYYVlE3sMxwFbiNRjElWgpj6wFxXDcDH3J+9Fo7R1SYp8wnfuw0f9Eg==
X-Received: by 2002:a2e:9058:0:b0:2d8:2d48:18f7 with SMTP id n24-20020a2e9058000000b002d82d4818f7mr2547837ljg.9.1712256338887;
        Thu, 04 Apr 2024 11:45:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c743:de00:7030:120f:d1c9:4c3c? (p200300cbc743de007030120fd1c94c3c.dip0.t-ipconnect.de. [2003:cb:c743:de00:7030:120f:d1c9:4c3c])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c314f00b004155afe0c11sm3615895wmo.15.2024.04.04.11.45.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 11:45:38 -0700 (PDT)
Message-ID: <7c54ce8d-b18b-4c5d-bd7d-56482e2bd946@redhat.com>
Date: Thu, 4 Apr 2024 20:45:37 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests: break the dependency upon local header
 files
To: John Hubbard <jhubbard@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Suren Baghdasaryan <surenb@google.com>, Peter Zijlstra <peterz@infradead.org>
References: <20240328033418.203790-1-jhubbard@nvidia.com>
 <20240328033418.203790-2-jhubbard@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240328033418.203790-2-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.03.24 04:34, John Hubbard wrote:
> Use tools/include/uapi/ files instead. These are obtained by taking a
> snapshot: run "make headers" at the top level, then copy the desired
> header file into the appropriate subdir in tools/uapi/.
> 
> This was discussed and solved in [1].
> 
> However, even before copying any additional files there, there are
> already quite a few in tools/include/uapi already. And these will
> immediately fix a number of selftests/mm build failures.
> 
> So this patch:
> 
> a) Adds TOOLS_INCLUDES to selftests/lib.mk, so that all selftests can
> immediately and easily include the snapshotted header files.
> 
> b) Uses $(TOOLS_INCLUDES) in the selftests/mm build. On today's Arch
> Linux, this already fixes all build errors except for a few
> userfaultfd.h (those will be addressed in a subsequent patch).
> 
> [1] https://lore.kernel.org/all/783a4178-1dec-4e30-989a-5174b8176b09@redhat.com/
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


