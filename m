Return-Path: <linux-kselftest+bounces-27808-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CCBA48B3E
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 23:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4165D3B5518
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 22:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00673271827;
	Thu, 27 Feb 2025 22:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAStz5ns"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7337A271284;
	Thu, 27 Feb 2025 22:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740694728; cv=none; b=PRaFAKMXRnJcF8Qg5b3vcouqOIC9DoBQdBg2Z+PjY8r3XKxLkwk9gSwyWUbGE/2CVvd3BL/xXUol/sz64WHJIEYmzI/GniM7TP086GxVTFH8rQN6xGein5rPzYCT2TEF/7ZjmW+tf7QY1+h75lcU4EHYr+wiHq01u2/7IW5LL5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740694728; c=relaxed/simple;
	bh=ErEdHSPSAm1Ij7j04xYeOWaR03Jf4ba90j13wrapdiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ct7ARYFwdH5Mvdbli1iLqt9e4WaJTXXuHEdKVyTuusUbo5od4tPcZ4vJL7/qwEq+8wBxxeXSWdEcojVqdBj9HGpxtq6EhnLR1HvU8hohEe/UK24wJbGCRWnO6unflFVbwgwbxNe9JYU+VMK9r4fx8BaPj6nQ+JCxM1K8lT+7v4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAStz5ns; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22328dca22fso24113155ad.1;
        Thu, 27 Feb 2025 14:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740694727; x=1741299527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RB8HKvW32Uafan7tipnlON3ASA7K7jTmMsTyQf4v3Os=;
        b=WAStz5nsl1uG7dWA/KPeGf+mi33zExkOGsXTyCKNKl4L+wwmUoxt3SrkWtKihszHXd
         FWqBgfgadfawC69SKa8yBKQ6FZJywCNz7y1Gia+ItNauYVjUbm8FtwWsFmmjmfH8bhxf
         vE3jFEZTREfm7P5FZMv9OJOZlSHdF5gywuEekCmt+bRH/mnCxNo25YbhryzqTtAAUtCu
         QH029B+qWpLlpOcm0ri/C305Kf2K4fk8gC9m5dUwSJYHfTlXyPs72J4GTNwhuBRHGcDs
         MjiYi3fmDHtHL0c7X32ZFy6PoUhWbJJVB59KG7HgEqN7AeCts7neR+7DbBvzPMxmouvQ
         wMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740694727; x=1741299527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RB8HKvW32Uafan7tipnlON3ASA7K7jTmMsTyQf4v3Os=;
        b=sSGhWp3BG6SH5PncfK2m15SXBKDQRJDHrPYod6QSRDob+JpSvMt5m2/9ONp39vATSK
         j+FND19MOBK2efHVsJkm5vENEhbT7u/Gck7UgLRNnfucwTGJBq0rLHK5znDsfp2HiCtU
         02YElRZct7sWLkf23BEPqIhn7xUovgaRyX3nVO5TgQy1/2Eav3jrV+COYUmdvveO9qIU
         O1tjw3M7qYn1kE9nd+j78f6Wfdi6ak+5pF6oLaBOBbbzjjVo0XJTOl8MuGOL96PgWTyi
         8r8LVYYCBu/rEWf9oPP3pN26NwRNN+qv67EqKAPvwhkVrcpIkEKnfEbGHmKRGFwH6qKv
         fi8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUNA6IT3zzDO9n5/+/b8X0ZDaz9KkXGI/F6EcW9E6jXUuzOsF+kQdY4j8wrBJZY1tJJ2q51qOz8b7husY68uoIM@vger.kernel.org, AJvYcCUeJIHKQQNl7ufBpFhgCCt6wxYWGcZaJ+tdnOY+xDR0M875vr0bm1ICR7KyfMPpSdKUJSU=@vger.kernel.org, AJvYcCUwbGWjoehUWHs7nRtOJYrU6jYilazWw2LUjNzYWk9sALsR8UKjriFZdxXiWO0X39TVLBaiR51awS4kSA/P@vger.kernel.org
X-Gm-Message-State: AOJu0YzCQ04E6V2WAhjN3XB+2P7kfEwhMnpUzui9gyuwQ+SnvgYGUq9w
	8ybzqCJc+uIjFVRNUei01muAISwMhQIJff52rc1r7Z7wG6MeccE=
