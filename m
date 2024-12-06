Return-Path: <linux-kselftest+bounces-22908-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 982159E6B05
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 10:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA0A286ACF
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 09:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B991EC01F;
	Fri,  6 Dec 2024 09:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="MkXaibff"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442691DA0E3
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Dec 2024 09:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733478520; cv=none; b=bmi+kDSRaHbCztgAPx1UbuPjeevioSri/PCT5Vwj2d+DpLPnxMn8DpPJ8Y/FQ4OWRckJ7pwAV/UseMOIJYEfQ2nLvO8TMZ3SoQ4G1RRerYTfvFDPefK4doIPwJIJ9xS48T+uK0fY7DBCZ8EMN4MmMqnpSNSCaZggxGbQriplpT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733478520; c=relaxed/simple;
	bh=2r8pylXs/Twu58JrlVG7EteCTVgvGwN9RIoZuY7VaOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KOtBABSl+uPR/+1em+4D00TA8ZKzGZqL6FQWM6Q36GQfyvvzmfbhUr5+VNG2Utq01hRZgOb+DDNZzrOLC19r9m4c/Pu8m5k2RQbQDR7cD1qxxzJgqk65H9yka/s9I9oTkTZC5/D/lUhTjsgD3BpF4z6LWjjro2glRlfnFixJp2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=MkXaibff; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d122cf8dd1so2976465a12.2
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Dec 2024 01:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1733478518; x=1734083318; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sMK56cZTycgI4vfKzSxxk0iKhdhNGddOzETc8Y9Cd34=;
        b=MkXaibffEDMgMnfXyWZCfH/EKS73ppzD7oJdKgBauiwylAyRYSutS7zslV2KrmjWVY
         5F5HpElHnJWkK22SWb6dR69MN871+AKKrebXVWCGsx1yRd13a62e/mR8logTBTnpmisB
         zTdPDe6NgbF0vYzGWORiaz96gYGH/oHgdBBCGBpRZ68KZ9/ybrZ7Hl+b0Ju7Pf7dOaDa
         XPhnZIivmqO7g58FV3FQPJCAiyhQARdZuuQzKqOfWuDVjdmLDHy0feT3ex0ekQzSI9yK
         KA8DcuIA7tYerte1Ae0gEEejaNLImIXD1/dGw+nQKFOZEFCCGhRnMBXO44oNiCLjJirF
         14iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733478518; x=1734083318;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sMK56cZTycgI4vfKzSxxk0iKhdhNGddOzETc8Y9Cd34=;
        b=OpmGHpM4qr7tRptrGu7NkwBez9BN8DsWkPEgL2WvMR450pt24l1N6AdC0TNOiBeTDK
         cCLrAvoFGEvxR+IfbBN83LshXBtEljqgbm/zJ+jTaneh8k5sjOs1UHEOqrr696ZW0wGN
         klBw3KWSabSOcHmmw9/OXd12x/3CgLCRyVEw1a8EpB1fBLI51rr5DwKCD4ml+qc4d9sm
         CsjW0H3n4mjbJgXN5MOWdLij2KAxxv0KIpBCTlEJXhYf3saeFMY0UIMe5H8rfOGFSIcL
         DERN9gVcsv+aT+K2k7W1aH1C3oKPOYPeyO2BKBifE3iZd0bQQpuq+Bpg5hxji5hbtP1g
         xSFA==
X-Forwarded-Encrypted: i=1; AJvYcCVRA4GGLT7zBNaoUE/af0t/7a63glnuCkg9aj4MmecwVnA7Agvwe+kjfYwbgjISGXGXBkEv2ZQ4m8E6DCZIceM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz37qjEQiAJ9ETh3aS5Dt4bY/4ApvXEWCU5mv0dvxA+8J2sgO9s
	9JASZOXuGYzS/v8R0MVuauS7FTu4UJfmfIYA8j9JUqhWiR21FfJu+8gqjJyB/yE=
X-Gm-Gg: ASbGnct60I8MjeCeIwhiArsP1EkJxAkf3a+i7eTRb4x87iAVlsAjnap6tt/seo1VyJq
	4gEH+4zGAvR5/XkKehCkfhgQmJRT3pUI6sVXHjn89gs1uY9HCdUX+H9sm2kkxkcgzQvU7L+UJwu
	iByXPPiNnbL1Qcp/+5RqHUnndE1HffEXLF0W5iIcJ1//IkRrHeUOBToiWH+ztvYeQ5OfhxMMAmF
	XC0Mwwc8E9GYKA1DbWHjO/uX1rEpTCnMS0dQSfWBICByeuflpvp6iCk
X-Google-Smtp-Source: AGHT+IEQGz4ncGLxW+djEWICPN1ZiR6AxySVCJxhG8ZLE1Sap5DiS8K+atDERjr+4pNjgY4Se81ejA==
X-Received: by 2002:aa7:dac9:0:b0:5d3:cff2:71a9 with SMTP id 4fb4d7f45d1cf-5d3cff28725mr666973a12.33.1733478517702;
        Fri, 06 Dec 2024 01:48:37 -0800 (PST)
Received: from [192.168.0.123] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14c7aa441sm1893564a12.72.2024.12.06.01.48.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 01:48:37 -0800 (PST)
Message-ID: <2d546228-e290-4161-a7cf-227732ab8e73@blackwall.org>
Date: Fri, 6 Dec 2024 11:48:35 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 10/11] selftests: net: lib: Add several
 autodefer helpers
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 mlxsw@nvidia.com, Shuah Khan <shuah@kernel.org>,
 Benjamin Poirier <bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, linux-kselftest@vger.kernel.org
References: <cover.1733412063.git.petrm@nvidia.com>
 <add6bcbe30828fd01363266df20c338cf13aaf25.1733412063.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <add6bcbe30828fd01363266df20c338cf13aaf25.1733412063.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/5/24 17:40, Petr Machata wrote:
> Add ip_link_set_addr(), ip_link_set_up(), ip_addr_add() and ip_route_add()
> to the suite of helpers that automatically schedule a corresponding
> cleanup.
> 
> When setting a new MAC, one needs to remember the old address first. Move
> mac_get() from forwarding/ to that end.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
> CC: Shuah Khan <shuah@kernel.org>
> CC: Benjamin Poirier <bpoirier@nvidia.com>
> CC: Hangbin Liu <liuhangbin@gmail.com>
> CC: Vladimir Oltean <vladimir.oltean@nxp.com>
> CC: linux-kselftest@vger.kernel.org
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


