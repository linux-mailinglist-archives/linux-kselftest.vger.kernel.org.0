Return-Path: <linux-kselftest+bounces-6339-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B733887C8F9
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 08:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7814B21C08
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 07:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439A04414;
	Fri, 15 Mar 2024 07:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HS7OOA1U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7514E134BE
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Mar 2024 07:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710486221; cv=none; b=ZpxneT72qNbGjgaUWJYCR70MDOhEZ4t0KYBHmk9M87JmFjo6rfT/34cMnlrvE8I0FNgcbBSXLnuBROgMyb2ljn2G4k3lGD4Ym6NnA675a3X1fMD91iGKJBAc+TVimdDB2zMafAX6Vnb3MztcRswoT6DHA66By1aZalKwy3QH2yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710486221; c=relaxed/simple;
	bh=kKiu8mn3SOtyyrqWFC90kmC6DfbLVJByCZKEaQuz0O0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YNXNqnOTDpLzSfSIilDooDDbZArjebiFM3yIUCEYutUsHuZg94cfuETSvYlpVi2G0ASMaLAz2bubHwgoJamHtbBFZjUcz5eMR111DvNOzyK1bp5bb6kVnnOlc6HXTke7XQPg3CmvXpezElOSvA/SpaPID2ymQeL011sLytWznP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HS7OOA1U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710486218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ILH/8Wu0pRuebE0YVOWDXHtt8730s41+llFapfiSRAM=;
	b=HS7OOA1UGQf7yA/ceGvaprrVnRTK5VoEDphOfAXf8X2RBlKeJhwDW1ZgUPtJFsP4BvCOMQ
	p/FENEp1ubMqwo2JlIxlCh1IVCNwlpyVPydyGaPvXNVxDvGJGH31NnF//905myS6FBvwAt
	AWAp/572Hxr6bwG5i773dtHMwueB78Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-Ru_yrNWrMp-Pem7htSh-pA-1; Fri, 15 Mar 2024 03:03:34 -0400
X-MC-Unique: Ru_yrNWrMp-Pem7htSh-pA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4140336d32cso461415e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Mar 2024 00:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710486213; x=1711091013;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ILH/8Wu0pRuebE0YVOWDXHtt8730s41+llFapfiSRAM=;
        b=p5349yXTJHaAKM49kzg3TS0ApVq9U4s6weftpNTebKJeJYu+sZ36cJf1/dbFSxR8jc
         eAIHGypEYWX4+GlkZr+PWk7jcHSl8zd/w76dfOXSgI6CWJfH2NHVrWZDxdP9TQHSbiUw
         0Q8Q/0R7anJNHJMsC0tSTKp7mtGI9Ttb/+3PYNOr8nHQyoXWxJQyygBRGMTSjbjB0rMu
         fpZPAlGTgqYq6xm/3saY6/e920z9OCCZ/vfifKb03MS6iCkcqHpYRAm15LiEIespLM1J
         R6fUolkzzJalE3GKl5TUJ8OxkdaWRtzG8MS+OPCC1pO/L6rEAwMDcJRiUp2aoq+kYs5v
         EJUg==
X-Forwarded-Encrypted: i=1; AJvYcCVjFgbiHcf3NVpO8sWKqHnDx7I0VqtJRT99BaL+Ec3c6U4a/1pGyvcVaEXqss99oIRizkFhlH3l8b7OtBts6BqGMwaXmCGw46p3AQSjH9qb
X-Gm-Message-State: AOJu0YyWYspDdJPvmcs4jSVkPaoRqH1/K9ijpSCmYDmJklzDhNbS0SU6
	zqf/WLYe6gHY5ylbTSDvIzSlmpR0Qsx2N5SZy0kYPA4d594tVT3MOpC2l6hji62l7leGTeCgdco
	4NY44vQ+nulMlBilbu785YHoCXT/05hlOYik0GlMy3wK5yJUhsJjmA4kUJKwRwUnYmQ==
X-Received: by 2002:a05:600c:45c4:b0:414:222:ad5e with SMTP id s4-20020a05600c45c400b004140222ad5emr299437wmo.11.1710486213078;
        Fri, 15 Mar 2024 00:03:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTyeJ7LNz+hDv9XMF6v2QbMpoUPOhv5YJ00YFIh0Ysj9HceNLwdt8ctWZZvyT3TEsTHK/OWQ==
X-Received: by 2002:a05:600c:45c4:b0:414:222:ad5e with SMTP id s4-20020a05600c45c400b004140222ad5emr299421wmo.11.1710486212795;
        Fri, 15 Mar 2024 00:03:32 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-176-251.web.vodafone.de. [109.43.176.251])
        by smtp.gmail.com with ESMTPSA id bg32-20020a05600c3ca000b00414037f27a9sm201874wmb.31.2024.03.15.00.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 00:03:32 -0700 (PDT)
Message-ID: <8402ad7d-9ecb-410c-8c01-f9ca1bedb65f@redhat.com>
Date: Fri, 15 Mar 2024 08:03:31 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: selftests: Use TAP in the steal_time test
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Jones <ajones@ventanamicro.com>
References: <20231019095900.450467-1-thuth@redhat.com>
 <20231019-2946dcc38c3e95e0e7433eae@orel>
 <abfbb656-fc55-4b10-ab54-e7fb96896bc9@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <abfbb656-fc55-4b10-ab54-e7fb96896bc9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/12/2023 10.39, Thomas Huth wrote:
> On 19/10/2023 15.13, Andrew Jones wrote:
>> On Thu, Oct 19, 2023 at 11:59:00AM +0200, Thomas Huth wrote:
>>> For easier use of the tests in automation and for having some
>>> status information for the user while the test is running, let's
>>> provide some TAP output in this test.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   NB: This patch does not use the interface from kselftest_harness.h
>>>       since it is not very suitable for the for-loop in this patch.
>>>
>>>   tools/testing/selftests/kvm/steal_time.c | 46 ++++++++++++------------
>>>   1 file changed, 23 insertions(+), 23 deletions(-)
>>>
>>
>> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> 
> Thanks Andrew!
> 
> Paolo, if there are no other concerns, could you maybe pick it up for 
> kvm/next ?

Ping?

  Thomas



