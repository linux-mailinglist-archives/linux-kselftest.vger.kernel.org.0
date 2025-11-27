Return-Path: <linux-kselftest+bounces-46621-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C87FC8DB65
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 11:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC5853AFE0C
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 10:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A09A30F80C;
	Thu, 27 Nov 2025 10:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="db4iitSZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="r+JFufm6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D02C22541B
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Nov 2025 10:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764238532; cv=none; b=kyuWFnjGcP8eWBFbOmKMrRDP0Lkm3Q8q1LJuA/MjbR+NWdKAb4aVwRJ+gS4Vgtf7zvn6ylAzANE8Qa8e/JV1LlFLeXacf4DtbyDbBKdc7bsknhOLmD7W6LRU2xKtiSt8eEOiBInsfBUMAE+oT9HprF6X9ZXtGUjwTPyDF5r7EpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764238532; c=relaxed/simple;
	bh=pwilmtuwZCwVGcEBxCIcxfJ/scfi2T4xcyOMcvootqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uWFOPQ1W06qTkYVRPl0ec5tzsZNbTBuJfn9ikdyDnDjVtrs/5Jq07P6cAy32+2CTjRsAiqVt6ytQdB+/da9vHzf+9PqJ55jpWk165oVJWfvUrKIHefGHhRWbHYjKEbm7RKFg20VGHUg4VEsBt3AkLn1XWABuCTrLIkrmptzZi3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=db4iitSZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=r+JFufm6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764238530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/cSz/b0Kd5xpZ/T1Df2U+cJQk1otyVLFFyjvMg96kbw=;
	b=db4iitSZ8W6Zh2npRZsIjHkIAKYY0D8jBPu5zCbMHAOPR5Uae4K0ehTNUVgyoTiivxmQVW
	YvBTyJYEGHraTmFHube3mm5xwLOEQ3af9Co/tcA2nNqM6BPC69k4LeQSkIcpzZmXlSh/N3
	jFQvObzwD+S23PFQ/pVLW4At+EJ4nB4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-Oak5K6BSMFWBYz-FFi6mFg-1; Thu, 27 Nov 2025 05:15:27 -0500
X-MC-Unique: Oak5K6BSMFWBYz-FFi6mFg-1
X-Mimecast-MFC-AGG-ID: Oak5K6BSMFWBYz-FFi6mFg_1764238526
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47904cdb9bbso11331995e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Nov 2025 02:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764238526; x=1764843326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/cSz/b0Kd5xpZ/T1Df2U+cJQk1otyVLFFyjvMg96kbw=;
        b=r+JFufm6NuDNfVqptG1hxfYgmto5MJQvtV3ueSEovJ8dTSF+YXF6OICo9A8XQMG3t5
         kXDJebbj2rhXO5YgDBiTrU/1FI1Bx9xCXee2FrymATL0dCCJouoKSo7LLeNfA+nfsAMu
         j42GyrL70x03EnmbM9uSyASEpd/zaT03VieCAqgP0nM+ybhS8++9uHBuomQ6FiJ0Ytz0
         enuYiLTV2URJbi5Of8LBhzfLGfIZqZJVl7n0CUebW/cbrnXOxQZgvLcUfwdhYyx5VD09
         vDQGBqecLabcRn5nZSW787273FgHtLhx25eOsikSJMCH9P99FxsqjD/+968qELNB3BNB
         2YJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764238526; x=1764843326;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/cSz/b0Kd5xpZ/T1Df2U+cJQk1otyVLFFyjvMg96kbw=;
        b=ARiGjYFgUkw8o38m6mEGAC1/FRJytOYtPdFntgVHFJ++QosJr07nz0t+XyNugKR7gt
         PkoRkNY2uz/d5ydUPc0PoFTTiollTNI0rTRe4mHgWmgwvB2hrmihGzamQIset5bwuysn
         xmlYxdv6KLZ4jInE7La9jP45NoqDBxbn2ETlQQENCGbMRzmwLhojEXBqx5ifzcN2Y2sw
         f2N2bbmNXS0BGw+CuZg3+44PDsnQHKvOE7NguHyvO28LAcvDTb3zoIEDVkgGWaGE3AYr
         SK5DHKl7kIH1Bm56S2hEXVZowH1DsF1q9mQUrf/TjSlJc+nTtAtKRWkQV+Iil6e/SpYK
         +2bw==
