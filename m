Return-Path: <linux-kselftest+bounces-22969-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 085FF9E8B5A
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 07:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6B11885ACE
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 06:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24607213E8A;
	Mon,  9 Dec 2024 06:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hr4ihsZ2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8695616DEB5;
	Mon,  9 Dec 2024 06:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733724691; cv=none; b=XlKJYIqaSWfyV+r4qE7rUG5m0wXIBGWxrhLTitKn1vmsmqmI8Xlh3ZGwp7mOHA198Fjx0YBI5RycaOTGm68UG8heEpIN10tqqHTY59UsDg+P+diGaOkqjGwziMhDGoLHYPsWXXe31MCVTXzkISL7yuOZlZwhey2fD47udi5Qiv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733724691; c=relaxed/simple;
	bh=uWhiM+/cVZ+gZtMPzxGcN6fFIQWwYSzJU8wU6/NrLM4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XFFxe6NAB+FK6lMBng7MWm9T31K4+wfM8IUDTPt/SH9+AnhnJwz1wl4I6dMJf+P7GWSD8fEnkTv2U4sAQ+yznhD5U9a1ntEdlum9tA1k1SNdJ292yqNQ3GjMu8aaiUvAtFr1QuDBJMoXJbMHvpcrmXoSvnAg7PmS/BGPud00eOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hr4ihsZ2; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-725abf74334so3336778b3a.3;
        Sun, 08 Dec 2024 22:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733724689; x=1734329489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0Dr18ok2Bwr1dMchDb8ArapEa4jmdw3PhKJpSV2ky8=;
        b=Hr4ihsZ24sMHXs4+qJsfYkG1SmnZSSagiHafDeth6ahrleft7MErLw2vwxrNIeDZHf
         PBDthx8ol4Mgj9cjhvXmDxnN1VcYuwZiWQ/+H5b99okXVD0JI2vHNLzWtXM+pBHlltHN
         QyuvfUgcwe62H/YbLylEly5rk7zfO6CqFTN9Szw4PusFgvxi35jB9IX+C1TvnNk6x9tE
         j/yl0jqgnpaw6QLOzyicJE4UrxR3JdG2a4vbwBhvLPcPyt5fd+JUptlntf4N3MTvXP8N
         wijicivmhD+jPzrOeo4FZf85WRFByjY2tjlM5KjpRO0jKid/E4KFmbrc7jONZjjgaA0S
         RO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733724689; x=1734329489;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U0Dr18ok2Bwr1dMchDb8ArapEa4jmdw3PhKJpSV2ky8=;
        b=esSc5nKfP+QNeC/lpuzReWIlFiABjOcx0PoCZZcfEIVZT0BnQD1IAmOY0S6RD84qYP
         Uq3AndS+S8rmuyayqdOf1D7YJuj9I5SNGovU7hPbXpanN6qTebLeIuj9YpKdrO/fZnVY
         kAXVC0vqCdLPev+VOXTv6UViDPQMI7URUuUuFk0rZ5RCd5ADC3qWA+imYRmp3SPNnhxw
         iKYDn7Pbq6EnC4zfXtvlPT3H/rGOuGBQVvaL5dhsXmhV1cXnMW/602iMyadSoEipz50T
         QkBhCOyChahXttsMYqcWkOex/bJIPZ7wFlyNXbLaVYjDLeZkK/bCn7nULrsogb9nsnF1
         dWBA==
X-Forwarded-Encrypted: i=1; AJvYcCV9rZaOgHjxNAtN45mMcwohlAaSZw74sns+cLPFd1piEFqFeVMeY7LI+2NdG3rRGI9hoZrl032d@vger.kernel.org, AJvYcCVHWVirEjGhzMrYeZdFNkSXRHACSQYPqE6+jDJ3F6bI874ECD804/VTOnO/A4uBGuVT1G2zjUKAgmbN9xE5fbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbuWyQXDN4jNY01n3B9aGCybky/MdGOvcnf48+2RS8ZgMVdvqn
	inlN0nOlDG0iwtm2TOnc8tQaigLNI8m5oLIE4GCugGvCchL0wjNC
X-Gm-Gg: ASbGncsnUtxOQbnv01o5BIubqhhDUJL4PB26/vmSqCJLSarNXS1fVA9vAyp4jyrn89a
	YcOtrmKtfdTOw76B9ipBNU6op7NCXEXINdTp98ufW3QYuLM9pK8r/PzPjwPLZ1bsgl258omNU1H
	7oLnEQexllFTkoRvUHPjLmT8rJOtFlbmvu9Es1vIWNJlEuJtQ1kxWOPg0QQgNZ0HfE02SgcFoMD
	xkJE4ja6M6rihyUcDS+5qiJUIuCJd6djMJBiackgdQuKvV6s48=
