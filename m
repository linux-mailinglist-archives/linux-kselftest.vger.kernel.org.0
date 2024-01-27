Return-Path: <linux-kselftest+bounces-3662-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F57F83ED90
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jan 2024 15:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09FD82841EE
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jan 2024 14:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C052563F;
	Sat, 27 Jan 2024 14:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OL0Tx62r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E43825760;
	Sat, 27 Jan 2024 14:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706366504; cv=none; b=VUd6qxkWTAh5GKSoGuucHIFy/Es4zWXT8KBM3paFCcapa2PfJoFDlBcZK9G2e6oKqjtC/iPyIq28QZejTXphR2d1Emf3+fS4Qf35jRsh7q8FQ+qzcMVwvba+6GF8BOmjRh8SRqA0btEa8dtWSz3Vo7iW9eo/0TUxo7ZFtNv3nn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706366504; c=relaxed/simple;
	bh=JLvxqrMBX6tjvXHwrqM36OgiuASGwsrVr+907KqTZfs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbM0ATvbCNN7YAoa5tthgi2Sk9pHve4S3vVSeIcPK8egclArhYWMBxk2TqIzPDrcbe6p2gjp792dsD9GwnwWsIW+Hdb6WwSy7B+YtcdBzXya4PEP3vOSzqo0xGtkYElpoZ2V1Q+EvIC2DflMYaRhkhXZbyhubSxMz9mJ+QefH0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OL0Tx62r; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-339231c062bso1318662f8f.0;
        Sat, 27 Jan 2024 06:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706366501; x=1706971301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h1vspUfzTTmU9eLBmpKfeYgGuaJfhX5gH3XiIuQ2AWs=;
        b=OL0Tx62r2XrNjK4hARgGAG0354V1N5MKDAVoP34R2aakJgVSgkPuGS/xEyJMZzBl44
         hCeVbHglutrg7pNkAxaJSNWxVslOo9lma5KEY++b22c6wObU0qURsXByew9YZkA1KWXS
         Dxpfrvszlu3dv33mRX5SC8ho7mIRtTjP6yrXhtjBMreibzLAp71mYuHdDVScDiFE7KU7
         62+8c/I5zGwC0ueu1P3T2hIGybywBsvP9cSb91hcJgDbrgkxzR2fMQfL46r3hkJWZXgV
         WfrSfxWFLrA34nAU3hHv0jS2ZPhntyVPxaiVk/TPoEtq+fULW9Ym1bO5CizDsF5FhRuh
         uBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706366501; x=1706971301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1vspUfzTTmU9eLBmpKfeYgGuaJfhX5gH3XiIuQ2AWs=;
        b=rG4vkTIlFXrlnf41rNG7SsYGKrb1I08MFh4CQu3/kf2G38kyEfzoplCAx7yi7y5ibg
         XUtFmfJqHZYRtYDCAirxdRAb/BxAm35axXS1P2Tq3jKtJ+pm8zfaEQJ/XJCxllAxtgP3
         6e7oDQXyRXelIxmq46goSl6Vvu69wBVyp/FpKO1jG247M+zhPxAd6jxZrsaauI/+HUex
         duEPbDtWMkL++/u1f3dSzqBblgnstXkzhyNb739fS8i/SPeqfjSfFCpHDcO5PfVJO7a8
         pgqG8ZqLQVnJxQeK4DG9ban7bEFqNbjm1bm+0bdtiUyVWmcFmbFYXJb4p8/yTbOsfsg1
         Yk6w==
X-Gm-Message-State: AOJu0Yym/sjDDV+T72ArovHNpRIf0vJD7CxKAUvbOkptQPyiLZPdJDoV
	eSOFA5YuyWxlQ5cVtmubw4pl5aBzHXkVZdhWMPjJ5VqPKp61VMZuIRzgIFLF
X-Google-Smtp-Source: AGHT+IF2Ap6iw2uLYZo/gy6MokNggNdqUshjdmS+gDzVEvkpNDG+HP3RBT8ROvOm+Vz/UZ2CPior8A==
X-Received: by 2002:a5d:6901:0:b0:339:5935:4b56 with SMTP id t1-20020a5d6901000000b0033959354b56mr1017037wru.41.1706366500971;
        Sat, 27 Jan 2024 06:41:40 -0800 (PST)
Received: from krava ([83.240.60.213])
        by smtp.gmail.com with ESMTPSA id f3-20020a056000128300b0033936c34713sm3621438wrx.78.2024.01.27.06.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 06:41:40 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 27 Jan 2024 15:41:38 +0100
To: Geliang Tang <geliang@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [bpf-next] selftests/bpf: Drop return in bpf_testmod_exit
Message-ID: <ZbUWIioaQ-WDKTxE@krava>
References: <fb088aab7eee941cc6018249a47f60b0871141ea.1706349508.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb088aab7eee941cc6018249a47f60b0871141ea.1706349508.git.tanggeliang@kylinos.cn>

On Sat, Jan 27, 2024 at 06:02:29PM +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> bpf_testmod_exit() should not have a return value, so this patch drops this
> useless 'return' in it.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

please rebase on top of latest bpf-next/master,
there's conflict now with latest change

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index 91907b321f91..e75e651f1337 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -544,7 +544,7 @@ static int bpf_testmod_init(void)
>  
>  static void bpf_testmod_exit(void)
>  {
> -	return sysfs_remove_bin_file(kernel_kobj, &bin_attr_bpf_testmod_file);
> +	sysfs_remove_bin_file(kernel_kobj, &bin_attr_bpf_testmod_file);
>  }
>  
>  module_init(bpf_testmod_init);
> -- 
> 2.40.1
> 
> 

