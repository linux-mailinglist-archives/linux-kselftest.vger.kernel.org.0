Return-Path: <linux-kselftest+bounces-33472-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 915E3ABFC2B
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 19:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 223CE7A58F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 17:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE0528313D;
	Wed, 21 May 2025 17:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GPDeNWWG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ADE27FB11
	for <linux-kselftest@vger.kernel.org>; Wed, 21 May 2025 17:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747848083; cv=none; b=CjEUB2Vw1oCq17StL3githR7T7A+2wxdvfJezfXESWihz+FhTe7yjT7aaVG0CmayCp2TTc2O8dnfRQQsNAUvI2LxDmaHpzPi22RWJo+djMOY6xsvPKSUdZYzZLz4UHiBbtW0XDdmnjh9smaPutbvPvTVblG1/Biis5ilZNWME60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747848083; c=relaxed/simple;
	bh=cqtVnYMwytU621vRDMWnywFjE3FJFp4m1Fu1HokVKxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B5oF/9fNiN2WU8KrhyMgSnnhnWLa1/vMEW2xHBcgoPfTcSAjFpWFntamzPgtAy1bD+ecWZMKZnnDYMnwNr6aXgnsNbaNj2E1LPcd4a/LgZo0Ya0oiywaklqMqJFX/D2aUelqZtTxcj1fh9648Qx5ion0A+ZuYQ11GKHv/PiXuVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GPDeNWWG; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-231f37e114eso1056715ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 21 May 2025 10:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747848080; x=1748452880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TzRULGTaOq2SCZGYjVrgxuJH6Vmk6OskDH6n5154vg=;
        b=GPDeNWWGsboLyTXFd3gYxjrakkGWca4DBDpTVsUqSi9QHLMAsJVXJ1vBMxpjOPdm+S
         /c8KWZetjQmL/qToPir7B9lz8FZXukFpaP9OTpdgILJZ44YI+pGCDs6X7vb/MGqXDJ1x
         P0hlTQJf9VGztFGiaoYRMo27tsokfmSvd6qbCquT3fxoTdvXko3qp8yR8smpEhNmuLUw
         twsCAykf74gh3XpQdqmuFS3AWTO4cmhmOKpaXcJX0oUo0PpvEyiCDt61YmLSupYdox5M
         XyW3bmVsuRG6JuwwvwA9Mvml5rhdW+Ik4KwUmScbChAfFK7mDt+SMR0aPdBZyN9JPzph
         XXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747848080; x=1748452880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8TzRULGTaOq2SCZGYjVrgxuJH6Vmk6OskDH6n5154vg=;
        b=C9P8Caw1c1FvcI0O2PUXXcR1bsAYLC8IIfniET9hk15EiFrnT3ryN3yUB/0QvsGtpC
         KClWdAEYkF0L6vnA2tjYTip7Ff/6BZ8qSj1+NJKY90LMZjDUwqzmgsN7qwefWwX31jJW
         kmajMCgPg4qMoOYW0KPDll1BmIqhEnJHuOVDO5BwcLF5jLb8uZYpBxZLfi893eBPHC01
         6Pep+wbCVLXTQyLOPRXaOFl+GEvqSsOLbDFH6SbiR1I/I59pesn8b+PZ7+yhtlFDWJOg
         W9lKbaChD06II55h480gGNqsvi0iC6RY3CvdugTT38hdZtHQI+Aj34Y5q2DB0hT74LYb
         5zlw==
X-Forwarded-Encrypted: i=1; AJvYcCVVyk3MV4qYaJD650kbiMrEdbNhqV73h7AhXdVIPvpLobVCD+03YsOFl9iScPmN/n2DpOx/zzfATo41zYCI/+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0G+Qt0RKBqPLu8MSMt2CI4q91S1NgGaLF8lgzULVgSc8UUjDH
	E9MvS5EDxUeCA2W6hz7cPez/wOppqWSMHlmIPOoulNG7i5efO76wIAKOGaNAubnYK0Uc/FdnOBe
	DfUdGWX/WOmdetiwECeGsODxW/PzBGycVJTvEB6zX
X-Gm-Gg: ASbGncu1ZMmbqSYdRkMX0FoOrL4Hab0k+In6XSvp8JA7yLn1BrMwqVcfqmXjFeXCK58
	ASzmCItQSN1X6xy5+szs8ZsvSwIkP5Cxxyi+eIWDGGlA4BvP7bjOBTm1Oa5Nhd1/R5FEwlgOFeo
	yrUl38NpPOeOA2QyoQ4Lx2kVEoFMZvl3+Kvu4Oqd+YeWvTI3aZiSfQZctKbGMyHRr5ew/lF8bD
X-Google-Smtp-Source: AGHT+IHXSLEh1ng48lSqSLKU62F5dm1IpyqVjnrXWcmc9Cn5aEIx79tGlkJf4Cvd8k/BEpZgaiZIo4LCPAtmC17HrN4=
X-Received: by 2002:a17:902:f68a:b0:231:e976:a829 with SMTP id
 d9443c01a7336-232041664fbmr11191355ad.27.1747848079650; Wed, 21 May 2025
 10:21:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520203044.2689904-1-stfomichev@gmail.com> <20250520203044.2689904-2-stfomichev@gmail.com>
