Return-Path: <linux-kselftest+bounces-31224-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3B3A94BDD
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 06:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EEEE1886301
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 04:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B97256C8D;
	Mon, 21 Apr 2025 04:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQuP9d6A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1D9262A6;
	Mon, 21 Apr 2025 04:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745209285; cv=none; b=pECJsHvzkAP1yfEYlug7dmGQDE1ylZwH4f1/SWfTjBYaMyUqTYwfC9ajG83xvAdHkK5u3d0GOe9nMQ0MVaW5D8QfnIPyrRbJWl+fiQ9K1+fnwXnJ1PHH92F7oLUlUUJjbaXr8v80XoKczYaKnpaRSlelVjGSgdHagfx9P4sguHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745209285; c=relaxed/simple;
	bh=pniZ2vXu7q4ZAogZzkjAYPN5wKLi3NF85XJ1oYPxgzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4ltxrt3tPYuQCM4XP7uj3XuuYRxLdaHDNb3nB/Jgvmd+vJ91/rgGRpdKyXqIs8mLK3cRskqaoNxnnxL5vfJCt8SZXB4/8oWN0uCBlOYb14oXgXTnTrsZOmk2pgTbpZE7oGlGr01RhIbzuuRnCaRasJ77oK2fp5f7NMdhNdwBi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQuP9d6A; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-736e52948ebso4119897b3a.1;
        Sun, 20 Apr 2025 21:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745209283; x=1745814083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0me9D7HF9QKBEL74pTv2jHUMZzDdUUcB3pHPjboOlA8=;
        b=mQuP9d6AOwPQpyuHrUZ2izCEc18ulCR6RzGhqLclR0KPnrJW0nSzzJOaw645LLDkX7
         AhsE5FxqbiLIbAZjEjsjEr2FSzcYQsyI5rS7Uqcb2Gm7DvigOcjBUvViDovhTxSR1BQF
         3jVy2kYTjY/Bk5H6b2OwYqZQug6Qvtcl4VTJfWIMqZscFByYqMJBpWMQs9iJOdA5IAQ6
         HJthhNLOL9f7fnySQo4/IYdQSjnk6O4d9L7gVvKTKf1t4XCm8BlH5WbId3Q3sqYcWBlp
         q90mIeeK7f6NPfmxV3SSxphCV64uBL31iO4XBXuq8w1kxJZcbIjCZlTdZ53xcIXhoj6V
         6uVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745209283; x=1745814083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0me9D7HF9QKBEL74pTv2jHUMZzDdUUcB3pHPjboOlA8=;
        b=il/x8hHExWaDdIzXZpCjCXTkxZB/Q0p0RzJC/xtzkfzbNdEE4qwFiKsXD6uiJvNC/7
         L5IFHh+5EQEg6UXRNcH/DevqJJQ1Mb2FCcj6MxsIafjVr8zmbM+W3apxRvL1g28wfLU8
         LgjNGdHt+rlys+jq2dwvY0ZDe/d63r2Fhk1wohCOAgfed1e2b+yI/3OEDEX9Eu8iReXp
         rjAJeB5oVmtG2us6ki2o5Ons5IJweGBJXy0pCQ0pc+Jt/bp3gFGd2RjLLZJOJJzQQhkq
         3eHslvzsCDHQUNhHd/a8PY1lA+aRwNFlMAg9nl29+VsppkBL4teNokiRauzbJ9P/58+N
         td/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhCMgtI9HVBkNoBavyQyDJF0Xi1UMWt8IuH5ku+YYF6uDy6X8kSzPijvHHmC+6I+wm6k0MdlFHNxrm@vger.kernel.org, AJvYcCVK6PiTmiMwtLA/BcqRg+mPv7EtJO781qEkdAzlOCYqOd9yfEYuadlZXZH7EMB+iM3rl2UvrwT+fGExtJM+@vger.kernel.org, AJvYcCVSic7xNrzzWXnRWp+7fhmt+o7DdLnW6xnSvzJrDgA4tKPXrCBIC+wXNxBIm+Wn0FO403I=@vger.kernel.org, AJvYcCXPHTUe3BoS6TWrxRZvdI5VR5OtJ+K6GptW5eN9JHARiU8W+ZoLLIw6pAHSERI/2y6jMxpgW0ZR1eva7FqiU81n@vger.kernel.org
