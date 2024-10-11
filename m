Return-Path: <linux-kselftest+bounces-19564-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3AF99ACD2
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 21:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC9F281CCC
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 19:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5A41D049F;
	Fri, 11 Oct 2024 19:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XjkjknEt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0BE1D0788
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2024 19:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728675510; cv=none; b=PbHY+tzNHpeIMTZPth+QMgVRIoUdAo0UfqbMZ+eb7FK/IiurLqLSJaQg2wsMoaEkgSnFgCJx2UHoCYDskSEqvqOqvTryBSxq3tzoEMdlitrfh0qlnoxcVN6yf7ZUj/kBcZKlVOmjkm8EhLB4OSzb+vi1eo/+YDrbidcDUo8WQtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728675510; c=relaxed/simple;
	bh=lIT4MF3P08EUQ/ItxiJCyTg8JaALptzUPgWCabDCkKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sEsjNUTjRY1OwRSfCd7W2VUKWu1ohhu506OBuAFyqOD2SuBd75aR3AYVSeiJ4NwwjJSU8QKalEFqpMxQu0Oh0mhfPRH0FVD9BW3w6/l3DlTeBiSkSq4YNxxOAhfDvrWi9R1l478b+PN25JmmajbXS0FhUoV+kCCeNg1x9x0elxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XjkjknEt; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4601a471aecso35431cf.1
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2024 12:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728675507; x=1729280307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4/PPqatSk2BAD8kUIT/38Gyd1BY7fTrP7ap/2S9Mqk=;
        b=XjkjknEt5tftq70KCGlTHLD1Bh2BPjVE2PxpnBWMyyvy0Sp3gh+Ou2AGHu9p3dWutG
         Ly3++jhiM30xrysorDSmgJ1/CrEZtf6ayIU3Zmwx3Vb8IUgL3FRRSfyF9Uq+Uzbj3vUN
         u/bUYraAbm5jodAmY4pqow/Khq+dr2J2OnWFkAw+h8J7APJ1G+1llNpGccZsVYLd3rvD
         +QBQRdyuhuBJG6aMG9ikacbC88xyvg5Opx9d5h6aw4PuP1rE87zMIrrAmpxqP3AFOGuK
         ExS8+5YeQleDH4F25vvvICWGh0gbjOcW75+6kisVvnRm7+3uDYn2SyaicjpmO643m7Cu
         Y50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728675507; x=1729280307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4/PPqatSk2BAD8kUIT/38Gyd1BY7fTrP7ap/2S9Mqk=;
        b=Rt3kGcPcUshfIrftVnww2k04hMtjRJ+HiBQyD6ufnNiwnh8qIAzztsJ0GwcKSJviXX
         Qe90KgH0qETGlUeNOvLq2E5yKMm4MFO+rj29c9n7qNQdNEbGP57yV4BIPpjOKlBniF9N
         evORfOo3Bi3BdMe6+jV/Du72CkmZJ6dbEpkQC2nFkzv+IQvuzNsmv+wirGU9/C/Qgs5J
         mGgIVkV9v1a16yeuHX3PnJLsLGZlCw7ND+dTWki4tfTURI+r2Ejwb+1Lqm7Qg3nsheLD
         TtdzY+p/itrXoV9JpPnMPdfTEGN3jpdwav3xyp1DBLOcHlsM2Pc/ziDx5EVdb/zv+ZHf
         fvbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUS55kLRG7SlCPqVmaGBKtL5VGaBfZ2xjF6Y1gV42Zlmd8JsOSzRT9i2MEuFqU/4qowkLSwz+rPe1Q7ThxARsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmRZajauK0Nn8Qj/IyWx5bpFYCfGo0G/khSKN+ookSGkgJx2Bv
	JR8hiscmfZrvOuPNUfcbriWuKcscg5KAxI2pOQQJPDYDl//bxsJ0PEJ9CXge67sAs2JJ+zw0exT
	g8r3mTRkR2SdtZdazGky5jeHJGIJ2txR+M2YV
X-Google-Smtp-Source: AGHT+IEJvq2uzdDh3W2Sfu5aWaK5xhLaKiCn2xWH/iIRkxgpB4FklAs+UX9kaTQ1TkS7P0dLyhTRAOjn/li4z+5WdqQ=
X-Received: by 2002:a05:622a:468c:b0:45c:9eab:cce0 with SMTP id
 d75a77b69052e-46059046571mr529141cf.15.1728675507274; Fri, 11 Oct 2024
 12:38:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909054318.1809580-1-almasrymina@google.com>
 <20240909054318.1809580-11-almasrymina@google.com> <Zwe3lWTN36IUaIdd@ly-workstation>
 <CAHS8izPuEUA20BDXvwq2vW-24ez36YFJFMQok-oBDbgk6bajSA@mail.gmail.com> <20241011082707.5de66f15@kernel.org>
In-Reply-To: <20241011082707.5de66f15@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 11 Oct 2024 12:38:14 -0700
Message-ID: <CAHS8izMVjfrYopPpmg4dN33VL7bF-icS=HFDPOhmW96rgthErg@mail.gmail.com>
Subject: Re: [PATCH net-next v25 10/13] net: add SO_DEVMEM_DONTNEED setsockopt
 to release RX frags
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Lai, Yi" <yi1.lai@linux.intel.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Donald Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>, yi1.lai@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 8:27=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 10 Oct 2024 12:05:38 -0700 Mina Almasry wrote:
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index 083d438d8b6f..cb3d8b19de14 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -1071,11 +1071,11 @@ sock_devmem_dontneed(struct sock *sk,
> > sockptr_t optval, unsigned int optlen)
> >             optlen > sizeof(*tokens) * MAX_DONTNEED_TOKENS)
> >                 return -EINVAL;
> >
> > -       tokens =3D kvmalloc_array(optlen, sizeof(*tokens), GFP_KERNEL);
> > +       num_tokens =3D optlen / sizeof(struct dmabuf_token);
> > +       tokens =3D kvmalloc_array(num_tokens, sizeof(*tokens), GFP_KERN=
EL);
> >         if (!tokens)
> >                 return -ENOMEM;
> >
> > -       num_tokens =3D optlen / sizeof(struct dmabuf_token);
> >         if (copy_from_sockptr(tokens, optval, optlen)) {
> >                 kvfree(tokens);
> >                 return -EFAULT;
> > @@ -1083,6 +1083,10 @@ sock_devmem_dontneed(struct sock *sk, sockptr_t
> > optval, unsigned int optlen)
> >
> >         xa_lock_bh(&sk->sk_user_frags);
> >         for (i =3D 0; i < num_tokens; i++) {
> > +
> > +               if (tokens[i].token_count > MAX_DONTNEED_TOKENS)
> > +                       continue;
>
> For the real fix let's scan the tokens before we take the xa lock
> and return an error rather than silently skipping?
>
> >                 for (j =3D 0; j < tokens[i].token_count; j++) {
>

Yes, sorry, I called the diff above an 'untested fix' but it was more
of a hack to see if I got the root cause right. For a proper fix, we
should do exactly that. Scan and see how many tokens the user is
asking us to free ahead of time, then exit early if it's too much
before we acquire locks and loop. Will do!

--=20
Thanks,
Mina

