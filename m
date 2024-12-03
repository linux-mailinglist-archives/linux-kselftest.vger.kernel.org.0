Return-Path: <linux-kselftest+bounces-22755-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC6A9E2081
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 15:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 741B028A569
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 14:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047781F8901;
	Tue,  3 Dec 2024 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ehjzlSgC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE6B1F7560
	for <linux-kselftest@vger.kernel.org>; Tue,  3 Dec 2024 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733237908; cv=none; b=U121z+gUXLU79CuQtDGfLspfHskt97uQyJ5uKDP6IwfLgUdvNqNWcXbTDdUjFZdhb5BsOJ6OY8272qvRtjoxlawNxpEXani/kL7pEpkjeMRulTCCqn7EMt2jLJX/aNZ1b7Tth73WwG410z+tstAyA68oIvGZKVvVIBKT0IPPlJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733237908; c=relaxed/simple;
	bh=FRS+jYrncd6tGPQbFP1DQGbwL4ACe2/jbzRj6PoGLoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sS3l/89SfwxFV5UZ53418hm8ZRoDPbe8M4dj8Q2BvlY3rCQsbu43wHxKWVCF9dvKtdG9n9zLUDb7+V+8NsLiAyxX0Ae06UrxDV1NBJKfy7Dp/YTZprWGGuLh1HPXchEajv9p/faVIa9FPqVBLJLEIcpS1jn1gPlC1IrRYUe4+KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ehjzlSgC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733237904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5/B9W1PHGC4jNtNkey4u5K3OKOvKVBYvJeFu04aQ9yI=;
	b=ehjzlSgCymPzBsOlsR7pVtHCt3rIYQranXMW05K+VkiexgvyIRB59RwRiuGRlA/0NByw3w
	Zzq/DoxVPUzannlZvHXoyjT6l8tzkF7NZB5VJa1tty3Vh4Xk7IVNe7KKXFbuubXmYfGXQ0
	FRjGcUWsE61e/fHr60KL7NNknGeuQ/w=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-dqRigqkiO0eWHC1YIW-W6w-1; Tue, 03 Dec 2024 09:58:23 -0500
X-MC-Unique: dqRigqkiO0eWHC1YIW-W6w-1
X-Mimecast-MFC-AGG-ID: dqRigqkiO0eWHC1YIW-W6w
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d89154adabso49471836d6.0
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Dec 2024 06:58:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733237903; x=1733842703;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5/B9W1PHGC4jNtNkey4u5K3OKOvKVBYvJeFu04aQ9yI=;
        b=U9qsNiSDIxIseg1mopAQgUNiAVKfyJ7uqR30J14QENDpcsnYsc3Q0WNjoWMyx0kEZC
         SxSDTabqjzP79POuNBrLzVCt7eKQ4ge/doMpastmgapSROBXYwTuqkgIEsXybE7SCsme
         zNHnW/GUQ/dKSq74Q6vSBvQ0lYNKgQMVXAIQI9KJd/Hs1df+lbOcd0Ix5yAirY3h3CDM
         pMucDULukQ4LvP6O/JMAG6LexIM3LMR32okY/3OS6FP9xzH8ufdSj3WAFo7fVncBRKC7
         r8wNnB9wmdhk1f3VnzZCe06bzoJ4UmbyP5SrJaSERxxoq749xgTZR8Z2HzrRI9ZWbDRF
         N3JA==
X-Forwarded-Encrypted: i=1; AJvYcCVqy2it9FIAAFZ2/54t941dolmOXfPcNtAehGnenvvacW+OTj8Tc5QNQAKDglgma+f/xJYgGuP0/5sikiBgFGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5AIxB37rAPaIkwarktlzXMHkSpS/0e+G7eQVqQbGoOzfK6Bon
	vFia07Nh34IVPRIEkcO35lTgkXCyhhmf85Mu2KAwDTxh7VFyzf5cAWiYAFUa8HOhLfVNnlasVtt
	2l9gxvI8vxDlFRNWY4MJMdw9u85m2eN75iKOVOfRnSkgnKuS7iWkxdG42IR+sjdYO6g==
X-Gm-Gg: ASbGncs+XBWYw2H1v9Ndt8v2nlOLR4zbmEALxrd9rB0kz0LH5/DLTqxcqnjYMPPH87e
	Dw9u9pXLuEexdUSr/zwRet/ro3B1Jji2eKFNYZubmEQw4oGtbmcbDskAUKijgdo6fnoU+peIhjt
	hzNHXtjPzeLR5UkPGAvLhIXfgb2faZe4ZSLOn7JdML2JxP14kRVcMFiuJ2KKxH/MvImezThq4BH
	Ccy9Yvl8Hh8oGNktYScI13kk+NNM9zLQ4FX+cCmAzBK98EBsT/xkEdMyZFKTe1oBBicPLM5E7vQ
X-Received: by 2002:ac8:5a4e:0:b0:458:2b4e:33d6 with SMTP id d75a77b69052e-4670c3d3ae9mr38895091cf.55.1733237903168;
        Tue, 03 Dec 2024 06:58:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/nVFCcZeBig9JWMWeqeCHf0c84sagtlg4Wmp3YzERC+96LXleV4anoV21jAapKzbX/PVEXw==
X-Received: by 2002:ac8:5a4e:0:b0:458:2b4e:33d6 with SMTP id d75a77b69052e-4670c3d3ae9mr38894751cf.55.1733237902806;
        Tue, 03 Dec 2024 06:58:22 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466c4253d6csm62154381cf.78.2024.12.03.06.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 06:58:22 -0800 (PST)
Message-ID: <d3d942c0-ceed-484f-8f2a-28abbdd132aa@redhat.com>
Date: Tue, 3 Dec 2024 15:58:19 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 09/22] ovpn: implement packet processing
To: Antonio Quartulli <antonio@openvpn.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 sd@queasysnail.net, ryazanov.s.a@gmail.com, Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
 <20241202-b4-ovpn-v12-9-239ff733bf97@openvpn.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241202-b4-ovpn-v12-9-239ff733bf97@openvpn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/2/24 16:07, Antonio Quartulli wrote:
> @@ -286,6 +292,31 @@ struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
>  	return peer;
>  }
>  
> +/**
> + * ovpn_peer_check_by_src - check that skb source is routed via peer
> + * @ovpn: the openvpn instance to search
> + * @skb: the packet to extract source address from
> + * @peer: the peer to check against the source address
> + *
> + * Return: true if the peer is matching or false otherwise
> + */
> +bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
> +			    struct ovpn_peer *peer)
> +{
> +	bool match = false;
> +
> +	if (ovpn->mode == OVPN_MODE_P2P) {
> +		/* in P2P mode, no matter the destination, packets are always
> +		 * sent to the single peer listening on the other side
> +		 */
> +		rcu_read_lock();
> +		match = (peer == rcu_dereference(ovpn->peer));
> +		rcu_read_unlock();

Here you are not dereferencing ovpn->peer, so you can use
rcu_access_pointer() instead and avoid the rcu_read_lock/unlock() pair.

/P


