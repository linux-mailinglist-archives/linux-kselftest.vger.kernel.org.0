Return-Path: <linux-kselftest+bounces-23925-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96796A01CAE
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 00:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5A9C1883111
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Jan 2025 23:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFBA1AA1F2;
	Sun,  5 Jan 2025 23:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="ZqfKP6sq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAF21547C6
	for <linux-kselftest@vger.kernel.org>; Sun,  5 Jan 2025 23:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736119610; cv=none; b=R752n87HKXZHHMWDalxPyKatAltkj7ppWIjBd0ycFsRCpJ3hJMnkzdICcbX+LiC+09B0Hjb5rYgP1tR1jHz+HbzwRNOuEpy45Y8BmWdt9Dnmi/AzQQJX/sr8fsA8sHGg2uxZvBgD9esrzdT2lRHVcoK3rWRgqojfR5qump6eFpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736119610; c=relaxed/simple;
	bh=LP7ZLzht5qbhm2Mnl3NnvvqM1w2ujNW6Pp/NlVJ/d+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U1FezQfYa8t2S45aJJuQgBm2aukFB6D/rxQ/5Gr3Sm+LcPY/uKhpJCWGG01b57ntkVTEp3W+j0sasIcmJQccuHe6HkCpE4Tml+33OG00JtgnT3jyssNd8dKtQoiuHb7fMHdh9NaOP8piuRajNx5XuNPqWOP8RK66uUpW9DKWR9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=ZqfKP6sq; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43623f0c574so94582995e9.2
        for <linux-kselftest@vger.kernel.org>; Sun, 05 Jan 2025 15:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1736119606; x=1736724406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9mHf8yFtOKVgQZRZ2k2zr9KtmnpbUApiV/Ef6697gs=;
        b=ZqfKP6sq3K2uN0xvGlky/BDPUos5hV/kAwhOQgrmkGcqKP6eXI9U7ghfbBFqMZNHJA
         CQ/QlDqPaMy2PmGzXDBAewGegJGHF4/QgH4N4VcTjxv3uHs+39+zai5kv3cT4ELXcb/O
         ijzfHDOgUGSQ9mu1VqHwEa+JGzVb7DPmJPcJtotinzuhrJBjstD5LDTDOIxbbkio+yUI
         ziJSMeeM2y0JRllFBrwPqciyJDpyzDbTrkNal8x4PG/2BuL5s4zrtmkMb1e+aDPIQ7lK
         Df+HX26wLGOk1kX9iht0C7bAIqBvPb1takoKbZUsfT1HJUaxUp9mACAsameo1zoSwxqw
         +Rkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736119606; x=1736724406;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9mHf8yFtOKVgQZRZ2k2zr9KtmnpbUApiV/Ef6697gs=;
        b=ekjmaYtZraMeYt9EeVLO5XN0EulUIhfPmU60AH0laZ0m/PcjUg7+Lf5g2V8BveXVGd
         k88uFv/u9Tk3vpKHknBZ3R6YRZovYLMxakWmxJmoFH0veSfqGDHHEIOPZbJHkRmrMUly
         yIt5mQk3AtQTmMTHdsd6QR6ytQI1lZeJwivpqeQrOws5ZhIzqXwrrOBi0p/p4DJ6EA0f
         B/REGagzXau+HMmIuvLKllrs3xLDm6AmDF5ETsxI9m+HmfKxCzEvLBK+01DQR8ONGaFD
         7PuRl7g1NbDJvmslygNuGsBmZy6O0R4wZf7mZBTHQZHMKxPwj3EiYkKPvcUyldGFzE/O
         TS/A==
X-Forwarded-Encrypted: i=1; AJvYcCUjg9Nilk8GPOlSSnkEJOeNC+JQaHrq9m8JavltOpCLD+qxKO2EDnw2MVBx4ySt2YCOdi1V5ZAfNgsvawJavs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsI2eMdSBLe0iEOqOKUH8+20ANUXUXysAMJ0pyP33ii0njO43x
	wic2V9JYn/4HFNHZwZ3tLOP+I9HrpwUF8PfWg/0SSx7Z3orE5Tkcdqny90DVvMI=
