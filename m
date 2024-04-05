Return-Path: <linux-kselftest+bounces-7253-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 280F6899492
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 06:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0F9F1F22C3F
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 04:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A4420DC3;
	Fri,  5 Apr 2024 04:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIdKehFQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1C6A21;
	Fri,  5 Apr 2024 04:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712292460; cv=none; b=s5vclOEDCblwHjlyhJDwCPQS6/RhVbCmXznLylzFi7LSkxN6S2OLuh+NtTVUkdhPOam60qOcdJfXwWgSeuMdXXNGBThk1GRbRPCMs5ni4kKuW1cAl90w19RyjGD37FIjZjGRcSmChGGeok7CT/9yBGo619WvCaIslwnCLRhfcpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712292460; c=relaxed/simple;
	bh=KPPAy2NRlf1bP6Z6fFT7GBie8pIP3N18Qq41ae3iumU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=sTX6UMblUGQJWLuvBBaWggGAVsw+6HZT/NfrG13mud3T8r+7obYlt/44cEsis1paq6zpyBlCPERJTpMxKKr8f6XsGZbE9F7tY/cpzh44ViuKUrMV0St3/5saudk8nMNS7/Pjm/Ko+YKitfcwLrumElDHzT+WS8Za24pkZ9sAImk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIdKehFQ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ecf1bb7f38so1069787b3a.0;
        Thu, 04 Apr 2024 21:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712292458; x=1712897258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCjVoUS8vmrMVqQdQng+Kk/4Ylbn3WMAKPvIJ7dMXnQ=;
        b=nIdKehFQ2lDrw1qtZ0TunDFY6bPFtu40PBrzVpSKfc4h2txCejZ/vUTFILGGnh5oVW
         PytQWLoAGLzkfdjrgI3NV+B40KbvGd8NiYq9z7YfhyKIVnXLKmRhS56fLBgsVKNjzRBw
         k1DrlDIePEmUFz20y49V871u4dQS44E69BL/no2Y8OgP4i1M10NZNLTmSZ4V4C+fOlRe
         9fg0x2qHY4wP/QGH6Bmtagnbq3KihuWmcFGTcDg+0bf8K2Gl1mDBsKYepuH29B+rpt33
         CfPbKuuDFq1kcPsw94FECu0vKRUUNQBKkJJtut72Uj+ra9xfvQ2H0bZvLy3DdjPY7KbY
         mNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712292458; x=1712897258;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CCjVoUS8vmrMVqQdQng+Kk/4Ylbn3WMAKPvIJ7dMXnQ=;
        b=nJOIhd0yiY5YeTBLPUXowZiCiVHxpPoSHKQoCsac2OCBofgg8AxmhfXvLUgaPgbwkG
         andL86EnuNXER4jwuzjXjQSWqnDoQ7q8DCqaT2b1I5RehXpFjWKtNioGhd40jXRhYlHk
         AZe863YlDmjW927XKzfMbyXY06DdfrxVw+Xw1b6wbfHkKmcNFniHaAeORONIjplPBoU7
         UnthWnnJz9TaCLihMdvJfI1MoBNzxi/HTcZf7+a9QPkmtNQlJdDZ0XuXCsay6e8Kw/LD
         X3NWgqNX5hJgifM4NMiwgeGulL4x1UPqhWMCGCzOj0Sa9/Q5dOXUOb43RXQyIUrhF9/f
         5O8g==
X-Forwarded-Encrypted: i=1; AJvYcCXf6L9QoUTVwOYAZ1PIi8KYuGEsU/9EeioMBjYA6X5wc5ipOTb2Biig5sEcF2/DFmJ/rcI57JB39zNxIU8XuC5QLJJ/oG01H+z/IRatxM7uowt5U6t2gnMDw3LwH2K/kCjJsmDC
X-Gm-Message-State: AOJu0YwD1AsRNfZ8mO74pYXyiRkWghTN8D53oMRk2vhozkh3J7K2uOct
	k9awG3pat3lonC89S6pHugBroGJUM1YoOdFPO5JdtKKuP4Xsrdv9
