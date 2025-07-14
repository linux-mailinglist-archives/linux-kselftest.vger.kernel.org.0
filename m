Return-Path: <linux-kselftest+bounces-37265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB643B04277
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 17:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 370667B1985
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 15:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D037025C816;
	Mon, 14 Jul 2025 15:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g2Hg7Lha"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A7825B67D
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 15:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505238; cv=none; b=SmCCSIbxaohZl+i/EUAJg20epr7Z2/Z0fTycdWWDouZNzBp6BUfuRSQEAg8yfl5xLlMwyexASzs0GLTaZ0irRZA2LGXprbB6LdDd5pDom2nPVkjg4oizj1y1y2UH/40e3wmOcqv3R091uZdn05Xnxa8UKgKd+GU1M0oGDuIsvBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505238; c=relaxed/simple;
	bh=IHKSZdBg3WcFhFDOVCLrgHqXdaBXMkfRz+CGmXp1u3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IIGpVqdHGrE8LSSgwuK6yVEr8I27uXtB0A9pf+lIUZK3+xnFoFpxcQnlxkrdZYk3/Z0Mppy3wC1LyISePa8vYIqrapkV3beF34OZTNEBmYI7rXy90EutAqBVCvEtlGjLvuLoEJxyZBxVAKy5i3jqiFwEhMKAxwcenvRJEjJ9J/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g2Hg7Lha; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752505236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aFwyX6lIQ0fjoLyREcaVc/pevM031iihhbAQ/uu7vB8=;
	b=g2Hg7LhaoorkpXnaw2qM8of+AUeF1I9XxFFUoUyqGOdeF0Kc0731bhBVde81Ek47nTGcSz
	oFWY80mLIgPtdGuwMI7H1HIpI0uzb6o0/y+KNp7o50XbW6rme5QSM/kNOmyGyyyxl3RsoS
	uAZB6tlhTHS50HyDCB9feHLh60BpRqk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-J6nQPJB5MNugFJ5Qukj30w-1; Mon, 14 Jul 2025 11:00:31 -0400
X-MC-Unique: J6nQPJB5MNugFJ5Qukj30w-1
X-Mimecast-MFC-AGG-ID: J6nQPJB5MNugFJ5Qukj30w_1752505229
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4561611dc2aso10817635e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 08:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752505229; x=1753110029;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aFwyX6lIQ0fjoLyREcaVc/pevM031iihhbAQ/uu7vB8=;
        b=kK2RSfXT1YwLtfG17450WvF+t4M1cdcNUmkVIbIMYT9OM6c3E+fu6vyL1DxOgl7CmD
         BLFKqlrF0sdUcctwKjqYBSvE4/R0WNYCOkz9ROJq2mrGqq5FA9AXIm2HJpApl2Kb4nmv
         pLkfB4W0LB608plg8j7LDocjZjdG1pAlT+KDSGad+fnYKtN/mEKDNTEor2LTFos4Mcp3
         mX1D/fo8+tZMl8qsmUDnDnZzQuSx/JGAhNFpyz7jgH1pM0WFtvaWzJprRDbpM+JuMDNJ
         0aftG8GijiyxRIqOh9Wb2xEOqPIdtWwxq0k8y5zFUC1kUkiTPe2xXzJRX9wmQwmAusyO
         DsYA==
X-Forwarded-Encrypted: i=1; AJvYcCVXw/JqlJSNUHHqcph8fg1sl5St5wSqzZUDymFjk6LI54zilbsxFrbQ3M4IJhNiZLFRgOHSyDcfxim+asJEQec=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPDBziE+bU5O4jaTx5j8ugZXSFyEnl44w/O+thJN2pdYmLDJ/4
	rhO9hN7IvZ2u5O+N1lIyFr/eNY+TvZtP0BaNVE1cSeIlMCgY94036r+nlGp2H6AXtglReMpEHoh
	0fF0bpbtUi3YdyRiQgAR63y9b2KNfuLi9I+d+T27/aBw5kCaZI6baBaHGSsUpAFdC7hCCnw==
X-Gm-Gg: ASbGnctRaseu1BgH6Qr+E+UxkWfDqEvM4MEJbKllxmNwBpzL7Ua+qdHwbO9ecHlR4ib
	A4Yf9M/qrRoO7DLuExzjvbNjWqkOe2Dwziljk+eK6Bt2c+yGVJ7Mwz44mno2ph7FWd/B9naqpkK
	bzMd0R6VCIfxBEdAriLBJsNwKxh7geV5aBCi/4XUkLcOI5YSl3atgGi51QH9Rf9j8l2VOzBgafA
	jRRM+iWDh1yJ5Y5XbRAQJN6AqYeFJxPFxzpDAqxrQ+FOYkmlyl0gpZM1Jw9JKJ3qMlmQsViqvP1
	2uywsUSvk6SBXglDGHDJ5m4OobCr1cDoA+tiHGMO/Z4=
X-Received: by 2002:a05:600c:37cf:b0:456:fd4:5322 with SMTP id 5b1f17b1804b1-4560fd45573mr66168575e9.11.1752505229171;
        Mon, 14 Jul 2025 08:00:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/DiiAZoBKMtGEbuxHY6nd18x8tIp6jAQkUUQbuvelaXC253z18SXm8PELPhx5Rs/OhWM7Ng==
X-Received: by 2002:a05:600c:37cf:b0:456:fd4:5322 with SMTP id 5b1f17b1804b1-4560fd45573mr66168005e9.11.1752505228616;
        Mon, 14 Jul 2025 08:00:28 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.155.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4560ddf5e0esm69819555e9.18.2025.07.14.08.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 08:00:28 -0700 (PDT)
Message-ID: <0e71834c-881e-4a13-a2c0-3443e2ab7605@redhat.com>
Date: Mon, 14 Jul 2025 17:00:25 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 net-next 13/15] tcp: accecn: AccECN option failure
 handling
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
References: <20250704085345.46530-1-chia-yu.chang@nokia-bell-labs.com>
 <20250704085345.46530-14-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250704085345.46530-14-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/4/25 10:53 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> @@ -443,9 +456,34 @@ static inline void tcp_accecn_set_ace(struct tcp_sock *tp, struct sk_buff *skb,
>  	}
>  }
>  
> +static inline u8 tcp_accecn_option_init(const struct sk_buff *skb,
> +					u8 opt_offset)
> +{
> +	u8 *ptr = skb_transport_header(skb) + opt_offset;
> +	unsigned int optlen = ptr[1] - 2;
> +
> +	WARN_ON_ONCE(ptr[0] != TCPOPT_ACCECN0 && ptr[0] != TCPOPT_ACCECN1);

You should probably error out from this function when WARN_ON_ONCE() is
true. I've no idea about the possibly meaningful error value to be returned.

/P