X-Gm-Gg: ASbGnctfzkOM3ELyJnjJOTp6YXCJgAPxyDw1wHPi62LB9Agaiuc7oho7b+smY4TLHJt
	d5gcj32Ldmt/p5c1ca2ox62STMk7BLQiJcg0CeE6IN0X7cWTmdOPtclkP8aNQJUpHck7lsUQAPd
	vMBb8oSyO65KxOxqSPyGMogP+600SqdhhDLHpl6BkLQMISMxgMe4BmINKGiGvRHpvgq2MJTlI0J
	9zwlkYS1SzCOg4SXSOfrTUA9KPi43hf1FFd94ZUrRPPoovWHXMI8mH7R/iVN8upT47Cj1vhXsjv
	j82x0NCiDyfMu/8tUTs=
X-Google-Smtp-Source: AGHT+IFfyRzFKSxBAa63INUl99UzqXvW//BGflMBlLyb+ckrsSV0XVNj70wBWEe+D3lGmyzFG2e2hA==
X-Received: by 2002:a05:600c:3516:b0:434:fbda:1f44 with SMTP id 5b1f17b1804b1-436686464e7mr478522965e9.19.1736119605988;
        Sun, 05 Jan 2025 15:26:45 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:4853:2a1d:28b3:4797? ([2001:67c:2fbc:1:4853:2a1d:28b3:4797])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43661219a71sm547181665e9.26.2025.01.05.15.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jan 2025 15:26:44 -0800 (PST)
Message-ID: <9634a1e1-6cc4-45ef-89d8-30d0e50ba319@openvpn.net>
Date: Mon, 6 Jan 2025 00:27:28 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v16 07/26] ovpn: introduce the ovpn_socket object
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>,
 willemdebruijn.kernel@gmail.com
