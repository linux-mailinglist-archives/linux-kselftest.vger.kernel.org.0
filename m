Return-Path: <linux-kselftest+bounces-35679-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE32AE632D
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 13:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BEC13AF92D
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 11:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A287E2777F1;
	Tue, 24 Jun 2025 11:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TSnSoQAm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277F0221F17
	for <linux-kselftest@vger.kernel.org>; Tue, 24 Jun 2025 11:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750762917; cv=none; b=FEfzG2fooRcTw6p5JxGZssCa45xnoPahHHPdb7ZXd+/KYyb2GPyvSTUUeywZFRFjz72Kp2xBARXsrENrN/BvgXaYqoc7aey8lC9lPpjBF8a6jjC43xGpvU+Oz/06wWB5GC4tBtCTXVWLrRiyyKHPu1v0eeBt2r6PKcxZKVS2/Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750762917; c=relaxed/simple;
	bh=GI7a4iR+LCdE9iTrNoclJaOJLfBAij5Trf5KhJb+XAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=P4nnZ1IsLEqGB4ayC8xzKXap0Ai6snAnc6GH59qHu5VgrCuOXqnkAxbi/RrijWYucEgA0MWCvXopunRbI7Swgz+BJMmtURjPN+z5VEecNi2c9icrN73FcHA4ULwssz0cE3CXMyu5dses8tAnxcoeAqWJT0gZAJBS7MScs5HBj2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TSnSoQAm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750762915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5WrfMksOxB0G9GSe2G8W4zx4JfvBQpVqOPDOrmuF3RE=;
	b=TSnSoQAmtMcK/0B9MzYJMrf7TR7PNW9ghgceq6NsM0+idMR3KdWp2pzwyyxFF/1F8BzyF5
	QBb8meqOgx3UiT7kIRE3FDX4RHodEE19PscL4VgIdmIzd01nrZtZa+CmhZm9Zdg8nIUGcx
	4JFKai45G3NUl7MKWha1LRDMiSz0tyI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-KBX4wGAZOKOfkxUCpImQwA-1; Tue, 24 Jun 2025 07:01:53 -0400
X-MC-Unique: KBX4wGAZOKOfkxUCpImQwA-1
X-Mimecast-MFC-AGG-ID: KBX4wGAZOKOfkxUCpImQwA_1750762913
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f6ff23ccso207041f8f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Jun 2025 04:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750762913; x=1751367713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5WrfMksOxB0G9GSe2G8W4zx4JfvBQpVqOPDOrmuF3RE=;
        b=N3SVo3BQl6h15B5AbyOHdqANDeUWvan9Pt8WIqqSEvf7gr/Zc1+gAQzh9oymxB3PxI
         TYCtaZKvT5mHgX2X9cNZ5sB+FMxDqyZzmRTCQ19/vAQR1ORF4fmo6zJNGj46CQ7Q2qiL
         NzId4ldDm+qP3CXYAdOyjKDOxZ9mTsNRXE1G/AulnGLGVvGTnYETFFEBtdbuD6n+gfqA
         QmBmSGbgflVgCmSFEcXZBL0bBUaVqescY4tLfilVZct0P0RHSlqYAYYpPp8a3i3WGa5y
         Ow5Uy1FWgzfj1B5c62OFC6+8u6wdbIaEudzmm1tmGmRsj1ZtZ8sUyFPFTiw7Qt0JV8bf
         Dtsg==
X-Forwarded-Encrypted: i=1; AJvYcCUbm7ioeq0npuauSD6KUDEzo4PFE7PYrPfxCpu0Fa1rvYqpVsLJ6UcXB/w2iu3a4OGjZzhncP9sEr/vbZumqsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLFDBZmC8ScVAWhb3duWSglmpGkHIOuYaxKHRPRxyqepANMI5l
	nM8WZtXYtMphzWZEMppxQbd//ro9lEI/46Wnh32Kgxx1Dqv6g/ZaFxvZkHljvbEEcad5OhbJXNu
	XYOY/l2XUzgUv/YknSUrFe5a76awZGWyV6wUXIe/vR+04O38KiSzmSGGTpiS5HEGIFYCHAQ==
X-Gm-Gg: ASbGncv1pclztWbT7h36RVhJZwdOYaqLGlO9Azv5hIhCTWGN+RhAYbUJaAj7AjTsccp
	h4lNRknLQIFzIVtcueuX7i/ojfMm0wbM1D8HKOoI+WFJQ9gooNXsTkAzYCyGoivbUjJQvU9JsrT
	K7Y72/lf1CnOqhSSMuiVO7oc7AmuDqBgCCGMH//bPaz9YK3hDbKTbAhcFhQJ2MaMcu8f4VEUGAo
	x37YscRKQpcjoArSBPLoZOXyKy00AP+wuxp1X8Ospxo0kMjlQ1SZspTZcr+S9FLkNnM8qXafCrk
	wIxOt9F8EXceyVoQxdi9BifldHPBHw==
X-Received: by 2002:a5d:5f82:0:b0:3a4:f7e6:2b29 with SMTP id ffacd0b85a97d-3a6d12bb560mr13887373f8f.5.1750762912305;
        Tue, 24 Jun 2025 04:01:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbc3G2xwmW0Oe4vryhFRrLeFBAo0H3LJ7tnjE/h1ipMaX9PHwE4uPVzYLosVI0SGtoOOvt4A==
X-Received: by 2002:a5d:5f82:0:b0:3a4:f7e6:2b29 with SMTP id ffacd0b85a97d-3a6d12bb560mr13887269f8f.5.1750762911445;
        Tue, 24 Jun 2025 04:01:51 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2445:d510::f39? ([2a0d:3344:2445:d510::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e805174fsm1665923f8f.6.2025.06.24.04.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 04:01:50 -0700 (PDT)
Message-ID: <926fd938-700e-45a6-928a-34a81d0c231d@redhat.com>
Date: Tue, 24 Jun 2025 13:01:48 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 net-next 1/6] sched: Struct definition and parsing of
 dualpi2 qdisc
To: chia-yu.chang@nokia-bell-labs.com, alok.a.tiwari@oracle.com,
 pctammela@mojatatu.com, horms@kernel.org, donald.hunter@gmail.com,
 xandfury@gmail.com, netdev@vger.kernel.org, dave.taht@gmail.com,
 jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, andrew+netdev@lunn.ch, ast@fiberby.net,
 liuhangbin@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20250621193331.16421-1-chia-yu.chang@nokia-bell-labs.com>
 <20250621193331.16421-2-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250621193331.16421-2-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/21/25 9:33 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> +static u32 get_memory_limit(struct Qdisc *sch, u32 limit)
> +{
> +	/* Apply rule of thumb, i.e., doubling the packet length,
> +	 * to further include per packet overhead in memory_limit.
> +	 */
> +	u64 memlim = mul_u32_u32(limit, 2 * psched_mtu(qdisc_dev(sch)));
> +
> +	if (upper_32_bits(memlim))
> +		return U32_MAX;
> +	else
> +		return lower_32_bits(memlim);
> +}
> +
> +static u32 convert_us_to_nsec(u32 us)
> +{
> +	u64 ns = mul_u32_u32(us, NSEC_PER_USEC);
> +
> +	if (upper_32_bits(ns))
> +		return U32_MAX;
> +	else
> +		return lower_32_bits(ns);
> +}

Minor nit not intended to block this series. If you have to repost for
other reasons, please consider dropping the 'else' statement;  the
alternative is IMHO more readable.

/P


