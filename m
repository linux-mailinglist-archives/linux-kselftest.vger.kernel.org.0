Return-Path: <linux-kselftest+bounces-37236-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 666DAB03D2F
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 13:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE4627A2F83
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 11:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDA3246335;
	Mon, 14 Jul 2025 11:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TCo43i71"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6041117C77
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 11:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752492016; cv=none; b=KJGvruszHAR8MEM4GrGX7Um93bmRgUrN7aub27DRjPd7JeQ3foXCoGvs8j6s6GAGxBxrSBbWJFMVe8B+XgrDbAwFHql9C8MWLoau7KrTH9pQXHWf8qSJeh2YthxDS0gSscbEF3r9C6PDy9U/MaAxLleDsLS1zbAr8KGpjHQfT6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752492016; c=relaxed/simple;
	bh=U+ABV2Z/K8FhS1tVsDtWSNLoxl2AP1Zy78uF8iTobqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n6FFJfPwKf1yxYf4d4+hZ44DnwVInB0yjuh/CIM+CwZ8LYHYg8JR5Cq8N88AayU9pl43eWhC5AUa9ejfYFX37LEFJyVwCFrZcl8+tFniYDJD+2Zipoas1FZtjlGXa/qvZjpd+wvWYWBABue6VtCnPY091ece+g4Aj0+9yo5XNSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TCo43i71; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752492013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Y2GjFqzQOcWBUPguZ9USD97IUATEowPrFd5x574Jlc=;
	b=TCo43i71mxbIFTPT/vwzSGnUEtXb3Hjb3IMFYn40LP3/UAwGr6K87DzTxp0oOAmFl9kFk1
	NlwV8UxpB5h5APA2ZXySSL3XxSEfiF4IoWX1qbRRA84gXQDCY5A8KeQ+rTy6U4ejmhwrho
	le56Hs2AM2PXctT+f8WTI+lT0ZV3AJI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-WxI7YMEyPhqGitYoxdq-qg-1; Mon, 14 Jul 2025 07:20:12 -0400
X-MC-Unique: WxI7YMEyPhqGitYoxdq-qg-1
X-Mimecast-MFC-AGG-ID: WxI7YMEyPhqGitYoxdq-qg_1752492011
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b20f50da27so2500816f8f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 04:20:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752492011; x=1753096811;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Y2GjFqzQOcWBUPguZ9USD97IUATEowPrFd5x574Jlc=;
        b=pJrpLEJCgqSNmkBwKNKWoX8sQXNBDlc886/9TxkKoIDL7AOiuGjAV9KOGApfvz8s8P
         GudqilhgawtN7Z1fBFoHYVEkSfqRhZLIbzaoYUXdWUEFQrjj9/MKNsW+fxHWqxHsB5G6
         6a9eI8P8+bmGHeVlXhqkLEV50bTOVKlUqdVfBxL+RWsr9J53lrU/Wa3YXuXz3X0RG4UQ
         C3CkWPeYVJjEG2QxJn9KRG0IozISaDVRFNUWmSqKwF3hjaW3gv00exTDQOM0ekXIuO7X
         9CV2Ht+DbDH+IhuHM7PY0Zf9iMACAf4A6GwbRyS32IOCKqTYUss9HvvM9vNxs4k2w3LI
         xcnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVIEDIAjuHdVFSn1LmBZwsGiZqpFt9LJyd7ziS9o7PWIHfDly+l5Nkn4VDuoNyOK8UsVUaGDMeYYG0xJAvVKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLwPlyr+yAOjBTFJ3JY+RDuvW5c1Xy4AcnNZ+rGj4E+Lw8bNWA
	Hdj1UAuFNvfvplljASU+yVvPutPKK6Dv8pb+vxqyO0yLsnm/9NNENx2ROC+Sk8yof6e6I9YnAHD
	2Ab6AMvpEB6V1Jit7/5lHZffsAI1MnaCjsUCm9FpjAAD/uT6RTCR6tBSPhUmI1FysG1Y2Dg==
X-Gm-Gg: ASbGncvsDu+3FfiS/+OSiZqglw8wzqEsw4A0JwwoJlhXYfEEGviNL34kZD3COXNF52z
	nU0ecrcQ6jXGN3u3p/m3u/jaZG2jdijaqRUq2l8tp1C81wOz6p9c48vsOhqFqJcS7DHR3+2UMeR
	osFxpj3q4k75HKO8RPQkhdP+1YxVlB6tkatvjDrsA2zaz8XM81nPBswVo176/6MebQkvLHaejqr
	KCjppDQI5TZTqWbTwvwXCDmnmgMj31w8RgeHA0eyrKRY0n7rkXoyszCdfvjnCcgfQ4jH8oVcUV5
	RbDvRxk+OOHRQByjlz3rbpcMfheMlX5NWcvc4P3lcTo=
X-Received: by 2002:a05:6000:240e:b0:3a3:70ab:b274 with SMTP id ffacd0b85a97d-3b5e7f13a0amr13230080f8f.12.1752492010669;
        Mon, 14 Jul 2025 04:20:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY5XrOya3yhJllGztjovrFQKpCxb10L3EkWzmPKdKNg7g1cHqucJ9l4yQULMvIkstPwMqvTQ==
X-Received: by 2002:a05:6000:240e:b0:3a3:70ab:b274 with SMTP id ffacd0b85a97d-3b5e7f13a0amr13230053f8f.12.1752492010098;
        Mon, 14 Jul 2025 04:20:10 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.155.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc201asm11984844f8f.22.2025.07.14.04.20.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 04:20:09 -0700 (PDT)
Message-ID: <b8f0ae48-b059-4137-9b74-f69c122f98f9@redhat.com>
Date: Mon, 14 Jul 2025 13:20:06 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 net-next 04/15] tcp: ecn functions in separated
 include file
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
 <20250704085345.46530-5-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250704085345.46530-5-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/4/25 10:53 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> The following patches will modify ECN helpers and add AccECN herlpers,
> and this patch moves the existing ones into a separated include file.
> 
> No functional changes.
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


