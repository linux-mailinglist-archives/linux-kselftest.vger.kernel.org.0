Return-Path: <linux-kselftest+bounces-13063-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505FE924048
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 16:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04320288160
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 14:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DF91BA072;
	Tue,  2 Jul 2024 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gbIIGpRK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FA01B580C
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Jul 2024 14:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719929831; cv=none; b=pQ0Ptqoldn7PT5nhoQm91uE+PdaGS1iZZBbgrMqUbH1m8QXoscVvFOjcyA0iaIzX+Y+6aeO4Dh7mgdicBNAP6C2oi3GllTeTaz3HxjgLN+xg8VgkqM63Kuixp4Q6QtNFx5poV8XKfMa88tXga3FLzmqZNAz8NQaP1iU/Xeti2Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719929831; c=relaxed/simple;
	bh=gnffRDgb6MkK9/ngZ6O/0GyrGhi5uTvKCK/HB1ItSAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kqekteH3hwd1k3Ox6m0WBxloxcyFHQm0/bp6ru7ixJDGH4Q/1pcqU72iMT061YA5/zQH2PHzIWtAWiBjmVrj8MoZLbKbQeeLJe591oKvNe2e+sIkbHbsNVziU45Un8/vXQlyg6+qQks2gfKU/JTsUrjCJh6kMNQ9EUOyGyF2wtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gbIIGpRK; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57d119fddd9so23243a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Jul 2024 07:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719929828; x=1720534628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3MsOJSlob7CKHdGlFCDO6udUL2K0h2Y2TJHmLjG41zo=;
        b=gbIIGpRKQobLTmehAOpgfLcy95ZU/AByfs9kdBeYQ/n2KkzTfa/cXXnp4MusF1H8BX
         N10qfXzyc9gq/LfGnU2Q55A1ZBI6rgezEmGprEgxZT9yr/tXnrloW0p2QLIG6T9XGoK4
         zK4fzdfs3GbBMR9fhU2FpVhygr4L5pdWCcgNxgcJ9tD0ZXPndk2DlM7d5VFUHTL3ZlxK
         CL8s+gWes1GXm/lFgHAX4DxefMh99qjJZSGMw22omRW0qlxUrLzlODvPHE5jTR6DVFVJ
         hnKEq5lxgWg6S5nz1lIeX5veiASadMiAZpwwPNVlj9heAkxvqT4kO4bkNoTzppVR5b/N
         JIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719929828; x=1720534628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3MsOJSlob7CKHdGlFCDO6udUL2K0h2Y2TJHmLjG41zo=;
        b=qp8zSbTjpsIKrcrY/wob2xCw0Rd+Ms6RCjuigsbobzlj7HQ1F6IY3y5c3eE3Dcbdlb
         3ANItaRZA6KXbuAjP9iTjQryluUJ65fRXS0kIwK6LEQhCuKRAgG7ZcTaXMR5dv16bo8B
         KzBOv723cikxDN4iuTpOBfzJRFp8ZogWceGKg3c5xnza3oI4xlPVFxnWQ0Wxi8e/Ux1q
         2FHEdyWOhAc0R7xEC1tJkcpdkeUJcH8CoPv/F2exoU76Lq2eTiDrO7hiiPkjZtxreC0e
         ExJxLqW+QhM45O6HHReDaQwLI6bTiFskOMnb281xVr2eJx10xOuHjKVfmu/8HFuX1i5i
         6iKg==
X-Forwarded-Encrypted: i=1; AJvYcCVTfenwvPQRufnC9uYHttEZkiHDNB/60SK17+poG1oC5SsTXFd1ANRjS2HeOLdSZJQl1h1nD+E3tkfWRNmpvbFrOhSwhXhYuclZdh3SyWnp
X-Gm-Message-State: AOJu0YxvK5iUfpQrgQovHmAjb9b4ZFIorqVLufeE6TxXYjani7j+XUXv
	V02yCOMFmYWnIn2mi8XV+ZE7G6pIu+qiNN93ULrA8H5AMKHAL0EaBvxKXS0awAUp6vzxS0N8h8h
	+HX4pG9+XzVxzcQOAhQMW8BtlzodZJFtD/7Kk
X-Google-Smtp-Source: AGHT+IHeie+CneGN1tFOl+YZGQ17cXdj2DR/Y+QNM3pfEb34aKGMstvK/sjFNw/KX6ZKxM2ZjhUuZFIwrJ3gR7SUsI4=
X-Received: by 2002:a50:cd4c:0:b0:58b:dfaa:a5cd with SMTP id
 4fb4d7f45d1cf-58c64acd894mr588a12.2.1719929827849; Tue, 02 Jul 2024 07:17:07
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628003253.1694510-1-almasrymina@google.com> <20240628003253.1694510-11-almasrymina@google.com>
In-Reply-To: <20240628003253.1694510-11-almasrymina@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 2 Jul 2024 16:16:56 +0200
Message-ID: <CANn89iLuXtpbVf5TEYy7QVqosZVSuCSsCLw=3DsJBoPDkEzveA@mail.gmail.com>
Subject: Re: [PATCH net-next v15 10/14] tcp: RX path for devmem TCP
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 2:33=E2=80=AFAM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> In tcp_recvmsg_locked(), detect if the skb being received by the user
> is a devmem skb. In this case - if the user provided the MSG_SOCK_DEVMEM
> flag - pass it to tcp_recvmsg_devmem() for custom handling.
>
> tcp_recvmsg_devmem() copies any data in the skb header to the linear
> buffer, and returns a cmsg to the user indicating the number of bytes
> returned in the linear buffer.
>
> tcp_recvmsg_devmem() then loops over the unaccessible devmem skb frags,
> and returns to the user a cmsg_devmem indicating the location of the
> data in the dmabuf device memory. cmsg_devmem contains this information:
>
> 1. the offset into the dmabuf where the payload starts. 'frag_offset'.
> 2. the size of the frag. 'frag_size'.
> 3. an opaque token 'frag_token' to return to the kernel when the buffer
> is to be released.
>
> The pages awaiting freeing are stored in the newly added
> sk->sk_user_frags, and each page passed to userspace is get_page()'d.
> This reference is dropped once the userspace indicates that it is
> done reading this page.  All pages are released when the socket is
> destroyed.
>
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

