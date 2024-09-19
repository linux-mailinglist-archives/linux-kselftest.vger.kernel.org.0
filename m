Return-Path: <linux-kselftest+bounces-18127-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C19A397C6AD
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 11:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3FE51C24147
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 09:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4C0199E8D;
	Thu, 19 Sep 2024 09:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eDe3lEkJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FBC199954
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Sep 2024 09:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726737135; cv=none; b=oGuvOl/ZTzdoG0Mqa6wfTS4w7jZdlMARRn10qPok5ByiNzUZwvMEOZVk/23jWm51Fl5SqkUdpuMoZYXgyFtQlim+Apl6B1fXBsBIcg17TU68xz2cv4LxiOjzMOPJoUw3mERtZfWvoZXdDfuNocoxoUNXIVNSlR0Sbg4smMk7sIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726737135; c=relaxed/simple;
	bh=GVQ0O2R1uWNT+xiUn1NlNaE8AFa47yPX2wZPeJVfj+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b/Xd+l3aiKaLDdXJlyfAfgkSidXIGZ/iHScdJh1HSb1BibhB2U4Yn8pyaB66q+r8BL6F84SmH6SX/RcQPwha20peD2ooNWabCcofPawKeCH0EOIKaJZLVP/hLmUJj+8qrYnKizB/XMuGILy8SNEU95iKRVIOcATogjPvhlrI77I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eDe3lEkJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726737133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LCElEKBH0phTZF2fIQuSy/+s0JOFGaYopSCTxfI0dVI=;
	b=eDe3lEkJNkvBzEi9lmWOhVHi1vVMMXgfrNe6IE8YSY76xUVbFARowsjKtSyJfPzidksVoJ
	TVxDymS0AiyRyjLq0xaanB00app8nVlmodq+SWpEWZdobIGhlvZZQvtL+n//VMaxXVHhkf
	BQnyNwMm7Mm0a0XvFyPsrKTrCmhWmuM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-2cfXnCGaPIK1w1CAd0xUIw-1; Thu, 19 Sep 2024 05:12:10 -0400
X-MC-Unique: 2cfXnCGaPIK1w1CAd0xUIw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-374b385b146so264601f8f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Sep 2024 02:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726737129; x=1727341929;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LCElEKBH0phTZF2fIQuSy/+s0JOFGaYopSCTxfI0dVI=;
        b=cYQKD1UItywW87+2MT27GxrKGMxAvBChdLEKTAe6U62HmIGhOo11pfNsywhnWefQxa
         JODDnOJKrmn74PHdCOZkDt+AEHmA1sVOoCei0xYTmpZ8h2JMVbdLCDhA989lSDg/dnKw
         qjuVb9sCL5aOK9JBimQgr9Um+ugC9QHJ+tpDcQaATXcAm2h7swhttbiRpVHLveehbqPv
         Wo83AmHYNK8DOeGp7HqFOX8nUptJZ5Mse9zPafsRMo/bn/IYy3Cj2Ru1q5ZAcg7lDxtC
         wA26vd7+/cbKMmlXj+ALLGk24SviYRyGOe9xFuNIjiJCzAuTePse1EsKB9qnJVCzfR1n
         03kw==
X-Forwarded-Encrypted: i=1; AJvYcCUbBKUMlbH2faE4yyMIiJgKO8cGnMyGFI14YNWBvuikhy3Sq6o37qqauEIEkyRNfVjPMrtSNc17UatNXYoL4i0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsu/SweL/Jddw17NW2YD0mLjeO2bLX7HvB1Yr/gHwm+KxK5AMZ
	ZcUxcdXq6jw7swUz20mjZnntyACTbfkjoRjMqnVNYfHkS8Yuoab9vtGsRV49beeBJtffjgI6wzD
	b2j+d9Owq4j+PAkeB72uL9+2iLM0lCsAiY41V0LXOFthXhe4aCBbGx7zTstV8t3O0Fg==
X-Received: by 2002:a05:6000:1815:b0:368:65ad:529 with SMTP id ffacd0b85a97d-378c2d06172mr13926660f8f.17.1726737128716;
        Thu, 19 Sep 2024 02:12:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiP7Zyv2OHT77WQZsp/MpXZUyd+Js26zDK1QxecEwwjKk/DBBeqSWHEiTWMF4+k3n/zDLpFw==
X-Received: by 2002:a05:6000:1815:b0:368:65ad:529 with SMTP id ffacd0b85a97d-378c2d06172mr13926622f8f.17.1726737128263;
        Thu, 19 Sep 2024 02:12:08 -0700 (PDT)
Received: from [192.168.88.100] (146-241-67-136.dyn.eolo.it. [146.241.67.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e75468765sm16452365e9.44.2024.09.19.02.12.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 02:12:07 -0700 (PDT)
Message-ID: <dd84c2d8-1571-41e9-8562-a4db232fbc38@redhat.com>
Date: Thu, 19 Sep 2024 11:12:04 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 0/2] bpf: devmap: provide rxq after redirect
To: Florian Kauer <florian.kauer@linutronix.de>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 David Ahern <dsahern@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>,
 linux-kselftest@vger.kernel.org
References: <20240911-devel-koalo-fix-ingress-ifindex-v4-0-5c643ae10258@linutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240911-devel-koalo-fix-ingress-ifindex-v4-0-5c643ae10258@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/24 10:41, Florian Kauer wrote:
> rxq contains a pointer to the device from where
> the redirect happened. Currently, the BPF program
> that was executed after a redirect via BPF_MAP_TYPE_DEVMAP*
> does not have it set.
> 
> Add bugfix and related selftest.
> 
> Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
> ---
> Changes in v4:
> - return -> goto out_close, thanks Toke
> - Link to v3: https://lore.kernel.org/r/20240909-devel-koalo-fix-ingress-ifindex-v3-0-66218191ecca@linutronix.de
> 
> Changes in v3:
> - initialize skel to NULL, thanks Stanislav
> - Link to v2: https://lore.kernel.org/r/20240906-devel-koalo-fix-ingress-ifindex-v2-0-4caa12c644b4@linutronix.de
> 
> Changes in v2:
> - changed fixes tag
> - added selftest
> - Link to v1: https://lore.kernel.org/r/20240905-devel-koalo-fix-ingress-ifindex-v1-1-d12a0d74c29c@linutronix.de
> 
> ---
> Florian Kauer (2):
>        bpf: devmap: provide rxq after redirect
>        bpf: selftests: send packet to devmap redirect XDP
> 
>   kernel/bpf/devmap.c                                |  11 +-
>   .../selftests/bpf/prog_tests/xdp_devmap_attach.c   | 114 +++++++++++++++++++--
>   2 files changed, 115 insertions(+), 10 deletions(-)

Alex, Daniel: this will go directly via the bpf tree, right?

Thanks,

Paolo


