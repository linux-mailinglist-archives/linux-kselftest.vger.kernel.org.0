Return-Path: <linux-kselftest+bounces-39471-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4952B2F3AC
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 11:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A955C17A584
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 09:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5CB2ED147;
	Thu, 21 Aug 2025 09:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G+izUzgR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2A22ED85D
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 09:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755767790; cv=none; b=ORYUE2qf/WVgbUWFfriOOBx7Oe9zNxJRANGl1htIgIPWeOEKoiheQGUbPsbqs5n++OJcbzxSBRZm/eL8kPOjotjS6ViMDskwzFESGCG9zyCps5KOsPBFIxm7nzq/pWuk/8cMt7tGexMWO1nsEVOvwdj6MkogIxa0QRj1FnEJx2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755767790; c=relaxed/simple;
	bh=pm14elPZ5G/j4V8ktFwqsKYTPh/bNpFOvdQNitNlm24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lts5xmNRGuZGChVgJtdrmzrnMbsdmW6M6P5vbZPex9hmGNkknCRPuF7wCgTarFfQHm6qaWcijEXniyuVH4z7TpBIygPuAYdJ+MRk0ddaUyayYYUQ6Cy79Gq5xA06vUkUAnVPQO6D8tiqDAR7m6Qf0jNQ4Ie69WHs5Dw8IzTnKpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G+izUzgR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755767788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QFV43Vjpw2YCtuBdkEV7d+CUzzBS4M8wrUUVCTOwfBI=;
	b=G+izUzgRIeKwnBKgK74Op0oIcKv2v3AFQG6NAqpOAZ/O85GJLw/CL0srpewae4XYsc+283
	LqS1y/HbCZYFwSF2CmdkDIHh0nhVflVmKuYzeZjfC79LJHlSxX3wReyj4jrj9JyI1ScU0g
	l6weMnr+s4N+aQlf9+WQTO0ZlTL4QNg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-XhwMx-nbMJyufyMw0UYiAA-1; Thu, 21 Aug 2025 05:16:26 -0400
X-MC-Unique: XhwMx-nbMJyufyMw0UYiAA-1
X-Mimecast-MFC-AGG-ID: XhwMx-nbMJyufyMw0UYiAA_1755767786
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e870316b85so163932885a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 02:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755767786; x=1756372586;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QFV43Vjpw2YCtuBdkEV7d+CUzzBS4M8wrUUVCTOwfBI=;
        b=H2uzD2i5sRoqT4yuhpP8hLfrawadMxyaBWmuayrojzPkmOJ5YkeeYt0aZV9vgJrNt9
         nXJGDh64hhEon0NdZTrB5bYURqbmR2ptmtIi0Qbbu0IMDh/cBgoEV/NR8yJzOra/aeqM
         3vRTfeSd0WtontCmz+MfZMIQVUwItGvF/pYYaIoFwXVa5Pu9v4b41DZkmmUS/G8FqlLE
         tgAD6LCxT22WVfRFWANrmG7M0XCnVb0V3RDeG3fYr6EjYnHQJTFI5VRBghuUK7nbjaTQ
         hYL0XqIuH7p/lD7Zof8STnuMOiZLPyAFPlyUKs2/jd7jC8yKUd3oLXdnokQ2kmFGxp8e
         9YJA==
X-Forwarded-Encrypted: i=1; AJvYcCWYVsRQmiux9nAD5i8uHBOVZ8qWdKOIzLLEf6Q6fLB+SSkiiYIVWT05LIuJGuHyxQoFTwyhNGvApM4gk6p5iJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcBhCuJO95eU1vKOjGjCNBBmJwWqO0l/vSHndeV9SWrGQALUD9
	eG55nmKzZCV1cGH8SUmhWHUBeLK0G0ywV285/HMXzrOruzt4BGDKnMITBBXtO3VYhj5ff9eFUik
	SU3SmJbnTM4u5wJPSTRjf4+Spl//XTeNXct+pNDUTagUnUkzrMy7hD2A1zt/iP1gIZS7qIA==
X-Gm-Gg: ASbGncsG2/ZqTxTuQKF43aLQEuWIN3+Nh1xzDts6ov2fRDl+cVWPQFUFBQXdwUwnubj
	ylQTZ0iH1G+tKQcdO1xkQo+ODsHWlnzgsRGILtIPWVvkaA8LsSFMP9VMRWpL7Sc4oZ9eUwANP+t
	bE12XTnmzHWVMJOmyCZmomsFCWqXweAZbJtBjq3LBT/hEfd9W48ZsL1gfdtpfjFn4+lVdSZoP2W
	jEwizBu+/pHo3/a1B1fPuN/0xNVyoVTFO9D3F1g6+ATVFgqrXi+F/ooa79kxa7akje02KQCV29i
	yWdnOnsublohfG8EtH3X0k9P09VtGN8Iv76+MBP7HgtG4fGoYLheHeZRHicndYPmJEjKNb7PlAe
	b/9HayA0l6lY=
X-Received: by 2002:a05:622a:2607:b0:4b0:74ac:db35 with SMTP id d75a77b69052e-4b29fa00e71mr17490411cf.12.1755767786299;
        Thu, 21 Aug 2025 02:16:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEO59+xn+TEz6syN109Tg/E9Y9908A1mTpsNgURB+UWGfNs8GFE2O7XylT4YucYAMPXkXfNRg==
X-Received: by 2002:a05:622a:2607:b0:4b0:74ac:db35 with SMTP id d75a77b69052e-4b29fa00e71mr17490011cf.12.1755767785777;
        Thu, 21 Aug 2025 02:16:25 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e1c9b9dsm1089675885a.70.2025.08.21.02.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 02:16:25 -0700 (PDT)
Message-ID: <1ba2c580-6401-4f95-8d63-48634b834234@redhat.com>
Date: Thu, 21 Aug 2025 11:16:21 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 net-next 2/3] bonding: support aggregator selection
 based on port priority
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Petr Machata <petrm@nvidia.com>,
 Amit Cohen <amcohen@nvidia.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 David Ahern <dsahern@gmail.com>, Jonas Gorski <jonas.gorski@gmail.com>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250818092311.383181-1-liuhangbin@gmail.com>
 <20250818092311.383181-3-liuhangbin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250818092311.383181-3-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 11:23 AM, Hangbin Liu wrote:
> @@ -1707,6 +1719,9 @@ static struct aggregator *ad_agg_selection_test(struct aggregator *best,
>  	 * BOND_AD_COUNT: Select by count of ports.  If count is equal,
>  	 *     select by bandwidth.
>  	 *
> +	 * BOND_AD_PRIO: Select by total priority of ports. If priority
> +	 *     is equal, select by count.
> +	 *
>  	 * BOND_AD_STABLE, BOND_AD_BANDWIDTH: Select by bandwidth.
>  	 */
>  	if (!best)

Minor nit: I think the comment would be more readable placing
BOND_AD_PRIO before BOND_AD_COUNT, so that each value documentation
references only the following one.

Thanks,

Paolo


