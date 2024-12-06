Return-Path: <linux-kselftest+bounces-22909-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BF39E6B0A
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 10:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 170221883109
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 09:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FDE1EF0B7;
	Fri,  6 Dec 2024 09:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="2lIHgRTJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1C118C932
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Dec 2024 09:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733478585; cv=none; b=QuwN4jfSJUZmm0slItjzqxGXQydDYIGoetKuMl6dSDIZtWIkT+9WkviWT/iQ8uefAsX3Nv+So3jiB6+r/PvjB7tLTr6Yv0Ym+Nfc0GAY5XrrU3bGWLkOIaAq8pp8yqeyTwN5GT4MyeSSbf6os0OWzT+O/teBIggxflWHePOr1QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733478585; c=relaxed/simple;
	bh=PnDB/sYV9slXqwjdQ+adiYJ8G9BZKP3IlyhMW03My5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DKQdUGUgM3vofCwwyzChK0Rqvl9Tp7qsQIxNLl6MraApKgBX5Rie4AbBPtZk9Noheg4J10lLagP/wHT4l8WD1fve8gZddV3mxhHyQm+in+jtArHUH0ebqyIEB2eWr9UhREhcCHeL5QuOp991WM8So0J7GzRmHkzQCxo+owZhyHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=2lIHgRTJ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa51bf95ce1so342417066b.3
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Dec 2024 01:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1733478582; x=1734083382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AuGUFOb/iBY8RJKzowVsntGQmfZkIN8i8d+6WuovufA=;
        b=2lIHgRTJUVgPiu0QpHE+4HXOrfauynhMdie+Me5alzQIz1fcn1cN2iENiFkYbeFhWb
         m4gD/XVsHWz49+kem84b/hMyLqctvhisb6wwH9SHtiVHf60Yl8Au4roiDZiE8utlHPE/
         69zyEWuINXGF9nMEPzJHt7qtLXxFCi9+9ZniHfepNrVTaVcqszJKF1RrdnMchsX6/bjD
         oSAssq1/4/Y3g5ZTI/PWld9ZaYUktjQsZ+vQ7p99nRL6Le12SnZdHQ2pqxZMYIROvWnf
         L/JwqEcwMGXx9HtX5k4VQISG9AbgD0QTWSDnkmjayc4XMmQbRmxH+F03mMpkc0QYtvO5
         LyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733478582; x=1734083382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AuGUFOb/iBY8RJKzowVsntGQmfZkIN8i8d+6WuovufA=;
        b=toafYhwGjce1mSrklNhVnc70eCqVpQxcvU8WDae5tfYB264W7nDHrx8H+cSauGw3iW
         imuC4v0IHIQdvRMuHfSxH3e/LAAWOtkNKIuKxGAtdSyNasmCbzkpVoZVbCGSsWlCl/Yn
         PFqqJhmqHNsYm0AHesR7+x33SCCz5rjThgR/grzbmyg0qOY4wl4BvCKdZ4mIl8EHfiM3
         /Hl6/7PLMCGyVOGGx4+ASnEowKBaxTnZD2Bw4naWnD7cyYYodiYyBmgJtqW5Uk0ha3S1
         PBhaOba7P6+Nd6buThtyXdr659SIa2QUyLTNQo7GHpy8W35xjqPPffNjIjdrz92g32dk
         5KwA==
X-Forwarded-Encrypted: i=1; AJvYcCVtBP0DQPK/wEcH1A9NhqFkBDGXEMXIT8zYnZumw80GtMU0B1sEmWl2OVVAx+lPZ/joTBkpqnIBHDCGZDHchvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJvPasaYmXqplSo2DllvDtzYCIUuObTyWY3vjcM9oP8n4OjoaU
	YvoHABETZz6bxbuN5YGwGyObwmU4Hk9NwSFCHkBzKCOIv/xP83wDTQKCQy0PVRI=
X-Gm-Gg: ASbGncunW4GXj8TWHC/YeIoyDMKmVoBo+kMtQ9jfjTAqCXJ9hcEXu8fw9JjybId6bZD
	kpUt3adivMWV6h5ZBHqWb+J2I9ss07SPwiVJNHezeeJ2LO0e00dfl7bEpeVjt3vxaGaiCA6AMhY
	lbM0JUTY6zyBcNCwT455ZH2Qe78v4pFcCjWSsRcOUUL7DZILlqU0hGxBe2w2m19RpjJqAZumdhh
	0dpeIQB4y8r5vyGKeLvx5aY7waFoEVKYEZDRXTq06D85dPtptmt
X-Google-Smtp-Source: AGHT+IGlZGYFgwmwFeNFQJwgjuah6WRFJxdm3tfG1ry4p/ogHPRA4+guYXrGWdGdYUv9BzFp83k3/A==
X-Received: by 2002:a17:907:9145:b0:aa5:630d:7de0 with SMTP id a640c23a62f3a-aa63a26a7c0mr170543066b.44.1733478581999;
        Fri, 06 Dec 2024 01:49:41 -0800 (PST)
Received: from [192.168.0.123] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e4dc8asm213942166b.35.2024.12.06.01.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 01:49:41 -0800 (PST)
Message-ID: <e7cb6b0b-afce-459e-a781-f78ed0af241a@blackwall.org>
Date: Fri, 6 Dec 2024 11:49:40 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 11/11] selftests: forwarding: Add a selftest
 for the new reserved_bits UAPI
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 mlxsw@nvidia.com, Shuah Khan <shuah@kernel.org>,
 Benjamin Poirier <bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, linux-kselftest@vger.kernel.org
References: <cover.1733412063.git.petrm@nvidia.com>
 <388bef3c30ebc887d4e64cd86a362e2df2f2d2e1.1733412063.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <388bef3c30ebc887d4e64cd86a362e2df2f2d2e1.1733412063.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/5/24 17:41, Petr Machata wrote:
> Run VXLAN packets through a gateway. Flip individual bits of the packet
> and/or reserved bits of the gateway, and check that the gateway treats the
> packets as expected.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
>     v2:
>     - Add the new test to Makefile
>     
> CC: Shuah Khan <shuah@kernel.org>
> CC: Benjamin Poirier <bpoirier@nvidia.com>
> CC: Hangbin Liu <liuhangbin@gmail.com>
> CC: Vladimir Oltean <vladimir.oltean@nxp.com>
> CC: linux-kselftest@vger.kernel.org
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