X-Gm-Message-State: AOJu0YyVeHkb3ctv9170y4c2MJtnsz3G2APsWEquLyKUmjQT8319wC5X
	d7oI8PgiGMsaxMTnjOtI4DKZuuo7pTYNgJYc0R7GpIfNq4pj3Zbt
X-Gm-Gg: ASbGncuCVch5yxnuolDE5h2+10mjZXa3GY+C5EcTL21ELxHaGd85bWqSIsxIq2DZLH6
	kEf4zcYSBoKXvHTvUIR//q6EFDTz53cjtjMotTVjfsi4ytxOdlTOMf5wJOrN3LS+3163k2OAEhO
	LOyanT6dTuPD/dQgUco6s48oFGO2jrWyUQusyQ8Pi+Eev5Hs+pFq583THxVsSeERAUBEM+uYLo7
	mJ4aMZRX/kxNVZMldMbiMxUX/GcJGYAn+sWtJcOtD8I69QOPOg72V5AWN2Q4eTbNb2WqHsG6bt0
	kLM2jXE8DrQ3C+8rJMEodlKQQ9aEGGnF1OF81LC7xw==
X-Google-Smtp-Source: AGHT+IH79Tj+w/Pl9QMwoZKyI1uQZN8MFCC3AjIPOHkcRYSVHhFrWzIgCYG76qUDj6dV5c9OQxhHVQ==
X-Received: by 2002:a05:6a00:ad3:b0:732:a24:7354 with SMTP id d2e1a72fcca58-73dc14535a1mr13723334b3a.4.1745209283243;
        Sun, 20 Apr 2025 21:21:23 -0700 (PDT)
Received: from gmail.com ([98.97.45.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8e13b5sm5504194b3a.48.2025.04.20.21.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 21:21:22 -0700 (PDT)
Date: Sun, 20 Apr 2025 21:20:51 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Jakub Sitnicki <jakub@cloudflare.com>
Subject: Re: [PATCH bpf-next v2 0/9] selftests/bpf: Test sockmap/sockhash
 redirection
Message-ID: <20250421042051.ub5n5hn7rveosltw@gmail.com>
References: <20250411-selftests-sockmap-redir-v2-0-5f9b018d6704@rbox.co>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411-selftests-sockmap-redir-v2-0-5f9b018d6704@rbox.co>

On 2025-04-11 13:32:36, Michal Luczaj wrote:
> The idea behind this series is to comprehensively test the BPF redirection:
> 
> BPF_MAP_TYPE_SOCKMAP,
> BPF_MAP_TYPE_SOCKHASH
> 	x
> sk_msg-to-egress,
> sk_msg-to-ingress,
> sk_skb-to-egress,
> sk_skb-to-ingress
> 	x
> AF_INET, SOCK_STREAM,
> AF_INET6, SOCK_STREAM,
> AF_INET, SOCK_DGRAM,
> AF_INET6, SOCK_DGRAM,
> AF_UNIX, SOCK_STREAM,
> AF_UNIX, SOCK_DGRAM,
> AF_VSOCK, SOCK_STREAM,
> AF_VSOCK, SOCK_SEQPACKET
> 
> New module is introduced, sockmap_redir: all supported and unsupported
> redirect combinations are tested for success and failure respectively. Code
> is pretty much stolen/adapted from Jakub Sitnicki's sockmap_redir_matrix.c
> [1].
> 
> Usage:
> $ cd tools/testing/selftests/bpf
> $ make
> $ sudo ./test_progs -t sockmap_redir
> ...
> Summary: 1/576 PASSED, 0 SKIPPED, 0 FAILED
> 
> [1]: https://github.com/jsitnicki/sockmap-redir-matrix/blob/main/sockmap_redir_matrix.c
> 
> Changes in v2:
> - Verify that the unsupported redirect combos do fail [Jakub]
> - Dedup tests in sockmap_listen
> - Cosmetic changes and code reordering
> - Link to v1: https://lore.kernel.org/bpf/42939687-20f9-4a45-b7c2-342a0e11a014@rbox.co/
> 
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
 
For the series. Thanks.

Acked-by: John Fastabend <john.fastabend@gmail.com>

