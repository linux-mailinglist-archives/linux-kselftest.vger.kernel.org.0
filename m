Return-Path: <linux-kselftest+bounces-33964-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8E3AC71BB
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 21:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 375057B4879
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 19:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7200D2206A7;
	Wed, 28 May 2025 19:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YJjxc5wg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B560F82C60
	for <linux-kselftest@vger.kernel.org>; Wed, 28 May 2025 19:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748461645; cv=none; b=l7vZqOsyHzhwUSqQhSqhcrN8xSlosaxaGWU8E2pgdXLLL627fVUmwrBiDkw/u0PLn4w5oyB5bwmhZF8mKC+99bhrNTVXaVP6cg+9B/BE1UK/GswLBG43YMawz0bHQjJ6/D/abHzjEgLMREuCVh3QAbpkEF0dmBceOs3MuWlnjbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748461645; c=relaxed/simple;
	bh=qzu/O5cbgHa1A7SMmfPezi+LRJu7xmZg3Qe1HliCsUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W3u/R/h7YqPeOaMVSRuLiMtOqHf33ZyJKFkPUilVTKTkX7HMJAaQarDkx/VpOwAcaEUIO3qtlOZFryIZ1eMCe2rFJ6EEOZPEJ3a+bs1pS0dDYczO1VAboNndFzAiWNli5fgXm0wM4hT3NSPckQIbSic8bAqLYx1tw3wQIDtoqes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YJjxc5wg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748461641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=E1sbNbzJcyv5ylnPczL2lJsFgJT8miYzZgeExLDdJSA=;
	b=YJjxc5wgtL+oL9WeLrePtYMWaMJzkesZAsZGvoxTN+sYcXlpb4uYL3vqavgfsVtqdhmxsj
	TqzwHrVAp2ROud7AEQ6/aOnpl4gZS3sgJPgYKQTMBdtHN30kMyg+z3QOyVMgXQFzfOuViK
	opD242Be2KPP95HSdYCuMfZ7Gx4D7UY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-Y3rPUQzhPOWV4oGgk47igQ-1; Wed, 28 May 2025 15:47:20 -0400
X-MC-Unique: Y3rPUQzhPOWV4oGgk47igQ-1
X-Mimecast-MFC-AGG-ID: Y3rPUQzhPOWV4oGgk47igQ_1748461639
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-441c122fa56so934335e9.2
        for <linux-kselftest@vger.kernel.org>; Wed, 28 May 2025 12:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748461639; x=1749066439;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E1sbNbzJcyv5ylnPczL2lJsFgJT8miYzZgeExLDdJSA=;
        b=BtHSuFkia0HA2Mh1Y7wYNXzgysclFwYrShWwMzfQ6eoJ4Me2qzrinatd3Ofzo1ZT/h
         kRc950Wsf2JTLPcX4MNnykkSM9KzEk2OZ+kMC++3OXV+MEj/volv9+sB1nqOL1dhRMha
         04R4wu2O/Lc3BqSJdvo9tHoauu/gpPNhehCGzW225DMIn1dCqOnnQQq4caUJd0wA2TC5
         Ulb5g/FO+y2FoYDUkn49OBks6SqOM/bD+TXjEQbJJGSVS8SudIdjjd/wqtZOIkv4ft+2
         mrT8LoEGI/VhNie5VethidUSi4YYTlfUXsYC4SLUc758eSzLZvk2HKKJRQnbJJKEJWVI
         T/Ww==
X-Forwarded-Encrypted: i=1; AJvYcCWVvFLs50wTUUgIb5FcHXQoLVtMIOejnlgzNWmi7Icr+KzHRnXFNnt93x3PY7yUXJqJFkc7e+1Atc0t7yN+QAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuLSECjsezOQ4cnvDXIEC9KtihSKygM5mr9sUVCXRIPcK71T0A
	3x+KoTTZ/b9Wno9sb5UNJvmyyfsugarQgr8+N4NkMakVqnplds9An0hN8LoUK7prk5q1WS1Lo+Q
	n0psItpoNUcRz0drLkIS3gUf0FEkC8/CoczLxE0SCoUowCxXCqY0lSXiE5hQlJO/jGvTMmA==
X-Gm-Gg: ASbGncuSvwzEaUt6uH6bY4tPR+bVqNBVvFToTJGLijI3R7OO6/CWqB98UoiTMsI9vNb
	GCAnuOJoucxaRoBXdD8YmAK0gy5smzXfm92CB+o/yIK+WX5DzLHBUDBEkUqxDg4dfB0uDtnK9zr
	16i8ia+/fMi9gr7PJn6wc+vsY6OvbSQ89cUWQD6KM74KeCrYtI5zRDPUJmhe+yFKZMTqv7rjH3f
	53V5FZL2CW5tNj48XKt2t7uAxJXltnMwd0rX5ABD7Y4fbsLju9WuBIs0F/HJFqZB3Am5SGrnWcv
	712wldyhwPr+WQNbKyJoJOOMpaXC9IUOMZMbo3gg4A==
X-Received: by 2002:a05:600c:3c84:b0:442:f4d4:53a with SMTP id 5b1f17b1804b1-44c9151293fmr194849025e9.2.1748461638639;
        Wed, 28 May 2025 12:47:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQSAvLo7Eqie62HosnzGxfv7hN4MV9xC0sn4CXjoTPfCTvWdS3TabcRAGK23QJ3x/FpWJtCw==
X-Received: by 2002:a05:600c:3c84:b0:442:f4d4:53a with SMTP id 5b1f17b1804b1-44c9151293fmr194848835e9.2.1748461638332;
        Wed, 28 May 2025 12:47:18 -0700 (PDT)
Received: from [192.168.3.141] (p57a1aa11.dip0.t-ipconnect.de. [87.161.170.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4eac7e919sm2361522f8f.33.2025.05.28.12.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 12:47:17 -0700 (PDT)
Message-ID: <cc13e6f0-3894-46b9-b234-11e066a9aadb@redhat.com>
Date: Wed, 28 May 2025 21:47:16 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/mm: add simple VM_PFNMAP tests based on
 mmap'ing /dev/mem
To: Aishwarya <aishwarya.tcv@arm.com>
Cc: ryan.roberts@arm.com, akpm@linux-foundation.org, dev.jain@arm.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, lorenzo.stoakes@oracle.com, mingo@redhat.com,
 peterx@redhat.com, shuah@kernel.org
References: <7df6ecb7-0aa8-4f18-ba8a-ce6d095cbd42@arm.com>
 <20250528182338.30117-1-aishwarya.tcv@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250528182338.30117-1-aishwarya.tcv@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.05.25 20:23, Aishwarya wrote:
> Hi David,
> 
> I applied the patch on next-20250515 and ran the test. The issue is no
> longer observed, and the test completed successfully. I can confirm
> that the patch resolves the problem.
> 
> Tested-by: Aishwarya TCV <aishwarya.tcv@arm.com>

Thanks a bunch for the fast re-test!

-- 
Cheers,

David / dhildenb


