Return-Path: <linux-kselftest+bounces-42146-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AA9B95677
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 12:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EB4B1906240
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 10:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD77317711;
	Tue, 23 Sep 2025 10:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OkowXnC1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C27F311583
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Sep 2025 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758622459; cv=none; b=UDDuE8SSx+N1BTtCLJIOwH6sq0D13+3j9tTvSI2tganOk5VHHiM4Fy7Vck09RmLLj02TgBMoZo3mN3j3fgQ4C33SXc81cVmvb49GOXEnOVF6fTmAtq1ABrydid4rzhxb3sNODZ71GajT2V43KhaAmxtYxHqq5g35IKk595x8xWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758622459; c=relaxed/simple;
	bh=PB7RTh2tkmTB3/Z3OmF5DIITDSFcvCKR9iFhCuOZMCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hNgz231qyxIoYOMiYSYXdygotZdcjPeE/uQepp0yXDzu4vwbEU6e6eHe5agQzDx4FrgnjcbYFSpZ8J0kA/blWJv43G8aKvMz+j739XGAUjPhmHiuUDAlAPrDg/lx4WnYSaJVKgHyHu52IE8H2W2oPHlXbkMDUCndPQ/iZGHUNsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OkowXnC1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758622456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xvoidjNPKx0LbqZQ6ZyfhvwOmvcCE/1oZtLmb8HEGok=;
	b=OkowXnC1OW0RKcegST2Ir2K+ZsPJ/CmhBLDL2jLRzey/+1DB6v1EsEX0skb8fWAz5tqCLD
	AzwkQ0I2Y2DprrESAs7g4neHEfBhox7PQTG63lM1kXtmsDXRL8zwCHTjL86nBJrtd/QLO+
	g9Ia7QjTVWcnKOlKVeWtf5XKWoID2DU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-btgOg_PRMz-h2PV086AWzg-1; Tue, 23 Sep 2025 06:14:15 -0400
X-MC-Unique: btgOg_PRMz-h2PV086AWzg-1
X-Mimecast-MFC-AGG-ID: btgOg_PRMz-h2PV086AWzg_1758622454
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45de18e7eccso25167495e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Sep 2025 03:14:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758622454; x=1759227254;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xvoidjNPKx0LbqZQ6ZyfhvwOmvcCE/1oZtLmb8HEGok=;
        b=Gt1SZ8KcGqa7d+UD0noSK6CV6gKpSiJhqMfzwIs/8IcpgdtKMbxCxuJKtzmbBEej2k
         sgpjhiFh8FqZ6/M2D4SHQGh4/d8MUz4I2b7tjUEOx+yojSBXG8z7fuiXjePueFI7WLC0
         OnNJ8Njt8CSqtDwm1uS6ku5YZD54Wx3myUATDfveIVyUfTOTCoq/ADEOTsKMl3a6ZPqS
         7C6/ghKF7TZ/LSDnh7D+tofQI0a8fr0ezw9oHHamsy9FKm3o+OE3ctVaB38a1+C7E5do
         4ffWQfrfU1OU4kemW6mdA9kNwb8Spyt7gz3UU4siNDKjkGt+UdRT5RuiqAQ6J+6ABbok
         IfUA==
X-Forwarded-Encrypted: i=1; AJvYcCUNZnLuZyuVUbW/mfcNt/1fqMEV58qAaZZDGt0FUXjXVYbJ68ujyVEdZilN5MjgUCw0uGDgK0pYIhw+RVYCv0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXbcBN/vOPyDBPV1ZJ4bNgjVnMIuCMeDYQyLS38VrLynhDiApB
	1Bf3iay/lGxzQSIx9+JiOH0cx3hK0R9ZgszYIFg7pd9obHwXlgJMPHVTQvBFlrurgcYGG3VIxVS
	pfYdj6kNTeDs6UWat5TPq44sCe/cqni9veEXcMLTI5XDJRt3WS3kwq900M/OGt/i6K61PWQ==
X-Gm-Gg: ASbGnctlPDFgZq77IS8ou9XQ3BQOTisikvG4Ktok//U8Npd2N+vf2DDBEyU/SZXzT65
	GAfgCqkTnpw0PH9yMwIV/bgJ1Uj/BFegSAH3v1wgv5AlSXaAhy0OZSF6CXV7vnU6uAZEeBDDBAl
	HLQKlOMfzTgyG5z531dIxDGmbdA26FxHYb9G+9ny+rwYagN9UfBO4pMPlvLx1C/lTZ5cIfLFjYA
	CkxNnSazTQSVscU6ELeI/HcrbHIn2JkacNmF0bi/EA4JkXgqIzPYJmFmrYO+K0YuT6ewjFdjuTv
	bcw3cs6i42hUKT9FP/DxCYkQ7aliUrgLF+N6/eAGBeymIrlbOWSQd8edBVtUM5qIOpE3jGdZgTP
	0j1Sax3K9tOwF
X-Received: by 2002:a05:600c:190e:b0:459:d451:3364 with SMTP id 5b1f17b1804b1-46e1dab8219mr23578705e9.24.1758622454126;
        Tue, 23 Sep 2025 03:14:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfxcysg2CPLWO7CKaUjf7VjUD/s/qwqr1QLzNIPiHoxbXJnS5UWMoepWPmpljqyYqsxssm0w==
X-Received: by 2002:a05:600c:190e:b0:459:d451:3364 with SMTP id 5b1f17b1804b1-46e1dab8219mr23578095e9.24.1758622453537;
        Tue, 23 Sep 2025 03:14:13 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-401d7fa1729sm5378032f8f.5.2025.09.23.03.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 03:14:13 -0700 (PDT)
Message-ID: <feca7414-31fc-4eb2-9b25-e8adc70c2394@redhat.com>
Date: Tue, 23 Sep 2025 12:14:10 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 06/14] tcp: accecn: handle unexpected AccECN
 negotiation feedback
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20250918162133.111922-1-chia-yu.chang@nokia-bell-labs.com>
 <20250918162133.111922-7-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250918162133.111922-7-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 6:21 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> According to Section 3.1.2 of AccECN spec (RFC9768), if a TCP Client
> has sent a SYN requesting AccECN feedback with (AE,CWR,ECE) = (1,1,1)
> then receives a SYN/ACK with the currently reserved combination
> (AE,CWR,ECE) = (1,0,1) but it does not have logic specific to such a
> combination, the Client MUST enable AccECN mode as if the SYN/ACK
> confirmed that the Server supported AccECN and as if it fed back that
> the IP-ECN field on the SYN had arrived unchanged.
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

This looks like a fix for an incorrect behavior introduced by a previous
AccECN patch. If so, please add a suitable fixes tag. We accept such
tags even for net-next material, and it's better to explicitly call out
needed fixes.

Thanks,

Paolo