X-Forwarded-Encrypted: i=1; AJvYcCWK5tXBevJCKUrybfcgPIkRXGPRH2JzEQGoS8UBTy7OdOiA5E5Rw7yW0yGHdqn/Pg18MtsynA6xjOc/+R9puC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUPCbAWxbgMzwdOEp/Zx/UyZmMuCAUA0UXnMAxlidcoB1G6bGh
	NWdNCNrTmpFobvJ1LctZAFrWjdKgOhqOPVvNBFskMnOQlBTYmmosNx2sUMjrNHkFruUeMsbdQIs
	7+isaUO34u4cZ/LB/HSyDwePJgGD9YLNCC3U8+ssggQOpixswK3v/Kv2jBNGvi65ii7D+rQ==
X-Gm-Gg: ASbGncuvTZH1oRFiwq0q9VPupjGyisdGeN/TWl0ll/MH+RuzBQsj6sfBbTuK98LJawE
	UwdGALZ2KzaA5xK0CtXuAujQKhUyQV+gVty8y7b57phDvausu3cq5jAkB+uws++kEFsgSr2qSnq
	OXKRzlC2WNZr3PN50n0Ap2czi+LRoyU0iSMUfJF6m/pFeY9l98/y9hSsa4pTk57T1Ji9uqRDgQy
	JnnZL4cwrqugo2ZG1JFAq6PC5ovG52vadtS8bfiLFReWTB56pQYmEHfwGivJZvboPNtf+6F6J4V
	f3VGtgp5OeUzOpgBMXK8jcDrEIq5w4k5QJT7591z+28s1NVaRW2ceWGiQFJD/aC8VLDvD7C6J1N
	r1Aq0vnFUlZz7aw==
X-Received: by 2002:a05:600c:1e89:b0:477:a1bb:c58e with SMTP id 5b1f17b1804b1-477c04cfddcmr248418755e9.7.1764238526425;
        Thu, 27 Nov 2025 02:15:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNb2PeD4KwIGCMkGgjUBm+QcFTwjLt9m8CIMLyVfjrnQH9DmdPco7CEVggwzpCQSSl5QxaTA==
X-Received: by 2002:a05:600c:1e89:b0:477:a1bb:c58e with SMTP id 5b1f17b1804b1-477c04cfddcmr248418345e9.7.1764238525977;
        Thu, 27 Nov 2025 02:15:25 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4791115caa7sm24218165e9.6.2025.11.27.02.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 02:15:25 -0800 (PST)
Message-ID: <63768c05-e755-48fe-a4be-9715f8b5ab2b@redhat.com>
Date: Thu, 27 Nov 2025 11:15:24 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] bonding: set AD_RX_PORT_DISABLED when disabling a
 port
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Mahesh Bandewar <maheshb@google.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
References: <20251124043310.34073-1-liuhangbin@gmail.com>
 <20251124043310.34073-2-liuhangbin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251124043310.34073-2-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/24/25 5:33 AM, Hangbin Liu wrote:
> When disabling a port’s collecting and distributing states, updating only
> rx_disabled is not sufficient. We also need to set AD_RX_PORT_DISABLED
> so that the rx_machine transitions into the AD_RX_EXPIRED state.
> 
> One example is in ad_agg_selection_logic(): when a new aggregator is
> selected and old active aggregator is disabled, if AD_RX_PORT_DISABLED is
> not set, the disabled port may remain stuck in AD_RX_CURRENT due to
> continuing to receive partner LACP messages.
> 
> The __disable_port() called by ad_disable_collecting_distributing()
> does not have this issue, since its caller also clears the
> collecting/distributing bits.
> 
> The __disable_port() called by bond_3ad_bind_slave() should also be fine,
> as the RX state machine is re-initialized to AD_RX_INITIALIZE.

Given the above, why don't you apply the change in
ad_agg_selection_logic() only, to reduce the chances of unintended side
effects?

/P


