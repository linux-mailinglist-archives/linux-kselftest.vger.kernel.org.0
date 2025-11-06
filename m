Return-Path: <linux-kselftest+bounces-44943-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A0547C3A795
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 12:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 61023500CD4
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 11:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F6A30C61C;
	Thu,  6 Nov 2025 11:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hh2668U4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJJseeHQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B0C2DEA79
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Nov 2025 11:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427176; cv=none; b=tULJeLeB3CVhqdZceORYpU6xGJufj+AtCHRoUx7FoBUhTxy2EHgexhYraM+T16lPUHw5E3tjglOCFGtJKlkP2jC3b6CJFhqcuLF4UBZhULz5pZZ9eG1XriucPpPvO5Bejx26XK79K1w1BARmNQbWyZToZ8IAnOA/mQL0/cg8Z+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427176; c=relaxed/simple;
	bh=j3hl+Kd7/n7v8BB6LvuqjtP+7XFRDVSiKP7+HyaKGvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LvWG2g9LRv810jA2u16xMzsAmhZa1efzi2LH63Yvp0o0ff1ksiUPBtlCe5XX2gi2HLVuAv1dTa7iD089bcAI/YmKjE6CmPn5oEDQCDNnr0XeK4/atG3kn2RcKnU5a/uDismNT1MHwFqlort14Aeoyh80QQVubZMF2HsEXigjB4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hh2668U4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IJJseeHQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762427173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uG06GFhvhg2/GhoIc3ckFZLsP4kGe20aTOFoVqJytmg=;
	b=hh2668U4ChiVywm+UUaZJW5ArHWb/dv+ldwSc3kwiRssgdYd+rusOkz+KXYaYeIzFM9Wan
	kBhwsQjL6Q42mzsqPP0zgjHtoH8JU1S+OV/l3EX/F+QakJahwVPBj/kaxpvXM/NNCMG+zB
	LRuoW/ARn/Mxw34dgTJwNdF7WD8Rkr0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-XBHJLi0DOke40gzqhW1AnQ-1; Thu, 06 Nov 2025 06:06:11 -0500
X-MC-Unique: XBHJLi0DOke40gzqhW1AnQ-1
X-Mimecast-MFC-AGG-ID: XBHJLi0DOke40gzqhW1AnQ_1762427170
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-429c61b0ef7so421452f8f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 03:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762427170; x=1763031970; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uG06GFhvhg2/GhoIc3ckFZLsP4kGe20aTOFoVqJytmg=;
        b=IJJseeHQPmvSp/LV9bOZmLSCO+7DDh2k773X/2UJojPF4tKY03iKMbWR1V+7G9mdHz
         2i5DTythTk1ZJXiV/2Q4NMq53KE3y6jQE1ipd16U7BbPqaYMRTPu2Vo8JsJtQ8WHx29N
         Kg6hQACf2i3Cg3FtHhUVO72pRxq1mJIANHjRLdV59XgWVEJPtpJkXHK8Kpb2/CDxrZoB
         zNRmm6Gd9rXH+REX9ULilJP/RVZuUIuzGzs2Fe3uZY44Hp5ifGHa25gz8RyEGIirloI3
         wl12cnAj+cWUPgYct8gAyzlX8FWRq0uFG5qSL8Nf1VyLP1BTefOmymLxlvr5uXoDb7MN
         R0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762427170; x=1763031970;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uG06GFhvhg2/GhoIc3ckFZLsP4kGe20aTOFoVqJytmg=;
        b=daDKoZvLxaeo4JbbFIto448NRYSDGbWXlcmYevX9wcAB2VKm5nhJiSjJiMjt7e+8q/
         aWIBAvJv0UDr/XdRxsP0AmMAhN0v+HzjP/7tY2S8IEdtjmnkb0Ar6lMmtgvaAy5QZeKh
         nbS681RmWAO8kN7IVYcQajhUP5Pk1LsHjCtn6GrcSyPybQfiF/q0WTST8WdbNzorHoWU
         5aIa8FO0FLRnyWsrpxV0XMt7vtp/EEnmjYNSIqeDpKmU7MKzFwLNsLkDT02Jg+0rf31d
         W9Y2qkUwPhlZQ2OBRQIg24um9OXNTkw3KBIZXmwihKzKSuoRMvBcWP+r7cErQE2YbFpF
         YnJw==
