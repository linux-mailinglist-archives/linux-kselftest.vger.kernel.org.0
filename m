Return-Path: <linux-kselftest+bounces-611-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 999407F9094
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Nov 2023 01:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9673CB20E46
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Nov 2023 00:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2A4A5A;
	Sun, 26 Nov 2023 00:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JO0XbUDa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4475218C;
	Sat, 25 Nov 2023 16:54:59 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40b427507b7so2726985e9.2;
        Sat, 25 Nov 2023 16:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700960098; x=1701564898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pm7530G9R5pfBVSHYb/dMQNQOiOAcGaPuFGYV7ZlkY4=;
        b=JO0XbUDa7+8Q04cgweiWXtN1WiPF/yS/Z7UGRxGlPNQgJGQujHbEhllqg6jve1JVYk
         iNN1raYRoh7pcTx61qdEqmoQw5GECQNStygGB+z/MmGjgIZ1nGscjtXxIOpS4jR/mEiS
         1ZRVTaNhYl0dvhM/lov4kHPtDKO4Lycuagh5xS8lTG44GumwyBdn060I7B1vldef49jF
         7mMLbtWlKPtr4GgCpIkqQMVGlE6WRd1RUAoOYIIABxC+kTnd0Ihe7AJ2d4pqDyNOCLzO
         riKEeN14gAVnNeH+sd6jRM3yRXR7OgWOyclFc58x1KouK2a6H3ebtdlKjl6ALsoR24Ga
         07CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700960098; x=1701564898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pm7530G9R5pfBVSHYb/dMQNQOiOAcGaPuFGYV7ZlkY4=;
        b=QVibthDLSpbzfToBMBLxqQjsgC+nvyvIlWLEvJy8002oMzv6SHiV1vqWBhOPyiUCQZ
         iF15moqt4ieviebSSRwBT1KfRJRb1FYoa5Of2yAC5S+xJT66pjHoMlNkf7n5zHgVM5C+
         uQmyn26/kaQk0zqd7sWsQ90SjQHQ8gh4UIA6GFoesKNNwQacA68CnjMNT5TyY31QWuUH
         IzHNQGSm4zBPaNJT37SFd33/ksFg2BqmebEs4JFP+uBJCQ8ik6RhKys5Cy6px44Nx1ls
         gacc3Rn5HZ+J6hF7JfQS0awyDuPuuqu6z/3Mv7/lB0SP80AWT+QFWMzqQaqpzaNp13Ku
         jlBA==
X-Gm-Message-State: AOJu0YwMpPskqarsNh/coFI+MV4CYYUeHmrmtDkeJ9A6obqtMJpYPJ+f
	QPiPqpxrA9/7UlD91xCGCd1bqUjfvPKJj3nOllU=
X-Google-Smtp-Source: AGHT+IH++JIbUbFM43WMSEWN2z1o9IPTwtGX0GlAeWCk3ZQguHRZjShL2HsLBUhg/r1xzUXzw9CBivZkeuEjlKugMt4=
X-Received: by 2002:a05:600c:1546:b0:405:3a3b:2aa2 with SMTP id
 f6-20020a05600c154600b004053a3b2aa2mr5697695wmg.37.1700960097336; Sat, 25 Nov
 2023 16:54:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1700676682.git.dxu@dxuuu.xyz> <391d524c496acc97a8801d8bea80976f58485810.1700676682.git.dxu@dxuuu.xyz>
 <0f210cef-c6e9-41c1-9ba8-225f046435e5@linux.dev>
In-Reply-To: <0f210cef-c6e9-41c1-9ba8-225f046435e5@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 25 Nov 2023 16:54:45 -0800
Message-ID: <CAADnVQ+sEsUyNYPeZyOf2PcCnxOvOqw4bUuAuMofCU14szTGvg@mail.gmail.com>
Subject: Re: [PATCH ipsec-next v1 6/7] bpf: selftests: test_tunnel: Disable
 CO-RE relocations
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Daniel Xu <dxu@dxuuu.xyz>, Shuah Khan <shuah@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, antony.antony@secunet.com, 
	Eddy Z <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	devel@linux-ipsec.org, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 25, 2023 at 4:52=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> >
> > diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/too=
ls/testing/selftests/bpf/progs/test_tunnel_kern.c
> > index 3065a716544d..ec7e04e012ae 100644
> > --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > @@ -6,6 +6,7 @@
> >    * modify it under the terms of version 2 of the GNU General Public
> >    * License as published by the Free Software Foundation.
> >    */
> > +#define BPF_NO_PRESERVE_ACCESS_INDEX
>
> This is a temporary workaround and hopefully we can lift it in the
> near future. Please add a comment here with prefix 'Workaround' to
> explain why this is needed and later on we can earliy search the
> keyword and remember to tackle this.

I suspect we will forget to remove this "workaround" and people
will start copy pasting it.
Let's change the test instead to avoid bitfield access.

