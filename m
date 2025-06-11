Return-Path: <linux-kselftest+bounces-34689-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44520AD5210
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 12:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB7FD7AC394
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 10:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA9C27700A;
	Wed, 11 Jun 2025 10:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFBh94E5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6EF27605C;
	Wed, 11 Jun 2025 10:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749638095; cv=none; b=fXvswhKo09cnawczjHw9zO4JqbMJdxbWsyCiQ1I5g9QqrIPG6Ou3WdJyHJvdg+d+c2coPayLC+QtGm8kwt1ysrbvrvaPwtWFZAsjUViaJgtJw1KHVIdTDsP9DiLCOuGuOybfN5GnsZwLXrFpuXTIt5mmBPA3z0XYMHj07vPCUeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749638095; c=relaxed/simple;
	bh=ogpnT5Ct5eysAH74HW6uLq8kQrXagSiHRmkpMn3ObqI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0FnS4dpcO4ASxe0wXS7Wmkrq8k4/I55KeT21S/j7S3HaHoUwFIFsUBSRvyiEBtsxUCIYjCxDtyo2aLvOLZZwDTLu0rVYQ9Aal4tRrvgmX2rEssLUQNSu1oiRZSkP4lnTNlX/xwuWH2sNzkYx9j4TbdwvT6L1QjV6m1KbTqdmcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFBh94E5; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-addfe17ec0bso151183966b.1;
        Wed, 11 Jun 2025 03:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749638092; x=1750242892; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x0uKW1VeGsneSncVbCyz+LkK6o18HmhOxqfXFR/PnMI=;
        b=cFBh94E5DTlpPrBPyFbpAunYDuTcimiWv6KbSTKFbBTNakOgKXmJsnCWwK/Cs3lcCZ
         Wo/DOwJ72ayhcAEwQk1iq3X3t2mK8H/RtQJa0ZBuD7gR6qHThmqCTnTe9ZElcTNBPyCm
         T7yxfZGNWTo3OAMXRQOa56uWxPRsE2lWUd9uJhUHKwjszD+Nw/DN5effihL5CJqwl8BV
         jd71shao+LuY9qqwNSeA9525Vmag5TnKi8JFZuReyz+wAmAplzHHXM7BMh9NXpAWn1oJ
         6TWZLXiGJ1aGkEjag9LEAl6aV239TlgXWPN4dZ+CzWczYN89Bj4Q/PzLm4fnzG+I13+q
         JSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749638092; x=1750242892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0uKW1VeGsneSncVbCyz+LkK6o18HmhOxqfXFR/PnMI=;
        b=PkBCH8C0pb6Kb4Dj6Hs+prhSHn+lLdnwZVBn+2TzvFbOwEEPVU/gMgfjZ/B708zonj
         FBl1HqqCyLfaJljJaQb0Az6qOnKPNp/rDCCgtHeTYUGBHkG3E2w/a97AiqtmcjNo32GK
         K2aqw6tzi1janxwziaM5Ue//FbmGXqiCPXWbBCKTEOBdY+rq8HcYX+ytXbiOrysP7v2W
         E/TeiTk1+pgOj2rhHY3uOvFhoQebWKBbXZpaY7YpRGapiocSGUwHNUdZ35srKX2xB4hw
         WojwJGDttvbORX0SkBhQdNeSnUas6gYMcqVH9L5Kcn5UhZDSymJ8SIVW4WXS0g61tSW6
         nzHA==
X-Forwarded-Encrypted: i=1; AJvYcCU+YsqCCIiB1i/KfOL+vVQQZ4WLrDI/tlVayOue30Hml/1mc+z/dnM46DuXso3Yb0/MGz9Hpy5Us2ejSCgJ@vger.kernel.org, AJvYcCUFU1liK5V4n5dV++hY1SqoNFnK6KM5yz89g553PRsR+LWTTo39A4Wap52/KpcbVeOZnB46r7+m9KMb5vj/X3+w@vger.kernel.org, AJvYcCVNdcrdK3DE8uOw+gJjeTEx1daAGhNct5rOIlASv9NZyA2fLhB+HDxa0RWQvX/h9T1Kakk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf8UfFVqz2Ys46S7vsRe8kDhrBrsbsfTLdBHTOZWwgRD6qGZjv
	0nke/HIGQjjWFJ2LlzB9H+OLAScICUeHsQw/qnI5VaBeN7PYZy7MnCGC
X-Gm-Gg: ASbGncuFNcPXZZMSwPKEGIaG9PcfougnGTS1NCPPCDZ5nlVMSqnl5QELCwV4XJykT9/
	a2Q0y9f/8nFxu4fsdy5OHT1WE+91sZaNsiKiMSxSBdgGKinTMFLXWDfP2sHAz2DIelLUp12aL2x
	3DyoQWsgN9fG9zA75NnrWLLGrbd0dcO+YTNVaPcE9JuXJfBp9F/EpR/kv0TR8XT8Rl4pilCdHSK
	N+7mo7pTSrK//LUY80P6sBRwBxRQG/HzvLOxrhBKHbI7MJ4qWLKZeJ03EKUEUtMqm/5Hbdypfzr
	UyGN6Pd3zKI3qbGakaTKZjfNkMEQJhgCPxbt0n1WVTADV0U0
