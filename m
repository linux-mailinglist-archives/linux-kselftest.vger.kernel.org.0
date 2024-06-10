Return-Path: <linux-kselftest+bounces-11553-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C430902253
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 15:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90DE1F21BB7
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 13:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA0C811EB;
	Mon, 10 Jun 2024 13:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeyMyi5x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42B17F490;
	Mon, 10 Jun 2024 13:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718024671; cv=none; b=PsDXJn2L0JxpvyqnSj+i+MVl6IDoWmJm8ZO3IYW+/ORc+GuWZSXZ+/DdLKcG34MC6/aUeXeKD9dKiv0u6NPpw+k6K9bElW1Hzt6d298NYFzo5xX1JOBgTDPWvbwuFgIbNG+anjYVTVtbApZC489QDuyfFP8Q/3SNHgmL4zbq2ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718024671; c=relaxed/simple;
	bh=gFy5uq8seL4hCY4Xr66+ZSvpftxpN7tTfAvbCIN2ksM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgLaNSz4B+KDJjZPoTM+NGF/ced1iwbyuOAjASYwU2U7DxGbYjlZ4Iwivksa/Kn2fooyTVUskRCXvatsw5MsudUdXZuNX6qfF8H05FY3zEup+GsNBXicpq1z3C+6W9sj5UrnGsbdlrdGuyOmnQBRvYyggWezP/9y/CF/hnDEI+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PeyMyi5x; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57c778b5742so1542554a12.2;
        Mon, 10 Jun 2024 06:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718024668; x=1718629468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w3OjOSiZjNWeHaOOIBvf7oQi5YB7w/ApxVFJxVWV++I=;
        b=PeyMyi5xMn16o+ga1q+c9z5GdP4ztuUVBokqi43gDVT0v2gCPxiPDQh9Cw9ZYNtKkV
         AZBgwK1B+ce5fI9yFHaP0NzF87jewpz/XvVuFhcWpRkXhwO2aa+85FMgzpC4GikJhpUu
         hTQfkVg3EKks/hgXvrH5L/eOjMgelC3YEJXr4bKN4BFdaRGJxuDaUq6NDK6zSEHrbvJ6
         w2wPXwokxhgWs2pRXr9afu7PTZLhAvHZthMkvjkI8pMYD1dhb49IxHZQks5+gARvc/am
         WSL32S2tnrBUepPNV0+Sr59Ur4LC2JZ5F2Bo5ETTbm/s2ez8oAI9JdmUUXvKzGgRBaJp
         M78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718024668; x=1718629468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3OjOSiZjNWeHaOOIBvf7oQi5YB7w/ApxVFJxVWV++I=;
        b=FABlygSoZNKl7YVlSZvfewtsp3ZDAjZYzNZOJA//PBFEefH58zcFZJVKeC6BJ16GrM
         uBst2R9diEF9F2W1VOTB+gOhYGnXF6uVL5uPO9P7nCFbQBDXFgVsN7mJVxpALlpT+elv
         Qio+8nbn7q9GzyiIAYgwSS/XDT1o0uVlLiCfkEAIQXzKbs623bPt/1GkAkpTYPeJ0kNQ
         rKB8Hz/sPbJb+RIBpOf5/bQiwmDLzAvNk/oYTgz9copXkYbQ2edHLqCyAiuhJuNtrNRN
         xMCUrMImxrLRGRCKA8PXm2Md6KahrjCwDRUcvTL21QQIt3mnbt0Gay2zsmQKPt3CH72j
         uNgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBYCBW7ERns0XgRxVcONUqKv1slxg7q7W0ZwXDV/aWjZsPruuQT6KyVPaGv2KrkU1PN67cBy6r2re9+z85KrvD08V2EB61KKLRjvOx5A3LAYC/vWUm/bWsgSUkdWtZIoM0BAIKcjH8+0Hz8iPLbab4GfFrLldMfK80gjPJYRm5zPDw
X-Gm-Message-State: AOJu0Yzs7ZcrYr6tk6HB3qDw3m7s3zxifshgrey0rPtVJt0Mg+zTZMIJ
	YHqyeg46nlDXMG04K3DYSj3a2wtFE9mr1IN3HHGM5t8XVZMBgsk8
X-Google-Smtp-Source: AGHT+IGbeFftNngfs9iL+yY74aZcfhDYvjQpagAyudvjfKRUhBWAwokvtihjLWAYPWlZ8CMAiBlLXw==
X-Received: by 2002:a50:9b4b:0:b0:57c:5f58:58c8 with SMTP id 4fb4d7f45d1cf-57c5f585accmr4550127a12.40.1718024667895;
        Mon, 10 Jun 2024 06:04:27 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c708136b2sm3888560a12.83.2024.06.10.06.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 06:04:27 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 10 Jun 2024 15:04:25 +0200
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: shuah@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
	daniel@iogearbox.net, olsajiri@gmail.com, quentin@isovalent.com,
	alan.maguire@oracle.com, acme@kernel.org, mykolal@fb.com,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next v4 06/12] bpf: selftests: Fix
 bpf_session_cookie() kfunc prototype
Message-ID: <Zmb52Qp__CBzbgDh@krava>
References: <cover.1717881178.git.dxu@dxuuu.xyz>
 <34708481d71ea72c23a78a5209e04a76b261a01d.1717881178.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34708481d71ea72c23a78a5209e04a76b261a01d.1717881178.git.dxu@dxuuu.xyz>

On Sat, Jun 08, 2024 at 03:16:02PM -0600, Daniel Xu wrote:
> The prototype defined in bpf_kfuncs.h was not in line with how the
> actual kfunc was defined. This causes compilation errors when kfunc
> prototypes are generated from BTF.
> 
> Fix by aligning with actual kfunc definition.
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  tools/testing/selftests/bpf/bpf_kfuncs.h                        | 2 +-
>  tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
> index be91a6919315..3b6675ab4086 100644
> --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
> +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
> @@ -77,5 +77,5 @@ extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
>  				      struct bpf_key *trusted_keyring) __ksym;
>  
>  extern bool bpf_session_is_return(void) __ksym __weak;
> -extern long *bpf_session_cookie(void) __ksym __weak;
> +extern __u64 *bpf_session_cookie(void) __ksym __weak;

the original intent was to expose long instead of __u64 :-\

could we rather change the bpf_session_cookie function to return long?
should be just return value type change

thanks,
jirka


>  #endif
> diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c b/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
> index d49070803e22..0835b5edf685 100644
> --- a/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
> +++ b/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
> @@ -25,7 +25,7 @@ int BPF_PROG(trigger)
>  
>  static int check_cookie(__u64 val, __u64 *result)
>  {
> -	long *cookie;
> +	__u64 *cookie;
>  
>  	if (bpf_get_current_pid_tgid() >> 32 != pid)
>  		return 1;
> -- 
> 2.44.0
> 

