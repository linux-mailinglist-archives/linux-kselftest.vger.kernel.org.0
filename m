Return-Path: <linux-kselftest+bounces-37249-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F33B03FCF
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 15:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 093C94A5E79
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 13:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004A824E4C6;
	Mon, 14 Jul 2025 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KtzCk5eQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438972550AF
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 13:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499375; cv=none; b=H+/Hb4CMNaEpFZPbPra+wPHW1HJ+xiApnK6oKHCQ09TqkKs3JPU2wxutpnw2qLKP7ekJpDkF50T018G/7U+mBtYnN0BX+52ZKfJw4S5fYkqswwk+1y4z7hbnEirCnF0Nnhu2UpeHPEfUMRbiXQkFbobTncLn+P9hJOsfnB36AlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499375; c=relaxed/simple;
	bh=DSltvb0vEhfUg7AEaM3U6pLDRM1PmY8c4GSdMZ0F3aQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CE78ISQlNmeUZ5VjJkHbqgeUt/SAWtVhFUQvaQfzULLGa5aIpMfJytQOtbkDdouD1f9HMJdb4SuOZRvSt5dgjs91S5gKlcJwI5eZvbz2fRGWq61C/pd6EPMpDg2I9v9CQ2Cc3Xdk18fmqUwviJQdddru3ZFzpenrmzTjd6ixwYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KtzCk5eQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752499373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+74sl1h9XcDCGHLtxtil1RR5aKu+l0UGJeyQC88qo+g=;
	b=KtzCk5eQDTIEP3LW8VGRh9EL8q0ClmFn3JgDB+sIL5b3VnB92TG/9swsjbe7It4tcrcZGX
	Za3FwKDrB2IlJJvd0RkOgYz7awZRk7Bhe6wA3vNZvheEfBA7Y+1rvL3ob9RAF03VIsYdKv
	3Zp8QMtpiaPUmNvz/O0jV9AT202o3qU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-uV8GhuIuNpigy3WgvyEnLw-1; Mon, 14 Jul 2025 09:22:51 -0400
X-MC-Unique: uV8GhuIuNpigy3WgvyEnLw-1
X-Mimecast-MFC-AGG-ID: uV8GhuIuNpigy3WgvyEnLw_1752499371
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45600d19a2aso17189195e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 06:22:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752499370; x=1753104170;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+74sl1h9XcDCGHLtxtil1RR5aKu+l0UGJeyQC88qo+g=;
        b=oeSY2DgHjVZ2Q2fjSZznMcyL9XTE7FCAr3/wOoqZMT/z/3mvVVWCEr9s+yAZE5feyU
         G6A27zsVBVKg18okaatGUzZTuAK8BldGy5A8a5/oRWuhDUmhCx3eJCq5lWprcmgkLGu9
         VdAakciuKVH/ixHo6THTdT/ShNuU6Ejm8+zvBfAkw7egKe7/INYTrYUN6c6ciUNLH/Ee
         NjtGhVfm/cpXfImCsJ2JNlNAiHlX/EF5V1PMBKlG51cD9olrHymTCgxjToSzpKmDDfH4
         d3wO98ucNWtILhKPttaV5LESAq6fKxl7LBHBUL1IMpSxSsMdq0w+s/nNIaKWWrFltuth
         XRTg==
X-Forwarded-Encrypted: i=1; AJvYcCVgQqjGmhWs5dqmtl6jmLia80kbOmecZcdywSsFDRBaJOC8JtT52KsmtJkSNQQ1cxB0S7J5pVBZYG+mzwOd/8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YynkE/q1Oovn5B7RbL7WEsOeT++QBk3wpfSS8cBwu/5uyfomUPn
	EvDMvEfi9u9CbQvisuBQCOu+MDN4tOdbCC9XCKGkqzCA9fMetRLZZeUn6rIOzdOKHFydNv6wqVv
	2l+1K7EMk/SP/nF1SMgj5r1tjVcSl/aJ46+AJU/vhmOaFhCK3E/viiadGMz5oVG2bx5hVNQ==
X-Gm-Gg: ASbGncvinqH7BgZV33WO5xv11pCqYTk/PP/OVvQZwOnzUmmc8FxE5gcf2Urlu7uRL4z
	S9tEYf95mSYe1hwuoSw0vLyQx1GnG+5hUVorPxYMIkcI5Hbcfu65xlgl0+Xl4/LuN6/gKFVIxjl
	22TsizIVZ/LqCJRJ4csQe16PraXGVndiJsIqE+HLZzaOAOKVxtHtvWEV0j5+OSC5xaJdfTwG2en
	RR+i24lbWbEke540YPz69agvkX9pHJRSPPv6E8dRU1uuP/aAriOGWZeaZjY4clHTSIeyf+OAjLw
	2b7OUsUQcGotZHgCfqdb75wSppKYLX5O8IL/NKSMsRQ=
X-Received: by 2002:a05:600c:848c:b0:43c:e70d:44f0 with SMTP id 5b1f17b1804b1-4557f0b52f2mr103651975e9.19.1752499370510;
        Mon, 14 Jul 2025 06:22:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNCV4TnpnSpBNGL5u+cKnLCGpcA5mGUjaCcEkgIGAq0CDxzLK13e64IbjzNHnO8ged+huEHA==
X-Received: by 2002:a05:600c:848c:b0:43c:e70d:44f0 with SMTP id 5b1f17b1804b1-4557f0b52f2mr103651615e9.19.1752499370003;
        Mon, 14 Jul 2025 06:22:50 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.155.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5032fcbsm173656775e9.6.2025.07.14.06.22.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 06:22:49 -0700 (PDT)
Message-ID: <eaeaf8e5-ac94-4368-b897-538c757f4e34@redhat.com>
Date: Mon, 14 Jul 2025 15:22:47 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 net-next 07/15] tcp: Add wait_third_ack for ECN
 negotiation in simultaneous connect
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20250704085345.46530-1-chia-yu.chang@nokia-bell-labs.com>
 <20250704085345.46530-8-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250704085345.46530-8-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/4/25 10:53 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> In simultaneous connect scenario, the connection will be established
> when SYN/ACK is received after patch 23e89e8ee7be7. However, the
> third ACK is still anticipated to complete the negotiation for either
> RFC3168 ECN and Accurate ECN. In this sense, an additional flag
> wait_third_ack is introduced to identify that the 3rd ACK is still
> anticipated to ensure ECN or AccECN negotiation will be done in the
> ESTABLISHED state.
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Co-developed-by: Ilpo Järvinen <ij@kernel.org>
> Signed-off-by: Ilpo Järvinen <ij@kernel.org>

I saw there are existing pktdrill test for ECN with simultaneous
connect, but I'm still wondering it there is a real use case behind?

AFAICS simult connect can happen only on loopback, and [Acc]ECN on
loopback looks useless.

I would simply not allow AccECN on simultaneous connect - assuming that
would basically drop all the code in this patch without no fourther
modification required.

/P


