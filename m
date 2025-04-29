Return-Path: <linux-kselftest+bounces-31899-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DB2AA0E57
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 16:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F40E48117C
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 14:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BCF2D998B;
	Tue, 29 Apr 2025 14:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjVlKyBQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17682D92CB
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 14:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745935721; cv=none; b=iBMisIjhFQtWbzRVr2B2dkWzkIj8ZeE9SA5qtUMdGaHnalbpa67qRTKYqWMAQnxCaXwjGXe1YHJZO4klMBN1TUozVCaIhoiWzKAROp7w1MNHJIk9oxplnS3Frhbg/LKQwZrTfG4+1gj9jz5bGFCXZjC8WicHYRmy3LjNaRckGBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745935721; c=relaxed/simple;
	bh=ha8igNbGM13aMHaHrQdfISRaLlgwfMIsDFvz65727oY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YdQxXkxde3/E2ztdgPPqJe7h6btxNNGC2iRYkdB6xo2k470Bb38EbgiILtg4OVawh2mUlDxq4ZcYmORiyD2nCv6CTKNApH/+9IBWDKCt91t26LgBbXMY+wMRl+6uZt2tmW0BS5OmYiTl9HOv9hB4GT8+rkEFIOF2uQV7CBLERSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WjVlKyBQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745935718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=suG985EOjCX8biycL8J7gZpWEOyx9rBhI4py/TvWT9I=;
	b=WjVlKyBQ+pKrx5KqjdrIG+EQbwvH2WxMmFynX8IqMD/2MZ6e+H5TY1ltmF8NMq6cOQfz7E
	yNlUtNUB8X3cnoTlys8qccxd0tH9mnAdoquWJ1a3AUG/qV09+Xx+SLdXWHF1iinBe96Pfr
	FPD/EQqB9pSb0qRdvQwEH5K5nrBh9I4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-npq9BAqWMPqWAjDNNV52cg-1; Tue, 29 Apr 2025 10:08:14 -0400
X-MC-Unique: npq9BAqWMPqWAjDNNV52cg-1
X-Mimecast-MFC-AGG-ID: npq9BAqWMPqWAjDNNV52cg_1745935692
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac6ebab17d8so431662566b.1
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 07:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745935692; x=1746540492;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=suG985EOjCX8biycL8J7gZpWEOyx9rBhI4py/TvWT9I=;
        b=HpzMu7Mei++gzS6K24yETuLdsnUzXA26PX59EDbmpyrOkeWPEzd/EBDicHGEiyRgNw
         lpyIlIVzejG845gCHlVKtgWugMBUAim/WfhR3sCv4zi+FRlI4ew1Bx271lIVQinoN+f6
         g5EGX1EsTSmGrGc3B1Ys4BzRxdtDrYyaALtef9s7H7H82zowvnT/9hPZkyZjMuZXzLfe
         GjI+b/hw0Yz0n1t+Yk1gDhEysx5TRU6bUCA/PkDGE2NExkXF1ZsflT3xij48PLzJ0YrB
         7opAdgwSTiWQSUcmy1tQLNARUTz6Xu3XiQKCdV4Br0ZOxcFsbv/fWnpDk5u2yk5hkaEF
         MInQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4nHYwx7m/gKhhLbmmrqYrR1X7EUQNLtCGw4GwqoXUE3p+Dn352+nzy4vD4H0U99B11JawCJWDg7Edjko0Bp0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf5AfIZOxLga8v0xL2kNoBbHe4Ew/rsEJGAA5f22pl1vv2SXh2
	93wW80Ju2jWbK57PW+VKUGG1PYAVQQOsthQSMcBOUVpTTnCQhF8CHbpR0gCuvtmtVXRvoHdYvy1
	xon7hV2o6V2WTFb/Cc36+lcG0q5uJfVMsTyVkZ4GUMD6dhixl8lAR8Ju6lLVppNnwyQ==
X-Gm-Gg: ASbGncvGEyYqyiIZMk7CvfxXolk9fdSJrj+nIkRRah7sKNo0/nKfHGUDOpFhlYZiv6g
	mUnGUC5jwuDIK2NEw+lyYbRKKJEU+B88hNGG+JcYLeXD33U0DAJSXROxAfe1TRBAeBpZqpNj2In
	FhtIIt116SuHocqXVMo5K7oKMCP5h0Eyzn8Vnzq1/p0GNXOXMPeJtyQz11z3XH+HKeK/6LCNGCN
	oRpOf+anY/FO9JCqGk6HgqT21zBEEnUg4AAcULZueD2bArn7C9xmFH4fJM9v+orre3dlbCZ0vzf
	yOrxI5eN5/gq07DQKFI=
X-Received: by 2002:a17:906:264d:b0:ace:d710:a8d1 with SMTP id a640c23a62f3a-aced710ab95mr45807666b.24.1745935692469;
        Tue, 29 Apr 2025 07:08:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0o5uLI0ku+DTzc9hke4sQ0b5ZTjR+yED75DjtR+K5/25/riwLVDPh0sFesxL/FxQTYulrqQ==
X-Received: by 2002:a17:906:264d:b0:ace:d710:a8d1 with SMTP id a640c23a62f3a-aced710ab95mr45803066b.24.1745935691981;
        Tue, 29 Apr 2025 07:08:11 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2726:1910::f39? ([2a0d:3344:2726:1910::f39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ed7205dsm777011666b.156.2025.04.29.07.08.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 07:08:11 -0700 (PDT)
Message-ID: <eed29236-f238-46c2-a60d-fbdd3955dc99@redhat.com>
Date: Tue, 29 Apr 2025 16:08:08 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 11/15] tcp: accecn: AccECN option failure
 handling
To: chia-yu.chang@nokia-bell-labs.com, horms@kernel.org, dsahern@kernel.org,
 kuniyu@amazon.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 dave.taht@gmail.com, jhs@mojatatu.com, kuba@kernel.org,
 stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20250422153602.54787-1-chia-yu.chang@nokia-bell-labs.com>
 <20250422153602.54787-12-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250422153602.54787-12-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 5:35 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> @@ -555,6 +556,30 @@ static void smc_check_reset_syn_req(const struct tcp_sock *oldtp,
>  #endif
>  }
>  
> +u8 tcp_accecn_option_init(const struct sk_buff *skb, u8 opt_offset)
> +{
> +	unsigned char *ptr = skb_transport_header(skb) + opt_offset;
> +	unsigned int optlen = ptr[1] - 2;
> +
> +	WARN_ON_ONCE(ptr[0] != TCPOPT_ACCECN0 && ptr[0] != TCPOPT_ACCECN1);

This warn shoul be dropped, too.

/P


