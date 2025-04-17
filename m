Return-Path: <linux-kselftest+bounces-31043-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F56A919AE
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 12:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E94216C505
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 10:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BD6232786;
	Thu, 17 Apr 2025 10:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RJeB/SME"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54F022E414
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Apr 2025 10:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744886895; cv=none; b=PX7pP5A7xlqM/ItG2Hv+qptTMBzhB/6+vwtAV5LZ0ZrNrBiTkqbUfjNNkhiPmAbkNir6oMSt194W9OhGqzp877KTl0Z9t7YbLCa85zaz3jM2q+ErsG1VQusK3xEdKZcj/dTbp3LlrdTw5HNGm2tH5eiLqhz/csF8CUeZvVqihvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744886895; c=relaxed/simple;
	bh=XhGacwTcE6A+IWJQpQyCMN16TVH3Z6owtk1R8JSA4+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kqJu5YxaUuB9eoPs6IXWBPOUgm0g1FTbgHHO6hxg5boOGX2wCrCProuMC7q0wtnJirHhSPrN8UeD+L4XNKgKg7LlT4WZd8of87TLaC62DFpTDgl5BUSkasD0dCxMKOwehfCXivZTm6mmyNO06n6MkQw6I5thbPRiLWyolsmc/ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RJeB/SME; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744886892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OudEsC2htuXU3a1BRgDOXrN8cqmum79c1G5XjX0b0Ts=;
	b=RJeB/SMEV2vlQF88hIAcBlzc2G/F9MTPkCmq7Cr5MbMKe4iefd0doeyPTBdddXWSKYTTjK
	OMweKDUmwvj1kP8eWAkIe94uNCHiqoMnxKfg5pweXPaE/jYzOcfo7CLF+tHniWwJ1DL6KR
	sVIAokg7i9l3lvGX0bTGpUpJaX/Pa6k=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-e5QChGQ6MdSc6VNIgsqMLg-1; Thu, 17 Apr 2025 06:48:11 -0400
X-MC-Unique: e5QChGQ6MdSc6VNIgsqMLg-1
X-Mimecast-MFC-AGG-ID: e5QChGQ6MdSc6VNIgsqMLg_1744886891
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6ece036a581so12503006d6.1
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Apr 2025 03:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744886891; x=1745491691;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OudEsC2htuXU3a1BRgDOXrN8cqmum79c1G5XjX0b0Ts=;
        b=d6EJi75iFoI0jlfyu1/TSrOCEXYOXsJ7mGlyLSazM+4GOKr27TpA0XNHoVj861VFwP
         ZX+Br4UZRtnssU9TkYS54NUXe+p8YVWnINLfjVm88sLslZaXSRpSVFVv45yUWdUUd3l5
         W9sp01P0OGjsM0r7PEe+p/uPf7Qfmd+NuzTl4TaUfUhmxFZR9C8BsU5SVDC0ETgEguDV
         mddRiorkT0tCAjy35MMgT1N3pAaCi+c5125y2vjYpLfsZmjNGPmgdVPBsxC7rToGoSMP
         bAoZnWykPQ8Q+e4V1yFUHmgwCjv5KpZ5fCgLvLVjZOJyA1xWS8nRqdvvtzRmRq4/49M8
         JUsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmCZn/XpaXy9fd+vAnvuE9w+j8woAEGuFLIxRaN738IqJFfVtxK5eH+z393ffYd1m8TLc2+x9HhanL9XY6OVI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6brvtOvP36jpQk98fEVjxiNmZMfO9YKLyDM6ZV+6019MXOa5m
	IWTXjShhwR6LgV7U85SVR6fLnnIscGCDY5FaPPeQi1FA73q8Yu0SuuYmEDR3QJJFuJq60hEKisr
	h58FY3KC/dpu18svEwvzMcZ201cOgTloC7TEFoGjlmyPSaRuc/gQnW8GIRCobiPjqsypMqgQVBQ
	==
X-Gm-Gg: ASbGncs8i6SYifnBNfNJc2aXC7+ygjnSJYEF/5S8rbuPyopZlIS8/R77Q4MedVGAh2U
	TVgfFsIwPgXBN+DeEzwOouJ9ufmJj4v/aos58OaNnjZYVJ7Y7OGcTRyXR1MJajIO3/ysiUbk2KI
	d/ALLVKXUEAYp8vVJ8t/5kctv7BND3QaCcZtkm7OJz0oMLsf7ttLJT1S80jVmrFOU/QinpKHyOD
	cPjEET7Dl1CY8PmqsChtU9Jx058zYvlJzJupCUyRyVWum+dICwSSmtmvkthv/iU3R9WjamQxwhx
	y6uJk0nqz/h96IxY6VKh3Z8nRsQ96D+3FAZqCaQK8A==
X-Received: by 2002:a05:6214:3008:b0:6e8:fa72:be49 with SMTP id 6a1803df08f44-6f2b2f421b9mr65124486d6.12.1744886891272;
        Thu, 17 Apr 2025 03:48:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRD2S2lNf87+n5j2F4wP6+GtOIfe7KgdYGkxqrRR5TEwTDQjpW1zM73oytFXas9ITp16LLpQ==
X-Received: by 2002:a05:6214:3008:b0:6e8:fa72:be49 with SMTP id 6a1803df08f44-6f2b2f421b9mr65124216d6.12.1744886890999;
        Thu, 17 Apr 2025 03:48:10 -0700 (PDT)
Received: from [192.168.88.253] (146-241-55-253.dyn.eolo.it. [146.241.55.253])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0de982274sm125717616d6.64.2025.04.17.03.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 03:48:10 -0700 (PDT)
Message-ID: <8bfc6c5f-4bfc-4df4-ac52-b96d902a9d7f@redhat.com>
Date: Thu, 17 Apr 2025 12:48:07 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v26 00/23] Introducing OpenVPN Data Channel
 Offload
To: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>,
 steffen.klassert@secunet.com, antony.antony@secunet.com,
 willemdebruijn.kernel@gmail.com, David Ahern <dsahern@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Shuah Khan <skhan@linuxfoundation.org>
References: <20250415-b4-ovpn-v26-0-577f6097b964@openvpn.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250415-b4-ovpn-v26-0-577f6097b964@openvpn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/25 1:17 PM, Antonio Quartulli wrote:
> Notable changes since v25:
> * removed netdev notifier (was only used for our own devices)
> * added .dellink implementation to address what was previously
>   done in notifier
> * removed .ndo_open and moved netif_carrier_off() call to .ndo_init
> * fixed author in MODULE_AUTHOR()
> * properly indented checks in ovpn.yaml
> * switched from TSTATS to DSTATS
> * removed obsolete comment in ovpn_socket_new()
> * removed unrelated hunk in ovpn_socket_new()
> 
> The latest code can also be found at:
> 
> https://github.com/OpenVPN/ovpn-net-next

I think it's finally time to merge this. Thanks Anotonio for your
patience and persistence and thank you Sabrina for the huge review effort.

/P


