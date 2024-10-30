Return-Path: <linux-kselftest+bounces-21129-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA939B67AE
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 16:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91D691C2190B
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 15:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D53213EE2;
	Wed, 30 Oct 2024 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FrhzbvM5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59A2213ED9
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Oct 2024 15:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730301571; cv=none; b=m6WT/J/q3yHrGQtgJpnchGj7zgQpwy/UX5oCVge1ueRqdgn9BDh/xJKAPY23Yjd8TcmMzqrf2RZKPDmuEK9GzAnxjmybH1OFfSP1NNXW/MacIO/iahtc3nbnlHDFxNsKvPmqo2nMMN7Tf8ovG6qlkZutCn8bKkDlda5fxDR+f6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730301571; c=relaxed/simple;
	bh=lJnGuusQCAELCp7rqkmBqFsUdmlzbjlJEOwppjDChmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MhdjYM6eDJYw3nmtb5qtlffBAJKtditsKRWWzMUuO5r70lJx+MWR9jIs4+KWQziWtHkVm6ytiYP5qjEp4+vuUeQorsmJPV3W9X+vzgJaQEgAiXmXhkS8Xs5bhO2OUcM7fRazHKy9sMtCXkktW2R3cpKnJnGG0aB6SRK8Ip98yws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FrhzbvM5; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-460a8d1a9b7so306341cf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Oct 2024 08:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730301569; x=1730906369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8svNofplrG2Q6V5+9hfVfJTbtmZizG7D9AXysNLGCE0=;
        b=FrhzbvM5rX86CvZcNatYjq0eN/6N2MDAodE+TiouLaIKzw55rM2FwitrTsltFdOkzN
         S43yhjM+f0pL8CEtddnkix8tl9MKpmnTbIa6bDq8YrfLrICONrjjdEsbvoa3Sq6DbaBg
         NpWkWb3mx/n18ZJvjxutU2XMZJSJPi9UreHKPokG4ahYFgN1Pa6TvnIfzNZ4ro6EYChJ
         f9vX3DdG7DhzVoZhwuF6/LSxwX+71qw72kHtwQDQqo2ygd7AaF234OhXUgQqVyJPRFh/
         9q3VMdr0IG30oSoGlXSe5LhZRhFQNlebbl+DW/TSKRU2u6u5SDM6inIYc8b1WSI6o5i+
         SQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730301569; x=1730906369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8svNofplrG2Q6V5+9hfVfJTbtmZizG7D9AXysNLGCE0=;
        b=SG9vKHNhvau9ZEKO6DbKkahYP7ZIMQsa4MuRmnTw6G/DsNJbsvCkZm/kNipXN2RZ0D
         S57xedlMJk50IvoU+O7TYpqP6M04uuyD64pzreIE+4xtaHA4AxZ8g1o7SvazHLzG3CEd
         jUlMXQ9Kx8AOYEFDc2VHN1xLmLnScRlM2/psvJWpHf5JPOQPhsksmad26NAGFOUqr+jG
         JgMnniral2H165P0EQe9AIKUJ5LPL3SF/wYFCpYDIjdTpsSGhyZb4HU7XS1gJPEzoEUw
         47pTe+xy8vZFL4Rlg0Fmg/Pl7pkJcBDNArSMniGpkGUhLftjYeenxElbALJhic9Re81A
         jvEg==
X-Forwarded-Encrypted: i=1; AJvYcCVsFpfVqRfeFOQqqDAomJGIeGlB/vQyW2zZwY28ZIulrM0tUPJzlYtz5MfWr/7tZ5t0Did9QCyIZmLOZt+pCpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKT7Hd/xBzeJylfYvKFDtCH51fdE83Tg3Rf6vniYV2M86Z2BCe
	4MI3Eo1CvQ2iDo1g+pSHfIlMHI3Py7yqG1hqWk248k1dd9HKDGnzaFtcleh7BDDY9bKzB2m63Sj
	y/vhoPfMWCeN0aOy4NxtUJI+Xs5FQIHYxNuxX
X-Gm-Gg: ASbGnctmfKaMtpz2kNM9a6sqCq/FVmgs4a2ZUh67Hw3T4gjQkvyDd+2yNwGTjBQh1xf
	DsmIj/YgCv97vnk/qNwLlHdihPj11mkg=
X-Google-Smtp-Source: AGHT+IE/yEH6zX+iddMnL8L5gybyWZzy+HVsRSlydG/ggXxEumZX5LgIE3lQOa8f/K9UZie0EgbC3H5cMcOhq0THBss=
X-Received: by 2002:ac8:776a:0:b0:461:6727:253f with SMTP id
 d75a77b69052e-4616727292amr6108901cf.24.1730301568454; Wed, 30 Oct 2024
 08:19:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030142722.2901744-1-sdf@fomichev.me> <CAHS8izOBp4yXBg-nOSouD+A7gOGs9MPmdFc9_hB8=Ni0QdeZHg@mail.gmail.com>
 <ZyJM_dVs1_ys3bFX@mini-arch>
