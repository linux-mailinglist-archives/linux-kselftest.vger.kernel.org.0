Return-Path: <linux-kselftest+bounces-17002-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDA2968DDF
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 20:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79D8E283A82
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 18:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366421A3A8A;
	Mon,  2 Sep 2024 18:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iybsLoTF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9B01A3A80;
	Mon,  2 Sep 2024 18:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725302923; cv=none; b=Z1D7AlUB5wW4mjavLSy7s0ZoLMf6KZPV8rTDk1ltC6FytsRhafb0e0tkJv+U8sNsyzUfJO9zMwC/qDKtSwhp5Tsq2rYdmFAsy+twzirj2oArKHIIqPry6q2dvfiNEIGO4iGh+7FCSEeuKl7XXOvDSn8QCN8ZGPUwgB08ufZCq90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725302923; c=relaxed/simple;
	bh=GhnPwaANvzIEJfD7074jTlrZcF9HJ/AnfdG4A69fYnQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0nN9aY0zFESBqzdYzyKJuCe2/8k6Uw0ckaV02GTnY2V0sDjmz8vFlLnBkm8/CoAYdhUt1o2eb8iheuNwt6YM05a397rT3nagYboHSxkFv57SXse3dAiJMd6fQ38eB8TFE9cTo3tHzwgUMHMohdc3Y1c016WFTwVG7iC/O+FQWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iybsLoTF; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-374bd0da617so1546249f8f.3;
        Mon, 02 Sep 2024 11:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725302920; x=1725907720; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MELQtSmOnmWF4IFnsIuzL6tau5qYYjPDtZMmxK7Zyb4=;
        b=iybsLoTFlJVnuOawYmikcYIP05xAlb09FHn3UjFXNDqU0S77cLf29Hlppx6mkXljCW
         GCuV8bjPsaM9jU9TcST7qzIsjg840yKHzC27fJbyJI+XKmVOZRSO61xWqUgYblE8c/ht
         cASADwYoMAGdPdLxzaXqKw3zk72w0kGnNstP3qSbULjG2T7SBkvMgTjQPPHXHr7dqGoJ
         fm65px1Ts1N5bQuk3KEsWj8sw5Bbl5eNAmOE6JkwAIHf3bXbPkkxzBA4znGS7t7ZBaMS
         +yPAhBkhHlc9sXaJPK3+CyBpEMCR4EoExvn3M/x2HVc2TRED4kg/dGR9rNYsLWqENQwz
         4xUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725302920; x=1725907720;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MELQtSmOnmWF4IFnsIuzL6tau5qYYjPDtZMmxK7Zyb4=;
        b=L6GU5gEEgmubVY8XDibsN5piq2ofZWlq8nbM8LMpTRlbDuoZ9fRQJZCh6DDWtB0olR
         SVfzyVUK1tWrU9YhdmnGfDZgcWe3ClfFVle/4toeok2naYajtPaYafnRdLSGWN2355Y3
         V04nTJhjf0gEh2vV9I6IeSVUYC3DXoRt2TgIvNWz/Sn33BO3z4iuVh0cSkqUFWEJlnEl
         Wffh6bAkGb6m30/N2iJDy75G8cWEjrbFPOTebwTMkX4lB3hJciGmm/uosErWCIq469x3
         BcnxWT7nTHUcnSrl1+8OBzWUIWehiI6s/Hcgc3x8POBts18CDeL/7CxYHAORwcHBJROA
         jXVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUWgsIUlqNgpKbGtrR5EupKQo+rDSX1jOoOhnJ5Ho7KWvAnwAlLzILzfDmrQNcK0a4xV4=@vger.kernel.org, AJvYcCWiKOu+4ACSq1HdrZ+FFQSMRzIOnNTpkvVmLluj0yNdh1W9JonLczsvPHf3dl6m0vGVhE93YkAwVboATuDsADsU@vger.kernel.org
X-Gm-Message-State: AOJu0YxQev11IZF/cxFcG3zkYIok8nHbTgoBFmfseQOhouLkskH0weAO
	EgMYDRu5uMuBaWDHjXzLQz6x/kvrOWMszbWwxWnx+VL0PzYMr8b8skh2tUKjnc8=
X-Google-Smtp-Source: AGHT+IHuHj5iv9qM/QbYWy+Bt9iEMD4aVFI13zXUvjPKNXFR4KO37kCJfraPrjPzTfKQXpJowfxP4Q==
X-Received: by 2002:adf:978c:0:b0:371:8dcc:7f9e with SMTP id ffacd0b85a97d-374bce9864bmr7721115f8f.2.1725302919649;
        Mon, 02 Sep 2024 11:48:39 -0700 (PDT)
Received: from krava ([87.202.122.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c8e4f1b3sm4485930f8f.27.2024.09.02.11.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 11:48:39 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 2 Sep 2024 21:48:35 +0300
To: Yuan Chen <chenyuan_fl@163.com>
Cc: andrii@kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/bpf: Fix procmap_query()'s params mismatch and
 compilation warning
Message-ID: <ZtYIgzz74_OZQM7B@krava>
References: <20240902093248.23473-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240902093248.23473-1-chenyuan_fl@163.com>

On Mon, Sep 02, 2024 at 05:32:48PM +0800, Yuan Chen wrote:
> From: Yuan Chen <chenyuan@kylinos.cn>
> 
> When the PROCMAP_QUERY is not defined, a compilation error occurs due to the
> mismatch of the procmap_query()'s params, procmap_query() only be called in
> the file where the function is defined, modify the params so they can match.
> 
> We get a warning when build samples/bpf:
>     trace_helpers.c:252:5: warning: no previous prototype for ‘procmap_query’ [-Wmissing-prototypes]
>       252 | int procmap_query(int fd, const void *addr, __u32 query_flags, size_t *start, size_t *offset, int *flags)
>           |     ^~~~~~~~~~~~~
> As this function is only used in the file, mark it as 'static'.
> 
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>

perhaps also 

Fixes: 4e9e07603ecd ("selftests/bpf: make use of PROCMAP_QUERY ioctl if available")

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  tools/testing/selftests/bpf/trace_helpers.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
> index 1bfd881c0e07..2d742fdac6b9 100644
> --- a/tools/testing/selftests/bpf/trace_helpers.c
> +++ b/tools/testing/selftests/bpf/trace_helpers.c
> @@ -249,7 +249,7 @@ int kallsyms_find(const char *sym, unsigned long long *addr)
>  #ifdef PROCMAP_QUERY
>  int env_verbosity __weak = 0;
>  
> -int procmap_query(int fd, const void *addr, __u32 query_flags, size_t *start, size_t *offset, int *flags)
> +static int procmap_query(int fd, const void *addr, __u32 query_flags, size_t *start, size_t *offset, int *flags)
>  {
>  	char path_buf[PATH_MAX], build_id_buf[20];
>  	struct procmap_query q;
> @@ -293,7 +293,7 @@ int procmap_query(int fd, const void *addr, __u32 query_flags, size_t *start, si
>  	return 0;
>  }
>  #else
> -int procmap_query(int fd, const void *addr, size_t *start, size_t *offset, int *flags)
> +static int procmap_query(int fd, const void *addr, __u32 query_flags, size_t *start, size_t *offset, int *flags)
>  {
>  	return -EOPNOTSUPP;
>  }
> -- 
> 2.46.0
> 
> 

