Return-Path: <linux-kselftest+bounces-21710-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE9F9C24FC
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 19:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1B071C230BE
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 18:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2E51A9B41;
	Fri,  8 Nov 2024 18:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBXnKKbb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1130194082;
	Fri,  8 Nov 2024 18:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731091449; cv=none; b=OZEpjNItVWaP0EDklj1VMLP1rLrjtIFQwt8MqsaaVIZsF+av1PBnQD5rGyx3k8rGdpNb0WODLqVrYsfw36XeipsfSKX81sMDNUHH9Qs8nu7ugVTt1hj8z4yjvdvDPtNhxW60h9f6MOpF/VMb7Yt04hbmyw1NXb+8fWn1wxZMz38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731091449; c=relaxed/simple;
	bh=C+hxhapf+iZyc0pcpQdnvxpMDyqwHITK/5KpnubEpVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GEAF/dqkQB8wNpOF2VzU17FAQzAG/nJMElETYNhNXBpAr6WfdiShfcockgYka+GP91o7mxlNKJgoVnbU/JEXYCDdGOrATRymIAJVgCNYTk0/I1j/smLxnVrqgeMiuuTYyoXBlUgWvTpqq//RDF1xO57Zf11yHj+E6X+HzttYvGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBXnKKbb; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7eda47b7343so1761472a12.0;
        Fri, 08 Nov 2024 10:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731091447; x=1731696247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoRzY+OGqSnXflEIRU3jjsFUxNnysaUNIoTmFkKC6/I=;
        b=ZBXnKKbbcMom3ACIPeUYUBOXIb+MbiuXwwxxPthvlDOOBPiWhVZtieXaSmPsely+dJ
         eZqpCj9nM2vI6MxxLZT9b0ay8bGFAlogGqsCT2IvDCGOAMOj249R1YSO6za6GqACeQvp
         +T+KGnVzDV/qwy8pDITi0hKKJrj2YoDZWTGVUwPnSCQek5yWudZQUBnnqBkCPfG0G7nB
         OIIu+IgK+OySUNZKRGXUpU4OSwVU67CzQjgMwH0CwVXUhXyxM7R2vjWEKEWfPuH6NUXn
         CIhK2uHDT7by/bVE+nQXADyEXgee9EfdZ7MZBqOy741MLBpnh5jdyxLaIq2Q6BG9ZqFE
         ZV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731091447; x=1731696247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eoRzY+OGqSnXflEIRU3jjsFUxNnysaUNIoTmFkKC6/I=;
        b=YlkKE1pQ6D3vFwCVdDp2xCjF0kxW/xC9YH0OOobxaPcvzT1u9O9lwV8HvbYjl1ox40
         ZZWuyn/bsf1Fb0XDj+OWNAteU6HUaTiBcyrVP7Jg78FpEq72ZXPDt3cq8rBWthkmbi1m
         5WubSsCsrlxbTJUDAoVdfk1AAmKWAf98ZEFdkdFIqdGBtuOMHnkRtrGHXJ0O0rm0Q9SR
         QKrmS4fCMxgLer+5iYNS7OUKaOJYIVSjwPRVVE89lW9VMntn8AY96a/4PEm5MeT9KaG1
         pS7dg4MHedbi0eE6J0kOdufrkiGaK00sh/li6bB+vlJ4HcG/nV2bTH+oyXC7O6jufgLL
         5W+g==
X-Forwarded-Encrypted: i=1; AJvYcCU2Tk7w014RfSifyIITuJEiGYtSr9MMeWsoL8b7Me8y+2fUo3oBxabAqZwGftQiVuVb+BgmtyH4NxM8EJo=@vger.kernel.org, AJvYcCVvJORK+UkCKh8j2cz/BwxXsu1kE1ynLAqyWRK3RgLSwtzGwtrxXMzBcgDiK2+swf5y+iKvdagmOT2ukN2Xrc+1@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcnf6AibK2KGUIPJHqW7/MHVgbm/PpcEzZnC3pZhiotPC4tGKk
	XH+pYuTpFCH/H457/Wpx36E/YnyyD/VS84+3HpTpm5oUFdoc+P/ylILYmJF4gSN6KYQZxwG7FgV
	6KXTkZqFyUZAs7kqnUSJ/j61tVd4=
