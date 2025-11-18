Return-Path: <linux-kselftest+bounces-45863-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AC4C69660
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 13:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E2EB636652D
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 12:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE543546FC;
	Tue, 18 Nov 2025 12:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U9u+Zopz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iwqCrtrg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF19336EDA
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 12:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763469157; cv=none; b=Sxlqu7Bx3/1bGZPQbTn2ZRvIysg82t2pibBFJxCupJpHnZRONy83ClYTIIvNlQxgqnG5f7cSAs2NbyM7p7bAhekkDaj3T5ydLD1aYnMgRQwjfPkNHT3BuqC2I6Uny6LVAVt/9G2SleA1hxo4Da6JXQHm1GpLKK4kfZHvxQQBzGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763469157; c=relaxed/simple;
	bh=DTaU0Q9eSCt9Q5BWyjMoRvlzd8ouWytjAvoYZ3iv3cM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cHy+isG779MPEklf47kWH3148PjWgmj4cAsmXRe1CJOzwWV02NvDXZq3LqZd39ykgBLEYZdheqsU9fo3r5Y9Ide8qJsfXCVD0ZK7KzCnj8Z6AtkuyzCtiUlMb9YpU2pE8bq2J26kDUUpW19MXHqvBH/0CcleOIv4K8JZ15nfM6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U9u+Zopz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iwqCrtrg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763469154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8bFq98UfncIM6fG2qDwD7snvwH11yQoURKT7uFfWCO8=;
	b=U9u+ZopzuetLY3x7AyM+7zlxNP0uf5Ti3/G7CR278Bvysr5/886HWj4YA1R7O4K9GbulBw
	zIGq/GnTuGBb6zYUDb7POJYF8/KfzJZl0/RTJNrruQbf9Oj7gd1XUA3T1FvrAf10HrKq9v
	vjyZeREnASE2Osix317aT0zGlqENCtA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-tPjrgxI2N7e65Rs3TXCObA-1; Tue, 18 Nov 2025 07:32:32 -0500
X-MC-Unique: tPjrgxI2N7e65Rs3TXCObA-1
X-Mimecast-MFC-AGG-ID: tPjrgxI2N7e65Rs3TXCObA_1763469152
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477a60a23adso11711595e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 04:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763469152; x=1764073952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8bFq98UfncIM6fG2qDwD7snvwH11yQoURKT7uFfWCO8=;
        b=iwqCrtrg7psXJc5aG3UI3sOmVFNyH8/zw6dP4ZJjQXT7mjUf0MpCi68UwMPZZqqdBm
         PK9WF3u++OnG/K4TJXffXrrR5Xp1C1Szg6pQFVwPTcG4FsO65agIiO5PFfwtNuDuYkKr
         rMAsZfiJ/owxxHYSo8LJFkoaxlW1pjwmsKsbwbrL7prPLhmq2UDhUiu85FywogOJtHyy
         1i8EJj30NiQgJD/CwXAMvbrGYW6PBUJvEzMdgwmdp/3VMeEYmT+6dpTFGf/CxYTya4h5
         PO4aZXQfR10+O3XTEQ/nBpihDWQdwMjc3yIE8Ne8OvJlzOWUxaNYvGsPCkBaWFs7ZWVt
         zANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763469152; x=1764073952;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8bFq98UfncIM6fG2qDwD7snvwH11yQoURKT7uFfWCO8=;
        b=JpYVJ5Loy9jBfkL4viWI4X3RqkKdvwXCaVH0ZudvvKtDg4FgReqE4iWmQihvfGrqsm
         5Te0CABIptAGJ/n79/aRIHiGD6DKV+1tj5swLGbce552CO8ploV8Zk+5kw3bKUTYEJPD
         IDXh+43pQ0gP58cTmRzm3cBUUKB2sZ3gM/TMomgTBFIQdC5HjWuhwV/yCh1+AN16yePB
         rsbCq/VNvh80KPh6kBXSUAKx8YJSvdHDopR+GdYFV/dLbIBwXTdH19SiwneQiqwtvhmc
         E6CE1tAY8Ndubhy8JUV4KgUITcKllMDIqMqIKFAmcIc1FCaysTuVu1P/2j56KA4YtCX4
         N03w==
X-Forwarded-Encrypted: i=1; AJvYcCXHoqvmYxwsQ7en6xRxSPpyZ5CBxxgBsF3UXpcTXF7VMVDOcfHc8ABCeGUZ9cUr9LKCEURuGeIq5UGblwMdBmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7zmOfWIbU+Qmta1wda7SErxgKyOBApL31Zcibbo0cUIsI6EeC
	vYv2FLIoOHokSESzKKs+WOt8hgM4UVYpE8mDTCE3QQIYuoGdRVqAd2gXDk+SKxYzrxmSdTiMG25
	bz2XpDcBECG0SfgM1fGhXeVv1sji1djkqn6OkFhfkC928eyFE1S8ssbcw7V5bT9QznvD55A==
X-Gm-Gg: ASbGncuoFbyCjaq3NUhPPY8uQgCqu7Rs9k6Ip0hzBJWBsFavYyAFzVDgUUfFZkpV1Pf
	Tc58cOcWrqQR7qonZkUPQMJ/jU0FETta1daZY+a5i6Hc/gkPHicvchkCINs+iApunBHhXPv211v
	H9DcE+xk+Yy5WT7FEcTuOya220cXyDmPRph5e06qD1LyGrkk3lT9b7lKZEhbHURmuHdYECVRExt
	inbcZYOKKoa8qJacSQDRu4wiq6RgdtfGYXqj+CGhClrpHEsZ0hWIBZUE+Qrmq5Dlf+12wPsHnNA
	7sSI2jVWyrnQrWT8f7kt7v9RSvbNO6GteMtLGqrR4TqmW46dbqS57YeMh8XkkPdHzrharbHHZsC
	alIndbq8mZ+G+
X-Received: by 2002:a05:600c:46ca:b0:471:14af:c715 with SMTP id 5b1f17b1804b1-4778fe4f06dmr157483335e9.3.1763469151615;
        Tue, 18 Nov 2025 04:32:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHFPZWLtIKBW62/sV/sykL4J1KL6tvHkeTFz5Ymr6cDp9e0U+MBYs0Z/GsHEyfY0VQ+h19FA==
X-Received: by 2002:a05:600c:46ca:b0:471:14af:c715 with SMTP id 5b1f17b1804b1-4778fe4f06dmr157482965e9.3.1763469151084;
        Tue, 18 Nov 2025 04:32:31 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4779a2892c8sm187622705e9.1.2025.11.18.04.32.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 04:32:30 -0800 (PST)
Message-ID: <6332df88-2d49-4dd6-8089-567129f1ef83@redhat.com>
Date: Tue, 18 Nov 2025 13:32:27 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 09/14] tcp: add TCP_SYNACK_RETRANS synack_type
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
References: <20251114071345.10769-1-chia-yu.chang@nokia-bell-labs.com>
 <20251114071345.10769-10-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251114071345.10769-10-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/25 8:13 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Before this patch, retransmitted SYN/ACK did not have a specific synack_type;
> however, the upcoming patch needs to distinguish between retransmitted and
> non-retransmitted SYN/ACK for AccECN negotiation to transmit the fallback
> SYN/ACK during AccECN negotiation. Therefore, this patch introduces a new
> synack_type (TCP_SYNACK_RETRANS).
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


