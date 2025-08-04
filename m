Return-Path: <linux-kselftest+bounces-38238-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BCDB19FAA
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Aug 2025 12:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0008A7A154D
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Aug 2025 10:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B97524BBFD;
	Mon,  4 Aug 2025 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U83iXZpO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6982D4A07;
	Mon,  4 Aug 2025 10:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754303045; cv=none; b=dMQcbHO4jrnfrY82GYKOE8/ooI5tH6X+0EQzw6bWh2t2+6gGCXHOR/zhgIEIaNZmQCYqb7ZIsHHzRadXoHxMYADh/O1WofEsP8WJb/Q7bQmDqFouf8+Vrtm01JuwT01jeNRBvuzvmI0oMeq/FJUp281niRkG+EdMpSkCquY3yB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754303045; c=relaxed/simple;
	bh=w6peR6m+7jZbZfFC9MGuKD7AYm9oxWmlaVTj3ejKf/w=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZdK+Epe1K4ZeGzg426zUsEDdT0rqPOMXP7NDIPvcSFLTIHUmzE9rpxxzu+TniwkgLIv1zH7p9wr+yJnDe8MQpCWo81WtGxuobCmqOEqh4mUF6l5NtHOr7VqdLuF3SDZe6RYsHSWsZeGy/QhFxQAJTFdVFm48bSUA+4dgdOg9E7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U83iXZpO; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so7434382a12.2;
        Mon, 04 Aug 2025 03:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754303042; x=1754907842; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ODqZllmQ7MG6tJZiiLCQv7qmnxSWZfG+uWxo/YH5lb8=;
        b=U83iXZpO16R0CDvkY1xh8UzdpytEse6GmR7BG8pnJ0/kLspmHXOIza05IEmNEogG1e
         LgEBzgFVjoCJUfTMDqzWqzqjEt3f832gRMvK7jpmcjPkXQnfMrM4athyrGE4GtHOkHK/
         tzD4O1k6LeoetilyDA4t+z8xfzAf3yEgJ4ktCduGzQEUX8k0Ff8Xg8N2DbBoShhVSteD
         n6issCzj3tLtVE6jZNPE6/DYovtFVe/FZYsWbA7VYFnUvHKrTGNC/Rhd90YXgoOK6R65
         dkGxAbpNmkp1fszr/GLIjzsaecPIleGYKvhZLxabKJkDP/R7gShYoWWQILaYh8jKfJ2k
         zQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754303042; x=1754907842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODqZllmQ7MG6tJZiiLCQv7qmnxSWZfG+uWxo/YH5lb8=;
        b=JYhGyIxm7Ao0cUZBl4UA/U69W+Kg7Y0dA8K8KmPzSzQw0dIMDc7VLz616JHebF/XS7
         T7I8eZcMJkfAW63I1FpQCjy1r3koN09vCEeTxzLtG1IA+lqT/krJ8PtsIylEnaW72/r3
         anQnKEWBmUomtBDo18Myc7GcAAb3V4MRYVT7rqnExuu1rF6S4Ad2EkxluA3vvPMuNZLQ
         r9ipEk0f6NTt7ek9NDH6TSdwJ5QkDRCLoYBqdP3S4b/UbZcluSHE6RtPJgK4thrHpypK
         tFQo2k/waHgOfgWM8VK1t1B6T/qFFIwnpsLMvED+4HszhTZRNL5SfwiS/liHEbp9SX/u
         G2SA==
X-Forwarded-Encrypted: i=1; AJvYcCVHFdOzEw+ipDDXUWb4/magcuqe7mspUC12c+4TS1VZ6N8XLzAh5EekGNngr7fdueFo1fJ5X9ktIOUYU/I2@vger.kernel.org, AJvYcCVX0Rtjv0a0MAXf5jNqvTSJMXBLfK62b0viMqcdQrwLIjAG+eubF/uhWn0y6AYu97SU+aUPjv4dcS6fM875y7wC@vger.kernel.org, AJvYcCXQcRq5OsfP49gs3brj5+KN5rj4QaqjNyqA3O4SQf9Z6T3c8xTL3r7UXgNCWy5wsaUzxd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQiUePvpoXvxxY1ICNc36Uq/xC4dgo6sFCZm6gPps7qc9lJOrR
	kv89sgAsaS3DoEcgKh1Tt7OAmF+35MQ95xRA44KaZ4Heh5yON3VaBr4R
