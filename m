Return-Path: <linux-kselftest+bounces-33973-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C5CAC7586
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 03:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A054E705B
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 01:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5884221D86;
	Thu, 29 May 2025 01:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xLH9qh6W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D426E21CA0A
	for <linux-kselftest@vger.kernel.org>; Thu, 29 May 2025 01:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748483605; cv=none; b=ZOpTxPpxQjZAsHtcH+46NlfS39R6nhrN6RThP8WSbdjWQnXstRIVxHFsPMoKnLVBrwLs+KclosXEKDKDKWuezMKOBS2xp/IqC6upfusE2/7Rr44Y2kxHPcCp8Ghu4MMpxON/urqiJXZdJIvcdZb83QT/ZPGoLFPWHeuTiGnpUWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748483605; c=relaxed/simple;
	bh=rJbOnLrons4tTuN78stT1ORqO5zSyyGsE+esZxR3PBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rU03u/clyE5U66UzAqQe4sCQ6CS8LHGmIbSWAajsgze+kUVK5DwJL23PxZT1beUEOkaWKQuUizmwqDHRI5xgNwR+cnM7kDM6sqhq8RJXQJvAlcVpfTVcYrM8vMzhLnKw2JhgL5UZDrGjOscu9bD6hPabfnGDPCL1wych0IAmMhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xLH9qh6W; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3dc9caf4cc7so15ab.1
        for <linux-kselftest@vger.kernel.org>; Wed, 28 May 2025 18:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748483602; x=1749088402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rK28GjLplaS1k6sqbBmLq7Kl/oZsU4xMjKQXJ8HS3rA=;
        b=xLH9qh6Wzyel+Qcwg7oraOeFJvWcjbp2sDQo3q+QMvOdqB5Is/qIbwKEdx62m17kcB
         NDcN1BJVn4c6RojJriZALkozb3UabYmyqbER7XNquDEDzF484+6rhfTtJX694bibKxLw
         oEefb6zx8WJ/ViWFjMUgCf8tdjOtVITIs9nq+YeBiNGZAuIO76FMS1bNHFc8+din55kJ
         7C5iGk5mTPOyH/t6M4NlhQLt5u1ekxUDgoMDVye1wgcTp7T1USKQpG9vPGOQ0NP5tjmU
         9N1+PaYxLCNi3mN86gip2sIg0kQLF/Cq2QYqIOUzuAU3nD66n7EY21Q+eHYNpSyy3ifn
         bW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748483602; x=1749088402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rK28GjLplaS1k6sqbBmLq7Kl/oZsU4xMjKQXJ8HS3rA=;
        b=M3MB1WwoZt1T/kIrSN6ciKYHUTIk+tqfhOo/r8QJ4O7MzHbkUXR6Oyto337Wf9js1T
         Q3myAONL4VdRAkYPW4Ji+QpyeGPu2H25A6lQnerW8zOFcse3jVygQ1AmrEbdpiubXfMg
         vfOlkGdIIdPbk1d50bdJyzutVzhjp8hNjESvF6WExqLjLxrdN4rxzzo6mzyA18ZlEsCX
         FibNWbxQHyzDYKxwwhU66lbPk11m45Z9B6mfG1m0URERyrntkMUVInANIgD4z71ldb9C
         f9cWAPMtPBY63I1DaOiW7bocZ9PEBHBN83UwtuL2oFx6MR07dSQ50ToHmUPHdQPXiy5L
         WWkg==
X-Forwarded-Encrypted: i=1; AJvYcCX+74I7BjrslltyQawOaxK8ASKSOCsee44Gx679B3Ppp/e8WKXKPUOxbT/qaSaa3qLtTrdsBXBUxFxOP053+3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIlYyC2FXetRplk+eWlLAflJemXWJA4GWv0dtXPukrGqDLEkfc
	X282zqM1JBoY/gKJjQGRVxqvO2IA6Mom8+i1m0r4hrt1VekZFERqIcSN0L2TkHYJhBgpwbgNdpO
	dAyWyF23m6n0hhb7zwBcXrb/pBd6pEdyUwScDR1G6
X-Gm-Gg: ASbGncvscf10tY3PYSm14td4ZsDW+U+C+X32ciLi3qnpnYDv9nJ6TdEErl1p2pDAN5U
	o5f9RsxMb4RwMnGG2RWHDEvcNz8Qv34QZjEZKroFZtQ5jgcoFVdWp5GDYRhxvN2UMBW1WAxfw1L
	wxK8/9Cn9OD+AxF3atg+w61qIdAGoJOL/5CRBOor9EsH4ukhoNsXqXbcrasHMMRpMgfiWDatOiX
	Q==
