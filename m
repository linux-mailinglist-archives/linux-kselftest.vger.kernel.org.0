Return-Path: <linux-kselftest+bounces-30012-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC39A78DB8
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 14:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBE25188E0A9
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 12:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FAE238141;
	Wed,  2 Apr 2025 12:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="LxVECP/T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5C120E00A
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Apr 2025 12:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743595296; cv=none; b=EXQH7sTj0JG1ClmcPTZVUKtIRZtniYA3rhTsP02LGJHCcQc1FNgvwTzkzrfxAayz8G7NC49fV/rQYGXSVLOOUTvdmACL49Tho88vU9mR+Yr/6aam2pBrqgjzWvDJaF61FcgHlDO23/2i3b7W29Ql2FTcVX1AkUKmlGNdzt9NW7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743595296; c=relaxed/simple;
	bh=PKE5qfiiVZCk3Ro1o/d+CtDLSVe26DM/L2sFigjHS78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aFYZ4ALBy7xKrcV3IE5r17n4Z7Iyl7eztn+igjUa+SWZZu3fNFFm21vAzqu1f7Bg75Ey/oU7QJBEuL/2jNG6J+ImUE6uJNGSjykOvA33qVsNvaBmXcMZu1VP8JVozfBqHp/JyHKLNhiKnGK6l6vHedHCNn++oForb2xULoOwQ+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=LxVECP/T; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cfb6e9031so59573085e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Apr 2025 05:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1743595293; x=1744200093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aKLsUV9G46N8nrsin1l1UMCYuJEFXtz/W/8hrAgqF0g=;
        b=LxVECP/TVOFTJD68OvLFHx4av3MKHy6G69ilmSdvDzPM7Q5aVUbyeX8hPStM1vwTZQ
         tu5h53p2e8nwB1lYqrhJDZ/nGXY/nK0/zJ3CN35j8oUXVTc2ljMg7Hfyc0eTgsL1wCU7
         GBgGf9zocHflVLiAFnIeJ1xoxkrn8IQLwCvyI0+4a/bUhGFxCac3DLvJy1R+4FfTHaG1
         MDee5hDnd30mriab9NzOe+Ypb6pIJH0g84ut/A2tJ4F7zHpYhBSZN0k1sYzKM5MLg469
         lX1RA+QANTZ5OuKe2MLTZ08NGuUN7kjaSZ5VwFfERH+QE6YyHyLxTMY3Q0HhjK0o9qkY
         znvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743595293; x=1744200093;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKLsUV9G46N8nrsin1l1UMCYuJEFXtz/W/8hrAgqF0g=;
        b=ahMaD/jqb6wGqhY3HcrwFezDz5EntLs79i4FVHVyfWMDRiAapjDhASzpFbdD2hIzG2
         gPkN4u6jZjcYFRptE8BiWBTXCURZ1nA6/kajL1sdazx6tEWxqOWMyS3CIeuLbcVDD860
         8MQdGuvciJlmUo12di37C/j/98+7a5CdLMe3HATvueLcJz/wnXV5py7wrz2dMur7PtM+
         I4x9DXC/tFTmJO28q/yuI6gJJ0ZiG33J0GVJb8oNfmsHxqS+GrYYlpxlNlnkp3BmpbHw
         GI6q90qZqG0Q4q3mzQqUrPxmxF6gJlvr0eeNYBNp6E6KcDdyFrooVKwAKBgJrrYztm07
         iNhg==
X-Forwarded-Encrypted: i=1; AJvYcCXc/iAsxhN49cg4jCihv2n1qFucScAG8V836Fl6ie5pxUJFVArgz/2WuxQxoQZTHDkFpgOBOgtgt+8Z3D9lZbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrlCygibT9r9u9Rwsl1zatsZaBQCM64D7aNCqVJ2dU12Rcboqb
	9BG/wuRkGVtAOFQzU42KjhLoq3syP4bKQeUX8gvv9MXFAu44f0M2LZlPri24nJ/fexAJ72dRazN
	b2e0uKHUuByKg/WSIO5ZE9iHti1FiR6CUCkhtm3yZw/s5CCByf3kCv0v2cTc=
