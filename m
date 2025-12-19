Return-Path: <linux-kselftest+bounces-47740-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA07CD111D
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 18:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B96D830270E5
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 17:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FCD339B4F;
	Fri, 19 Dec 2025 17:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3bxekb9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6229215055
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Dec 2025 17:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766164242; cv=none; b=DB88rh4az1QMzBeWCxeP49pOPGCmndio4Wuo1Z/CuF/Qu2qJB/mNhuoiMT92Khkdad9CGZs5LpiClSX2jfAIpdCWQJx9up2DxVLdjOtfderV18NxekvdhbfY8X1iRALxAQe29US+j8wYQOJGOaSuxyppxpqCUbAWNsYcmzcWYqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766164242; c=relaxed/simple;
	bh=Keif8xyEXxrpVYzkFc6rW+jVjx5IXT3KzA6SAOscrgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TcNijqn82FnA2tW7SpchnZWhW9UVD15lNF52Y1RN4SRt2q8Cq6n5rM06ptcS1+YEfZTQtT++SgtkoqQPlwIn5CoFRzwKSw/VAXqFSCeO7mu6pkFVmDtovwbcxxX/hkLmQfDJLfTa8tpZ6lWU9dY+wMC0mItPdh+Ar9kOfrCiEbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3bxekb9; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34c1d84781bso2217731a91.2
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Dec 2025 09:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766164240; x=1766769040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GE9e6QYnjFdaiiRAndKSrZ31PCnZFpK/FIt/ooXlfvM=;
        b=b3bxekb9vGNO7qfbMy2G1G+i98R+N0zVrKI2VpPUtkhA1lA2LyDfY3i/drxQuHgeL9
         3e7eQ2JSf3412Kj/5U73fCswZMI9iLXw2ioJsnb+J5t0nWC+4pY4BjQZM5fsTtglzWbK
         B+H99T4T/NVmbwHx3ilTdMTZC9hitaNdvUVhrbdANs+1muFyPair+uMGkReZ9wFArTns
         SIu/cV0ISZ4NUMtkcQs0TgykomAeOm6kf5O2dEzW1EJUW7ExOksfZyQxIUDjpvxFSUkp
         w4cEwgFgGeRJ8syL6C63EmoCwO0fi1OMpw4YBrJgB+Mws1U/nrYDAWfoue7U6c09Y56D
         /W0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766164240; x=1766769040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GE9e6QYnjFdaiiRAndKSrZ31PCnZFpK/FIt/ooXlfvM=;
        b=FQ8oFs1JQQUwv+h6lfauDNG7zs9Ta826EwhRFGXY8Sl1slzkBgo3eZZbmsltRWcnvY
         pZePV+cLTpy3PWevNSZ3r5VgVpnxXUu9P90x0p/AjERAWx4IrnION0d+ak/zM93WkT2X
         03CEBY6tYXM7mk+LeyZl9v/EfkTIexiw1CBsH7yWONnPSLi9Q4WKkCX+288G8Qet2enh
         B2aGLRCcRlKvmJZPams3z4uxkCg1h9+oCmiExjTtEF1c6aT9YjpgUGWwxrrZGj6ghyLm
         P8Xbe+ylRIxps6vomvhe3Ou2/GeBvd7t1gODWTfZS54MN0m0Xo9KhDrIFOPtyscOzvMk
         nomQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRT1dOHnSThSdgUgzKv2kXr5Y6FqYYW/HBl6Xi4E8I35iLCggMNYjVUYK/B8ygSuaRJffVzyfMS47zJQsZ5+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw32GE+uyovx2Il+RLe4FYKq/S/G9vGlRJYyiJIlR41Qjwvd+ae
	iSTLEKqIy27a7QwN2CayaPb5rAHVkYvyGDNbTtdCW182dF4GrgNR4LLSLabGTFxeYmM6qCZVvKG
	zxfcJ2zopRX4gTpvTU7ZDKyQV5DJI2dY=
X-Gm-Gg: AY/fxX4X3CKxGa/xcA142GRpDQqwqmDsD51k+D4AWjQSXjv7aTBXsTo6Jp+E4kZRtZM
	SNxrKU5Y5sDnUv5FvYODMAzaoFmOC2cJzJMeQ87p4PnHi6Kgr2m7/4AFblQ1PBa7sD7QFn0KbtV
	yap6e+voYDoV2QBbo3kNDTyNlKKRg+rFZg+UTlSQjtUbzSu6rm8Gm2vCG8vXKNnY4amkMc2gH5p
	A4uEDMbfllW0kO/yhvNdmt7crzfVtv8kHbe3DTgXmxVWznSP3ajOxznPS3ZC1M48kILAEo0bA==
