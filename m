Return-Path: <linux-kselftest+bounces-44960-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D23CC3AE13
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 13:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC57C500632
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 12:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABF3322551;
	Thu,  6 Nov 2025 12:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZa5AE1C";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HwRLewNE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1248E28B7EA
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Nov 2025 12:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762431711; cv=none; b=Ir0td7GFEZWn89OhCES4Qf7oBIgADocjuSAR0KpbvIwivgFhC0K8C6BDwy4/dYr4KjBIWQBsqGXTZFDGX91KR0pNTioMnUiZarbd/gUp/a+S26goB0qbvy0seLOa783t5AIHU6ANVlnzBk2DTOSPhN7I387aJXQA+uBrgv1aNC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762431711; c=relaxed/simple;
	bh=f6B/tbcYYNUY1cwi4BIgQgWXetzxYn720LqQVpZbrbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=C7L0ZmBoBihPz4EJdmpl00F4f1snaE8azc38kApPaNLN8kJPskc9UnTsT+jbhAvV4u9fQUJCPRvDghp0+fCqp55jVENF5FlY5lhlv6JCMSKMPq/QCgaqKYWrjLFqKv9lqSjQSRplx389eY3H9pgXttpgMDlnqhmIEbcrDfBeId0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eZa5AE1C; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HwRLewNE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762431709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v1N4Cl13V8PNbOQcEwPAAvE71VJRJZSQLqVmISUC4TI=;
	b=eZa5AE1C/cYEn3pnftu2tKCPblgDKDaAr/uXngjB7P1u8hcvrklzW+ddV3omHw44z2SCem
	58HNaEPS/gB+8cvTGIHCX+7auxIaz0Uj/sf165FlGrB0Aj2MUrnF8KK2SRgwawHgIGX6bl
	r1f6iwwMsbNgNXnj7Q7Q865lynuRiFs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-cKsPU-ZKODGtwVh35WCHOg-1; Thu, 06 Nov 2025 07:21:47 -0500
X-MC-Unique: cKsPU-ZKODGtwVh35WCHOg-1
X-Mimecast-MFC-AGG-ID: cKsPU-ZKODGtwVh35WCHOg_1762431707
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4776b0ada3dso82515e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 04:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762431707; x=1763036507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v1N4Cl13V8PNbOQcEwPAAvE71VJRJZSQLqVmISUC4TI=;
        b=HwRLewNEHvTqY7mk1cOBjONPVvLeUtdefBISOpQgzvn0qyupSNSPaog9I24ycLrsY9
         zETL4tv1aefjHExTqRCRYN7svJAg/Lf+0TLlFWFJcQKv7+M8U0i1DFQdP417eW/Tyy6X
         05WMJlb+XANCjkrlSR5nZspVfRcuHktdV9MkMnXv4EaLqLp4VnRXgnoWVNrur68Ppzun
         kHOfdWTpJpXEbc3X+8bLzKAKSGNRqK3vuhZXkaaqK3BtY5K7Aak1XrJKws62Co5jz1h4
         HuEpTQ4KlNnBb4Me1mhxT6jlniINN3hyeFeCmw5JQQ4I8i8I4+8aOuUhfl/JJL2zkHlS
         aB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762431707; x=1763036507;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v1N4Cl13V8PNbOQcEwPAAvE71VJRJZSQLqVmISUC4TI=;
        b=ZDQ125YOdNm3cFjHQcOqpK3rHfGAWz9S96ttBb9vnTCopEduZe5jfst5qG8yOSuwKC
         2110tEzdceZOOu0WzTwEV7FIHDdzt/FDBVtSwFOAVtZOBiGkpoHx1z4lX4mNGI1xmf5h
         2nnUF3y0KtZM0mttAIxgvmv0nbs3fS3QBi62mhHfHuXVMSS5vWlsts1yJCwwOqwqwnDU
         fzS9Zf5m9gTnLnr51UN5z1GzPqrrvkJ13lJC8BqV+pQ70EMKvQzNYztfWB6ZAM5721SI
         w/XclH2hDnO5JRjmaD5JAWk8I8RNtZD0kPdRcFPcbEymTK7ttttQG5fusewTYve67gto
         HuoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKw2+CYVYuCTT8DnYXQdXNS+jJN8K9BJuAEz7t4PCTzGKfhEFnNv/gHmdlOkOeqMTYJUzqUhXQPHr3jXCBsP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqcnmDe5J9eahNJlsb22WAKRbn3Tiiz3uGqH7FDnv6OfVEFv90
	he/Y/L+ydO48hab3HPV9Cqf27Qu/jYMdVYBHw9t4HE2j1Wou6+Od7AWjiUi7UEdBlSC08j8g2v+
	G09zwHUEc0zGXUroR1fLLRv+GFEd/c/KgNi5W+Uix6XhRvM9XCyhgdKSrxabyGlJ+YQmdqw==
X-Gm-Gg: ASbGncvBNnr1PN+4iR2/SXPHMdfARuuYo3xooM3rAcmRpf3PW2XgOm5gfPKiIwC9X9n
	nRO3XV8gh0B1bUiGtiQAdOFz/H2V7cqP1t39LhRpxvhEW4pV9qTwDi8hmJttdktLPWqAYirDTUR
	t2/KraTsLWBhBOg/rExRYNcpf+ozUDtYq1Db3PDXpWmXH12bYZhZ0VbellvaN4QnTkjECSGdKji
	azc0HgbUaX4hgu+3aunPQ0QIKVAcwiFQWGGUCSAO9jFODbO877FlQ2+VmAiMXHqyL7ywKaZbMQ8
	3EYJD6XqKL64TsgNGFl5gG/9NMBCS5iQ84mHrRZHJUJNRkOTvGznfyUMIwAk/GB7Zq7xtdVDRk/
	bDg==
X-Received: by 2002:a05:6000:4112:b0:429:9272:c1be with SMTP id ffacd0b85a97d-429eb151f1emr2335234f8f.8.1762431706690;
        Thu, 06 Nov 2025 04:21:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhC3gPHF44nNLz6WF4vQ+gEkHlkVJdaQMy0UYsfuedwouhI/V3U2psJ1S8t/e2gVWT4Gn96Q==
X-Received: by 2002:a05:6000:4112:b0:429:9272:c1be with SMTP id ffacd0b85a97d-429eb151f1emr2335200f8f.8.1762431706238;
        Thu, 06 Nov 2025 04:21:46 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb40379esm4634350f8f.9.2025.11.06.04.21.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 04:21:45 -0800 (PST)
Message-ID: <faea7f2c-f63f-4b0e-9c75-1e93fdee5811@redhat.com>
Date: Thu, 6 Nov 2025 13:21:43 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 13/14] tcp: accecn: detect loss ACK w/ AccECN
 option and add TCP_ACCECN_OPTION_PERSIST
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
 <20251030143435.13003-14-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251030143435.13003-14-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/25 3:34 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Detect spurious retransmission of a previously sent ACK carrying the
> AccECN option after the second retransmission. Since this might be caused
> by the middlebox dropping ACK with options it does not recognize, disable
> the sending of the AccECN option in all subsequent ACKs. This patch
> follows Section 3.2.3.2.2 of AccECN spec (RFC9768).
> 
> Also, a new AccECN option sending mode is added to tcp_ecn_option sysctl:
> (TCP_ECN_OPTION_PERSIST), which ignores the AccECN fallback policy and
> persistently sends AccECN option once it fits into TCP option space.
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


