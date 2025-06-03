Return-Path: <linux-kselftest+bounces-34217-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4465ACC784
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 15:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2FC3A42FF
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 13:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A9922F152;
	Tue,  3 Jun 2025 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3j8CshA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215E213C8E8;
	Tue,  3 Jun 2025 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748956687; cv=none; b=IwfRHAWqSxWK3iDBGfLPA2hK8oerHLi63Jye1nKYvFt88YQnzhsHASUbR4qVI05OayFMnQnUmq/Thca6CWdHqYGRc61/aG7PedvXfAPFDxMnfvVaHaO2Lgwqq+K4UnPPi2isIQZrEiwPfRpa+bZZGFP55suwo7uWQvW+waPsBXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748956687; c=relaxed/simple;
	bh=Xemxkc7CmkUAnRI0oTE4LFUjpXKr0LGpTSrxjrZCiIc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBc2aOhjIv3FVXjgMksKQ0JPsQ3/K/NKwThr4rPOxWSQ6tcG/Tpl+0D7G+hcrGiEqhPHxYE9XlZwPMmPfRoXZGcm+PhyvgD5c2QwoG2kDXyCREVDOwySPY/zs9UgwYJXIFglD67mHiYa8RD/LeHN8uzQbVfjQultU0VdrHsB3TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3j8CshA; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-450cf214200so51907945e9.1;
        Tue, 03 Jun 2025 06:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748956684; x=1749561484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=peWLhA4jAbByy6mLiR9VmFzFINS+YteyOYVUMCn+9PE=;
        b=I3j8CshAfgHifQ7bS1EFDH3As/oaDyZ74LFMqa6BpRDKrOYhtuMvgNhkQrcEYXt3yO
         z2/AKLl/ywqIY23PWpWT0oNeBRxF7XoNp9/VuPf9avhfjDfpzmJW1ifp+C9Hth7MybPf
         zjmYfuJ/kaBWWJYb7fNHFYw6wxE3ByJ1ypE/IBYZ8N/vLKwZ75P17+4hz3I2qaZXMBuo
         BZ7NaCQTyosg5/BBGGaIdfuGZyxKV0GIYkk5oa9BredWrWF3KRpGSEFeAILjXAGF+ouA
         LRZI7WX1T4/IJGx4t8REaepPefygMf8pnsPUeCO30RYG7gKo/GysAUo0Mvd263ncbgIy
         1QKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748956684; x=1749561484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=peWLhA4jAbByy6mLiR9VmFzFINS+YteyOYVUMCn+9PE=;
        b=eupBBK3+kt8TSG2zj5sgpDRnW2l4Sf3c3H6J8fXg3RCn85QiIVIE7rx/CyZ6o8XdIL
         tMVjypnVSMSk1mQCvOUMkzFvJ4XpWYRU4M6B4RHEHDZjRItnd6nySwSDhhbS8ZFDqZCS
         dZqITkW0cYyNWqbLPSA8nLLmtQNUVRoCCuyjDHyNum2LTMFSPizKieMnamawlpbAQjt7
         3Xk4SYW+4De+70W8q5IQoIplxvm1YWkXhHezIo45pnIv0CRWaBx5DpjMQnPCXcnqMCH2
         5RPgQ67X6cVAtGTRAtbNyNU/TkV7pDLr3Vl9VmJ9QEwmGYtsGeDfkamQGrTUZti4CyFG
         QKgQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3e5vIEsVHHj1A5CaiSIXgSc807/BP7wKvCDOjGOubIznFpXSG46HJAUuE4FuzeXq+1ynfQcsknTOSvbvR@vger.kernel.org, AJvYcCW3moPfVAQ2vlQsPMCUA9XNnncKyBgnY95TU5m6EirnJvc4CFKmSWVD/sTohSIkFg3i2vk=@vger.kernel.org, AJvYcCX5WP0c0VaEKiwGKMNSY5tg0vNM7miDTE1dUAMhBg9AXVdj69cSi54YpWRITdiB8447vJWnQ3zymwSixZ9kmTsN@vger.kernel.org
X-Gm-Message-State: AOJu0YwoO7AepdIGvEmXlVw5E7eOqQXYdND6tVwgqfeseqNpmSbgJQoy
	1Fuk7Tx4+7A/o00sw6V+p3i8zTwxBXKeqNntK0kyrHCf6krVxbBJhU/W
