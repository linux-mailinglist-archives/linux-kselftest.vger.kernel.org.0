Return-Path: <linux-kselftest+bounces-44944-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC300C3A79E
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 12:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC133B90D1
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 11:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0031830C60B;
	Thu,  6 Nov 2025 11:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TSVNapcG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="R2lq28WY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FB02E7F02
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Nov 2025 11:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427297; cv=none; b=bJO4sbfZNpgzb3qUvng6PS1l7TCUt+2ChGxp8sDknI2xhlyxoE4E8Dm46KmYSFk9WKglaEnXqKFTLxz6B2ZBAiUYHdbzN5pR9HUhPYIDBM1ppR6gfmZmz0ixqWRT1WLFutp1xdndzolS+DbEZL67ul7CnOn9kpKfNLaiUKAk6B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427297; c=relaxed/simple;
	bh=AzYwnHKc/M/GnwP2HQJVj7gqwdd7tzGdSNwpt2uNAzU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=B95quj8lhod7RvsOkQjv1nw4X+nEzpo12ihEGi0Zo0IEyT2Uqpok8vB08xoIbiLCoWCg0VxA83r8aQOkRiMmQjVjIRCnQO5fAz/pAy6cDFFj4XSdIrTIVlgTJO9hnQz8QcsvtLSS7yMXRKh6cHExLlqMCRsCj9LyBC3YbNBRmp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TSVNapcG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=R2lq28WY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762427295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mJ9H3vt04iE1iOinRpVRRRwRwQxVn8Vs66MDAfX+ERc=;
	b=TSVNapcGDmyPB2jwD/9JSpLNhUV55SLy2LPg9wBg/9aSOSxtx5nz2Elw11i0JtSCrZZxgG
	axpx3Dbmm3izLjQKGADFF6p00YEwGmyTCIUt73DVQbsq+j/MLx969sByH7KmOnHUv6KoPA
	gEdBNy9Nm/ilIswpiMnfri4k1gSGRvE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-0Fnj31ZXMiqUv5d6mJSh_w-1; Thu, 06 Nov 2025 06:08:14 -0500
X-MC-Unique: 0Fnj31ZXMiqUv5d6mJSh_w-1
X-Mimecast-MFC-AGG-ID: 0Fnj31ZXMiqUv5d6mJSh_w_1762427293
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-428567f67c5so524545f8f.2
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 03:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762427293; x=1763032093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJ9H3vt04iE1iOinRpVRRRwRwQxVn8Vs66MDAfX+ERc=;
        b=R2lq28WY71t81pdM6VYa4o9Q/ONByehnoGu+vkqLxavia9JYZP9JbUfv9c6eLpVqpB
         ysLmKDK1iCq0OSGuMLU2Bk0i48BRxZNEfk7ZYP7lpNQE9d3K80xa2yFSVamRobuFGTRN
         aqznr6kyHKuPFlJwsjfFNz/FmMGTNRfMzfbRLnx2yse6zV9RbKnMXsFfw6QlLp6Xc3O6
         hM6zejXy1Tc2cO2dIsmnhzym5dHwrxmwDdLrX6EI0HdEhHnpy9BRR+z1s3jSrJK/yvW/
         nWXb5mnb6TUS8bZq3N/Bui9UieTCDHjORqC1Ltb2AvPHNTRgLB4PlYaq4pibBzva0mle
         N2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762427293; x=1763032093;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mJ9H3vt04iE1iOinRpVRRRwRwQxVn8Vs66MDAfX+ERc=;
        b=p0UqTsvWeSRMLGJOQah4/M6CozJMH/AxI90RyL3PF8jOWrNsruTv2S56Nl6DUfdWYz
         CJYb9IXTrZCmanBBOyn7xWRhzu/ITXlgyOTqc0qqAPqMPaaLHTgPAcv5cm0J8XwmExHG
         b8WyuGjScJHfHRammIpJ6JfMO+mck2CVDMVDAOBX3dB6vMG+uxjuAi/Q9yULxZ185dSz
         e6n31bEcMa2WbTBX9Akh0PlC6eCfBARRzU2cbK5AYBErD+xoL5y5cgPP1h9izkiocVXr
         mR3x105A93jZn5LWFESjQLx+pA73eZ+WmCCmb2yUhvV8QZctPvTOrwHsGR4i8nzJ84tP
         uvLA==
