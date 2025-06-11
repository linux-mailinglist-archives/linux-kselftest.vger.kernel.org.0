Return-Path: <linux-kselftest+bounces-34697-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD55AD551A
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 14:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EBAC177C82
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 12:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54C827AC57;
	Wed, 11 Jun 2025 12:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G4NxddTB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7043127780B
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 12:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749643838; cv=none; b=OEWldpcCrj3Ae43pCA5eNMobE0w7BZbdebf1pCPndgEYoCdDEC7kXfdj6j1w4FMl5eAhd+R6+C/50uRGSz9PReCtK4XNf3I0pcr/Qc/ldh5UKjpqMHjziWm6Ycrueqou3dmHQPM2PhkSu5BSnChmqVYB6kaX+KR5tKNXGPP3IZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749643838; c=relaxed/simple;
	bh=fUVyuM/JZzRTEZVSVxBe4m9fLSnTIzYmKm1y3ITexfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HY/lX870n8Qg3s2feS79LbFQ47Vw8HEkdU1KID7MsFfXR1OaoHL9D1XTIblhpYktvhpsaBe06yrQ2EteESBreGt/d1xYc2HVCHij0RfgjiplavspVUaQh61rmjJ6HAQn2KSOsx00iEWaxyrar0BqhjLGx9HIwuNZHCKFnyeyPEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G4NxddTB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749643831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AbBtaKYCxKdKVKglizMjSqjtb9qBaSCtFRd2jqHKCgQ=;
	b=G4NxddTBZWkgZehZyylSTPtckAcyU836q9MnEAZEIEkKRQJH032LMcySJRt025+W3f2rj2
	HuYXM+RpkDLq4E9XdtoF5/Cz8hk1Kby7CXiSwLpH/iyEGKXfuO4nYG0q5gSgFLX+BMsY4x
	jbO24ZOwP88gNRBzgO2gJrAUuo5e4QA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-mGMSGF4RO36J8OqYULuNXw-1; Wed, 11 Jun 2025 08:10:30 -0400
X-MC-Unique: mGMSGF4RO36J8OqYULuNXw-1
X-Mimecast-MFC-AGG-ID: mGMSGF4RO36J8OqYULuNXw_1749643827
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4a6e9182fbaso15213561cf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 05:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749643824; x=1750248624;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AbBtaKYCxKdKVKglizMjSqjtb9qBaSCtFRd2jqHKCgQ=;
        b=fahQ+F1YYe42+9z1D3irQe2Sp1ZNOHsVmWzfjAEIJ2I+qk9o8e9RkEAUn0oGrMsboM
         c2w1Chk8hYe8xePiHbQHg1QDi8kymioAw84T7RNhdCVSMj4yDhwWz5sqYy2NTKpgvuj/
         qgMQfhg4gm3b9/TqwjjilRQKRmJTj6jfya7IM6xBNt/vu00uFm3w3XqZClj2QiC7OTj3
         87OsxB4oSm+4G6BqIsOUp6TUCG0fYIjdzWNoawZXMoNHNk+fOAPwswsWTNnoVFFT+Z6f
         O0PvetdXtd+dpHIKM5VZcTmblWoW7OQ43Gxreg+YgpN6XZDi2m4A507iMK9ymIZ0T2JZ
         0Ffw==
X-Forwarded-Encrypted: i=1; AJvYcCXpn1lr83ZCaQUURGHtqn6jgSSnNnMUlXt8xVTmwveKZJehD+zKElQlZJZGPucjVyniH2I2kWxeGRsTzV9S6OQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnNT4KE9aOItT7ZARTQ8vl8W65mHGQ/auLp7UPlWt0bSfEzs32
	x6pnIWoVkbjedn7FoSPBa6Tikcjimr/q4qvgEcQH+MkqnJCPksyX+VjQ7gqVDNFWkKDDHlrcESI
	dPOk0OodZNwsY6h1US9/eloaWAj+sKtWoezGnw4NKe1FdLT8lS4nf7hD002i9ZhMilp9v5A==
X-Gm-Gg: ASbGnctuHUrGoAKotkurJQqRaUMgIm1DUbggLK2r8x0UK0VEy1Is3t7S8mm2vBJF9lh
	Z0Olxjp1rYfeUGwG9c9AUu7f828cm50bifDAwnRWHlRw2VWTS3OsvukJRIu7XetLVlODSybLKGp
	00Ftuo7smb56PeTzVlJys3nNGmnTUENMmlbPFEIrgqLQtTRlqhW04UpDMbAATlWdnWwFVArqWtm
	xF4zHIbKU6rViyaitagNleKVjBCXr1zKmhMr0mJsKCNMvARlSDFzp4rnM4TmghX2LxEX4fLK7hc
	i7PH/mdQTeNcP3b59KjpmufVn6nBbwIw3K9/A0wRKxUv
X-Received: by 2002:a05:622a:544c:b0:49a:4fc0:56ff with SMTP id d75a77b69052e-4a713cc7259mr49568601cf.12.1749643824159;
        Wed, 11 Jun 2025 05:10:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEepQjK3TiCXlLV7iAyNnfWZsZ5ljFhICTRx5WfMX4Xp6Fy/sYo+plUCva/LJAfRC05JEryg==
X-Received: by 2002:a05:622a:544c:b0:49a:4fc0:56ff with SMTP id d75a77b69052e-4a713cc7259mr49568061cf.12.1749643823744;
        Wed, 11 Jun 2025 05:10:23 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a611150cb0sm87438601cf.11.2025.06.11.05.10.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 05:10:22 -0700 (PDT)
Message-ID: <e88999e6-8c79-4273-9f6f-df28d016cc6e@redhat.com>
Date: Wed, 11 Jun 2025 14:10:20 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] selftests/mm: Convert some cow error reports to
 ksft_perror()
To: Mark Brown <broonie@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250610-selftest-mm-cow-tweaks-v1-0-43cd7457500f@kernel.org>
 <20250610-selftest-mm-cow-tweaks-v1-2-43cd7457500f@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250610-selftest-mm-cow-tweaks-v1-2-43cd7457500f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.06.25 16:13, Mark Brown wrote:
> This prints the errno and a string decode of it.
> 
> Reported-by: David Hildenbrand <david@redhat.com>

Probably not "Reported-by". Did you mean "Suggested-by" like for the others?

> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


