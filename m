Return-Path: <linux-kselftest+bounces-22129-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4629CFBB6
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Nov 2024 01:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AF8C1F22D0A
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Nov 2024 00:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB965C96;
	Sat, 16 Nov 2024 00:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="OiFp/XMo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0A2EAC7
	for <linux-kselftest@vger.kernel.org>; Sat, 16 Nov 2024 00:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731717200; cv=none; b=eSR6Ap1ZxgHDYGb4KpoVaytXWJQOSNv4hn3tuvcoJesqtBVBfLoMn6Lik/lwpipsY2FxwDfUp9/FNfS0itgdHWWlHMBNzkYosgmDjHbohDB8ma9wwc/riwLb/l5FqyUG5SHwzPghucmKylEcvaLYoeAlLA5qyVqkV8goh8op/Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731717200; c=relaxed/simple;
	bh=qUu9sVzzzGkIY391MboEYpeWwreEvz1oIijd49NMTCI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GRAtrdNNj/EAJqg8IlfuMJOBjOB9ErZDDYfhnjSohhElUUQ31TcU/XBEcP/fQ1EDH9tLdUttEDuxmO2ePLJP60m3xhEX0dM9UDN4UgCk5d7M0BBu4CHGUOSEZTHJVNIiP+cgwK+hJF0nmKs/sGdR87MsY3evUzq7IdBGZjyMznA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=OiFp/XMo; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4316f3d3c21so19442575e9.3
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Nov 2024 16:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1731717196; x=1732321996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1MMSOuAOZWrhFJo3QIAoCyBUwAMAzd91sdYRX8Vb8ZU=;
        b=OiFp/XMoqkWQ6DKbWMtodkb22Er9rsAIGdzOrILCoATNttQwO0YjPmOKPRrSX7O1gP
         eE/GuAPrHHwH49Kz1GsFabggGUf9lnrSZh/UFON+XvYjdeSJZJQfcoeZVyPzHg5hEJJw
         HjjRzi1MSgNkKjTYLpkRdkzzGMQ0eWyYih2rsnekU6tfkzHpeJ6EICWdDDwhiQOiM0Xm
         +8b9ji/FsiDiij15XuhWUtA3NTBPdckqYChp7//KK5TEh0ETNLxR3EvMKndlIww4wMGD
         32uvvk0xTkgVpCjhaxDIXQ6pZD0zohTTHLIZvkvItWFtEI+uhHF+r4hGTpxqq5g/kUas
         +sLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731717196; x=1732321996;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1MMSOuAOZWrhFJo3QIAoCyBUwAMAzd91sdYRX8Vb8ZU=;
        b=lCo/A7KRY4jL9JHJJyMpcQjYJi6BRYAISB5fNxBam9BBfOobntQAdgtVt5qLBvEPIQ
         fdzDqIEpV3TmkTpqlI33wT8r/ST2yHsjOwQN3MUwU4pVKWCD6PHiKhcWcmRq4/vsIetm
         swTBeIIY8e/K2FhLm7eA4IQLBiJNDiEfi5HkRRCxlFZovvDqM3+0ynfE9MwgPEfNhSvW
         Bi7JEaFUk1Y6aInVhDJGBhMcHWB0r3FycIQMI6LU+KxfHEIcNVus3ucypIfIO7A+z3LZ
         aHrwLlaj02BdDQtYp6VcPKVP0Gbd+2lVJzXM1eFpAowchrCAogKsmO3cARzJJVeMxscb
         Jhkw==
X-Forwarded-Encrypted: i=1; AJvYcCUOUbGaJ1Th7pgy7vOCtHfMm+w9cVXPPhF2u0QBZC9Vks+OmMn7ByQSAFMs6Fv3qQOx2+tv8tNf+K+VdEXej5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMCav4PIdyFlyhyKYdpgbRlwlQ8FfX+kez+PQM9YYPbgyX9EaZ
	4f3uEbs0hiQGFiQIFVSEDPsUlHq2M234gd9hbcuPSU48qX12mTxzSLzrebt1MFU=
