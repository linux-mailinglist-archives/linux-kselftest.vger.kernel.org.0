Return-Path: <linux-kselftest+bounces-21833-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306BA9C4A84
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 01:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E97B4284B14
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 00:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876683D3B3;
	Tue, 12 Nov 2024 00:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+cMn3Do"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85F81F5E6;
	Tue, 12 Nov 2024 00:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731370594; cv=none; b=ac78+EUhvI7WTkOnlRNks9MirvcL/EoPcfupipvWdnn32WCHX/EAXXrrhBfkCdrpJRJF3dp+Hgq0SCkgPNva2kYpj3iX+/iLynFVFYuVt0DPIacexFbwtlbCVycnvNJKmvLDVBjQqUZaDbrneUEhic7ofwU3UtFjTm8gEO6JVZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731370594; c=relaxed/simple;
	bh=oQEHSYw7JZCFOnSD0bt5r6wX9BMVp2W1N43t9O7WbjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VAh1hU3z6IRjUP/rPIWMcZFRJRbRWrp3JvXyLcLf/YO7dkOtDYC2t2SylF+HTtswg1itDvRWDT5O19BcBOb/LV2SoomHgk9lmqKdy5y5rIV72STulimXsBHVdOwK0/s09Hq/qbbdY49fxE02XlO4wWW5eoVMdnwxboGJedQiJNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+cMn3Do; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d3e8d923fso3602402f8f.0;
        Mon, 11 Nov 2024 16:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731370591; x=1731975391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FdRwmpjd/W7NbWdC4kjZYBpGRCpZC2xENVDlhOmySu4=;
        b=U+cMn3DoTc5Tvks8tt4aNOFUu4QvLWuqYKokkuZ2pJ1aPGkABk3QnBPfwDud9BKB8M
         lR9+gQ9yJDV2Z7CFaUytFqYNxLsBAsRA8KbpzlSckbpFW4C3c/KHFOygk/JSHLGO/Sf1
         RpHkHLrNaDAjiNcaitLzDmQcVVRVOkOf3bh6DIi+onyHt9pOMLdpLdLjhuf0fYPxPLbt
         dg7rspZt5XzNoN5iuQrFFFcR+CC/Oygw7a7wg9XP/Nd1jyaG32DUJE5gPwX3tskayQW9
         pHUVrVmU7IGlT+2ekJAWPmHJ6r+ZcCbYZAUskbI94FL/3OFKM06ts0kleCjYwnmT5He0
         kWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731370591; x=1731975391;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FdRwmpjd/W7NbWdC4kjZYBpGRCpZC2xENVDlhOmySu4=;
        b=uTrSPD44KkNMXzPZ9D309CP5s2P4Q0e9h3REZLWmBHoL7fjqkXIrErassWB/aBsugj
         EXSCO/1GPtGXh0PawyRMXd5bE0Vg8B5Ca7+BOR5csx9Z1e4z0YRQUIzVYtMD9X2idHBl
         TmLhjeq1EiwlYSvAY6LuiqSR14tCnOymwIY3+v33aAsihu+PJrFeo28TOCA0TpZ+3Urc
         kVD9BwwMbJ53YKcb5xCnp4JUG1DcXrmO8M3fSxtkpUwMEle0ur3JkJplQ4hZ5wSC8/Xs
         JcM/I91MWB6JAIj52hGwTRMR1lTn5VLVX0hvSkz+m4+t8yw9hhLB/d42OPae6H8wJX+n
         p25A==
X-Forwarded-Encrypted: i=1; AJvYcCV0S045numwFrx7HxwbfeLS7bgbi93y0k9Cxnv2zQXbnfN/JqlbOT3UQxmZYepZLRPLvyijIP+k@vger.kernel.org, AJvYcCWukQPR/zCJ/umktWsCiPiNfayw/1S5RXqbr8KPZNCYzF8CE//EGIsUydVEPApdR6kzpIJM4I68uWJqZ41owcSz@vger.kernel.org, AJvYcCXajUXbLM/tv40Ik+8ukV55H8YvUSRUSsvvL07pExpFabn4J+hs1eSP3qznqpT6U4PZiOY7mwafZTLdz30=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWgApD//8IizhOH7owJxrNmu7VIityDEK0BgDWTsksRbgnlvnM
	9cFuvplSial5Nremr6TyxIqoxITcB9C8E1H/dwSQKrtfCWhhRKJP
X-Google-Smtp-Source: AGHT+IGVKIdjFhFSKmuDoUFehwaoxKCl8TdYyrY0raNGpi7DZELb0WQPZFLBb309cUlO50nRmXl3AA==
X-Received: by 2002:a05:6000:20c3:b0:382:51f:60a7 with SMTP id ffacd0b85a97d-382051f616cmr2003172f8f.33.1731370590965;
        Mon, 11 Nov 2024 16:16:30 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381fc0f5f91sm5505857f8f.62.2024.11.11.16.16.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 16:16:29 -0800 (PST)
Message-ID: <3bfdd5c2-2564-4122-9e44-36ce944cba21@gmail.com>
Date: Tue, 12 Nov 2024 02:16:59 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 09/23] ovpn: implement basic RX path (UDP)
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-9-de4698c73a25@openvpn.net>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20241029-b4-ovpn-v11-9-de4698c73a25@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.10.2024 12:47, Antonio Quartulli wrote:
> +static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
> +{
> +	unsigned int pkt_len;
> +
> +	/* we can't guarantee the packet wasn't corrupted before entering the
> +	 * VPN, therefore we give other layers a chance to check that
> +	 */
> +	skb->ip_summed = CHECKSUM_NONE;
> +
> +	/* skb hash for transport packet no longer valid after decapsulation */
> +	skb_clear_hash(skb);
> +
> +	/* post-decrypt scrub -- prepare to inject encapsulated packet onto the
> +	 * interface, based on __skb_tunnel_rx() in dst.h
> +	 */
> +	skb->dev = peer->ovpn->dev;
> +	skb_set_queue_mapping(skb, 0);
> +	skb_scrub_packet(skb, true);
> +
> +	skb_reset_network_header(skb);
> +	skb_reset_transport_header(skb);
> +	skb_probe_transport_header(skb);
> +	skb_reset_inner_headers(skb);
> +
> +	memset(skb->cb, 0, sizeof(skb->cb));
> +
> +	/* cause packet to be "received" by the interface */
> +	pkt_len = skb->len;
> +	if (likely(gro_cells_receive(&peer->ovpn->gro_cells,
> +				     skb) == NET_RX_SUCCESS))

nit: to improve readability, the packet delivery call can be composed 
like this:

       pkt_len = skb->len;
       res = gro_cells_receive(&peer->ovpn->gro_cells, skb);
       if (likely(res == NET_RX_SUCCESS))

> +		/* update RX stats with the size of decrypted packet */
> +		dev_sw_netstats_rx_add(peer->ovpn->dev, pkt_len);
> +}

