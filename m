Return-Path: <linux-kselftest+bounces-44954-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC00C3AC6A
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 13:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2117E1AA5DB4
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 11:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF30531A069;
	Thu,  6 Nov 2025 11:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i255g/rA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PHLMlYjd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F6F3195F9
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Nov 2025 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762430192; cv=none; b=PVKhYq5s0orAmgx2E5BQnuuyV1eeACkreM7D/6cwtcVspHKRKHVTaFX2yt6vxyPp1LPYSdlcBZ/nUzgfjQkJTCm/KYD6SsHOivO3Cxz/I9Xl0cLr+L2VogdzVGsxoYQN3sNfCWOWhU8DsdUjrEhCLPowkMcCRlL1auVlkcz4uYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762430192; c=relaxed/simple;
	bh=YeroezC/007S9WCZ1zjfYLqrdykQ/FoCz8WVrVp3klk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NC4pKvIed3MrlndMqo5DYtJylLT/2oXPOUA/1IVBjAKx98GmtW2U+NKRSiAVrUvh88lMlARqYBFPNVs9ghlG392LCILk3E0XiPKCYqafwu8A308hEtlMMapCRIvXCd19oKAq2LhDt5Dwe0s+KFyZSlbGN8IUlJUfr6k/PGCU/MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i255g/rA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PHLMlYjd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762430189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9le/TR6EJL7OtK2G5F8XjAJfAro4XHRnCrWtY3w0ANA=;
	b=i255g/rAt5Udiq2NmpUpiRe5XwifmeLnjSRipbxVUjjGVi0ceXVVIRPNlPooyjD8Z5NAee
	m9kM572rZ4Yxms7i5jTISRBsIfKf8KtdJpkxWT2yKmZSyO9QgmPgo+MEHWA6pjgTPnPY+a
	NI9Pcw+G5/kJRK47BKCVO5y2u6gLfc0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-lo8Pw5EWPNirQsIzOWMpQA-1; Thu, 06 Nov 2025 06:56:27 -0500
X-MC-Unique: lo8Pw5EWPNirQsIzOWMpQA-1
X-Mimecast-MFC-AGG-ID: lo8Pw5EWPNirQsIzOWMpQA_1762430186
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47769a0a13bso2018635e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 03:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762430186; x=1763034986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9le/TR6EJL7OtK2G5F8XjAJfAro4XHRnCrWtY3w0ANA=;
        b=PHLMlYjdxUBj6bWlLwLy3L+PAqdN/yWe5NFwfbr/v7b74jWR9C0c8uRC+RGNgKtdZO
         mDBQTBUzwU7mhVOLX9x/jgK8k9blURU6S+X82n1DRDLaosRW7m6/SLbcYfIz5ozAIk70
         Ygtr5s6fgN5rrZM3YQlU+1r5rs8rUPlTV3xV5Ft0m4qfWQAImYfXQAtQn6YTLNdRhkkl
         dCQy5hfiSjnrlfAII/EWMrdXAkQ7BUhQp7exFi3PlAyZ4MxG6DFTfpWK+nZe/X0ogRgw
         3I7jgWVG6qen5ZQvtpwME8mu7+VAQ+1sK/dRNGBPRYsRnGJn1FcJJ76KWQPhEHlADMJ8
         5OZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762430186; x=1763034986;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9le/TR6EJL7OtK2G5F8XjAJfAro4XHRnCrWtY3w0ANA=;
        b=I4zcGhmiINBOJlWCUo9CyGa3BUYXglRHRKH6HaPD5X3/GuEjBVD+rlhlbIQ6XEeJpr
         XsixvgLZGrPp/w2DgLj9asH0rFkAM2q4LsoV5YXVcKaYFJlvb9aMJH/ryx4NYYFAvZPe
         OFb7CH58MuLpE1V5OukXwNt7UTG5SZmMgk/sjxWNbqzOPtQ0j3GudU8/TjTMee6X7Bt3
         MbAues/LOo7+pWXjI+HSMdKBbzSwuU+MK2t+/YHGOF33bJiLrejh9194Q/6UYeWv1YEd
         zo42fSPByoGNEAYFAwtyAqUV36FM/IdWJSEwD1d4KTfX7PpMxZOXGMqdHz8j2lU1hcK6
         KDEg==
X-Forwarded-Encrypted: i=1; AJvYcCU+yeLhagKzw6kjxWR9kDvAmLmITbdcUMr10Ar3yKUwOh4sMFqS6B4Do0BbaRoqf3K4nwV6wmpbHqxBmoHUby4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNzw1kGv3Ku/7X3QLLS7fDE9kWmb7RUCa4//705saWF8118JzI
	aIdz99rpjvmo8EG0aVYFurr32OuBbo3tdOlkVOqfVEDUqDwJ9Mhz+Q7cZjfWRFNqfqvO/jPsEqx
	0snrb+XuAMBBv82AJmOFn8oyMY2R+NwPVSag6/QpLlub2zqM58+kPLRIMKM1fBAO6Ox7X6w==
X-Gm-Gg: ASbGnctGFmH9ChD/sDPIqTDElznPtOxnkoNUEAiekLGtjCua1BfbgfFdfXvC4/A4VAt
	Xu/6jNS5HM1MECTAnE6CbAINWV9v3XE0CAbE+5B+LOpPxBB4JdBH7HmPXwFXcseMVNTgQ9+IUWV
	4oohtD54ZYaBbE+C1EaxFygYz4pSTWvAmsYp/2ttjHgzge6d6C9V/d69LCVbXVvjL8v+6VETX1v
	OSfgTerkgrIQxCjVFE427GiMCsBaesJ8Qala83ms7qWNM+9aKClU0hMN+KvqkU2qb4Vjm3vohIL
	cCiZGbfHlScMUi29pfSu2hlnSWwhS4ZK/rzw7h0lF3sH0ur2kMWPILfCRexkJt5sG43Rph7aGdi
	zqA==
X-Received: by 2002:a05:600c:621a:b0:471:14f5:126f with SMTP id 5b1f17b1804b1-4775ce206f3mr53397915e9.33.1762430186375;
        Thu, 06 Nov 2025 03:56:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeNjObPV82BW3NmBnsDhrNmHHpx+fbtiOXZTi7CtBgVaPdD09D56F002RyajJ9jcqH6Y5d4w==
X-Received: by 2002:a05:600c:621a:b0:471:14f5:126f with SMTP id 5b1f17b1804b1-4775ce206f3mr53397525e9.33.1762430185911;
        Thu, 06 Nov 2025 03:56:25 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477625eabf3sm55632995e9.16.2025.11.06.03.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 03:56:25 -0800 (PST)
Message-ID: <4eef8fe1-b2b8-47c8-a21a-bcb4b75c3a0e@redhat.com>
Date: Thu, 6 Nov 2025 12:56:23 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 09/14] tcp: move increment of num_retrans
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
 <20251030143435.13003-10-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251030143435.13003-10-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/25 3:34 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Before this patch, num_retrans = 0 for the first SYN/ACK and the first
> retransmitted SYN/ACK; however, an upcoming change will need to
> differentiate between those two conditions. 

AFAICS, send_synack is invoked with a NULL dst only on retransmissions.
Perhaps you could use that info instead? moving forward and backward a
counter is not so nice.

/P


