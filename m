Return-Path: <linux-kselftest+bounces-16199-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC0E95D945
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Aug 2024 00:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6682F28647F
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 22:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934EC1C8FB6;
	Fri, 23 Aug 2024 22:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eoGt3Lk5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F88B191F6B;
	Fri, 23 Aug 2024 22:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724452135; cv=none; b=koUNy5jQTW93sKvFkjBz1ohC746nA+v3a/zH2xes70BenaDMhbM+oX/A7iGA9quYr1E5mJD3jNbHVdRwh8LQC3MK+LZDCZ33jrjKLPEjnLZrYHxk5QQPw2lqBY5thmQGxfsllkO8XgAroyyGrn6oGOOoPE/Zoordu0h/S/9yea0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724452135; c=relaxed/simple;
	bh=lhFa9C+TdLA9AgtlhB86iziIxZ2TXHCWtZB1vVjHBhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MpZ7qluwTEViuy/zzRbplw7W0h1C7jpzxAYFMl2HVtRfjOw8ce8JC3vnw81/brflFY/biecbvtZRHZiaFblY+XTbx09xwmw0Va+XztxIApXlIGhEckFTee1bE6E+Sjgoc02Wto56yzG2Uz1U0M5hG+TnXxhl43OAJWU7C4AzApM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eoGt3Lk5; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-429da8b5feaso25471125e9.2;
        Fri, 23 Aug 2024 15:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724452132; x=1725056932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWtV3/DOt8P4Xpd14+mqShRwy4l1Z4jup7YrAn/As/k=;
        b=eoGt3Lk5h8fuUauRSQT+ylePqwjJdA+2xEonafeov1/xrb4ndZB6yKzdENgmmqeYcs
         +vm/Gi3MJ1ppaJMOzN6MwFbdo2r1/oxV0VMQks6DeYPnuU84yiDxYJUqO68/fB8l+A//
         dTwMypuos5AJFhEqQaL1D0njyJ6nSnDITUg7IPISvH5m8lqSmnxq7HCYOj07aTwnnPdv
         bP8HYSP+jtOXNQDzzMcbAVaSWFBX/8Bf++rgGhqf1EsYnF1/Fh9d4W42FI5YsdVX9FnC
         ifG1eUQ/lE2I2sb9NrjXEDu8jDd6g0sUnkKQ134hfB+k1qezDY9ojEzBINHIrKivkAi0
         9G9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724452132; x=1725056932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWtV3/DOt8P4Xpd14+mqShRwy4l1Z4jup7YrAn/As/k=;
        b=fsoK6IpuVs5gzMm7b5PkTzdHnrMZxZHoxfPJMo3Yt8YSKiDSx+WpuGPYGP4V1yXQqd
         Od/gtqMMiP8NGeJlt75tAICtWGugkGcabACJxXqA/fT0k+xOXSSpf3EIupz5O1oHw7r1
         RqnNyi1GBL8f/WGLPewkH36dMPcLK0ic39nzgh9x+wKvKixtiX4yLvI288xOv5zu7jL7
         mA4ceArKDvAYHsCw6MSHdZ7bir7C1zWhOB1SQ+7yAKjivRZXaSqHDfLkTIatRzKyKfBb
         nfw5WAepYf0ZgMqA0mFdA/1bsv+KXU6MFwwT+XW0jowpn5JidoTRvc6XY5ihfULFtBMu
         w/tw==
X-Forwarded-Encrypted: i=1; AJvYcCVhMvsOMqSjTuFd31iKjUkrCr0xOtVeIbqqlUVbSomQ5WV3vFXCSk+EL2roMAU4JWT0k2uT91NQw0fP6fpE@vger.kernel.org, AJvYcCVj1TAi3gXfhzJGJNvXavmGnPBKnzqxpnJpTkNmCXrQtmTKJYbER7zcP2DUG88OMUee1x9KMP2q@vger.kernel.org, AJvYcCVsdSxxdf1rv5zC2tjQRkNRmVx2BmeZxHaIvdzhHDgZ5bMu/pcVXXECS9GJJ++cURjgtIg=@vger.kernel.org, AJvYcCXkHSMMn5SvPCrV+ovSjnVy0AWWWwTvEWXaphz0kBCRthhdTfHRxMd23OLmmdRWpN8wcot/2nDC4bR5bXhEXzZD@vger.kernel.org
X-Gm-Message-State: AOJu0YyIPFtcow+VgEnziaHUeNoPzFGIw50r/wzXlBokEepHsQscaEQn
	EaFL+4JsR3iEpXjlR52o89LVrVSJtsAQ+evAimL/f2eZtRumikCC8SCrh+vdGbsIutJxdEAm4je
	3cv3T9M6LpiraGMBWB7lgyLX6L+k=
