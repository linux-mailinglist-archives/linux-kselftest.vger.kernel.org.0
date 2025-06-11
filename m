Return-Path: <linux-kselftest+bounces-34698-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E547BAD551B
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 14:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6539116C3C8
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 12:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5B927B4E0;
	Wed, 11 Jun 2025 12:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RBsY8dSQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8587227780B
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 12:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749643856; cv=none; b=sDMn+7iNnsKoO53ie8ph4Xtq1U4Mbqos/XT7odoQFfIzPtBWGL8t6DwtaJrjawBUQ0p0Fcw3mCxXqmNfIFE59jmCwUfqXB02VdhZgb+F7/68OuNcbOF/SUa+9iGfvNNcjMLhJ11HJz9bqIarjBE9OGopVteacTRU1MDOrLYJsZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749643856; c=relaxed/simple;
	bh=Xk1ddhx77cHWw9Ct61TDaPE3Rg8dzF9dzOF3Dpji2DY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ahUOTsJHayhYKcxZqt+ZRx2KyfTShtF6TisCDpqR5vqpTvKto/Q43PYaSEfuOGM7uKs0AljmsyVCAMHfgw3E/TxyGcEzX96MgA6myOVf9cxIAtUQB8sI/MuN5I1B/lsIoa+8GAXxK/2iqL1FGoh9icJ/keAawbQeXfQ5oGXqFx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RBsY8dSQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749643853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=h9u/BB+Pg7diLVSz+P1K4APpZKD4S0kyw+YGrKVNC4M=;
	b=RBsY8dSQJx4Ay+BOJi+ouRSA3e7GpcTlkyBZWSrrYajVkzXG69wewhrrOoA+DZK93QTbCE
	illuW094qAehmUrl9tyk24qG9WvmKT7MYUo5Mmz7EE7pzHn2jOkJ08oBqmKo6dAjOV8WLb
	DGCAUm8/mRb+PIuCBuYqrPpcdGE9kss=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-zvEy92JOOyOPlKeuBjmi1w-1; Wed, 11 Jun 2025 08:10:52 -0400
X-MC-Unique: zvEy92JOOyOPlKeuBjmi1w-1
X-Mimecast-MFC-AGG-ID: zvEy92JOOyOPlKeuBjmi1w_1749643852
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c5e28d0cc0so1007193485a.3
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 05:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749643852; x=1750248652;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h9u/BB+Pg7diLVSz+P1K4APpZKD4S0kyw+YGrKVNC4M=;
        b=KpcbTPgh/4cDoidHLpt7IGIoFXrodkbgjMmdmamUz217gq/MSNToQTjZgzlt5B0fQw
         KvsHvAZuUezgQO81Bi2C+oM3lAj8FU+SzhfEO/eV7ZctE7O7ID87GqI+/bpz53/5iQng
         PXtK08OU/su9sTYBc3OepaZEKR2K0hZcP7Ivk2NhyE1mPj5JMfGSbxqCxFqWfGjuBTRN
         m19m2tYTiEf89nMtbhxZ0nwgyqkBPfLRZEUzSDdNB8ssjHK47ntB/TeycfmnXrzwcIbc
         aj5OVNeqoVl0Yu7VQjz7lCaHHqeW5OEXvLtDCKn/lny13qGCW5QiZPypyl+hfiJbluYQ
         9bWw==
X-Forwarded-Encrypted: i=1; AJvYcCUZk9E8Zqn8pe8bry97Nn1TE8+WAZ+9SC3yZZ7TNfWZkgXS7yLH57w2AUjYyTf05EsgcwMp3c9OXc/zevD/ASw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhuDyjFmYE4ROAndeTSMm0qspBnR5me7MTn5Pe/rEVfC7PpmwN
	Yy0gFOonvntP/6LdkjCYbffQlf+rsQpeOiGgWU+zND834yN701B/yN2M1sXzQgBWk2pcNWVwoVV
	Iij/AapNYIkVdAUVLunDDjX+P+BulATctCTiy9b0DvLDtYfhsDCwK2aWoAojGBwLjTVZDNw==
X-Gm-Gg: ASbGncvKF66wjK1ev19tkdfuodHU38UbTmu9Sq9SwYq+Gd6zMxJ1OrQ66dRct9Z1Mcq
	wDBrKyh5qnrorb7fCIXyDWXG8JY/MjYpY33Q4z/VdtAHVHHmt0uJW9X9jBIwTDC4OfV9SYmrdce
	PtZnsoa1gvEPgBegdhs5Qj/DYJz4kdf9IMhPbTXT0rrAIIrD65Qc9ZZBNoOgdyIRsePpvMG0hjb
	ckxbdSm8JGskGdmeOCB4oVDZnKj5ByWzulRA6ywF92Frz2WsuMhPeAWVyIaWDb+QnJEGL0D9Rx7
	WJcXEEE1ely9EyXlSjihY7psVbaLVKxq+R356DoXsDK5
X-Received: by 2002:a05:6214:20c1:b0:6e8:8798:275d with SMTP id 6a1803df08f44-6fb2c251fc2mr50983906d6.0.1749643851793;
        Wed, 11 Jun 2025 05:10:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpQQObiAAO/LAoeVrc+vGFwd3Oi28mcq0/hlnDd2TbOd9ncS9NKhQhbvQU/ipsx2Ddq/pZBg==
X-Received: by 2002:a05:6214:20c1:b0:6e8:8798:275d with SMTP id 6a1803df08f44-6fb2c251fc2mr50983586d6.0.1749643851477;
        Wed, 11 Jun 2025 05:10:51 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3916f3318sm510764485a.10.2025.06.11.05.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 05:10:51 -0700 (PDT)
Message-ID: <b21349dd-6020-4b8a-b34a-f4085e040908@redhat.com>
Date: Wed, 11 Jun 2025 14:10:49 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] selftests/mm: Don't compare return values to in cow
To: Mark Brown <broonie@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250610-selftest-mm-cow-tweaks-v1-0-43cd7457500f@kernel.org>
 <20250610-selftest-mm-cow-tweaks-v1-3-43cd7457500f@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250610-selftest-mm-cow-tweaks-v1-3-43cd7457500f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.06.25 16:13, Mark Brown wrote:
> Tweak the coding style for checking for non-zero return values.
> While we're at it also remove a now redundant oring of the madvise()
> return code.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