X-Google-Smtp-Source: AGHT+IE8SIVFSPxHy04F/nR2Xhi3uUbPpm4yM6gc7UZ2MMWfC9Kpbmt7MaJOGFiADTq+5YH+jRAfWw==
X-Received: by 2002:a17:906:2442:b0:ade:9b52:4d79 with SMTP id a640c23a62f3a-ade9b525d84mr18040866b.1.1749638091955;
        Wed, 11 Jun 2025 03:34:51 -0700 (PDT)
Received: from krava ([173.38.220.55])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc1c7e2sm863976666b.73.2025.06.11.03.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 03:34:51 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 11 Jun 2025 12:34:49 +0200
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
Subject: Re: [PATCH v3 1/2] libbpf: add support for printing BTF character
 arrays as strings
Message-ID: <aElbyWY-cIQNf4wp@krava>
References: <20250603203701.520541-1-blakejones@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603203701.520541-1-blakejones@google.com>

On Tue, Jun 03, 2025 at 01:37:00PM -0700, Blake Jones wrote:
> The BTF dumper code currently displays arrays of characters as just that -
> arrays, with each character formatted individually. Sometimes this is what
> makes sense, but it's nice to be able to treat that array as a string.
> 
> This change adds a special case to the btf_dump functionality to allow
> 0-terminated arrays of single-byte integer values to be printed as
> character strings. Characters for which isprint() returns false are
> printed as hex-escaped values. This is enabled when the new ".emit_strings"
> is set to 1 in the btf_dump_type_data_opts structure.
> 
> As an example, here's what it looks like to dump the string "hello" using
> a few different field values for btf_dump_type_data_opts (.compact = 1):
> 
> - .emit_strings = 0, .skip_names = 0:  (char[6])['h','e','l','l','o',]
> - .emit_strings = 0, .skip_names = 1:  ['h','e','l','l','o',]
> - .emit_strings = 1, .skip_names = 0:  (char[6])"hello"
> - .emit_strings = 1, .skip_names = 1:  "hello"

hi,
could this be used in bpftool map dump? ;-) I checked, but it looks like
bpftool map dump is using something else to dump data.. I admit I haven't
spent much on time that

thanks,
jirka


> 
> Here's the string "h\xff", dumped with .compact = 1 and .skip_names = 1:
> 
> - .emit_strings = 0:  ['h',-1,]
> - .emit_strings = 1:  "h\xff"
> 
> Signed-off-by: Blake Jones <blakejones@google.com>
> ---
>  tools/lib/bpf/btf.h      |  3 ++-
>  tools/lib/bpf/btf_dump.c | 55 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 56 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index 4392451d634b..ccfd905f03df 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -326,9 +326,10 @@ struct btf_dump_type_data_opts {
>  	bool compact;		/* no newlines/indentation */
>  	bool skip_names;	/* skip member/type names */
>  	bool emit_zeroes;	/* show 0-valued fields */
> +	bool emit_strings;	/* print char arrays as strings */
>  	size_t :0;
>  };
> -#define btf_dump_type_data_opts__last_field emit_zeroes
> +#define btf_dump_type_data_opts__last_field emit_strings
>  
>  LIBBPF_API int
>  btf_dump__dump_type_data(struct btf_dump *d, __u32 id,
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index 460c3e57fadb..7c2f1f13f958 100644
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
> @@ -2028,6 +2029,52 @@ static int btf_dump_var_data(struct btf_dump *d,
>  	return btf_dump_dump_type_data(d, NULL, t, type_id, data, 0, 0);
>  }
>  
> +static int btf_dump_string_data(struct btf_dump *d,
> +				const struct btf_type *t,
> +				__u32 id,
> +				const void *data)
> +{
> +	const struct btf_array *array = btf_array(t);
> +	const char *chars = data;
> +	__u32 i;
> +
> +	/* Make sure it is a NUL-terminated string. */
> +	for (i = 0; i < array->nelems; i++) {
> +		if ((void *)(chars + i) >= d->typed_dump->data_end)
> +			return -E2BIG;
> +		if (chars[i] == '\0')
> +			break;
> +	}
> +	if (i == array->nelems) {
> +		/* The caller will print this as a regular array. */
> +		return -EINVAL;
> +	}
> +
> +	btf_dump_data_pfx(d);
> +	btf_dump_printf(d, "\"");
> +
> +	for (i = 0; i < array->nelems; i++) {
> +		char c = chars[i];
> +
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
> +			btf_dump_printf(d, "\\x%02x", (__u8)c);
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
> @@ -2055,8 +2102,13 @@ static int btf_dump_array_data(struct btf_dump *d,
>  		 * char arrays, so if size is 1 and element is
>  		 * printable as a char, we'll do that.
>  		 */
> -		if (elem_size == 1)
> +		if (elem_size == 1) {
> +			if (d->typed_dump->emit_strings &&
> +			    btf_dump_string_data(d, t, id, data) == 0) {
> +				return 0;
> +			}
>  			d->typed_dump->is_array_char = true;
> +		}
>  	}
>  
>  	/* note that we increment depth before calling btf_dump_print() below;
> @@ -2544,6 +2596,7 @@ int btf_dump__dump_type_data(struct btf_dump *d, __u32 id,
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

