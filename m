Return-Path: <linux-kselftest+bounces-22100-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BB69CE167
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 15:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 520BFB3AD9B
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 14:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FCF1CEEBA;
	Fri, 15 Nov 2024 14:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="VISo3WXJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB001CEE92
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Nov 2024 14:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731680894; cv=none; b=gdDTNK0xrYVb7oKptPPKus5QZ9ytkasr8z9wimhBIHTYIx9hObwGqwLYkEh94NLJGMkj4N2Euve/G9ojTitysMBhONXoTrVQvDX5UJCQ9DQnL4NybsokRSeNYBZ4g3Vn0+QA6u7kBk67dDYDdjaNN7v5IjQheqNwACOM83jZo94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731680894; c=relaxed/simple;
	bh=jamWgIHOfsaao7wOpcgdVVGn6tQ9PQTvF2Rh2OgqkrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e87dirN8SE8zyPGjI3iNh0NkSBdrtF7QOxbM8Uk9MVN7TSHQPKhUDwIMEr2mXqVFR4es+Bvnlw8nnDr9B1BkgdXYsZEFtQ2SEQdaFjw1ar6NH71Y4UW72GTx7srbP6DyJMVrTZYOIEnoBMvRjG2SJb5SYjROMW2YfdvI899Rceo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=VISo3WXJ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso341644166b.1
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Nov 2024 06:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1731680890; x=1732285690; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rQn0oEs9QyHotplMurlph4uEPp/pBuFKtx+BZ+a7uRE=;
        b=VISo3WXJVeksKyPxa5bQHKxYNxnsBgLLfx/HkOUi0yuB00cFtFddA9dDjnSBUIgnrI
         xtJ7DLsVzzQuewpsLlv04UzGNhinUj93kkIT2GFex0umhH/HplFYeikAJsas68J+RfbQ
         p6UZdKbQyTK/FTZyJa1hrOOGAbTfGdbjFsccCrHfxXxJKD2KBq4fH0eczr7XmAfmcViU
         ohzpBR/xtDSOPCU4BvJjTpgd5WGd+P8kZRoqQHTac1KgKBZMGpCgbFrrN9zXoIqbFMP8
         53ha3Md9eauJILJUasQGmOqI403tHYSSOzeJAleVad+1FPfKna7ZE1YfzBqCqgC/QQxC
         WJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731680890; x=1732285690;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQn0oEs9QyHotplMurlph4uEPp/pBuFKtx+BZ+a7uRE=;
        b=dXge/AWamaYgKLpyaA3Zaj8ckGGV/ZgN39Qf8VB/HiwIqvZUFqpE+t87K1vlmeqfA8
         wMQiqSTf6XR6TNtsw0Y23J1MUO8ziNpnK5VTl/IDxsf+6ivskw1QzSRtWd7tB3Z6aSi/
         2+v69DtSSSQh49j32KYgMvGH7RojESFJv4CpwBuFTguWvH+rOOr4/wTdU70pV/s8WT1k
         sWfVqruqPs6R/gThEbyRAOcurUfg8W7S97j2woJp8lCZH2SGelJeUtPXNPOXoGwx3QmU
         waxOOClumpwcjjuNnUPWs1nLPE2ZUFxiJjNT1YBWhBXJig8FaYQvkLkD5Im8R5dgGo53
         Mviw==
X-Forwarded-Encrypted: i=1; AJvYcCW3TU1TEIsSXnqNeXZx7krozSFiY5l3XjL6dj/wz6kiAI9t0kKE4K1xDByIbLymhIVFb2HIjKGIQj4hI1b6azY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBrGR4Qj3X5t3GzbrUoObfzlDFFZPTrWtwK39BHfOzhGYrHiLr
	wjnesO20zr66hxkgLo3GSQ/yAu0bavX+TSSIdzVE3WFANkcLFGrJNQ2RyUaYNU4=
X-Google-Smtp-Source: AGHT+IGaUMla6ZjgSDWnnCnYUl46HeUl6IqrHc/pzDr2xXO5/v4ZeJGWGvJdJVEhv9LSg8Qpc7f5Ew==
X-Received: by 2002:a17:907:9289:b0:a9a:6752:ba80 with SMTP id a640c23a62f3a-aa4833f67a5mr273809166b.5.1731680890282;
        Fri, 15 Nov 2024 06:28:10 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:59f4:10be:886a:27eb? ([2001:67c:2fbc:1:59f4:10be:886a:27eb])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e043bc9sm182867166b.142.2024.11.15.06.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 06:28:09 -0800 (PST)
Message-ID: <1dffb833-1688-4572-bbf8-c6524cd84402@openvpn.net>
Date: Fri, 15 Nov 2024 15:28:35 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 07/23] ovpn: introduce the ovpn_socket object
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-7-de4698c73a25@openvpn.net>
 <62d382f8-ea45-4157-b54b-8fed7bdafcca@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <62d382f8-ea45-4157-b54b-8fed7bdafcca@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/11/2024 19:26, Sergey Ryazanov wrote:
