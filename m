Return-Path: <linux-kselftest+bounces-37417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6055EB073CE
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 12:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 781D1189BDE5
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 10:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C402E424D;
	Wed, 16 Jul 2025 10:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cG4PqXW2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB41F2BE647
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Jul 2025 10:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752662672; cv=none; b=b/622Z+PyVVIa9K8u0v+MgnxoBbBw3HeW5opsA0uvE2uEQQIgZTROwwavywgs3hYtgx9/+VOcT+/ohwVPZChf2MKbfcCGit43ZJ77jBPq0V4fBTuJzKDUB28LZpZc/O6VScjF8BgIt+LuuSvnqjV2bidU1+GpTLPjqH8RLlZrkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752662672; c=relaxed/simple;
	bh=BM2RWK92PKISCA1wSUFtzN01XGb8/Ifi8vvkpRHlV08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GBqA16x85YXGXBUuHvZ5EHJIoLItqLD6zmkvAm/OYvrKm6Sn3wtIkGa2+2OzPG+0h9gJfaUHrHbbQNlywN+lk6j/kZNJe4eXK5C50/aACvoE1XcKaprFjCskMZW0MQx/jqV6SFrzV6Tf1L682vMs+40w+lsx5mH7Dq4WrTICl+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cG4PqXW2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752662668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=H0DrpHFYox10/T2b5Nsf8Ll/oRGOI12jubzByP7raXI=;
	b=cG4PqXW2SyF04gfzz0+6cbszuJZxchjTbE0+N0/oYTDB2LoKbtlFs0p0QzuSzNAXTGP56c
	ndcEDauNFaY6ZbDIaZhZIn7o0xW9jo8mbm95qDfeT5cVxCdmeXT8b4yzvDcPtDbgLnagR2
	qQf0YRTVK4ZbcSMkrT5WEwMLMhIsEng=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-enLmKVxeMC2cp5dKwMV4VA-1; Wed, 16 Jul 2025 06:44:27 -0400
X-MC-Unique: enLmKVxeMC2cp5dKwMV4VA-1
X-Mimecast-MFC-AGG-ID: enLmKVxeMC2cp5dKwMV4VA_1752662666
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f65a705dso4205373f8f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Jul 2025 03:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752662666; x=1753267466;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H0DrpHFYox10/T2b5Nsf8Ll/oRGOI12jubzByP7raXI=;
        b=mTBwfgJEQ4GLoTI1KACwC14wsOlu6JCU0T9K4/DxHhhs8HhXw4zvrHGQ3aIc6zA9aL
         rKtmkgA/2eDU4uLqXMeGsfw9AaV70Furf5riERqlgMElz++kz/shO5PvNIBjaGKpOatI
         lJteX9W4sosWn0dwWmAtcSbji17uoCUg2OpEzOivvgUkI94Fj4u9gCJsIgJctvqIyu1g
         iH2NNiSocRgeWnEL3UOVxQ9DQ2OKLDZJ2aAiSw0VZhNW08LoiVcnj/E/rk5V7NBWXfwQ
         P2RLXHbmviQ8YYeS+Hx+pdDiq0w0ABPhVI7XmLsbmBTQ56ISI5xnF6U9orTnwOyRjk28
         88rg==
X-Forwarded-Encrypted: i=1; AJvYcCVwCGoAtP6q4XQDmHmHYjF2l1x1Z6xbEVs/rWGlBbh957Bi/0RMn0vG+9RlavvUlQ+gDrdMOc5sLoDsdJkoOn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDum74BO1H97fO2KeGYFkjtKbXFHbq5D/rORCqruWt+V+fF5q9
	3+8ZoBR0CD057EImkZOhkwUWZnbbAMirnpsCSwVoadytTlcGVBZAASn0DFhmAJeYmC44nS49X8k
	vY2GJcm0KzYsoI4fqHcaBcFLggcGHSD8S2GrK2/y3xxsyb+mVCizEpWRUSCBueBSOkkNoPQ==
