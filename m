Return-Path: <linux-kselftest+bounces-11555-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBDD9022B1
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 15:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D141281A50
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 13:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B33824AF;
	Mon, 10 Jun 2024 13:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIaUSAet"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4E882495;
	Mon, 10 Jun 2024 13:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718026123; cv=none; b=HXlEDrG2fODc69nK5/CbWzLFvDbHfN4vY7DmKCA8gtIP4g9nRao0EKhHud6QhNFCOHSwngP4gY1ftuObVANrnhsFOq8RE+C6y/SVN4PvL0mpIUCddZyq+XyhzohHkHnc9cQ6R/SPiXavzPdmGJCPZlkbvRruLJYSI9Xordhagkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718026123; c=relaxed/simple;
	bh=8iNBFiAFk2x18bz/Cm2pkU+ucUprAO5UFuzBsXiZHOw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCNejAxR/BWYLYThokH9++DkT9IEtvfy1i6biou65XDUSSaa8/eTmJd4RAJuKwRW1cb0rAHt3kEbuQinU5TXL31ujUHIt7y4YH9/K2O7Aoi0ragDyd8uNSAzP2gAPq+ccRFth6j5OZoMxNdsDr3e6fAfss0gsGFovmFbD8m1BEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIaUSAet; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6f09b457fdso169117966b.2;
        Mon, 10 Jun 2024 06:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718026119; x=1718630919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Oe1uG12OwFGfm/fXehU9KIf5CFABE6TR3kzu0gjzfKk=;
        b=kIaUSAetLepxRgNOaAK1Hsf9MqMFn6OmtVd9V58Xy26++GBaeDmhHHc7M34ASmKZoG
         pgIwhSiP884wi0U+o2ozWJLd+vjWcQ10i5diZXEciq0IlHPG3KIZYs6IkFGzjgVHfnh8
         kaEiRHQrzeFGBTOr1hdcr13b48+3nOZkCaYxgD1ocbAVj/nlP3m+Qj/wlwjIkTPDnDeZ
         KW1KqlM2YmjYurbZNIfKaCYh7z0OSYJWZWwnLys0tWCWJ3bkzE+RO4rwX5pEHu2u6ef9
         h7qyhhcgCkZ3cYzcVe4rhK5Qn/IE7BVbJWfvgG3wBg6+M7yT8EicloL5fwQui0PArEdD
         /vlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718026119; x=1718630919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oe1uG12OwFGfm/fXehU9KIf5CFABE6TR3kzu0gjzfKk=;
        b=hRa4KkDDu0XE0tU9oab6IrpX+ttfLdQtbIIRZ0lEpRxL7XQUCve49E7TSjXim5OfCX
         iKxqKFlUzDVBVdS7TCEOqdBl9WGsAdJJ7YLYB4gfw6ho26GdTSrqeWOvwlYS9m3+2rOo
         NBg9/hig04pHDKpDCQ5jBVMBnEv3AozoYldBrzf5N4GsXXxIhItQ4UWUP45YkajLxS+H
         prfQEtG0wlBT9D+xq6yoGVz+JxRZ8EY/HAvcr3M9+ToTiBohiy0wZ+DRMpo78M2mYCBK
         t8ieIyySvLWunKiHLzA7f+2D1SdtdSLPTHGcAg8k87MS6+G9+eNjYVD2DRvg4vHkT2fH
         k38w==
X-Forwarded-Encrypted: i=1; AJvYcCXyS+tXJM05+JzyElgOtGC/yj99DsW8Y1ZBU+vmR60DF1KZSDvgRQIXNcodl5Zlex3H6fDGCkwkYVLaoepop6OKaroudYIfkqzZRdV0QSsQ8fApWKtvHu21lt3SJn0Qs6IVhJrFE9GxK3MawuZHOvpfFmC4U098bRWUoYcMiiXmIVZ6
X-Gm-Message-State: AOJu0YzaIOO9iRiUEcitIr4fC2Pdr6dL+Wz7PBvc/RokSTK4jVHhqCOZ
	IelRQlCwSmYahs/ilc944gvBRlsMGrXC9C+89EkqHh/My9c75gLW
X-Google-Smtp-Source: AGHT+IHmjqOo8ZKym0tRlCWoq8GHs1+hiC4mi31qnNwyUYWu0BX7iKhT5iYN1mYN7y2V8y90CAMUxA==
X-Received: by 2002:a17:906:b85a:b0:a6f:1036:98cf with SMTP id a640c23a62f3a-a6f10369abcmr322649766b.54.1718026119082;
        Mon, 10 Jun 2024 06:28:39 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8072b010sm643480766b.214.2024.06.10.06.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 06:28:38 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 10 Jun 2024 15:28:36 +0200
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: shuah@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, ast@kernel.org, olsajiri@gmail.com,
	quentin@isovalent.com, alan.maguire@oracle.com, acme@kernel.org,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next v4 03/12] bpf: selftests: Fix fentry test kfunc
 prototypes
Message-ID: <Zmb_hJQqxi44Nj5B@krava>
References: <cover.1717881178.git.dxu@dxuuu.xyz>
 <1f493cb7a7e5349f99e2badf0880b75dd6681898.1717881178.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f493cb7a7e5349f99e2badf0880b75dd6681898.1717881178.git.dxu@dxuuu.xyz>

On Sat, Jun 08, 2024 at 03:15:59PM -0600, Daniel Xu wrote:
> The prototypes in progs/get_func_ip_test.c were not in line with how the
> actual kfuncs are defined in net/bpf/test_run.c. This causes compilation
> errors when kfunc prototypes are generated from BTF.
> 
> Fix by aligning with actual kfunc definitions.
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  .../testing/selftests/bpf/progs/get_func_ip_test.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
> index 8956eb78a226..a89596f7585d 100644
> --- a/tools/testing/selftests/bpf/progs/get_func_ip_test.c
> +++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
> @@ -5,13 +5,13 @@
>  
>  char _license[] SEC("license") = "GPL";
>  
> -extern const void bpf_fentry_test1 __ksym;
> -extern const void bpf_fentry_test2 __ksym;
> -extern const void bpf_fentry_test3 __ksym;
> -extern const void bpf_fentry_test4 __ksym;
> -extern const void bpf_modify_return_test __ksym;
> -extern const void bpf_fentry_test6 __ksym;
> -extern const void bpf_fentry_test7 __ksym;
> +extern int bpf_fentry_test1(int a) __ksym;

hum, the only registered one as kfunc is bpf_fentry_test1, to allow fmodret
also there's bpf_fentry_test9 as kfunc, which AFAICS is not really needed

jirka

[1] 5b481acab4ce bpf: do not rely on ALLOW_ERROR_INJECTION for fmod_ret

> +extern int bpf_fentry_test2(int a, __u64 b) __ksym;
> +extern int bpf_fentry_test3(char a, int b, __u64 c) __ksym;
> +extern int bpf_fentry_test4(void *a, char b, int c, __u64 d) __ksym;
> +extern int bpf_modify_return_test(int a, int *b) __ksym;
> +extern int bpf_fentry_test6(__u64 a, void *b, short c, int d, void *e, __u64 f) __ksym;
> +extern int bpf_fentry_test7(struct bpf_fentry_test_t *arg) __ksym;
>  
>  extern bool CONFIG_X86_KERNEL_IBT __kconfig __weak;
>  
> -- 
> 2.44.0
> 

