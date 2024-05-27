Return-Path: <linux-kselftest+bounces-10735-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D779C8D092C
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 19:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14DED1C230C7
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 17:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5059315EFC8;
	Mon, 27 May 2024 17:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZ3lBe2q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC75E13AA5D;
	Mon, 27 May 2024 17:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716829616; cv=none; b=oTf6NYZuIrAcHvcCac1G+hnUqbpOEpBGvsDGGnrembQSr5iu/PQH1NWpp0VND/CCnnsK4WmxbVp2QVc6cZehCIxCaMr4bonBCokeY7bFQ4oARlaqqoBnJTo0VIIbG8kWSaRrV0/P+Zb/9+REXmr7ju9kiESrLcAvC0+2RvOrqKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716829616; c=relaxed/simple;
	bh=eBW8CryJaySW49MZHriV+5F1eEQmkbywsBa1law3vvw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=CkRwsc+P7N0IremL90MVWyBCes/1W8ruKBtu5TBUmeYpwIBZsCJeaT8GhtYpBFEI368+APahzhn+Cq8ilVzODKeUOPXmJbDzmjfSh12fQeviPBSwMAwuJcP57wXi7yWCE6i2DWQQRlz2N4dTbE9eqXlqe1xJI6GLodrnIX/RocU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZ3lBe2q; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2bf9753a00fso1316149a91.3;
        Mon, 27 May 2024 10:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716829614; x=1717434414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BiMW9iHeV0ekkTbm67XJ47xBiTBd/Oyx14PzxaakMyI=;
        b=eZ3lBe2q8dQ/KMS6skSDmRfuv0KDDwQkGVNOxj3n+1BSqSl6llDFej4P0GF82pVGXD
         H0B74ARH3oCiK98G+ZWKjdRsWuPjzOHRHeWneNbC5PycGRWPThH3QwQZUPULjwevcsXh
         8I3iPpOIwluvT2gHCCcffyfIABPdgT3/WYcME7R6tqe0ztlo3uZ2QpVbrZ92JIPd48pm
         Ne78dqnWoxByaNRhTRQq1ntsTcjZ8lhbvGvBs5uROU/dNcm6J0S1HUFUWBDujHMhoRcn
         GsGoCGyNuW/31lueqgrX1ebg1kUu/s4EG9tAF4DRqTVRPgTAUgyyjUIIBxKE79sqGbVj
         1KCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716829614; x=1717434414;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BiMW9iHeV0ekkTbm67XJ47xBiTBd/Oyx14PzxaakMyI=;
        b=bECRDi/G0kx7DbNfLvxurCvsz0yzb4ROg9Z6UxhTmX+RDnDvIPWkEATSAVIX45uKqE
         JuUw70P7McS7NQuhymnRWy9SR+JxWxmbeyw0LEdRWqtmYujYtCh8TdfE2/zWXhVorUhQ
         CYcP9P/WUAVgoUmX4hDAH8kZNXECjUzscD0fES1YNYDIsvrhNRVMoN5YOuBaZQnRf+Ya
         73nWhNMmdHgM7OF15GWlIxvrWOFRt2BV9U2Mvcukqt33YLJqCB1r24RV6jf66SZfcQHV
         op+LD+fJdDv1WaSQzACvpoRG6z7C9bC1Ol5RVzUEjgxC4ihzGCyobTfmQJtJmreERsGe
         fzGA==
X-Forwarded-Encrypted: i=1; AJvYcCWadSvf6o6+wPT3ZnfhHn7dtyRrh7lUACMsgyIVHCFee25WgTRDpjwBJmpcd7TMacs3v2A5Jnmep8D3zoZuiTQFkO0uXmNISl3ArFyokTWJYx2kvr6qwH+YvS18Hp1+VsTpFsHz
X-Gm-Message-State: AOJu0YwbDCDhnTj4hF8/FNCUG0mTNSYsL4BN25aJxYX3nRs+oZL0/PyC
	kojMiXZO0uhAybAtl4zLmfzQlkmCAxs5vFIFxMkqq3JQV1uuCk9Z
X-Google-Smtp-Source: AGHT+IHxuJuqXsGC0VcydiEh3ngFFwVuVUIL3AmcxKFYKI39WrFOpIK+7B5D8Xmgr01KWEJUI2a4Hg==
X-Received: by 2002:a17:90a:c698:b0:2bd:92d9:65ee with SMTP id 98e67ed59e1d1-2bf5f85dae0mr7536038a91.45.1716829614339;
        Mon, 27 May 2024 10:06:54 -0700 (PDT)
Received: from localhost ([98.97.41.203])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bdd9ef0b00sm8738657a91.18.2024.05.27.10.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 10:06:54 -0700 (PDT)
Date: Mon, 27 May 2024 10:06:53 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Geliang Tang <geliang@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, 
 KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, 
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, 
 bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Message-ID: <6654bdad22f0_23de20845@john.notmuch>
In-Reply-To: <ea8458462b876ee445173e3effb535fd126137ed.1716446893.git.tanggeliang@kylinos.cn>
References: <cover.1716446893.git.tanggeliang@kylinos.cn>
 <ea8458462b876ee445173e3effb535fd126137ed.1716446893.git.tanggeliang@kylinos.cn>
Subject: RE: [PATCH bpf-next 8/8] selftests/bpf: Drop duplicate
 bpf_map_lookup_elem in test_sockmap
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> bpf_map_lookup_elem is invoked in bpf_prog3() already, no need to invoke
> it again. This patch drops it.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  tools/testing/selftests/bpf/progs/test_sockmap_kern.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_kern.h b/tools/testing/selftests/bpf/progs/test_sockmap_kern.h
> index 99d2ea9fb658..2399958991e7 100644
> --- a/tools/testing/selftests/bpf/progs/test_sockmap_kern.h
> +++ b/tools/testing/selftests/bpf/progs/test_sockmap_kern.h
> @@ -177,9 +177,6 @@ int bpf_prog3(struct __sk_buff *skb)
>  		return bpf_sk_redirect_hash(skb, &tls_sock_map, &ret, flags);
>  #endif
>  	}
> -	f = bpf_map_lookup_elem(&sock_skb_opts, &one);
> -	if (f && *f)
> -		ret = SK_DROP;
>  	err = bpf_skb_adjust_room(skb, 4, 0, 0);
>  	if (err)
>  		return SK_DROP;
> -- 
> 2.43.0
> 

Acked-by: John Fastabend <john.fastabend@gmail.com>

