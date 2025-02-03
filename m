Return-Path: <linux-kselftest+bounces-25568-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1765A25A6C
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 14:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EE07164580
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 13:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588E0204F84;
	Mon,  3 Feb 2025 13:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="N90y90gQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7D3204C06
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Feb 2025 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738588309; cv=none; b=Vnz/YsgSRfEG68CcKkVFmJuFSs5vrSde+DuoC69sA8mn7PPzwUZls/Vi500e9flT1Xi4Ninrh7sPUc2AUnvkgwzcxhG5opNID93gpJ04DmaDL8PHbhTXybKALZlR1ifQIXnDLPMU3534FPNVMFayej6v12kaxb/yKlKSyb5iE0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738588309; c=relaxed/simple;
	bh=PDfO2TqiHOQOswp1r7MD60aF2gzSJU3JaaoTdmxlwEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kf6cWRR3Nj692Kku1Dy6C+2M/pWef+eh5h74QquVMDE8Qajq+hCCb5zhzSTitwzwpxy8ywYvYI6k4sTB0AkOSlBVdB97nDrA7gQo3Z2VZVDixujNXRguYsGhh/Y2FxK4JMeraPXTuRLpQexjnNfxWEV5UHdjhtqIjHnrSflIT40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=N90y90gQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436a39e4891so29753085e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Feb 2025 05:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1738588305; x=1739193105; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W0RwX06YNoQDRCRmvfoCjGCfN9QTBGFckStparosZZg=;
        b=N90y90gQnyZDbawzAUUwKAxucHfrEu5a9AXbCBVfIu7mSKWpVkOZDj1Ejd2JjCLpmK
         LcAVowU/5XFa7TBVdHr4fNi/Pk3Fn/I3+zrtfeEPR2xb0660TU/UDpqqGyAjVS3CxVsg
         yDww6964tbJa/JGjZ7q+9rkDtcpEJHXiwScwKHAm7ED0E1pQmIJUufV+YVelzGNDSF/y
         bkp2Ji0wMec/YwJOAVTMaFzB96CCCwC/Ok8ttsTLVhM0WaQbZjMY/EByC13KsyykqsNq
         0fv92vpmoJcfs1Jep0zZ2wu6vTL6IXMd1LWitpelrSyz/PClzyH6rt4tVygdg4WFODEF
         OCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738588305; x=1739193105;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0RwX06YNoQDRCRmvfoCjGCfN9QTBGFckStparosZZg=;
        b=ltriL1tBt1D/T3ZhLE7+cMnEc+IUprDlmgo2I2yuED4LPjvo2qOZBj7Hvc3AvglCYN
         +2OfkslpyDukZgpIlJJMiYSXG4iWqwMvpzESn6sQIuskfWDW/SfOrc/uO/v42QhIpW49
         GFfixloJtXMmck01qkSLXeADHL+noaJ5zXJY3HSxP30SBDGEWmlMKv3MrhBlbzr0BQja
         ePtuKPQYLdlyHUnuXMkumBc4Lkj003oKCwFiHopr7J2RqT4fqksLl+LaMPNBmjXGZtpv
         Nua7S9f/p5Tcx27mHSNyNp+jngUMgnmKjhSTRsE5IM43tuh8CkeySh71JgBR1l/6+ACb
         ZfXw==
X-Forwarded-Encrypted: i=1; AJvYcCWvGJTmprBNdqUPrrUAk/4yJRDuM5ftM4Lp2V9k/4K/qsV+YwcE/+VxigUNOncXvMJ1Cb9/Mxqg7h0UHfkJ2OA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Awym6btOnWS2SCHF0ElsEU2IxEMAgkRsLUSqUshBSz3PHN7O
	5QwdmNSjY6nHuzI88+xViBDYwboR22v7fdZSUY7N6QGLjXh4L6g9ob46RlZsITw=
X-Gm-Gg: ASbGncvH36gBupA5jf5B1wCxV1W91bbkdYX3ISRClmtAHLUeW6vZX0XcluM1nGdALi/
	DnQ4sfSbR7GdYUq0UaI0d43teYEDVpTtoKnrtLGy+2SNM9ajmumV2so41cVeEcr/iKyjCCM1g86
	m3gpBtk0sHLguIiO6BB/ujFwzG4F4V4V2Eua0EqN704ftvBbWeq9hfXMSdcCS98idpjW0TKRRP3
	MNtybU5XUObsrtBcbAWtB0Tn/JdgfkPTlRo6fXIpSjmNzt4Mi0ucrn4lGwxKo0+cla/30COy7K7
	gV72M2SO2yOROwHvmo2qbSagEi0+w+UkA7821f98jmUrzo8Z1uYlOQ==