> On 29.10.2024 12:47, Antonio Quartulli wrote:
>> This specific structure is used in the ovpn kernel module
>> to wrap and carry around a standard kernel socket.
>>
>> ovpn takes ownership of passed sockets and therefore an ovpn
>> specific objects is attached to them for status tracking
>> purposes.
>>
>> Initially only UDP support is introduced. TCP will come in a later
>> patch.
>>
>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> 
> [...]
> 
>> diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
>> new file mode 100644
>> index 
>> 0000000000000000000000000000000000000000..090a3232ab0ec19702110f1a90f45c7f10889f6f
>> --- /dev/null
>> +++ b/drivers/net/ovpn/socket.c
>> @@ -0,0 +1,120 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*  OpenVPN data channel offload
>> + *
>> + *  Copyright (C) 2020-2024 OpenVPN, Inc.
>> + *
>> + *  Author:    James Yonan <james@openvpn.net>
>> + *        Antonio Quartulli <antonio@openvpn.net>
>> + */
>> +
>> +#include <linux/net.h>
>> +#include <linux/netdevice.h>
>> +
>> +#include "ovpnstruct.h"
>> +#include "main.h"
>> +#include "io.h"
>> +#include "peer.h"
>> +#include "socket.h"
>> +#include "udp.h"
>> +
>> +static void ovpn_socket_detach(struct socket *sock)
>> +{
>> +    if (!sock)
>> +        return;
>> +
>> +    sockfd_put(sock);
>> +}
>> +
>> +/**
>> + * ovpn_socket_release_kref - kref_put callback
>> + * @kref: the kref object
>> + */
>> +void ovpn_socket_release_kref(struct kref *kref)
>> +{
>> +    struct ovpn_socket *sock = container_of(kref, struct ovpn_socket,
>> +                        refcount);
>> +
>> +    ovpn_socket_detach(sock->sock);
>> +    kfree_rcu(sock, rcu);
>> +}
>> +
>> +static bool ovpn_socket_hold(struct ovpn_socket *sock)
>> +{
>> +    return kref_get_unless_zero(&sock->refcount);
> 
> Why do we need to wrap this kref acquiring call into the function. Why 
> we cannot simply call kref_get_unless_zero() from ovpn_socket_get()?

Generally I prefer to keep the API among objects consistent.
In this specific case, it means having hold() and put() helpers in order 
to avoid calling kref_* functions directly in the code.

This is a pretty simple case because hold() is called only once, but I 
still like to be consistent.

> 
>> +}
>> +
>> +static struct ovpn_socket *ovpn_socket_get(struct socket *sock)
>> +{
>> +    struct ovpn_socket *ovpn_sock;
>> +
>> +    rcu_read_lock();
>> +    ovpn_sock = rcu_dereference_sk_user_data(sock->sk);
>> +    if (!ovpn_socket_hold(ovpn_sock)) {
>> +        pr_warn("%s: found ovpn_socket with ref = 0\n", __func__);
> 
> Should we be more specific here and print warning with 
> netdev_warn(ovpn_sock->ovpn->dev, ...)?

ACK must be an unnoticed leftover

> 
> And, BTW, how we can pick-up a half-destroyed socket?

I don't think this can happen under basic conditions.
But I am pretty sure in case of bugs this *could* happen quite easily.

[...]

>> +/**
>> + * ovpn_udp_socket_attach - set udp-tunnel CBs on socket and link it 
>> to ovpn
>> + * @sock: socket to configure
>> + * @ovpn: the openvp instance to link
>> + *
>> + * After invoking this function, the sock will be controlled by ovpn 
>> so that
>> + * any incoming packet may be processed by ovpn first.
>> + *
>> + * Return: 0 on success or a negative error code otherwise
>> + */
>> +int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct 
>> *ovpn)
>> +{
>> +    struct ovpn_socket *old_data;
>> +    int ret = 0;
>> +
>> +    /* sanity check */
>> +    if (sock->sk->sk_protocol != IPPROTO_UDP) {
> 
> The function will be called only for a UDP socket. The caller makes sure 
> this is truth. So, why do we need this check?

To avoid this function being copied/called somewhere else in the future 
and we forget about this critical assumption.

Indeed it's a just sanity check.

> 
>> +        DEBUG_NET_WARN_ON_ONCE(1);
>> +        return -EINVAL;
>> +    }
>> +
>> +    /* make sure no pre-existing encapsulation handler exists */
>> +    rcu_read_lock();
>> +    old_data = rcu_dereference_sk_user_data(sock->sk);
>> +    if (!old_data) {
>> +        /* socket is currently unused - we can take it */
>> +        rcu_read_unlock();
>> +        return 0;
>> +    }
>> +
>> +    /* socket is in use. We need to understand if it's owned by this 
>> ovpn
>> +     * instance or by something else.
>> +     * In the former case, we can increase the refcounter and happily
>> +     * use it, because the same UDP socket is expected to be shared 
>> among
>> +     * different peers.
>> +     *
>> +     * Unlikely TCP, a single UDP socket can be used to talk to many 
>> remote
>> +     * hosts and therefore openvpn instantiates one only for all its 
>> peers
>> +     */
>> +    if ((READ_ONCE(udp_sk(sock->sk)->encap_type) == 
>> UDP_ENCAP_OVPNINUDP) &&
>> +        old_data->ovpn == ovpn) {
>> +        netdev_dbg(ovpn->dev,
>> +               "%s: provided socket already owned by this interface\n",
>> +               __func__);
> 
> Why do we need the function name being printed here?

leftover, will fix, thanks!

> 
>> +        ret = -EALREADY;
>> +    } else {
>> +        netdev_err(ovpn->dev,
>> +               "%s: provided socket already taken by other user\n",
>> +               __func__);
> 
> The same comment regarding the function name printing.

ACK

> 
> And why 'error' level? There is a few ways to fall into this case and 
> each of them implies a user-space screw up. But why we consider these 
> user-space screw ups our (kernel) problem? I suggesting to reduce level 
> at least to 'warning' or maybe even 'notice'. See level definitions in 
> include/linux/kern_levels.h

Yeah, this can be reduced. The error will be reported to the user via 
netlink in any case.

Thanks!

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