References: <20241219-b4-ovpn-v16-0-3e3001153683@openvpn.net>
 <20241219-b4-ovpn-v16-7-3e3001153683@openvpn.net> <Z3gXs65jjYc-g2iw@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 xsFNBFN3k+ABEADEvXdJZVUfqxGOKByfkExNpKzFzAwHYjhOb3MTlzSLlVKLRIHxe/Etj13I
 X6tcViNYiIiJxmeHAH7FUj/yAISW56lynAEt7OdkGpZf3HGXRQz1Xi0PWuUINa4QW+ipaKmv
 voR4b1wZQ9cZ787KLmu10VF1duHW/IewDx9GUQIzChqQVI3lSHRCo90Z/NQ75ZL/rbR3UHB+
 EWLIh8Lz1cdE47VaVyX6f0yr3Itx0ZuyIWPrctlHwV5bUdA4JnyY3QvJh4yJPYh9I69HZWsj
 qplU2WxEfM6+OlaM9iKOUhVxjpkFXheD57EGdVkuG0YhizVF4p9MKGB42D70pfS3EiYdTaKf
 WzbiFUunOHLJ4hyAi75d4ugxU02DsUjw/0t0kfHtj2V0x1169Hp/NTW1jkqgPWtIsjn+dkde
 dG9mXk5QrvbpihgpcmNbtloSdkRZ02lsxkUzpG8U64X8WK6LuRz7BZ7p5t/WzaR/hCdOiQCG
 RNup2UTNDrZpWxpwadXMnJsyJcVX4BAKaWGsm5IQyXXBUdguHVa7To/JIBlhjlKackKWoBnI
 Ojl8VQhVLcD551iJ61w4aQH6bHxdTjz65MT2OrW/mFZbtIwWSeif6axrYpVCyERIDEKrX5AV
 rOmGEaUGsCd16FueoaM2Hf96BH3SI3/q2w+g058RedLOZVZtyQARAQABzSdBbnRvbmlvIFF1
 YXJ0dWxsaSA8YW50b25pb0BvcGVudnBuLm5ldD7Cwa0EEwEIAFcCGwMFCwkIBwMFFQoJCAsF
 FgIDAQACHgECF4AFCRWQ2TIWIQTKvaEoIBfCZyGYhcdI8My2j1nRTAUCYRUquBgYaGtwczov
 L2tleXMub3BlbnBncC5vcmcACgkQSPDMto9Z0UzmcxAAjzLeD47We0R4A/14oDKlZxXO0mKL
 fCzaWFsdhQCDhZkgxoHkYRektK2cEOh4Vd+CnfDcPs/iZ1i2+Zl+va79s4fcUhRReuwi7VCg
 7nHiYSNC7qZo84Wzjz3RoGYyJ6MKLRn3zqAxUtFECoS074/JX1sLG0Z3hi19MBmJ/teM84GY
 IbSvRwZu+VkJgIvZonFZjbwF7XyoSIiEJWQC+AKvwtEBNoVOMuH0tZsgqcgMqGs6lLn66RK4
 tMV1aNeX6R+dGSiu11i+9pm7sw8tAmsfu3kQpyk4SB3AJ0jtXrQRESFa1+iemJtt+RaSE5LK
 5sGLAO+oN+DlE0mRNDQowS6q/GBhPCjjbTMcMfRoWPCpHZZfKpv5iefXnZ/xVj7ugYdV2T7z
 r6VL2BRPNvvkgbLZgIlkWyfxRnGh683h4vTqRqTb1wka5pmyBNAv7vCgqrwfvaV1m7J9O4B5
 PuRjYRelmCygQBTXFeJAVJvuh2efFknMh41R01PP2ulXAQuVYEztq3t3Ycw6+HeqjbeqTF8C
 DboqYeIM18HgkOqRrn3VuwnKFNdzyBmgYh/zZx/dJ3yWQi/kfhR6TawAwz6GdbQGiu5fsx5t
 u14WBxmzNf9tXK7hnXcI24Z1z6e5jG6U2Swtmi8sGSh6fqV4dBKmhobEoS7Xl496JN2NKuaX
 jeWsF2rOwE0EZmhJFwEIAOAWiIj1EYkbikxXSSP3AazkI+Y/ICzdFDmiXXrYnf/mYEzORB0K
 vqNRQOdLyjbLKPQwSjYEt1uqwKaD1LRLbA7FpktAShDK4yIljkxhvDI8semfQ5WE/1Jj/I/Q
 U+4VXhkd6UvvpyQt/LiWvyAfvExPEvhiMnsg2zkQbBQ/M4Ns7ck0zQ4BTAVzW/GqoT2z03mg
 p1FhxkfzHMKPQ6ImEpuY5cZTQwrBUgWif6HzCtQJL7Ipa2fFnDaIHQeiJG0RXl/g9x3YlwWG
 sxOFrpWWsh6GI0Mo2W2nkinEIts48+wNDBCMcMlOaMYpyAI7fT5ziDuG2CBA060ZT7qqdl6b
 aXUAEQEAAcLBfAQYAQgAJhYhBMq9oSggF8JnIZiFx0jwzLaPWdFMBQJmaEkXAhsMBQkB4TOA
 AAoJEEjwzLaPWdFMbRUP/0t5FrjF8KY6uCU4Tx029NYKDN9zJr0CVwSGsNfC8WWonKs66QE1
 pd6xBVoBzu5InFRWa2ed6d6vBw2BaJHC0aMg3iwwBbEgPn4Jx89QfczFMJvFm+MNc2DLDrqN
 zaQSqBzQ5SvUjxh8lQ+iqAhi0MPv4e2YbXD0ROyO+ITRgQVZBVXoPm4IJGYWgmVmxP34oUQh
 BM7ipfCVbcOFU5OPhd9/jn1BCHzir+/i0fY2Z/aexMYHwXUMha/itvsBHGcIEYKk7PL9FEfs
 wlbq+vWoCtUTUc0AjDgB76AcUVxxJtxxpyvES9aFxWD7Qc+dnGJnfxVJI0zbN2b37fX138Bf
 27NuKpokv0sBnNEtsD7TY4gBz4QhvRNSBli0E5bGUbkM31rh4Iz21Qk0cCwR9D/vwQVsgPvG
 ioRqhvFWtLsEt/xKolOmUWA/jP0p8wnQ+3jY6a/DJ+o5LnVFzFqbK3fSojKbfr3bY33iZTSj
 DX9A4BcohRyqhnpNYyHL36gaOnNnOc+uXFCdoQkI531hXjzIsVs2OlfRufuDrWwAv+em2uOT
 BnRX9nFx9kPSO42TkFK55Dr5EDeBO3v33recscuB8VVN5xvh0GV57Qre+9sJrEq7Es9W609a
 +M0yRJWJEjFnMa/jsGZ+QyLD5QTL6SGuZ9gKI3W1SfFZOzV7hHsxPTZ6