In-Reply-To: <20250520203044.2689904-2-stfomichev@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 21 May 2025 10:21:06 -0700
X-Gm-Features: AX0GCFvIb1Mor4qHBJWuRsulh2MAvDR01XTEdcXxYf4IzCEkeO4dm8bvfQxtp1k
Message-ID: <CAHS8izNwpgf3ks1C6SCqDhUPnR=mbo-AdE2kQ3yk4HK-tFUUhg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] selftests: ncdevmem: make chunking optional
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, viro@zeniv.linux.org.uk, horms@kernel.org, 
	andrew+netdev@lunn.ch, shuah@kernel.org, sagi@grimberg.me, willemb@google.com, 
	asml.silence@gmail.com, jdamato@fastly.com, kaiyuanz@google.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 1:30=E2=80=AFPM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> Add new -z argument to specify max IOV size. By default, use
> single large IOV.
>
> Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
> ---
>  .../selftests/drivers/net/hw/ncdevmem.c       | 49 +++++++++++--------
>  1 file changed, 29 insertions(+), 20 deletions(-)
>
> diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/te=
sting/selftests/drivers/net/hw/ncdevmem.c
> index ca723722a810..fc7ba7d71502 100644
> --- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> +++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> @@ -82,6 +82,9 @@
>  #define MSG_SOCK_DEVMEM 0x2000000
>  #endif
>
> +#define MAX_IOV 1024
> +
> +static size_t max_chunk;
>  static char *server_ip;
>  static char *client_ip;
>  static char *port;
> @@ -834,10 +837,10 @@ static int do_client(struct memory_buffer *mem)
>         struct sockaddr_in6 server_sin;
>         struct sockaddr_in6 client_sin;
>         struct ynl_sock *ys =3D NULL;
> +       struct iovec iov[MAX_IOV];
>         struct msghdr msg =3D {};
>         ssize_t line_size =3D 0;
>         struct cmsghdr *cmsg;
> -       struct iovec iov[2];
>         char *line =3D NULL;
>         unsigned long mid;
>         size_t len =3D 0;
> @@ -893,27 +896,29 @@ static int do_client(struct memory_buffer *mem)
>                 if (line_size < 0)
>                         break;
>
> -               mid =3D (line_size / 2) + 1;
> -
> -               iov[0].iov_base =3D (void *)1;
> -               iov[0].iov_len =3D mid;
> -               iov[1].iov_base =3D (void *)(mid + 2);
> -               iov[1].iov_len =3D line_size - mid;
> +               if (max_chunk) {
> +                       msg.msg_iovlen =3D
> +                               (line_size + max_chunk - 1) / max_chunk;
> +                       if (msg.msg_iovlen > MAX_IOV)
> +                               error(1, 0,
> +                                     "can't partition %zd bytes into max=
imum of %d chunks",
> +                                     line_size, MAX_IOV);
>
> -               provider->memcpy_to_device(mem, (size_t)iov[0].iov_base, =
line,
> -                                          iov[0].iov_len);
> -               provider->memcpy_to_device(mem, (size_t)iov[1].iov_base,
> -                                          line + iov[0].iov_len,
> -                                          iov[1].iov_len);
> +                       for (int i =3D 0; i < msg.msg_iovlen; i++) {
> +                               iov[i].iov_base =3D (void *)(i * max_chun=
k);
> +                               iov[i].iov_len =3D max_chunk;

Isn't the last iov going to be truncated in the case where line_size
is not exactly divisible with max_chunk?

> +                       }
>
> -               fprintf(stderr,
> -                       "read line_size=3D%ld iov[0].iov_base=3D%lu, iov[=
0].iov_len=3D%lu, iov[1].iov_base=3D%lu, iov[1].iov_len=3D%lu\n",
> -                       line_size, (unsigned long)iov[0].iov_base,
> -                       iov[0].iov_len, (unsigned long)iov[1].iov_base,
> -                       iov[1].iov_len);
> +                       iov[msg.msg_iovlen - 1].iov_len =3D
> +                               line_size - (msg.msg_iovlen - 1) * max_ch=
unk;
> +               } else {
> +                       iov[0].iov_base =3D 0;
> +                       iov[0].iov_len =3D line_size;
> +                       msg.msg_iovlen =3D 1;
> +               }

Do you need to special case this? Shouldn't this be the same as max_chunk=
=3D=3D1?

>
>                 msg.msg_iov =3D iov;
> -               msg.msg_iovlen =3D 2;
> +               provider->memcpy_to_device(mem, 0, line, line_size);
>
>                 msg.msg_control =3D ctrl_data;
>                 msg.msg_controllen =3D sizeof(ctrl_data);
> @@ -934,7 +939,8 @@ static int do_client(struct memory_buffer *mem)
>                 fprintf(stderr, "sendmsg_ret=3D%d\n", ret);
>
>                 if (ret !=3D line_size)
> -                       error(1, errno, "Did not send all bytes");
> +                       error(1, errno, "Did not send all bytes %d vs %zd=
", ret,
> +                             line_size);
>
>                 wait_compl(socket_fd);
>         }
> @@ -956,7 +962,7 @@ int main(int argc, char *argv[])
>         int is_server =3D 0, opt;
>         int ret;
>
> -       while ((opt =3D getopt(argc, argv, "ls:c:p:v:q:t:f:")) !=3D -1) {
> +       while ((opt =3D getopt(argc, argv, "ls:c:p:v:q:t:f:z:")) !=3D -1)=
 {
>                 switch (opt) {
>                 case 'l':
>                         is_server =3D 1;
> @@ -982,6 +988,9 @@ int main(int argc, char *argv[])
>                 case 'f':
>                         ifname =3D optarg;
>                         break;
> +               case 'z':
> +                       max_chunk =3D atoi(optarg);
> +                       break;
>                 case '?':
>                         fprintf(stderr, "unknown option: %c\n", optopt);
>                         break;
> --
> 2.49.0
>


--=20
Thanks,
Mina