X-Forwarded-Encrypted: i=1; AJvYcCXuevVdVBXwZ8UGItXp8iouVD02XmEa/YIpjj49PyPkp618Nx6X5Bl9W90ShtSU3Hm0v69TW8FWdqIaAql28PQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx+W7MJTY0lJVI/0QJ1u+9E918WVjTEb/7PNE5HJT+4vVTiwMt
	pTNnbWFoVTvGuKHgjUI1EJQR7TR/hvDRJ1190AAkHrYMLzFkkCovMDEkfAIVs1EXJMg+vka6/bM
	bJoYx5+WAojKgoWK7SdFqbnHAHr8ga1Jl1UZZwcKpLJghYMZeKomfJUWoOJPzD/Og07qZig==
X-Gm-Gg: ASbGncvJE5iFwuTPcPpu5JhfbSMoZAdM5YV4zRrSuJVOhPvLXNBwZMjIaDJtJ7uwcXq
	crENZa4VugFSG+23xkzzGrH3L0Qcn3B2mbM3a5nw4CoEzYxH1fRjMmmVg1H6TrR+MVHKmkNUiJY
	0HBZ9HEn7xkCsvzfwpNdmZ/WsENSgLXWgg7BIVSqmKSeLu4LvlKInNT3gyVzUo+zWlHOmCAEcFI
	ZX8TVFH3yZlN4WHzqxKs3l9wK5TT04m3E0nZQoWFqToGfU2sNSztyqVS2+JkylJBv9iqZYHIRz6
	6H4Zm41hSvS6jbWqyerepEjmC2ljdJqryqDLYiZqA7Q9SDA8RMyKepRooX8W5WmLBfQ66PswVG1
	VjA==
X-Received: by 2002:a05:6000:2906:b0:429:cab5:7852 with SMTP id ffacd0b85a97d-429e333cde0mr5731249f8f.55.1762427170001;
        Thu, 06 Nov 2025 03:06:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTtI8vYgnO1RGwmVN+jHUiMzYwpB1QH1SDyUcEnFBvLnN6YC5pja1tLsRgCwJnde/PfJVqIw==
X-Received: by 2002:a05:6000:2906:b0:429:cab5:7852 with SMTP id ffacd0b85a97d-429e333cde0mr5731215f8f.55.1762427169550;
        Thu, 06 Nov 2025 03:06:09 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb4771f4sm4333146f8f.22.2025.11.06.03.06.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 03:06:09 -0800 (PST)
Message-ID: <f98d3cab-7668-4cf0-87bf-cd96ca5f7a5b@redhat.com>
Date: Thu, 6 Nov 2025 12:06:06 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 03/14] net: update commnets for
 SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN
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
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
 <20251030143435.13003-4-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251030143435.13003-4-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/30/25 3:34 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> No functional changes.
> 
> Co-developed-by: Ilpo Järvinen <ij@kernel.org>
> Signed-off-by: Ilpo Järvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  include/linux/skbuff.h | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index a7cc3d1f4fd1..74d6a209e203 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -671,7 +671,12 @@ enum {
>  	/* This indicates the skb is from an untrusted source. */
>  	SKB_GSO_DODGY = 1 << 1,
>  
> -	/* This indicates the tcp segment has CWR set. */
> +	/* For Tx, this indicates the first TCP segment has CWR set, and any
> +	 * subsequent segment in the same skb has CWR cleared. This cannot be
> +	 * used on Rx, because the connection to which the segment belongs is
> +	 * not tracked to use RFC3168 or Accurate ECN, and using RFC3168 ECN
> +	 * offload may corrupt AccECN signal of AccECN segments.
> +	 */

The intended difference between RX and TX sounds bad to me; I think it
conflicts with the basic GRO design goal of making aggregated and
re-segmented traffic indistinguishable from the original stream. Also
what about forwarded packet?

/P