In-Reply-To: <ZyJM_dVs1_ys3bFX@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 30 Oct 2024 08:19:16 -0700
Message-ID: <CAHS8izN6-5RJgKX08sgntYDVgETkBGpgoYToq8ezcy+tYHdaSA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 00/12] selftests: ncdevmem: Add ncdevmem to ksft
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	andrew+netdev@lunn.ch, shuah@kernel.org, horms@kernel.org, willemb@google.com, 
	petrm@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 8:13=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 10/30, Mina Almasry wrote:
> > On Wed, Oct 30, 2024 at 7:27=E2=80=AFAM Stanislav Fomichev <sdf@fomiche=
v.me> wrote:
> > >
> > > The goal of the series is to simplify and make it possible to use
> > > ncdevmem in an automated way from the ksft python wrapper.
> > >
> > > ncdevmem is slowly mutated into a state where it uses stdout
> > > to print the payload and the python wrapper is added to
> > > make sure the arrived payload matches the expected one.
> > >
> > > v6:
> > > - fix compilation issue in 'Unify error handling' patch (Jakub)
> > >
> >
> > Since I saw a compilation failures on a couple of iterations I
> > cherry-picked this locally and tested compilation. I'm seeing this:
>
> Are you cherry picking the whole series or just this patch? It looks
> too broken.
>
> > sudo CFLAGS=3D"-static" make -C ./tools/testing/selftests/drivers/net/h=
w
> > TARGETS=3Dncdevmem 2>&1
> > make: Entering directory
> > '/usr/local/google/home/almasrymina/cos-kernel/tools/testing/selftests/=
drivers/net/hw'
> >   CC       ncdevmem
> > In file included from ncdevmem.c:63:
> > /usr/local/google/home/almasrymina/cos-kernel/tools/testing/selftests/.=
./../../tools/net/ynl/generated/ethtool-user.h:23:43:
> > warning: =E2=80=98enum ethtool_header_flags=E2=80=99 declared inside pa=
rameter list
> > will not be visible outside of this definition or declaration
> >    23 | const char *ethtool_header_flags_str(enum ethtool_header_flags =
value);
> >       |                                           ^~~~~~~~~~~~~~~~~~~~
> > /usr/local/google/home/almasrymina/cos-kernel/tools/testing/selftests/.=
./../../tools/net/ynl/generated/ethtool-user.h:25:41:
> > warning: =E2=80=98enum ethtool_module_fw_flash_status=E2=80=99 declared=
 inside
> > parameter list will not be visible outside of this definition or
> > declaration
> >    25 | ethtool_module_fw_flash_status_str(enum
> > ethtool_module_fw_flash_status value);
> >       |                                         ^~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~
> > /usr/local/google/home/almasrymina/cos-kernel/tools/testing/selftests/.=
./../../tools/net/ynl/generated/ethtool-user.h:6766:45:
> > error: field =E2=80=98status=E2=80=99 has incomplete type
> >  6766 |         enum ethtool_module_fw_flash_status status;
> >       |                                             ^~~~~~
>
> This has been fixed via '#include <linux/ethtool_netlink.h>'
>
> > ncdevmem.c: In function =E2=80=98do_server=E2=80=99:
> > ncdevmem.c:517:37: error: storage size of =E2=80=98token=E2=80=99 isn=
=E2=80=99t known
> >   517 |                 struct dmabuf_token token;
>
> And this, and the rest, don't make sense at all?
>
> I'll double check on my side.

Oh, whoops, I forgot to headers_install first. This works for me:

=E2=9E=9C  cos-kernel git:(tcpdevmem-fixes-1) =E2=9C=97 sudo make headers_i=
nstall &&
sudo CFLAGS=3D"-static" make -C ./tools/testing/selftests/drivers/net/hw
TARGETS=3Dncdevmem 2>&1
  INSTALL ./usr/include
make: Entering directory
'/usr/local/google/home/almasrymina/cos-kernel/tools/testing/selftests/driv=
ers/net/hw'
make: Nothing to be done for 'all'.
make: Leaving directory
'/usr/local/google/home/almasrymina/cos-kernel/tools/testing/selftests/driv=
ers/net/hw'
=E2=9E=9C  cos-kernel git:(tcpdevmem-fixes-1) =E2=9C=97 find . -iname ncdev=
mem
./tools/testing/selftests/drivers/net/hw/ncdevmem

Sorry for the noise :D

--=20
Thanks,
Mina