X-Gm-Gg: ASbGncvVHru8FEKxjjtoUlYu+Ru1fBn7Ck2P1sIxEf39B7OUrCfryMYwfMHanrWmjzW
	D0ZsKPIOSDpwldLwke+Mndj3yCK5UDVBgCbGbCLldp7QOGrmUZ5jelX88UgiG9y1UPVmi8Og4tl
	3Nf12F3bEcEZ0BTuoxQPEwVCpkHtrEqu1RR6bp6JuAaN4R6PXgNgcw/nq+HfCePSJhYysHlv9v7
	qODFAl/2ml09YBPkRbwjyAFxG9gliJInDRHuYPYZ+WHVJip6Rpn7t6lAYnZFR6iHyj6wSyahuxM
	xZr26703ubtSUma+TZ8RfdgL89yeV/fYEMXLkI8vdpmL4D9PjUnV6b3sNlZ3f5liqlNZyftw9Cs
	D5uRjhdKl
X-Google-Smtp-Source: AGHT+IHb0ZITpm6CBI91qSNUMi1uKmXv5hmfMz1eldIsixXme+2JH3CntR+FJ0kHEOADsOvE8Dpmxg==
X-Received: by 2002:a05:6402:84a:b0:615:b6b9:d87c with SMTP id 4fb4d7f45d1cf-615e6eb5fbamr8145984a12.3.1754303041267;
        Mon, 04 Aug 2025 03:24:01 -0700 (PDT)
