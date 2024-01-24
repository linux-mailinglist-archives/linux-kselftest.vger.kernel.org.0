Return-Path: <linux-kselftest+bounces-3499-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F7D83B5BE
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 00:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCDFD2853C4
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 23:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5459613664F;
	Wed, 24 Jan 2024 23:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2agXMOA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7B012C532;
	Wed, 24 Jan 2024 23:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706140323; cv=none; b=k0/Z4neq4U9PaVSHJS3+w4mBiO/Dxk7lrXbJPLFOgPkGf5NRZyVw+8Xe+UnQP/6gO8bOqvZPV7AUKfz6jS3nUaO3sZDAoRt9ssts7RdVXcs1i/7K29WLGlqC3Ow7VsRBGQnroHOzpxrN8ZlolepnnM9aHRNMj0ClWak03+Z9zsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706140323; c=relaxed/simple;
	bh=2hvgdzr1IGarJ27oIm3E8HanMERu9rz9t2mfRppxYlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VkIsLtGomhZT3uYVxDxiFRVnteRbIObYqIEUy9P4730Jh1gTElpeUXxzIGJ6GRP4M8gfXxjuimYwG8RTSUaRy8qLyjw4jm5iKKMUMeI5Jq5ZkAlINGvVEYUBX55pztQCEiXbfBWXIFUkYpd3QFgxhZZPJiUYabWBTU/toJxF8kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2agXMOA; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40eced4c61eso1271455e9.2;
        Wed, 24 Jan 2024 15:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706140319; x=1706745119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DU9iRQihqU5HWSAWqNEeyXIpwWSEprclpxP8SAr15HE=;
        b=g2agXMOAB+g5C7L4/GQB4szm6BDmYXcIV46SN6JuMwZSmXMntahOmY/ka1TMK4olmP
         SAWu72KIMaU6UauDet+I9WiCOUXXfMdx2Clzok1fC6DghbMX78WGHvrxG6ZXqGlQ+tLX
         pL2jqEDdXIwDza1CycEdONk8sJD+yD2SmvNVbgh2V5k47pv5sFvnef3WfOjqbOu17Xvf
         uccApHc8CF2mjeiGcFVVQqIRg0ekBFJGja+16Mk3dJ30tGBGMZcVjJfHiaUJVunSa4VB
         SkVt6pHGry6xjtinbjBbp8FmAjHBAivpuCoHonhhqabGhzDoLw7D5s+0S+E6RVGVfskq
         N+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706140319; x=1706745119;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DU9iRQihqU5HWSAWqNEeyXIpwWSEprclpxP8SAr15HE=;
        b=ug9Gl3l1X9Co9oX6WItJVfMdLROyRCkeM1arQpXy6cZ27wU1brJe9Nz8loU/FKC8MV
         NxFlkw9QIqinDyUN3Rk0jdmkxFJTdgJ1wNja0JZHDS4LFX/RXdcZ20AwdvyPMFY39bn7
         9TMukvcHYOB2s67VLO34ALhxJ7rNB+LcuaR1FtVcmSpiJEGokNwYDbp5u5ugX89sGVfx
         dx+ALWUPPeXhub3+oWngt7/UXwEWg3hY44HI+xGTwTRzZRtnhra1oCADmCilMUJVNySf
         anbs727YjE1tzzrSVwg12n+Ura0tH0k8vZWypNsAIwdRw/75Jmgw+UsKI3AbNPniZG76
         4MHg==
X-Gm-Message-State: AOJu0YwP0ozVrwqgtXV6+jhVznZBuUOuai/FFdyljdeN/YM9pQANyMu8
	WU/E/In6HPukTZdaiUWp8avM8z4mk/M6MUF2JgBxPY5CgkDt/ljR
X-Google-Smtp-Source: AGHT+IFxQHOLea1eetID+KyENChxIEPJZkriCmk0tfuIx7gkpJgAOnVd5FJKWUfpySdW8ZEw1pxmkA==
X-Received: by 2002:a05:600c:450:b0:40e:4d21:6729 with SMTP id s16-20020a05600c045000b0040e4d216729mr2008839wmb.71.1706140319198;
        Wed, 24 Jan 2024 15:51:59 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r20-20020a05600c459400b0040e527602c8sm597192wmo.9.2024.01.24.15.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 15:51:58 -0800 (PST)
Message-ID: <6fc2ff95-35c6-4962-a299-3f520df7d4b3@gmail.com>
Date: Wed, 24 Jan 2024 23:51:52 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests: tcp_ao: set the timeout to 2 minutes
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <20240124233630.1977708-1-kuba@kernel.org>
Content-Language: en-US
From: Dmitry Safonov <0x7f454c46@gmail.com>
In-Reply-To: <20240124233630.1977708-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/24/24 23:36, Jakub Kicinski wrote:
> The default timeout for tests is 45sec, bench-lookups_ipv6
> seems to take around 50sec when running in a VM without
> HW acceleration. Give it a 2x margin and set the timeout
> to 120sec.
> 
> Fixes: d1066c9c58d4 ("selftests/net: Add test/benchmark for removing MKTs")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Thanks!
Reviewed-by: Dmitry Safonov <0x7f454c46@gmail.com>

> ---
> Long story short I looked at the output for bench-lookups_ipv6
> and it seems to be a trivial timeout problem. With this we're at
> 22/24 passing for TCP AO, the reset case failures aren't as obvious...

I'll fix and send a patch for rst selftests on Thursday/Friday :)

> CC: shuah@kernel.org
> CC: 0x7f454c46@gmail.com
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/net/tcp_ao/settings | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 tools/testing/selftests/net/tcp_ao/settings
> 
> diff --git a/tools/testing/selftests/net/tcp_ao/settings b/tools/testing/selftests/net/tcp_ao/settings
> new file mode 100644
> index 000000000000..6091b45d226b
> --- /dev/null
> +++ b/tools/testing/selftests/net/tcp_ao/settings
> @@ -0,0 +1 @@
> +timeout=120

Thanks,
             Dmitry


