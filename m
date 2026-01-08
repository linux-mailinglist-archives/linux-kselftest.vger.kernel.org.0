Return-Path: <linux-kselftest+bounces-48471-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BD833D0213D
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 11:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81CA431A5ECA
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 09:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F21736BCE7;
	Thu,  8 Jan 2026 08:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GQFhnX22";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="K6pYkrNq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6ED337BA0
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 08:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767861305; cv=none; b=SSMwIyMrfAITSKvh/NSNvqJo7sRaXgNPZvfjvllmlqjknOk8jWNHq05BTrAKuGSC8mb7fKot4OjyBEJoV7d0whiTJauGeZTJdld+nRSQQVrVXoVJJvJXnaSSN93FfABTygUzINz16+5uFrn/oR9g+bIdY4YhHd8U2tR2FM9K3O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767861305; c=relaxed/simple;
	bh=vOqy1647WRoRymxOMyXMEG8qnGN00OXJpzkXEokwITs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oo1QHtKolE3OehFl8d+vDUTq24LK9oD0nP7cpmkW3B7xjl7CIZC+CJ/LdrGdDaDiHWYbC2qItO1etUmKc/zz4ghr0d5cI9ndLjnP1aSDhmsY0LRK2+xIAdTbrpXzSlf+wVeyGnG+Wg8fWjurpUMVYiFsQOvFi329weovGZGPYxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GQFhnX22; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=K6pYkrNq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767861292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G3izPdtqXaA4EZIquGKpD4hKmpzGXchWnG6uLb78MGE=;
	b=GQFhnX22O+Txw9S2KPtVot3iGYRaOF+wGaNDPDhD8Ln1AEAVt4jJP1pToS0fuDTYSiqxe6
	JjQEbvi5clIX7l3lP1niQ8/oCOg2wO0LsKBKhaSFaYoul5vzbg2PNRqys6tNdM0uqL5l38
	Do/D/34Q8lVyxGNbaLupA0GOJsD85p8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-BJrKEBXyO0CV38DJhwPL1A-1; Thu, 08 Jan 2026 03:34:51 -0500
X-MC-Unique: BJrKEBXyO0CV38DJhwPL1A-1
X-Mimecast-MFC-AGG-ID: BJrKEBXyO0CV38DJhwPL1A_1767861290
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43101a351c7so2313195f8f.2
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 00:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767861290; x=1768466090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G3izPdtqXaA4EZIquGKpD4hKmpzGXchWnG6uLb78MGE=;
        b=K6pYkrNqcNjfA68oKoBMJy8uzKTXCn1nNZmV+13XHevU8yk/NRVpLmCk9w7lRu4zFm
         +/s7VDAzU6q6sCJoXsKT2J2hmeclRtBW7KDV1iU4yG4HJlbFJVRepTmoMG/mdVYMkS5/
         m5Xd+frci9SzO/ainVdYma5C852c7iXOeDxSuK3rz85E9wzIR+ubxiwuxbl9zXmOYiNP
         rEvuakL7XG0h3K5xwOvr2gA/wZHljxGbLXBi8qWOSVZOAEXa258q6djz8A9yNii6N8f3
         Zd5PLJm2PV02rGuK+KLI6D373ptOvMFsdRhQq7EaCmd+NP9waUv9PGG/7pbadVYjS75F
         IV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767861290; x=1768466090;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G3izPdtqXaA4EZIquGKpD4hKmpzGXchWnG6uLb78MGE=;
        b=PPrW3idtt2IXk6/3rnpMNXPygfsZj083cN0VPOHfJ7BrCBatHTg9zxk0XMoT23tGwE
         Ax0nao0IUpAwiXXxjbjIAqzNW+BPaAdphzO3ongbPhoJmj8G2dBAhLeSviTcg2KmDY46
         pQxrfCbSfOcL8+uopB56b7mnaiCHQq4LOx19BOlRczLz31a8byOW85/IBs8Unwea1aot
         Sgl0tRD7iUbclFMcufy/olpuDhXJist55jV/cUxCX5/tkCbhY8qfwn9nNlUY6Wcu5a9V
         Sd+Uo/xq7XW7EEUAgItUlGuyntzx3irzxcJmRSF8rv9BGDCOsAUBWLDTQ86JnIE6nIsz
         ziHg==
