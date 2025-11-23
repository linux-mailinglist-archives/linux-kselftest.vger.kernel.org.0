Return-Path: <linux-kselftest+bounces-46338-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 738D8C7DAB6
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 03:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3344E3AB06F
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 02:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCBE1F91E3;
	Sun, 23 Nov 2025 02:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="22Al1hVI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12A41D90DD
	for <linux-kselftest@vger.kernel.org>; Sun, 23 Nov 2025 02:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763863670; cv=none; b=hL42QfP1hcgbH4caU10CUvANiaWy1HvTziwJKG3z6VBhZVyDznK4T67R5H/gUg08HzDBeNux6BTZ8zxwVHElfLNvwXrUjXCoZSSCbanWT21ce7Pzt3Y4WQT+Jp2qhPCNlC9oahzUd6Nct1We1H20SLdAMffvdVx0NYnIpaxK8mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763863670; c=relaxed/simple;
	bh=4c0Sw81Ia9ndAt5YEnRgp/kupoHNBrXg5JI+nAP7urU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YAZOtkl4SpCix+WJmCXPuylbLdFcJWSqMNAcRwe7gdNw7VYR1kQXhjgRy4uE6Z6IPBZqFXPC+NvMUSU0rRUNexLylipsyPNR8VL4I4TglQUmtgf9iLdr8JTQOxHN+N9QDI45gvAO/izWSX2PcC7U0Y8JoCp3rD0f6f2SPeNCxQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=22Al1hVI; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-343ff854297so4667054a91.1
        for <linux-kselftest@vger.kernel.org>; Sat, 22 Nov 2025 18:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1763863668; x=1764468468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HZIoteEzegCW+0JXd1Jo93XG2PVvQC5dBeKHebsF4jQ=;
        b=22Al1hVICZ9Lk4qgGK4Bwoe5yKilKbBnrW3eSh82Bfz9WdYFvY+HNBOmxk/4xzDxZB
         Ti0RrTlJOI8cSuudBP8DtjLgbHBbbpNWxH9JkvGdzoUR3ATUAo+2VuToqdAwtkHQsYUw
         P1ZolZVQiNae9J3vfROyJSeYdON2zLkcb893tKxww6j1ziTEhhn3LlM+NYjvqwzwf5Ov
         mIu6WPEuyVq8DW/3a4p76EJ5+/8C+6ojd/XpgW6g/kWTOnIKAKlag9/ZHil4Df6EjlxR
         FsamhiKTvfvBmOyIcohr7cF//9/dVQ7rM8lutGhJtnRV9gFHid61ZE7AuwqCa+6SOPRC
         UGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763863668; x=1764468468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HZIoteEzegCW+0JXd1Jo93XG2PVvQC5dBeKHebsF4jQ=;
        b=MAm3ELZlP2fhuBjngGTytTsE2CklkqZF+HWK/faHi21gX2yMRQLH361Uh2dli6ZoWF
         OcV6URLFjKI8CSv3IBeEv7Q+I72TnNJ851tbJ6yp7fMiAOAv9SEITu/Y9+gzSPL3pmlh
         l5dTDgTdqniC83A5LZuACUKmOHX2XeSqjF8EPmaZ8BpwEk94CNxNq5upPAqAjF7RyspZ
         0u4Ftu2gKUHDnh+SL39p1zoxfpgly+WuhyBa+wPvkETCIsG7GyM3ValUJQHfmU1h87gL
         +59j05LRIemrkckamF3MbqERYy3ysLGJFFoAhtnOx3CvC/u16aoD+HCdyX6A5u9c60bd
         Vwlw==
X-Forwarded-Encrypted: i=1; AJvYcCWiQhETBvT2yWXaZ2P+VErZXBoJ8E3IP7TZYCakNXZh+Hh625yV2M/wSlSzFuQCtYEjEcSv/OMdElZ4wdUS7CA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbKEJmp878chJtFXk53zgU8iXXeMq2UhWo+ED3awJVfaUDPAKv
	GHMbkqSIBeW/G37MjKTQt4Dz/it7TNvJ5kJYKP33PydKo6oD+relEeD2QByTmYCTv3s=
