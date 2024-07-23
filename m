Return-Path: <linux-kselftest+bounces-14062-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F29BF939CA8
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 10:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EBEE1C21AC7
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 08:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F1136130;
	Tue, 23 Jul 2024 08:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Mrse2xCZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA09ADDDC
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Jul 2024 08:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721723460; cv=none; b=pDu3QNNwWCxxz4h70MOcRcdsFCzf3xYs7Aj/Rpe9ZiNAcXqUScdxjkNOKgq1RpoLDxAeh3pKttA1ezMt9DmkTba3tNEeoIu1WDHtQTqJDKBBEfLvkuDOMav3eSTxQsv6ajiFnUVisw7CoWmS4bB/I9+hCSdNeq1C4gE/1e/CVkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721723460; c=relaxed/simple;
	bh=SrWX3VQijbUeAucWDp6ga4EJ90X99IuuDWOGGHvwIN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nJ3c4bQI0srv/AVUvSTgXnR/ZvzwdOfCMPfxHjV2SLC4eBVMk8uCRJ6y3LkPF6adSJJj4UyDU4tKOt0+fMt1I37ces7EfrJ6bEBEV5NF0CWcNrw2tHJYVJ7+tR38QNMa0NRBhUEeB+36ngDRMV+3YYYed9dBYei+EuUE7e9XJ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=Mrse2xCZ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a1f9bc80e3so2002561a12.2
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jul 2024 01:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1721723457; x=1722328257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RwptGWQr9FAjaFiuNjezpA61ovwu+YVC2AfuPz9vxJI=;
        b=Mrse2xCZK/YkbB+FXbMlikiaJQtrrFGiG+Tr1jOaNERQYn1MRLsrQ1LkIRVaqD7S5A
         K0mtUdJlbTQ9XIIJ+VudXCPWtK0XghfPHT4YfX9K8a/w4J1OHKeD7zqWOaFD01loxLZc
         CzrYvmPdBp9YyOUTM/T83xZ5vd3gSvLIDyoBwaczlHSmbcyQJ8re5Q+xMqN46s9kdLX/
         6mcDwl3YzoUMH9laRcu2tYehgmrbZI8cKAcQjKcdIFc/xizp3qzb/Gtw5q1ZaTpyG23M
         /BOTtuUx55zK8pzSoPB5euSvRMIp63EMLo7kpMLtPTbn4LuOT6U8jj8BcQ3Uegq7kj1A
         r3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721723457; x=1722328257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RwptGWQr9FAjaFiuNjezpA61ovwu+YVC2AfuPz9vxJI=;
        b=OBXcaFlRr6X4/uAyPRQGODRCGrg7fbwZtmDq/ycYW+1o7DYsc4/k408jyOYHZrJ1WR
         089moVS3cN/GKFyoQJm5xviUWwYjlHoHXEJ8KJfhrABeMiXBGIAyIY3UeDrd8eP9Gjsd
         +1TqGIc0O7xEM5AoB11LCjMn3TO9rTMA4bhSJMLB1FBcJMatLg+s9YSurMzyXTF3/5QK
         Cn+Ixrv8DsjMG0pQI6nsHYo6CM3p60gJeRspN+aI3rV0UszQxJavxifUSQtNCjAW+WVg
         I5/ZWccFmRpoomWYSR1ur/MxIOK3Jh2rKJSwaABZMYbn7dQomWGE6Rp6bUzEL6+cVsKG
         pq6A==
X-Forwarded-Encrypted: i=1; AJvYcCURZoHA14y0Pm5F8n5Wpb80P4qYc69hST+Bg8YOlRCNiOvLI3AqBAyfXb3tbcA0oE/WRDERSWkEUFxwjycuWJDt+dyjxlavL+L574mQ6LwX
X-Gm-Message-State: AOJu0YxjKmsvZMoedAowqKnaciFULv6qhzXEpOAK+AzTzFCqeRZqnKoE
	iS4llRk9rKoD9ayRRDOVtoeZYS7zNFdBMsPJi0iWKsF1MG7MCyBC2CU3MHzx5mE=
X-Google-Smtp-Source: AGHT+IGrY7I9l5X4B1N6ltEEAzUB9BtpqYSGyjjQf9lJiizCpIauD9I/q/fDtPWO1cg/wejtony+Cg==
X-Received: by 2002:a05:6402:35d5:b0:57d:3df:f881 with SMTP id 4fb4d7f45d1cf-5a478b65c3amr6581151a12.3.1721723457090;
        Tue, 23 Jul 2024 01:30:57 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30aaa449esm7222634a12.38.2024.07.23.01.30.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 01:30:56 -0700 (PDT)
Message-ID: <d5dc8f31-26ed-488c-9d63-a96b95609814@blackwall.org>
Date: Tue, 23 Jul 2024 11:30:55 +0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests: forwarding: skip if kernel not support
 setting bridge fdb learning limit
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Johannes Nixdorf <jnixdorf-oss@avm.de>, linux-kselftest@vger.kernel.org
References: <20240723082252.2703100-1-liuhangbin@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240723082252.2703100-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/07/2024 11:22, Hangbin Liu wrote:
> If the testing kernel doesn't support setting fdb_max_learned or show
> fdb_n_learned, just skip it. Or we will get errors like
> 
> ./bridge_fdb_learning_limit.sh: line 218: [: null: integer expression expected
> ./bridge_fdb_learning_limit.sh: line 225: [: null: integer expression expected
> 
> Fixes: 6f84090333bb ("selftests: forwarding: bridge_fdb_learning_limit: Add a new selftest")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  .../forwarding/bridge_fdb_learning_limit.sh    | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/forwarding/bridge_fdb_learning_limit.sh b/tools/testing/selftests/net/forwarding/bridge_fdb_learning_limit.sh
> index 0760a34b7114..a21b7085da2e 100755
> --- a/tools/testing/selftests/net/forwarding/bridge_fdb_learning_limit.sh
> +++ b/tools/testing/selftests/net/forwarding/bridge_fdb_learning_limit.sh
> @@ -178,6 +178,22 @@ fdb_del()
>  	check_err $? "Failed to remove a FDB entry of type ${type}"
>  }
>  
> +check_fdb_n_learned_support()
> +{
> +	if ! ip link help bridge 2>&1 | grep -q "fdb_max_learned"; then
> +		echo "SKIP: iproute2 too old, missing bridge max learned support"
> +		exit $ksft_skip
> +	fi
> +
> +	ip link add dev br0 type bridge
> +	local learned=$(fdb_get_n_learned)
> +	ip link del dev br0
> +	if [ "$learned" == "null" ]; then
> +		echo "SKIP: kernel too old; bridge fdb_n_learned feature not supported."
> +		exit $ksft_skip
> +	fi
> +}
> +
>  check_accounting_one_type()
>  {
>  	local type=$1 is_counted=$2 overrides_learned=$3
> @@ -274,6 +290,8 @@ check_limit()
>  	done
>  }
>  
> +check_fdb_n_learned_support
> +
>  trap cleanup EXIT
>  
>  setup_prepare

Isn't the selftest supposed to be added after the feature was included?

I don't understand why this one is special, we should have the same
issue with all new features.


