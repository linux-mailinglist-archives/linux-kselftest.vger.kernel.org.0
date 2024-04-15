Return-Path: <linux-kselftest+bounces-7968-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 839B08A52FA
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 16:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD7AAB20A72
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 14:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1961757E1;
	Mon, 15 Apr 2024 14:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dvSHlq4f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D8C74E25
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Apr 2024 14:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713190936; cv=none; b=C2NhoBw8PFAEOxz4J7g4lXRA+JVWD2hA7CB8LjjdEn6LuWs4UGKYE6VvzpDDFTdVXhdnbZKAa33eRl30uA42ZEnvk8YjoXozSIFkEZevX782aFjcMD5pV2DZAhoq6F2epgZ6vz2NOyuHQ2t/CmvPJdEF1+xXBuHsLO4eRV+F4+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713190936; c=relaxed/simple;
	bh=N6BsmOpUFv1NdzAIhR7wG4F9QbFYaKztoAW+/nHUQH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KTmPWByYZTBWSADodsyzC37B82teSo0cJpYh3P7LZ0SCGM4wOZADxT+RFxWg6VsHkuZnPy+3FKZ860e9l2tMJkFFfeSJU5hEYSVWca1xpEg9or1KlKCntUYcPMzcZVRmpsleLeXnHVJeVKXYzVDQdgUGMe3XzVJxnFTzayGhi4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dvSHlq4f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713190934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1PbOJBRpspxdDa6pRJjCuw+ncvorVUgjMaFCtffqZ+Q=;
	b=dvSHlq4ffl9La6scN3ja6neyqrTkmRvMbdijqJyANEVsfbidiQGhGNQb815FooC27p1FNq
	cwNGx5babAkcrg3M+2h3HhbkCPZmXHP5k8cEyp7LhcF58PYNoMNlE8Tiv3p+BMoING5Fv8
	qwaRIVbL644ii/9QoHe/kCcs/wI44sA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-z-pZk_jWP2-Z4eLNnpCS_Q-1; Mon, 15 Apr 2024 10:22:12 -0400
X-MC-Unique: z-pZk_jWP2-Z4eLNnpCS_Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-41552c04845so12173835e9.2
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Apr 2024 07:22:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713190931; x=1713795731;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PbOJBRpspxdDa6pRJjCuw+ncvorVUgjMaFCtffqZ+Q=;
        b=Ao9uA3o1SPsucMW0SYBvUfZiMLx8gS1C0Rf1NglUkQc3K5QfChsZQD7kL0WyzJ1LYL
         dVBCqnzgqG+nuw3MhxMFb+PZOs/D7MLEUnpmk0KCihHDrYfkBnvR5n9k9RXJD0nCCcPl
         EvU92QZpEJhXUu5lq85hBLmbfF5yQExvbM1kbz324X4Tz5wkN3K9Fb2AlxA2RILXAsUx
         jmmI25rBxneiXwqMImdqTHyubYH2D56fUJ6U0l6XxL/O6haTrPICZe7ke4wOkKhomWSD
         PaZ9XTXdecHdZVsc4fl1CNiUPHrmLYT1waFCVv5zWrax8iyUgL6Q73Ve2xGqoNWnlcgO
         EsrA==
X-Forwarded-Encrypted: i=1; AJvYcCUSpM9ubZzngiel2831cDMQBqaZvqMsmpdfdeb+cjnxpq/o0U/mC9rM1jsxStOq88bsyaMszzyDpvLJ8TQpOicLu6hM3Ht/rGyDmXy2ppjD
X-Gm-Message-State: AOJu0Yz9FTIMkD8dikFGWTwFIpBkHfb2QAd6ZFERLRz0pV4va4SIuXih
	M/fw3R6mLRZRoV45nE18EUPmuQ4xDMkMoszzQaftRz7vE4JFn20kWh7ihNXNqOLldwa/y0YUUU8
	wZiRlrPS8Vz7MAbMlHPwoq7rVWfJ46yZJ2tNepmdw9Draub5353rpEXi0UuC/fbIhkNb83pp+4A
	==
X-Received: by 2002:a05:600c:1c81:b0:418:7401:b15f with SMTP id k1-20020a05600c1c8100b004187401b15fmr1322458wms.38.1713190931712;
        Mon, 15 Apr 2024 07:22:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDak1eTKoWVr2U+6dT5ZcLn1063lRhwGMlTXR2A2YuvZAJE2t6UbWSYNg3COoiiV+lBsHBiw==
X-Received: by 2002:a05:600c:1c81:b0:418:7401:b15f with SMTP id k1-20020a05600c1c8100b004187401b15fmr1322438wms.38.1713190931354;
        Mon, 15 Apr 2024 07:22:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:d800:568a:6ea7:5272:797c? (p200300cbc706d800568a6ea75272797c.dip0.t-ipconnect.de. [2003:cb:c706:d800:568a:6ea7:5272:797c])
        by smtp.gmail.com with ESMTPSA id q12-20020a05600c46cc00b00417bab31bd2sm16449015wmo.26.2024.04.15.07.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 07:22:10 -0700 (PDT)
Message-ID: <513a9e86-6159-43dd-8b70-f903637f2cd0@redhat.com>
Date: Mon, 15 Apr 2024 16:22:09 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] KVM: s390x: selftests: Add shared zeropage test
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
References: <20240412084329.30315-1-david@redhat.com>
 <Zh03fI2oA0UkE0Kp@tuxmaker.boeblingen.de.ibm.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zh03fI2oA0UkE0Kp@tuxmaker.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.04.24 16:19, Alexander Gordeev wrote:
> On Fri, Apr 12, 2024 at 10:43:29AM +0200, David Hildenbrand wrote:
> Hi David,
>>   tools/testing/selftests/kvm/Makefile          |   1 +
>>   .../kvm/s390x/shared_zeropage_test.c          | 110 ++++++++++++++++++
>>   2 files changed, 111 insertions(+)
>>   create mode 100644 tools/testing/selftests/kvm/s390x/shared_zeropage_test.c
> 
> Tested-by: Alexander Gordeev <agordeev@linux.ibm.com>

Thanks Alexander, especially also for discovering that nasty ifdef bug!

-- 
Cheers,

David / dhildenb


