Return-Path: <linux-kselftest+bounces-23257-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD3B9EE757
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 14:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2B30281D48
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 13:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1CD213E6F;
	Thu, 12 Dec 2024 13:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZktGluM3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720F21EEE6;
	Thu, 12 Dec 2024 13:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734008803; cv=none; b=BegvWGSBuKYl9AfaZ2nJyWuCpEArFrwjeD6VU0UN8NrAKWF+nlLg1iL8E5RH+adKmfXZMotW9+NkKqKYqpr3r+Ux8syFaksKq64tVeyph+WdHWIr+qBh+hZ2Lfy0f+tA6Rgr/yF8AvQJufces29J1PZY22+gIlrvEX8WTYhVbgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734008803; c=relaxed/simple;
	bh=QtnJQVvfbhujzCBbhdoVTuAqzhIPgOKP0r086zlDy7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/Apqum03kGBI+CNFfZGWhkzLEQmxNYF0KuZVnuHx+YcgGwq44qEy3hC4R8j2eZWka8LGPclmJEdvFq+Yxb5Ev8Ce4IuTWQVkb9VRVgHAnNwW6KwKrBeph5RV6HU0GLD3rvLXGaXzcQ4hCIKniWZDSqm2vZItpfc6t0c4l4j7r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZktGluM3; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4361fe642ddso5928795e9.2;
        Thu, 12 Dec 2024 05:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734008800; x=1734613600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HqYxTqAiECe9wyyAXaPuVyEXlxRKQjZazVAEQa5Qpbg=;
        b=ZktGluM3dlR/NF+iXXPLFABaWgcjKCjnNLgrvwDNFhu8xp1OFZ5GHABrDQ1Yv/nH8b
         ZFXbXUYcE7TfhLWarn4g6UQBwoOfQM6mD23j1LXBSTY3/EzSP355LtykvKZV/wGip79k
         TwehLk2kIdBMiw3GEOoD4ks6CaoxyvsNl5qtpvYDKf4++YhlJwbcFibtA18/DLzUqKcz
         oc+ZHNejW+ROMyxslfKFhLGSJf1lDQyNIYjhy1+bpgd2Qs1cNaVCbG8P6SRQTTfSur80
         5S6/kJ4Mt9DAa3Sk5fDa/LqseIyKcI4vJAWboLA5o74/7Br09Gv1LAawbXz5Bh7i7Yit
         nI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734008800; x=1734613600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HqYxTqAiECe9wyyAXaPuVyEXlxRKQjZazVAEQa5Qpbg=;
        b=DkuoP9tmR4LAp4upucPVi/gANCEW/N9EYXgvaJN+Sa1kGSLtvaM5b3DnSHUGvw+JOh
         hT3F/y6l6CpiSg9fJJZkUlcbfV/Go4aNCe8wnzO8RnRIyG98sbVK2AdqDYnEmJ7G7Kxb
         RTejDUH10bjxmJUtrIo3Kk+nlKBRcZJ3vn8VqRnurZcfJHRcjbXn4uCWg85hpwB9ao0g
         u+vpyNsGYdAggSUKN0sG5gr86i9nqPuXwBWI5g046ZP+hmjY6ZXYrvpJCxtPsHS3Tv6x
         fRyg4MkAOSxLeiolhik3mCz7az/GLV8fxoBFBZcM5IEHSW3SJmhxqYEyYREfS2AUEKfj
         1/qQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0co2m8kQ87soIcfJKzwNxclsUvo2uyTa37dRPsdaKIFLLr0DEj64pZZ+gAc01qnWFRz27o7rS/Uow@vger.kernel.org, AJvYcCU85PbXeNqOaEBYeGeklIoQ/U3dkw5DVFdTjeOatDS59ghUfie5tO8s4KMbic5xOQ0UTKE=@vger.kernel.org, AJvYcCV5coQ0VWJ42/b1iKHA+SrdRhnkIEv5bG7KP6gkK/EJ7W378Mch/w9K27iMt/BVMLgtKo0BXE6zQBidag==@vger.kernel.org, AJvYcCVFOaHkDV658AHNOOnh3KwwhLhnS9Nm/im/vz2w8QDYDUOmcNToQsMaTwTq/6TwXmkiMMpcsI4pH0q3y5Ts@vger.kernel.org, AJvYcCWb6PWROPDhghXhjuSkH505RNcJFBdDDQLGHnluyGj+Ur1uevI44UmWgh1KolYyezPIl2R/LcfcQxEsAp38j+M=@vger.kernel.org, AJvYcCWhRiDf8Bq+lD7dudbo59mwdKqtcx94TlsWgGz6lhXcmZk2dSU4x8qMWxs/hKuv9WyurK8oiV/JZVRT@vger.kernel.org, AJvYcCWulte37j3DZ41CT1brK37eLXzTMB9e9T5M4DIB1RhdjL52u7C+vipG82iTHvtB+sHVSCY1Mm9J7aKYUw==@vger.kernel.org, AJvYcCXzv9fWxhYf2YBUwR5tw+p4GN9J+gL1fLQBMWskLubscEUPubjsrhqhTk17Xzz8TfmJ1cvCoJX502wAs4b4p9Lc@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9oKm1OleroqTcHb1AE+VsCqnDLoCfA6AuoOVrTYbtLJU/QaLg
	OVsyi3XZId07Fq/1ER1JRz0kCELEY8wQoQ2e3HEyx4+x1cNisdQSaTEp3S0OiNZNOCL+43bx+FW
	DP+Y9HkwYB2wADHhiSkSL5GI0MyI=
