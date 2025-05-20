Return-Path: <linux-kselftest+bounces-33386-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B0CABD3BB
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 11:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAC361B634B2
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 09:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A10269AE6;
	Tue, 20 May 2025 09:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H20gj8sS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67156268688
	for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 09:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747734250; cv=none; b=k6qLKvLEgJs+zrTz+AM2Q39PCZSYTFk74Y57HCyD+xDrVcYthPAi95JGstM1JEf1YNOnxssG8wsXJrX8pEeDeaC+o9UjqmL1CQpviPwSNmAQMOrZkPycwoMYqHlLxw3FO6uIGNRKYpNtsN7S1D08oRfKJClQNhszdv/SRtrKpso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747734250; c=relaxed/simple;
	bh=GdfrJ9wEalOSO5bv0hmoFkzoT7yB2DwWV6SQJUpoaZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=M35QhkcNVbpZSLqy4o1SAd5/PiqWTdwtf8Yf8b0bIQpsGAJ+yGauQJUE+ERjzJDdhf8UqHKYWI9l1fgfsEu6JiVI2ujVRLU3F5WTRyz51DhVWq9zdjhFgAl38I015uhJUg+KM13Caw6MfEn3lvx5E5xSHspqlszAeFZ8G9DdMI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H20gj8sS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747734247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oVjYCglGOjhQOwhRRoCVF9gAuVp//nFBUyUL3xi0qNE=;
	b=H20gj8sSkKnuFQyMUepG6DhvAQXcSVeyQGpMPZexZDAIN+neRxihb5drYJtDAR7oPEdEyB
	p45hTz3bmuxLesJOOoixE2wRy3SO+rbGcb4IDJrcZr1OaanrZnruzldF5IQfc1+bfP55r4
	IsYzBDxeq1/kzYA2dk7SYTE+Sle/drQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-QbHpSbqOO4aUVTZaoV28Lw-1; Tue, 20 May 2025 05:44:05 -0400
X-MC-Unique: QbHpSbqOO4aUVTZaoV28Lw-1
X-Mimecast-MFC-AGG-ID: QbHpSbqOO4aUVTZaoV28Lw_1747734245
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a34f19c977so2560515f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 02:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747734244; x=1748339044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oVjYCglGOjhQOwhRRoCVF9gAuVp//nFBUyUL3xi0qNE=;
        b=rK70RkkNOvfh7XWfkeO0PPciXR8v8zWxsSNoJ1V4JXkNL0LDSJA0t7+7jfF/cI4ix6
         NsRuTA3oYh/V+jEs5F0a4PdQN6crUosyHVgmxF379Xru9plN9Vw0aKrijQ+IfTN8Acgg
         p0S7/8+GEx7+297Lr9KXUyrWegL0rYpFRCkpiEJiO+Aj4jzQDZbolRxXp8LjtMYYkTe/
         K0AAjCvShtIjk0vPHIbVYbpUsHBbOznYLJUGnC+uTT0mUC+xxsdq90eYuXoPZZGoy9Gw
         7gC+ymEBLHMN38HNEekVCKCsrONz2zl1ssX2A86xRkGIwX1hKF1W06N6pX3WCyrJynwr
         98OQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjfWpOebiBe48UQnnobt9kwIZsnwEIEFeRZmMaY1CMXEAn+B18DWYZJJIx2Gj4hx1HgbjfQ5EY934G/WYdpYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YynrWS/3n0EFOxooP39VYRhqg+dCZtR0k5BaXRyCb6h/2oZ6AiL
	OjLxMkDC95HljaIcs917VOA7AhylBoTYOHf6xwJC/4MyvO3IzQ4fifItbhbtWm5Q/Vw5Mi0A+sD
	rMzs2hUCuaw6VOZQHe/xYtOt4kGV0ddGg9l0aLZlC48n5IxENQrs7NtEkmUX4ODSF+ZkNNA==
X-Gm-Gg: ASbGncuI/KGHaQRNDq7yJKYoMQ2rYstiyH51vGvW2PQRBrwH8nJ+Kmd6m/gMO1+zwZE
	jzTugMNVl3gYm/8UcK1M6t9Z5f3aMq0bh8bjoGvMyJzgoinpdAc3CPsXfgjha0cPzyvTMMvegym
	kG0ZyaLd0P1uQFpMFq/0niY7idXoasHReD3xqPiF//1b6n5xnUivgk5Q7aBm3UjoEudDOvUqXqG
	ALosVsCxSEIp+gM8sMXN2GXWyQgRDUlKudxy4cmfWWdaTk8CzWSmFXtiHQkE4Ej8QfbYNg142Yh
	/alw1EFSlzpwrXHDxjyscZg2c/yH4Hg54guzzpN8BKtmgxrDz4E48ZUx7LM=
X-Received: by 2002:a5d:5f4f:0:b0:3a3:6d25:b8e2 with SMTP id ffacd0b85a97d-3a36d25babemr6669816f8f.6.1747734244562;
        Tue, 20 May 2025 02:44:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2oghOI8vAadYac9W7SXycaXiUvUjylnYzfxLoDCc2r39zb/TatFV5FbKXsSsW2LJtvpmuhA==
X-Received: by 2002:a5d:5f4f:0:b0:3a3:6d25:b8e2 with SMTP id ffacd0b85a97d-3a36d25babemr6669787f8f.6.1747734244185;
        Tue, 20 May 2025 02:44:04 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:5710:ef42:9a8d:40c2:f2db? ([2a0d:3344:244f:5710:ef42:9a8d:40c2:f2db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5a04csm15574156f8f.23.2025.05.20.02.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 02:44:03 -0700 (PDT)
Message-ID: <f0941549-904a-452a-aafc-f42763d13d9e@redhat.com>
Date: Tue, 20 May 2025 11:44:01 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 06/15] tcp: accecn: add AccECN rx byte
 counters
To: chia-yu.chang@nokia-bell-labs.com, linux-doc@vger.kernel.org,
 corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com,
 jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, andrew+netdev@lunn.ch, donald.hunter@gmail.com,
 ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
References: <20250514135642.11203-1-chia-yu.chang@nokia-bell-labs.com>
 <20250514135642.11203-7-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250514135642.11203-7-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/14/25 3:56 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index 779a206a5ca6..3f8225bae49f 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -497,10 +497,11 @@ static void tcp_ecn_openreq_child(struct sock *sk,
>  	struct tcp_sock *tp = tcp_sk(sk);
>  
>  	if (treq->accecn_ok) {
> +		const struct tcphdr *th = (const struct tcphdr *)skb->data;

Minor nit: please insert an empty line between the variable declaration
and the code.

>  		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
>  		tp->syn_ect_snt = treq->syn_ect_snt;
>  		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
> -		tcp_ecn_received_counters(sk, skb);
> +		tcp_ecn_received_counters(sk, skb, skb->len - th->doff * 4);

There is an identic statement a few lines above, possibly worth an helper.

/P


