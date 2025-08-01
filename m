Return-Path: <linux-kselftest+bounces-38173-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F89B17EC6
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 11:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5C331C25EB6
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 09:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC5520D50C;
	Fri,  1 Aug 2025 09:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0jeZ9aZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447DE18C02E
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Aug 2025 09:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754039005; cv=none; b=bEWe+IoJSFxWdTHxWosCATk9ulPRSzEGYu7DJCEiVgeM+dMEARokJgKKE5EeYWvFA7UxmCTzpyF+BkITWPNvCg/OxdN1uHC9COIdtufu3+MkSwztQe6hPJ9MYQn7Wq8XpRLX/6NU7nVQwi76+xVpMqp87Om7v1aXWOKZkLw10mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754039005; c=relaxed/simple;
	bh=NeW/eaKMl4TKdeb8zHoLFAAOYwgoI/w0GNQNTcD9NC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k6+H3AUyISQLQaVgzfVKs/Xqp/7OBA2jd9fYfqbrJkO8IsUbxn0vmGk9Igwqm8qGrf2iwxv2phcbaA04AtypDSqB7/V4QxrhGYk8HctH+eT98Y+d6wxhrcXpV/bLATiMpi8HZWUx3OugisUm5kF/ToVIXpmURU8z1rSydwTYObs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q0jeZ9aZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754039003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jKFRHT6OU2uRnFKuf79dMDW02YpzgbfX6ReI0ryBvj8=;
	b=Q0jeZ9aZQCQ1T/RZRc5eLlrHVgfSEk0eLKaIDQuHXcFBcHaflgDuuERzOQZxxGe5BhmPCY
	B+gcb17sTXHk8sWRnft4OT/thpKI3Yhtq1RF/4P/ojeFCshDl+t68QYqv9YU+u2w7EKO/R
	TEZpymmlT5QXqGKLS8UfQ1HxkHabHsM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-CIezCl4LPyOunSarDFUrEw-1; Fri, 01 Aug 2025 05:02:40 -0400
X-MC-Unique: CIezCl4LPyOunSarDFUrEw-1
X-Mimecast-MFC-AGG-ID: CIezCl4LPyOunSarDFUrEw_1754038959
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-456175dba68so4329765e9.2
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Aug 2025 02:02:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754038959; x=1754643759;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jKFRHT6OU2uRnFKuf79dMDW02YpzgbfX6ReI0ryBvj8=;
        b=eln2y53RxZY4i6iTlNwTpmSgVPWrKXr2/lJ0Ny5edLtBLjqYQaUntYnP+YmDkl3UOf
         yQcSAxWqES4mmxAN8tuJY3UuO/gg/cm9WqhzvYIg7fcag57O7j8iifrBJZySyMjiEn5p
         ef2jmRKllaHLtHXx4vYqtCFsrr7rbUfxr+J2VlQygGLd3TBugjOLvBna5ZCpNP5jpAhH
         4eqiwEJYSfW0N2KtCGYsY7PN8X3i+fotT6cKdJp2fu62zTyFHHu8AvZSpBuD7XX5//bC
         maA9AruPqkm4fi3nxD+dJcunt8jigeMYaeBVwgWp83RhMehF1u9mk7HUHyCADZP13Rj7
         4r1g==
X-Forwarded-Encrypted: i=1; AJvYcCVOfDX7dpIf9YzxiGf+LgHn/LxewDlnP5w4mujcaQC97bJft9DrIY0y2GUBmOxDDkhEauTTbNSPz2IIlnYsyzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpNntx+v4LKw/SjgyU3h0nzEMxVXL71Ly9t/62i2vvRkvJ0V2k
	DFTX8zLSsoWJT/z+8jzo7hmWBGejC437Lgj04FaU+3Pp/cQ2J2f0L0J4qgReD9gxRYIXbHbPzyq
	wFaM/lalaF6UOspxib69YQaCK064WWC8rp6lLE9XrckPNjxcNcm/wHDmGLX3Xol2+K4F7WA==
X-Gm-Gg: ASbGnctPShBoUjyYNlmAPh8SMO17w4IyhuQiIdlgcWGjkq/4DmUUyutwOmarIMgOmNO
	pGXSchn+nYJgaTDCz6zO6le6RlIFZMBseeuEM9+gZeZF1b0byQN09AEWSUx86xiLaGIU9A3YfKe
	Lw30dgXfouyiFx8yfLlrxL56eA/cph7TeQaypJFsZ86tPZBLGyLyR3+aLVosFMwG9URdQvxviAy
	TLzNcb7BB+kWiYsirj1HNkeokj+AybdWKdsH2CxmSK8kOl9u/t1FqQfrWBTnxjZM0IErtxo1po/
	8P1ac7rq8+9zOdWlrSR9ZWnsoDmY1zVwZbPMU33PaOCADjejvCTWOuY5Pk4yu5W4JuwuoSdUWnq
	kf57dFwacFCa1a5KOrrCQb0mvcL5LY754Sfjk/HSt1CFeI0OQZoj3+3Zi/cHoRj58
X-Received: by 2002:a05:600c:6814:b0:456:dc0:7d4e with SMTP id 5b1f17b1804b1-45892bc58eamr98373395e9.18.1754038958620;
        Fri, 01 Aug 2025 02:02:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkH0ccGkKZ/6vzJsc76g5xDgdfhxBqzn1bLX/4APKTuoDCrW7A/V19UVwG2pZ4KLzrc6vMOg==
X-Received: by 2002:a05:600c:6814:b0:456:dc0:7d4e with SMTP id 5b1f17b1804b1-45892bc58eamr98373015e9.18.1754038958195;
        Fri, 01 Aug 2025 02:02:38 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:7500:5f99:9633:990e:138? (p200300d82f2075005f999633990e0138.dip0.t-ipconnect.de. [2003:d8:2f20:7500:5f99:9633:990e:138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953eaed4sm91617645e9.27.2025.08.01.02.02.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 02:02:37 -0700 (PDT)
Message-ID: <566ff1f0-e6f4-4888-a901-4995a84d15b7@redhat.com>
Date: Fri, 1 Aug 2025 11:02:35 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: link with thp_settings when necessary
To: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 Ryan Roberts <ryan.roberts@arm.com>
References: <20250801085444.27182-1-richard.weiyang@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250801085444.27182-1-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.08.25 10:54, Wei Yang wrote:
> Currently all test cases are linked with thp_settings, while only 6
> out of 50+ targets rely on it.
> 
> Instead of making thp_settings as a common dependency, link it only
> when necessary.


You don't state why we should care about that? I don't see how binary 
size is a problem, why do you think it is?

-- 
Cheers,

David / dhildenb