X-Gm-Gg: ASbGncu5/2LogKtPmifCLgyTBTx8/o5yaXHqveru4ofL6zY9BrBwuliTgRbCM8j48zr
	w+cT/AzuxNrmCty1TiyoRa8ry15UvK1DiV7Kk
X-Google-Smtp-Source: AGHT+IEgToBDxS7Y2rJTQaW+KRxkcbBuEM1S3SQpzBBgB7EfM9NZPQ+SlbrHysoSI6mEreAZ9kYV8K51n0HSyiFVXHg=
X-Received: by 2002:a05:600c:3acf:b0:434:f8a0:9dd8 with SMTP id
 5b1f17b1804b1-4361c345006mr53002405e9.1.1734008799513; Thu, 12 Dec 2024
 05:06:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209140151.231257-1-shaw.leon@gmail.com> <20241209140151.231257-6-shaw.leon@gmail.com>
 <4a2fe99a-772d-4df1-a8ef-14338682b69e@redhat.com>
In-Reply-To: <4a2fe99a-772d-4df1-a8ef-14338682b69e@redhat.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Thu, 12 Dec 2024 21:06:01 +0800
Message-ID: <CABAhCOQnMGm8y5bVj_fg5veJqim1PEEa02oZHqFt7ZPEQMpFzw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 5/5] selftests: net: Add two test cases for
 link netns
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jakub Kicinski <kuba@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	Hangbin Liu <liuhangbin@gmail.com>, linux-rdma@vger.kernel.org, 
	linux-can@vger.kernel.org, osmocom-net-gprs@lists.osmocom.org, 
	bpf@vger.kernel.org, linux-ppp@vger.kernel.org, wireguard@lists.zx2c4.com, 
	linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, 
	bridge@lists.linux.dev, linux-wpan@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 5:40=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 12/9/24 15:01, Xiao Liang wrote:
