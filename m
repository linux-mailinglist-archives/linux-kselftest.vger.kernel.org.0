Return-Path: <linux-kselftest+bounces-48501-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BCAD04961
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 17:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 310603467E63
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 15:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF896497B01;
	Thu,  8 Jan 2026 12:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hggHdqUf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="P0EB5tUq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07AA3B8D6E
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 12:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767873912; cv=none; b=BGRZaoCURl13eJ5I9Bq5K0vuRdjyqTC6AZHDiK1z4iwPeIbu0ZtboiMZBKBIoswmpWN6plpN/AG3xO9BuqMnwFrzXi3OT2TEf9adYiqWhLt7ZfRH+lL1j9T6soP2mNYfs2yHIEwap+BGlfwy+HBdx/EquTu0vzPyJfIw4u1v9a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767873912; c=relaxed/simple;
	bh=Flh5gm/FG6f2h7+d4LlYOxc+wsoA1WupGU+z5tvQXn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OSG2w5gyAMYXfrU0nTb+tPUpuuIilWuHkSfc0UamW0NojHmRGhlv3vLcsYphAZqwi2K4gINSaFg+GMcqtvN0eok52rN5XIURVQGRyGnb65w+TEagJbwpOHJDkdqFaOk9UHWo2gRxa5/8VJe6w6k0Y0HOXfHHG8zg0YBW3DX/1EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hggHdqUf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=P0EB5tUq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767873906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Flh5gm/FG6f2h7+d4LlYOxc+wsoA1WupGU+z5tvQXn4=;
	b=hggHdqUfhOpfVf2+ddDxEWafFYAonVMZt55ZkKS+K+NWBwuRmoVAqyb56uItlm+e2dAtga
	vsdrVhSimUqh99MhcpcSLGPomkfoaJQZcDV07ygDOEE7QRjXwVzuxLVkFo2nedNuVQQ4t1
	mBnzXksN4AVH2SREEmIMa+cZ+Ml5X00=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-R3qR_uFFNQe013RuokXY0g-1; Thu, 08 Jan 2026 07:05:05 -0500
X-MC-Unique: R3qR_uFFNQe013RuokXY0g-1
X-Mimecast-MFC-AGG-ID: R3qR_uFFNQe013RuokXY0g_1767873904
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4779edba8f3so27105585e9.3
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 04:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767873904; x=1768478704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Flh5gm/FG6f2h7+d4LlYOxc+wsoA1WupGU+z5tvQXn4=;
        b=P0EB5tUq4gEPbQC8HFtAZIwPhtjivVywhg5mmDspsKEbQaSC/gQpJyyKK5wFGyWw2L
         07vwoad/3AOiZ2lVzMvR1pO1Neja3nunwK4QhIrY5bACcofo+d9Eyxn2fmH8i0rHhtr2
         +gN9vbo0QEtstBCtwY0IhqDmtogQGYds4puZcBDlzJKio7HOz6i6sZkjbKiuZb2cCn+L
         IVqVsjsrelFzg4txGT8ePwrN3yjM12kkjuzGqDrAyuvN15oRPreHd1yctO+wzW9dZk2k
         pF3behY8G/tY4QmNO+DLPOvJMkczbM3RChQmEVECJPx63iSzS1diTlQOkRMT4uhlOCJw
         M2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767873904; x=1768478704;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Flh5gm/FG6f2h7+d4LlYOxc+wsoA1WupGU+z5tvQXn4=;
        b=R7gimg58jCOGq8ZHTin6OMCYgX4GRER7OZ7txu7IFEZvCCg2qL9Gkos0Z8IjmmwsQc
         kr2k/Xak5+fzMlWMomR0S0j4t7rkz/lI5T8fUniVjUSmf0nLd2JJKhfu7+8xUT5IdykH
         50Zi/jWIOPbXTYxwNrEg9nzDvmSW86SvFqkO/ou+al221yGRSmSsjoTNsqfhOCEOrcr6
         1T1KLy2taqIKWfFkYQQUEWabpL1+Q1uSt60nqwU3W6p6OIHfHhLLiWg/OHO3U+FovEir
         3kXzXb30WJeVtIE7i3OcWXW0+S/UPC7BwQVPZZsNpZh9o6ig5jyqnltBoAkYyqtR9U0A
         evvg==