X-Gm-Gg: ASbGncsDT1DVkw9YKNbJeO6FVlNkAqd+J303clAXkK1DgVl3GSIKWvPYfYq6K1akhXA
	IUNWUaT4rT2jEioXSB2tkPCppgE4jQNXXibwxseu3FqXS6ra9ZI0flKLjOqLKIcyEFewWKTipX8
	8TNKZkzygXEhHKuJcVZPVnJpncEJfPfV4n51kXxfrZKvu1aQ5PtxYS9EUFMpTFrTfi0hlWAv4Dv
	Ys84advAS9H620gf+l21M0drZTtGMNllfZfRlKeW4GnVtWtIpBz4HT1FTWgCgb9AD80Q4XvTr0t
	EqdK0s7Dt1UbfPm8/Erq4umnurusWdZwU8sd827xmzbtj0xWFDJ5I3kmb2PVsBa47v9rG0cvgW8
	d4ph+T/OQ0t5VOaWqZZnwv0zIJUGTkWyjWVocxjaE/yqFVRohVxjbkEsr+uabN0Z9Gjb2jbUqYI
	GeZnPrHKEyVJnxpcAQ0vFp+oe+8kMRKFUT0Ug+Llhjus9q/t8oSw==
X-Google-Smtp-Source: AGHT+IHRMXTXKXjEyorE/OR+JgIhlUmGW/33HECEKNiQG1+7IFPbdCPZ/lFmn8eUQeIV+QYEJHx+xg==
X-Received: by 2002:a17:90b:582e:b0:343:a631:28b1 with SMTP id 98e67ed59e1d1-34733e94c4bmr7781670a91.16.1763863668056;
        Sat, 22 Nov 2025 18:07:48 -0800 (PST)
Received: from [192.168.86.109] ([136.27.45.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ed379558sm10098989b3a.25.2025.11.22.18.07.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Nov 2025 18:07:47 -0800 (PST)
Message-ID: <ceb11201-0520-407b-b5ca-f32d1e3bfdee@davidwei.uk>
Date: Sat, 22 Nov 2025 18:07:46 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/5] selftests: hw-net: toeplitz: read the RSS
 key directly from C
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, willemb@google.com,
 petrm@nvidia.com, shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <20251121040259.3647749-1-kuba@kernel.org>
 <20251121040259.3647749-4-kuba@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20251121040259.3647749-4-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-11-20 20:02, Jakub Kicinski wrote:
> Now that we have YNL support for RSS accessing the RSS info from
> C is very easy. Instead of passing the RSS key from Python do it
> directly in the C code.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   .../testing/selftests/drivers/net/hw/Makefile |  6 ++-
>   .../selftests/drivers/net/hw/toeplitz.c       | 41 ++++++++++++++++++-
>   .../selftests/drivers/net/hw/toeplitz.py      |  5 ---
>   3 files changed, 44 insertions(+), 8 deletions(-)
> 
[...]
> diff --git a/tools/testing/selftests/drivers/net/hw/toeplitz.c b/tools/testing/selftests/drivers/net/hw/toeplitz.c
> index afc5f910b006..7420a4e201cc 100644
> --- a/tools/testing/selftests/drivers/net/hw/toeplitz.c
> +++ b/tools/testing/selftests/drivers/net/hw/toeplitz.c
[...]
> @@ -551,7 +590,7 @@ static void parse_opts(int argc, char **argv)
>   	}
>   
>   	if (!have_toeplitz)
> -		error(1, 0, "Must supply rss key ('-k')");
> +		read_rss_dev_info_ynl();

Do you also want to remove the case 'k' and other no longer used code,
or is there still a valid use for them e.g. someone calling `toeplitz`
manually?

