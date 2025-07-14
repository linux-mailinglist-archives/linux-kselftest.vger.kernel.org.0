Return-Path: <linux-kselftest+bounces-37266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71522B0428D
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 17:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2288F1688D4
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 15:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157692594AA;
	Mon, 14 Jul 2025 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TXmG339X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18D12522B5
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 15:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505421; cv=none; b=IyEddIWo0oQALbb8OVOokMV3GUEtlvuf5KVwK684AHldZ7w+pZhl5FFyK7IcR2s8ynkGdeRLFyrsA8RDj1AaKb1AJvGF8cbwvubCojys5OXla4NVq4+GavTOFzEyWOtTuVlX7xL3ta9Ru6JGyfJEWmP5vvm/ZGQfXN4l1E8stK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505421; c=relaxed/simple;
	bh=HgEdt27/fadF/UDelzRUDfGMNwFhsLgZIGfeu1efcvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Oab/atIIk5USJSCU/foyUZUXmNRVo57pSUtXcApfAgQJqp/QZ6a1W3SmW3GZ9E+aF/nFwEg7R0838mEtmEAR7aMaj99WZQxcILwC0fdSkYuEBCWd9Jzqoz6afxuZATlghoSmH/oInEoorxUnTRV3JKVoxHhpa9NWlMcjoLTOUTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TXmG339X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752505415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CHjUCxwTYZsQwTU8Zui9gNjcOnUwNl2oic1dvzZPsoo=;
	b=TXmG339XmSFMbnNB+4+6FVCUwu2YddZew6tgVGJiHB5P/nWnTF3AH9e4eg4LUCcl3+/E22
	WTAPJK+PN8Ebi8dC+o6HEC+uFEH3FFM9TpoTzwJR06vvWX+EkbSV8bmIj+XRfcvssRuZFx
	CAYQrQBPbR5I8BTdqDZNBIlO5uUtOmc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-UGh4r3WSPHCPxeB3_Bk3qw-1; Mon, 14 Jul 2025 11:03:33 -0400
X-MC-Unique: UGh4r3WSPHCPxeB3_Bk3qw-1
X-Mimecast-MFC-AGG-ID: UGh4r3WSPHCPxeB3_Bk3qw_1752505411
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4561611dc2aso10851085e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 08:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752505411; x=1753110211;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CHjUCxwTYZsQwTU8Zui9gNjcOnUwNl2oic1dvzZPsoo=;
        b=GwV+uKSGLZeIC2ZXZ9orXNHTIXzqHk8EbEwUa0eCoyAzaYlyQqysfMgK7jIaJdg2r6
         J2BjPlITLhPgAMgcsf2+7U8VzcsVW4PSW4K7qAi9/IsTX9U20ve99JJtZ1RlogPs/3ka
         XPFS6N/oGUWdI6mQZzAvk6/I9OrX9a6Rgl6CbDNiCA8tvw1l9/3WniF5AtZz6KTyPeL6
         JEYHH7+htsZn7wHuzP4vgGxLRxRcUAJ7oX+zJ1rz0OnTxZ99fTszcT/QrKLH+evZhDgl
         /8d3B/hgOaVsgFYRG8ieuJwdMEK2n9h/DS4tydPx4gQDOQWUjz6AQ3NXv+vRTGM5R1KV
         3Mqw==
X-Forwarded-Encrypted: i=1; AJvYcCXNnG9fhKPhWjwqPJsNzrsCsuO+jafFl+AVIKGwdNJh15JtUzPJuMwTO6qrQlngNU5YHWFa9P1XZ+GlHwNUyjc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpitic8QE9x9WZYbArYQEpul2TXt/R3xvpuva60hk8uo5IfX84
	X4N2AsKMqLEIcXCdzEbskLoPq7SqhfXUBumldQ29l/CURjx8qO3v7ZJ8UVaPuHP6L6CyQB0Lycn
	KMMLh65CJkKOEZ/kCAB4lF3T6u/6+VYpZJqlVNl+UCVGLk04LzHOawjYjRZnuQyTUdOhPIg==
X-Gm-Gg: ASbGncvJUXz+hPptuh094HT8AdkjCYvvU6+YFpnCdJpHKYxx/1sIMjUGVyTQ1bYABAG
	mp1tjE0xRfIKSCDAjgLi53kL0iPtU6ugDkcML8m7zxJK93CxD4ryYwZv9i+gcFoxJlRNayJ04DY
	pCWUHzCA+f9SVT8qOvF7Jfm31sp7mhMZQcOABl4UjIJzv/FzWXgavqI33zD+NOOb6ouyCCPhM3g
	Fvq6JkL9lnRgC2x7SHMZJx/GhrYhoSml/YBySqgY2CHnoqYNo2lkLFIg+bvrKoN1SxqPDiZ6ct5
	bcJvMsY48rJaciIhXSGUSDM8pBXwmFRNHeb6S9UPllQ=
X-Received: by 2002:a05:600c:1f14:b0:43d:fa59:af97 with SMTP id 5b1f17b1804b1-454f4255695mr113362395e9.32.1752505410986;
        Mon, 14 Jul 2025 08:03:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgGUQLi8QIz9qJck9h2onkd29NM35VCq7kR/qUQg+hshIrtci80OF3+t9fpKWQoP0MLQ3vkg==
X-Received: by 2002:a05:600c:1f14:b0:43d:fa59:af97 with SMTP id 5b1f17b1804b1-454f4255695mr113361195e9.32.1752505410294;
        Mon, 14 Jul 2025 08:03:30 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.155.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc201asm12513593f8f.22.2025.07.14.08.03.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 08:03:29 -0700 (PDT)
Message-ID: <d16bda13-2f84-4d15-a737-d2782cda480f@redhat.com>
Date: Mon, 14 Jul 2025 17:03:27 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 net-next 14/15] tcp: accecn: AccECN option ceb/cep and
 ACE field multi-wrap heuristics
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
 <20250704085345.46530-15-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250704085345.46530-15-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/4/25 10:53 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Ilpo Järvinen <ij@kernel.org>
> 
> The AccECN option ceb/cep heuristic algorithm is from AccECN spec
> Appendix A.2.2 to mitigate against false ACE field overflows. Armed
> with ceb delta from option, delivered bytes, and delivered packets it
> is possible to estimate how many times ACE field wrapped.
> 
> This calculation is necessary only if more than one wrap is possible.
> Without SACK, delivered bytes and packets are not always trustworthy in
> which case TCP falls back to the simpler no-or-all wraps ceb algorithm.
> 
> Signed-off-by: Ilpo Järvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


