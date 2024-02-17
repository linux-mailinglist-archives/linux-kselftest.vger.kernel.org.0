Return-Path: <linux-kselftest+bounces-4906-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50028858D05
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Feb 2024 04:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895CD1F2352C
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Feb 2024 03:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB951B7F6;
	Sat, 17 Feb 2024 03:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="McLXvosS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9385B5381
	for <linux-kselftest@vger.kernel.org>; Sat, 17 Feb 2024 03:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708139002; cv=none; b=IJjG0Ao5HfENy8MbgQT9wn+wf4G2fIAuFoow6ghkKOc/8QOzxMwE0N2znZTdvTkp5USL+1XyFpyoGAiNb8FuE3jMf3qBy3yY7NqPVPNy7XHNiyNPRwx43Ti5vpZCCvLCUQTIntxqVF/wqHwTKqyZLbtN90tDJq9fMe6DoAqvQR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708139002; c=relaxed/simple;
	bh=xpvnUQORiMZ/oAeyo85a9kbOqGl2fDmjOk2texpVn8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7fU6IuCNz6mbKDIbCuQuvi99HKHCjDuuXWDZzKDVlBXuWvTkvQGF2ujNNFVglIIdDs5gMLsKqltUfUskrERSamn/PBZgE6A4rIKmJWfWQg4ZAZCtp7K3eZj0qWL1XxWRz6Nf+LuANJpXKWUjPdlWpwAZKq3KJRvUDfk6A2vGzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=McLXvosS; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-53fa455cd94so1851582a12.2
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Feb 2024 19:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708139000; x=1708743800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9E8QSOafC61clD8Eej3Har3OU/+oWCjszElG8x74Hj8=;
        b=McLXvosSYm2MWVUEK/eacWgTkwXq1xzXKmxqORZBZPBuc3Ea19jdw3dDdgY4rnRJc+
         Lg8YS/ydevC1hc4f3uEOa4b87WlgZw4yJO/MSqSdFhnjwhspJEgP/FkxIIXw+iicBmkf
         QKnB14duiBoR5bPq8YbixNjN9g6iGJXuq0h1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708139000; x=1708743800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9E8QSOafC61clD8Eej3Har3OU/+oWCjszElG8x74Hj8=;
        b=l/3IajVZA/r1SrYpnpOw7AKR4O06QiDZ6FON+1WjEkCInaASZbSXXmscxADQ94s6q9
         tAJqluyhzBdLNxKxSQ2w4/tfUjMZyoCzjtXA2ovTrUrI6OtOjNL+gUr+ElOFAEcosukH
         AltTkAuGDqTqkFp0NGjOeRrdzMm9UgLLf0RzgZVn1OIyV4IkylfXwGK8FE+2GWXAiazH
         A/1kOM3P/fmgmrBEfrCRlSV5+83pf6HFbxx+J+9n8hUxtnZaEfpXosXwl+sfvIuXaxg+
         ULkElf+gEVBoV8xc3+hhC1WWrDLppjKzJTIyJeRjA+Sids0M0JdqL/9IoHpIKu/aI0KG
         koRA==
X-Forwarded-Encrypted: i=1; AJvYcCWm38xpfXXhuiDlntvL+MKsxtkTvtF8o6F9TRa57TntXWW8fBM3R8t8XdyETHxdvb9fXoMiB7aDu4lz5k7SzUOI6fi2PBI3xl58IC8m0zax
X-Gm-Message-State: AOJu0YwKcMIbvstkpCHzCbDQTxu5sf0P2H8xokQdZAT9dstytUX1kq5e
	ynpmV50/EvknJIwmv75HAWr8bZmEZQv0rX5uzYgT7kn+sUroiqXC6tLQ5e/2lg==
X-Google-Smtp-Source: AGHT+IGk3vr0O8poIMmGJlhPEiEvPKSSXAAztZELBQ+98gW6sIlAiN+nPC+62bRu84NsZRY0YVzpBw==
X-Received: by 2002:a17:902:f54a:b0:1db:55cc:d222 with SMTP id h10-20020a170902f54a00b001db55ccd222mr9000388plf.4.1708139000004;
        Fri, 16 Feb 2024 19:03:20 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id kq13-20020a170903284d00b001db5c8202a4sm525497plb.59.2024.02.16.19.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 19:03:19 -0800 (PST)
