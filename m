Return-Path: <linux-kselftest+bounces-31284-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5E1A9651C
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 11:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94F7A3BB020
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 09:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661BF20C03F;
	Tue, 22 Apr 2025 09:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BFu6p76u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840ED2036ED
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Apr 2025 09:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745315625; cv=none; b=f+XpFw9M5u5beaWlj+U8+4mX0BwtrMyXGRyTP28nW51Zzt/gkvgajaEL2Gj1JrrjV3NePGpmsphKSfELyIGvMpCVYcx05WJTD9i/V8KnH/lkAaCk5iypPAcWyNDfqiLjL78q9aS8xn5V0kyteCuSIuRazySfVCJ7tQSWeJVjP/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745315625; c=relaxed/simple;
	bh=DCc3yBCsqdPNNY2uSU0prMZ58cy7dzH4+00lcq9cFhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QQK/JQYFCX77SKeWG9RA66os2o1hgp2c9cW5ZOMAVAivt/uqrwhV4xMiSxF38LIf0otSzKC6h9tznGMxljdGgtsPAoqjoSIT588XUqODEggOA4ol2dJEuKPPc93+n9mDgPsVEcV/TVpVtDPn6UrIhLiRj7GjFyap8xZgXk+nbpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BFu6p76u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745315621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T+UqUh7siRWF1pR1SGVYCpepDRE8usjhEsgJtixBTFs=;
	b=BFu6p76uSXYUA/NXLiJVQ3Vv/ZN7rzDPuHp2xdxWX3alHYvWGLaFIzBHf+hhY+8grpbTMU
	fCQFNm0GdSwTlMTxfR1QxhZPEo2jj6ZkpQjgExQSxYd3qfVP8kHBO8qZ394bM4FdnMpJOb
	RQogrDVw+zZyE8xS+N9xBLcWnYdH+ys=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-6hdzZqkeNmycgYQ3gyVn4g-1; Tue, 22 Apr 2025 05:53:39 -0400
X-MC-Unique: 6hdzZqkeNmycgYQ3gyVn4g-1
X-Mimecast-MFC-AGG-ID: 6hdzZqkeNmycgYQ3gyVn4g_1745315618
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d5ca7c86aso27491375e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Apr 2025 02:53:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745315618; x=1745920418;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T+UqUh7siRWF1pR1SGVYCpepDRE8usjhEsgJtixBTFs=;
        b=ut22pPFWw/NLeH5d33W2D/80rFQrXyJr3R+sZSLRBs+cht17Er9V9JJ+S1SaKNu88r
         Wts683YouFBE6GWcYl+N6ftaw4fsReppQeJ2b2SoB4k+WS8Xe/u/CutR77ihti5vcWf0
         4G+rZhnlp/Hzj/3Yle54VZ5SOWVhnmk9I2A1MH8bbu4poJxcp1zgRXGuEZB6TvSYrDNT
         0z0yiCS9Q4iNnpgYcT9yf57MZJZD2TeJQulcZMzrVkhAT6Fiy9/2tju5lB2wt2RrSrku
         +zHgl8MUfiGE2ZI9WSNJCBYIHHDIvKmWJCVBceL4M6pqmGtqcFDDYuAlatyvf6eDrJmS
         B1pA==
X-Forwarded-Encrypted: i=1; AJvYcCUQWyq/QxDA6YIVaigoyd8Qutw75+jpziMHR0xdebqqmdIIpLAJlBZSjKNToyVZCbgh6IuUH3Tl5PzxNLEQw/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8iC/76d5ALnotKJmjM8EvtTdpDiVcRNFxdb+CWBIIyMpjuy6/
	rl+J7X20X4facDrWm2Td6q+gTHT7e4PjRneT5ZjwvRh1ABoRE5+iTocsdi6j3FMaz3AqznR6hJJ
	Nu22+jV2A5s+xKaBuTFagXcvvXa+DOFakY4jNeXN4n9OXZ7vNAGTPHGzf+dX1Olg2Lg==
X-Gm-Gg: ASbGnctMjSJUkesKxiDAfbXlmOhN92Npdau5GpJte51h12vQo8iW5hOdpxpEtuMQocs
	c5gVlfS/R8D/Bo49byyQb6yBW1kBsZf3JV0SF26NiMIpgIRpOGotX825AT3NBLdTdDFRvGV0b8t
	ToOSqY9KUpjiNO/M19Ex34fqh1Tt5I19TT5tpIvHg8lmgAEBHQT2MnAx5Ga70BiebLS7Qatg2GY
	LfsDNyfgXRnzQMxMFqbSP0hOxHVKIkNhPamdw6NER8FQz6IVj3KOP3u4TmdWm4BdaPnjrkTqbn9
	sk9vmCakXy1qPyHk9urhLZvUBATCF2qTd5B3
X-Received: by 2002:a05:600c:34c1:b0:43d:fa58:81d3 with SMTP id 5b1f17b1804b1-4406ac227fbmr122446045e9.32.1745315618202;
        Tue, 22 Apr 2025 02:53:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELd9y2H3dCrtLmR1DIRKBH11l4OEmiZ2yNoBIf8u5QiIP6XTBXHDW0/0UXfmKoS/09wAj4Bg==
