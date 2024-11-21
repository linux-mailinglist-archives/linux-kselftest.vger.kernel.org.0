Return-Path: <linux-kselftest+bounces-22428-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383FE9D5630
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 00:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1050281615
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 23:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC1C1D90BC;
	Thu, 21 Nov 2024 23:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzRynrtC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0624E1BBBDC;
	Thu, 21 Nov 2024 23:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732232053; cv=none; b=LWA/lyuJqHbUSEw6r2liY4uIMGntcaoW0W3uL7KiNuslOvt9J+9hB7WjM0/+DByy6JT0FZ2554iMcBW3gY33aDBOrklHVYRgYakJ5MLnmmItKb1gWLOQA0t4kNuCMAegggyJXotUYKiHE8RtGiKvqslp01Cic0zo3zzWG+pf/Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732232053; c=relaxed/simple;
	bh=qdLMV8zGkvT/QtA/r+qtvK3bWoQ/glpHCnqXfNcoVvA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=dVZ2WMWTgwcN0+Uul8QlKjhjywvkWtdnR4lEKf5/BpWJ3mr9gxTDGv1d1jODjppf1wYvXUNq5yXEdifWySDmtqB3DzHZh9WdHZ5gAJbBHx24IBCcaUr/WubSqtYFjDlomdOy3qVOhKpRFO7/X9uP/WWE2W/bJksfrPr09T99gQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzRynrtC; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ea78d164b3so1291085a91.2;
        Thu, 21 Nov 2024 15:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732232051; x=1732836851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUac66YlDe4DsE8EEWH0kHICeDsnP4YHiVPJ73sgToc=;
        b=RzRynrtCHnsw7N9bgr/dp5/VkGRt8lKh5NvACjzDna3gVXwP5c4dYXMmiANzcQDptX
         YsQ9BsMTAJXv7FNZWKldi8/rrv2itdRa48iU7uJjyaO8TS5iGDgkNWoByzGLtNfAbvZc
         OixTg5UsKdfWe6zyBZGt77uIIrqfg2UMeM/Ss/t/0s/wLTI8ECnW13nBYFNsYW3lyJ2Y
         oFTvRYEVacRF9ZXKpeveZ+bqR2d+gDCyY4R3hGEeUalA/D/czIgUrVpfyyrtXMUeml65
         ol/2rzp4pS/u0KOKtcNkvhMtsPrptQ+vRG/+FTWbcVgbiuGRUtOipi8Lp+NVDIdVSzyn
         nq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732232051; x=1732836851;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sUac66YlDe4DsE8EEWH0kHICeDsnP4YHiVPJ73sgToc=;
        b=e6ZBpVwCzowMQqvdQoVnkVILtWX649zZ9whGFZLxUMmyVpUisdiJnxb12ysI/HCVrj
         3xjmH+uXgFWVGRYk7PDglR8QwVdpbIMhvXSbENNBTQeSE3bhIvJqj/2Bmt7SyYBSsqFQ
         vtkv8df74w4wTuH+ENkzSKdrsQ6Ex2sQmH9FyWEIPzBRylpwvnyDpsojfK+YSACqfIZg
         u5bCdWK1EPlyiee9DPd1bMxmjj2gKMBquCynp24UMZSz+gXw+kmDkG13DPB9MZPUxDnB
         Z8CKmYgX934jDlsdfpCLPXIJVZjNOCwpI7Bp9wCae8B22L4ciMTLu/FpbdZYYLsyMWhe
         fFYw==
X-Forwarded-Encrypted: i=1; AJvYcCUTGWEveDWIe51UqMqu0KOmjP2wUc+y2rqxRH4laoQ2Hb5cqr6B/xJSRxBUOClTcIcgAZLMnYiK@vger.kernel.org, AJvYcCW+iBcFrL5bAN/RT6MxgyqTvrZf73tW1jmpmLA+EJLXbuGQs64p4mH8XMJMwi5e3dHBG2k=@vger.kernel.org, AJvYcCXgTKAOEjc6/gVZgg7RLY7NFig2VR2mdv7wmUiNWeh/Fzun146j36c3Jy4JQcddbDw2D0+jdEWoW6N5L/c6lyoL@vger.kernel.org
X-Gm-Message-State: AOJu0YzkZMB/n7prZjh7SydNj8C2ID77FJsOTTSYObVCW8E/M8FKODLK
	G5JL8vQJSscyFdw0g3aot7qr23qrm+qbI3FeW9065bNrmQwG7X5d
