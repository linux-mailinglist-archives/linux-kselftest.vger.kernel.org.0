Return-Path: <linux-kselftest+bounces-13632-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6C892F336
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 02:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C2F11C20A2C
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 00:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D410310E3;
	Fri, 12 Jul 2024 00:53:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7152107;
	Fri, 12 Jul 2024 00:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720745594; cv=none; b=epg05w5YKMphbIzn7gPtQc4DFiP6o7TWyFtI5nlgWO+Opf2VSP+8SWdDgjiEaKgCLar6RwErjU5hp25sRTKNhGVeaQ6Ukq94sy1KuWBzrCx0mE0xTMcN0EtXjiQ/lG42BKwbknyWYVkbOyuFZ11tGGJOuy9cUTySHNplZ7kwQlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720745594; c=relaxed/simple;
	bh=esKILx7oXVH+jjRLOQGNopM298eecv1k5iwOSWKaOuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBUnhVFqHd5DG2o0AbF/mPd3TDUBXOThXttlXOu6wpBWYO7iSdU+kSrZgK/mWUi/OmnhCxlOjOmG4xfc+DtD0Fhrhcq4+BcB28A3Wy+S8ajWCLrv695Suvvz8QdzTXgSgfBCkytOZO7446pjFyaQGw3N0T0pXUZc7yjVF6wDClg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70b0013cf33so1357555b3a.2;
        Thu, 11 Jul 2024 17:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720745592; x=1721350392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3F64ug1erdWH11RqFsEoBl4L9EzVwcxDLGQjrawr39g=;
        b=bzfws86qXgORmhgMxPYgz4lFoh0zt2L1AEUnjKfhKbT434Zwh0L1iYmL32h8vvC+f8
         /5CfNQ2QmsC0snWqAycmgLjjiQZSTYlYr8TbDLLxE/2gmJa+wtpGgPMJZ3c5AvEsqfch
         tL9/bVji7ZsW2aIwe+DrQlqZ/TBI3qJk2z12APnHT/1Htg58qjhnEPdSl3lWzsjtlGjd
         BSlxQsNvulehD9srNgLYlwfq0WIRf3FGi73/PmXVaOJnl4qDzBo5JfymbVm+3aRJNPVC
         PlbMusY8s/m0pxC75zcDer3jTUvhOYRlHZrPvzZ+vVF9yqaHTBRs2GY+UvaD+P1qVzt+
         oMSQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9tKk3VNr3U2QJZDyajANx4JXQlCdefURwlVB7lMMJzIj9l0Wv7h1PC1B/q6GMFKpLhdFHaO/KxMLg9id5TiCaytG6Vpq9jeWoNfFmYv5aNJ5/4fRiBQk+fhqRucBOBrmF0XnmhW6QEimsy3lzSTDqXXZ9z0+2Mnrw3Fzmz+EohVC0
X-Gm-Message-State: AOJu0YyiWKmlc1cDTbIi1bgHrJDuy3LDHgbfc+h5/lCJq5/+nZHCfkyr
	5Ij840x05jkOFc4Mk0gHn8zEPzEVX8OfrLGA8Jm/tX3ajU15WVg=
X-Google-Smtp-Source: AGHT+IFussQXz48wwMWVN/4l3pJw0+NtMa8T8q2Z3ZRSic2bNioZzHqBuwkkTQVbySy9PLB4tjq1zw==
X-Received: by 2002:a05:6a00:124a:b0:706:74b7:9d78 with SMTP id d2e1a72fcca58-70b43370ff6mr11955686b3a.0.1720745591477;
        Thu, 11 Jul 2024 17:53:11 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b4389c13asm6287988b3a.21.2024.07.11.17.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 17:53:11 -0700 (PDT)
Date: Thu, 11 Jul 2024 17:53:10 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Ma Ke <make24@iscas.ac.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
	mykolal@fb.com, shuah@kernel.org, sowmini.varadhan@oracle.com,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/bpf:fix a resource leak in main()
Message-ID: <ZpB-dswNvYJiCRR4@mini-arch>
References: <20240711071018.2197252-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240711071018.2197252-1-make24@iscas.ac.cn>

On 07/11, Ma Ke wrote:
> The requested resources should be closed before return in main(), otherwise
>  resource leak will occur. Add a check of cg_fd before close().
> 
> Fixes: 435f90a338ae ("selftests/bpf: add a test case for sock_ops perf-event notification")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  tools/testing/selftests/bpf/test_tcpnotify_user.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_tcpnotify_user.c b/tools/testing/selftests/bpf/test_tcpnotify_user.c
> index 595194453ff8..f81c60db586e 100644
> --- a/tools/testing/selftests/bpf/test_tcpnotify_user.c
> +++ b/tools/testing/selftests/bpf/test_tcpnotify_user.c
> @@ -161,7 +161,8 @@ int main(int argc, char **argv)
>  	error = 0;
>  err:
>  	bpf_prog_detach(cg_fd, BPF_CGROUP_SOCK_OPS);
> -	close(cg_fd);

Worst case that happens here is that we call close(-1) which returns
EBADFS or something similar. Don't think there is any problem. This
applies to the rest of that patches that add an extra 'if' check.