X-Google-Smtp-Source: AGHT+IHC28T0OxdS5xfWVXMn6jPEmfd/fTwBRe4M2YVY0z1mCKUZOIrmxvOKGo0k/glS1YBPx9wJCuP9gjWxOW50vjk=
X-Received: by 2002:a5d:58d9:0:b0:368:6564:751b with SMTP id
 ffacd0b85a97d-37311864454mr2589305f8f.32.1724452131607; Fri, 23 Aug 2024
 15:28:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816-ups-bpf-next-selftests-use-khdr-v1-0-1e19f3d5b17a@kernel.org>
 <20240816-ups-bpf-next-selftests-use-khdr-v1-1-1e19f3d5b17a@kernel.org>
 <CAADnVQ+JBq8-6Rhi_LHX470uj2_2xxJAhgdUfg_abUxEDqpdJQ@mail.gmail.com> <6a693ad6-f145-48c1-b3a7-d441d3764e73@kernel.org>
In-Reply-To: <6a693ad6-f145-48c1-b3a7-d441d3764e73@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 23 Aug 2024 15:28:40 -0700
Message-ID: <CAADnVQKnEuQ4XZROLWH47mEZNwnJ9TuyTrauOnuobcLgVMrimw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] selftests: bpf: use KHDR_INCLUDES for the
 UAPI headers
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 17, 2024 at 7:51=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Alexei,
>
> Thank you for the review.
>
> On 17/08/2024 09:22, Alexei Starovoitov wrote:
> > On Fri, Aug 16, 2024 at 7:56=E2=80=AFPM Matthieu Baerts (NGI0)
> > <matttbe@kernel.org> wrote:
> >>
> >> Instead of duplicating UAPI header files in 'tools/include/uapi', the
> >> BPF selftests can also look at the header files inside the kernel
> >> source.
> >>
> >> To do that, the kernel selftests infrastructure provides the
> >> 'KHDR_INCLUDES' variable. This is what is being used in most selftests=
,
> >> because it is what is recommended in the documentation [1]. If the
> >> selftests are not executed from the kernel sources, it is possible to
> >> override the variable, e.g.
> >>
> >>   make KHDR_INCLUDES=3D"-I${HDR_DIR}/include" -C "${KSFT_DIR}"
> >>
> >> ... where ${HDR_DIR} has been generated by this command:
> >>
> >>   make headers_install INSTALL_HDR_PATH=3D"${HDR_DIR}"
> >>
> >> Thanks to 'KHDR_INCLUDES', it is no longer needed to duplicate header
> >> files for userspace test programs, and these programs can include UAPI
> >> header files without the 'uapi' prefix.
> >>
> >> Note that it is still required to use 'tools/include/uapi' -- APIDIR,
> >> which corresponds to TOOLS_INCLUDES from lib.mk -- for the BPF program=
s,
> >> not to conflict with what is already defined in vmlinux.h.
> >>
> >> Link: https://docs.kernel.org/dev-tools/kselftest.html#contributing-ne=
w-tests-details [1]
> >> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> >> ---
> >>  tools/testing/selftests/bpf/Makefile                       | 2 +-
> >>  tools/testing/selftests/bpf/prog_tests/assign_reuse.c      | 2 +-
> >>  tools/testing/selftests/bpf/prog_tests/tc_links.c          | 4 ++--
> >>  tools/testing/selftests/bpf/prog_tests/tc_netkit.c         | 2 +-
> >>  tools/testing/selftests/bpf/prog_tests/tc_opts.c           | 2 +-
> >>  tools/testing/selftests/bpf/prog_tests/user_ringbuf.c      | 2 +-
> >>  tools/testing/selftests/bpf/prog_tests/xdp_bonding.c       | 2 +-
> >>  tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c | 2 +-
> >>  tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c | 2 +-
> >>  tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c   | 2 +-
> >>  tools/testing/selftests/bpf/prog_tests/xdp_link.c          | 2 +-
> >>  tools/testing/selftests/bpf/xdp_features.c                 | 4 ++--
> >>  12 files changed, 14 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/self=
tests/bpf/Makefile
> >> index 4eceb491a8ae..6a7aeae7e206 100644
> >> --- a/tools/testing/selftests/bpf/Makefile
> >> +++ b/tools/testing/selftests/bpf/Makefile
> >> @@ -37,7 +37,7 @@ CFLAGS +=3D -g $(OPT_FLAGS) -rdynamic               =
                    \
