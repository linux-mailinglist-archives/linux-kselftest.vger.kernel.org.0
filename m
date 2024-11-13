Return-Path: <linux-kselftest+bounces-21903-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4A39C66C3
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 02:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C302CB2B48F
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 01:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D80623741;
	Wed, 13 Nov 2024 01:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I29yc5bJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65252BA34;
	Wed, 13 Nov 2024 01:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731461808; cv=none; b=BXLfoBxhPy4wySaH+K2QNyDxM88qClSIyNTpqDRPZNx1G8xv7kU5hIKqqSbKb+c1xK3P7FI1+gup7K6jF5DvykQF1PLQKeJzK3dLWNeF2dJnBGrKwYu/B36ul7fAIF5LSFaHBFceajDC79pk7FMvGPJOkdPzvbjTLh8iXe63QSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731461808; c=relaxed/simple;
	bh=jQ7vjQitYIwVRV5qo3X4jTdA0nSn7aCAbVKckDNIqhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FRbk0pq0fIkop0VeRQuDoCmNgOesPSiE0GyJcEIOH6tJ/OVxo1PkR8vWvYJP9QQpAAkTw2Kj7JSyHaz1u8ctK6ZrTju/BjJRZb9t507z7miR6hlJRfWpIHwaphW8szGa1qx0JVO/vox7msL86JnwVljPZafd4a3FnQqc7DeXHQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I29yc5bJ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4314fa33a35so51729195e9.1;
        Tue, 12 Nov 2024 17:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731461805; x=1732066605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r0He/ui9X3lLXTLqSVc28T6+iNWPPBcnJC+uzdT9cME=;
        b=I29yc5bJJM9MQ+1VgrAuqnHJvnEa9UMZjSrXJjg8GhZubMXSiV+3NVjvOLGqtV9er+
         LnJYfTFrJuUe9pgrJMJA+GvklvSu9OkRiIo4755NkXMnpSWY71TENhlmWhSdqTTGEO9R
         gRNPHIdO6p1UavNGdhKGmFVIwJ+KA568/ZEOWYO9+PHE7zAKeh8jxrtCfrHuQnNRI81s
         cZG2Div3VNKnsQFtO9ohe4eaErBgr2Dz21hQ6Xf643GOMyratDDTFRw2tAq9VVCsBnb4
         aAXtbmxFY9wRs36M6JnU8J04EJUreOf5ewvKL6BX7zx5LRMcv9AjuGpawTEl/Oy66T75
         R16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731461805; x=1732066605;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r0He/ui9X3lLXTLqSVc28T6+iNWPPBcnJC+uzdT9cME=;
        b=mQ7wuU3EPxR781yc9ZV50L1y3WBtyKk19xYIICXp6KTaBt6mObVu9MTGNNDFdUBxd+
         2LKhLGmrzdSpHPAsB/I1uTddZUgla5VqHPl2wUhssPILVhv2zf04ye28JQ4baTH50WEX
         eowH+a13BM8MU6wOS/L66WRqb827UBsJ6Ikv5IRmgRVWOTZutEgG9w/ISnK+B1qAz8Gs
         eQxecqNLuKpwp/A4Pj0kzakVJ8pN9k1cfV4M1HuwTFb+wtkq6R6XBzrmbxl6yZ3nHcYM
         wOI26Xd4pSdw4Drw8BDsvanLpDiErc0W3pUW2UgldBqPu4DpJPksUIJ8DzSvcqIwSyGx
         UrLg==
X-Forwarded-Encrypted: i=1; AJvYcCVAfExDBXd65c3YWzeN34a3oKhYJgMg/cLtZL0PSyI01fvNBgstFtSvgNjZOjadsFHj0f5aXFzFAesDxa4oOwZB@vger.kernel.org, AJvYcCWyDMTHWEQwYvzGHncQRk2gumQc3e6UMCWK3jzMUi7BCGwoR+LGXbrt2t2EfpnOPfhCwJgpQbIMCIX9Uko=@vger.kernel.org, AJvYcCX/BkABEXd4bcuxK6wvIQSTcP3whxfNkvw+ubbieHGKjr64xtBvxknb51lQ+w625oLZ9I3RYYeC@vger.kernel.org
X-Gm-Message-State: AOJu0YzoMcfxvWqTu99rT2VhCFvAVoLaQiQL+N6RvEX0dULy+MqWbp/h
	szItvpYNZubIkmXZ6kglawraJgvVEnBnP3VdMIofaw59xBiB6Bf0