X-Gm-Gg: ASbGncujg6L3HucRl6fB1dGO/RJ38UgMgV2NLqKMidVS0IAfsANOVcaABu9ue4B3kVV
	XWtgydDyteAFPrrEbGvkW/urQiYc7YV4n/AFrqgXT/YWkzmFWqxyTaG5mumrgsVtNwT20hfV261
	LNMu0k84h78UBOVp6/4s4cM+KfNeTyxlhVSrh7di5Am9PgK2OK0qSccfW7bzSJtV905DNVIMhmY
	92lQTelwIdesx6fIxBWIpWM5JWic3omAjdU4LVwPGFE5a5g6kJQpxOY1C9iMjILOzkESX8J/2So
	pnPNDPhy16bvaVfqsCMyeh/I5cGPhOsieBx6xm82mU0sq8v+rwNWpXjP25FBcsh0AziBLhApNQa
	RcFK08Sg+QbHrPjrZzP+h8SZtj0JLYdGzEYRi163EHIyDFzWrkDq6NIIJMprSg/G2N0o=
X-Received: by 2002:a05:6000:3cb:b0:3a4:e629:6504 with SMTP id ffacd0b85a97d-3b60e5246a5mr1354311f8f.49.1752662666356;
        Wed, 16 Jul 2025 03:44:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWua8wVVW9bKulQ0ObMl//Eo2vwfpPgEkZ+TqYQycNsZHWW4bjQYPv7qQsGur2N+pi10FAMQ==
X-Received: by 2002:a05:6000:3cb:b0:3a4:e629:6504 with SMTP id ffacd0b85a97d-3b60e5246a5mr1354275f8f.49.1752662665920;
        Wed, 16 Jul 2025 03:44:25 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1d:ed00:1769:dd7c:7208:eb33? (p200300d82f1ded001769dd7c7208eb33.dip0.t-ipconnect.de. [2003:d8:2f1d:ed00:1769:dd7c:7208:eb33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562eb63551sm16517585e9.24.2025.07.16.03.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 03:44:25 -0700 (PDT)
Message-ID: <f041e611-9d28-4a30-8515-97080f742360@redhat.com>
Date: Wed, 16 Jul 2025 12:44:23 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/7] selftests/proc: add /proc/pid/maps tearing from
 vma split test
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
 peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org,
 paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com,
 brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com,
 linux@weissschuh.net, willy@infradead.org, osalvador@suse.de,
 andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu,
 tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250716030557.1547501-1-surenb@google.com>
 <20250716030557.1547501-2-surenb@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250716030557.1547501-2-surenb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.07.25 05:05, Suren Baghdasaryan wrote:
> The /proc/pid/maps file is generated page by page, with the mmap_lock
> released between pages.  This can lead to inconsistent reads if the
> underlying vmas are concurrently modified. For instance, if a vma split
> or merge occurs at a page boundary while /proc/pid/maps is being read,
> the same vma might be seen twice: once before and once after the change.
> This duplication is considered acceptable for userspace handling.
> However, observing a "hole" where a vma should be (e.g., due to a vma
> being replaced and the space temporarily being empty) is unacceptable.
> 
> Implement a test that:
> 1. Forks a child process which continuously modifies its address space,
> specifically targeting a vma at the boundary between two pages.
> 2. The parent process repeatedly reads the child's /proc/pid/maps.
> 3. The parent process checks the last vma of the first page and
> the first vma of the second page for consistency, looking for the
> effects of vma splits or merges.
> 
> The test duration is configurable via the -d command-line parameter
> in seconds to increase the likelihood of catching the race condition.
> The default test duration is 5 seconds.
> 
> Example Command: proc-maps-race -d 10
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Why is this selftest not making use of any kselftest framework?

I'm sure there is a very good reason :)

Reading assert() feels very weird compared to other selftests.

-- 
Cheers,

David / dhildenb


