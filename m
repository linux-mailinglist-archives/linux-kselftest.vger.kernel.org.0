Return-Path: <linux-kselftest+bounces-32742-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4156DAB10F6
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 12:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1960162B96
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 10:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9FD28E57C;
	Fri,  9 May 2025 10:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NNT/Ij/U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F0617BCE
	for <linux-kselftest@vger.kernel.org>; Fri,  9 May 2025 10:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746787436; cv=none; b=cDgk+Wh+tPo5lyiFNP+2G6yYZFQvlAnIS1YFcA13XPDEtMNEltKOeGGwAejTw6h2mWpoPeylSJxcgBAW0KQb217ZKLyKOa3xg9V6dWYOqS5nq1oZd37v69rs2oDejXk1hOxmCtOlMPky+fOghA4aMqajPIBhC9btyi8vMw8xl2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746787436; c=relaxed/simple;
	bh=JV+tHenNIB4LDTqRqk4lSX6uey2Np7nRunFx+ydfJsA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=md65DKDOSXVczrukD1+yGhrkBR0o4lLvDjPwbpyK+9PFrLm6tOC5bjolKHSvCrt3fuxnwcA0XEV2sf+xJi7OKf1y6CyZVQrjkE2ImjsTPZZLt18SBagcKdAyoolCIhCSz6ryQJLThI3t2Ew16tRZYri/YZnM9er0wXOR4Xkmm9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NNT/Ij/U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746787434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=t0YuuKqPOefner0ewCou2iYZdkYY4bwjKexcRJon0/k=;
	b=NNT/Ij/UZ6QZkVjqQFBq+QTAKHWWJiwURiwSSH8kz6jM+ljNfOyNaVo0+jHbGQSBEAniU/
	loFEe6J54hMAAxraZbJs8LvxtUxA5yDkJLT5oSxYDfE518z+BjOufTAs8yvwK1Vi+ch4wa
	uMCCELTUzVkqUf6VCQf/XVFSzERs92k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-ndU-mNAXMHO8HQEFVgD-Tw-1; Fri, 09 May 2025 06:43:52 -0400
X-MC-Unique: ndU-mNAXMHO8HQEFVgD-Tw-1
X-Mimecast-MFC-AGG-ID: ndU-mNAXMHO8HQEFVgD-Tw_1746787432
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43d0830c3f7so13122595e9.2
        for <linux-kselftest@vger.kernel.org>; Fri, 09 May 2025 03:43:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746787431; x=1747392231;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t0YuuKqPOefner0ewCou2iYZdkYY4bwjKexcRJon0/k=;
        b=SjijYtaO3oPtldNiZCWhcoFc0RL3TEjLuzBtzB9WhpcJ+dZQf+N42AX+YKHBk9hVCK
         P4uMVYTKm5MXBurW7pjSFWhS7+buSqPFMvba5ioyBGt6VsiLmWd0zVc4ui6omP5C9lma
         O7MiQZ29lH2z0vuKXb/9mBiGePX1U2DVVKhIgyCH852eboOLXL5fvcu0RcP69vNQqWc9
         3JyfWGcEsAmcbXR+j4LFgC/dCa7sr568aSV6i02GBE0knyKVeYACKbY9bRc8Sv8RcOEl
         nM63wyOqMc2+S/jfocMoLO076eXYTqvC2UprQBnNJmnLfwroQEjNhBjoULhirrGNlNze
         NFPA==
X-Forwarded-Encrypted: i=1; AJvYcCV4xqsuEUsur/61uAsWNrPV/qYZfjPR8EVpRXjQTQ1GbpbOnsoFLbNmE5nHM1vfnJWWg8b+WVz6P2FIKJDlxoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoJ7FyK56jMwWc8RvGGKJvbQCobpq2BOGHSSXzKe6Cuf47mzP3
	8suP6bNccuRIdV5Kghq4mFaTAiiLItPR05t189FJilDkonnCjSFLexrwJkdOhUQhAAjY4QJexeJ
	G6p3vtD3II34YvQpYDPU7uCucpex0wc5T15RvzX02JUBAwH35Vo3RqOMZsk1od8/xCA==
X-Gm-Gg: ASbGnctEV8uTQGzlhgRmHV+XrJHRj4q+rn6ZpyzK0OrHvimeCIZuZudSoect+MDf5Tm
	doy7VVudp48vyfytqD50vBD4gmWFZbz2BJFqzB+TeulwN0YzXMDz0iWu3+/BpU2GOimBtvCGCsn
	nwZLAviooW8EvDaOUJs2gAUlfWmSv4DW6HdTYR6JxMkJXcmQQQLraibtwluBmykTUU0xfGnRgGW
	w/jRkJ7rMN5sPYVmGhtQ1TQBFJkEpTCQBGjJyxduyFF3tZh+zzuPl0C8Q1YKWSY04uS0s8MHJKV
	f/ZrEr0+9AW+VucS/5S8dB5hUrMpUYVVwnZu8PqVDp3gierkhpv6EKnr04yjOKJlYCG7mz3MGRP
	NMoGNA0qYl7dhX38Y7iN5TpaxT+3cFO3790Lm6us=
X-Received: by 2002:a05:600c:4e09:b0:43c:f64c:447f with SMTP id 5b1f17b1804b1-442d6dde9c9mr23192245e9.29.1746787431624;
        Fri, 09 May 2025 03:43:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7HNyHl+655gN1OiyqWhRPdGXDj2iazbitjAhPfi4NoY848N16dn1QqOdDtVonibTlkHtSPQ==
X-Received: by 2002:a05:600c:4e09:b0:43c:f64c:447f with SMTP id 5b1f17b1804b1-442d6dde9c9mr23192085e9.29.1746787431293;
        Fri, 09 May 2025 03:43:51 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f45:5500:8267:647f:4209:dedd? (p200300d82f4555008267647f4209dedd.dip0.t-ipconnect.de. [2003:d8:2f45:5500:8267:647f:4209:dedd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d7806a73sm9450265e9.3.2025.05.09.03.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 03:43:50 -0700 (PDT)
Message-ID: <a0a54f02-bee3-41b8-8c4f-9cfd7ea524ed@redhat.com>
Date: Fri, 9 May 2025 12:43:49 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] selftests/mm: add simple VM_PFNMAP tests based on
 mmap'ing /dev/mem
From: David Hildenbrand <david@redhat.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Xu <peterx@redhat.com>
References: <20250508222041.1647645-1-david@redhat.com>
 <8c94faf4-9af9-4d43-a597-6b06dd21be95@lucifer.local>
 <4efa9948-a523-4597-baa4-c36d18a658b0@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <4efa9948-a523-4597-baa4-c36d18a658b0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> Is this not pretty much equivalent to a volatile read where you're forcing
>> the compiler to not optimise this unused thing away? In guard-regions I set:
>>
>> #define FORCE_READ(x) (*(volatile typeof(x) *)x)
>>
>> For this purpose, which would make this:
>>
>> FORCE_READ(addr);
>> FORCE_READ(&addr[pagesize]);
> 
> Hmmm, a compiler might be allowed to optimize out a volatile read.

Looking into this, the compiler should not be allowed to do that. So 
FORCE_READ() should work!

-- 
Cheers,

David / dhildenb


