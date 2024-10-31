Return-Path: <linux-kselftest+bounces-21222-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 192D79B7D21
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 15:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B3041F227FF
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 14:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23EF1A254F;
	Thu, 31 Oct 2024 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SluWtb+r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04E91A08CC
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2024 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730385713; cv=none; b=GEbuw9pOMahLFvGSgv03F2HHFyoRyq2xFHWWv2tWvkjVGohzvAr8Sp9h0RkJgz/lCBqsR0uZmXQMsVGrQP/58a1KC/zTSsBeeFLkorPU5JbT8qwVL6JaeWWb6Qt8CTm5a7MoEvQcmVjJWn5gzL1Lpl0yWnOeKXfwtKPbSME/lAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730385713; c=relaxed/simple;
	bh=9eS5ge2alX9b56f6i6Q7sWV1uG4Sj94/LDvot5kpaqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p221E+HDbdKQKtcRnj7Rq6ml5FRe/fPOpD9m98LT2QsbzgRFAHJWMVdTeNVRfoAHMb0xljvX6U/BBq1K+5mbiqpsJQ/oEbAnv0vL28g1fSo5hmeTa9qbAYtBBHG8U2jMkIFkIHQ62gNL/US4C3TweRzlsfM0edQDEeByiL4WP04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SluWtb+r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730385711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2dlgmPQjrWN8bcG64Fgx2fujRr7yOykhTLvlfDSXZU4=;
	b=SluWtb+rDf6mSi/VmSI/a5nzl3cbsEVByZ/CfhTN6HuFyaw4sEWX41SGxCBi89jk0k7/V+
	Z1m21INAa0MQKZmntVZJB8LcILZEq3xhHGzz++JzBSR4NlQXIZR9Wi3btQZjPsILQtLJS8
	RacYIau8Y3Dk+ePUXDLbfDyso20jlA0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-hv6S3Br9NVmVUmJ1gUrlqQ-1; Thu, 31 Oct 2024 10:41:47 -0400
X-MC-Unique: hv6S3Br9NVmVUmJ1gUrlqQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d4922d8c7so490826f8f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2024 07:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730385706; x=1730990506;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2dlgmPQjrWN8bcG64Fgx2fujRr7yOykhTLvlfDSXZU4=;
        b=tjVs/Nqo2wNrZXyEBAsq2AoH/FrvLmlQ6hcbbFv/YrwOWXIX2N3fduIAxLQxyE7gCm
         o0ybpCF0+TTjCkYqsmr6nTwNpLMx79W5shYeAQMh46bPq82jscRrmkjw6Lj2PU0LAae+
         Fr3Y3DpJ+S+Ja2o6rjD25ftFfYgcUBTt2CdO5FR9La/ywDGbm1JH3h82rjCD9t6C706+
         drtr/auzFHZVL+vb1u7sKW6MYDhtZEyOg/7MrDJIY2G9at99jj30Kz8rHAdUS8fG4pOJ
         /AFO/uxi5ZEQJ31d3kgmTkz7en8tmmlbIbUG6UPir5VwvbP6hbGGa2EyjjDq4fScH9SB
         EP6g==
X-Gm-Message-State: AOJu0YzRshQ3Dkj7wjC/7GijZBVWotuWX1VyHm959aacFGejY4sMw5pj
	XBNAwKw5/IloIzkwu7AiVijqaGklM4UvQMRENHjtuFkcfKp9TMF+gC7J7th1Ywm8vn2ikfcsNtM
	/41EqalCBZllNDjly+oXJM6Ow6FT2eOghIaxDRR58nyzzOtRPqhAe4OjRTEnght/G1Q==
X-Received: by 2002:a5d:6d0e:0:b0:37c:cc60:2c63 with SMTP id ffacd0b85a97d-381c7a3a23dmr216422f8f.5.1730385706483;
        Thu, 31 Oct 2024 07:41:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFg8FMucp/9+qkpBZFRMIEgFHrJyFQGjPuPNs4cDJVO5fafRU341aNOfiA7iUPsBELpgYtCyQ==
X-Received: by 2002:a5d:6d0e:0:b0:37c:cc60:2c63 with SMTP id ffacd0b85a97d-381c7a3a23dmr216386f8f.5.1730385706081;
        Thu, 31 Oct 2024 07:41:46 -0700 (PDT)
Received: from [192.168.88.248] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116b11esm2278221f8f.104.2024.10.31.07.41.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 07:41:45 -0700 (PDT)
Message-ID: <3e443eb4-d15f-45ff-8b41-a8215fb4032b@redhat.com>
Date: Thu, 31 Oct 2024 15:41:43 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/4] selftests: hsr: Add test for VLAN
To: MD Danish Anwar <danishanwar@ti.com>, geliang@kernel.org,
 liuhangbin@gmail.com, dan.carpenter@linaro.org, jiri@resnulli.us,
 n.zhandarovich@fintech.ru, aleksander.lobakin@intel.com, lukma@denx.de,
 horms@kernel.org, jan.kiszka@siemens.com, diogo.ivo@siemens.com,
 shuah@kernel.org, kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>,
 m-malladi@ti.com
References: <20241024103056.3201071-1-danishanwar@ti.com>
 <20241024103056.3201071-5-danishanwar@ti.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241024103056.3201071-5-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/24 12:30, MD Danish Anwar wrote:
> @@ -183,9 +232,21 @@ trap cleanup_all_ns EXIT
>  setup_hsr_interfaces 0
>  do_complete_ping_test
>  
> +# Run VLAN Test
> +if $vlan; then
> +	setup_vlan_interfaces
> +	hsr_vlan_ping
> +fi
> +
>  setup_ns ns1 ns2 ns3
>  
>  setup_hsr_interfaces 1
>  do_complete_ping_test
>  
> +# Run VLAN Test
> +if $vlan; then
> +	setup_vlan_interfaces
> +	hsr_vlan_ping
> +fi

The new tests should be enabled by default. Indeed ideally the test
script should be able to run successfully on kernel not supporting such
feature; you could cope with that looking for the hsr exposed feature
and skipping the vlan test when the relevant feature is not present.

Cheers,

Paolo