Organization: OpenVPN Inc.
In-Reply-To: <Z3gXs65jjYc-g2iw@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sabrina,

On 03/01/2025 18:00, Sabrina Dubroca wrote:
> Hello Antonio,
> 
> 2024-12-19, 02:42:01 +0100, Antonio Quartulli wrote:
>> +static void ovpn_socket_release_kref(struct kref *kref)
>> +	__releases(sock->sock->sk)
>> +{
>> +	struct ovpn_socket *sock = container_of(kref, struct ovpn_socket,
>> +						refcount);
>> +
> 
> [extend with bits of patch 9]
>> 	/* UDP sockets are detached in this kref callback because
>> 	 * we now know for sure that all concurrent users have
>> 	 * finally gone (refcounter dropped to 0).
>> 	 *
>> 	 * Moreover, detachment is performed under lock to prevent
>> 	 * a concurrent ovpn_socket_new() call with the same socket
>> 	 * to find the socket still attached but with refcounter 0.
> 
> I'm not convinced this really works, because ovpn_socket_new() doesn't
> use the same lock. lock_sock and bh_lock_sock both "lock the socket"
> in some sense, but they're not mutually exclusive (we talked about
> that around the TCP patch).

You're right - but what prevents us from always using bh_lock_sock?

> 
> Are you fundamentally opposed to making attach permanent? ie, once
> a UDP or TCP socket is assigned to an ovpn instance, it can't be
> detached and reused. I think it would be safer, simpler, and likely
> sufficient (I don't know openvpn much, but I don't see a use case for
> moving a socket from one ovpn instance to another, or using it without
> encap).

I hardly believe a socket will ever be moved to a different instance.
There is no use case (and no userspace support) for that at the moment.

> 
> Rough idea:
>   - ovpn_socket_new is pretty much unchanged (locking still needed to
>     protect against another simultaneous attach attempt, EALREADY case
>     becomes a bit easier)
>   - ovpn_peer_remove doesn't do anything socket-related
>   - use ->encap_destroy/ovpn_tcp_close() to clean up sk_user_data
>   - no more refcounting on ovpn_socket (since the encap can't be
>     removed, the lifetime to ovpn_socket is tied to its socket)
> 
> What do you think?

hmm how would that work with UDP?
On a server all clients may disconnect, but the UDP socket is expected 
to still survive and be re-used for new clients (userspace will keep it 
alive and keep listening for new clients).

Or you're saying that the socket will remain "attached" (i.e. 
sk_user_data set to the ovpn_priv*) even when no more clients are connected?

> 
> I'm trying to poke holes into this idea now. close() vs attach worries
> me a bit.

Can that truly happen?
If a socket is going through close(), there should be some way to mark 
it as "non-attachable".

Actually, do we even need to clean up sk_user_data? The socket is being 
destroyed - why clean that up at all?

> 
> 
>> 	 */
>> 	if (sock->sock->sk->sk_protocol == IPPROTO_UDP)
>> 		ovpn_udp_socket_detach(sock->sock);
> 
> 
>> +	bh_unlock_sock(sock->sock->sk);
>> +	sockfd_put(sock->sock);
>> +	kfree_rcu(sock, rcu);
>> +}
> 
> [...]
>> +struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
>> +{
>> +	struct ovpn_socket *ovpn_sock;
>> +	int ret;
>> +
>> +	lock_sock(sock->sk);
>> +
>> +	ret = ovpn_socket_attach(sock, peer);
>> +	if (ret < 0 && ret != -EALREADY)
>> +		goto err_release;
>> +
>> +	/* if this socket is already owned by this interface, just increase the
>> +	 * refcounter and use it as expected.
>> +	 *
>> +	 * Since UDP sockets can be used to talk to multiple remote endpoints,
>> +	 * openvpn normally instantiates only one socket and shares it among all
>> +	 * its peers. For this reason, when we find out that a socket is already
>> +	 * used for some other peer in *this* instance, we can happily increase
>> +	 * its refcounter and use it normally.
>> +	 */
>> +	if (ret == -EALREADY) {
>> +		/* caller is expected to increase the sock refcounter before
>> +		 * passing it to this function. For this reason we drop it if
>> +		 * not needed, like when this socket is already owned.
>> +		 */
>> +		ovpn_sock = ovpn_socket_get(sock);
>> +		release_sock(sock->sk);
>> +		sockfd_put(sock);
>> +		return ovpn_sock;
>> +	}
>> +
>> +	ovpn_sock = kzalloc(sizeof(*ovpn_sock), GFP_KERNEL);
>> +	if (!ovpn_sock) {
>> +		ret = -ENOMEM;
>> +		goto err_detach;
>> +	}
>> +
>> +	ovpn_sock->ovpn = peer->ovpn;
>> +	ovpn_sock->sock = sock;
>> +	kref_init(&ovpn_sock->refcount);
>> +
>> +	rcu_assign_sk_user_data(sock->sk, ovpn_sock);
>> +	release_sock(sock->sk);
>> +
>> +	return ovpn_sock;
>> +err_detach:
>> +	if (sock->sk->sk_protocol == IPPROTO_UDP)
>> +		ovpn_udp_socket_detach(sock);
> 
> This would leave the TCP socket half-attached, and if userspace tries
> to attach the same socket again (I don't think the ovpn module would
> prevent that since sk_user_data is still unset), both ->sk_data_ready
> and tcp.sk_cb.sk_data_ready will be set to ovpn's (same for
> sk_write_space with ovpn_tcp_write_space which will recurse into
> itself when called).
> 
> I think it'd be easier to do the alloc first, then attach. Handling a
> failure to attach would be a simple kfree, while handling a failure to
> alloc is a detach (or part of a detach) which is not as easy.

Yap, makes sense!

> 
> 
> 
>> +int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_priv *ovpn)
>> +{
>> +	struct ovpn_socket *old_data;
>> +	int ret = 0;
>> +
>> +	/* make sure no pre-existing encapsulation handler exists */
>> +	rcu_read_lock();
>> +	old_data = rcu_dereference_sk_user_data(sock->sk);
>> +	if (!old_data) {
>> +		/* socket is currently unused - we can take it */
>> +		rcu_read_unlock();
>> +		return 0;
>> +	}
>> +
>> +	/* socket is in use. We need to understand if it's owned by this ovpn
>> +	 * instance or by something else.
>> +	 * In the former case, we can increase the refcounter and happily
>> +	 * use it, because the same UDP socket is expected to be shared among
>> +	 * different peers.
>> +	 *
>> +	 * Unlikely TCP, a single UDP socket can be used to talk to many remote
> 
> nit: s/Unlikely/Unlike/

ACK

> 
>> +	 * hosts and therefore openvpn instantiates one only for all its peers
>> +	 */

Thanks a lot!

Regards,


> 

-- 
Antonio Quartulli
OpenVPN Inc.


