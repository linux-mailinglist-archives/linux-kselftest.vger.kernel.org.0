Return-Path: <linux-kselftest+bounces-29829-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BB3A71F12
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 20:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00CF57A3087
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 19:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA40253B43;
	Wed, 26 Mar 2025 19:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LR209uFy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EEE23C8CD
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Mar 2025 19:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743017058; cv=none; b=b9EB+qCVj7KbC7Adzq2N8oYlNqaPfMPAAXMKDCF0j7qY4gLpOVw2P3vvm4eA9uNyRDDde5em3GuOo/oU2SRsn9mGIzpWhp6gXK2EALRoaQcWJCfGyusDFoPyt+rg6T4JqcD+U+eiYjczwTSBes+NBPzMXuMlAZgxAWg7u3ko/Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743017058; c=relaxed/simple;
	bh=v/8sO9aY6Fj8YF2TcOYwjtbMV3BfK54upsEGdZxeTU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FrO6qapfv7xb1MvV2emegJLHyj+kELdHR34t97HzwUB/IEDpZ8yV/KubJFxRc0how21NISYwT8Mk1KvrXxV8MnV4lERpYqAFtJAtq75zMJ4Angg4S2N0Ebrd2d3yUgwai8uTe1CakzmhQZ8wDCSkjCX6z1S6chS/N5MjeHTpE3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LR209uFy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743017055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WR4q0K9RINwOvLs9yveVcMM+axrOT2+6rY2lFiOG9pU=;
	b=LR209uFybhgPgLTXQ8mJgG9LLxmfjEvXGrqP0NtjvKJ6sq10XpAQskdino8iiS9v46UXlu
	/7oXSC6Jo0ggIlREYGzDm1dwYHBwqoXbeuoCUcYH9bodPb/NX3DvMyDj5WPOWHZJKJs8UT
	4id/uX0nucji1fYmaedU0gTs3haPhis=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-JtLVDOZxNy-GE8SEwq9zjQ-1; Wed, 26 Mar 2025 15:24:14 -0400
X-MC-Unique: JtLVDOZxNy-GE8SEwq9zjQ-1
X-Mimecast-MFC-AGG-ID: JtLVDOZxNy-GE8SEwq9zjQ_1743017054
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c5c82c6d72so44778185a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Mar 2025 12:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743017054; x=1743621854;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WR4q0K9RINwOvLs9yveVcMM+axrOT2+6rY2lFiOG9pU=;
        b=pk2S1M+YGnJNQ1INfBLzemiZnxR0DfyDJA56yy1FZnaZcQiUw6eA38NxUk9IYov83Z
         xuY2qbrhYjbLP9EkDOSFN0d7Em6yHHCdZqkFOc3h72ut3SK7WFCRa1mI35yMFC45S8Wj
         KmCR3ASgDqUGCUj4c4g4jzBxl6wOhl8yAyuwo21VGndtgya8naMAzPWiWD6+0VSb6g+g
         LkLmqRYbVv9DGcsj8iBokuLPR1Nuhawokyw+bpcqnzPsoeLrVw38N/XFDqtfBBZNNemc
         vXsZGbz9Eg5P23oLMfX2P6SUluJIbVCSg9+L7BYlCviaVDEiu0DmT8q816py+QfoHlW6
         bYFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMn43a7m6F4J4xB/RNL4wEBVr9U0P4/wRBotfpr75W57mVKkmHByG3lmHxkBWg/rfQ2MKapqX/ND4WbSRwLvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqMH2EtI+ycrek1mIXfuxb9kqAZxJM340/NgDONPdmfKpwErVs
	Ll0awG238xLkE7uWbM8+RpRdJizVre0YDzHNd/c+vFbeotZw3qm2o3DQyNpiFVbhMfK7zNq35Ab
	ZCuwvuEmHsCOjEJIcOlecCD+zzc8OiClKhsI+MizTIJhtqs/q4O91JksIChlD32DiQw==
X-Gm-Gg: ASbGncs6To4Qshjyct4VIp9lGFa8Og/oIsUKQ9j172Y+wr+dM1kPH46DcrdVG50W/5D
	Cy0qrelM3gn9E/dryjKuMzQ4qmaGqa+suyCKlQIprpTNC0LAdT/LC/pn1wtv49JmaAvLMhOW7rI
	fUq6mkd68OZjo2VtAx6wzVrIwaunwHZF1AsePsZzeJDlRcUBvQ1zUrM31Flqo8cJKCHUbEhlXmx
	vygALFj/sMJEXqN99aRcuBu0yGmW2oe13nH42/WF5RZJ3XocUTQMuymkNuKXgcplJ7HGoIDUvM5
	6rEgKbqnDtCx
X-Received: by 2002:a05:620a:2403:b0:7c5:49e3:333f with SMTP id af79cd13be357-7c5eda7c9a6mr155660185a.36.1743017053818;
        Wed, 26 Mar 2025 12:24:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5UhoZ0GmEjNuQ4mGxCzC8Dkynp/HRZEvYqbRW1Hk3tatujaXIJHUQoRIRmj6q6lrFprgJbg==
X-Received: by 2002:a05:620a:2403:b0:7c5:49e3:333f with SMTP id af79cd13be357-7c5eda7c9a6mr155655685a.36.1743017053430;
        Wed, 26 Mar 2025 12:24:13 -0700 (PDT)
Received: from [172.20.3.205] ([99.209.85.25])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5e9a22eaesm79891185a.68.2025.03.26.12.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 12:24:13 -0700 (PDT)
Message-ID: <f8b49472-dedf-4377-b418-4ba425ed80c5@redhat.com>
Date: Wed, 26 Mar 2025 20:24:12 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] selftests/mm/cow: fix minor memory leak in
 child_vmsplice_memcmp_fn()
To: Malaya Kumar Rout <malayarout91@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250325182319.29352-1-malayarout91@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250325182319.29352-1-malayarout91@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.03.25 19:22, Malaya Kumar Rout wrote:
> Static Analyis for cow.c: error
> Exception branch exits without releasing memory 'old' and 'new'
> 
> fix the issue by releasing the allocated memory.
> 
> Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
> ---

https://lore.kernel.org/linux-mm/20230404031256.78330-1-jiangfeng@kylinos.cn/

-- 
Cheers,

David / dhildenb