Received: from krava ([173.38.220.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8ffb8d7sm6701166a12.47.2025.08.04.03.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 03:24:00 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 4 Aug 2025 12:23:59 +0200
To: Jiawei Zhao <phoenix500526@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	yonghong.song@linux.dev, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] libbpf: fix USDT SIB argument handling causing
 unrecognized register error
Message-ID: <aJCKP1Cja3DCm0EG@krava>
References: <20250802084803.108777-1-phoenix500526@163.com>
 <20250802084803.108777-2-phoenix500526@163.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250802084803.108777-2-phoenix500526@163.com>

On Sat, Aug 02, 2025 at 08:48:02AM +0000, Jiawei Zhao wrote:
> On x86-64, USDT arguments can be specified using Scale-Index-Base (SIB)
> addressing, e.g. "1@-96(%rbp,%rax,8)". The current USDT implementation
> in libbpf cannot parse this format, causing `bpf_program__attach_usdt()`
> to fail with -ENOENT (unrecognized register).
> 
> This patch fixes this by implementing the necessary changes:
> - add correct handling for SIB-addressed arguments in `bpf_usdt_arg`.
> - add adaptive support to `__bpf_usdt_arg_type` and
>   `__bpf_usdt_arg_spec` to represent SIB addressing parameters.
> 
> Signed-off-by: Jiawei Zhao <phoenix500526@163.com>
> ---
>  tools/lib/bpf/usdt.bpf.h | 33 +++++++++++++++++++++++++++++-
>  tools/lib/bpf/usdt.c     | 43 ++++++++++++++++++++++++++++++++++------
>  2 files changed, 69 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
> index 2a7865c8e3fe..246513088c3a 100644
> --- a/tools/lib/bpf/usdt.bpf.h
> +++ b/tools/lib/bpf/usdt.bpf.h
> @@ -34,6 +34,7 @@ enum __bpf_usdt_arg_type {
>  	BPF_USDT_ARG_CONST,
>  	BPF_USDT_ARG_REG,
>  	BPF_USDT_ARG_REG_DEREF,
> +	BPF_USDT_ARG_SIB,
>  };
>  
>  struct __bpf_usdt_arg_spec {
> @@ -43,6 +44,10 @@ struct __bpf_usdt_arg_spec {
>  	enum __bpf_usdt_arg_type arg_type;
>  	/* offset of referenced register within struct pt_regs */
>  	short reg_off;
> +	/* offset of index register in pt_regs, only used in SIB mode */
> +	short idx_reg_off;
> +	/* scale factor for index register, only used in SIB mode */
> +	short scale;
>  	/* whether arg should be interpreted as signed value */
>  	bool arg_signed;
>  	/* number of bits that need to be cleared and, optionally,
> @@ -149,7 +154,7 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
>  {
>  	struct __bpf_usdt_spec *spec;
>  	struct __bpf_usdt_arg_spec *arg_spec;
> -	unsigned long val;
> +	unsigned long val, idx;
>  	int err, spec_id;
>  
>  	*res = 0;
> @@ -202,6 +207,32 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
>  			return err;
>  #if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
>  		val >>= arg_spec->arg_bitshift;
> +#endif
> +		break;
> +	case BPF_USDT_ARG_SIB:
> +		/* Arg is in memory addressed by SIB (Scale-Index-Base) mode
> +		 * (e.g., "-1@-96(%rbp,%rax,8)" in USDT arg spec). Register
> +		 * is identified like with BPF_USDT_ARG_SIB case, the offset
> +		 * is in arg_spec->val_off, the scale factor is in arg_spec->scale.
> +		 * Firstly, we fetch the base register contents and the index
> +		 * register contents from pt_regs. Secondly, we multiply the
> +		 * index register contents by the scale factor, then add the
> +		 * base address and the offset to get the final address. Finally,
> +		 * we do another user-space probe read to fetch argument value
> +		 * itself.
> +		 */
> +		err = bpf_probe_read_kernel(&val, sizeof(val), (void *)ctx + arg_spec->reg_off);
> +		if (err)
> +			return err;
> +		err = bpf_probe_read_kernel(&idx, sizeof(idx), (void *)ctx + arg_spec->idx_reg_off);
> +		if (err)
> +			return err;
> +		err = bpf_probe_read_user(&val, sizeof(val),
> +				(void *)val + idx * arg_spec->scale + arg_spec->val_off);
> +		if (err)
> +			return err;
> +#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
> +		val >>= arg_spec->arg_bitshift;
>  #endif
>  		break;
>  	default:
> diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> index 4e4a52742b01..1f8b9e1c9819 100644
> --- a/tools/lib/bpf/usdt.c
> +++ b/tools/lib/bpf/usdt.c
> @@ -200,6 +200,7 @@ enum usdt_arg_type {
>  	USDT_ARG_CONST,
>  	USDT_ARG_REG,
>  	USDT_ARG_REG_DEREF,
> +	USDT_ARG_SIB,
>  };
>  
>  /* should match exactly struct __bpf_usdt_arg_spec from usdt.bpf.h */
> @@ -207,6 +208,8 @@ struct usdt_arg_spec {
>  	__u64 val_off;
>  	enum usdt_arg_type arg_type;
>  	short reg_off;
> +	short idx_reg_off;
> +	short scale;
>  	bool arg_signed;
>  	char arg_bitshift;
>  };
> @@ -1283,11 +1286,39 @@ static int calc_pt_regs_off(const char *reg_name)
>  
>  static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec *arg, int *arg_sz)
>  {
> -	char reg_name[16];
> -	int len, reg_off;
> -	long off;
> +	char reg_name[16] = {0}, idx_reg_name[16] = {0};
> +	int len, reg_off, idx_reg_off, scale = 1;
> +	long off = 0;
> +
> +	if (sscanf(arg_str, " %d @ %ld ( %%%15[^,] , %%%15[^,] , %d ) %n",
> +				arg_sz, &off, reg_name, idx_reg_name, &scale, &len) == 5 ||
> +		sscanf(arg_str, " %d @ ( %%%15[^,] , %%%15[^,] , %d ) %n",
> +				arg_sz, reg_name, idx_reg_name, &scale, &len) == 4 ||
> +		sscanf(arg_str, " %d @ %ld ( %%%15[^,] , %%%15[^)] ) %n",
> +				arg_sz, &off, reg_name, idx_reg_name, &len) == 4 ||
> +		sscanf(arg_str, " %d @ ( %%%15[^,] , %%%15[^)] ) %n",
> +				arg_sz, reg_name, idx_reg_name, &len) == 3
> +		) {
> +		/* Scale Index Base case, e.g., 1@-96(%rbp,%rax,8)
> +		 * 1@(%rbp,%rax,8)
> +		 * 1@-96(%rbp,%rax)
> +		 * 1@(%rbp,%rax)
> +		 */

hi,
I'm getting following error from the test:

subtest_multispec_usdt:PASS:skel_open 0 nsec
libbpf: usdt: unrecognized arg #10 spec '-2@nums(%rax,%rax) -1@$-127'
libbpf: prog 'usdt12': failed to auto-attach: -EINVAL
subtest_multispec_usdt:FAIL:skel_attach unexpected error: -22 (errno 22)
#480/2   usdt/multispec:FAIL

arguments look like:
    Arguments: -4@$3 -4@$4 -8@$42 -8@$45 -4@$5 -8@$6 8@%rdx 8@%rsi -4@$-9 -2@%cx -2@nums(%rax,%rax) -1@$-127

not sure why there's variable name in the arg10 definition

gcc (GCC) 15.1.1 20250521 (Red Hat 15.1.1-2)
clang version 20.1.8 (Fedora 20.1.8-3.fc42)

thanks,
jirka


> +		arg->arg_type = USDT_ARG_SIB;
> +		arg->val_off = off;
> +		arg->scale = scale;
> +
> +		reg_off = calc_pt_regs_off(reg_name);
> +		if (reg_off < 0)
> +			return reg_off;
> +		arg->reg_off = reg_off;
>  
> -	if (sscanf(arg_str, " %d @ %ld ( %%%15[^)] ) %n", arg_sz, &off, reg_name, &len) == 3) {
> +		idx_reg_off = calc_pt_regs_off(idx_reg_name);
> +		if (idx_reg_off < 0)
> +			return idx_reg_off;
> +		arg->idx_reg_off = idx_reg_off;
> +	} else if (sscanf(arg_str, " %d @ %ld ( %%%15[^)] ) %n",
> +				arg_sz, &off, reg_name, &len) == 3) {
>  		/* Memory dereference case, e.g., -4@-20(%rbp) */
>  		arg->arg_type = USDT_ARG_REG_DEREF;
>  		arg->val_off = off;
> @@ -1298,7 +1329,7 @@ static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec
>  	} else if (sscanf(arg_str, " %d @ ( %%%15[^)] ) %n", arg_sz, reg_name, &len) == 2) {
>  		/* Memory dereference case without offset, e.g., 8@(%rsp) */
>  		arg->arg_type = USDT_ARG_REG_DEREF;
> -		arg->val_off = 0;
> +		arg->val_off = off;
>  		reg_off = calc_pt_regs_off(reg_name);
>  		if (reg_off < 0)
>  			return reg_off;
> @@ -1306,7 +1337,7 @@ static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec
>  	} else if (sscanf(arg_str, " %d @ %%%15s %n", arg_sz, reg_name, &len) == 2) {
>  		/* Register read case, e.g., -4@%eax */
>  		arg->arg_type = USDT_ARG_REG;
> -		arg->val_off = 0;
> +		arg->val_off = off;
>  
>  		reg_off = calc_pt_regs_off(reg_name);
>  		if (reg_off < 0)
> -- 
> 2.43.0
> 
> 

