Return-Path: <linux-kselftest+bounces-13367-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6082A92B614
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 13:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1F97B2315A
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 11:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD061155303;
	Tue,  9 Jul 2024 11:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMNmryFo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384C2156C73;
	Tue,  9 Jul 2024 11:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523047; cv=none; b=NCJodGmwPFqXWqmXdQoKW9Mt5hwRXZs+GZ1DqU9mpB7aqPop2CiGIX7ZL8Of9sRV9yD1VUr4bbJnvI0+YnHPCXvwotLEXS4c2S2lBHswcqDzO5ktPlZcRoIkxpwhCIw+7e9hbC9pGrtoGmjrg3FjFdahs5ly6TKM/xQBY7XPQ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523047; c=relaxed/simple;
	bh=dKq29cJVzDs5S0hkG/ltrR53U5U9z4sTSyBhXno2ag4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7lO0ggpjSNCqJJoXaMMDDGnstMcn9j7HjdNcd73LVnGjRFBuyUwOqoxt4wPIR+Bi5gKwJijdpsNeZMTh4CRZ4WYK6f0bDJpFYn6cVXjPpZXlGs4Li0hpFKapn+CGZMZlH9snqj0ug9p+X6q/92PJA6ChFoIQ+D7ZpZGVUb+xdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMNmryFo; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3679f806223so2893305f8f.0;
        Tue, 09 Jul 2024 04:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720523044; x=1721127844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g1kwGWMszOBp5rS4tt3+yWfioVsOReclfUrEhGCKp/M=;
        b=AMNmryFom/2ag0OEgyVGHh2RzeYXZ9GFRu4cZ22wb8Cn7BMlY4HqC+WuCmlgCAYW0Y
         ZgvMJrIc0gnqJCt4Pi7FHfRpox3Vrj3cDUGHAmjFMq+aH7qkWjM6Tl8vEIHfVXQ4ZwLq
         RhxyxnQ7toeEEj0aQ0m6WgAfieYVCqPPm0O0fZ9kyfX4yddUFUUBynWSXCttrGVBL6eb
         mrOkftSevVtNDoZRYMLJTjopsZBhz8Zh3A/EbRS2hnm8TCfYAUITtfsC4X7rbkL0FB4m
         oaHBViUnt1ZqpO8YhMNFBlPX4pAwCANzJ6OoaoadTiLM+5hQAVWfTCDpVoFQalh+nBZ8
         KYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720523044; x=1721127844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1kwGWMszOBp5rS4tt3+yWfioVsOReclfUrEhGCKp/M=;
        b=GQWC7vD2l6H+NgAHzhMO5DUubb+Eh45GJ5GAHKZ5AlIyBhxYHN9qP6sAf+ALW7M2HW
         eMQwFAQzUPJmsK+9GdjwgaArBoIHlsnKnUpkSiUD8P0SMZdlk6OnuoCFS93Ym755dvLN
         KqNvFzwwYDp8pDiv9Uk6W0xHIw99yr+YEoJJurwrQnWuOvk5gAKYfTrAXsDG/eqQX1y+
         q/IENFuOYWztWpweT5gVoV9hYvbTArN47GZAtWfhsfu6Azph4xhhcc2f2EGTFt2veU74
         G3Zewhs9v7wGxr/CscsCD1/FMFrLxruy1TAKBsQ3sa/oasbzOO6Mwkjrq9NP6f2Cq4wb
         6nrg==
X-Forwarded-Encrypted: i=1; AJvYcCUX47ZkJ9D1kqmjaomxe6WKXbF66YPr5hRF1q+pBNNvKXlNQzmgFYxeULQLHwWZlplqj0yj1a10rdYgsGgXD5uvtOpTR7esaADFUrZStQuOvkQs/xdmKOEDNKBfHVEnpOMIjSrX
X-Gm-Message-State: AOJu0Yz+KILG77m9GRteOUyIeZq738X/tmSuN7FX/tRU+/qLyXcKdaeW
	pvfG/Zl6sZ4gIbOnOKlX1WGIDBgjg9PsKidQIJyHMlyEfOoqwppC
X-Google-Smtp-Source: AGHT+IFinNVok+ZUMF+3u64a16XvPOy72VJSE2Q9KpgapPG8t4r6SpEQSU/F8rq1ddWeokLqY87klQ==
X-Received: by 2002:adf:f78a:0:b0:366:e09c:56be with SMTP id ffacd0b85a97d-367d294209bmr1604005f8f.6.1720523044354;
        Tue, 09 Jul 2024 04:04:04 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde89164sm2250953f8f.63.2024.07.09.04.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 04:04:04 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 9 Jul 2024 13:03:51 +0200
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	shuah@kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.or
Subject: Re: [PATCH] selftests/bpf:fix a resource leak
Message-ID: <Zo0ZF9h73Fi51D__@krava>
References: <20240709093842.3407-1-zhujun2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709093842.3407-1-zhujun2@cmss.chinamobile.com>

On Tue, Jul 09, 2024 at 02:38:42AM -0700, Zhu Jun wrote:
> The requested resources should be closed before return
> in main(), otherwise resource leak will occur
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

should have 'PATCHv2 bpf-next' (or bpf) in subject, other than that lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
> v1 -> v2: check for cg_fd >= 0 and have just one out label
> 
>  tools/testing/selftests/bpf/test_sockmap.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
> index a34e95040994..285a9a714666 100644
> --- a/tools/testing/selftests/bpf/test_sockmap.c
> +++ b/tools/testing/selftests/bpf/test_sockmap.c
> @@ -2075,8 +2075,10 @@ int main(int argc, char **argv)
>  
>  	if (!cg_fd) {
>  		cg_fd = cgroup_setup_and_join(CG_PATH);
> -		if (cg_fd < 0)
> -			return cg_fd;
> +		if (cg_fd < 0) {
> +			err = cg_fd;
> +			goto out;
> +		}
>  		cg_created = 1;
>  	}
>  
> @@ -2092,7 +2094,7 @@ int main(int argc, char **argv)
>  	if (err) {
>  		fprintf(stderr, "populate program: (%s) %s\n",
>  			bpf_file, strerror(errno));
> -		return 1;
> +		goto out;
>  	}
>  	running = 1;
>  
> @@ -2109,7 +2111,8 @@ int main(int argc, char **argv)
>  		free(options.whitelist);
>  	if (options.blacklist)
>  		free(options.blacklist);
> -	close(cg_fd);
> +	if (cg_fd >= 0)
> +		close(cg_fd);
>  	if (cg_created)
>  		cleanup_cgroup_environment();
>  	return err;
> -- 
> 2.17.1
> 
> 
> 

