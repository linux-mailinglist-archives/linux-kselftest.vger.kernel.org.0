Return-Path: <linux-kselftest+bounces-10734-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B4D8D092B
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 19:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C3C31F21E2F
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 17:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE1315EFA2;
	Mon, 27 May 2024 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cH8CTLKb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F07313AA5D;
	Mon, 27 May 2024 17:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716829597; cv=none; b=fwQkeeyfliUVNron9PxvMR9YgIC2zW2KzlHgmMMm5KhmMMumcKBhIcCerFODgeeF4jz3xWxZyNqb3qYBhYN46mc2KjBJgDsHuyPmmLAvDgyfcz6K6csVTova74fs1OZ3QGGMY/VK7SPUD0f+PRseeNMoOH0S6/M1u/oco7Fa55Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716829597; c=relaxed/simple;
	bh=pEU770YGmgCdLL+8XtLRFJqaPVPI5U7j0aHXUn634G8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=uSuB47SkHn7AHKJzZAG0BsYccA/c/vP5j+eE8HBO+ty1Ryv7/uoJfzXuebJ3AetLHiykG2grpFIeoWVgIg2M+zeGLNlDX4SgvE5wCx40rXo8NmtIkFJnGjCbGDlVmTf34xIol4+rX/6cFQtUPrXShXttIr0LHR5zl8jzr2SL1+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cH8CTLKb; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6f693fb0ab6so6292065b3a.1;
        Mon, 27 May 2024 10:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716829595; x=1717434395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rh2jeUFWdkWRIBAmTTD0Pft+tCV0EnYgOCapUQoZ4jU=;
        b=cH8CTLKbgNSxC8bl6N9rlMQUOLNGIFnf6aPMHHkbxn2NQIj9QT5b1+1hLHDrZ3sraQ
         LUrwXeFmn9fcaVWCgt6s62eBP5IKBVehhSdaqqzzfohn/W0KaccaPuNW5XXMiyIzL7cJ
         LwJ9gOiH1LovanE3jltna+sVmeWwE/4bpSfUtua5KbPCT55Bw352pyrzOBZVqBcjHPDK
         X665rq/kHmjXcpDz9pDBugntLAFbbmVfQ30t7OqG8HosVX8aS1VI+Zq78atXgLKXQmI2
         zOXlar2Y1XKX5z95gJQrGQ2Ley88EK4xdYPpZ5H6jUXbtKIv95PFgX5VORTYP/8f2vO8
         wnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716829595; x=1717434395;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rh2jeUFWdkWRIBAmTTD0Pft+tCV0EnYgOCapUQoZ4jU=;
        b=lxxqylxzFti3gqlk7hOnI7HlM1xMkR+MTO4pW3Ck9svF7kKFEd7cjbNI2Ko0SamJBW
         IJ0FgSJWE5B0ANr4zoA2gAeRzP4yFuhmhskh8jUFw8vs54Z5knUoTQoMFhbE/IBu0bMP
         7FU8+z1b+bPqGy7hODAZRCnTpQ1BvayI/Adsr1BomorbqRjtwVEIgPbZtcqXQCMNkDeK
         AtG24xkaYaHV5mkZsnOIIqarQV06H0XEaIaQEwmzeRlEfLggRL2KCRg1xl5Ib4kpLOkK
         3f1/xDPC+4O74HCqJhpmrh8uQH6YyQIl0gUbbYuXJA/qWeA9XCvVaqWu+YrSFuM1hBxx
         J2Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUqY84ztZtpM0Lf325Dt/VRKB1c3fJU66C5yvAfGC+3xbsyM9cs4/Qq94sjAr+rVNs3rrHXR2c18jSkkyQ6NMjRSPtxcZre+miFSfolRR1ZDjFKCP0WE4NPL+1+kE4SSaBCYyJs
X-Gm-Message-State: AOJu0YzMiW+TCvH1eN1che/MbFwDB/h1t+89GlkcpLnILnmZpugDu1qv
	k1qcLMqEgTZ6yBrNM2lsl+iy5YnMQW0P1J0u2psfAo3IZuwBSxYJ
X-Google-Smtp-Source: AGHT+IGihj1Xslss4sPLg9nO0ADTL9P2bO47ezQwuoQwO3GBRmI7t5t4hewDGaCx36pQyYTFtnf1Bg==
X-Received: by 2002:a17:902:d4c4:b0:1f4:a36e:8a83 with SMTP id d9443c01a7336-1f4a36e8e77mr29625475ad.43.1716829595424;
        Mon, 27 May 2024 10:06:35 -0700 (PDT)
Received: from localhost ([98.97.41.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c7d2f36sm63293675ad.119.2024.05.27.10.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 10:06:35 -0700 (PDT)
Date: Mon, 27 May 2024 10:06:34 -0700
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
Message-ID: <6654bd9a46bd5_23de20826@john.notmuch>
In-Reply-To: <5172563f7c7b2a2e953cef02e89fc34664a7b190.1716446893.git.tanggeliang@kylinos.cn>
References: <cover.1716446893.git.tanggeliang@kylinos.cn>
 <5172563f7c7b2a2e953cef02e89fc34664a7b190.1716446893.git.tanggeliang@kylinos.cn>
Subject: RE: [PATCH bpf-next 7/8] selftests/bpf: Check length of recv in
 test_sockmap
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
> The value of recv in msg_loop may be negative, like EWOULDBLOCK, so it's
> necessary to check if it is positive before accumulating it to bytes_recvd.
> 
> Fixes: 16962b2404ac ("bpf: sockmap, add selftests")
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  tools/testing/selftests/bpf/test_sockmap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
> index 3654babfac59..4c7cb206b31d 100644
> --- a/tools/testing/selftests/bpf/test_sockmap.c
> +++ b/tools/testing/selftests/bpf/test_sockmap.c
> @@ -681,7 +681,8 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
>  				}
>  			}
>  
> -			s->bytes_recvd += recv;
> +			if (recv > 0)
> +				s->bytes_recvd += recv;
>  
>  			if (opt->check_recved_len && s->bytes_recvd > total_bytes) {
>  				errno = EMSGSIZE;
> -- 
> 2.43.0
> 

Acked-by: John Fastabend <john.fastabend@gmail.com>