X-Google-Smtp-Source: AGHT+IG2WaN+2xrRNPGNLPFeaYiOFW8CtqSRppLS+TuR/8KubpUiew+qnrBtrCuyzGyegdR/wusbXQ==
X-Received: by 2002:a05:6000:4022:b0:37d:4657:ea78 with SMTP id ffacd0b85a97d-38225aa6479mr3296371f8f.54.1731717196164;
        Fri, 15 Nov 2024 16:33:16 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:1b94:c354:f504:96f9? ([2001:67c:2fbc:1:1b94:c354:f504:96f9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-382371a5646sm184855f8f.0.2024.11.15.16.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 16:33:14 -0800 (PST)
Message-ID: <3df02a8f-72c7-4db9-bb46-a6529082b328@openvpn.net>
Date: Sat, 16 Nov 2024 01:33:40 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Antonio Quartulli <antonio@openvpn.net>
Subject: Re: [PATCH net-next v11 12/23] ovpn: implement TCP transport
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-12-de4698c73a25@openvpn.net> <ZyOhe3yKTiqCF2TH@hog>
Content-Language: en-US
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZyOhe3yKTiqCF2TH@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/10/2024 16:25, Sabrina Dubroca wrote:
> 2024-10-29, 11:47:25 +0100, Antonio Quartulli wrote:
>> +static void ovpn_socket_release_work(struct work_struct *work)
>> +{
>> +	struct ovpn_socket *sock = container_of(work, struct ovpn_socket, work);
>> +
>> +	ovpn_socket_detach(sock->sock);
>> +	kfree_rcu(sock, rcu);
>> +}
>> +
>> +static void ovpn_socket_schedule_release(struct ovpn_socket *sock)
>> +{
>> +	INIT_WORK(&sock->work, ovpn_socket_release_work);
>> +	schedule_work(&sock->work);
> 
> How does module unloading know that it has to wait for this work to
> complete? Will ovpn_cleanup get stuck until some refcount gets
> released by this work?

No, we have no such mechanism.
Any idea how other modules do?

Actually this makes me wonder how module unloading coordinates with the 
code being executed. Unload may happen at any time - how do we prevent 
killing the code in the middle of something (regardless of scheduled 
workers)?

> 
> 
> [...]
>> +static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
>> +{
>> +	struct ovpn_peer *peer = container_of(strp, struct ovpn_peer, tcp.strp);
>> +	struct strp_msg *msg = strp_msg(skb);
>> +	size_t pkt_len = msg->full_len - 2;
>> +	size_t off = msg->offset + 2;
>> +
>> +	/* ensure skb->data points to the beginning of the openvpn packet */
>> +	if (!pskb_pull(skb, off)) {
>> +		net_warn_ratelimited("%s: packet too small\n",
>> +				     peer->ovpn->dev->name);
>> +		goto err;
>> +	}
>> +
>> +	/* strparser does not trim the skb for us, therefore we do it now */
>> +	if (pskb_trim(skb, pkt_len) != 0) {
>> +		net_warn_ratelimited("%s: trimming skb failed\n",
>> +				     peer->ovpn->dev->name);
>> +		goto err;
>> +	}
>> +
>> +	/* we need the first byte of data to be accessible
>> +	 * to extract the opcode and the key ID later on
>> +	 */
>> +	if (!pskb_may_pull(skb, 1)) {
>> +		net_warn_ratelimited("%s: packet too small to fetch opcode\n",
>> +				     peer->ovpn->dev->name);
>> +		goto err;
>> +	}
>> +
>> +	/* DATA_V2 packets are handled in kernel, the rest goes to user space */
>> +	if (likely(ovpn_opcode_from_skb(skb, 0) == OVPN_DATA_V2)) {
>> +		/* hold reference to peer as required by ovpn_recv().
>> +		 *
>> +		 * NOTE: in this context we should already be holding a
>> +		 * reference to this peer, therefore ovpn_peer_hold() is
>> +		 * not expected to fail
>> +		 */
>> +		if (WARN_ON(!ovpn_peer_hold(peer)))
>> +			goto err;
>> +
>> +		ovpn_recv(peer, skb);
>> +	} else {
>> +		/* The packet size header must be there when sending the packet
>> +		 * to userspace, therefore we put it back
>> +		 */
>> +		skb_push(skb, 2);
>> +		ovpn_tcp_to_userspace(peer, strp->sk, skb);
>> +	}
>> +
>> +	return;
>> +err:
>> +	netdev_err(peer->ovpn->dev,
>> +		   "cannot process incoming TCP data for peer %u\n", peer->id);
> 
> This should also be ratelimited, and maybe just combined with the
> net_warn_ratelimited just before each goto.

ACK.

> 
>> +	dev_core_stats_rx_dropped_inc(peer->ovpn->dev);
>> +	kfree_skb(skb);
>> +	ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_TRANSPORT_ERROR);
>> +}
> 
> [...]
>> +void ovpn_tcp_socket_detach(struct socket *sock)
>> +{
> [...]
>> +	/* restore CBs that were saved in ovpn_sock_set_tcp_cb() */
>> +	sock->sk->sk_data_ready = peer->tcp.sk_cb.sk_data_ready;
>> +	sock->sk->sk_write_space = peer->tcp.sk_cb.sk_write_space;
>> +	sock->sk->sk_prot = peer->tcp.sk_cb.prot;
>> +	sock->sk->sk_socket->ops = peer->tcp.sk_cb.ops;
>> +	rcu_assign_sk_user_data(sock->sk, NULL);
>> +
>> +	rcu_read_unlock();
>> +
>> +	/* cancel any ongoing work. Done after removing the CBs so that these
>> +	 * workers cannot be re-armed
>> +	 */
> 
> I'm not sure whether a barrier is needed to prevent compiler/CPU
> reordering here.

I see ipsec has one in espintcp.c. I think it makes sense to add it 
right here.

> 
>> +	cancel_work_sync(&peer->tcp.tx_work);
>> +	strp_done(&peer->tcp.strp);
>> +}
>> +
>> +static void ovpn_tcp_send_sock(struct ovpn_peer *peer)
>> +{
>> +	struct sk_buff *skb = peer->tcp.out_msg.skb;
>> +
>> +	if (!skb)
>> +		return;
>> +
>> +	if (peer->tcp.tx_in_progress)
>> +		return;
>> +
>> +	peer->tcp.tx_in_progress = true;
> 
> Sorry, I never answered your question about my concerns in a previous
> review here.
> 
> We can reach ovpn_tcp_send_sock in two different contexts:
>   - lock_sock (either from ovpn_tcp_sendmsg or ovpn_tcp_tx_work)
>   - bh_lock_sock (from ovpn_tcp_send_skb, ie "data path")
> 
> These are not fully mutually exclusive. lock_sock grabs bh_lock_sock
> (a spinlock) for a brief period to mark the (sleeping/mutex) lock as
> taken, and then releases it.
> 
> So when bh_lock_sock is held, it's not possible to grab lock_sock. But
> when lock_sock is taken, it's still possible to grab bh_lock_sock.
> 
> 
> The buggy scenario would be:
> 
>    (data path encrypt)                       (sendmsg)
>    ovpn_tcp_send_skb                         lock_sock
>                                                bh_lock_sock + owned=1 + bh_unlock_sock
>    bh_lock_sock
>    ovpn_tcp_send_sock_skb                      ovpn_tcp_send_sock_skb
>      !peer->tcp.out_msg.skb                      !peer->tcp.out_msg.skb
>      peer->tcp.out_msg.skb = ...                 peer->tcp.out_msg.skb = ...
>      ovpn_tcp_send_sock                          ovpn_tcp_send_sock
>        !peer->tcp.tx_in_progress                   !peer->tcp.tx_in_progress
>        peer->tcp.tx_in_progress = true             peer->tcp.tx_in_progress = true
>        // proceed                                  // proceed
> 
> 
> That's 2 similar races, one on out_msg.skb and one on tx_in_progress.
> It's a bit unlikely (but not impossible) that we'll have 2 cpus trying
> to call skb_send_sock_locked at the same time, but if they just
> overwrite each other's skb/len it's already pretty bad. The end of
> ovpn_tcp_send_sock might also reset peer->tcp.out_msg.* just as
> ovpn_tcp_send_skb -> ovpn_tcp_send_sock_skb starts setting it up
> (peer->tcp.out_msg.skb gets cleared, ovpn_tcp_send_sock_skb proceeds
> and sets skb+len, then maybe len gets reset to 0 by
> ovpn_tcp_send_sock).
> 
> 
> To avoid this problem, esp_output_tcp_finish (net/ipv4/esp4.c) does:
> 
> 	bh_lock_sock(sk);
> 	if (sock_owned_by_user(sk))
> 		err = espintcp_queue_out(sk, skb);
> 	else
> 		err = espintcp_push_skb(sk, skb);
> 	bh_unlock_sock(sk);
> 
> 
> (espintcp_push_skb is roughly equivalent to ovpn_tcp_send_sock_skb)

mh I see...so basically while sendmsg is running we should stash all 
packets and send them out in one go upon lock release (via release_cb).

Will get that done in v12! Thanks!

> 
> 
>> +	do {
>> +		int ret = skb_send_sock_locked(peer->sock->sock->sk, skb,
>> +					       peer->tcp.out_msg.offset,
>> +					       peer->tcp.out_msg.len);
>> +		if (unlikely(ret < 0)) {
>> +			if (ret == -EAGAIN)
>> +				goto out;
>> +
>> +			net_warn_ratelimited("%s: TCP error to peer %u: %d\n",
>> +					     peer->ovpn->dev->name, peer->id,
>> +					     ret);
>> +
>> +			/* in case of TCP error we can't recover the VPN
>> +			 * stream therefore we abort the connection
>> +			 */
>> +			ovpn_peer_del(peer,
>> +				      OVPN_DEL_PEER_REASON_TRANSPORT_ERROR);
>> +			break;
>> +		}
>> +
>> +		peer->tcp.out_msg.len -= ret;
>> +		peer->tcp.out_msg.offset += ret;
>> +	} while (peer->tcp.out_msg.len > 0);
>> +
>> +	if (!peer->tcp.out_msg.len)
>> +		dev_sw_netstats_tx_add(peer->ovpn->dev, 1, skb->len);
>> +
>> +	kfree_skb(peer->tcp.out_msg.skb);
>> +	peer->tcp.out_msg.skb = NULL;
>> +	peer->tcp.out_msg.len = 0;
>> +	peer->tcp.out_msg.offset = 0;
>> +
>> +out:
>> +	peer->tcp.tx_in_progress = false;
>> +}
>> +
>> +static void ovpn_tcp_tx_work(struct work_struct *work)
>> +{
>> +	struct ovpn_peer *peer;
>> +
>> +	peer = container_of(work, struct ovpn_peer, tcp.tx_work);
>> +
>> +	lock_sock(peer->sock->sock->sk);
>> +	ovpn_tcp_send_sock(peer);
>> +	release_sock(peer->sock->sock->sk);
>> +}
>> +
>> +void ovpn_tcp_send_sock_skb(struct ovpn_peer *peer, struct sk_buff *skb)
>> +{
>> +	if (peer->tcp.out_msg.skb)
>> +		return;
> 
> That's leaking the skb? (and not counting the drop)

we should not lose this packet..[continues below]

> 
>> +
>> +	peer->tcp.out_msg.skb = skb;
>> +	peer->tcp.out_msg.len = skb->len;
>> +	peer->tcp.out_msg.offset = 0;
>> +
>> +	ovpn_tcp_send_sock(peer);
>> +}
>> +
>> +static int ovpn_tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>> +{
> [...]
>> +	ret = skb_copy_datagram_from_iter(skb, 0, &msg->msg_iter, size);
>> +	if (ret) {
>> +		kfree_skb(skb);
>> +		net_err_ratelimited("%s: skb copy from iter failed: %d\n",
>> +				    sock->peer->ovpn->dev->name, ret);
>> +		goto unlock;
>> +	}
>> +
>> +	ovpn_tcp_send_sock_skb(sock->peer, skb);
> 
> If we didn't send the packet (because one was already queued/in
> progress), we should either stash it, or tell userspace that it wasn't
> sent and it should retry later.

In the part you omitted we have the following (while holding lock_sock):

320         if (peer->tcp.out_msg.skb) {
321                 ret = -EAGAIN;
322                 goto unlock;
323         }

Therefore ovpn_tcp_send_sock_skb() should never drop the packet if this 
condition was already evaluated false.

But if I understood all your notes correctly, the data path may still 
overlap here because it never holds the lock_sock and thus fill .skb 
after ovpn_tcp_sendmsg() has checked it. Am I right?

However, this race should not be possible anymore once I implement the 
sock_owned_by_user() check you suggested above.
Because ovpn_tcp_sendmsg() will be invoked with owned=1 which will 
prevent the data path from attempting to send more packets.

Do you agree?

Thanks a lot for pointing this out!
The inner mechanisms of TCP socks are still a bit obscure to me.


Regards,


-- 
Antonio Quartulli
OpenVPN Inc.