X-Forwarded-Encrypted: i=1; AJvYcCWIPsmRpBlzOTQq3nCclwI+d+O5DPLJtibNCI3neJxfs6r+NNWUO35JKY/h/KWKV+8d1+rwGbSbX2Gk0Ezswmc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4tHDr6hz8X+x+HXHTfxWAogbErof1qtVgRINQCW1w+KANMBWj
	2N28QOicRzOA/tNZmc/DIY+PyZtyIhbQoCWqWINfIrhU1L/TiKoLjXEzmN8Z8EcaeycxB9t7Z+H
	jMuvRewLzZjh6NchTMaWn0gBUE7JVR7yVyTWhlPsyeDmFiz3LA7QsQGiePvXS2RXaWLGKUw==
X-Gm-Gg: ASbGncte3pg8OFtTA/TKWcv7filq5o1t6/ymDdAejuP7JO+Ld1wi9093lwBnAHl8NQk
	LGNYYaEamuvTJIcjsuEGmTQ5Ec9oCyC3pXVEBXE1okrv/BMmvyTBrsr+sHtX5QfCJyC/h5V4zGZ
	zqI2OUoRFZ+TpZA1I4neL99IblgDcQAifXhEuQ7vT3sK0sj4Jcwek93oxc7l4GZSFh2GhE3Gvdm
	QcJidrNGP2Hp2PYNhanahuZDCnLbRL4vQX15Go4+E/hlWJt6vqsHNaDWzyf9lr6Sj/0BJJb0Z6Z
	t4JyHlofFION4ccLrPRljPT5Zf1HyjShfD1oPlKnNEnxXSpoPK49jcdVWmCZn9Wz97b3dvBqt59
	f5Q==
X-Received: by 2002:a5d:5f87:0:b0:427:64c:daaa with SMTP id ffacd0b85a97d-429e3309a36mr5941974f8f.44.1762427293032;
        Thu, 06 Nov 2025 03:08:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEd1vm77ZDhKKFmGLmtogps8up+77Qdb9bBoLD/2VxY85lZ0MG6jm4vBI/942lqkDDMsGcznA==
X-Received: by 2002:a5d:5f87:0:b0:427:64c:daaa with SMTP id ffacd0b85a97d-429e3309a36mr5941919f8f.44.1762427292510;
        Thu, 06 Nov 2025 03:08:12 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb477226sm4275998f8f.24.2025.11.06.03.08.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 03:08:12 -0800 (PST)
Message-ID: <8ac38ae2-74fc-45a1-88fb-4edd124ab9c3@redhat.com>
Date: Thu, 6 Nov 2025 12:08:08 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 02/14] gro: flushing when CWR is set
 negatively affects AccECN
From: Paolo Abeni <pabeni@redhat.com>
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com, parav@nvidia.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
 <20251030143435.13003-3-chia-yu.chang@nokia-bell-labs.com>
 <8ad4ca21-5b81-415b-b16c-6cc4b668921c@redhat.com>
Content-Language: en-US
In-Reply-To: <8ad4ca21-5b81-415b-b16c-6cc4b668921c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/6/25 12:01 PM, Paolo Abeni wrote:
> On 10/30/25 3:34 PM, chia-yu.chang@nokia-bell-labs.com wrote:
>> From: Ilpo Järvinen <ij@kernel.org>
>>
>> As AccECN may keep CWR bit asserted due to different
>> interpretation of the bit, flushing with GRO because of
>> CWR may effectively disable GRO until AccECN counter
>> field changes such that CWR-bit becomes 0.
>>
>> There is no harm done from not immediately forwarding the
>> CWR'ed segment with RFC3168 ECN.
>>
>> Signed-off-by: Ilpo Järvinen <ij@kernel.org>
>> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Please provide a test/update the existing one to cover this case or move
> to a later series. Possibly both :)

Whoops, sorry. I'm looking at the patch in order and when I wrote the
above I haven't seen yet patch 4/14. Please ignore.

/P


