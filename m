Return-Path: <linux-kselftest+bounces-21507-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C38619BDB15
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 02:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E93FB20F1A
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 01:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E7C186E20;
	Wed,  6 Nov 2024 01:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1wU+Fma"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E09225745;
	Wed,  6 Nov 2024 01:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730855912; cv=none; b=rVMEBHzBSLdYlgIxUaId3eVyzVmBL3TOBxC64qNSXfIL7tpA5pRsdS2WRIU285SQ0U1tZ94gbBsTpry6RNqngQoeUmeH7447JTI/YxlxAdYzxs9ssVhE2StGh1ZlKQbAXu7rotnD1wXvNSbqVPrEoL/IjGqfmcmnSg4l+yS4YH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730855912; c=relaxed/simple;
	bh=P0UmvgWl7d5aGHUxmqCPKTF4JvQ9tOah+x0Fjqo4Ssc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f0LH26G/Pb4+ZL6lOyX3QX+y3KBGQrt5vDhSZJzlD+5wL4kQogXmbwhhywm+ft1I1L1C5bcljpuIk3CgQ8E2m14mM0wkj034BK5z/xh9ZQEBUysBeNPoIzirFx44X2zwg2QVr7sl+xuD1uMjozc1R1n2qn8RzuQCzcZ3twQukzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1wU+Fma; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d5689eea8so3571340f8f.1;
        Tue, 05 Nov 2024 17:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730855908; x=1731460708; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xFPKbm5D0TWedCl1uCwOWGVEbxxEgVoeM/6CmwRNIGA=;
        b=O1wU+Fmam0Gepw9/5y+YWXU4ebBQmKcp+TchU47zbtkqNpbi01td8Q+MLOgV9eaydL
         J4bGWOuj8uJsnpDmRBFyak0MEJt4ZMpxjNmh9y04pXoHo0M4dKl2XTmXNIL31Dz2Cova
         3WfvpEvmYqBgDp3YXeJVuijjZ3NTf00VpmdKFwqGPEACKeUlQVsuU3TKrX9WfvKkZS2o
         2479gCKSJA1s8JwtYUwO6fdfqbUL6W3o53xaaxwAApExpeCA7jj9V2N4moYelt1eyhr4
         PVvwnZt6h8xie10FxQvSX24NIzrXhubaHGC4Mgz9IWNQHmYhqMWMmljssE9rujtVcfsX
         yXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730855908; x=1731460708;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xFPKbm5D0TWedCl1uCwOWGVEbxxEgVoeM/6CmwRNIGA=;
        b=C0C1FDIgP+BINlgCUquVhPvBrg25h6k5RPbxJAJiS2GT/fCjbMiGfofBcG9IQhipuh
         DMrHFt3+65Z4KL3W0VUKWWxXavvyV7te28odreoj1S5RlL+I3RtHaw1ZHDZb4z6wivKG
         wjzm6OEduALgBx6qLOgB8dTRcrY9UJwAulI605lPPLW2Jv2Oe8UJF+uHRMRuuwjrothN
         22e3JrwezHSWzhBkxChufNib46Zzk47ROkm7fbZEs8rzJdbC2//zo16P4vGIaimVaMJ0
         USZru0xjwwgt2eYWVf+wal/KthnCqXnPO8PE2AYOtsRcl979mn+ESCZyGQlKnf7YaGzz
         4hvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZtuDpS10/pAPUj/gj1UalYTnlSHMIfSUkzTP6R0qR4YJWSsxHdcIeIYUxBzEF0u7hTYe6QW5Vy43FJ6Q=@vger.kernel.org, AJvYcCUo9tcB18Rbsf5+u4ap/DmhmuH3eum+MGhxYLglF46dJWkjVcr72XeaqSyjhV9iS1NzKdji0Cd13aivd498Xe4y@vger.kernel.org, AJvYcCVRKAzkSLcj8Cc7s6/1d+avaz/yQq3LIWrKkP8oe/7buieqQWE0bTVA8DmqtmGmRw0FHgZ71ssT@vger.kernel.org
X-Gm-Message-State: AOJu0YzPeVbNFhjgA6kUZ5VSo8vO7ZkE3Y+c0guDqfbosIx6LboHSu1V
	GbQpSOz8Od+1z0qrKWVvnpTAImlQbkn5RKSaAIjxE6ikyQW1/HBP
