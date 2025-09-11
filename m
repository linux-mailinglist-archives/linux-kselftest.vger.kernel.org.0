Return-Path: <linux-kselftest+bounces-41254-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 823CEB53805
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 17:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A0A216DDB0
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 15:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC4534F476;
	Thu, 11 Sep 2025 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ObbB7Mvk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DF3346A11
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Sep 2025 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757605292; cv=none; b=McSm6wCiaXrCpkRQcA58OKNXr5jSjfzLuLdBvata9xsfkx4sxmwQEDFSD4xUJ2iByPuqww0uqHSfYD/fDQyTqlR0vKEFtc+652IbKlQGT4p9dxxXuMyFJurkd9bc5Dg8GuATP2BgIbZi/504F5YPRTuKcDp4ohC3CwPkaJU+6xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757605292; c=relaxed/simple;
	bh=TAt1xvybF5A6IPhp1Tj8CnOrxrbMgnAq2MtsexDeswg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h6xD8461TjVHNSgLMjCMzvMMZYo0PwDGJjxNBlrzYMIp1ActsIXLrIsu0tlsN6hW8rsqL6URPBaapsAKPl4cfmoTT/+eevZ5/3zTIGMHtD8OHktbEkv3cbgFYnuXENRkciVDxuW6zLE6Ci1dhV8yyrMrenLTklAZOFNHeNoJdtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ObbB7Mvk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757605290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xqCLZ5lR/ej010vRnUI5sNuPZaZKzMiy4/gIS4eczMw=;
	b=ObbB7Mvku0PAVfKMQOC4u+Yvcfd9FhHP+E6PlnTmWlfwgxoIfK3rC4sHfeVUMSaQEufkuz
	w8mmnOtMPVLRsD7UHgjY0VNlQD0pWx4lTTACRri+xPDDnnroeQdwymAvyNged5feEDXhe+
	abggycrhG1X37hkk/A2WhnbGrppivFM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-OV2DU1gEP5eTyrt09k84tA-1; Thu, 11 Sep 2025 11:41:28 -0400
X-MC-Unique: OV2DU1gEP5eTyrt09k84tA-1
X-Mimecast-MFC-AGG-ID: OV2DU1gEP5eTyrt09k84tA_1757605287
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45de18e7eccso5217525e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Sep 2025 08:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757605287; x=1758210087;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xqCLZ5lR/ej010vRnUI5sNuPZaZKzMiy4/gIS4eczMw=;
        b=RorMWGsdpfzltPpnlLxwRgdepoG1VDOqX2cAg8Nk3A75D4+xT/9FK5iqurweVo1YAc
         d5ZmuxJKA4G99TivF5NWUmMDIJs/luTx38Ip0udiNzLPzBXO097m8R7lzLR+sbaDSAZw
         iJUNSeUFUffREWsgyV+yv87DHccqkpWZTz5URTggemZWImC+cfa+4gGRMEJ4LyKK6JS4
         WUDbfH/KdcMfGObte02BwxjywtAdLiHKQG2ajtMyc1tdOp/2MiSqZoBHRzG2jUwyL8VM
         AzvHqYFXhGYup2eftGkHoQLkThR0zoZgiEylHUWAbcYElH7LB/OaviBS8a86ZVtj0Dfl
         5rYg==
X-Forwarded-Encrypted: i=1; AJvYcCV0daoSTUZoRvPe0OwkXfjMu5ZgPHZm4QxuTmOZzA3UMiX5jeCBLv9fUaiHxJQq5uq/AaUTitfcmCsrUJ4DZ/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7vFue8Nf4Sp4OO75K4AQeMUbtgSI2UwZj5NRFJ1EmPf48mIk6
	yqY4YzpFhqqUA49RkTy83f8Mbey1kncYJnqmZqk7MJ40iPfnWwyd8G2Z4w4weBrYgxxPLDxzEQM
	LIHiNMQCko7Bv+glQyDWckJR+Ft1z37R1s/LSFq+FJz5v337/kmug9FaDKlOU/ApDBgG36Q==
