Return-Path: <linux-kselftest+bounces-25793-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22609A282CC
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 04:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B61F91886A2A
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 03:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AB2212F9F;
	Wed,  5 Feb 2025 03:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDaKYS/I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AA379FE;
	Wed,  5 Feb 2025 03:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738726094; cv=none; b=L2FUCPUcOp8yKN4dKDRuo6zM4kCCUJSUUGCZeDlkx6zIjIoCwEkgskaEDWw9VQpgRT+JLoBGgCTbfOLR8ngG//OFXMiP2qvnPijJib2yCvgOx9OOO8xLG/+9ePPVhfgkGYSrDRzmxQipbDKDVQr1hn0zYexvTsTMlEitHERxO0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738726094; c=relaxed/simple;
	bh=nTJ60qrMV408Msexwf7oifg9Ppw0JO1A7faKf69mdiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pftu9W/xucUDVrCdT27foIjO4fui5qGYsD3qCZq81uM8w9R1cHQhmm8uN/5TROlE699DmC65DPmgMDJVIHqqAL0q1fCnbi4UZp3F7t0mLyk5+Upnu8UbQJHU5Hq1+4KNnU+AvLei8GMewaQWZkzyXOlG+SDx+yH9tPYsJ794dzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDaKYS/I; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3cfeff44d94so16342445ab.0;
        Tue, 04 Feb 2025 19:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738726092; x=1739330892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFvvWVUJyQlbDzeQH/SADJYRLUdLozQtn/zK3w7wvik=;
        b=QDaKYS/IoIDMeQxQLaYIWnGgT2WChx6ONNL+WtgtlPjZRFhNl3fzTi0CZoUcDRFJK1
         7ICtyM7pKANgM9bbAmAyDDtepIPLkFufOLHmPn44P5H612OcINk5Si2DvST24PZqybNO
         M6QKOP9XtgUsKqDeAbbOOIuRYLLhdhL9QhTi+NZbH47/hMK6O1ekkpFPqVIRVycnOEfL
         HoPNo2LKXBSwnw/BXL+L86fspo5Ay+uITIGu+Gptr4YtW0SzZ1e5tfjup6CvIqQ5yQEc
         WZPqRrjNDk07ekPmD56ucYHaRXjFrAA7W1KhTlJr8IxZsFxXU5+SI0MOQqmDm8a1SPjV
         vVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738726092; x=1739330892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFvvWVUJyQlbDzeQH/SADJYRLUdLozQtn/zK3w7wvik=;
        b=MOXTCwZdgNznvCGxEdmRqtNvRQjktmabQvYZhDPVPuAaLLhWpBOkUPbUccMHTfPyak
         istl7xqp0lnjkQcem6lW3GM5jCwjnbKfC+EFhgpE+JRbNORSt0Ts0yy/2PYlNQ+vF7Pz
         Joy/QJWozhjnwMQSHcHe9w++Sqf0E6cS/YU6MUvVGAsWSlG5e9ducD82AWY6w6LjAtl1
         0cToez1dsElXdLEs1cc7sYknx6OoTyEmTlw2aRrTjMOLlamoYeSETu/hV1EufwvQ/aU6
         Ahnj7bwyTCxTPrlHQ9PQDXDDGZNKNV88E3dUyZ/hEo8dsygg/By3M4B/ooxebdaEBJNa
         Z8iA==
X-Forwarded-Encrypted: i=1; AJvYcCUVscgce7DXLx+8JKotAnmbL9hzyw2q4NE3pGzwnn1ri9rNYq+Tlbeg1Bs84lGrVAycgvA7hYlyXgtpqYtTY+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEy4vv2NoGryMaFiT3lWH6+Tn0nxRmFjWfp/5frztpmw61VpYj
	/TpSKqJBQF2MzQUi7MQfqwc9VA2CGtoQh72xEe1NR0mNWo33SJR50dHSx2y/4gI6fuaImvPa53q
	UEe6mjf+q/8nKC0AhjioNJkJ4CZI=
X-Gm-Gg: ASbGnctQpubDyBthq9SPSq8D5sZ+rqep9NE9rkKyqC93T4XcaA57/4p+LZEPW/QiHMc
	oEz93YRLUbwl2CS3EJ8Z1H98IkGFzvgoe31iVk0c8keyhdlf1kgqJ01qu+EGA/50AEp5Dpk2K