X-Google-Smtp-Source: AGHT+IF14WoEilUZUUkoGwizvBJZSycpKBCQVxKXdYSKH2B5PNhe9eJbdwNZFsqq3AP3+XtalRH4RA==
X-Received: by 2002:a5d:5711:0:b0:37d:47b0:6adc with SMTP id ffacd0b85a97d-380610f8251mr27420586f8f.4.1730855908258;
        Tue, 05 Nov 2024 17:18:28 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7d20sm17845024f8f.7.2024.11.05.17.18.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 17:18:27 -0800 (PST)
Message-ID: <2828411f-f2e5-4dfc-80ff-577eb5fd359a@gmail.com>
Date: Wed, 6 Nov 2024 03:18:53 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 00/23] Introducing OpenVPN Data Channel
 Offload
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 steffen.klassert@secunet.com, antony.antony@secunet.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Antonio,

On 29.10.2024 12:47, Antonio Quartulli wrote:
> Notable changes from v10:
> * extended commit message of 23/23 with brief description of the output
> * Link to v10: https://lore.kernel.org/r/20241025-b4-ovpn-v10-0-b87530777be7@openvpn.net
> 
> Please note that some patches were already reviewed by Andre Lunn,
> Donald Hunter and Shuah Khan. They have retained the Reviewed-by tag
> since no major code modification has happened since the review.
> 
> The latest code can also be found at:
> 
> https://github.com/OpenVPN/linux-kernel-ovpn

As I promised many months ago I am starting publishing some nit picks 
regarding the series. The review was started when series was V3 
"rebasing" the review to every next version to publish it at once. But I 
lost this race to the new version releasing velocity :) So, I am going 
to publish it patch-by-patch.

Anyway you and all participants have done a great progress toward making 
accelerator part of the kernel. Most of considerable things already 
resolved so do not wait me please to finish picking every nit.

Regarding "big" topics I have only two concerns: link creation using 
RTNL and a switch statement usage. In the corresponding thread, I asked 
Jiri to clarify that "should" regarding .newlink implementation. Hope he 
will have a chance to find a time to reply.

For the 'switch' statement, I see a repeating pattern of handling 
mode-or family-specific cases like this:

int ovpn_peer_add(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
{
   switch (ovpn->mode) {
   case OVPN_MODE_MP:
     return ovpn_peer_add_mp(ovpn, peer);
   case OVPN_MODE_P2P:
     return ovpn_peer_add_p2p(ovpn, peer);
   default:
     return -EOPNOTSUPP;
   }
}

or

void ovpn_encrypt_post(void *data, int ret)
{
   ...
   switch (peer->sock->sock->sk->sk_protocol) {
   case IPPROTO_UDP:
     ovpn_udp_send_skb(peer->ovpn, peer, skb);
     break;
   case IPPROTO_TCP:
     ovpn_tcp_send_skb(peer, skb);
     break;
   default:
     /* no transport configured yet */
     goto err;
   }
   ...
}

or

void ovpn_peer_keepalive_work(...)
{
   ...
   switch (ovpn->mode) {
   case OVPN_MODE_MP:
     next_run = ovpn_peer_keepalive_work_mp(ovpn, now);
     break;
   case OVPN_MODE_P2P:
     next_run = ovpn_peer_keepalive_work_p2p(ovpn, now);
     break;
   }
   ...
}

Did you consider to implement mode specific operations as a set of 
operations like this:

ovpn_ops {
   int (*peer_add)(struct ovpn_struct *ovpn, struct ovpn_peer *peer);
   int (*peer_del)(struct ovpn_peer *peer, enum ovpn_del_peer_reason 
reason);
   void (*send_skb)(struct ovpn_peer *peer, struct sk_buff *skb);
   time64_t (*keepalive_work)(...);
};

Initialize them during the interface creation and invoke these 
operations indirectly. E.g.

int ovpn_peer_add(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
{
   return ovpn->ops->peer_add(ovpn, peer);
}

void ovpn_encrypt_post(void *data, int ret)
{
   ...
   ovpn->ops->send_skb(peer, skb);
   ...
}

void ovpn_peer_keepalive_work(...)
{
   ...
   next_run = ovpn->ops->keepalive_work(ovpn, now);
   ...
}

Anyway the module has all these option values in advance during the 
network interface creation phase and I believe replacing 'switch' 
statements with indirect calls can make code easy to read.

--
Sergey

