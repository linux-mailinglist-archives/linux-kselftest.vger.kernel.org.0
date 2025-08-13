Return-Path: <linux-kselftest+bounces-38849-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1149B249F7
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 14:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFBD05833CE
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 12:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429F92E5B2B;
	Wed, 13 Aug 2025 12:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpaDS/l6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com [209.85.219.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9E92D4B66;
	Wed, 13 Aug 2025 12:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755089893; cv=none; b=jFp94oRH+1yaBLyMDLKT8ZwC2pKJBsgbEMRho4HJddnPbro87vTdKnGbPLm1i4ijIafF09W9Tv/YT+RYFtEfmnzrh5tSxitx1jXmDkS7tVmCLTEyib/lrgSmKMvo5iE9rtXKXKNbPA9mD8VwvBHE29plWSBzvNJh1iitdUp1XmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755089893; c=relaxed/simple;
	bh=Ol9h+nGBCMOLYE0+Ii6+Lbkj08Z0st/zWgFlhXOqVHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L43ZC6hHkt+V5mqsRBho44OecI8gOYb+lxfVPfB7p+mRwwnjBCIbLb46AattuhNJqFFwwtG/lNHw9hnRP7Kv4j53dgMGZM0x8NsohTmsZDRbAZ2RoxMj9FPzye4J23cUUBAeQL0b9rKko8K4AsyhzNGcbWd/4gC5UP2Sxlb/kmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpaDS/l6; arc=none smtp.client-ip=209.85.219.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f196.google.com with SMTP id 3f1490d57ef6-e75668006b9so6494348276.3;
        Wed, 13 Aug 2025 05:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755089890; x=1755694690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqNRsOjLtroEZv4Oe4QfFtLa60PVWLIcKwoN/xz6KB8=;
        b=QpaDS/l6tRvby+YwUTxhpLw9uYVcLGA8dHnSYzqYjXDbR9E2sLxmoQ/A+kbwMwBC7v
         NfFe89OeokJTNwhujVtugY/EXLIkR8fV0m1TSDxz/rQlwDO2gdcBtffhcqNLoIUpAqDx
         2/CiH2foY3+iEaHLAVwxNrL3uSCdT9kPPtvFNVQlANBWYhOzEQtPIL0yC/CTWKkK8vsY
         f0gxl9bjEhXkT3plRXl0iR13cPpIF8iaLszYlaKOq3UwDpvPMgtrNhItlRth5tui11Ny
         YB/sxP23+tDXcVbQGqjz9JPyG1mzHW2OGOA2gB/wKxZ/2I+HTgersCQjKKgOJVQJ2vZk
         jlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755089890; x=1755694690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TqNRsOjLtroEZv4Oe4QfFtLa60PVWLIcKwoN/xz6KB8=;
        b=IHqTqev/v0OdHd3KCYDzrRDFO+eLFWwOroGO/ZvTmFROC6Ssk36Dol7Nlchx55cx6V
         Il+k8Gc9ADPldCw4AkjGIC7ONxeRJ4ov9I5iDtcF8iGqzbFBb0t7qP9F/b3lP4MUKQ4E
         zGxxg12/Dto3pTllXF1nr/GA0dXhWrkSSTGMYKZQnVJuQoxv+/3+zH/bEPCSKYR4WEUu
         w6RmDg2Ffa3b0sXtR7d63BDC4tPmHol1PSb0FDmQj84rVUCujsLZW5JaVzRJiMT6p76R
         MDMF/eO0h/gYcFttqMc6I0eBoUBTDSviUzQCgBs3KO+gGsrujd9jy03AlXPyBaqaoZ34
         deqw==
X-Forwarded-Encrypted: i=1; AJvYcCVjnIXHLB7/v2AOAvGvbaWLle3XmPoplStK5O9sCQqjje9zFciEXAxcXoOWMIPc4J+fcPAa0qGTDzzlpwK8jP+P@vger.kernel.org, AJvYcCVkW5Vvnnpz58WO13BlmtbfHPHjKyDZydl8dIxOgSJahBh7dWWfjYWQioHM1wHvf3VIl9mrspKg@vger.kernel.org, AJvYcCVoW2lRJuSwrpUHSXK742ysHEGj9zUIfldZW66Zfs14chGfTdjHYGNBO1N1jAUuGmKQItqHd23cKYok4HA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8vTYDIiQCOYFNg+RwRTsT3EfPXYcf9YgY0IAH416eATgVe2Es
	9FovWIe+pnH/uLWunqpkzPZ1+sryNI08k3UKSJTtv4Brf2TcGN/tv8dam9/9cj3YpPFvxoNa6wO
	OFz/r52WpGYwTIfmdnj4resV7Fg34yUJlO2UMeU9ppg==
X-Gm-Gg: ASbGncsfsiFYpFaplMgBgh4MXoyuOMb2albmtAVy8GeueyPGd1LXTOukOCXdOEGX6IA
	jCBZOZuFVUtdz3H0hqGc75JXtxsKhCobrmItbHOTnYi3BmQhNDgJXq6pmJLY8uOy6qqMoTiaqdp
	9zlyBG7dbRK+tzpfiH6nqPqh7QYh25ec0ts8LYr0sz35EDYcOlmYTCvkWep9UGr/xmqWXh4JaQM
	JpUy+g=
X-Google-Smtp-Source: AGHT+IF0/WQgcQsmP7Lpp0cHFMwoDHWDq1xvfOoXY6DiToQuz6uPEEQib8bealhu2P1sBY77o9ggpclq+KreOnrrnU8=
X-Received: by 2002:a05:6902:3201:b0:e90:6d24:6741 with SMTP id
 3f1490d57ef6-e930c0b28a6mr3273573276.31.1755089888473; Wed, 13 Aug 2025
 05:58:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250802092435.288714-1-dongml2@chinatelecom.cn>
 <20250802092435.288714-3-dongml2@chinatelecom.cn> <CAAVpQUBAk=339yyCnG+hDnHEu-O1+WPnAVqX=X9H22T=POQ3Bg@mail.gmail.com>
In-Reply-To: <CAAVpQUBAk=339yyCnG+hDnHEu-O1+WPnAVqX=X9H22T=POQ3Bg@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 13 Aug 2025 20:57:57 +0800
X-Gm-Features: Ac12FXwQCR5tMTH-ADrBdjohJDem4F0tNhlvz5HXZURLgMes4v5lEbOlN3hrJSg
Message-ID: <CADxym3a1cp3kT2UTaQ7kmqEH7_xmKA_PZ7yJEoY3hLeJ05wNCA@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] selftests/net: test TCP reuseport socket selection
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: edumazet@google.com, ncardwell@google.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	shuah@kernel.org, kraig@google.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 3:01=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> On Sat, Aug 2, 2025 at 2:24=E2=80=AFAM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
> >
> > The test script is provided by Kuniyuki in [1], which is used to test t=
he
> > selection of the TCP reuseport socket problem.
> >
> > Link: https://lore.kernel.org/netdev/20250801040757.1599996-1-kuniyu@go=
ogle.com/ [1]
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  tools/testing/selftests/net/Makefile         |  1 +
> >  tools/testing/selftests/net/tcp_reuseport.py | 36 ++++++++++++++++++++
> >  2 files changed, 37 insertions(+)
> >  create mode 100755 tools/testing/selftests/net/tcp_reuseport.py
> >
> > diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selft=
ests/net/Makefile
> > index b31a71f2b372..0f4c3eea9709 100644
> > --- a/tools/testing/selftests/net/Makefile
> > +++ b/tools/testing/selftests/net/Makefile
> > @@ -117,6 +117,7 @@ TEST_GEN_FILES +=3D tfo
> >  TEST_PROGS +=3D tfo_passive.sh
> >  TEST_PROGS +=3D broadcast_pmtu.sh
> >  TEST_PROGS +=3D ipv6_force_forwarding.sh
> > +TEST_PROGS +=3D tcp_reuseport.py
> >
> >  # YNL files, must be before "include ..lib.mk"
> >  YNL_GEN_FILES :=3D busy_poller netlink-dumps
> > diff --git a/tools/testing/selftests/net/tcp_reuseport.py b/tools/testi=
ng/selftests/net/tcp_reuseport.py
> > new file mode 100755
> > index 000000000000..eaeb7096382e
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/tcp_reuseport.py
> > @@ -0,0 +1,36 @@
> > +#!/usr/bin/env python3
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +import os
> > +
> > +from lib.py import ksft_run, ksft_exit
> > +from socket import *
> > +
> > +def test_reuseport_select() -> None:
> > +    s1 =3D socket()
> > +    s1.setsockopt(SOL_SOCKET, SO_REUSEPORT, 1)
> > +    s1.setsockopt(SOL_SOCKET, SO_BINDTODEVICE, b'lo')
> > +    s1.listen()
> > +    s1.setblocking(False)
> > +
> > +    s2 =3D socket()
> > +    s2.setsockopt(SOL_SOCKET, SO_REUSEPORT, 1)
> > +    s2.bind(s1.getsockname())
> > +    s2.listen()
> > +    s2.setblocking(False)
> > +
> > +    for i in range(3):
> > +        c =3D socket()
> > +        c.connect(s1.getsockname())
> > +        try:
> > +            print("SUCCESS: assigned properly:", s1.accept())
> > +        except:
> > +            print("FAIL: wrong assignment")
> > +            os.sys.exit(1)
>
> It seems you don't need to handle an exception with ksft.
> You can see os.sys.exit(1) triggers another exception when
> you run it without patch 1.
>
> TAP version 13
> 1..1
> # timeout set to 3600
> # selftests: net: tcp_reuseport.py
> # TAP version 13
> # 1..1
> # FAIL: wrong assignment
> # # Exception| Traceback (most recent call last):
> # # Exception|   File
> "/root/linux/tools/testing/selftests/net/./tcp_reuseport.py", line 26,
> in test_reuseport_select
> # # Exception|     print("SUCCESS: assigned properly:", s1.accept())
> # # Exception|                                          ~~~~~~~~~^^
> # # Exception|   File "/usr/lib64/python3.13/socket.py", line 295, in acc=
ept
> # # Exception|     fd, addr =3D self._accept()
> # # Exception|                ~~~~~~~~~~~~^^
> # # Exception| BlockingIOError: [Errno 11] Resource temporarily unavailab=
le
> # # Exception|
> # # Exception| During handling of the above exception, another
> exception occurred:
> # # Exception|
> # # Exception| Traceback (most recent call last):
> # # Exception|   File
> "/root/linux/tools/testing/selftests/net/lib/py/ksft.py", line 244, in
> ksft_run
> # # Exception|     case(*args)
> # # Exception|     ~~~~^^^^^^^
> # # Exception|   File
> "/root/linux/tools/testing/selftests/net/./tcp_reuseport.py", line 29,
> in test_reuseport_select
> # # Exception|     os.sys.exit(1)
> # # Exception|     ~~~~~~~~~~~^^^
> # # Exception| SystemExit: 1
> # not ok 1 tcp_reuseport.test_reuseport_select
> # # Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0
> not ok 1 selftests: net: tcp_reuseport.py # exit=3D1
>
>
> btw, I'd write an official uAPI selftest in plain C for socket as
> python sometimes does a tricky thing and I don't trust it.

Yeah, sounds nice, and C has better compatibility and
reliability for the testing.

>
> For example, this is...
>
> from socket import *
>
> s =3D socket()
> s.listen(-1)
>
> internally translated to:
>
> socket(AF_INET, SOCK_STREAM|SOCK_CLOEXEC, IPPROTO_IP) =3D 3
> listen(3, 0)                            =3D 0

