Return-Path: <linux-kselftest+bounces-29457-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9226DA6995D
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 20:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25CE98A099F
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 19:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259DF2147E0;
	Wed, 19 Mar 2025 19:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uu/DRrTY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBE22144A2;
	Wed, 19 Mar 2025 19:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412629; cv=none; b=MdF7PXUzvp7ZMzhBiBYMGiZoBLeZ3PCj9wZNYz3grQuv2LMjSIPdFwpsN6iZjrtobh0ifUk/Sa1F1wIVrO0i/02RH4opG66mQlBkv0iYs6dVLc61tWBvwkjMb9PVlo6XKgvLaIDqVxeabAtvSJtXlyYMz4Hr9LAqxxa6nC3fSCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412629; c=relaxed/simple;
	bh=Rz7Yp1I80hzWgHGkG+CgxdDTBoc6y2B4a7XLDwScsJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=op3aGA2jMTYIN/EjnLmSOmNHNUAEMF8MY82BEoNbDrXOM1Rj7v6Tql6enU08Eb+VwlV/i2XtryiLGEji/Qc2OLQoQyN1RWSW/SzquyhgLkIqGZUP8sne7UofcuTb+rm04R78WKBVBjXJd1dMcdVjTNZaTMtHJhoR4PyLhkedAQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uu/DRrTY; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e535e6739bso43311a12.1;
        Wed, 19 Mar 2025 12:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742412626; x=1743017426; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JcRJhKVbE8LiKn0WB81Ry6++/HhaRWmyYNiRtC8fff8=;
        b=Uu/DRrTYibBlpfLWszx5vp8lqwny996KYvTo/axot5LX6U5ExN39E6TkwdiZWtO+bT
         qxEoQuAqZC4Sn8JGgTTFDn8dGK2sCRPSeXuwOzm+14IbxMFpvxUUHBfJX6wEZn8bQJAl
         iMkVotnEBHd+03mWz0AthPEBX2ZNgdXH9tDGj1BBnRdcWQ3pMIEOZ40O3rF/68eY0n23
         J1vKmNmw97iKfEPtpMbhfe2fRsqedu0LH7MtKkHrZEVaXD/wc0kGH+JevTkN5RyufUdp
         yFw5v+trks+2S9uyYwyqcyIDKdbLBe0qaHYtgGYQ8gtIbb7OXKnQk6QUx7wyBJ3IjAoL
         T8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742412626; x=1743017426;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JcRJhKVbE8LiKn0WB81Ry6++/HhaRWmyYNiRtC8fff8=;
        b=SdW1Lniy9LuSa7oAbmWUTNg3blKMLDMG4SqcpRVqSyUlHkj1INsbQ5zMwvkCCcl9Rq
         RRGFy2jrLLzCvLKESoufGClORQ6gLmdu2SpHlecndkkIhOaf4tvCRY0wHKAr+DvglqKc
         DGG/eoQo999TutU2GBDM54U0IZgHYkCBpAizWwpLkJ6lesZw3gzZ3eV1RFB+vZnfup15
         SBFpvDzXr8mWHzoWj44ZNcO3sFWF34ami3vZ3dQ+RJmI3TbSQYE6Bx+LNcn19Fv/Vc89
         Xyei0aqqFrjDRor705KgZD7KqbtVLwzp013aYRo8yM8jZRt2daI1uEn44SWlbYBhRHHj
         NoiA==
X-Forwarded-Encrypted: i=1; AJvYcCUIAzSyhJrAb2PuaztcmdR3AwakNAgUVt8eCgJ1YPsFZnfmF3DJmPJjje3n6VYK9zI5s17ZpNcnPWEJaWzXXGY=@vger.kernel.org, AJvYcCW1Nu2l7WgT8hAGFNlk9uRLGOA0jFMb64Hr1qxvFoAm+62tkQIscC5IhUehI/M4Mfk+gNYuGr+Bu3j/bGsKPN3w@vger.kernel.org, AJvYcCWLjH4IpkRz671bUXkZ4dyjj5RIO0IaykQvycYuO6oQqmSLtSpO5RwADAGMscfa1XUCEJmx9ZZI@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2RZyCeMB2j3mScjmRAzL5NPKAt8ZBGrCjGGznK7o2hm9rvS3U
	LALV6N1CyqnGPMaczpVq+wNwOl1go4FthDX6bG2A8pjqd+bSVx+Y
X-Gm-Gg: ASbGnctBoKqj2G65FUtrd0GfvWmOgRRYtWGjCa3HnaVr2AcqCFTSC1MZgulTIqpdQQf
	6CVpS8l+DdN+NQ0TbfNYoKDooTggXeb8uawtOgEwq9wiMmAXhZrDXOIbzCiXZdm/9NgMAJVh5Ua
	adS2v8SDMi605waAFBX/C4U3haFJvNCXa5fGYmy1mSCvplAUhXsfY0QqbKPS9o1ZtvAuMn708+b
	8h+Vc2x9lz8KgZHzZQotCQ+0Iw6yvQ2hH09an84eKMbwXeyE+OW7ExIoMgWsfmqjGjO7r6Atmsn
	wpu/nv2h9Lbdn2TR/AzRHUzkjahAGoVklK4Kt1OoDZvKfl+Wu7X3ft2J3mgwgakltl4jUaQxmwe
	/L4F8y+7t+vum++g7uTCvRJY792WbjRKmhocydA7NcQwaXHsYq9qg8wExbfsS80jmoBP57vU2+V
	Pp0Y3X3zS4800qmECcmIM=
X-Google-Smtp-Source: AGHT+IHfY94z1fDRn6/5yWLXbj9lWPjuQfu08xCij4YrKfzU9oqQAqTzAP1SiocnoJAKedNXqvHa0w==
X-Received: by 2002:a17:907:2d9f:b0:ac3:b613:a651 with SMTP id a640c23a62f3a-ac3b7d72767mr373478666b.17.1742412625436;
        Wed, 19 Mar 2025 12:30:25 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149d0077sm1065324166b.93.2025.03.19.12.30.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 12:30:25 -0700 (PDT)
Message-ID: <6d16cf71-ce66-46fd-94b3-5757ef044bd5@gmail.com>
Date: Wed, 19 Mar 2025 20:30:22 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 nf-next 3/3] selftests: netfilter: Add
 conntrack_bridge.sh
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>, Roopa Prabhu <roopa@nvidia.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 netfilter-devel@vger.kernel.org, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250315200033.17820-1-ericwouds@gmail.com>
 <20250315200033.17820-4-ericwouds@gmail.com> <Z9n8qBrt-TK4XlRq@calendula>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <Z9n8qBrt-TK4XlRq@calendula>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/19/25 12:07 AM, Pablo Neira Ayuso wrote:
> On Sat, Mar 15, 2025 at 09:00:33PM +0100, Eric Woudstra wrote:
>> Check conntrack bridge is functional in various vlan setups.
> 
> Only conntrack bridge support is tested here, patch 2/3 does not seem
> to be covered :(
> 

I should add more details to this description.

I do add the nftables table bridge, chain forward, type filter
and check the counter for ct state established.

Without patch 2/3 this counter does not increase.

I can add more match criteria to the counter next version, to better
check patch 2/3 at l3 (and l4) level.