X-Google-Smtp-Source: AGHT+IF3ayvSmRejOAejiQIAYZuBc7XfDRh2N7JSjg21At89QKgITaRBie8cblrEyUd7I4EymnbR/Q==
X-Received: by 2002:a05:6a00:3c89:b0:6ea:7db6:6271 with SMTP id lm9-20020a056a003c8900b006ea7db66271mr444514pfb.19.1712292458051;
        Thu, 04 Apr 2024 21:47:38 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id e12-20020a62aa0c000000b006ead792b6a0sm560411pff.93.2024.04.04.21.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 21:47:37 -0700 (PDT)
Date: Thu, 04 Apr 2024 21:47:36 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Geliang Tang <geliang@kernel.org>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, 
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 bpf@vger.kernel.org, 
 mptcp@lists.linux.dev, 
 linux-kselftest@vger.kernel.org
Message-ID: <660f8268ddd8f_50b87208bb@john.notmuch>
In-Reply-To: <74fec36278933bd0dd793875ac2343f528c9355d.camel@kernel.org>
References: <b67101632c6858d281f105b5d4e1bc62dd6b7d27.1712133039.git.tanggeliang@kylinos.cn>
 <878r1ubq8q.fsf@cloudflare.com>
 <660dd833358bd_2144820881@john.notmuch>
 <74fec36278933bd0dd793875ac2343f528c9355d.camel@kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add F_SETFL for fcntl
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Geliang Tang wrote:
> Hi Jakub,
>  =

> On Wed, 2024-04-03 at 15:29 -0700, John Fastabend wrote:
> > Jakub Sitnicki wrote:
> > > Hi Geliang,
> > > =

> > > On Wed, Apr 03, 2024 at 04:32 PM +08, Geliang Tang wrote:
> > > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > > =

> > > > Incorrect arguments are passed to fcntl() in test_sockmap.c when
> > > > invoking
> > > > it to set file status flags. If O_NONBLOCK is used as 2nd
> > > > argument and
> > > > passed into fcntl, -EINVAL will be returned (See do_fcntl() in
> > > > fs/fcntl.c).
> > > > The correct approach is to use F_SETFL as 2nd argument, and
> > > > O_NONBLOCK as
> > > > 3rd one.
> > > > =

> > > > Fixes: 16962b2404ac ("bpf: sockmap, add selftests")
> > > > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > > > ---
> > > > =C2=A0tools/testing/selftests/bpf/test_sockmap.c | 2 +-
> > > > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> > > > =

> > > > diff --git a/tools/testing/selftests/bpf/test_sockmap.c
> > > > b/tools/testing/selftests/bpf/test_sockmap.c
> > > > index 024a0faafb3b..34d6a1e6f664 100644
> > > > --- a/tools/testing/selftests/bpf/test_sockmap.c
> > > > +++ b/tools/testing/selftests/bpf/test_sockmap.c
> > > > @@ -603,7 +603,7 @@ static int msg_loop(int fd, int iov_count,
> > > > int iov_length, int cnt,
> > > > =C2=A0		struct timeval timeout;
> > > > =C2=A0		fd_set w;
> > > > =C2=A0
> > > > -		fcntl(fd, fd_flags);
> > > > +		fcntl(fd, F_SETFL, fd_flags);
> > > > =C2=A0		/* Account for pop bytes noting each iteration
> > > > of apply will
> > > > =C2=A0		 * call msg_pop_data helper so we need to
> > > > account for this
> > > > =C2=A0		 * by calculating the number of apply
> > > > iterations. Note user
> > > =

> > > Good catch. But we also need to figure out why some tests failing
> > > with
> > > this patch applied and fix them in one go:
> > > =

> > > # 6/ 7=C2=A0 sockmap::txmsg test skb:FAIL
> > > #21/ 7 sockhash::txmsg test skb:FAIL
> > > #36/ 7 sockhash:ktls:txmsg test skb:FAIL
> > > Pass: 42 Fail: 3
> =

> Sorry, I didn't notice these fails in my testing before, they do exist.=

> I'll try to fix them and sent a v2 soon.

Not 100% sure but a hint. I would look into where the stream parser
is waking up the sock here. I'm not sure there is an easy fix tbh.
I can help look at this soon as well if you don't beat me to a fix.

Thanks for looking into it.

> =

> Thanks,
> -Geliang=

