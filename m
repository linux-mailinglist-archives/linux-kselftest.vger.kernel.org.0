Return-Path: <linux-kselftest+bounces-22967-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F06959E8B27
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 06:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEE6528111E
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 05:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180692063F1;
	Mon,  9 Dec 2024 05:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCJYHPuC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F712063D7;
	Mon,  9 Dec 2024 05:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733723261; cv=none; b=kGJHR/SsFsr6Dd7nWKS/M3lbfLAHEkpL6XRwevBKkFztIGjg8Z2bxdrKZbOMnv0OR51a8tOrudpvi9m45DQ/pKZpzo4mgl0VBBeCKsKhj6A3u6wV8MFU8hYWGlu0qxvsnuKH1EJiNOP4+aLJyS3FylMFHhMTJ7fetnBw+t8le7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733723261; c=relaxed/simple;
	bh=kwjtclmgfmugmEFlH6X5T8hfUwNrUkwmU1L96m3Y5CU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=o4+T6fY/j8m022pjK8/m8jn59dqvzA6644Gkc95BbKvb7iGT/yBu6Z+xOZvMVQzHt8kJpbClXj+Irjly6Vn4g7D9qXDxJnEe6f3hLn6pcvbiqMwh7KJd7hODppo6uoZADYItL6MTCj95fdmJf+wSPS5inIN9EmPLsrPH9xf3/60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCJYHPuC; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-215770613dbso25278475ad.2;
        Sun, 08 Dec 2024 21:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733723258; x=1734328058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+iVONp1bemOOkjT/n7EkSCEGBeAYMzJrereun6Nd8c=;
        b=LCJYHPuCpPZfA/2KuD4Sm+k9UIWta8vJOHNS2vk1kSpxajlgma8uwENQhqw2LoOayA
         gILVCnfHEIZugWTrKGrbgppiXtfGLOlG32yYBWDHW+7HyDTE97vVB3TGfuRvUqA3CGAK
         sNEuQ7CSAQq88UIrDxPtVdXhrDKPGcP3W24tyuTYwdgs4QExYhT4RqdJVkrd0yDgXMac
         KLk5wclOX9XptZGsQIoyIV5+pEeGgM0bzVYoIonhK4YDSfNS3w/FlVYI06o6s84wOcSV
         /ZfhoNcH5w/l8Xm2qfMwDqg9JbgKG6gWKD6Wk2Jr9QbdihpGOEOV72DTdbb4jH5P5kBq
         NXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733723258; x=1734328058;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B+iVONp1bemOOkjT/n7EkSCEGBeAYMzJrereun6Nd8c=;
        b=GzX5t/0Ruajqm+/2X7HIk3LgNKy9qDaO6aE4YIDPORllc2cnlO2vylIxRfGJW6j2TV
         Pr6To2ayKPJ5I98FjRp/XkluaIR/q6ByBWuSwzkeE2ICQdrf4Vp3sjXvTQQYWorKFmh+
         MtV3Rju+yIxrnlKN3VytNWDDTgtpF6b/YmIDrNB82BNHCCOmZSUzNkJsOq3St1avx2Vd
         wBLj13fbDHI3WCO9TkkrjkD2K7rsTqFIHmyr+zkg6RaBhuG6c3r66LalTI2xAh0ySu23
         fdZPedndMD2w3WBQ9FQur6yZVZd89Fpovyo9f5ugZV70lQkAmpqvMG+c6017j/keBga2
         jq0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUv6iYoWW6bfbQAIq2OkXUXCVJDeWjUnasWTc7yz5P6tkioAFSezXbaME6q0LAFZzfVasmUOeRiPHxcaC4v1c8=@vger.kernel.org, AJvYcCVgpVsuE+ul0fEKJgq4LAqB1BogMtB5C2Azvim+cvDo8cD5loeocZcmL2iuPBokJJwtNvkjYR12@vger.kernel.org
X-Gm-Message-State: AOJu0YzEw1IpmHPmvUjtY7gTPr4teekxY3fVAMQDx/ShTvuVGLwl8IDU
	5szdeRXircw/wbao52PPG1/bdWIndWGPB7yGTDY0WJcnk1a8gGTz
X-Gm-Gg: ASbGncvM/5n+oOG+0Xlt/JVd8eszVzsmVRcVZuJRB3MUxrjCEXJyPiCjx7WjIr/V0tK
	9nZDAeDNvwh0oyCTV7/DABZYym6OyxaNlhd5QBtvnleuOHuO0njTuwkLfJ/6jvdwP3cXjQBWcG6
	mD18lrGyhnDa1O/L4oIDGvmNa1EEFJPPumx/skKR/Ky3TJKrj/FLIO6iws7GVfatpwek2Av8muk
	ZEG9HmJu3CkcwHKOtAmysS+xF75egVebUjQD9AJz6LsVvJ+Ra8=
X-Google-Smtp-Source: AGHT+IH3TB1M3EYXQFyQ0vOpAYxhOjsfrL4CUMwiHNTW6xuCQCu0g5lKcbijP8BXnDeb4TrN4r+rYQ==
X-Received: by 2002:a17:902:ce83:b0:216:50c6:6b42 with SMTP id d9443c01a7336-21650c670ffmr40365835ad.56.1733723258463;
        Sun, 08 Dec 2024 21:47:38 -0800 (PST)
Received: from localhost ([98.97.37.114])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2162b13d486sm32392125ad.191.2024.12.08.21.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 21:47:37 -0800 (PST)
Date: Sun, 08 Dec 2024 21:47:36 -0800
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
Message-ID: <675684786d66c_1abf208ea@john.notmuch>
In-Reply-To: <20241202-sockmap-replace-v1-1-1e88579e7bd5@rbox.co>
References: <20241202-sockmap-replace-v1-0-1e88579e7bd5@rbox.co>
 <20241202-sockmap-replace-v1-1-1e88579e7bd5@rbox.co>
Subject: RE: [PATCH bpf 1/3] bpf, sockmap: Fix update element with same
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
> Consider a sockmap entry being updated with the same socket:
> 
> 	osk = stab->sks[idx];
> 	sock_map_add_link(psock, link, map, &stab->sks[idx]);
> 	stab->sks[idx] = sk;
> 	if (osk)
> 		sock_map_unref(osk, &stab->sks[idx]);
> 
> Due to sock_map_unref(), which invokes sock_map_del_link(), all the psock's
> links for stab->sks[idx] are torn:
> 
> 	list_for_each_entry_safe(link, tmp, &psock->link, list) {
> 		if (link->link_raw == link_raw) {
> 			...
> 			list_del(&link->list);
> 			sk_psock_free_link(link);
> 		}
> 	}
> 
> And that includes the new link sock_map_add_link() added just before the
> unref.
> 
> This results in a sockmap holding a socket, but without the respective
> link. This in turn means that close(sock) won't trigger the cleanup, i.e. a
> closed socket will not be automatically removed from the sockmap.
> 
> Stop tearing the links when a matching link_raw is found.
> 
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---

Thanks. LGTM.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

>  net/core/sock_map.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 78347d7d25ef31525f8ec0a755a18e5793ad92c0..20b348b1964a10a1b0bfbe1a90a4a4cd99715b81 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -159,6 +159,7 @@ static void sock_map_del_link(struct sock *sk,
>  				verdict_stop = true;
>  			list_del(&link->list);
>  			sk_psock_free_link(link);
> +			break;
>  		}
>  	}
>  	spin_unlock_bh(&psock->link_lock);
> 
> -- 
> 2.46.2
> 



