Return-Path: <linux-kselftest+bounces-24217-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32556A095BA
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 16:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34A381886FD4
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 15:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF8D2116F8;
	Fri, 10 Jan 2025 15:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dGJrmNRi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424DC2116E5
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 15:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736522947; cv=none; b=NS9Eb+ZX1SIBP5uDnVzOzYHMGsbfLpNAVy00eSushLqHM8J4ZJ8M8Qll5YdG26YUWMLseJ83GgNGgKmGe+6ckgPh7tixdyiGQv+dPA5YFWZPrvBPPW9ixqK0WCvOEkcd2wjfLShDeaB16Xm/ExDQCBEDDt98JzH1YcuOPb1A36A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736522947; c=relaxed/simple;
	bh=ONFk/iX6hSegNSzb3FKu5rFfjM+kOjWnXrEQU9/+pC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hM5Lh53MQyEUI73ldQUhjtEHfSZgJ7gtEvp/pAfJarZHQ8TIBWATP/sYy1PNUrFWGVAVFkuGhEN2GHsUw+2qQyxc3lW8kIgf1Epphxm8odIzVCMsBNt2D0z9rl9HAvmV9tNFnqcwIVaBBoaka7ayif/hZSTWz47PCW8u8ft9tB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dGJrmNRi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736522944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JedACyF3qaYIJ70J/2rldT4MFWaos417O6C0UzElWMQ=;
	b=dGJrmNRij8aOAk4y79Mkack8DOXaDQC9B+DF4Tfm1XretkqwJnqK4yWxK9Ro01gxygGhQY
	OuDDY4p32tP/ppsm9nAKJjUa9rCx1Bcwz3LDIDJUCMt6jjvZI/djJKnBsETSCQzIJVfgPw
	CINDwGOvaAXATMbubPNZVasYpSzdQjo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-0d8SHxxnOmunM3xNfB60Pg-1; Fri, 10 Jan 2025 10:29:02 -0500
X-MC-Unique: 0d8SHxxnOmunM3xNfB60Pg-1
X-Mimecast-MFC-AGG-ID: 0d8SHxxnOmunM3xNfB60Pg
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4361c040ba8so12130195e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 07:29:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736522941; x=1737127741;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JedACyF3qaYIJ70J/2rldT4MFWaos417O6C0UzElWMQ=;
        b=NcTNcketxIg9Xoytu4VrYCxleKmIyEGq0arBU8IdVjGSowBjtG5N+lrZRk3uxCquYN
         s0pm04QVQUxYHVf2J2YGhCDEizWfoAjTIxqIvM5yuOSLUD1mAqUz1r+qqa+xX+5VRYv/
         siEvpPhzWugqgkzY9l+Hbratgo6+UiV6wsdBiK+XxKA2DoMYeeOZwevvz3Mmq8RR3jG+
         SIxCj2axf/dOmBDK8+FTbqwpwnTn3b/raxFKSHEwqYtkOVMKjgPsjWxow49epsykz2yD
         AtQeaIllPHRH7a84piIaxe9EAE1+D0ELDNO0YUsV/pY+/YrHP3BhV/uDWXYU4Agn8Q1y
         SXDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvsoqse/SrVULNR6Bzv1/e9OQnJ49j+vzPbKFxHp9iqfYzreD2L0T4wRtkHnCsIYEB6HN/1hemMAI3LbjM8NU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYIcew2tMYzu5v+mJs8jBRgZQlDr99j66fKG5gjaoxPPvonSKM
	82yH5OHOVKkdVT1POsgV+t5ujbLWZ9Bjwg2CrsJh+EnaHLYyqMqTHd4L86tPHLSMhJxvdGWGQdG
	KaK98ounEnSBRMgYUKVEeXPYqjywn0OFmPKNwr6IM50sqciZbWLtVn2xTx4+ner86ng==
X-Gm-Gg: ASbGncuu8vUoDbXO0DpszHBNvuDWeHi82WHfw865q5M1PpC8XV+kA4bm6zWrFJUF26t
	ht6urxTQbRyUzHIdcDBsOHS8qX8/cqbTzzDJtitdRntsPKIRXiFxI57bFYDYQCPBsx8JF7wK2uM
	dNQHhcRazUOcfA2QXMt+NQCnTTVmKxN12sPRR06iqcb0yA7irAvKOzYArV26JuddWw3BjapbGrc
	Jn8qyrm7IXDZ3wzw4HXZVXeb/ThXUYldFEBzi4tYYM+xYpTMxNDbp3C4VRV1RKrFCDJ5nOUvauQ
	UXe6EObsVhzC9TpKgN0WqLFaSjuF8JDC/KyPLuspQgv6xD9aAl8q/MzchS51/tUlXHYxHyZtt/O
	oTzOkzIy5
X-Received: by 2002:a05:600c:46c6:b0:436:5165:f21f with SMTP id 5b1f17b1804b1-436e26d9482mr94059595e9.26.1736522940991;
        Fri, 10 Jan 2025 07:29:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnAGe2xqHxmg2z1ZugKda1zemeP3ZymZ6IqA3Yc14/9MbHhyrmu+3BSz6AZa88PuYXrh1Cow==
X-Received: by 2002:a05:600c:46c6:b0:436:5165:f21f with SMTP id 5b1f17b1804b1-436e26d9482mr94058915e9.26.1736522939414;
        Fri, 10 Jan 2025 07:28:59 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:e100:4f41:ff29:a59f:8c7a? (p200300cbc708e1004f41ff29a59f8c7a.dip0.t-ipconnect.de. [2003:cb:c708:e100:4f41:ff29:a59f:8c7a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4c1ce5sm4865805f8f.94.2025.01.10.07.28.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 07:28:57 -0800 (PST)
Message-ID: <1ac669c9-331b-493c-a241-8a7a07716eed@redhat.com>
Date: Fri, 10 Jan 2025 16:28:55 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] selftests/mm: virtual_address_range: mmap()
 without PROT_WRITE
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Dev Jain <dev.jain@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250110-virtual_address_range-tests-v2-0-262a2bf3c3d0@linutronix.de>
 <20250110-virtual_address_range-tests-v2-1-262a2bf3c3d0@linutronix.de>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250110-virtual_address_range-tests-v2-1-262a2bf3c3d0@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10.01.25 14:05, Thomas Weißschuh wrote:
> When mapping a larger chunk than physical memory is available with
> PROT_WRITE and overcommit is disabled, the mapping will fail.
> This will prevent the test from running on systems with less then ~1GiB
> of memory and triggering an inscrutinable test failure.
> As the mappings are never written to anyways, the flag can be removed.
> 
> Fixes: 010409649885 ("selftests/mm: confirm VA exhaustion without reliance on correctness of mmap()")
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> 
> ---
> I went with dropping PROT_WRITE instead of adding MAP_NORESERVE as this
> works even in the face of OVERCOMMIT_NEVER.

Yes, makes sense, it's certainly simpler this way.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