X-Gm-Gg: ASbGncvOvnUuxWfIcx17mWLDRGPmrLvDcmj8S9iFeURBbErqzCYzDJ4WHecfYv+dfFB
	JSUglFDvgJS39ngZ4WzllHXJm/FjP/v8AMW2HLnCaEyYm0aWQieyY1akH6fnyk6t61v+kwIALTX
	FV8VW/xbIvqTqjQDuM+zd1NnxdtOx4goZIFoh/H+2YGN8WvjddUPAPdNNVLR4vg1NGeTpcntYaT
	SUNLeGTO8r7M5NFAcOU0y1T7MEpHmKJX/hBIcJrSkrdOL+S0MusYMngX7aBa5yYcn26x9H7lnvo
	CMvgxvYU/wM770H88trlkUKEkzz+ozb/nmNzvhjPmSQ=
X-Received: by 2002:a05:600c:4750:b0:458:a7fa:211d with SMTP id 5b1f17b1804b1-45ddded6df8mr160615685e9.29.1757605287333;
        Thu, 11 Sep 2025 08:41:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3/syyS4kZMgaPRW3J7fU9zkQugCn/+nk/LBJjNNnNcoKhiA39KMLoKttFsUa5rSoKfoQvDw==
X-Received: by 2002:a05:600c:4750:b0:458:a7fa:211d with SMTP id 5b1f17b1804b1-45ddded6df8mr160615275e9.29.1757605286860;
        Thu, 11 Sep 2025 08:41:26 -0700 (PDT)
Received: from [192.168.0.115] ([216.128.11.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e016b5a2esm30986725e9.13.2025.09.11.08.41.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 08:41:26 -0700 (PDT)
Message-ID: <cd37574b-0c15-481d-84dd-8ccc830efd06@redhat.com>
Date: Thu, 11 Sep 2025 17:41:24 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 net-next 5/5] selftests/net: add offload checking test
 for virtual interface
To: Hangbin Liu <liuhangbin@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Stanislav Fomichev <stfomichev@gmail.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, bridge@lists.linux.dev,
 linux-kselftest@vger.kernel.org
References: <20250909081853.398190-1-liuhangbin@gmail.com>
 <20250909081853.398190-6-liuhangbin@gmail.com> <aMGR8vP9X0FOxJpY@krikkit>
 <aMJyC_YNjVWcB7pe@fedora>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aMJyC_YNjVWcB7pe@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/25 8:54 AM, Hangbin Liu wrote:
> On Wed, Sep 10, 2025 at 04:57:54PM +0200, Sabrina Dubroca wrote:
>> 2025-09-09, 08:18:52 +0000, Hangbin Liu wrote:
>>> +__check_offload()
>>> +{
>>> +	local dev=$1
>>> +	local opt=$2
>>> +	local expect=$3
>>> +
>>> +	ip netns exec "$ns" ethtool --json -k "$dev" | \
>>> +		jq -r -e ".[].\"$opt\".active == ${expect}" >/dev/null
>>
>> Sorry Hangbin, I should have noticed this when we discussed the IPsec
>> test, since the problem is similar for the other features set in
>> netdev_compute_features_from_lowers:
>>
>> `ethtool -k` does not test the dev->*_features (mpls, vlan, etc) set
>> in the new common function, it only checks dev->features and
>> dev->hw_features. So this will not test the new function.
> 
> Hmm, that make the selftest more complex. A very easy way to verify whether
> the feature is set is using tracepoint. But Paolo said adding new tracepoint
> is not welcomed.
> 
> Since all these flags are fixed after compute from lower devices. We need to
> find out a proper device and test the features are inherited.
> 
> The next question is how to test gso_partial_features, vlan_features,
> hw_enc_features, mpls_features (maybe also tso_max_segs/size in future)
> effectively.
> 
> The veth device only has hw_enc_features and mpls_features, while it's 
> hw_enc_features doesn't have NETIF_F_HW_ESP. The netdevsim device only have
> hw_enc_features.
> 
> 
> For mpls_features, seem we only able to test NETIF_F_GSO_SOFTWARE, but I'm not
> sure how to check mpls gso..
> 
> For hw_enc_features NETIF_F_HW_ESP. Does sending ipsec data and see if
> netdevsim has pkts count enough??
> 
> Any advices? Should we just drop the selftest?

Uhm... one possible way of testing netdev_compute_features_from_lowers()
correctness is transmitting over the relevant device (bridge/team/bond)
"arbitrary" GSO packets and verify that the packet is segmented (or not)
before reaching the lower.

GSO packet injection can be done with some work via the tun device (in
tap mode), and the virtio hdr.

That is limited to some GSO types (i.e. no ipsec pkts), and can become
easily very complex.

What about giving it a shot for UDP tunnel GSO types?

Thanks,

Paolo