X-Gm-Gg: ASbGncu2y9bmwEEs1BLhfDAbfZymCjhYypFik3FyL4tj5s3wSawiV4MngWmJ2K9j4SI
	DqCr2H+6p8P8Q1uNChHcNOTFYq4F1TXa9q+IidYJp4/nK9fCTbalmBpMGc9NCDtYgd9N3IypIlh
	wuwtmCFSV91OGiqZ25jSecO18Wsitrwm0zIIyVXFBwOnX1mILPKPU2JWocO9nhvAkuvmJgXvu8H
	BMndc2NJNU5Npls5Sk30F41uUAF8/aO7SEvrxVBYkAoWV6JcC8=
X-Google-Smtp-Source: AGHT+IEkytm/0Te1RFpMjsSqr2S2XW50TP0rS/sdJu/aDq05wk1ZduEAst0IkX1ljEDoqogYVHMagg==
X-Received: by 2002:a17:90b:4a47:b0:2ea:3d61:1846 with SMTP id 98e67ed59e1d1-2eb0e86b6a4mr738871a91.26.1732232051137;
        Thu, 21 Nov 2024 15:34:11 -0800 (PST)
Received: from localhost ([98.97.39.253])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc42262esm265604a12.86.2024.11.21.15.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 15:34:10 -0800 (PST)
Date: Thu, 21 Nov 2024 15:34:09 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: Michal Luczaj <mhal@rbox.co>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Bobby Eshleman <bobby.eshleman@bytedance.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>, 
 netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Message-ID: <673fc371c9de1_11182089c@john.notmuch>
In-Reply-To: <dpt2h73fnzgzufuvilmaw5lbs2nydc3572xqn4yoicateys6cb@reuefsarvhka>
References: <20241118-vsock-bpf-poll-close-v1-0-f1b9669cacdc@rbox.co>
 <673ed7b929dbe_157a2089e@john.notmuch>
 <dpt2h73fnzgzufuvilmaw5lbs2nydc3572xqn4yoicateys6cb@reuefsarvhka>
Subject: Re: [PATCH bpf 0/4] bpf, vsock: Fix poll() and close()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Stefano Garzarella wrote:
> On Wed, Nov 20, 2024 at 10:48:25PM -0800, John Fastabend wrote:
> >Michal Luczaj wrote:
> >> Two small fixes for vsock: poll() missing a queue check, and close() not
> >> invoking sockmap cleanup.
> >>
> >> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> >> ---
> >> Michal Luczaj (4):
> >>       bpf, vsock: Fix poll() missing a queue
> >>       selftest/bpf: Add test for af_vsock poll()
> >>       bpf, vsock: Invoke proto::close on close()
> >>       selftest/bpf: Add test for vsock removal from sockmap on close()
> >>
> >>  net/vmw_vsock/af_vsock.c                           | 70 ++++++++++++--------
> >>  .../selftests/bpf/prog_tests/sockmap_basic.c       | 77 ++++++++++++++++++++++
> >>  2 files changed, 120 insertions(+), 27 deletions(-)
> >> ---
> >> base-commit: 6c4139b0f19b7397286897caee379f8321e78272
> >> change-id: 20241118-vsock-bpf-poll-close-64f432e682ec
> >>
> >> Best regards,
> >> --
> >> Michal Luczaj <mhal@rbox.co>
> >>
> >
> >LGTM, would be nice to get an ack from someone on the vsock side
> >though.
> 
> Sorry, is at the top of my list but other urgent things have come up.
> 
> I will review it by today.

Thanks a lot Stefano much appreciated! I was also slow to review as I
was travelling and on PTO.

> 
> Stefano
> 
> >
> >Acked-by: John Fastabend <john.fastabend@gmail.com>
> >
> 



