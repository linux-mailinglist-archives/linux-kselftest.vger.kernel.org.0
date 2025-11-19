Return-Path: <linux-kselftest+bounces-45964-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C33FC6E0C7
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 11:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 866774E71CC
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 10:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0DF34D4EF;
	Wed, 19 Nov 2025 10:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eFbsE+sL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFgXU8vS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725783321A0
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 10:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763548815; cv=none; b=HOZ7uAFxRuR3qDSnqK2DuDwOGlCQR84RgTXouhHYIvYdBPtX13XXrg1+Kl0GDgHhazdNNuXTAPy56gNCPNRxqY+aX6sSmJTU/29c/AysLx4TO88xNf/GsXHP4awPKSJwiqw5KpmjZeMMQJA73z/sTO6ZF7AGdR/UctpXtgZiKI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763548815; c=relaxed/simple;
	bh=DZIAcCTww0s4iWal9ociel47JWmGW4w6rucjX7XMwbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uS2thwa3LXJUtwkLW/M9b7Tt/qiHAcLMhzDpFy0wpgintUO7Kuu+a9dEeVhydwxhNrnV5pEhmMvfaKaE1szYVSocnHVi7rFDQ7RTP3iG+/lrhW+f0X6XObvlfCPwdqnM/u75bl10HUjDa20ZThuRk2w2FADMWp4Y9pQLO+E7MTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eFbsE+sL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bFgXU8vS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763548812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0l9o/pX7rZdgzEzxtL69j/qja5gm9z4d5aM9fQ+O5cc=;
	b=eFbsE+sLoXWcfxX4eNox37FiBPERG7Xmzv6HczRwn4I7hja+t6Vt2OHxt5pWLdw/nwOwcd
	+1E2hWPYtZZRuvXMmGwz8WN6a85h6x8LXdPsXJF6FjmpNHUU6UwqbogWxDbK2/TXhNPLFN
	Jlz6lu1PCTBRlmkq2MAyanp+lXRJ6gk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-IJREc-iQOX6iRHQFNJ1yjA-1; Wed, 19 Nov 2025 05:40:11 -0500
X-MC-Unique: IJREc-iQOX6iRHQFNJ1yjA-1
X-Mimecast-MFC-AGG-ID: IJREc-iQOX6iRHQFNJ1yjA_1763548810
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477a11d9e67so24657805e9.2
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 02:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763548810; x=1764153610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0l9o/pX7rZdgzEzxtL69j/qja5gm9z4d5aM9fQ+O5cc=;
        b=bFgXU8vSey88dMC69sRh1ok7AdXRmRjMQ0kyKm8Ea+yeScTGNAm3ybq/7CkMLJqtYJ
         AL7qfkGv2IxH+Mpsd4LRpXTKOUoj2QMjHzFmXuKAuX1kjf4FOjOhnLVTEB9FKl43v1VU
         mCnZCZeqAdfbPgmJpMNrMHLwee/TI7SXAiXiu1E1mRiqK2iUGar+2NF1J9AWP4jUpjgb
         TxbCB9qPOthL01TnQVJta+H7yDHLjgARA2WU3zFWxmWzzLUeu+7w18L+dqGbm1xw9n9F
         dPaKhB7CgFBhQz5XxBlnq3koqDr0r08OS4q+JiUY9bqRYYhOS5a7V2IJTdC0MOwVN3ho
         xvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763548810; x=1764153610;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0l9o/pX7rZdgzEzxtL69j/qja5gm9z4d5aM9fQ+O5cc=;
        b=Ma18op9xLbUc9t2X77RBvPe7VyWKjbtg+nSAouojXMDQ5thHSGPPoV20fhPldRoLm+
         NjFMBFkF9IsMQMcmE2rcrJeXpWCYxWvMh2NmJgFp7W+pPAZ/qv04MJ0KQQ/gfEAInph7
         GYBLjKYgpJ4Qjt7QRSajgpf3p5DzYEf3ate6IoFRgzI7F8KkhppsXyEJdOflS39dRRF5
         wGXmx1Oj2ccN2fFU3X1j8D31wMdndB9pDwPuGz7yLg6AYbg1OyD8Se5yGQqO3wz/d2Y7
         QjbHyT8ToNKQw7Pa88AzXQxXTHFSP6NGgI8ZLY80Euyh8kFWJUHXpRKETyS4ZsS4HA82
         KTRg==