X-Google-Smtp-Source: AGHT+IFB8Tt1Ije6WUQlVCQNt0crSYa3afPoNKFhgsk88siWWRxe4yFfeMskg2T1WqJaeB+waGOyHkH84RuS/474jgA=
X-Received: by 2002:a17:90b:560d:b0:343:e461:9022 with SMTP id
 98e67ed59e1d1-34e921a3caamr3151319a91.24.1766164239688; Fri, 19 Dec 2025
 09:10:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109050245.191288-1-jdamato@fastly.com> <20241109050245.191288-6-jdamato@fastly.com>
 <CADvbK_d5YVLtSeYu+tXX3n=iF4QZ+d502ZUGzchrpvB5_hVfCw@mail.gmail.com>
In-Reply-To: <CADvbK_d5YVLtSeYu+tXX3n=iF4QZ+d502ZUGzchrpvB5_hVfCw@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 19 Dec 2025 12:10:27 -0500
X-Gm-Features: AQt7F2q3pay0gaZbNZDqWJ4eRL7fqezP5YQE_ZE-S8SDc4osecBO5jq3PrgOod0
Message-ID: <CADvbK_dpCoYgVCX=-Bx7T=Hfr2dJUW_RFAGHLj7yXOYX9HPinA@mail.gmail.com>
Subject: Re: [PATCH net-next v9 5/6] selftests: net: Add busy_poll_test
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, corbet@lwn.net, hdanton@sina.com, 
	bagasdotme@gmail.com, pabeni@redhat.com, namangulati@google.com, 
	edumazet@google.com, sridhar.samudrala@intel.com, sdf@fomichev.me, 
	peter@typeblog.net, m2shafiei@uwaterloo.ca, bjorn@rivosinc.com, 
	hch@infradead.org, willy@infradead.org, willemdebruijn.kernel@gmail.com, 
	skhawaja@google.com, kuba@kernel.org, Martin Karsten <mkarsten@uwaterloo.ca>, 
	"David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 12:05=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wr=
ote:
>
> On Sat, Nov 9, 2024 at 12:04=E2=80=AFAM Joe Damato <jdamato@fastly.com> w=
rote:
> >
> > Add an epoll busy poll test using netdevsim.
> >
> > This test is comprised of:
> >   - busy_poller (via busy_poller.c)
> >   - busy_poll_test.sh which loads netdevsim, sets up network namespaces=
,
> >     and runs busy_poller to receive data and socat to send data.
> >
> > The selftest tests two different scenarios:
> >   - busy poll (the pre-existing version in the kernel)
> >   - busy poll with suspend enabled (what this series adds)
> >
> > The data transmit is a 1MiB temporary file generated from /dev/urandom
> > and the test is considered passing if the md5sum of the input file to
> > socat matches the md5sum of the output file from busy_poller.
> >
> > netdevsim was chosen instead of veth due to netdevsim's support for
> > netdev-genl.
> >
> > For now, this test uses the functionality that netdevsim provides. In t=
he
> > future, perhaps netdevsim can be extended to emulate device IRQs to mor=
e
> > thoroughly test all pre-existing kernel options (like defer_hard_irqs)
> > and suspend.
> >
> Hi, Joe,
>
> While running this test, I consistently hit the following failure:
>
> # ./busy_poll_test.sh
> 2025/12/19 11:56:46 socat[8169] E connect(6, AF=3D2 192.168.1.1:48675,
> 16): Connection timed out
>
> After investigating, I noticed that both netdevsim devices remain in
> the DOWN state:
>
> # ip net exec nssv ip link
> 25: eni374np1@if26: <NO-CARRIER,BROADCAST,UP> mtu 1500 qdisc noqueue
> state DOWN mode DEFAULT group default qlen 1000
>     link/ether 2e:5f:c8:84:82:e5 brd ff:ff:ff:ff:ff:ff
> # ip net exec nscl ip link
> 26: eni765np1@if25: <NO-CARRIER,BROADCAST,UP> mtu 1500 qdisc noqueue
> state DOWN mode DEFAULT group default qlen 1000
>     link/ether ee:78:d1:b7:d6:00 brd ff:ff:ff:ff:ff:ff
>
> It appears that linking two netdevsim devices does not automatically
> bring the interfaces up. As a workaround, I moved the following
> commands out of setup_ns() and placed them after the netdevsim devices
> are linked:
>
>         ip netns exec nssv ip link set dev $NSIM_SV_NAME up
>         ip netns exec nscl ip link set dev $NSIM_CL_NAME up
>
> With this change, the test runs successfully.
>
> Do you think I=E2=80=99m missing something here, or is this the expected =
behavior?
>
Added Joe Damato <joe@dama.to>.

