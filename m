Return-Path: <linux-kselftest+bounces-9420-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA598BB398
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 21:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AFE7B22BE4
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 19:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D5613A25B;
	Fri,  3 May 2024 18:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ddj8Fw3h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A7812F588
	for <linux-kselftest@vger.kernel.org>; Fri,  3 May 2024 18:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714762798; cv=none; b=EDNmDCJ1cZVZukdo1A42LEJtD6zvoCM+ao3+L6eRFjMqtlDX96UgJRkwLiomCrUfS/4UEFZ7kX1bceASQemUZCUNVC/YgpAi67m3LkDHijP7kJqiGQ3yavH6Bca7wOIYBBDyZD9946SC/TSQJ2oVh76gr9Ma9/ABEcTkVSqHd/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714762798; c=relaxed/simple;
	bh=vstfoZvHsAcXCZCvOZqSg5KA/bwkjUFboyKSn6palj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mNL0PRVVwjYq+uS3DmR9w11Z5iFeYlqU7DozbZPgD7gyzFJmJR+APC3b7dThU2cKF9TljmHBADgDyVwg/pjvjD/OzJ2Ql9nM0onhm4h10SX3CAS3RBFtI5n3WBuUNnk5djXC5ffSh9fMHUtSYjgqP5ZGIUhs0NQWlno7TR/6c48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ddj8Fw3h; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7dec9c65057so46242839f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 03 May 2024 11:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1714762796; x=1715367596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zK7EjngVwHxCdqRBj4DTZ+w1kW00DuCOALFXYA7wuDI=;
        b=ddj8Fw3hiXbVeHPP9J7nRpOtbBZlfSnozmvrikXmssHMvCnr64VwE6TdZ61Hh5CwJi
         SV371pAmkbO99or4+RbvwMoqL1ytIvrofc+Rm52r2de+6gnq6qGXFLC6/bjGRV+sosMa
         MZpm3UqL8o5O13UafPKy/yX/cVlgBBj2nSsLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714762796; x=1715367596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zK7EjngVwHxCdqRBj4DTZ+w1kW00DuCOALFXYA7wuDI=;
        b=XeOK+OKkVeS+KNXjrZvU2D+cl3oufIYVQ5eTXYdlABc93J/y+5R7J7BWXy2ESl6GgA
         2DWq9gIQqxqREfxHJw9LpihQz+OeSq9F8abwcDqubGNLYlnalRAanmGwgB6DGwobDd5k
         GsxmZuIZF5WqtmYZErKzURPJJBJwBe2MlB+KfEufr/t9bwf1Mp4SHrfsN2XrAOI+0wnm
         AvJwVnzwt40qvrGzF9KIqEERZwECubslBq5nm9avrbeiaoJOduH7IY10b+/HdYiLSqp5
         htDju0/B6yodtRyPClAMxEdmc+6kBEf3rBxHFjGQR1rsS43o5o5lSa4cPIz4ifkiOl65
         z26w==
X-Forwarded-Encrypted: i=1; AJvYcCVyjHodMkb32AoNqacyok7ufVgKcHknAXbuoWcdPnvK3ZgZtcWC4GUDYHVD8a728XW5W1/+JmXqLOx+CruP9zJH9L5zVW0PRw6vD0wD8vGN
X-Gm-Message-State: AOJu0YyvWNV8/Dg9GQ43ZAnRlTA+I6OEOlQMAQ/zDjzospYtM8m58xat
	gBXvBOgaGonIueANEQbe0FEFH3YvtnDtuaUH9XlQqEF2Y0cELos3u8NBsrc4MC0=
X-Google-Smtp-Source: AGHT+IGKOG2BRFN59lfSUvaPMYRftU2oCo3evPUBOi38lV7vpEyniKA6Hz/kFSVNmS0ClAbtZJsuug==
X-Received: by 2002:a05:6e02:188d:b0:368:974b:f7c7 with SMTP id o13-20020a056e02188d00b00368974bf7c7mr4362981ilu.0.1714762795516;
        Fri, 03 May 2024 11:59:55 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ix13-20020a056638878d00b00482c2bcabd5sm933236jab.2.2024.05.03.11.59.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 11:59:55 -0700 (PDT)
Message-ID: <6a54d332-c13f-4d9c-93c7-7700baf951f9@linuxfoundation.org>
Date: Fri, 3 May 2024 12:59:54 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: kselftest: fix codeblock
To: "Yo-Jung (Leo) Lin" <0xff07@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240429165047.16088-1-0xff07@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240429165047.16088-1-0xff07@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/24 10:50, Yo-Jung (Leo) Lin wrote:
> Add extra colon to mark command in the next paragraph as codeblock
> 
> Signed-off-by: Yo-Jung (Leo) Lin <0xff07@gmail.com>
> ---
>   Documentation/dev-tools/kselftest.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
> index ff10dc6eef5d..dcf634e411bd 100644
> --- a/Documentation/dev-tools/kselftest.rst
> +++ b/Documentation/dev-tools/kselftest.rst
> @@ -183,7 +183,7 @@ expected time it takes to run a test. If you have control over the systems
>   which will run the tests you can configure a test runner on those systems to
>   use a greater or lower timeout on the command line as with the `-o` or
>   the `--override-timeout` argument. For example to use 165 seconds instead
> -one would use:
> +one would use::
>   
>      $ ./run_kselftest.sh --override-timeout 165
>   

Thank you. Applied to linux=kselftest next for Linux 6.10-rc1.

thanks,
-- Shuah

