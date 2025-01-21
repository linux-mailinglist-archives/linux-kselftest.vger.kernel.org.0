Return-Path: <linux-kselftest+bounces-24879-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8D4A17FA5
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 15:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A5593A678E
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 14:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C191F3D38;
	Tue, 21 Jan 2025 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="XaQ3qI7R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDF61F37D1
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Jan 2025 14:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737469386; cv=none; b=cSuR/uhxo/I3ZKO7f7A6Rm6HGwNi+TvSvXGrVUi+TomJ6wQR6yg83FOzFmTSAGlx2IyTcJhpXyIEqcGJctIXxRfcUsgw5uuoDVAJoBUFyTMlCYiYr0OgRA8nh60NPeBQmMiyRadl/U9ypQukCpR1NketJgBVLAVrw7mBJyxTpog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737469386; c=relaxed/simple;
	bh=8LJL8YLTQX6WSmYSPdyTL4xFCKtXqCuDdTieXU+HLvc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NILPMfsNX4CNpxapQe4D4Gtb7pyfDreldnxTqCQ10ICVLWB0YYTJm9tK0B6FfcCuroAksN4qo0ixNeZF5qh2vQN4L6WXC4dt7VFE1LalN4UkKbTZ+OsYznhuc+W6snJbB98L+D0r6UOzhBGTFmf5LGNSxcOa0pAue3cm4glqJ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=XaQ3qI7R; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab2bb0822a4so1120460066b.3
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jan 2025 06:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1737469383; x=1738074183; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=24RDCBIR9iRuoTg3dMEiNWifEd1AZzAWzKfuB9PQfXw=;
        b=XaQ3qI7RvNa2NBV1K1JH0nic5Y+3rvcA6Z8t4BB68Gx5Ddt99coXv0ZpAvaREmNN15
         51Grft7W6/V7XgtFPe3XullaRN/n4TdlNPpB9p/41/tXzR9dpEtwDMl/twP96Cq3uyau
         axylKZu508/vuravlP31l9QOP5qa0UdoelmKmMwbzdRZ3cdONmMY9jrK2dDni7b5BkwB
         +A/PbVMQriJyRJ3NkefPUHtWCGP3Txam6OUTXPawwTj04XuZ815krlqwDfwZitqfPBck
         XuekrgqzVshkRHERsE04Scft9OD95YNRv5mfySX3wZUTw0jwCieQ9faMcCL8RaKoQA3P
         Kuow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737469383; x=1738074183;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=24RDCBIR9iRuoTg3dMEiNWifEd1AZzAWzKfuB9PQfXw=;
        b=rL0U2KSv3Sot9LMCzDGsjg+HpmENCTu5eLMHAkOgdQa5/LNID8GVEHTFcdszFwGC6U
         5M7qV14MgC8v4m8UD5z+uKZLNYnubhtRpq8p+UfLkpreFpR7ZLmAGYqwJKrQ2Llif9OS
         DOauKSyyXjppvjufMluI8p7vjBSRjpgZaH4eSUHr3hWFVG5fRoD+0/m3Sej7B816h7jC
         AdFWtulDqrD3xGnCVeKcRLoH8jbWFr5dnSVAjjWB1o9A10nL9M8qHVSdvC0KR3OLm2Ld
         ejhKarlNS4rNBkxFV45LGC4sbHqM7CDlv0xmrkHpPBgmF1D9eTvidbRE+ay1NNe79/1k
         hPAg==
X-Forwarded-Encrypted: i=1; AJvYcCUkjyE9MSFjUUrHd8adfFYFPg2zjJNfB5UvHL8T5OpYWZeYa1nCixCvCnl3aWxSj2OT8x6yT1X3dV/L3hzArWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBbDYY0Olfu6MHxGykn8ek1cOYfp6Y2X8GNGbjyAb4ionN73Bf
	iDmAoY74d3Lmzf8akQYIdg+vSZmo0HdIGLBZWoLGIgX20wjwLnc+HsMRVADXi2M=