X-Google-Smtp-Source: AGHT+IFALx6KnI2luU/9rCyrVeA205AXOLCHwGLslZasLde8G6ibR4TvR84HK7MgnU7TKRCL29vHwqpLFzZA/j5e2dg=
X-Received: by 2002:a05:6e02:1542:b0:3d0:235b:4810 with SMTP id
 e9e14a558f8ab-3d04f403570mr13744705ab.2.1738726091874; Tue, 04 Feb 2025
 19:28:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204023946.16031-1-kerneljasonxing@gmail.com>
 <20250204023946.16031-3-kerneljasonxing@gmail.com> <99ccf971-cae5-9c45-5dff-2c8563a7879f@huaweicloud.com>
In-Reply-To: <99ccf971-cae5-9c45-5dff-2c8563a7879f@huaweicloud.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 5 Feb 2025 11:27:35 +0800
X-Gm-Features: AWEUYZniPthOC91UScEwt6P9XvOIQg32SPDTCjGhZfv5H-XarXD74v5DeQy0F9U
Message-ID: <CAL+tcoAkyjDQd48wKuA8V_RE6j1OYTL2iGxT8HdVKpryD3SaUA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] bpf: sockopt_sk: fix 'undeclared'
 definition error
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 10:57=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> On 2/4/2025 10:39 AM, Jason Xing wrote:
> > Error messages:
> > selftests/bpf/prog_tests/sockopt_sk.c: In function =E2=80=98getsetsocko=
pt=E2=80=99:
> > selftests/bpf/prog_tests/sockopt_sk.c:22:31: error: field =E2=80=98zc=
=E2=80=99 has incomplete type
> >    struct tcp_zerocopy_receive zc;
> >                                ^~
> > selftests/bpf/prog_tests/sockopt_sk.c:169:32: error: =E2=80=98TCP_ZEROC=
OPY_RECEIVE=E2=80=99 undeclared (first use in this function)
> >   err =3D getsockopt(fd, SOL_TCP, TCP_ZEROCOPY_RECEIVE, &buf, &optlen);
> >                                 ^~~~~~~~~~~~~~~~~~~~
> >
> > Fix it by introducing the right header.
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/prog_tests/sockopt_sk.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tool=
s/testing/selftests/bpf/prog_tests/sockopt_sk.c
> > index ba6b3ec1156a..e0a9785ffcdc 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> > @@ -2,7 +2,7 @@
> >  #include <test_progs.h>
> >  #include "cgroup_helpers.h"
> >
> > -#include <netinet/tcp.h>
> > +#include <uapi/linux/tcp.h>
>
> Should it be <linux/tcp.h> instead ?

I thought that too, but I altered my thoughts after reading this
commit[1], totally without knowing why the tcp part should be changed.
Should I change it back?

> Directly including uapi header file
> in application seems weird.

After greping the tools/testing/selftests/bpf, we see some similar
usage like including a uapi header file.

[1]
commit a2f482c34a52176ae89d143979bbc9e7a72857c8
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>
Date:   Wed Nov 20 08:43:21 2024 +0100

    selftests/bpf: use the same udp and tcp headers in tests under test_pro=
gs

    Trying to add udp-dedicated helpers in network_helpers involves
    including some udp header, which makes multiple test_progs tests build
    fail:

    In file included from ./progs/test_cls_redirect.h:13,
                     from [...]/prog_tests/cls_redirect.c:15:
    [...]/usr/include/linux/udp.h:23:8: error: redefinition of =E2=80=98str=
uct udphdr=E2=80=99
       23 | struct udphdr {
          |        ^~~~~~
    In file included from ./network_helpers.h:17,
                     from [...]/prog_tests/cls_redirect.c:13:
    [...]/usr/include/netinet/udp.h:55:8: note: originally defined here
       55 | struct udphdr
          |        ^~~~~~

    This error is due to struct udphdr being defined in both <linux/udp.h>
    and <netinet/udp.h>.

    Use only <netinet/udp.h> in every test. While at it, perform the same
    for tcp.h. For some tests, the change needs to be done in the eBPF
    program part as well, because of some headers sharing between both
    sides.

Thanks,
Jason