X-Gm-Gg: ASbGncvLxP9Aei0X2c2W8riXlCTfPh7WNM8gikB1AmocY2/q7ab2GBgSci93AdRodu5
	t24kw+gNuviuUmjcfHhUJHbmdZq9AiJHUv1Aq+CdshtLSnwT+QjN8W+YxJedkt0ZbamiBy/mhww
	IWorcOSS77kYk2yiHouPxxRlgYbmqmtNPwbTe+OzqmyKYqVVuqwXdeyDG2RPtgiQhDgtSmAhinx
	gtGpJcdzUfdXGGFWFM4+O9dV/whpefnhuHTsDeCCzE1GgRV2i47SvwR6cYiedAd8UiIVFDASkZr
	e425vUHzNiCY8ayyCDVUIgqc+WRM8ZgPc3kS9yqjge0f96d1Ckht3KRWNTdy2c1wuU2EIaGldmQ
	HtUe34pE=
X-Google-Smtp-Source: AGHT+IE1MjV6Q+oWtEiQ0gx3yVxATQdYV81lzqZn7Jt1Sm1oubfet43l1MNL2xIJ4QPrbuDd4octMA==
X-Received: by 2002:a05:600c:1c15:b0:43c:f969:13c0 with SMTP id 5b1f17b1804b1-43db85250eemr140089385e9.29.1743595292754;
        Wed, 02 Apr 2025 05:01:32 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:9a9c:dc9e:39c6:2380? ([2001:67c:2fbc:1:9a9c:dc9e:39c6:2380])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43eb5fc5924sm18759155e9.7.2025.04.02.05.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 05:01:31 -0700 (PDT)
Message-ID: <5e968611-407b-4496-a333-82aa7c22ca29@openvpn.net>
Date: Wed, 2 Apr 2025 14:01:30 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v24 07/23] ovpn: implement basic TX path (UDP)
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
References: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
 <20250318-b4-ovpn-v24-7-3ec4ab5c4a77@openvpn.net> <Z-vu7AWTwWE2D_df@krikkit>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z-vu7AWTwWE2D_df@krikkit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/04/2025 15:49, Sabrina Dubroca wrote:
> 2025-03-18, 02:40:42 +0100, Antonio Quartulli wrote:
>> +static int ovpn_udp_output(struct ovpn_peer *peer, struct dst_cache *cache,
>> +			   struct sock *sk, struct sk_buff *skb)
>> +{
>> +	struct ovpn_bind *bind;
>> +	int ret;
>> +
>> +	/* set sk to null if skb is already orphaned */
>> +	if (!skb->destructor)
>> +		skb->sk = NULL;
>> +
>> +	/* always permit openvpn-created packets to be (outside) fragmented */
>> +	skb->ignore_df = 1;
> 
> Have you tested this with IPv4 encap? AFAICT it doesn't have any
> effect because of the call chain:
> 
> ovpn_udp4_output -> udp_tunnel_xmit_skb -> iptunnel_xmit -> skb_scrub_packet
> 
> which does
> 
>      skb->ignore_df = 0;
> 
> 
> But since you pass df = 0 to udp_tunnel_xmit_skb, I suspect it works
> as intended despite skb_scrub_packet.

Yeah, seems so. Passing df = 0 basically does what we need.
So you're right, that ignore_df = 1 is useless.
Will drop it.

> 
> 
> [note: that was the last comment I wanted to send, I have a few more
> suggestions that don't need to be addressed at this time]

Thanks! :-)
I'll answer all other open comments in the meantime..

Regards,

> 
>> +
>> +	rcu_read_lock();
>> +	bind = rcu_dereference(peer->bind);
>> +	if (unlikely(!bind)) {
>> +		net_warn_ratelimited("%s: no bind for remote peer %u\n",
>> +				     netdev_name(peer->ovpn->dev), peer->id);
>> +		ret = -ENODEV;
>> +		goto out;
>> +	}
>> +
>> +	switch (bind->remote.in4.sin_family) {
>> +	case AF_INET:
>> +		ret = ovpn_udp4_output(peer, bind, cache, sk, skb);
>> +		break;
>> +#if IS_ENABLED(CONFIG_IPV6)
>> +	case AF_INET6:
>> +		ret = ovpn_udp6_output(peer, bind, cache, sk, skb);
>> +		break;
>> +#endif
>> +	default:
>> +		ret = -EAFNOSUPPORT;
>> +		break;
>> +	}
>> +
>> +out:
>> +	rcu_read_unlock();
>> +	return ret;
>> +}
> 

-- 
Antonio Quartulli
OpenVPN Inc.


