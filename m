Return-Path: <linux-kselftest+bounces-18614-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFB8989FDD
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 12:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 919271F20FED
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 10:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290E718CBF5;
	Mon, 30 Sep 2024 10:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YiszODV/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDDC18BB8E
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 10:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727693721; cv=none; b=VhsXEVIMuKGV62jL3elaMkw6517OEK9usewcvq+y6gfQiwAp8X1UMDRCDuGUooOilFi+5T+l2qUMb2OfmmRWFIF+1VDzgg3TfkPH8hLPfHxWUacbbguE/az3rTcdyVS4dzitZeoCTJkQ7nz/G6KtbH3jJdjFSczZV+MceMQp90Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727693721; c=relaxed/simple;
	bh=ztSUdnk2CsZFtqu6+CbhQrD1JdzXFI0Jpn+H43kdl2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d/yuHMPO0MYeDuf5sNLo+1/7E6FtmbP3B3TTqtWdjkU83NLeYZrwjABM/SgVzMhVGG+qNVA5Osgxt/6PLlhDlLCU1IbmqHFHdhdK75fAJ+zoEHfpg8iuwTXoA0eJ/2enKhe9MIIXuxni7lT3zVheMXvJT1VX53BmeHbFjAvqns8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YiszODV/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727693718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WE+YRhY8H5W22JCdQGzXfsAHkDafbR3ThQ4VmUGM9ps=;
	b=YiszODV/2c3a60FmB7Kfow+iz6C3U6tje4OYiYDQLfeurDrV/CiSEM6yMnvtx09sXzMpgw
	vzavDuZRvl6lUbFN900AQyCU7S0L6PeH+ocVBk2y4olaYpTpjB9RlatDwpG8CNm4/3wvdU
	yPD6q8OE3C8mWKesYlRAHlCZUG+Uw2s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-HRbVDBSRN2CChRtuR2YJhQ-1; Mon, 30 Sep 2024 06:55:17 -0400
X-MC-Unique: HRbVDBSRN2CChRtuR2YJhQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37ccc96d3e6so1600217f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 03:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727693716; x=1728298516;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WE+YRhY8H5W22JCdQGzXfsAHkDafbR3ThQ4VmUGM9ps=;
        b=md0V0R0U+mBYkmg1CMCXZZa++1H24hE5EeuGc5TjfEIndV/IbrNUMazm+Vjp50Wdic
         FbZjoGzpx933/9gTEUN/m5o5BF3tVsW4IsvLVHys8iNAQ16aw9mqbJPVwuifenca8VXD
         4MHtJHorXjgSGSrvLYLwhTXLX7TCh4OkLaVOnwy6+bS63H8PnSAbymnoIlRnfbbBF5ko
         CLJ1SaJiGLnOeVN2HQuOISnCPOxOmLf+AephmSJkHW1rcJsTtJIe6tvXeROB7feu8fWx
         /p6Oe59y6HugmxUVz+zGncpNo6gxfqH4H8txBm4Yzp9dR95Gl98jbxRsYOeTGfggDB2q
         C11Q==
X-Forwarded-Encrypted: i=1; AJvYcCUU+sKK4X6phggF2xUaRsGJqWNbJ/RaKdIdmdplyKXTYIsce75wvGmgQk4khOjoAEujmUDhKMwPa3ZKXvMh3o8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzISfQfHz09kGbz8GKoDNAZr9Ekw/okypagGR/ZspSgguud0N6T
	hmSFd+V0Fvn7iO6LYMcas0ZOLqK6Qss9cywK9DxaF9jVeR9wdHNVWS/Y21m4traqWHhT7NrVfdz
	VWbh8aXqXix9/QZ0mok7NF/bddpI+o6uhiOxlAq6EsNWex6fbCnRNWePaLRZouas/kw==
X-Received: by 2002:a5d:42c9:0:b0:371:9360:c4a8 with SMTP id ffacd0b85a97d-37cd5a99f37mr6345301f8f.6.1727693716254;
        Mon, 30 Sep 2024 03:55:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdKwk8xHzg6/p93JsFR234UxBUmGfa7FUYqw6DwNfDaBHXYF4EZZRJIAdlXNC9gD6XoH4+KA==
X-Received: by 2002:a5d:42c9:0:b0:371:9360:c4a8 with SMTP id ffacd0b85a97d-37cd5a99f37mr6345281f8f.6.1727693715813;
        Mon, 30 Sep 2024 03:55:15 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e65e4sm8699598f8f.61.2024.09.30.03.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 03:55:15 -0700 (PDT)
Message-ID: <a3125f26-f72d-4502-a4af-55ab36d66b0f@redhat.com>
Date: Mon, 30 Sep 2024 12:55:14 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] selftests/mm: hugetlb_fault_after_madv: improve
 test output
To: Breno Leitao <leitao@debian.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Shuah Khan <shuah@kernel.org>, Mario Casquero <mcasquer@redhat.com>
References: <20240926152044.2205129-1-david@redhat.com>
 <20240926152044.2205129-3-david@redhat.com>
 <20240930-loud-brave-cassowary-0aecfc@leitao>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240930-loud-brave-cassowary-0aecfc@leitao>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.09.24 12:05, Breno Leitao wrote:
> On Thu, Sep 26, 2024 at 05:20:44PM +0200, David Hildenbrand wrote:
>> Let's improve the test output. For example, print the proper test
>> result. Install a SIGBUS handler to catch any SIGBUS instead of
>> crashing the test on failure.
> 
> That is way better now. Thanks for improving it.

Thanks for the review!

-- 
Cheers,

David / dhildenb


