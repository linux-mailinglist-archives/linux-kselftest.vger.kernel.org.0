Return-Path: <linux-kselftest+bounces-44084-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12044C0C250
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 08:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8B069345D74
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 07:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE982DFA28;
	Mon, 27 Oct 2025 07:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghA9J1FL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5542DF6EA
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 07:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761550462; cv=none; b=D/NHoi6I4yhYYjzazOkwGRQcv0DxUs8Aza2gsubsTyj+/c6Gl5q/9qs9N4C6uVLMn8BnmE66W4Xsy+fNwhAYgbshV6l543ZBasz40rdMIRRBuU8WKM8JzpYONmb1h2sCuW7xRJ/0GqqqCN+btvWPtIIbj3ZlNu0wacM4qb9U/iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761550462; c=relaxed/simple;
	bh=VLS73N+k0m8pm2jfMn0bQ+AxVZEGfiR67VwsmEn/FAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hvYTmaWK/Bjl1XHQ5pzr1Hjl2uclZb27f7yittfDndwFbPZTmQ0fmmoQa7XkK4Ct2ql4oTHsSwYTzqqA8JVibPnWMnGiPcQyAg+oRlzI2SHIr+ozuyajrtGPd9ACdMltms9AmfF2HWGdX0FaIrVH0xpGG+6ky/zo0/HqGvvnSFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghA9J1FL; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-430da09aa87so20725635ab.2
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 00:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761550460; x=1762155260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLRKSCpsYmwhIoBpLKvnpHRYxz12yXBw9ZjyLu+9T0M=;
        b=ghA9J1FLNNV2Q+/50p63l9mAdqufw01gfa6NrKcnhX65vJ6vOZWFGmbozP5wRgZ+gD
         JUydxddDjlg3SbvjZAw63IVdsfJ5T/tNapREXvJu60WRK9Xg5UixiTWa8Ui5uxr/1nkj
         AmmY5gF1JeSSz4UfiXtUeAI6P4CIgsYk87O4Osxu6V+qBlaGGiqq5MTb9IwYnRoP90ll
         6YCce6+/k1+hbtTPEIRFjPWKV8+OcrVBb/8vCgSNWI8PnA+DUcWRo7lJ46JDIw0DBGXi
         pAdtnIYbV0reH1R9hklIZy7K8jRTI1GTwbDSjstUqO0lolhg9HesAG3g0+fXo4Sd5m5Z
         /zWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761550460; x=1762155260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLRKSCpsYmwhIoBpLKvnpHRYxz12yXBw9ZjyLu+9T0M=;
        b=bquZ5wsWm5stA9dMh3das3Lhb4guxvkleNhvG3S6PMzHcPsMl8bND3IGk3GXTpAvWl
         cyZ9gTb1H3lAJQdT7meHh4n0MA525TvQYnIJus2Y4zxGUnkmPMdAkqdR4AQ30gs4mK3E
         hiGzedy1iHHNSV48PoPVPHtjD+97pEVY46Sb2cgFZVSXonY9reCuuK6sI2AoRGWle/XN
         DRNAi2ckXxyNkujzH0kkVAjFoIRbCRvZj3bRXu8qNEj89USJXYRbfPMA9uyUS7NEhZm8
         xl/gKrokk7PAQlbVAt6MpW7LDSIkokazLOKyRenCLOr0odCasAVgVbfdfa6rzeHyRBso
         v7qg==
X-Forwarded-Encrypted: i=1; AJvYcCVnS5o7UndVoZrNIfgQSr9QYLqBmWFQkehOmLrjMH3znAT5aN4GOABwdxei+2NOVlxZ472gFq7wyFVsut07EFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgypxbxDFlEW+sNCTaOgSvDWLk8TfzplzBE5xdam94qc/vb+Vf
	mGdlPHtit8J7kiXe9eaBPKMZ6OT6hJn/GgK/Ft+EReixNmkAxlsiqNs02nNFszR2VQ9fCLjuKCu
	UUvXPIROzZrdG5gusjazFY/MCKutL1/U=