X-Google-Smtp-Source: AGHT+IGix2KKhAS1u/WXZkqDrxDELKSomSjX0SZ+43f7IZjAxUu2W/Ytm+kXaqZ0WXxeZUkc/HDk8w==
X-Received: by 2002:a05:600c:3b94:b0:434:a923:9310 with SMTP id 5b1f17b1804b1-438dc3cc3b1mr197184575e9.15.1738588305116;
        Mon, 03 Feb 2025 05:11:45 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:b4fe:e6fa:32a0:6a72? ([2001:67c:2fbc:1:b4fe:e6fa:32a0:6a72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc2e384sm194539245e9.19.2025.02.03.05.11.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 05:11:44 -0800 (PST)
Message-ID: <78e59cd0-332e-4a97-8060-ccdf023e8a91@openvpn.net>
Date: Mon, 3 Feb 2025 14:12:52 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 12/25] ovpn: implement TCP transport
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
 <20250113-b4-ovpn-v18-12-1f00db9c2bd6@openvpn.net> <Z6CU2emFGy1L3MDT@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z6CU2emFGy1L3MDT@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/02/2025 11:05, Sabrina Dubroca wrote:
> 2025-01-13, 10:31:31 +0100, Antonio Quartulli wrote:
>> +static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
>> +{
> [...]
>> +	/* we need the first byte of data to be accessible
>> +	 * to extract the opcode and the key ID later on
>> +	 */
>> +	if (!pskb_may_pull(skb, 1)) {
> 
> make sure we have 1B...
> 
>> +		net_warn_ratelimited("%s: packet too small to fetch opcode for peer %u\n",
>> +				     netdev_name(peer->ovpn->dev), peer->id);
>> +		goto err;
>> +	}
>> +
>> +	/* DATA_V2 packets are handled in kernel, the rest goes to user space */
>> +	opcode = ovpn_opcode_from_skb(skb, 0);
> 
> but this reads a u32 (4B) from skb->data

ACK, hand-in-hand with the comment not updated.
Will fix this.

> 
> [...]
>> +void ovpn_tcp_socket_detach(struct ovpn_socket *ovpn_sock)
>> +{
>> +	struct ovpn_peer *peer = ovpn_sock->peer;
>> +	struct socket *sock = ovpn_sock->sock;
>> +
>> +	strp_stop(&peer->tcp.strp);
>> +
>> +	skb_queue_purge(&peer->tcp.user_queue);
>>
>> +	/* restore CBs that were saved in ovpn_sock_set_tcp_cb() */
>> +	sock->sk->sk_data_ready = peer->tcp.sk_cb.sk_data_ready;
>> +	sock->sk->sk_write_space = peer->tcp.sk_cb.sk_write_space;
>> +	sock->sk->sk_prot = peer->tcp.sk_cb.prot;
>> +	sock->sk->sk_socket->ops = peer->tcp.sk_cb.ops;
>> +
>> +	/* drop reference to peer */
> 
> nit: not really :)

drop comment :)

> 
>> +	rcu_assign_sk_user_data(sock->sk, NULL);
>> +
>> +	/* before canceling any ongoing work we must ensure that CBs
>> +	 * have been reset to prevent workers from being re-armed
>> +	 */
>> +	barrier();
>> +
>> +	cancel_work_sync(&peer->tcp.tx_work);
>> +	strp_done(&peer->tcp.strp);
>> +	skb_queue_purge(&peer->tcp.out_queue);
> 
> Also kfree_skb(peer->tcp.out_msg.skb)?

hm yeah, it could be we allocated one but did not finish filling it.

> 
>> +	ovpn_peer_put(peer);
>> +}
> 
> 
> [...]
>> +static int ovpn_tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>> +{
> [...]
>> +	ret = skb_copy_datagram_from_iter(skb, 0, &msg->msg_iter, size);
>> +	if (ret) {
>> +		kfree_skb(skb);
>> +		net_err_ratelimited("%s: skb copy from iter failed: %d\n",
>> +				    netdev_name(sock->peer->ovpn->dev), ret);
>> +		goto peer_free;
>> +	}
>> +
>> +	ovpn_tcp_send_sock_skb(sock->peer, skb);
> 
> This isn't propagating MSG_DONTWAIT down to ovpn_tcp_send_sock?
> 

patch 14/25 will add a new member to ovpn_cb which will be filled right 
before calling ovpn_tcp_send_sock_skb() and that gets picked later.

Cheers,


-- 
Antonio Quartulli
OpenVPN Inc.


