Return-Path: <linux-kselftest+bounces-38765-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A140AB2229D
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 11:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96DF1166B97
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 09:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0A82E7BD0;
	Tue, 12 Aug 2025 09:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U05wqZda"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3715C2E7BB7
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Aug 2025 09:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990085; cv=none; b=aWtS2RCONyUS2U48NquwVQbY0t3dVb7W0zrXNjm+ytyjaew/ZY+eQXEI2jGId3O3T/lz1lGw5EUihTLVxRcQnNPYGDvSFlmY1AeTX8O3P5oNjCG1dwSdCtDxnGFUhc99gLKGVZcDrWOVOX1ur8SRvi+qv81Fq8Bg6apFSwaKrw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990085; c=relaxed/simple;
	bh=fbkvdHbzO5iMyqUyNMSQ2ifyYq35TUmApmNBn7z38C8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bJNDfXMEf6eCib7716DMAsJbjSMBWvtmi2A/8NBYRJ6gxBMPtp1KI5OZzj1Fu2hJT6zr8/tzDEsYZE9If7bH85xHBlg/Nj1BjO7DmnzW0DuNCutr7ab97/Ujpoax+m2zoFxEZTuDF4s+cxfL72wgIsqD9GreWg8i1XiRGUo2qak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U05wqZda; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754990083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GfnH6UdWPTLsT4NE037V+5yMnBpvuJn2hgsl4bTLdLY=;
	b=U05wqZdaaFrxmbAMhoc4EWztNWUjs59w/KZ+Ku6rUz8TIh5pPHsW44pwu/vnCKScBJ4qko
	uFXj7TOAsDh9Bf9iGnv91up8j/p0yTejY3r2hQlBF8SGy1CXKBTKGt6pDhqa1Y8D/2HuNE
	+O7jG919gHynclc1RR9YD3banrM+B44=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-wesSM6AKOXGaQMHKnRPUXA-1; Tue, 12 Aug 2025 05:14:41 -0400
X-MC-Unique: wesSM6AKOXGaQMHKnRPUXA-1
X-Mimecast-MFC-AGG-ID: wesSM6AKOXGaQMHKnRPUXA_1754990080
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-459f53d29d2so22304985e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Aug 2025 02:14:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754990080; x=1755594880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GfnH6UdWPTLsT4NE037V+5yMnBpvuJn2hgsl4bTLdLY=;
        b=GXHlO+emfTXERpPi4p9Hkkg3pQGl7AFklBXXRS/S7gDeVuOfcWOOMRdHNYwgJv+Xcc
         VDmrYZZPJM6LPgtqFKMnNQfQI+8oi0tUZ5IGsSahw6U4hK7jMEaMeVCOQrrw2LnbPXju
         ZAbmXrYPfqlo/buxBjaXeLSQTBpCok+XOWCltMSMk3299CYz8dI5J0HYT9HjAxgv4Jr+
         uO/YTmUdXFCVM4dCX1B6lWrAE+v1wqpgjZ5+HlMrYCB9yTp/UcsaaR+j9n9bi0BOCtFm
         3uKoevGRK/LfE4ZycaFDBawlCyq66feMT1vuOd05iZcQqU9HkQ5eS27wjQGYa6Dsutid
         L0pg==
X-Forwarded-Encrypted: i=1; AJvYcCWVhd0QSk1vDP/lujR7RQ5OB10cMjOH5WWaKXwg7iq3/HR3Jt0ZCvqi4AxuAyX6KSkctiw2ydXwQgHNjrA1tKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIKRkk5mocc3kGGEp1VsABTTSuRDx9l1c0WtvA8G6wM7ck9vdN
	tW7hxavC45MaM8j20i0p0E0ah10n9Qp0MSzG+VrIKMvqB5qZ4Q7LRcXvbKvkwX2XGSF4C7Bb3vo
	eaHrEYxyP/qoCpHi8B8uMzDcKoAARFmHDsbhOagRez82QOSTDNquw0YuAJs3j1mggyQnCSw==
X-Gm-Gg: ASbGncvKqMqGMZ5tc4SxowlNlKDxZIW0lkHP/aZq9pS6tsOKfQngFvRraobd6ClmYj3
	Sa89wM8wCT7hfY+oq7ERG4TOLXaAFp7h9xsD2otgPvahAR+tS/iIXVOoEItNygdql1H5aT8lU2d
	T8gxq0cLBiQoH74uxlICMBoQaTiC3M1aPyFcKjy/ExoGYliwaX7iPlkmAVdCOcdf8nU5Ld7DvZ7
	SUQYqDWjcSLwJi1oF9PzeStxiA/KfoHSJ1C8BYtmaOB9G1Up6lLM+1NJ6kbT6E55FRSyB9jxhHk
	/nsZGAEyfmEVd0wVt42i21iaZzeYSeWVDdfPkcZNSXk=
X-Received: by 2002:a05:600c:a46:b0:453:5a04:b60e with SMTP id 5b1f17b1804b1-45a10c0020amr20225135e9.26.1754990080398;
        Tue, 12 Aug 2025 02:14:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6aoDZQH3cS2UCnVzBBG1Izm2yKQoFjrOrA+8ZiuIJILKKDdscGnHzDMcfx14lN7+SN/qnwA==
X-Received: by 2002:a05:600c:a46:b0:453:5a04:b60e with SMTP id 5b1f17b1804b1-45a10c0020amr20224905e9.26.1754990080025;
        Tue, 12 Aug 2025 02:14:40 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.149.252])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3ac093sm45795951f8f.9.2025.08.12.02.14.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 02:14:39 -0700 (PDT)
Message-ID: <fb08ab9f-4d15-48c4-bd2e-52077dce0b82@redhat.com>
Date: Tue, 12 Aug 2025 11:14:38 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net 2/3] bonding: send LACPDUs periodically in passive
 mode after receiving partner's LACPDU
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250805094634.40173-1-liuhangbin@gmail.com>
 <20250805094634.40173-3-liuhangbin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250805094634.40173-3-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/5/25 11:46 AM, Hangbin Liu wrote:
> @@ -95,13 +95,13 @@ static int ad_marker_send(struct port *port, struct bond_marker *marker);
>  static void ad_mux_machine(struct port *port, bool *update_slave_arr);
>  static void ad_rx_machine(struct lacpdu *lacpdu, struct port *port);
>  static void ad_tx_machine(struct port *port);
> -static void ad_periodic_machine(struct port *port, struct bond_params *bond_params);
> +static void ad_periodic_machine(struct port *port);
>  static void ad_port_selection_logic(struct port *port, bool *update_slave_arr);
>  static void ad_agg_selection_logic(struct aggregator *aggregator,
>  				   bool *update_slave_arr);
>  static void ad_clear_agg(struct aggregator *aggregator);
>  static void ad_initialize_agg(struct aggregator *aggregator);
> -static void ad_initialize_port(struct port *port, int lacp_fast);
> +static void ad_initialize_port(struct port *port, struct bond_params *bond_params);

The `bond_params` argument should be constified.

Thanks,

Paolo



