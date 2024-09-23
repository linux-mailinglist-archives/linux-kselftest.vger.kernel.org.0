Return-Path: <linux-kselftest+bounces-18229-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6B097EE37
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 17:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92C44280DA0
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 15:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1CE8821;
	Mon, 23 Sep 2024 15:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OqFbf+5v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4E28F7D
	for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2024 15:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727105442; cv=none; b=Z2M3eC+I9fY8eCvJPTAu1hTOlmx1gnwVgZMFlbgJdcUrpXSwSVxZE0PQqVwU0eLfTXg7/3SnrZOZ8ACi23mgqIUYNQM0VC47EqMkLOBjOipajPSEgyM4STX571uYazXf1t4JijTmznWvLTcmX+Js++r3mjw803NlxH1wMT7ZFAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727105442; c=relaxed/simple;
	bh=uLcW+rmXal26v/z8vhGS2uCWTvUZ3yU7Qp6E43BG2TE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gAUwmFLp2juoC++xcp8+OTWytHjbzS/Fv0u5qLuywMyZHaMsfCGzhY9bF+LtRRZc7t5/5II1XUNHDZUBjiX2Vihr2ikFV5cVPgdgjXCH/Y/IntAxkzY6DOVosh6qfDoX9Ofe43RQdPRVZEBmkvUJjU6M0KdUzOKgEMyXXKSu7xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OqFbf+5v; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-82aa4fd82a4so167813439f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2024 08:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727105440; x=1727710240; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2blkRbJ8CGcwwGlLk+/59C8XZR2HuCSI/93XNrDLmVQ=;
        b=OqFbf+5vxEVbBBDsE79Sx+AF2fY4Z68oSh6v1GOkm6GpEA25B9y8BqWIy4qQwz2MqE
         rifBBAnH/z3he1xelOm86WRP8Pa1d5s3PRC+S8oU7VbZKssbkrcJjyNcQLLlfnKGox7u
         J1w7o+GUoVqlsVNmKwE0D6bwkjX6kj0xdNEZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727105440; x=1727710240;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2blkRbJ8CGcwwGlLk+/59C8XZR2HuCSI/93XNrDLmVQ=;
        b=boN6pONQBhCDpdJIw9M09YflJMvWRifYeYH2e5QnkygFnq4ix6dhLFn2n0TdWydZrS
         Jy8+iK7KWCcWympktPTQZCpcsnyYnyk88LzRFIDrxOBq119LwZ+iYbepS0Uh2m7c4htY
         jA/4Jo5YD4//Qcy9qBHHiI9N4PnUpU8UKEQIkVYaOXMcx2YzOvWjvH6s81zFAPHpCst2
         RwUX/haj8cx/tk+e/71cokzoyTmSo5jEXbH7YiF3VI/KYa3l7zrzwfmj7nh5YbjNco8W
         uLYMwrlQaDXyxTagmgdY8XIPlLzsOu83FM/asa8OILPL7440yvCzQWsJppZGNOc/EAYl
         vX8g==
X-Forwarded-Encrypted: i=1; AJvYcCUvRZt16L0pmzLYWGcYld2BNXxTl9se1cjL1iHCn3XwbzE2GU16qxgNoCu4uAjcTjg2poMiRYDmzIACSW1GciE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy0/HKAHMNYTGviwcQLf/6ave6EUDGyzcYJZEaafo5I9q0QsfK
	suQUWHXVXGtsvNoA+xZ20kyT2GHi8B9yNXZcAJZhsQ/UnVFgy22iMtlWz70Rffw=
X-Google-Smtp-Source: AGHT+IEZHFqZhJPpuh8lpcucgIPAfvdLaKHdd3ud3PCtOcv8Hu1ILkdM0XQzVYjVeaVWztPK0owVpQ==
X-Received: by 2002:a05:6602:6427:b0:82a:545b:113f with SMTP id ca18e2360f4ac-83209d7af46mr774540839f.12.1727105440160;
        Mon, 23 Sep 2024 08:30:40 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ed59609sm5156546173.162.2024.09.23.08.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 08:30:39 -0700 (PDT)
Message-ID: <87684869-4565-4a4a-845f-4301242be52a@linuxfoundation.org>
Date: Mon, 23 Sep 2024 09:30:38 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: vDSO: fix compile error for
 vdso_test_getrandom
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Yu Liao <liaoyu15@huawei.com>
Cc: shuah@kernel.org, liwei391@huawei.com, broonie@kernel.org,
 linux-kselftest@vger.kernel.org, Xie XiuQi <xiexiuqi@huawei.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240919111841.20226-1-liaoyu15@huawei.com>
 <20ef1a1d-db00-44a7-a550-0b293d6e0d0e@linuxfoundation.org>
 <0010d5c7-388e-d648-8320-83b9fd16e615@huawei.com>
 <3e3507d8-f17c-4af8-83cb-682190f5bf67@csgroup.eu>
 <CAHmME9p9iy+d2wx3vpD1XbVde9WvcJ1agTOqcNw4z=WABVn5XQ@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAHmME9p9iy+d2wx3vpD1XbVde9WvcJ1agTOqcNw4z=WABVn5XQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/20/24 09:31, Jason A. Donenfeld wrote:
> Indeed probably <sched.h> is what's wanted here.
> 

Yu Liao, Please send v2 as per the review comments.

> Shuah - I was taking patches for this code during the 6.12 development
> cycle, because it all interacted with the dev work I was doing. But I
> think that's died down now and things can return to normal. Do you
> want to take these like you usually do now? Or is that annoying
> because your tree won't be based on them for another cycle, so I
> should still do it? I'm okay with doing whatever you want.
> 
> Jason

I can take this through my tree - I rebase as soon as rc1 comes out.
We can also handshake as needed if there are conflicts still.

thanks,
-- Shuah

