Return-Path: <linux-kselftest+bounces-21209-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBCB9B7B4F
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 14:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 530A91F23A65
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 13:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7B419DF5F;
	Thu, 31 Oct 2024 13:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="M8dIynUp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C5019D880
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2024 13:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730379864; cv=none; b=NmkllfStKhVTHxjRvrY3uYJEmoT5o/PjKKRQFOrG8OHk3THG60EX+5XxBvdv5b9Lcx8tMbv6ZbCmKNBjHpoUTSEzqxKq0FGtpBZjJtUQV8vHQsvKMRpUPuuarbfSNfU1BCuth1zo7Hlep/WwoFXa/mqhM/3XFxvHkypuQBEG2v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730379864; c=relaxed/simple;
	bh=JsKGmnpIuoW5fsclwSZrkIkCEuS6dS0KpTGciK9Eu0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GBDxQb9RHdSECPcZUehYO/MmexsL6hul4xJaxiygxlPomeC4hqrrfq32Ughc6K31XEjKTmkCPmFv9p3Dob9Lxz8olAY7Vq+ajwcPdYTLxvKmeK25ZUisH9zA5vmfAvE4VzqKhz05VnQgKkUucWhm1yxFXpusCdMVEy/Q/9TAiM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=M8dIynUp; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c9709c9b0cso1349802a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2024 06:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1730379858; x=1730984658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ywVMufKZMjU17iNIBKgZen4OeV1HNgSAnuk2ZsOpC5Y=;
        b=M8dIynUpuNExwu3k+l2mlQ+KTojHDTJafqn9EOS+1ShIfVdNaW9QmBPrMsRL73OjZN
         kCsZtLBN2jRMR0GSjPu7f0FAknTUYnFo0FxP8/wEhavj5K9sv97a/9XJiJPsAwwKxVER
         6eYdJweGouAA2/UI/tWbu9n3FE6kjI9tvgW6rB8Z+BqTTnz2I3RlzSonlx/+iOinPgNc
         b0LZb8sZSe/uSi2uDim9MxCwbJc3SBmEnod4pN+yR9oZdlyknQF5eASsaiYqg2tgWL7A
         VmMrB++OJ6rbeYib+1PI9rIKU7ZOkY7Bhmru/VV2rugHNEcSOqd/1VZDomy+tyOljmTx
         UxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730379858; x=1730984658;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywVMufKZMjU17iNIBKgZen4OeV1HNgSAnuk2ZsOpC5Y=;
        b=nNZ3fTybScezLZGNvWe497+6IANjkpSRqCyKdNvwsQ2b6bOVh950wWXaTjpDcq+AZ+
         qZjPCqeY0toabj4ta6S0u9InyP0fRqjdoXuM5yIFlkRnaPhy5BqwCyoDD4br0UMAechU
         mYiyfjEtIgfwB2nCzmm9QJzak/9Qy3GjY7oUNKADtl0KkVK/bv8W97Xv4EEmpBlRoI8P
         ZObflkgMWbl9ZZoVQfY2t0yc+z6l621+jm33VS6ZXkx6E2Ud4yLfoYojknbrz26vUnar
         5dqwbmdtKWi5Vpmh9D1hhb8fVGJY0ghG3VJOfEQ704mgsTZeCrUHyxdQKsJWk4AZLBVb
         P8dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaEmLOsO/IbtqeIVxXIFvB17CqeKNxEytdJZFFD5PwKUHWL6jr0NaMBWKSMpex5xD6DX/sgmmK5Q7rW6uY+kA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfWpHV2fQzwqK8vSHBsSW+TnjZwo+LlxUMkdgUEGVW0tjHz8Z0
	D6zouFDeZPLhcWhLx3TgbrnTJ+Ha5Oj0FA8umOb5zWgiluYpXM2uM8cRMNepmBE=
X-Google-Smtp-Source: AGHT+IE6r2tmet2APO46r81uaRL+hYsT1FbsAPHA0sEcRhbYsmep9QKQX8UYdGqu3rqXHpeuMM2TVQ==
X-Received: by 2002:a05:6402:3481:b0:5c8:9f3d:391b with SMTP id 4fb4d7f45d1cf-5cd54af11bamr5111654a12.28.1730379857694;
        Thu, 31 Oct 2024 06:04:17 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:634e:2582:d0aa:ee79? ([2001:67c:2fbc:1:634e:2582:d0aa:ee79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac74ccf2sm592450a12.9.2024.10.31.06.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 06:04:17 -0700 (PDT)
Message-ID: <3aa1644e-ddca-44ef-aa7c-da1382083f77@openvpn.net>
Date: Thu, 31 Oct 2024 14:04:33 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 09/23] ovpn: implement basic RX path (UDP)
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-9-de4698c73a25@openvpn.net> <ZyNp_WSG6ClueLe_@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZyNp_WSG6ClueLe_@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/10/2024 12:29, Sabrina Dubroca wrote:
> 2024-10-29, 11:47:22 +0100, Antonio Quartulli wrote:
>> +static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
>> +{
> [...]
>> +	opcode = ovpn_opcode_from_skb(skb, sizeof(struct udphdr));
>> +	if (unlikely(opcode != OVPN_DATA_V2)) {
>> +		/* DATA_V1 is not supported */
>> +		if (opcode == OVPN_DATA_V1)
> 
> The TCP encap code passes everything that's not V2 to userspace. Why
> not do that with UDP as well?

If that's the case, then this is a bug in the TCP code.

DATA_Vx packets are part of the data channel and userspace can't do 
anything with them (userspace handles the control channel only when the 
ovpn module is in use).

I'll go check the TCP code then, because sending DATA_V1 to userspace is 
not expected. Thanks for noticing this discrepancy.

> 
>> +			goto drop;
>> +
>> +		/* unknown or control packet: let it bubble up to userspace */
>> +		return 1;
>> +	}
>> +
>> +	peer_id = ovpn_peer_id_from_skb(skb, sizeof(struct udphdr));
>> +	/* some OpenVPN server implementations send data packets with the
>> +	 * peer-id set to undef. In this case we skip the peer lookup by peer-id
>> +	 * and we try with the transport address
>> +	 */
>> +	if (peer_id != OVPN_PEER_ID_UNDEF) {
>> +		peer = ovpn_peer_get_by_id(ovpn, peer_id);
>> +		if (!peer) {
>> +			net_err_ratelimited("%s: received data from unknown peer (id: %d)\n",
>> +					    __func__, peer_id);
>> +			goto drop;
>> +		}
>> +	}
>> +
>> +	if (!peer) {
> 
> nit: that could be an "else" combined with the previous case?

mhh that's true. Then I can combine the two "if (!peer)" in one block only.


Thanks!
Regards,

> 
>> +		/* data packet with undef peer-id */
>> +		peer = ovpn_peer_get_by_transp_addr(ovpn, skb);
>> +		if (unlikely(!peer)) {
>> +			net_dbg_ratelimited("%s: received data with undef peer-id from unknown source\n",
>> +					    __func__);
>> +			goto drop;
>> +		}
>> +	}
> 

-- 
Antonio Quartulli
OpenVPN Inc.