X-Gm-Gg: ASbGncuzF2dA0bapx+4/1CKSheRovjWJ/2dYoDDkO5Qe95ZdOTj8dZXc03iXZyJ1CNY
	mo2sDt4ENeiFSwGbePhS3izEtWVCfh3SEU2l89vxdixqXySIkIuQjv/pjTlbpOj7nkv9R6X0znL
	XjfQX+U6oPnKSjS0WfFJYpwoLf0GJo63VdfTwZs87cYEJF397I/bl/D7fg8fSFLJNTexknW/AS5
	OZyQlOw4JbXtwGmi3Pg73wpAgC4VhI12wMqHOajCchu0g2u5oBtamSydLu4ZVGnXiBt4d5CfjFS
	BrZ/e8kxZ5btCEgBgsmJMJaRzwd/2vCld4sFG78=
X-Google-Smtp-Source: AGHT+IEOLU+ZNQccBdDuYLKmcv1FH7y9QFTBdWAdtQv9NUcEFH1//GEL/QfmTGkcoDfbzeqbxby5XQ==
X-Received: by 2002:a05:600c:314a:b0:43d:1b74:e89a with SMTP id 5b1f17b1804b1-450d880c950mr155691445e9.9.1748956684034;
        Tue, 03 Jun 2025 06:18:04 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe5b887sm18720835f8f.18.2025.06.03.06.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 06:18:03 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 3 Jun 2025 15:18:01 +0200
To: Blake Jones <blakejones@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/2] libbpf: add support for printing BTF character
 arrays as strings
Message-ID: <aD72CVq-kWr3G4S3@krava>
References: <20250603044813.88265-1-blakejones@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603044813.88265-1-blakejones@google.com>

On Mon, Jun 02, 2025 at 09:48:12PM -0700, Blake Jones wrote:

SNIP

> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index 460c3e57fadb..336a6646e0fa 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -68,6 +68,7 @@ struct btf_dump_data {
>  	bool compact;
>  	bool skip_names;
>  	bool emit_zeroes;
> +	bool emit_strings;
>  	__u8 indent_lvl;	/* base indent level */
>  	char indent_str[BTF_DATA_INDENT_STR_LEN];
>  	/* below are used during iteration */
> @@ -2028,6 +2029,43 @@ static int btf_dump_var_data(struct btf_dump *d,
>  	return btf_dump_dump_type_data(d, NULL, t, type_id, data, 0, 0);
>  }
>  
> +static int btf_dump_string_data(struct btf_dump *d,
> +				const struct btf_type *t,
> +				__u32 id,
> +				const void *data)
> +{
> +	const struct btf_array *array = btf_array(t);
> +	__u32 i;
> +
> +	btf_dump_data_pfx(d);
> +	btf_dump_printf(d, "\"");
> +
> +	for (i = 0; i < array->nelems; i++, data++) {
> +		char c;
> +
> +		if (data >= d->typed_dump->data_end)
> +			return -E2BIG;

curious, is this just string array without null terminating byte?
should we just print " and return 0 instead of E2BIG error ?

thanks,
jirka


> +
> +		c = *(char *)data;
> +		if (c == '\0') {
> +			/*
> +			 * When printing character arrays as strings, NUL bytes
> +			 * are always treated as string terminators; they are
> +			 * never printed.
> +			 */
> +			break;
> +		}
> +		if (isprint(c))
> +			btf_dump_printf(d, "%c", c);
> +		else
> +			btf_dump_printf(d, "\\x%02x", *(__u8 *)data);
> +	}
> +
> +	btf_dump_printf(d, "\"");
> +
> +	return 0;
> +}
> +
>  static int btf_dump_array_data(struct btf_dump *d,
>  			       const struct btf_type *t,
>  			       __u32 id,
> @@ -2055,8 +2093,11 @@ static int btf_dump_array_data(struct btf_dump *d,
>  		 * char arrays, so if size is 1 and element is
>  		 * printable as a char, we'll do that.
>  		 */
> -		if (elem_size == 1)
> +		if (elem_size == 1) {
> +			if (d->typed_dump->emit_strings)
> +				return btf_dump_string_data(d, t, id, data);
>  			d->typed_dump->is_array_char = true;
> +		}
>  	}
>  
>  	/* note that we increment depth before calling btf_dump_print() below;
> @@ -2544,6 +2585,7 @@ int btf_dump__dump_type_data(struct btf_dump *d, __u32 id,
>  	d->typed_dump->compact = OPTS_GET(opts, compact, false);
>  	d->typed_dump->skip_names = OPTS_GET(opts, skip_names, false);
>  	d->typed_dump->emit_zeroes = OPTS_GET(opts, emit_zeroes, false);
> +	d->typed_dump->emit_strings = OPTS_GET(opts, emit_strings, false);
>  
>  	ret = btf_dump_dump_type_data(d, NULL, t, id, data, 0, 0);
>  
> -- 
> 2.49.0.1204.g71687c7c1d-goog
> 

