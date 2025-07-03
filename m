Return-Path: <linux-kselftest+bounces-36409-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D743AF6D1A
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 10:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44735524098
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 08:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2EB2D193C;
	Thu,  3 Jul 2025 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGajvd7g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0642D0C9A
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Jul 2025 08:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751531784; cv=none; b=tnL0n9jf1uCPBmwXcalCXySSFPF56w8fTNT37k+g35Qu5rgAHu9Zx5wd80J4xTabTOJlMomnGztxwLuyCJdTkOawoFhZHEVwEusEFAjL7NOI3EHy4H49ifPmMs8nzSdfovAK8FlYInF+uzWIGAjLC2oM6GF/5r3el4oSCazm8yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751531784; c=relaxed/simple;
	bh=T6PpFeQ/ohri03+CGLWWlYLkV2rqEwutq9AcbGax4X8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mWYNYYfJbP3IWdyo0BMfU/ya3uNkoBFHTbuupPCYb68XuuRspoqf/geBGB0Sf9C2o/XD5m116SeFZWvAp7sWIfuEFgqEmqcxMxsgkwtBPOJmUVNUIW6y8Q5QRz66RJYJW/xlcU57j/g3B05vruyt+5vjmZh26pEShIA3pMDSKJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KGajvd7g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751531781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9gO/OHQvAP6w5kh7oQzia//h/ythwr2wIvD22NPjXXU=;
	b=KGajvd7gRpxUOp+i07xqI/y9kpvxJ1UAU3KHQuphXQTY25yIp7ozJNs2XAn/SeDgwQMJx8
	HwPX47FjaiLYPIDbbmVoyi2UaxZN5q4Rj/Gmi7tnTv/m5E/NBwmfYIdAp5xgsYytsWKy/9
	gOP3fRdYxeyf4p9/HAGxv1BRNApafQU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-MDXizwe0PdS3pttwmH2NdQ-1; Thu, 03 Jul 2025 04:36:19 -0400
X-MC-Unique: MDXizwe0PdS3pttwmH2NdQ-1
X-Mimecast-MFC-AGG-ID: MDXizwe0PdS3pttwmH2NdQ_1751531778
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ae3c8477f1fso129562666b.3
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Jul 2025 01:36:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751531778; x=1752136578;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9gO/OHQvAP6w5kh7oQzia//h/ythwr2wIvD22NPjXXU=;
        b=TLcmF9hWJi10HLjtJ14lbhMBwfSgH0JohfP0bKvoObeFMs5XIPGCe4oWmpq0vfBY6+
         pzMv1WKabnC9VI8V2Mr7QsboRS4NT2Ch0adPfF+qL9PER6hFlu9/khektipXOxz2h/LF
         y9F8isri9IO7JHjr/Rvdd1o9mLPhKTnbmMfo1UjWChWGBhwQiM5pQxtUDJDwyG8EYFmR
         XG/c/UCCz3Yt9DKmBFNi6eOg5JILJK+zOQmwulO0X+ftxfCKlx35wALuyHrH1J1YBdyQ
         evgzkfAnk5XL8h06Q5lcVL1VSv5UEDhr8w0j6GbYxoDyAo0jfvV0oJOZBiRYYe+DRQma
         x1og==
X-Forwarded-Encrypted: i=1; AJvYcCXdlMXbPU2T3p7thDtNYOTFJwthSvAH9GAODAQHL4ZjWI7pBHgR0Z/gK5iHPxiexlmXpeHDl1olUF698FS4wZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIm8XaNbaj0X42CRZN1S0fL0t2R6OK7ogWfMqTW6181jdASclh
	rJY0K67sbDIiPh+LAU3SJ4bC3kCMKiKQsXZGuP5DOZoTyn4cjv3K9ImWWbgHqrzgrMbtFcJmVX4
	5zU4SuYk7O6kLO2VD2MHyu3XmElegwyDZ5ki11p/aOvFlxhPtxqjrkyEChjO0lV2ZX53FCg==
X-Gm-Gg: ASbGnctHby9TBW8Ja0WRW1dMZVNL4eYSiQx1SCWIJww8qBmNc+T+XQqx557a4UUDSsP
	uaLPFpa6zpLr+WplwFBO+qeXhdl1vuCFDw6h8wXLQzWJvTi5y448llLX080GECrtZeP5Y2ZZLgl
	EJiAyuN++3iGaWTBBueKILHX/rDbDxG4UEPqhkiW9YzbGHHaudPaQ4DlUSj/n7JQtjBdRFZO0hc
	qm2PhrH9bXeJRGS82fIM3tsts3yhyIgpuSVEixFpGDlDXWuJ3Z0Z+nRtjMc5iFGdZ5pvnnIkVlz
	WqyTuJSVUgjk6SvmfqiAo55NFzVprzNgC0ZWrbB44upO
X-Received: by 2002:a17:907:9813:b0:ae0:d019:dac7 with SMTP id a640c23a62f3a-ae3d8a00e87mr207397166b.23.1751531778383;
        Thu, 03 Jul 2025 01:36:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdZn7Xzvu2kuD04w0WXoNHvONDJk1+Shs/4Cy35t8g6LHSLZdzBllHtVL4w3wNSP1r10N5MQ==
X-Received: by 2002:a17:907:9813:b0:ae0:d019:dac7 with SMTP id a640c23a62f3a-ae3d8a00e87mr207393866b.23.1751531777914;
        Thu, 03 Jul 2025 01:36:17 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35363a149sm1205694966b.9.2025.07.03.01.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 01:36:17 -0700 (PDT)
Message-ID: <165faf55-4376-4fa8-9a9b-aefd00de6a66@redhat.com>
Date: Thu, 3 Jul 2025 10:36:16 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] selftests/mm: Skip thuge-gen if shmmax is too
 small or no 1G huge pages
To: Aboorva Devarajan <aboorvad@linux.ibm.com>, akpm@linux-foundation.org,
 Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, shuah@kernel.org,
 pfalcato@suse.de, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, donettom@linux.ibm.com, ritesh.list@gmail.com
References: <20250703060656.54345-1-aboorvad@linux.ibm.com>
 <20250703060656.54345-7-aboorvad@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250703060656.54345-7-aboorvad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.07.25 08:06, Aboorva Devarajan wrote:
> Make thuge-gen skip instead of fail when it can't run due to system
> settings. If shmmax is too small or no 1G huge pages are available,
> the test now prints a warning and is marked as skipped.

Maybe change the subject to

"selftests/mm: Skip thuge-gen test if system is not setup properly"

> 
> -------------------
> Before Patch:
> -------------------
> ~ running ./thuge-gen
> ~ Bail out! Please do echo 262144 > /proc/sys/kernel/shmmax
> ~ Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
> ~ [FAIL]
> not ok 28 thuge-gen ~ exit=1
> 
> -------------------
> After Patch:
> -------------------
> ~ running ./thuge-gen
> ~ ~ WARNING: shmmax is too small to run this test.
> ~ ~ Please run the following command to increase shmmax:
> ~ ~ echo 262144 > /proc/sys/kernel/shmmax
> ~ 1..0 ~ SKIP Test skipped due to insufficient shmmax value.
> ~ [SKIP]
> ok 29 thuge-gen ~ SKIP
> 

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