X-Forwarded-Encrypted: i=1; AJvYcCW8gHY4738M2uOZeer404omePJsWZ5FpBELvX3IvQVrE38eOfPPFQDPNwrSIQ+Cc8rHLX4P30gYcnMM3hOaPWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg9mhOe8aDNW+EiVh61Fb3SRCoQaqjr2JBO4fassGCjNqP1Iu8
	50hernsqYA1C7QXCBVjeQkhcPWy4PnRZ+C1SU0FV/8yrKh33TKcjuiH3tY/M+/uDfZqlUdLqm/n
	CCTmoTSCtByGg+raEkeSuyAu55GJVhjvGpuX7YYK/5src+QDdavHC2tNfwBFPMcFTQc15fw==
X-Gm-Gg: AY/fxX7MEXdic2Tp/C2p/pNB2bA+Ogfmxmnf6UeAf7fSLkhpWnz8pwrLGJBFkCBFjWZ
	uo+VXdYEQUn5HR3HdyvgQUyKvLsTIq+LRqqecD5F/aVn5UEDuTQUEsMlzTIAmxHNqdlJxLgWR0Q
	1Qv27ZTzuMpf7j8uiVONFs2ET39N+7rO7KzTH8xfXG+huOw25fPWClFd5Ai5F4NIqkekV1g2U+6
	aWATqqMBbD36wLAcv1oXcgj4QdDp1ZTDOT9b0wNj+dK2CqBjxfCNlkf6E8numqCemSUFFCAp9In
	B4P8hhdNmu2+gcHSh7Zv82Ir+IT3wdyz49x0CeRCNRiXbSoregB+iOB6pDqP4W+oxQhroQTWMDf
	GFl/kP16ftyjBvg==
X-Received: by 2002:a05:600c:4447:b0:477:3e0b:c0e3 with SMTP id 5b1f17b1804b1-47d84b3b8b9mr66671895e9.32.1767873903873;
        Thu, 08 Jan 2026 04:05:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyd3EobR8+CtqNLr1SJNq4aJtqIFnG4hdPC4+x+J4mPj7mFR2jjmxPx+hGX2qRU6Jn66CAIQ==
X-Received: by 2002:a05:600c:4447:b0:477:3e0b:c0e3 with SMTP id 5b1f17b1804b1-47d84b3b8b9mr66671435e9.32.1767873903307;
        Thu, 08 Jan 2026 04:05:03 -0800 (PST)
Received: from [192.168.88.32] ([212.105.149.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8662ffaasm36179535e9.6.2026.01.08.04.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 04:05:02 -0800 (PST)
Message-ID: <9d64dd7e-273b-4627-ba0c-a3c8aab2dcb1@redhat.com>
Date: Thu, 8 Jan 2026 13:05:00 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 00/13] AccECN protocol case handling series
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
References: <20260103131028.10708-1-chia-yu.chang@nokia-bell-labs.com>
 <56f6f3dd-14a8-44e9-a13d-eeb0a27d81d2@redhat.com>
 <PAXPR07MB798456B62DBAC92A9F5915DAA385A@PAXPR07MB7984.eurprd07.prod.outlook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <PAXPR07MB798456B62DBAC92A9F5915DAA385A@PAXPR07MB7984.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/8/26 9:47 AM, Chia-Yu Chang (Nokia) wrote:
> Regarding the packetdrill cases for AccECN, shall I can include in this patch series (v8) or is it suggested to submit them in a standalone series?

IMHO can be in a separate series, mainly because this one is already
quite big.

/P


