Return-Path: <linux-kselftest+bounces-41115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B4AB5124F
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 11:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DD187AEC7A
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 09:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EA23128A7;
	Wed, 10 Sep 2025 09:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bk7liKNZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1A730C349
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Sep 2025 09:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757496074; cv=none; b=WcLFYBhLjyIC9KH8H1PDpW5g0CYWn+s+zecdnZT7nzkAshYidoMLgi+Qo+tPv7WQsSTKsreF+84CBFJsv952oBlfeycdsf4znrEOIa+X3QcYQ0OsNKTHFmVzbqL7ojrq2bPAWzyqA+A4VIj+6zm+na2ZyQKA4awV4MtZ4aDbTKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757496074; c=relaxed/simple;
	bh=umrSFJLvax1nJGHbQCZt0adE5BTTV5Lcal0ybaH4HiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XA7N/PB/Jb5sS3LzQr+z8TKJueBC5dlIOH1oecntopnZn+8/puQePcGrgXhb7xKa0TdFFzkMJaqUbGKUCoCHB5sDGgU/Rwq9hoSylJx/GGvkW41Y1JOGp4sCjaaABJsEH0ppM9Ow8TC++bSUHAwg0cWY6cZlEtbrnIgjDGpAW10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bk7liKNZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757496070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IXsx9Ic7O7zZ84RSI3WUTXXDbyazumVEbCuc+kUHkxc=;
	b=Bk7liKNZJoHBWy32ylkkfZVsiO4dMXyKZB/+W0yZcqX2wm3Ka2FXAcuYSeNCub55z6XopQ
	Yjfm+jWRHe0kDZe4ZJXpHBUwiHhXSgRAEL8oCxfjVVRUlhduPcdCKCyR0BRyVcaIjr21aA
	JKWElBDzooAt0Iu8tJLG0sHZbbwqOyI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-EtkdnumOObupnsvA-p9vvw-1; Wed, 10 Sep 2025 05:21:09 -0400
X-MC-Unique: EtkdnumOObupnsvA-p9vvw-1
X-Mimecast-MFC-AGG-ID: EtkdnumOObupnsvA-p9vvw_1757496068
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3dabec38299so4275393f8f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Sep 2025 02:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757496068; x=1758100868;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IXsx9Ic7O7zZ84RSI3WUTXXDbyazumVEbCuc+kUHkxc=;
        b=oXiAP7BFeJv0b7LUFpZkgfb1qJW8b7e9IjwpWMK0zgBl/hu3599f0904eV16vek6Td
         mIj+Nn1q72ucYx9x/h/BHKfP4zFRjf4jB4NmwoMyZ4hGApUhlpn+lQ3uLq4GHkdrmZ7p
         rEu51dfNlvf2HhuvqXLJsFC2WZBPjAFHcYQr2Ub4VoTIN37c7I9bIfPQYV/2wWU0RB9P
         +b1sP//22HvjBUFB0NsFOk3CF3KvVQCNazHBGo2bE9pKIKjEqGM76tXzbovI/7uMGP+k
         XVBMTQHrpOcaW97E0t5oh89Gb3Y8ivtvzYlvTnUIPx1GGxKzwHnUQSlM7O6UEc+eAhA7
         12GA==
X-Forwarded-Encrypted: i=1; AJvYcCU2bdo4X7i8Kc6/GjFpZEt3u7L+N20/LjofbLZE0UFvEm9e+8JDQvaX/8eiwa0btRs+E0M+YlDllQCbn3ZRxs4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw33Y1L6TOst5bQvEJPb/ytR/fUXJLj28qMrChxkMXTQQdz6B4R
	lMFoXy3VIhTVCLeTfykoSFeKd6n/7xdtwAxHIHayXVOhZSWtVj4QVE1+9wzpmD2KYeTPOjrBBwv
	pNR9qNs/W/XCeTpTM5Ip4rs+xKDjeivowCssW4LLg0Q7Hg/KjuCsgXC7eOREG5GLMqMkDag==
X-Gm-Gg: ASbGncvtE/K/KNnQATJUKFV1klGlfXEyixL4sDg5TiJybTuL2w2o4ad0XzwjgflXIkh
	/5Lg8GSgkFL/kSy/rgoIs71302LQkYztluKS6Q4IuJhVGEYqPaKbVX2VoEuv0LWHBKCn+mADeSm
	ulV9Yo+xEn4++I3k0GlqJgquNPXcI/hCo/WzmkEcJlsWHBIHx+yZea9phVQXITYnKm06ROPJGDJ
	1e+WzJriAADYyblDu66CLE483BKPbaElfVV7VAhpU/QYmtlRqQvHWgMheUb/GDTXrlK0Bde6u0T
	JUEm06GU84Nymqaz87X4L+FCohly7CTmr5acxTvJPyJCGq0OVy161pgG5ezExyotfNHMDDnn93D
	qKeyawj6ufrL2MqH8HQMFiuxd3JrnY0zrLqol/E2P/9prfiaPcj7sBrXrlecDQOs+RY8=
X-Received: by 2002:a5d:64c3:0:b0:3d0:3eae:576d with SMTP id ffacd0b85a97d-3e642f8f76fmr10290431f8f.22.1757496068087;
        Wed, 10 Sep 2025 02:21:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCnT1FVklH7nbjNgKoM/He/fVrE4yAXPhgf7MBYTl2+m5PkmwhD6Q2MRLgU+UZH+dNGP9RYQ==
X-Received: by 2002:a5d:64c3:0:b0:3d0:3eae:576d with SMTP id ffacd0b85a97d-3e642f8f76fmr10290400f8f.22.1757496067526;
        Wed, 10 Sep 2025 02:21:07 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f17:9c00:d650:ab5f:74c2:2175? (p200300d82f179c00d650ab5f74c22175.dip0.t-ipconnect.de. [2003:d8:2f17:9c00:d650:ab5f:74c2:2175])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e752238997sm6493544f8f.37.2025.09.10.02.21.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 02:21:07 -0700 (PDT)
Message-ID: <2fe10966-521f-4af5-a9cd-f55d04b12eb8@redhat.com>
Date: Wed, 10 Sep 2025 11:21:05 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: remove PROT_EXEC req from file-collapse
 tests
To: Wei Yang <richard.weiyang@gmail.com>, Zach O'Keefe <zokeefe@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250909190534.512801-1-zokeefe@google.com>
 <20250910091622.n25zvgw27olskao2@master>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250910091622.n25zvgw27olskao2@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.09.25 11:16, Wei Yang wrote:
> On Tue, Sep 09, 2025 at 12:05:34PM -0700, Zach O'Keefe wrote:
>> As of v6.8 commit 7fbb5e188248 ("mm: remove VM_EXEC requirement for THP eligibility")
>> thp collapse no longer requires file-backed mappings be created with
>> PROT_EXEC.
>>
> 
> One question, what if user run this new version test on old kernel?
> 
> Is there a guideline for user?

We try to keep some older kernel working as long as it is easy, so 
people have to do less manual work of filtering out false positives if 
they happen to run these tests on older kernels.

6.8 was from end 2023, not sure if we still care about that.

-- 
Cheers

David / dhildenb