X-Google-Smtp-Source: AGHT+IFMQfjWG8+hq0DsREnI77EtruDQsGNSS2eOzaYid2+5l3TTbMj5s/XqTwPKfy6itOzuf3pr4w==
X-Received: by 2002:a05:6a00:a90:b0:725:f153:22d5 with SMTP id d2e1a72fcca58-725f1532457mr1897792b3a.18.1733724688664;
        Sun, 08 Dec 2024 22:11:28 -0800 (PST)
Received: from localhost ([98.97.37.114])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725c9ec7217sm3888129b3a.60.2024.12.08.22.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 22:11:27 -0800 (PST)
Date: Sun, 08 Dec 2024 22:11:26 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Michal Luczaj <mhal@rbox.co>, 
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
 Stanislav Fomichev <sdf@fomichev.me>, 
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
Message-ID: <67568a0ed36d3_1abf20818@john.notmuch>
In-Reply-To: <20241202-sockmap-replace-v1-3-1e88579e7bd5@rbox.co>
References: <20241202-sockmap-replace-v1-0-1e88579e7bd5@rbox.co>
 <20241202-sockmap-replace-v1-3-1e88579e7bd5@rbox.co>
Subject: RE: [PATCH bpf 3/3] bpf, sockmap: Fix race between element replace
 and close()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Michal Luczaj wrote:
> Element replace (with a socket different from the one stored) may race with
> socket's close() link popping & unlinking. __sock_map_delete()
> unconditionally unrefs the (wrong) element:
> 
> // set map[0] = s0
> map_update_elem(map, 0, s0)
> 
> // drop fd of s0
> close(s0)
>   sock_map_close()
>     lock_sock(sk)               (s0!)
>     sock_map_remove_links(sk)
>       link = sk_psock_link_pop()
>       sock_map_unlink(sk, link)
>         sock_map_delete_from_link
>                                         // replace map[0] with s1
>                                         map_update_elem(map, 0, s1)
>                                           sock_map_update_elem
>                                 (s1!)       lock_sock(sk)
>                                             sock_map_update_common
>                                               psock = sk_psock(sk)
>                                               spin_lock(&stab->lock)
>                                               osk = stab->sks[idx]
>                                               sock_map_add_link(..., &stab->sks[idx])
>                                               sock_map_unref(osk, &stab->sks[idx])
>                                                 psock = sk_psock(osk)
>                                                 sk_psock_put(sk, psock)
>                                                   if (refcount_dec_and_test(&psock))
>                                                     sk_psock_drop(sk, psock)
>                                               spin_unlock(&stab->lock)
>                                             unlock_sock(sk)
>           __sock_map_delete
>             spin_lock(&stab->lock)
>             sk = *psk                        // s1 replaced s0; sk == s1
>             if (!sk_test || sk_test == sk)   // sk_test (s0) != sk (s1); no branch
>               sk = xchg(psk, NULL)
>             if (sk)
>               sock_map_unref(sk, psk)        // unref s1; sks[idx] will dangle
>                 psock = sk_psock(sk)
>                 sk_psock_put(sk, psock)
>                   if (refcount_dec_and_test())
>                     sk_psock_drop(sk, psock)
>             spin_unlock(&stab->lock)
>     release_sock(sk)
> 
> Then close(map) enqueues bpf_map_free_deferred, which finally calls
> sock_map_free(). This results in some refcount_t warnings along with a
> KASAN splat[1].
> 

[...]
 
> Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
>  net/core/sock_map.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 20b348b1964a10a1b0bfbe1a90a4a4cd99715b81..f1b9b3958792cd599efcb591742874e9b3f4a76b 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -412,12 +412,11 @@ static void *sock_map_lookup_sys(struct bpf_map *map, void *key)
>  static int __sock_map_delete(struct bpf_stab *stab, struct sock *sk_test,
>  			     struct sock **psk)
>  {
> -	struct sock *sk;
> +	struct sock *sk = NULL;
>  	int err = 0;
>  
>  	spin_lock_bh(&stab->lock);
> -	sk = *psk;
> -	if (!sk_test || sk_test == sk)
> +	if (!sk_test || sk_test == *psk)
>  		sk = xchg(psk, NULL);
>  
>  	if (likely(sk))
> 
> -- 
> 2.46.2
> 

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