X-Received: by 2002:a05:600c:34c1:b0:43d:fa58:81d3 with SMTP id 5b1f17b1804b1-4406ac227fbmr122445785e9.32.1745315617831;
        Tue, 22 Apr 2025 02:53:37 -0700 (PDT)
Received: from [192.168.88.253] (146-241-86-8.dyn.eolo.it. [146.241.86.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa43ce6bsm14756493f8f.55.2025.04.22.02.53.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 02:53:37 -0700 (PDT)
Message-ID: <949655cd-4690-4513-a24e-7f1e035425b0@redhat.com>
Date: Tue, 22 Apr 2025 11:53:34 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 net-next 1/5] Documentation: netlink: specs: tc: Add
 DualPI2 specification
To: chia-yu.chang@nokia-bell-labs.com, xandfury@gmail.com,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, andrew+netdev@lunn.ch, donald.hunter@gmail.com,
 ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
References: <20250415124317.11561-1-chia-yu.chang@nokia-bell-labs.com>
 <20250415124317.11561-2-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250415124317.11561-2-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/25 2:43 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Introduce the specification of tc qdisc DualPI2 stats and attributes,
> which is the reference implementation of IETF RFC9332 DualQ Coupled AQM
> (https://datatracker.ietf.org/doc/html/rfc9332) providing two different
> queues: low latency queue (L-queue) and classic queue (C-queue).
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  Documentation/netlink/specs/tc.yaml | 144 ++++++++++++++++++++++++++++
>  1 file changed, 144 insertions(+)
> 
> diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
> index aacccea5dfe4..0fb971935285 100644
> --- a/Documentation/netlink/specs/tc.yaml
> +++ b/Documentation/netlink/specs/tc.yaml
> @@ -816,6 +816,58 @@ definitions:
>        -
>          name: drop-overmemory
>          type: u32
> +  -
> +    name: tc-dualpi2-xstats
> +    type: struct
> +    members:
> +      -
> +        name: prob
> +        type: u32
> +        doc: Current probability
> +      -
> +        name: delay_c
> +        type: u32
> +        doc: Current C-queue delay in microseconds
> +      -
> +        name: delay_l
> +        type: u32
> +        doc: Current L-queue delay in microseconds
> +      -
> +        name: pkts_in_c
> +        type: u32
> +        doc: Number of packets enqueued in the C-queue
> +      -
> +        name: pkts_in_l
> +        type: u32
> +        doc: Number of packets enqueued in the L-queue
> +      -
> +        name: maxq
> +        type: u32
> +        doc: Maximum number of packets seen by the DualPI2
> +      -
> +        name: ecn_mark
> +        type: u32
> +        doc: All packets marked with ecn
> +      -
> +        name: step_mark
> +        type: u32
> +        doc: Only packets marked with ecn due to L-queue step AQM
> +      -
> +        name: credit
> +        type: s32
> +        doc: Current credit value for WRR
> +      -
> +        name: memory_used
> +        type: u32
> +        doc: Memory used in bytes by the DualPI2
> +      -
> +        name: max_memory_used
> +        type: u32

Here and in other numeric fields you should probably want to use 'uint'
type, that will allow either 32 or 64 bits integers depending on the
actual value and will make possible overflows harder.

> +        doc: Maximum memory used in bytes by the DualPI2
> +      -
> +        name: memory_limit
> +        type: u32
> +        doc: Memory limit in bytes
>    -
>      name: tc-fq-pie-xstats
>      type: struct
> @@ -2299,6 +2351,92 @@ attribute-sets:
>        -
>          name: quantum
>          type: u32
> +  -
> +    name: tc-dualpi2-attrs
> +    attributes:
> +      -
> +        name: limit
> +        type: u32
> +        doc: Limit of total number of packets in queue
> +      -
> +        name: memlimit
> +        type: u32
> +        doc: Memory limit of total number of packets in queue
> +      -
> +        name: target
> +        type: u32
> +        doc: Classic target delay in microseconds
> +      -
> +        name: tupdate
> +        type: u32
> +        doc: Drop probability update interval time in microseconds
> +      -
> +        name: alpha
> +        type: u32
> +        doc: Integral gain factor in Hz for PI controller
> +      -
> +        name: beta
> +        type: u32
> +        doc: Proportional gain factor in Hz for PI controller
> +      -
> +        name: step_thresh
> +        type: u32
> +        doc: L4S step marking threshold in microseconds or in packet (see step_packets)
> +      -
> +        name: step_packets
> +        type: flags
> +        doc: L4S Step marking threshold unit
> +        entries:
> +        - microseconds
> +        - packets
> +      -
> +        name: min_qlen_step
> +        type: u32
> +        doc: Pacekts enqueued to the L-queue can apply the step threshold when the queue length of L-queue is larger than this value. (0 is recommended)

Typo above, should likely be 'Packets'

/P