Thanks.

> Thanks.
>
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > Co-developed-by: Martin Karsten <mkarsten@uwaterloo.ca>
> > Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
> > Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  v9:
> >    - Based on feedback from Willem, in busy_poll_test.sh:
> >      - shortened long lines,
> >      - used more reader friendly variable names
> >      - moved constants into variables
> >      - fixed the SPDX-License-Identifier
> >      - reduced code duplication
> >    - In busy_poller.c:
> >      - Added a comment explaining the ifdef blob
> >      - Fixed some types for strtoul and added explicit casts
> >
> >  v5:
> >    - Updated commit message to replace netcat with socat and fixed
> >      misspelling of netdevsim. No functional/code changes.
> >
> >  v4:
> >    - Updated busy_poll_test.sh:
> >      - use socat instead of nc
> >      - drop cli.py usage from the script
> >      - removed check_ynl
> >    - Updated busy_poller.c:
> >      - use netlink to configure napi parameters
> >
> >  v3:
> >    - New in v3
> >
> >  tools/testing/selftests/net/.gitignore        |   1 +
> >  tools/testing/selftests/net/Makefile          |   3 +-
> >  tools/testing/selftests/net/busy_poll_test.sh | 165 +++++++++
> >  tools/testing/selftests/net/busy_poller.c     | 346 ++++++++++++++++++
> >  4 files changed, 514 insertions(+), 1 deletion(-)
> >  create mode 100755 tools/testing/selftests/net/busy_poll_test.sh
> >  create mode 100644 tools/testing/selftests/net/busy_poller.c
> >
> > diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/sel=
ftests/net/.gitignore
> > index 217d8b7a7365..85b0c4a2179f 100644
> > --- a/tools/testing/selftests/net/.gitignore
> > +++ b/tools/testing/selftests/net/.gitignore
> > @@ -2,6 +2,7 @@
> >  bind_bhash
> >  bind_timewait
> >  bind_wildcard
> > +busy_poller
> >  cmsg_sender
> >  diag_uid
> >  epoll_busy_poll
> > diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selft=
ests/net/Makefile
> > index 26a4883a65c9..3ccfe454db1a 100644
> > --- a/tools/testing/selftests/net/Makefile
> > +++ b/tools/testing/selftests/net/Makefile
> > @@ -96,9 +96,10 @@ TEST_PROGS +=3D fdb_flush.sh
> >  TEST_PROGS +=3D fq_band_pktlimit.sh
> >  TEST_PROGS +=3D vlan_hw_filter.sh
> >  TEST_PROGS +=3D bpf_offload.py
> > +TEST_PROGS +=3D busy_poll_test.sh
> >
> >  # YNL files, must be before "include ..lib.mk"
> > -YNL_GEN_FILES :=3D ncdevmem
> > +YNL_GEN_FILES :=3D ncdevmem busy_poller
> >  TEST_GEN_FILES +=3D $(YNL_GEN_FILES)
> >
> >  TEST_FILES :=3D settings
> > diff --git a/tools/testing/selftests/net/busy_poll_test.sh b/tools/test=
ing/selftests/net/busy_poll_test.sh
> > new file mode 100755
> > index 000000000000..7db292ec4884
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/busy_poll_test.sh
> > @@ -0,0 +1,165 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +source net_helper.sh
> > +
> > +NSIM_SV_ID=3D$((256 + RANDOM % 256))
> > +NSIM_SV_SYS=3D/sys/bus/netdevsim/devices/netdevsim$NSIM_SV_ID
> > +NSIM_CL_ID=3D$((512 + RANDOM % 256))
> > +NSIM_CL_SYS=3D/sys/bus/netdevsim/devices/netdevsim$NSIM_CL_ID
> > +
> > +NSIM_DEV_SYS_NEW=3D/sys/bus/netdevsim/new_device
> > +NSIM_DEV_SYS_DEL=3D/sys/bus/netdevsim/del_device
> > +NSIM_DEV_SYS_LINK=3D/sys/bus/netdevsim/link_device
> > +NSIM_DEV_SYS_UNLINK=3D/sys/bus/netdevsim/unlink_device
> > +
> > +SERVER_IP=3D192.168.1.1
> > +CLIENT_IP=3D192.168.1.2
> > +SERVER_PORT=3D48675
> > +
> > +# busy poll config
> > +MAX_EVENTS=3D8
> > +BUSY_POLL_USECS=3D0
> > +BUSY_POLL_BUDGET=3D16
> > +PREFER_BUSY_POLL=3D1
> > +
> > +# IRQ deferral config
> > +NAPI_DEFER_HARD_IRQS=3D100
> > +GRO_FLUSH_TIMEOUT=3D50000
> > +SUSPEND_TIMEOUT=3D20000000
> > +
> > +setup_ns()
> > +{
> > +       set -e
> > +       ip netns add nssv
> > +       ip netns add nscl
> > +
> > +       NSIM_SV_NAME=3D$(find $NSIM_SV_SYS/net -maxdepth 1 -type d ! \
> > +               -path $NSIM_SV_SYS/net -exec basename {} \;)
> > +       NSIM_CL_NAME=3D$(find $NSIM_CL_SYS/net -maxdepth 1 -type d ! \
> > +               -path $NSIM_CL_SYS/net -exec basename {} \;)
> > +
> > +       # ensure the server has 1 queue
> > +       ethtool -L $NSIM_SV_NAME combined 1 2>/dev/null
> > +
> > +       ip link set $NSIM_SV_NAME netns nssv
> > +       ip link set $NSIM_CL_NAME netns nscl
> > +
> > +       ip netns exec nssv ip addr add "${SERVER_IP}/24" dev $NSIM_SV_N=
AME
> > +       ip netns exec nscl ip addr add "${CLIENT_IP}/24" dev $NSIM_CL_N=
AME
> > +
> > +       ip netns exec nssv ip link set dev $NSIM_SV_NAME up
> > +       ip netns exec nscl ip link set dev $NSIM_CL_NAME up
> > +
> > +       set +e
> > +}
> > +
> > +cleanup_ns()
> > +{
> > +       ip netns del nscl
> > +       ip netns del nssv
> > +}
> > +
> > +test_busypoll()
> > +{
> > +       suspend_value=3D${1:-0}
> > +       tmp_file=3D$(mktemp)
> > +       out_file=3D$(mktemp)
> > +
> > +       # fill a test file with random data
> > +       dd if=3D/dev/urandom of=3D${tmp_file} bs=3D1M count=3D1 2> /dev=
/null
> > +
> > +       timeout -k 1s 30s ip netns exec nssv ./busy_poller         \
> > +                                            -p${SERVER_PORT}      \
> > +                                            -b${SERVER_IP}        \
> > +                                            -m${MAX_EVENTS}       \
> > +                                            -u${BUSY_POLL_USECS}  \
> > +                                            -P${PREFER_BUSY_POLL} \
> > +                                            -g${BUSY_POLL_BUDGET} \
> > +                                            -i${NSIM_SV_IFIDX}    \
> > +                                            -s${suspend_value}    \
> > +                                            -o${out_file}&
> > +
> > +       wait_local_port_listen nssv ${SERVER_PORT} tcp
> > +
> > +       ip netns exec nscl socat -u $tmp_file TCP:${SERVER_IP}:${SERVER=
_PORT}
> > +
> > +       wait
> > +
> > +       tmp_file_md5sum=3D$(md5sum $tmp_file | cut -f1 -d' ')
> > +       out_file_md5sum=3D$(md5sum $out_file | cut -f1 -d' ')
> > +
> > +       if [ "$tmp_file_md5sum" =3D "$out_file_md5sum" ]; then
> > +               res=3D0
> > +       else
> > +               echo "md5sum mismatch"
> > +               echo "input file md5sum: ${tmp_file_md5sum}";
> > +               echo "output file md5sum: ${out_file_md5sum}";
> > +               res=3D1
> > +       fi
> > +
> > +       rm $out_file $tmp_file
> > +
> > +       return $res
> > +}
> > +
> > +test_busypoll_with_suspend()
> > +{
> > +       test_busypoll ${SUSPEND_TIMEOUT}
> > +
> > +       return $?
> > +}
> > +
> > +###
> > +### Code start
> > +###
> > +
> > +modprobe netdevsim
> > +
> > +# linking
> > +
> > +echo $NSIM_SV_ID > $NSIM_DEV_SYS_NEW
> > +echo $NSIM_CL_ID > $NSIM_DEV_SYS_NEW
> > +udevadm settle
> > +
> > +setup_ns
> > +
> > +NSIM_SV_FD=3D$((256 + RANDOM % 256))
> > +exec {NSIM_SV_FD}</var/run/netns/nssv
> > +NSIM_SV_IFIDX=3D$(ip netns exec nssv cat /sys/class/net/$NSIM_SV_NAME/=
ifindex)
> > +
> > +NSIM_CL_FD=3D$((256 + RANDOM % 256))
> > +exec {NSIM_CL_FD}</var/run/netns/nscl
> > +NSIM_CL_IFIDX=3D$(ip netns exec nscl cat /sys/class/net/$NSIM_CL_NAME/=
ifindex)
> > +
> > +echo "$NSIM_SV_FD:$NSIM_SV_IFIDX $NSIM_CL_FD:$NSIM_CL_IFIDX" > \
> > +     $NSIM_DEV_SYS_LINK
> > +
> > +if [ $? -ne 0 ]; then
> > +       echo "linking netdevsim1 with netdevsim2 should succeed"
> > +       cleanup_ns
> > +       exit 1
> > +fi
> > +
> > +test_busypoll
> > +if [ $? -ne 0 ]; then
> > +       echo "test_busypoll failed"
> > +       cleanup_ns
> > +       exit 1
> > +fi
> > +
> > +test_busypoll_with_suspend
> > +if [ $? -ne 0 ]; then
> > +       echo "test_busypoll_with_suspend failed"
> > +       cleanup_ns
> > +       exit 1
> > +fi
> > +
> > +echo "$NSIM_SV_FD:$NSIM_SV_IFIDX" > $NSIM_DEV_SYS_UNLINK
> > +
> > +echo $NSIM_CL_ID > $NSIM_DEV_SYS_DEL
> > +
> > +cleanup_ns
> > +
> > +modprobe -r netdevsim
> > +
> > +exit 0
> > diff --git a/tools/testing/selftests/net/busy_poller.c b/tools/testing/=
selftests/net/busy_poller.c
> > new file mode 100644
> > index 000000000000..99b0e8c17fca
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/busy_poller.c
> > @@ -0,0 +1,346 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <assert.h>
> > +#include <errno.h>
> > +#include <error.h>
> > +#include <fcntl.h>
> > +#include <inttypes.h>
> > +#include <limits.h>
> > +#include <stdlib.h>
> > +#include <stdio.h>
> > +#include <string.h>
> > +#include <unistd.h>
> > +#include <ynl.h>
> > +
> > +#include <arpa/inet.h>
> > +#include <netinet/in.h>
> > +
> > +#include <sys/epoll.h>
> > +#include <sys/ioctl.h>
> > +#include <sys/socket.h>
> > +#include <sys/types.h>
> > +
> > +#include <linux/genetlink.h>
> > +#include <linux/netlink.h>
> > +
> > +#include "netdev-user.h"
> > +
> > +/* The below ifdef blob is required because:
> > + *
> > + * - sys/epoll.h does not (yet) have the ioctl definitions included. S=
o,
> > + *   systems with older glibcs will not have them available. However,
> > + *   sys/epoll.h does include the type definition for epoll_data, whic=
h is
> > + *   needed by the user program (e.g. epoll_event.data.fd)
> > + *
> > + * - linux/eventpoll.h does not define the epoll_data type, it is simp=
ly an
> > + *   opaque __u64. It does, however, include the ioctl definition.
> > + *
> > + * Including both headers is impossible (types would be redefined), so=
 I've
> > + * opted instead to take sys/epoll.h, and include the blob below.
> > + *
> > + * Someday, when glibc is globally up to date, the blob below can be r=
emoved.
> > + */
> > +#if !defined(EPOLL_IOC_TYPE)
> > +struct epoll_params {
> > +       uint32_t busy_poll_usecs;
> > +       uint16_t busy_poll_budget;
> > +       uint8_t prefer_busy_poll;
> > +
> > +       /* pad the struct to a multiple of 64bits */
> > +       uint8_t __pad;
> > +};
> > +
> > +#define EPOLL_IOC_TYPE 0x8A
> > +#define EPIOCSPARAMS _IOW(EPOLL_IOC_TYPE, 0x01, struct epoll_params)
> > +#define EPIOCGPARAMS _IOR(EPOLL_IOC_TYPE, 0x02, struct epoll_params)
> > +#endif
> > +
> > +static uint32_t cfg_port =3D 8000;
> > +static struct in_addr cfg_bind_addr =3D { .s_addr =3D INADDR_ANY };
> > +static char *cfg_outfile;
> > +static int cfg_max_events =3D 8;
> > +static int cfg_ifindex;
> > +
> > +/* busy poll params */
> > +static uint32_t cfg_busy_poll_usecs;
> > +static uint32_t cfg_busy_poll_budget;
> > +static uint32_t cfg_prefer_busy_poll;
> > +
> > +/* IRQ params */
> > +static uint32_t cfg_defer_hard_irqs;
> > +static uint64_t cfg_gro_flush_timeout;
> > +static uint64_t cfg_irq_suspend_timeout;
> > +
> > +static void usage(const char *filepath)
> > +{
> > +       error(1, 0,
> > +             "Usage: %s -p<port> -b<addr> -m<max_events> -u<busy_poll_=
usecs> -P<prefer_busy_poll> -g<busy_poll_budget> -o<outfile> -d<defer_hard_=
irqs> -r<gro_flush_timeout> -s<irq_suspend_timeout> -i<ifindex>",
> > +             filepath);
> > +}
> > +
> > +static void parse_opts(int argc, char **argv)
> > +{
> > +       int ret;
> > +       int c;
> > +
> > +       if (argc <=3D 1)
> > +               usage(argv[0]);
> > +
> > +       while ((c =3D getopt(argc, argv, "p:m:b:u:P:g:o:d:r:s:i:")) !=
=3D -1) {
> > +               switch (c) {
> > +               case 'u':
> > +                       cfg_busy_poll_usecs =3D strtoul(optarg, NULL, 0=
);
> > +                       if (cfg_busy_poll_usecs =3D=3D ULONG_MAX ||
> > +                           cfg_busy_poll_usecs > UINT32_MAX)
> > +                               error(1, ERANGE, "busy_poll_usecs too l=
arge");
> > +                       break;
> > +               case 'P':
> > +                       cfg_prefer_busy_poll =3D strtoul(optarg, NULL, =
0);
> > +                       if (cfg_prefer_busy_poll =3D=3D ULONG_MAX ||
> > +                           cfg_prefer_busy_poll > 1)
> > +                               error(1, ERANGE,
> > +                                     "prefer busy poll should be 0 or =
1");
> > +                       break;
> > +               case 'g':
> > +                       cfg_busy_poll_budget =3D strtoul(optarg, NULL, =
0);
> > +                       if (cfg_busy_poll_budget =3D=3D ULONG_MAX ||
> > +                           cfg_busy_poll_budget > UINT16_MAX)
> > +                               error(1, ERANGE,
> > +                                     "busy poll budget must be [0, UIN=
T16_MAX]");
> > +                       break;
> > +               case 'p':
> > +                       cfg_port =3D strtoul(optarg, NULL, 0);
> > +                       if (cfg_port > UINT16_MAX)
> > +                               error(1, ERANGE, "port must be <=3D 655=
35");
> > +                       break;
> > +               case 'b':
> > +                       ret =3D inet_aton(optarg, &cfg_bind_addr);
> > +                       if (ret =3D=3D 0)
> > +                               error(1, errno,
> > +                                     "bind address %s invalid", optarg=
);
> > +                       break;
> > +               case 'o':
> > +                       cfg_outfile =3D strdup(optarg);
> > +                       if (!cfg_outfile)
> > +                               error(1, 0, "outfile invalid");
> > +                       break;
> > +               case 'm':
> > +                       cfg_max_events =3D strtol(optarg, NULL, 0);
> > +
> > +                       if (cfg_max_events =3D=3D LONG_MIN ||
> > +                           cfg_max_events =3D=3D LONG_MAX ||
> > +                           cfg_max_events <=3D 0)
> > +                               error(1, ERANGE,
> > +                                     "max events must be > 0 and < LON=
G_MAX");
> > +                       break;
> > +               case 'd':
> > +                       cfg_defer_hard_irqs =3D strtoul(optarg, NULL, 0=
);
> > +
> > +                       if (cfg_defer_hard_irqs =3D=3D ULONG_MAX ||
> > +                           cfg_defer_hard_irqs > INT32_MAX)
> > +                               error(1, ERANGE,
> > +                                     "defer_hard_irqs must be <=3D INT=
32_MAX");
> > +                       break;
> > +               case 'r':
> > +                       cfg_gro_flush_timeout =3D strtoull(optarg, NULL=
, 0);
> > +
> > +                       if (cfg_gro_flush_timeout =3D=3D ULLONG_MAX)
> > +                               error(1, ERANGE,
> > +                                     "gro_flush_timeout must be < ULLO=
NG_MAX");
> > +                       break;
> > +               case 's':
> > +                       cfg_irq_suspend_timeout =3D strtoull(optarg, NU=
LL, 0);
> > +
> > +                       if (cfg_irq_suspend_timeout =3D=3D ULLONG_MAX)
> > +                               error(1, ERANGE,
> > +                                     "irq_suspend_timeout must be < UL=
LONG_MAX");
> > +                       break;
> > +               case 'i':
> > +                       cfg_ifindex =3D strtoul(optarg, NULL, 0);
> > +                       if (cfg_ifindex =3D=3D ULONG_MAX)
> > +                               error(1, ERANGE,
> > +                                     "ifindex must be < ULONG_MAX");
> > +                       break;
> > +               }
> > +       }
> > +
> > +       if (!cfg_ifindex)
> > +               usage(argv[0]);
> > +
> > +       if (optind !=3D argc)
> > +               usage(argv[0]);
> > +}
> > +
> > +static void epoll_ctl_add(int epfd, int fd, uint32_t events)
> > +{
> > +       struct epoll_event ev;
> > +
> > +       ev.events =3D events;
> > +       ev.data.fd =3D fd;
> > +       if (epoll_ctl(epfd, EPOLL_CTL_ADD, fd, &ev) =3D=3D -1)
> > +               error(1, errno, "epoll_ctl add fd: %d", fd);
> > +}
> > +
> > +static void setnonblock(int sockfd)
> > +{
> > +       int flags;
> > +
> > +       flags =3D fcntl(sockfd, F_GETFL, 0);
> > +
> > +       if (fcntl(sockfd, F_SETFL, flags | O_NONBLOCK) =3D=3D -1)
> > +               error(1, errno, "unable to set socket to nonblocking mo=
de");
> > +}
> > +
> > +static void write_chunk(int fd, char *buf, ssize_t buflen)
> > +{
> > +       ssize_t remaining =3D buflen;
> > +       char *buf_offset =3D buf;
> > +       ssize_t writelen =3D 0;
> > +       ssize_t write_result;
> > +
> > +       while (writelen < buflen) {
> > +               write_result =3D write(fd, buf_offset, remaining);
> > +               if (write_result =3D=3D -1)
> > +                       error(1, errno, "unable to write data to outfil=
e");
> > +
> > +               writelen +=3D write_result;
> > +               remaining -=3D write_result;
> > +               buf_offset +=3D write_result;
> > +       }
> > +}
> > +
> > +static void setup_queue(void)
> > +{
> > +       struct netdev_napi_get_list *napi_list =3D NULL;
> > +       struct netdev_napi_get_req_dump *req =3D NULL;
> > +       struct netdev_napi_set_req *set_req =3D NULL;
> > +       struct ynl_sock *ys;
> > +       struct ynl_error yerr;
> > +       uint32_t napi_id;
> > +
> > +       ys =3D ynl_sock_create(&ynl_netdev_family, &yerr);
> > +       if (!ys)
> > +               error(1, 0, "YNL: %s", yerr.msg);
> > +
> > +       req =3D netdev_napi_get_req_dump_alloc();
> > +       netdev_napi_get_req_dump_set_ifindex(req, cfg_ifindex);
> > +       napi_list =3D netdev_napi_get_dump(ys, req);
> > +
> > +       /* assume there is 1 NAPI configured and take the first */
> > +       if (napi_list->obj._present.id)
> > +               napi_id =3D napi_list->obj.id;
> > +       else
> > +               error(1, 0, "napi ID not present?");
> > +
> > +       set_req =3D netdev_napi_set_req_alloc();
> > +       netdev_napi_set_req_set_id(set_req, napi_id);
> > +       netdev_napi_set_req_set_defer_hard_irqs(set_req, cfg_defer_hard=
_irqs);
> > +       netdev_napi_set_req_set_gro_flush_timeout(set_req,
> > +                                                 cfg_gro_flush_timeout=
);
> > +       netdev_napi_set_req_set_irq_suspend_timeout(set_req,
> > +                                                   cfg_irq_suspend_tim=
eout);
> > +
> > +       if (netdev_napi_set(ys, set_req))
> > +               error(1, 0, "can't set NAPI params: %s\n", yerr.msg);
> > +
> > +       netdev_napi_get_list_free(napi_list);
> > +       netdev_napi_get_req_dump_free(req);
> > +       netdev_napi_set_req_free(set_req);
> > +       ynl_sock_destroy(ys);
> > +}
> > +
> > +static void run_poller(void)
> > +{
> > +       struct epoll_event events[cfg_max_events];
> > +       struct epoll_params epoll_params =3D {0};
> > +       struct sockaddr_in server_addr;
> > +       int i, epfd, nfds;
> > +       ssize_t readlen;
> > +       int outfile_fd;
> > +       char buf[1024];
> > +       int sockfd;
> > +       int conn;
> > +       int val;
> > +
> > +       outfile_fd =3D open(cfg_outfile, O_WRONLY | O_CREAT, 0644);
> > +       if (outfile_fd =3D=3D -1)
> > +               error(1, errno, "unable to open outfile: %s", cfg_outfi=
le);
> > +
> > +       sockfd =3D socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
> > +       if (sockfd =3D=3D -1)
> > +               error(1, errno, "unable to create listen socket");
> > +
> > +       server_addr.sin_family =3D AF_INET;
> > +       server_addr.sin_port =3D htons(cfg_port);
> > +       server_addr.sin_addr =3D cfg_bind_addr;
> > +
> > +       /* these values are range checked during parse_opts, so casting=
 is safe
> > +        * here
> > +        */
> > +       epoll_params.busy_poll_usecs =3D cfg_busy_poll_usecs;
> > +       epoll_params.busy_poll_budget =3D (uint16_t)cfg_busy_poll_budge=
t;
> > +       epoll_params.prefer_busy_poll =3D (uint8_t)cfg_prefer_busy_poll=
;
> > +       epoll_params.__pad =3D 0;
> > +
> > +       val =3D 1;
> > +       if (setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &val, sizeof(v=
al)))
> > +               error(1, errno, "poller setsockopt reuseaddr");
> > +
> > +       setnonblock(sockfd);
> > +
> > +       if (bind(sockfd, (struct sockaddr *)&server_addr,
> > +                sizeof(struct sockaddr_in)))
> > +               error(0, errno, "poller bind to port: %d\n", cfg_port);
> > +
> > +       if (listen(sockfd, 1))
> > +               error(1, errno, "poller listen");
> > +
> > +       epfd =3D epoll_create1(0);
> > +       if (ioctl(epfd, EPIOCSPARAMS, &epoll_params) =3D=3D -1)
> > +               error(1, errno, "unable to set busy poll params");
> > +
> > +       epoll_ctl_add(epfd, sockfd, EPOLLIN | EPOLLOUT | EPOLLET);
> > +
> > +       for (;;) {
> > +               nfds =3D epoll_wait(epfd, events, cfg_max_events, -1);
> > +               for (i =3D 0; i < nfds; i++) {
> > +                       if (events[i].data.fd =3D=3D sockfd) {
> > +                               conn =3D accept(sockfd, NULL, NULL);
> > +                               if (conn =3D=3D -1)
> > +                                       error(1, errno,
> > +                                             "accepting incoming conne=
ction failed");
> > +
> > +                               setnonblock(conn);
> > +                               epoll_ctl_add(epfd, conn,
> > +                                             EPOLLIN | EPOLLET | EPOLL=
RDHUP |
> > +                                             EPOLLHUP);
> > +                       } else if (events[i].events & EPOLLIN) {
> > +                               for (;;) {
> > +                                       readlen =3D read(events[i].data=
.fd, buf,
> > +                                                      sizeof(buf));
> > +                                       if (readlen > 0)
> > +                                               write_chunk(outfile_fd,=
 buf,
> > +                                                           readlen);
> > +                                       else
> > +                                               break;
> > +                               }
> > +                       } else {
> > +                               /* spurious event ? */
> > +                       }
> > +                       if (events[i].events & (EPOLLRDHUP | EPOLLHUP))=
 {
> > +                               epoll_ctl(epfd, EPOLL_CTL_DEL,
> > +                                         events[i].data.fd, NULL);
> > +                               close(events[i].data.fd);
> > +                               close(outfile_fd);
> > +                               return;
> > +                       }
> > +               }
> > +       }
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +       parse_opts(argc, argv);
> > +       setup_queue();
> > +       run_poller();
> > +       return 0;
> > +}
> > --
> > 2.25.1
> >
> >