X-Forwarded-Encrypted: i=1; AJvYcCVJA+N8f9FJx3n1bhHQTDOCCBUabZZ+iq+KmgsCL+ToYnt7b1QRA0oX3zLyIlZEx9hqMbJlkug4FVStBLtY0EA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSxeNsbmdkTMeO4nxxpUUkyanttOSxiCdL+W44PxAzvuwa01wl
	HESM2Cg5q62X5o/k4f2KHPYUSqyhk5Woocg5kOSZoRTLmKcMbf/1s7louJ8Wd1yFVUar9JI0Drb
	S0WJr1bX9D+BYlO26WpAg5/KYi9j1Ham5578vCn35m8tMHGe+zXxCBHVrfOlA84rzf26KEQ==
X-Gm-Gg: AY/fxX4Q3R2Js7tj5cCybWARXSlCvUVYfG5gAzF5+7cTErn0NToqlFX4Noxrc0pc0ut
	ks1p4h1NFfhvlyta7HtX0gyix6DLtwQiHQKEWKJBCn6gdhKHXZ0OJLs2w3mvBl2Qcf9sVKTFhxS
	j/zcvFB/09KXRcNNuVtMkgIUqeBSflSOYVcKFsj6+QHV3BDo0mZ7ylvEkKS3bEojw9RGToXQJZ6
	GgipAlTrdtwB+kC2h0QX455RPvP917wWSCCO83WrDy5oXz2fvh4VWsiv6aXGUiIUXtohqfsiKGf
	g3vbrYgXgJW78jjVF7pdaJ6AoL4JMk5i8jgV9i4mLqFRB9PExVtUEWFnpd/oRVqKtNa3iIhBCK6
	Eyt1ccAL+OmvYpQ==
X-Received: by 2002:a5d:64c4:0:b0:430:fbad:687a with SMTP id ffacd0b85a97d-432c378a4cfmr7270525f8f.13.1767861289915;
        Thu, 08 Jan 2026 00:34:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJdXnc4ULpa81FnMPK+JkotChAGavVuM3yRwe+jMFsfmaDecitohHZqOK7h9/y3DI6QU+Rqw==
X-Received: by 2002:a5d:64c4:0:b0:430:fbad:687a with SMTP id ffacd0b85a97d-432c378a4cfmr7270478f8f.13.1767861289456;
        Thu, 08 Jan 2026 00:34:49 -0800 (PST)
Received: from [192.168.88.32] ([212.105.149.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ede7esm14917323f8f.32.2026.01.08.00.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 00:34:48 -0800 (PST)
Message-ID: <6491258b-0ef5-4789-b856-3e9cd9a3fbd5@redhat.com>
Date: Thu, 8 Jan 2026 09:34:46 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 10/13] tcp: accecn: unset ECT if receive or
 send ACE=0 in AccECN negotiaion
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com, parav@nvidia.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20260103131028.10708-1-chia-yu.chang@nokia-bell-labs.com>
 <20260103131028.10708-11-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260103131028.10708-11-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/3/26 2:10 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> @@ -1103,6 +1104,9 @@ static void reqsk_timer_handler(struct timer_list *t)
>  	    (!resend ||
>  	     !tcp_rtx_synack(sk_listener, req) ||
>  	     inet_rsk(req)->acked)) {
> +		if (req->num_retrans > 1 && tcp_rsk(req)->accecn_ok)
> +			tcp_accecn_fail_mode_set(tcp_sk(sk_listener),
> +						 TCP_ACCECN_ACE_FAIL_SEND);

Minor nit: AFAICS the above block is repeated 3 times and could deserve
landing in it's own helper.

/P


