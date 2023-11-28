Return-Path: <linux-kselftest+bounces-746-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6B77FC399
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 19:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283411C20C40
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 18:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCC641C86;
	Tue, 28 Nov 2023 18:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TBMxYFd6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA68E1
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Nov 2023 10:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701196854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VHDSVc68YkNjIz/fNayvFmFoqWmnEg0LsBzOyPrViJ0=;
	b=TBMxYFd6nXCKbMbgEtX0EGZlCR7Ot7WuyAD6+0IYEwjZ1/IAEnGz1Xm2lDk+agaK+CArIP
	DQ4rZEYVkLP9SC4twuj4rSLH1LB1Y8Mk6chNCusYZwlgw4WCkkmMugBczv5sBABD5wbUqr
	KTKvoTVzdCIVGGxmQwuE01Zc9rQEgS0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-uvRcxFXaOLO_r0RKQ9ohOQ-1; Tue, 28 Nov 2023 13:40:53 -0500
X-MC-Unique: uvRcxFXaOLO_r0RKQ9ohOQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-332ee6c2a1aso2993318f8f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Nov 2023 10:40:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701196852; x=1701801652;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VHDSVc68YkNjIz/fNayvFmFoqWmnEg0LsBzOyPrViJ0=;
        b=JbXr/3NJQ68FWM3XmeuxlnXL1IoLld7gZG1zy+RNbV9OhHIttpskXcfuBG+hqpj0ua
         HDR6JZkeKUg99sA3V0zohaUJKrgYrnE7RQn++odoO9jPAo3WiXPK7CQr7XB9icy09nW3
         rkHr/lEBxOPQzB4YgF7dkZ+5Br1SRWLZci65onW401wrotK5iITQLuL8IEkTGk+Ln5Vm
         VvYdCIE5sJbw6eM5UKFS7GjUt9s1mXI8fscU1q71JKmWen851VK7Fo58TxRXDbZM4uU7
         h4s/rTXxW/9IDlUBangh0QQJfIhoXL0Cor3VSChCyCoFrytyWZ76Hv+UkHu1nn7fiChi
         a9qg==
X-Gm-Message-State: AOJu0YzXoLE8AtOwbzlPW9pIuQF0GjRTDDPXRKHOnXraxXolCPoATzrb
	bRnGIzVRqB1zrYfubZAs0XDBbzHmluWNSpwhjjSr+JID8PnsCjamUBMTRxjHB5OISlAxjRy5MHO
	oZfaNjBlkqgNimtqh1seaTiZYmIA=
X-Received: by 2002:adf:ef4e:0:b0:324:8239:2873 with SMTP id c14-20020adfef4e000000b0032482392873mr13119574wrp.37.1701196852165;
        Tue, 28 Nov 2023 10:40:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgx9fub6tHc2TIBf8WvN+f8H+w3lnzmfR1oU9iU0W6tR1BbdEUVqOXM76GdnBXAvfNg89crw==
X-Received: by 2002:adf:ef4e:0:b0:324:8239:2873 with SMTP id c14-20020adfef4e000000b0032482392873mr13119557wrp.37.1701196851839;
        Tue, 28 Nov 2023 10:40:51 -0800 (PST)
Received: from [192.168.9.34] (net-2-34-24-178.cust.vodafonedsl.it. [2.34.24.178])
        by smtp.gmail.com with ESMTPSA id y14-20020adff6ce000000b0033308db2576sm3765067wrp.56.2023.11.28.10.40.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 10:40:51 -0800 (PST)
Message-ID: <d6e92498-1784-48f5-904c-8bd37770c206@redhat.com>
Date: Tue, 28 Nov 2023 19:40:49 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kunit: run test suites only after module
 initialization completes
To: Javier Martinez Canillas <javierm@redhat.com>,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 Jinjie Ruan <ruanjinjie@huawei.com>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org
References: <20231128101627.65399-1-marpagan@redhat.com>
 <878r6icenj.fsf@minerva.mail-host-address-is-not-set>
Content-Language: en-US
From: Marco Pagani <marpagan@redhat.com>
In-Reply-To: <878r6icenj.fsf@minerva.mail-host-address-is-not-set>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 28/11/23 12:15, Javier Martinez Canillas wrote:
> Marco Pagani <marpagan@redhat.com> writes:
> 
> Hello Marco,
> 
> [...]
> 
>> @@ -737,12 +738,14 @@ static void kunit_module_exit(struct module *mod)
>>  	};
>>  	const char *action = kunit_action();
>>  
>> +	if (!suite_set.start || !virt_addr_valid(suite_set.start))
>> +		return;
>> +
> 
> I would add a comment here explaining why this condition is checked and
> what it means. Maybe something like the following ?
> 
> +       /*
> +        * Check if the kunit test suite start address is a virtual
> +        * address or a direct mapping address. This is used as an
> +        * indication of whether the kunit_filter_suites() was used
> +        * to filter the kunit test suite or not.
> +        *
> +        * If is not a virtual address, then this means that the
> +        * kunit_module_init() function was not called and the kunit
> +        * suite was not filtered. Let's just bail out in that case.
> +        */
> +       if (!suite_set.start || !virt_addr_valid(suite_set.start))
> +               return;

Good point. I'll add a comment in v3.

> 
> The patch makes sense to me though and agree that is a better approach.
> 
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> 

Thanks,
Marco


