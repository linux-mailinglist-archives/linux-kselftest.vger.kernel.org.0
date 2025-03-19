Return-Path: <linux-kselftest+bounces-29464-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CA2A69BE8
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 23:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07BC88867DC
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 22:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A20C21B9D5;
	Wed, 19 Mar 2025 22:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNvjWr52"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E3D214A7A;
	Wed, 19 Mar 2025 22:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742422690; cv=none; b=GEA8/y9O4VuExFO2MulXTQOlXMohAt6Xwsz0LosJrx3EJjhv+1XBKodhYpEMuxmwTYIUKCB0U/MQWgevrogr+pN8Yn6Bbk/0528e4T/Zq6iTqxBLVj2xcoxk17RtRvZZsBCjw1DtvNhkI6JRv7ErIbltIcmitPcIcrMmsUJWzxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742422690; c=relaxed/simple;
	bh=YUognYdZVDVKoNWdTzYPY6W8ESehC/hs2B/Ek/cAyZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpvpQe1Xt2aDOWJy3tbCLn/wDEoreMBM7+dEz/2QSo05UKilO4cEFdV5TZoiokQYAsx1/J9Gkaxaj6LrfHImw068i4y7F/7zhi6VVTQJ7cnfJ53B7vLfGgwNxnIBzALylsXnxsiB9idczgW+FIGHHHCDP1ei/jIFA6w9VWIFyXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNvjWr52; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-225df540edcso27453675ad.0;
        Wed, 19 Mar 2025 15:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742422688; x=1743027488; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u4D7n+2LppWRVXPYghpVBpyiFPmMtKDL9HM2hyc7IaU=;
        b=lNvjWr52iUu+YVqNbXyW7i989idxLoKF4hGshp7mJhMCg7aaBtQ8fk1YI6dHrLT+JA
         odyJUVSBuvH/AUs5t9w7QK3SQ1DgXo+yDlavkFun7Zaoinq4Y/2t1maa2aI/KJZE8BaO
         yN5c/AY4hvyDTCb+D8rJkIsT/gaELi+EwKK3XxGDkEhoxiR8+quye87oq90c1uEJH4am
         mbXs0kQ/GYjcg+b4Nk77KvYGpL40Iy6m3xgFHNuVka8rMogE8pNqg5WNEGDml0J3QF/7
         l36fhfeD8j6cadKFZ+7Uj6nEYoFA/4BoLROISnk3LVTD+xXb8itIhct+uUjvBJrpBj0g
         A05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742422688; x=1743027488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4D7n+2LppWRVXPYghpVBpyiFPmMtKDL9HM2hyc7IaU=;
        b=w7s9NxB3cjtDrLwsOmfam3jHr9fQoQxunU0JldeVfWdNQM8ZFAvigvOLjYwgljExZw
         ebxtU6KFBR73XHJNgINo6+dQZJpWhKr4PPUXcgZwGH2iL4Xb6Buo4PfoLKpNqVe/W/4J
         xsM8zY/yujLQQ9giyWojI/byO/qP+6WDiPyOK9MvUwjzY0JO46u333VGRDOOQqtV2RCh
         U2AqHQSWcMx1c+GCy2IzPWsUeAA4BPUWNDZ0Ln1yoY/jBokDkaUnjt8px2yyN7oUG0mL
         coNt2ieID7iOr87nZNElXN8leu0LGVChBA4USiN46lUZ+rK0wnkcdxzCAXTm6R6qCkyy
         YTKw==