X-Gm-Gg: ASbGncvo58poSmTbkWPhql6gD3ZKNsw/2w8rI/0kzxp5/7cP+9tZ5MiIyusIhv97BwK
	FlOAhHfO+W06EKEw0AnRXrZCZlwON+1MsRt66VjPvQQ6QBnMz4IPpy09bLwGIZFNvin9kmPfbOk
	QyZkJsJ0pBHp/uHTLFkb4FGFIYj5CGn5X4W45hpzelgPvgD0fzmqqFZ+qUo7XluA+Dm1gikyHhi
	wFVhAKNJSPNKnw1YzVN6CLWmmxQJYgyaRlor2TX/h85ZA4yb2/5HEFCMVE=
X-Google-Smtp-Source: AGHT+IE4yTFQB/Sz1Hvmf1eohFHURvb676RfwgjWsjq1mbVjiRUKXUxdP/I+N8rdBuajxo0qe5dILr2G07V8SzV/+rY=
X-Received: by 2002:a05:6e02:1c0c:b0:430:b787:1c7a with SMTP id
 e9e14a558f8ab-430c52b43b0mr510390015ab.17.1761550460332; Mon, 27 Oct 2025
 00:34:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027053156.34368-1-ankitkhushwaha.linux@gmail.com>
In-Reply-To: <20251027053156.34368-1-ankitkhushwaha.linux@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 27 Oct 2025 15:33:43 +0800
X-Gm-Features: AWmQ_bmSUZhPR6p4SLQBN6A4GJHnkpFAQUKFPm5PcXL0KgaMnnMufzd-em_1cRE
Message-ID: <CAL+tcoANtVUp=tFD=JgR34_TvmrKVr7zz8gZMgoTKNDnjCzLTg@mail.gmail.com>
Subject: Re: [PATCH v2] selftest: net: fix variable sized type issue not at
 the end of a struct
To: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Jason Xing <kernelxing@tencent.com>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 1:32=E2=80=AFPM Ankit Khushwaha
<ankitkhushwaha.linux@gmail.com> wrote:
>
> Some network selftests defined variable-sized types variable at the middl=
e
> of struct causing -Wgnu-variable-sized-type-not-at-end warning.
>
> warning:
> timestamping.c:285:18: warning: field 'cm' with variable sized type
> 'struct cmsghdr' not at the end of a struct or class is a GNU
> extension [-Wgnu-variable-sized-type-not-at-end]
>   285 |                 struct cmsghdr cm;
>       |                                ^
>
> ipsec.c:835:5: warning: field 'u' with variable sized type 'union
> (unnamed union at ipsec.c:831:3)' not at the end of a struct or class
> is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
>   835 |                 } u;
>       |                   ^
>
> This patch move these field at the end of struct to fix these warnings.
>
> Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
> ---
> Changelog:
> v2: https://lore.kernel.org/linux-kselftest/20251027050856.30270-1-ankitk=
hushwaha.linux@gmail.com/
> - fixed typos in the commit msg.
>
> ---
>  tools/testing/selftests/net/ipsec.c        | 2 +-
>  tools/testing/selftests/net/timestamping.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/net/ipsec.c b/tools/testing/selftest=
s/net/ipsec.c
> index 0ccf484b1d9d..36083c8f884f 100644
> --- a/tools/testing/selftests/net/ipsec.c
> +++ b/tools/testing/selftests/net/ipsec.c
> @@ -828,12 +828,12 @@ static int xfrm_state_pack_algo(struct nlmsghdr *nh=
, size_t req_sz,
>                 struct xfrm_desc *desc)
>  {
>         struct {
> +               char buf[XFRM_ALGO_KEY_BUF_SIZE];
>                 union {
>                         struct xfrm_algo        alg;
>                         struct xfrm_algo_aead   aead;
>                         struct xfrm_algo_auth   auth;
>                 } u;
> -               char buf[XFRM_ALGO_KEY_BUF_SIZE];
>         } alg =3D {};
>         size_t alen, elen, clen, aelen;
>         unsigned short type;
> diff --git a/tools/testing/selftests/net/timestamping.c b/tools/testing/s=
elftests/net/timestamping.c
> index 044bc0e9ed81..ad2be2143698 100644
> --- a/tools/testing/selftests/net/timestamping.c
> +++ b/tools/testing/selftests/net/timestamping.c
> @@ -282,8 +282,8 @@ static void recvpacket(int sock, int recvmsg_flags,
>         struct iovec entry;
>         struct sockaddr_in from_addr;
>         struct {
> -               struct cmsghdr cm;
>                 char control[512];
> +               struct cmsghdr cm;
>         } control;
>         int res;

For the timestamping part:

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks,
Jason