X-Google-Smtp-Source: AGHT+IFJ3TyFzXqhDuVU7DJUr9rylVz4qYboLBexKwMmYF8kWN714xioYIohZpiK5XEDRhdObS7OuQ==
X-Received: by 2002:a5d:47c7:0:b0:37c:d54b:a39a with SMTP id ffacd0b85a97d-3820812de92mr3323488f8f.33.1731461804463;
        Tue, 12 Nov 2024 17:36:44 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed970729sm16681031f8f.15.2024.11.12.17.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 17:36:43 -0800 (PST)
Message-ID: <e543a3de-44f1-4a2d-90ef-1786e222f0d8@gmail.com>
Date: Wed, 13 Nov 2024 03:37:13 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 06/23] ovpn: introduce the ovpn_peer object
To: Sabrina Dubroca <sd@queasysnail.net>,
 Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-6-de4698c73a25@openvpn.net>
 <b7d3ec11-afe4-409c-970e-8bc647364a08@gmail.com> <ZzORATd5hG614dta@hog>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <ZzORATd5hG614dta@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.11.2024 19:31, Sabrina Dubroca wrote:
> 2024-11-10, 15:38:27 +0200, Sergey Ryazanov wrote:
>> On 29.10.2024 12:47, Antonio Quartulli wrote:
>>> An ovpn_peer object holds the whole status of a remote peer
>>> (regardless whether it is a server or a client).
>>>
>>> This includes status for crypto, tx/rx buffers, napi, etc.
>>>
>>> Only support for one peer is introduced (P2P mode).
>>> Multi peer support is introduced with a later patch.
>>
>> Reviewing the peer creation/destroying code I came to a generic question.
>> Did you consider keeping a single P2P peer in the peers table as well?
>>
>> Looks like such approach can greatly simply the code by dropping all these
>> 'switch (ovpn->mode)' checks and implementing a unified peer management. The
>> 'peer' field in the main private data structure can be kept to accelerate
>> lookups, still using peers table for management tasks like removing all the
>> peers on the interface teardown.
> 
> It would save a few 'switch(mode)', but force every client to allocate
> the hashtable for no reason at all. That tradeoff doesn't look very
> beneficial to me, the P2P-specific code is really simple. And if you
> keep ovpn->peer to make lookups faster, you're not removing that many
> 'switch(mode)'.

Looking at the done review, I can retrospectively conclude that I 
personally do not like short 'switch' statements and special handlers :)

Seriously, this module has a highest density of switches per KLOC from 
what I have seen before and a major part of it dedicated to handle the 
special case of P2P connection. What together look too unusual, so it 
feels like a flaw in the design. I racked my brains to come up with a 
better solution and failed. So I took a different approach, inviting 
people to discuss item pieces of the code to find a solution 
collectively or to realize that there is no better solution for now.

The problem is that all these hash tables become inefficient with the 
single entry (P2P case). I was thinking about allocating a table with a 
single bin, but it still requires hash function run to access the 
indexed entry.


And back to the hashtable(s) size for the MP mode. 8k-bins table looks a 
good choice for a normal server with 1-2Gb uplink serving up to 1k 
connections. But it sill unclear, how this choice can affect 
installations with a bigger number of connections? Or is this module 
applicable for embedded solutions? E.g. running a couple of VPN servers 
on a home router with a few actual connections looks like a waste of 
RAM. I was about to suggest to use rhashtable due to its dynamic sizing 
feature, but the module needs three tables. Any better idea?

--
Sergey