X-Forwarded-Encrypted: i=1; AJvYcCWSZGVYSrcJWtIPcIlpDYouM+It8qHEaZTZzXxtWAAhob26ZgKBCVkgBiGNXRBUOg2z9FU=@vger.kernel.org, AJvYcCWbyH5m6A9Bi1zeroFnUjqswwOLqBmxP4QlYYJJQ2dI5lxPXyw6TIeJQQR+aDMWaakzAUMStL9d@vger.kernel.org, AJvYcCXCHYFKfCCgnnDqOPNBbtU1b0IJwOrilfIyQFqC0rl5wfrMM1CCm0FYDH1cUlaNUBiPvj1T6K3Ywk/R9d6q@vger.kernel.org, AJvYcCXwbDd+cPIrHhpTau5unwna2V/vZq/5EGkyvjCE/eB+cqHqFYlPAen6ThVib39jlOYwYvXqsYWBbPTyL2x2O/TG@vger.kernel.org
X-Gm-Message-State: AOJu0YyatGyZjukWPhQCwKnKuAubc+qL+4fPIqM+Jtn42fml50X0K5id
	qHK+lfZMjATzhhOPXodfzJriF8V9Urt1clRRESwuUwMrGWrVornO
X-Gm-Gg: ASbGnctX9jxzC5j81beLdCsvUlexHomu2F+tuAqXiH35t+G7m5+NroFVD0zlNhUEMlj
	9FPOAjehbIUU0PdsIqMsiQRzGFNrL1hcb0i3NUeGb3tXYeQjWIza144+nB6h/FvOFSqO1CF9hHM
	I7Xm2HOUJ7ScxiCSB+1B/VhJr56vnBDzeAUEpM5XXFutk46RjrxtDL9+P2hpCdHiCN12pYyJ8l1
	n+vjwowoLKtb30VAmn50y9U2ZqLR8MPnG4UmcelOFPtvPhTYQ7idmTY7JB7TS6zORbjPrcjYU2u
	3j/lJ9q0qy1neWqdbDB4Ydp4sL9AVBECrvG1C9DjvTdnhkCI
X-Google-Smtp-Source: AGHT+IGK0f2KkWnICFOc8q1r+oYDRZ2i3pe9qWJQ1JQu0L9prPZ3InQnyeIpr/0kzsZTnUAQx2nzGg==
X-Received: by 2002:a05:6a00:1249:b0:736:5969:2b6f with SMTP id d2e1a72fcca58-7377a0d85e8mr1620793b3a.6.1742422687959;
        Wed, 19 Mar 2025 15:18:07 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711695ae4sm12671807b3a.145.2025.03.19.15.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 15:18:07 -0700 (PDT)
Date: Wed, 19 Mar 2025 15:18:06 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v4 3/3] vsock/bpf: Fix bpf recvmsg() racing transport
 reassignment
Message-ID: <Z9tCnq0rBw+nETfW@pop-os.localdomain>
References: <20250317-vsock-trans-signal-race-v4-0-fc8837f3f1d4@rbox.co>
 <20250317-vsock-trans-signal-race-v4-3-fc8837f3f1d4@rbox.co>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317-vsock-trans-signal-race-v4-3-fc8837f3f1d4@rbox.co>

On Mon, Mar 17, 2025 at 10:52:25AM +0100, Michal Luczaj wrote:
> Signal delivery during connect() may lead to a disconnect of an already
> established socket. That involves removing socket from any sockmap and
> resetting state to SS_UNCONNECTED. While it correctly restores socket's
> proto, a call to vsock_bpf_recvmsg() might have been already under way in
> another thread. If the connect()ing thread reassigns the vsock transport to
> NULL, the recvmsg()ing thread may trigger a WARN_ON_ONCE.
> 
> connect
>   / state = SS_CONNECTED /
>                                 sock_map_update_elem
>                                 vsock_bpf_recvmsg
>                                   psock = sk_psock_get()
>   lock sk
>   if signal_pending
>     unhash
>       sock_map_remove_links

So vsock's ->recvmsg() should be restored after this, right? Then how is
vsock_bpf_recvmsg() called afterward?

>     state = SS_UNCONNECTED
>   release sk
> 
> connect
>   transport = NULL
>                                   lock sk
>                                   WARN_ON_ONCE(!vsk->transport)
> 

And I am wondering why we need to WARN here since we can handle this error
case correctly?

Thanks.