Date: Fri, 16 Feb 2024 19:03:18 -0800
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Haowen Bai <baihaowen@meizu.com>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Yonghong Song <yonghong.song@linux.dev>,
	Anton Protopopov <aspsk@isovalent.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] bpf: Replace bpf_lpm_trie_key 0-length array with
 flexible array
Message-ID: <202402161902.FCFFEC322@keescook>
References: <20240216235536.it.234-kees@kernel.org>
 <e58d035c-fb74-4d29-94d5-6c22542e7513@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e58d035c-fb74-4d29-94d5-6c22542e7513@embeddedor.com>

On Fri, Feb 16, 2024 at 06:27:08PM -0600, Gustavo A. R. Silva wrote:
> 
> 
> On 2/16/24 17:55, Kees Cook wrote:
> > Replace deprecated 0-length array in struct bpf_lpm_trie_key with
> > flexible array. Found with GCC 13:
> > 
> > ../kernel/bpf/lpm_trie.c:207:51: warning: array subscript i is outside array bounds of 'const __u8[0]' {aka 'const unsigned char[]'} [-Warray-bounds=]
> >    207 |                                        *(__be16 *)&key->data[i]);
> >        |                                                   ^~~~~~~~~~~~~
> > ../include/uapi/linux/swab.h:102:54: note: in definition of macro '__swab16'
> >    102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
> >        |                                                      ^
> > ../include/linux/byteorder/generic.h:97:21: note: in expansion of macro '__be16_to_cpu'
> >     97 | #define be16_to_cpu __be16_to_cpu
> >        |                     ^~~~~~~~~~~~~
> > ../kernel/bpf/lpm_trie.c:206:28: note: in expansion of macro 'be16_to_cpu'
> >    206 |                 u16 diff = be16_to_cpu(*(__be16 *)&node->data[i]
> > ^
> >        |                            ^~~~~~~~~~~
> > In file included from ../include/linux/bpf.h:7:
> > ../include/uapi/linux/bpf.h:82:17: note: while referencing 'data'
> >     82 |         __u8    data[0];        /* Arbitrary size */
> >        |                 ^~~~
> > 
> > And found at run-time under CONFIG_FORTIFY_SOURCE:
> > 
> >    UBSAN: array-index-out-of-bounds in kernel/bpf/lpm_trie.c:218:49
> >    index 0 is out of range for type '__u8 [*]'
> > 
> > This includes fixing the selftest which was incorrectly using a
> > variable length struct as a header, identified earlier[1]. Avoid this
> > by just explicitly including the prefixlen member instead of struct
> > bpf_lpm_trie_key.
> > 
> > Note that it is not possible to simply remove the "data" member, as it
> > is referenced by userspace
> > 
> > cilium:
> >          struct egress_gw_policy_key in_key = {
> >                  .lpm_key = { 32 + 24, {} },
> >                  .saddr   = CLIENT_IP,
> >                  .daddr   = EXTERNAL_SVC_IP & 0Xffffff,
> >          };
> > 
> > systemd:
> > 	ipv6_map_fd = bpf_map_new(
> > 			BPF_MAP_TYPE_LPM_TRIE,
> > 			offsetof(struct bpf_lpm_trie_key, data) + sizeof(uint32_t)*4,
> > 			sizeof(uint64_t),
> > 			...
> > 
> > The only risk to UAPI would be if sizeof() were used directly on the
> > data member, which it does not seem to be. It is only used as a static
> > initializer destination and to find its location via offsetof().
> > 
> > Link: https://lore.kernel.org/all/202206281009.4332AA33@keescook/ [1]
> > Reported-by: Mark Rutland <mark.rutland@arm.com>
> > Closes: https://paste.debian.net/hidden/ca500597/
> 
> mmh... this URL expires: 2024-05-15

Yup, but that's why I included the run-time splat above too. :)

-- 
Kees Cook

