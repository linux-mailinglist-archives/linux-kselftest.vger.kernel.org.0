Return-Path: <linux-kselftest+bounces-43317-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCD9BE25B4
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 11:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB16D42163A
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 09:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178E0310650;
	Thu, 16 Oct 2025 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XoKCLfig"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C7F325496
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 09:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760606717; cv=none; b=Zi2y9IvdNcroFz3X3eetxmkpqQSoSQ9CodfYPrYSIWN8CmnXzv2kpCh6IZHSmJPW1Yqhc5K1+ygWLucRuk8NIqLva06fLfKLZPym+z1b8ys3I7PIGqvGpZbkH3qwCdyWqWTVNf4nnY3NZp355Bpb3qogsaX1MsQLKa1TP/Q0sPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760606717; c=relaxed/simple;
	bh=m2KeARvuTRmdyoLiLI4saJD6ImG7emQEBqfOCbuYQQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bcaWUzSZp00ERvJbAOGq59dmB1ldZrChZXh6t2HpbPAwh/vQHVfuN0FDfmwQisqyS9A+xaNSQWIfvV5Ko/H7KzV+YzHpYu1CeKooodP86KT6RenHI9L52ID6rEMA8OAUgCCrQuF0Fmo9q5nsTt71yg+EJMI6eSsMSMKBsiq4QIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XoKCLfig; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760606714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U6o+0dlH/LO6+L4uMhml00siHNkD8OlJHU5sP6Kvv18=;
	b=XoKCLfigCuDOIdckgLC0yYhjNUUXOLlE3GF4ejj5IuP40pJBmZb4vzY88S2hV/qDraTYUj
	V+3TtRszR+4Re0iyAVnIDgjdRsFntdChfwYFDIEFxaPntMtyx8/L0I8OKLAcE/AMNkBDlm
	ZYJya+NVz7q7212KoIAh7oF+XQvCKMc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-mDr8snUwPumrwp8k3E0WLQ-1; Thu, 16 Oct 2025 05:25:13 -0400
X-MC-Unique: mDr8snUwPumrwp8k3E0WLQ-1
X-Mimecast-MFC-AGG-ID: mDr8snUwPumrwp8k3E0WLQ_1760606712
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47106720618so9171985e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 02:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760606712; x=1761211512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U6o+0dlH/LO6+L4uMhml00siHNkD8OlJHU5sP6Kvv18=;
        b=srnzYiCQJeAy1b37ZYAptW4Cz53dLDKvjdRazi3JiTKTScfMtTrKI6WtOmohdeIahw
         k1u89/6kVsgRdvidoeV88JtMNwaMNOrMhvxG309+AqAL2eSGp9Nnx+2YKlBA9N1DuAEt
         xt0Hwilo3BS9jstoSuYq0BMWlbl082hxCJqFIRowOBDmNkpVy6Fxo0tMPKeBykb2CUZ+
         pXEX0yyyQkjyVM3Xg+Bv18wLLbxiTYXr7RWw//uf724LFJW21vMpfiXMblQZxyqwfIg7
         Vpo9VB3IYiJfjRexOh9WEF54r1hrOyXQUFfH5eCuSl5h7/mcK2fPn4c1HF5/Y1w3RMTL
         XPUA==
X-Forwarded-Encrypted: i=1; AJvYcCWkDXvXAC0RWX3xAk64PC8LLJlL2kegdq+AVLRedpkaCBIbtk4kxVogbsza4W3GSX4PNjiAtTh8DXZmM1w8zTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgZf3ayyvso4LH+QX1Z6dCuRDn0awfUhLhcJ5rHwJmP5fAz2GK
	0TM+hSLmy/+Fnyeg/jAG3gv/Ozk1GY2m6zmiWoplKrnmvMtcDr8aVqrCUSsZKjFt5cBeM+hMN1a
	04T3OCeJGBOnxjL+UjawBn+kkOXEPYm4Vka0k7zD7yWpS/mDnw6kt6G54QaIAndSFtLDiYg==
X-Gm-Gg: ASbGnctug56Dc9Qv84hYUy28bag2EHlZ9KoUxGCK+01cbrh/Pbg7Ak12WzFJ3r2WNSX
	H93sY+nPAN3mKiCR2DadQUw6BaFisKFHp+OaqYayefOi76fet8XXaFanNheb/5j+/gIKGbKnDvw
	HPXCMOp+UT13t3ZTcQ4ANfmtO/8YmfTwFsKn7YdOi0jM+LbQ9obzc8CYXBpLJLW/hqcsv2lT30s
	QAJ3OdusIRoFhOxvEn5Z8+eviy4UYU+xnuJ6xwX/WLewzDeO/LOGcraJW5Eed4dWhek3y8tKVs8
	06XCCwlk03DBGUht0txZRyxEA6pfhlRpjN8nOXhCwiIflS/NfclECazxCrdD+JYujOiEdq5dlUV
	KxQE6m0z+VjNo7AoyQih1HKFvXxUcnJtREHmcLULAM7Qw18Y=
X-Received: by 2002:a05:600c:8487:b0:45b:80ff:58f7 with SMTP id 5b1f17b1804b1-46fa9b16570mr237048555e9.36.1760606711782;
        Thu, 16 Oct 2025 02:25:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHODLXNXbl09HgER/Hf+hYD5m43sAstxJrTZCO15jaacFlZi4yisRDZcg7tAy/BjWtv6IsDQ==
X-Received: by 2002:a05:600c:8487:b0:45b:80ff:58f7 with SMTP id 5b1f17b1804b1-46fa9b16570mr237048295e9.36.1760606711423;
        Thu, 16 Oct 2025 02:25:11 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47114428dbfsm14687365e9.5.2025.10.16.02.25.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 02:25:09 -0700 (PDT)
Message-ID: <9ad5cdc8-c900-4ada-ba62-5ee313829bac@redhat.com>
Date: Thu, 16 Oct 2025 11:25:06 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 12/13] tcp: accecn: detect loss ACK w/ AccECN
 option and add TCP_ACCECN_OPTION_PERSIST
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
References: <20251013170331.63539-1-chia-yu.chang@nokia-bell-labs.com>
 <20251013170331.63539-13-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251013170331.63539-13-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/13/25 7:03 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 61aada9f3a6f..edfcce235d2c 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -4808,6 +4808,7 @@ static void tcp_dsack_extend(struct sock *sk, u32 seq, u32 end_seq)
>  
>  static void tcp_rcv_spurious_retrans(struct sock *sk, const struct sk_buff *skb)
>  {
> +	struct tcp_sock *tp = tcp_sk(sk);

Minot nit: An empty line is needed here.

/P