> >  - Add test for creating link in another netns when a link of the same
> >    name and ifindex exists in current netns.
> >  - Add test for link netns atomicity - create link directly in target
> >    netns, and no notifications should be generated in current netns.
> >
> > Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
> > ---
> >  tools/testing/selftests/net/Makefile        |  1 +
> >  tools/testing/selftests/net/netns-name.sh   | 10 ++++++
> >  tools/testing/selftests/net/netns_atomic.py | 39 +++++++++++++++++++++
> >  3 files changed, 50 insertions(+)
> >  create mode 100755 tools/testing/selftests/net/netns_atomic.py
> >
> > diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selft=
ests/net/Makefile
> > index cb2fc601de66..f9f7a765d645 100644
> > --- a/tools/testing/selftests/net/Makefile
> > +++ b/tools/testing/selftests/net/Makefile
> > @@ -34,6 +34,7 @@ TEST_PROGS +=3D gre_gso.sh
> >  TEST_PROGS +=3D cmsg_so_mark.sh
> >  TEST_PROGS +=3D cmsg_time.sh cmsg_ipv6.sh
> >  TEST_PROGS +=3D netns-name.sh
> > +TEST_PROGS +=3D netns_atomic.py
> >  TEST_PROGS +=3D nl_netdev.py
> >  TEST_PROGS +=3D srv6_end_dt46_l3vpn_test.sh
> >  TEST_PROGS +=3D srv6_end_dt4_l3vpn_test.sh
> > diff --git a/tools/testing/selftests/net/netns-name.sh b/tools/testing/=
selftests/net/netns-name.sh
> > index 6974474c26f3..0be1905d1f2f 100755
> > --- a/tools/testing/selftests/net/netns-name.sh
> > +++ b/tools/testing/selftests/net/netns-name.sh
> > @@ -78,6 +78,16 @@ ip -netns $NS link show dev $ALT_NAME 2> /dev/null &=
&
> >      fail "Can still find alt-name after move"
> >  ip -netns $test_ns link del $DEV || fail
> >
> > +#
> > +# Test no conflict of the same name/ifindex in different netns
> > +#
> > +ip -netns $NS link add name $DEV index 100 type dummy || fail
> > +ip -netns $NS link add netns $test_ns name $DEV index 100 type dummy |=
|
> > +    fail "Can create in netns without moving"
> > +ip -netns $test_ns link show dev $DEV >> /dev/null || fail "Device not=
 found"
> > +ip -netns $NS link del $DEV || fail
> > +ip -netns $test_ns link del $DEV || fail
> > +
> >  echo -ne "$(basename $0) \t\t\t\t"
> >  if [ $RET_CODE -eq 0 ]; then
> >      echo "[  OK  ]"
> > diff --git a/tools/testing/selftests/net/netns_atomic.py b/tools/testin=
g/selftests/net/netns_atomic.py
> > new file mode 100755
> > index 000000000000..d350a3fc0a91
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/netns_atomic.py
> > @@ -0,0 +1,39 @@
> > +#!/usr/bin/env python3
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +import time
> > +
> > +from lib.py import ksft_run, ksft_exit, ksft_true
> > +from lib.py import ip
> > +from lib.py import NetNS, NetNSEnter
> > +from lib.py import RtnlFamily
> > +
> > +
> > +def test_event(ns1, ns2) -> None:
> > +    with NetNSEnter(str(ns1)):
> > +        rtnl =3D RtnlFamily()
> > +
> > +    rtnl.ntf_subscribe("rtnlgrp-link")
> > +
> > +    ip(f"netns set {ns1} 0", ns=3Dstr(ns2))
> > +
> > +    ip(f"link add netns {ns2} link-netnsid 0 dummy1 type dummy")
> > +    ip(f"link add netns {ns2} dummy2 type dummy", ns=3Dstr(ns1))
> > +
> > +    ip("link del dummy1", ns=3Dstr(ns2))
> > +    ip("link del dummy2", ns=3Dstr(ns2))
> > +
> > +    time.sleep(1)
> > +    rtnl.check_ntf()
> > +    ksft_true(rtnl.async_msg_queue.empty(),
> > +              "Received unexpected link notification")
>
> I think we need a much larger coverage here, possibly testing all the
> update drivers and more 'netns', 'link-netnsid', 'peer netns'
> permutations for the devices that allow them.

OK, I will add more cases. But I'm afraid I don't know how to build
valid parameters for all of them, and some seem to require hardware.

>
> Thanks,
>
> Paolo
>