X-Forwarded-Encrypted: i=1; AJvYcCUhYF/on0mKXUL2tZcdUFpIY2nzRx1jRgZEkwP+lgxugGsQ3tWJLzOrb+adfS4X/H7QtEQH+rFsc2eCjjpBYh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQx8nDuBoP/wSC8QK2XMMNlOMe5O79nPHL2uAmjoaNL3QDUDpq
	5EUuO0JikUdH53XTwHETuGkERQ0oEQcGMhNL7SLTSL+LbpMMVpkfk1qmg+LHR0LnkzlLFvi6rTi
	dQuT3A0vrh0GO5qZxP7yUKuL6rOk7a0S4R+wyhyIEws9eJt+FvFuN8r5XexEO2iHoJjrouQ==
X-Gm-Gg: ASbGncuMqvKa6TlLuW7Yhv+YOxkeIY0ToValM3gy+Gsr51V7ZMXsHUQPnAExFRMzY5k
	b7+e9BDlbBfie2QA+KzIwDOKGNS5nKZiixN5BGTolVRO0ksnB+tcwBvoZQGB/M7mw2e/sT/YuBe
	9ffULJ1nhLuGEkAxyDaDYA1Zewe3ZOyAsFLLdOKl1u4R/RWk+ACCf1JJ8unRndnCTTupOynW8o4
	wu9mkOxMweGihn+14tGagwRwV3//6PXKCb+2YJ04LOLhAX5t8RVuTlGqGA1dKFLS2m5GJWLvh/3
	VyDatKNmkYGyPiE9ADWxgDQFkoMMkL49ho+V6cN/dnKgZotuXXWeRR1qapO4SjcqIfWABDnScMf
	NsMPX0VPZ2Z9h
X-Received: by 2002:a05:600c:4585:b0:477:54cd:202e with SMTP id 5b1f17b1804b1-4778fe59a0bmr191362515e9.2.1763548809745;
        Wed, 19 Nov 2025 02:40:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQBsoVLIQABpPzBRMJso90plcaov7SPkZ+FeWQLc/AfXpX8X110BATx3cN1ed3w5TAESS3iw==
X-Received: by 2002:a05:600c:4585:b0:477:54cd:202e with SMTP id 5b1f17b1804b1-4778fe59a0bmr191361945e9.2.1763548809270;
        Wed, 19 Nov 2025 02:40:09 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b1035c78sm40679485e9.11.2025.11.19.02.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 02:40:08 -0800 (PST)
Message-ID: <6d4aad6e-ebe0-4c52-a8a4-9ed38ca50774@redhat.com>
Date: Wed, 19 Nov 2025 11:40:06 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 03/14] net: update commnets for
 SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>,
 "edumazet@google.com" <edumazet@google.com>,
 "parav@nvidia.com" <parav@nvidia.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "corbet@lwn.net" <corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>,
 "dsahern@kernel.org" <dsahern@kernel.org>,
 "kuniyu@google.com" <kuniyu@google.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "dave.taht@gmail.com" <dave.taht@gmail.com>,
 "jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
 "jiri@resnulli.us" <jiri@resnulli.us>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
 "ast@fiberby.net" <ast@fiberby.net>,
 "liuhangbin@gmail.com" <liuhangbin@gmail.com>,
 "shuah@kernel.org" <shuah@kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
 <ncardwell@google.com>,
 "Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>,
 "g.white@cablelabs.com" <g.white@cablelabs.com>,
 "ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
 "mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
 cheshire <cheshire@apple.com>, "rs.ietf@gmx.at" <rs.ietf@gmx.at>,
 "Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>,
 Vidhi Goel <vidhi_goel@apple.com>
References: <20251114071345.10769-1-chia-yu.chang@nokia-bell-labs.com>
 <20251114071345.10769-4-chia-yu.chang@nokia-bell-labs.com>
 <d87782d4-567d-4753-8435-fd52cd5b88da@redhat.com>
 <PAXPR07MB79842DF3D2028BB3366F0AF6A3D7A@PAXPR07MB7984.eurprd07.prod.outlook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <PAXPR07MB79842DF3D2028BB3366F0AF6A3D7A@PAXPR07MB7984.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/25 11:24 AM, Chia-Yu Chang (Nokia) wrote:
> I was thinking to totally remove ECN from Rx path, 

??? do you mean you intend to remove the existing virtio_net ECN
support? I guess/hope I misread the above.

Note that removing features from virtio_net is an extreme pain at best,
and more probably simply impossible - see the UFO removal history.

Please clarify, thanks!

Paolo