X-Google-Smtp-Source: AGHT+IGzDtW/S/3ZNx2BdBWgq6UlNpXAogQZJHwXY8381fWN4WHd4BNZtX7ea2q9D3b6aKYQkz+LVuyHgAwqMy2v1R4=
X-Received: by 2002:a17:90b:1344:b0:2c9:5a85:f8dd with SMTP id
 98e67ed59e1d1-2e9b174124cmr5790628a91.18.1731091447156; Fri, 08 Nov 2024
 10:44:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104050007.13812-1-skb99@linux.ibm.com> <20241104050007.13812-3-skb99@linux.ibm.com>
In-Reply-To: <20241104050007.13812-3-skb99@linux.ibm.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 8 Nov 2024 10:43:54 -0800
Message-ID: <CAEf4BzZ9Bz8a_hY-jDkqaYg6Phi9bjvoxbBeVZqcgjYXg4a-mA@mail.gmail.com>
Subject: Re: [PATCH 2/3] libbpf: Remove powerpc prefix from syscall function names
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ast@kernel.org, hbathini@linux.ibm.com, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, mykolal@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 3, 2024 at 9:00=E2=80=AFPM Saket Kumar Bhaskar <skb99@linux.ibm=
.com> wrote:
>
> Since commit 94746890202cf ("powerpc: Don't add __powerpc_ prefix to
> syscall entry points") drops _powerpc prefix to syscall entry points,
> even though powerpc now supports syscall wrapper, so /proc/kallsyms
> have symbols for syscall entry without powerpc prefix(sys_*).
>
> For this reason, arch specific prefix for syscall functions in powerpc
> is dropped.
>
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> ---
>  tools/lib/bpf/libbpf.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 219facd0e66e..3a370fa37d8a 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11110,9 +11110,7 @@ static const char *arch_specific_syscall_pfx(void=
)
>  #elif defined(__riscv)
>         return "riscv";
>  #elif defined(__powerpc__)
> -       return "powerpc";
> -#elif defined(__powerpc64__)
> -       return "powerpc64";
> +       return "";
>  #else
>         return NULL;
>  #endif
> @@ -11127,7 +11125,11 @@ int probe_kern_syscall_wrapper(int token_fd)
>         if (!ksys_pfx)
>                 return 0;
>
> +#if defined(__powerpc__)
> +       snprintf(syscall_name, sizeof(syscall_name), "sys_bpf");
> +#else
>         snprintf(syscall_name, sizeof(syscall_name), "__%s_sys_bpf", ksys=
_pfx);
> +#endif

The problem is that on older versions of kernel it will have this
prefix, while on newer ones it won't. So to not break anything on old
kernels, we'd need to do feature detection and pick whether to use
prefix or not, right?

So it seems like this change needs a bit more work.

pw-bot: cr

>
>         if (determine_kprobe_perf_type() >=3D 0) {
>                 int pfd;
> @@ -11272,8 +11274,12 @@ struct bpf_link *bpf_program__attach_ksyscall(co=
nst struct bpf_program *prog,
>                  * compiler does not know that we have an explicit condit=
ional
>                  * as well.
>                  */
> +#if defined(__powerpc__)
> +               snprintf(func_name, sizeof(func_name), "sys_%s", syscall_=
name);
> +#else
>                 snprintf(func_name, sizeof(func_name), "__%s_sys_%s",
>                          arch_specific_syscall_pfx() ? : "", syscall_name=
);
> +#endif
>         } else {
>                 snprintf(func_name, sizeof(func_name), "__se_sys_%s", sys=
call_name);
>         }
> --
> 2.43.5
>

