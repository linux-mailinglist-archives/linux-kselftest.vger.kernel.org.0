Return-Path: <linux-kselftest+bounces-32762-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B730AB1B3A
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 19:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32106A01E75
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 17:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF8F239E91;
	Fri,  9 May 2025 17:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSIuZxOx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68DF238175;
	Fri,  9 May 2025 17:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746810273; cv=none; b=F1uiGjTIs5tjXamUAEnO6U8awZuDfeiSjkf8mcioooaLTGE7aJL4jZGbzs6bxc7d4r6hmWz0I3+XoA/sq7k6GhqddVtPOYX4I515E4xMntheEM/dPhzaKwcjlvhz3b9c+i9jqlr7JUtrf3CMqaiGkOQSrkmBwGmVXm9rlngJec0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746810273; c=relaxed/simple;
	bh=FmqJE5CaWwRF+fvQUgtrkJzaKV7CEKJVosSM6sK0Jwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DqZitxJAc1Aw2bXN8mLT2Fl8ChlgbBdDx74LnxzseDvGfCk+ed9uXewbnKr9F7Su5zI1KtEAP9ad8bJde5MD7OIMBAoqq5bzNyelcNAanwfhB+oXqS9ekNVJ6NY7dNlorfWNG7SXdKP2EMD59hZGGNioWRUYLSCh3a+Ib3FW7w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSIuZxOx; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-441c99459e9so15626775e9.3;
        Fri, 09 May 2025 10:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746810270; x=1747415070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9FGoOFxXhMGTP5ls91WbfqbKMEzNeTHiP62ZYlEVbw=;
        b=YSIuZxOxOxCux9JGDbrZehQfglACGaNUOddYVUFA7m5rxIUp/9TXsm7n6LsrDDeQh8
         KSOJ8+3wdrrhaBrXkcHFrvMucGDfgnE1YuYUwPi4WJxkfIAUlHPuhlYt3I/V354zzUmX
         ScomsTb/C/M85SC5fLdb0Bmfqn5R2HEO+H1rEZluIeSmkWUpkrijs01cGZqr3VSBW6H1
         +HlQ28dUr9YQb/HFp8Bjb8TPAL9jydRpy/wlAH5VqaEwWU1Cvrwgo26vdZ4XvC5cOFys
         FPSbTgobbgupuZuoXYnfvxW1CV82pcghcC6hmKa4VbD2tq6A8JbdREcbE8Wj5TDcqhO3
         yoxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746810270; x=1747415070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9FGoOFxXhMGTP5ls91WbfqbKMEzNeTHiP62ZYlEVbw=;
        b=hUumGZk5NzBPEMGeJGkkpwRGCe58o5xgoZVl9ooqBTEhFb54AuJGumnCZT7iPAhuYi
         5eDmjYbexSPOqx+tR1rL5C/3wUXFyhQ4ZYD1sqEdq+UO2DTs+mwgfAx1NBElXuu01So9
         FRVl6764Cf2DGLZIhr5yGI5p5rqsItda4TVelzXCmPNQ2k3DNB+b3T+f69iwsqZekyLo
         2BPCbhtnLOPUQvWxUrwTm+Csw0GLzPOiYWsZ4mclOZFK6JPXo1YpiE5J5YuFHD9Q06MI
         r3VkitFyXXspldJlnuIIInl618kWr8G9v94hJGLwr35lsZUiNpG18tX0vI3skvbejoS9
         GCug==
X-Forwarded-Encrypted: i=1; AJvYcCWVWwtRhvG0DqAsJul7yj/WS0UgJyKeiuZJgWpw+uizgquPG7T4FPEQDqg0Xc6l/CRtRwSIDUsvAAc/XJcx7Br1@vger.kernel.org, AJvYcCXDePP+B9SCBFhFaYfyNuL0XLDoR3RWKrOXvgCvuL1OXdKsN6xCoKHD1wYcHGYdixCp0NTeboiqrMQLGho=@vger.kernel.org, AJvYcCXapVp/CvNAp+d8ur1o3qUUm0wP4dCoTQb5OEWFmcwtnsuwxlCF5IvQp1vW2+QzJ5lZx/S2fIMvajYEcA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBJq6OasMgy4Pxvp+GMAsqu4EhZxMvqdfPTz9OX2HVXXcRcnT8
	KR3+ANb603Rx46qRnvEF4z0zoUiiW14RiA3H++KLB4xgF+ddnikIbul6Su/KSgFBdmMYSuOG1u5
	9zNV6YSABVxDCoykbpEGOUupc0XE=
X-Gm-Gg: ASbGncsEd6vyiUoiivdqmgt97qX3yNoSaBWxqBfy3e62g10pGyESMjXa47TIBfGpSLR
	5rrDzkPIoQ0upckPkf1yvbn5e1bQnFjvWUGQLIs0aktC5nz/g3OoPizaXWqwcxmeur4VAj7dbIW
	GBfOIaNM52tvjG7SAt2+ZceDaQzzFO79MaJ7vS4A==
X-Google-Smtp-Source: AGHT+IFnBYqhXbjNCF8NTXyLF6urD2/hEu6wcbrtnXUvS6VeJLvXHUVn+vYN/eT8TSsjCML7ULcEftXd3SA1OPWI14w=
X-Received: by 2002:a05:600c:64c4:b0:43c:fe15:41e1 with SMTP id
 5b1f17b1804b1-442d6d18bc6mr39356315e9.4.1746810269524; Fri, 09 May 2025
 10:04:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509122348.649064-1-skb99@linux.ibm.com>
In-Reply-To: <20250509122348.649064-1-skb99@linux.ibm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 May 2025 10:04:18 -0700
X-Gm-Features: AX0GCFtGvd38TEcBIzgZXpP366MKGCZNb_SZxydI264Su3mUoJ1EjhzLUKYHED8
Message-ID: <CAADnVQKBQqur68RdwbDVpRuAZE=8Y=_JaTFo-36d_4vr2DNVyw@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Fix bpf selftest build error
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	linux-stm32@st-md-mailman.stormreply.com, 
	Linux-Next Mailing List <linux-next@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Hari Bathini <hbathini@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Mykola Lysenko <mykolal@fb.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 5:24=E2=80=AFAM Saket Kumar Bhaskar <skb99@linux.ibm=
.com> wrote:
>
> On linux-next, build for bpf selftest displays an error due to
> mismatch in the expected function signature of bpf_testmod_test_read
> and bpf_testmod_test_write.
>
> Commit 97d06802d10a ("sysfs: constify bin_attribute argument of bin_attri=
bute::read/write()")
> changed the required type for struct bin_attribute to const struct bin_at=
tribute.
>
> To resolve the error, update corresponding signature for the callback.
>
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/e915da49-2b9a-4c4c-a34f-877f378129f6@=
linux.ibm.com/
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> ---
>  tools/testing/selftests/bpf/test_kmods/bpf_testmod.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index 2e54b95ad898..194c442580ee 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> @@ -385,7 +385,7 @@ int bpf_testmod_fentry_ok;
>
>  noinline ssize_t
>  bpf_testmod_test_read(struct file *file, struct kobject *kobj,
> -                     struct bin_attribute *bin_attr,
> +                     const struct bin_attribute *bin_attr,
>                       char *buf, loff_t off, size_t len)

You didn't even compile it :(

Instead of fixing the build, it breaks the build.

pw-bot: cr