X-Google-Smtp-Source: AGHT+IHvXpxdbsNsdSIj7f0krR3C592J4ox9Z6xPbGgTujvSL8gBecLol8wGmmUwIDp3VmUxXJZIQ9cqFHX68YMuAB0=
X-Received: by 2002:a05:6e02:17cb:b0:3d9:6c7a:2b37 with SMTP id
 e9e14a558f8ab-3dd943b659dmr165085ab.0.1748483600459; Wed, 28 May 2025
 18:53:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527091855.340837-1-yuyanghuang@google.com> <20250528154906.GD1484967@horms.kernel.org>
In-Reply-To: <20250528154906.GD1484967@horms.kernel.org>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Thu, 29 May 2025 10:52:43 +0900
X-Gm-Features: AX0GCFuYgCNb70ORjeZSMAVUwUmRpmuC-GcYb2mnhAWrV6WRxyL5vLj9hHEg0Fc
Message-ID: <CADXeF1E7zuqpixcB+9j90d7tZhR5bsSsrniYD-BtpK8+uzA_Pw@mail.gmail.com>
Subject: Re: [PATCH net-next] selftest: Add selftest for multicast address notifications
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon

>Other tests in this file seem to warn if the ip command is too old
>to support the test. Perhaps we can achieve that here something like this
>(completely untested!):

Thanks for the advice. I will modify the test to make sure it skips on
old iproute2 versions. I will send the patch after net-next reopens.

Thanks,

Yuyang


On Thu, May 29, 2025 at 12:49=E2=80=AFAM Simon Horman <horms@kernel.org> wr=
ote:
>
> On Tue, May 27, 2025 at 06:18:55PM +0900, Yuyang Huang wrote:
> > This commit adds a new kernel selftest to verify RTNLGRP_IPV4_MCADDR
> > and RTNLGRP_IPV6_MCADDR notifications. The test works by adding and
> > removing a dummy interface and then confirming that the system
> > correctly receives join and removal notifications for the 224.0.0.1
> > and ff02::1 multicast addresses.
> >
> > The test relies on the iproute2 version to be 6.13+.
> >
> > Tested by the following command:
> > $ vng -v --user root --cpus 16 -- \
> > make -C tools/testing/selftests TARGETS=3Dnet TEST_PROGS=3Drtnetlink.sh=
 \
> > TEST_GEN_PROGS=3D"" run_tests
> >
> > Cc: Maciej =C5=BBenczykowski <maze@google.com>
> > Cc: Lorenzo Colitti <lorenzo@google.com>
> > Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
>
> ...
>
> > +kci_test_mcast_addr_notification()
> > +{
> > +     local tmpfile
> > +     local monitor_pid
> > +     local match_result
> > +
> > +     tmpfile=3D$(mktemp)
> > +
> > +     ip monitor maddr > $tmpfile &
> > +     monitor_pid=3D$!
>
> Hi Yuyang Huang,
>
> Other tests in this file seem to warn if the ip command is too old
> to support the test. Perhaps we can achieve that here something like this
> (completely untested!):
>
>         if [ ! -e "/proc/$monitor_pid" ]; then
>                 end_test "SKIP: mcast addr notification: iproute2 too old=
"
>                 rm $tmpfile
>                 return $ksft_skip
>         fi
>
> > +     sleep 1
> > +
> > +     run_cmd ip link add name test-dummy1 type dummy
> > +     run_cmd ip link set test-dummy1 up
> > +     run_cmd ip link del dev test-dummy1
> > +     sleep 1
> > +
> > +     match_result=3D$(grep -cE "test-dummy1.*(224.0.0.1|ff02::1)" $tmp=
file)
> > +
> > +     kill $monitor_pid
> > +     rm $tmpfile
> > +     # There should be 4 line matches as follows.
> > +     # 13: test-dummy1    inet6 mcast ff02::1 scope global
> > +     # 13: test-dummy1    inet mcast 224.0.0.1 scope global
> > +     # Deleted 13: test-dummy1    inet mcast 224.0.0.1 scope global
> > +     # Deleted 13: test-dummy1    inet6 mcast ff02::1 scope global
> > +     if [ $match_result -ne 4 ];then
> > +             end_test "FAIL: mcast addr notification"
> > +             return 1
> > +     fi
> > +     end_test "PASS: mcast addr notification"
> > +}
> > +
>
> ...
>
> ## Form letter - net-next-closed
>
> The merge window for v6.16 has begun and therefore net-next is closed
> for new drivers, features, code refactoring and optimizations. We are
> currently accepting bug fixes only.
>
> Please repost when net-next reopens after June 8th.
>
> RFC patches sent for review only are obviously welcome at any time.
>
> pw-bot: deffer