> >>           -Wall -Werror -fno-omit-frame-pointer                       =
  \
> >>           $(GENFLAGS) $(SAN_CFLAGS) $(LIBELF_CFLAGS)                  =
  \
> >>           -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)        =
  \
> >> -         -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
> >> +         -I$(TOOLSINCDIR) $(KHDR_INCLUDES) -I$(OUTPUT)
> >>  LDFLAGS +=3D $(SAN_LDFLAGS)
> >>  LDLIBS +=3D $(LIBELF_LIBS) -lz -lrt -lpthread
> >>
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/assign_reuse.c b/t=
ools/testing/selftests/bpf/prog_tests/assign_reuse.c
> >> index 989ee4d9785b..3d06bf5a1ba4 100644
> >> --- a/tools/testing/selftests/bpf/prog_tests/assign_reuse.c
> >> +++ b/tools/testing/selftests/bpf/prog_tests/assign_reuse.c
> >> @@ -1,6 +1,6 @@
> >>  // SPDX-License-Identifier: GPL-2.0
> >>  /* Copyright (c) 2023 Isovalent */
> >> -#include <uapi/linux/if_link.h>
> >> +#include <linux/if_link.h>
> >
> > No. This is not an option.
> > User space shouldn't include kernel headers like this.
> > Long ago tools/include directory was specifically
> > created to break such dependency.
> > Back then it was done for perf.
>
> I'm sorry, but I think we are not talking about the same thing here:
> here, I'm only modifying the "normal" userspace programs, not the ones
> used to generate the BPF objects. Perf is a special case I suppose, it
> needs to know the kernel internals. It is the same with BPF programs
> requiring vmlinux.h. But I think "normal" userspace programs in the
> sefltests can use the UAPI headers, no?

Not really. perf is a normal user space that doesn't look into
kernel internals.
It's used to rely on a few .h from kernel src tree for convenience,
since they're not present in what's installed after 'make headers'.
Hence the tools/include dir was created.

Using KHDR_INCLUDES is fine, but it's not ok to search replace
s/uapi\/linux/linux/ everywhere.
Like the example I quoted above.
tools/.../if_link.h is much older than include/uapi/linux/if_link.h
and it's ok.
We're not planning to update it.
It's like building selftests on the system with older glibc.
There is no requirement to have every .h in the tools/ dir
up-to-date with the latest in include/.
We're doing it for bpf.h because new selftests typically need
something from bpf.h that was just added in the previous patch.

> I understand that I could indeed fix my initial problem by duplicating
> mptcp.h in tools/include/uapi/linux/, but this doesn't look to be
> allowed any more by the Netdev maintainers, e.g. recently, 'ethtool.h'
> has been duplicated there in commit 7effe3fdc049 ("tools: Add ethtool.h
> header to tooling infra"), but removed quickly after in commit
> bbe91a9f6889 ("tools: remove redundant ethtool.h from tooling infra").
> In this case, it was fine to simply drop it, because the linked test
> doesn't require a recent version. Jakub mentioned [4] that these
> duplicated headers should be avoided, and the ones generated by 'make
> headers' should be used instead: what is being suggested here.

This is a different issue. There are very few .h in tools/ that
needs a sync.
bpf.h is one of them. ethtool.h is certainly not.

you need something for mpctp.h. Let's talk about it,
but switching everything to KHDR_INCLUDES is not ok,
since there are a bunch of things in play.
Sometimes selftests are built standalone and with non-glibc-s.

Also realize that bpf selftests are not really kselftests.
We use a few common .mk for convenience. That's about it.