X-Gm-Gg: ASbGncvKOvhhQR2wmlz5xBIsgx1HwB1xY1xjZtdKTeKdjiLG3VL0iMxM9elEIkEGl48
	CzRANjIurh4LVvfYnCJzGpP8OyUzOYEQ9eT6i7Jaw+4UIteRtiKRcGEPOvQ51AQQziT8XmeXtOO
	LA/oEIcAyWPNVLOkBLQSEf/dPCHJaCnUYX+AnAvF3F/EAKRXLYHb1iid5xJhbX3K/4wQ69K7K2O
	yKgc02w6K7xleSd+TRR8+Bd5B315yohepH1oLjn1SeQZhVFsMJQF3FF/Tp2ag==
X-Google-Smtp-Source: AGHT+IFUeRUyejArjy8Ob6cNoRY58VolLrz0RuIWmIcvYqgW/FaOF7yendQ3SxB3TDqJWgJ96/D/pQ==
X-Received: by 2002:a17:907:7f9f:b0:aab:d8de:217e with SMTP id a640c23a62f3a-ab38b163550mr1641019466b.26.1737469382986;
        Tue, 21 Jan 2025 06:23:02 -0800 (PST)
Received: from cloudflare.com ([2a09:bac1:5ba0:d60::38a:3e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384fc35b9sm748662866b.161.2025.01.21.06.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 06:23:02 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <mrpre@163.com>
Cc: bpf@vger.kernel.org,  john.fastabend@gmail.com,  netdev@vger.kernel.org,
  martin.lau@linux.dev,  ast@kernel.org,  edumazet@google.com,
  davem@davemloft.net,  dsahern@kernel.org,  kuba@kernel.org,
  pabeni@redhat.com,  linux-kernel@vger.kernel.org,  song@kernel.org,
  andrii@kernel.org,  mhal@rbox.co,  yonghong.song@linux.dev,
  daniel@iogearbox.net,  xiyou.wangcong@gmail.com,  horms@kernel.org,
  corbet@lwn.net,  eddyz87@gmail.com,  cong.wang@bytedance.com,
  shuah@kernel.org,  mykolal@fb.com,  jolsa@kernel.org,  haoluo@google.com,
  sdf@fomichev.me,  kpsingh@kernel.org,  linux-doc@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v8 3/5] bpf: disable non stream socket for strparser
In-Reply-To: <20250121050707.55523-4-mrpre@163.com> (Jiayuan Chen's message of
	"Tue, 21 Jan 2025 13:07:05 +0800")
References: <20250121050707.55523-1-mrpre@163.com>
	<20250121050707.55523-4-mrpre@163.com>
Date: Tue, 21 Jan 2025 15:23:00 +0100
Message-ID: <87wmeogsaj.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 21, 2025 at 01:07 PM +08, Jiayuan Chen wrote:
> Currently, only TCP supports strparser, but sockmap doesn't intercept
> non-TCP to attach strparser. For example, with UDP, although the
> read/write handlers are replaced, strparser is not executed due to the
> lack of read_sock operation.
>
> Furthermore, in udp_bpf_recvmsg(), it checks whether psock has data, and
> if not, it falls back to the native UDP read interface, making
> UDP + strparser appear to read correctly. According to it's commit

Nit: typo, "its"

> history, the behavior is unexpected.
>
> Moreover, since UDP lacks the concept of streams, we intercept it
> directly.
>
> Signed-off-by: Jiayuan Chen <mrpre@163.com>
> ---
>  net/core/sock_map.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index f1b9b3958792..3b0f59d9b4db 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -303,7 +303,10 @@ static int sock_map_link(struct bpf_map *map, struct sock *sk)
>  
>  	write_lock_bh(&sk->sk_callback_lock);
>  	if (stream_parser && stream_verdict && !psock->saved_data_ready) {
> -		ret = sk_psock_init_strp(sk, psock);
> +		if (sk_is_tcp(sk))
> +			ret = sk_psock_init_strp(sk, psock);
> +		else
> +			ret = -EOPNOTSUPP;
>  		if (ret) {
>  			write_unlock_bh(&sk->sk_callback_lock);
>  			sk_psock_put(sk, psock);

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

