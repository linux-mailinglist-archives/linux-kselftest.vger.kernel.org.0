Return-Path: <linux-kselftest+bounces-1694-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA01F80F373
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 17:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CDB5B20D98
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 16:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404F87A228;
	Tue, 12 Dec 2023 16:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2fftcZ3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF39CCA;
	Tue, 12 Dec 2023 08:44:55 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3333074512bso3734010f8f.1;
        Tue, 12 Dec 2023 08:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702399494; x=1703004294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f72rnhLGCj7YeXxJ2uAZSlHFuNQHutdzqzKTHCk0k28=;
        b=e2fftcZ3W3jZ8+lB3bO+fWSQFYhVe9ErWy3E7zjMmVxkdEmHaBt9KroM/75n6wQBA9
         wt2T5XBb6spvvHU8fTPXbq1wtx1hwSSCJjCBKG2rR0Hh80ctd3hGpF3c0EGIGtvbcFE1
         XnunYWOkE9E/nakovRvMUlgvS3dpLt7zdlDfzLKuDF0wFXEs2Mm8GOaPc4ouUpfA729b
         LLVk30yocQ6+akKQEmJxvHiMltIMzqh/+1ZP6zB4qf4Z8V8DqrFw8MeJZ7PGHzBEFqXB
         pdq5RvCw0lVz7gZd92DuUORfTGmyqQJF+PtdJzucVcEE61q18jSP2fQwmXaNRehlb5aO
         W0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702399494; x=1703004294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f72rnhLGCj7YeXxJ2uAZSlHFuNQHutdzqzKTHCk0k28=;
        b=a0nKNF5fadOtQGmSCx08N3d9PBZgN6QgTqo9kT6DzEmfo/pMZ0DUoSXk7AHrxMraZ4
         PvoDZkcd9W3v0L5HVJgkOWVtJWDfu/3ylKDiccIG3QYSoId2aehDoPuP/PYW1jun7+Z/
         dmJeEJejztooiAdGUjxDkrLBu+trXiLBpsUilkiW2R8cnLe0TZNlqlgSSTD4G9eB3nQt
         L+eSswtSQDquwSBr2fdFhybZQT0rW7ncO82WUQYRl/Gmu6gkXZCeFRTikPe9E9L2Eq9p
         Kmv2CWM5D3IhNVhfJw/w3NQc9fao58Zt4T/0aA0Uel6AgbUW1xL6loMPAwuDC/lt+nhV
         oY6w==
X-Gm-Message-State: AOJu0Yx/adthG4spR04sipg6nIr4PUn/IYBJ+oVDGbtlxNjPnN9FKNLV
	oq7unj11jkoUMCSw05JL8klPLOp1xSw0xUAfCkM=
X-Google-Smtp-Source: AGHT+IHXkobD8K3/QjhypGC53V4wE7Wqgr3NDwQ6ESNDr5WO/bsIbVIC15NStxk5bvlaXc9r9vtUtUHemqpAxlu8/9A=
X-Received: by 2002:a05:600c:4897:b0:40c:1de7:41d5 with SMTP id
 j23-20020a05600c489700b0040c1de741d5mr3522673wmp.87.1702399493727; Tue, 12
 Dec 2023 08:44:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1702325874.git.dxu@dxuuu.xyz> <8ec1b885d2e13fcd20944cce9edc0340d993d044.1702325874.git.dxu@dxuuu.xyz>
 <CAHsH6GsdqBN638uqUm+8QkP1_45coucSTL7o=D2wFW-gYjPaBw@mail.gmail.com>
 <7yjkfhrwdphtcljq3odv4jc6lucd32wcg277hfsf4ve2jbo7hp@vuqzwbq5nxjw>
 <CAHsH6Gs1vUQnhR_a4qFnAF37Vx=68Do28sfVfFxQ9pVj9jSzjw@mail.gmail.com>
 <qiv464c4y43mo5rih5k6lgzkbpnj6wsrl52hrhgbxeqj45atun@szmqlmnccm52>
 <CAHsH6Gujycb9RBuRk7QHorLe0Q=Np_tb3uboQfp9KmJnegVXvw@mail.gmail.com> <fwadmdjjogp4ybfxfpwovnmnn36jigffopijsuqt4ly4vxqghm@ysqhd25mzylp>
In-Reply-To: <fwadmdjjogp4ybfxfpwovnmnn36jigffopijsuqt4ly4vxqghm@ysqhd25mzylp>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 12 Dec 2023 08:44:42 -0800
Message-ID: <CAADnVQKpXpqMr9jmc8RKLcL822ir0wA7bEN2h6dEo=6Y60qgWQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 9/9] bpf: xfrm: Add selftest for bpf_xdp_get_xfrm_state()
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Eyal Birger <eyal.birger@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Shuah Khan <shuah@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	antony.antony@secunet.com, Yonghong Song <yonghong.song@linux.dev>, 
	Eddy Z <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, devel@linux-ipsec.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 8:17=E2=80=AFAM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
>
> If you don't mind (and there no more comments), I would prefer to send a
> follow up fixing the nits in this revision. So that I stop blasting the
> list (as well as people who may not be as concerned with these details).

Resending patches is little effort while follow up patches
double the commits, more code churn, increase in code reviews, etc.
Always address feedback by resending.