X-Gm-Gg: ASbGncufLvJstza57VbnCDKiIcwbIrKlMMiB7ejnmW+7ITJJZ9cZzMjsruAmae5NWRh
	/4pqVo8jncwspj5GxXN387Z58R2lHPCTlciK7UlP5tLjSoeIdtOniz6mAQ1c8MiisAJjVhB0sf3
	mNw6tKBnpbNiYgu+a3ZLvi5IwZ5lLqZgEOj4lNjszzilDOaV5JSDlgja++V3AgTvkeZXwpCD7SI
	gdxj94aS/7lLnfBbpoKbeH+Lfb0DWmEwX1V5bM35WNHTUPa121ybAIRYGPqdsial/cNjBxWqB9j
	dcSMh7Iuh9xQvy9vwKcnDARtPw==
X-Google-Smtp-Source: AGHT+IFXU6d6VDzfF2B8yA9tvfod3ttMXDWjZrYym6DaM07m7smD+h3Q3SBynY9VMoQehMPrjNwxlQ==
X-Received: by 2002:a05:6a00:1884:b0:732:6223:552 with SMTP id d2e1a72fcca58-734ac342d57mr1568836b3a.1.1740694726643;
        Thu, 27 Feb 2025 14:18:46 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-734a0024d40sm2331204b3a.93.2025.02.27.14.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 14:18:46 -0800 (PST)
Date: Thu, 27 Feb 2025 14:18:45 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alexis Lothore <alexis.lothore@bootlin.com>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 04/10] selftests/bpf: test_tunnel: Move ip6gre
 tunnel test to test_progs
Message-ID: <Z8DkxXy9ZAbASXCk@mini-arch>
References: <20250227-tunnels-v1-0-33df5c30aa04@bootlin.com>
 <20250227-tunnels-v1-4-33df5c30aa04@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250227-tunnels-v1-4-33df5c30aa04@bootlin.com>

On 02/27, Bastien Curutchet (eBPF Foundation) wrote:
> ip6gre tunnels are tested in the test_tunnel.sh but not in the test_progs
> framework.
> 
> Add a new test in test_progs to test ip6gre tunnels. It uses the same
> network topology and the same BPF programs than the script. Disable the
> IPv6 DAD feature because it can take lot of time and cause some tests to
> fail depending on the environment they're run on.
> Remove test_ip6gre() and test_ip6gretap() from the script.
> 
> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
> ---
>  .../testing/selftests/bpf/prog_tests/test_tunnel.c | 110 +++++++++++++++++++++
>  tools/testing/selftests/bpf/test_tunnel.sh         |  95 ------------------
>  2 files changed, 110 insertions(+), 95 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
> index bd1410b90b94773ba9bc1fa378bb7139f8d4670a..f00727aedee0c283002c55a45a04a96013d39a5d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
> @@ -71,6 +71,8 @@
>  #define IP4_ADDR2_VETH1 "172.16.1.20"
>  #define IP4_ADDR_TUNL_DEV0 "10.1.1.100"
>  #define IP4_ADDR_TUNL_DEV1 "10.1.1.200"
> +#define IP6_ADDR_TUNL_DEV0 "fc80::100"
> +#define IP6_ADDR_TUNL_DEV1 "fc80::200"
>  
>  #define IP6_ADDR_VETH0 "::11"
>  #define IP6_ADDR1_VETH1 "::22"
> @@ -101,11 +103,21 @@
>  #define GRE_TUNL_DEV0 "gre00"
>  #define GRE_TUNL_DEV1 "gre11"
>  
> +#define IP6GRE_TUNL_DEV0 "ip6gre00"
> +#define IP6GRE_TUNL_DEV1 "ip6gre11"
> +
>  #define PING_ARGS "-i 0.01 -c 3 -w 10 -q"
>  
>  static int config_device(void)
>  {
>  	SYS(fail, "ip netns add at_ns0");

[..]

> +	/* disable IPv6 DAD because it might take too long and fail tests */
> +	SYS(fail, "ip netns exec at_ns0 sysctl -wq net.ipv6.conf.default.accept_dad=0");
> +	SYS(fail, "ip netns exec at_ns0 sysctl -wq net.ipv6.conf.all.accept_dad=0");
> +	SYS(fail, "sysctl -wq net.ipv6.conf.default.accept_dad=0");
> +	SYS(fail, "sysctl -wq net.ipv6.conf.all.accept_dad=0");

`ip addr add ... nodad` should be a less invasive alternative?

