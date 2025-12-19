Return-Path: <linux-kselftest+bounces-47739-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EE5CD10CB
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 18:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F64F30393D5
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 17:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC3432A3CC;
	Fri, 19 Dec 2025 17:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxeV6aoM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A063329E46
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Dec 2025 17:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766163932; cv=none; b=Sw7vL33n/6HiGleYlp595cBfDauDKrubq2SgYNqXq1ljWick4go5JsiOCHkAg+mMiEKtY4xmUlL3rQZ0EO7DGxx2EP3kMF2OzMgJvaC4p/VQAA3KnsLRRGLUXNbJWHJVioQe1557+YNs09ACMDYSHRa9VmzEbU4azoqsPWAbsU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766163932; c=relaxed/simple;
	bh=lPZMm6vd0UxqqYpv2bWfcRmUagh/+/8pIZ7icyReFho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ES5udOTngq13+EdmEWj9/36EnNHUal+P1HW7g+9X9Wk/LV9otiSRcjbtojlm6O3skIJxbIvlshcQYW52auEWhq6teQFqg9M8qrSOFiYEncel6u2U5Hxm52B+7uvFr851r0LqLVxX4JyY70vp7gh7unLx6Ql6zTbkIeCkrQfewz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxeV6aoM; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a102494058so15328255ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Dec 2025 09:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766163929; x=1766768729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULJ9kWNCOqQvgxuBx6h+gohgwQ2loFkChdnTGfLvwnk=;
        b=NxeV6aoMsOvHVSE+QSYfgLywsg8c2jCCVLmMokenQeuK8Jcfkj+HnryB7t/PPOoSd2
         TkBD1p/vefXb1YWxnNYWc//Hh6pTQaVaV/V0x2qIyof+saZrrojzPHlOc4WIv86Sf2j/
         YGyV1vVfA4vGId1GFDLnk0MXidT223VjvF1KrYuKXpMWcRZ6/qWUY57GYIK49LPZsSyA
         L6fAO1+EiK1tpDRZbiC5R5TE3HV6JZBRSvIty2gAqIw1mAc54LN/xNp36yGGS0/7U+uq
         I4ZHsP5dNJ477iAQFNq3Z0nd6zJ9AcD1inxrfG6lhdwcuTdZdPCSgbEUtzqkCFGRj9b/
         3fxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766163929; x=1766768729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ULJ9kWNCOqQvgxuBx6h+gohgwQ2loFkChdnTGfLvwnk=;
        b=ESheKfV/es8oCPgDEwlZzSuIQfcZDz4k5RJRMfo9DijtAl2/eoonhVpfSMDFq/90qn
         jtW7rPz3MEcxAMIxqs7odY/Z0vNd5/olkl2R2cb0XcXO6K/iKt3gB1r29qcnBZPiVUss
         8R6t66LYzPpM3AXjOGHH4PBy/XIoO4I+7IgzdG5QcEPt46mt5SOf2nO0Zlgmp+yLgMEx
         PDssrXIJg8NOF9BMGMbD4aOYC7hfl1NSUMhdu2hQ64/TKbPkyldIhTTvwTOABr4f6uN+
         G3AodhzlBke/aOZ9CpDz3ck6KdXrMLu6kCGbSzRXRGOIE2olra/7PmhhnZNNKGwjXodV
         /x5A==
X-Forwarded-Encrypted: i=1; AJvYcCVTp3mQAnjB3WLc1I4b+rlz/aBaK2em1o0boav9RIQp0fCCaDf5CZHIvcTGaj0DLUWf7CtIQroTmz64Riqqq3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfDNEc0UMfWRuI0Ej2b14moh0ZdotIUfqgVIFuPU66IKk5a+jC
	/G0WvXmBZsmaHomohxOQfzHkufv0cMNkWM4sdICU+Zh0tJcpXnEglOKADpMOaIjgIpJ2t84RTwu
	tfOOCK+jUBiYIcQEpU6CxW/lsrHkboog=
X-Gm-Gg: AY/fxX5gJKGyB2xd6yyeFCq+7a52x0Ln0yHgtr7rc+QG3GKXnvQudSMX7dqo4cd0G9Z
	Sf6J8tv9gtudNtG0fkGolZIYjojWyTmqF3xUlkV0d0mFEAxwE+ciiSQ/aRR5MT8sScF1PkPf+0i
	vAfCg3EO/fIxqoeHs7rjQE9yVfDsss/yN8ptnxT79yn1vDtDrJrpvDk42Tl6f5drEuMN15gzS4l
	FquGZIg9E9Oxw2TtFPLsZMuP4yQ1WFH6k/+40DDoF1uTf2vyH1/5+JofLDgzu2TJIumv2Kfcg==
X-Google-Smtp-Source: AGHT+IERBeZiFOwkfh0b2fkMH1uX1kTVgVYhoX9Iz8bARIMC4U1FX4jPd+jbirgb3O+xGGNKGkHvvFcStISaSFQzNF0=
X-Received: by 2002:a17:902:e785:b0:295:592f:9496 with SMTP id
 d9443c01a7336-2a2f0d40a74mr32574935ad.20.1766163928889; Fri, 19 Dec 2025
 09:05:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109050245.191288-1-jdamato@fastly.com> <20241109050245.191288-6-jdamato@fastly.com>
In-Reply-To: <20241109050245.191288-6-jdamato@fastly.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 19 Dec 2025 12:05:16 -0500
X-Gm-Features: AQt7F2rJSrbBcx_0fIlICwcK6dJXHG5qDAkAOJKRkP73DSXuRtO8Vlo7iQCQDh8
Message-ID: <CADvbK_d5YVLtSeYu+tXX3n=iF4QZ+d502ZUGzchrpvB5_hVfCw@mail.gmail.com>
Subject: Re: [PATCH net-next v9 5/6] selftests: net: Add busy_poll_test
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, corbet@lwn.net, hdanton@sina.com, 
	bagasdotme@gmail.com, pabeni@redhat.com, namangulati@google.com, 
	edumazet@google.com, amritha.nambiar@intel.com, sridhar.samudrala@intel.com, 
	sdf@fomichev.me, peter@typeblog.net, m2shafiei@uwaterloo.ca, 
	bjorn@rivosinc.com, hch@infradead.org, willy@infradead.org, 
	willemdebruijn.kernel@gmail.com, skhawaja@google.com, kuba@kernel.org, 
	Martin Karsten <mkarsten@uwaterloo.ca>, "David S. Miller" <davem@davemloft.net>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 9, 2024 at 12:04=E2=80=AFAM Joe Damato <jdamato@fastly.com> wro=
te:
>
> Add an epoll busy poll test using netdevsim.
>
> This test is comprised of:
>   - busy_poller (via busy_poller.c)
>   - busy_poll_test.sh which loads netdevsim, sets up network namespaces,
>     and runs busy_poller to receive data and socat to send data.
>
> The selftest tests two different scenarios:
>   - busy poll (the pre-existing version in the kernel)
>   - busy poll with suspend enabled (what this series adds)
>
> The data transmit is a 1MiB temporary file generated from /dev/urandom
> and the test is considered passing if the md5sum of the input file to
> socat matches the md5sum of the output file from busy_poller.
>
> netdevsim was chosen instead of veth due to netdevsim's support for
> netdev-genl.
>
> For now, this test uses the functionality that netdevsim provides. In the
> future, perhaps netdevsim can be extended to emulate device IRQs to more
> thoroughly test all pre-existing kernel options (like defer_hard_irqs)
> and suspend.
>
Hi, Joe,

While running this test, I consistently hit the following failure:

# ./busy_poll_test.sh
2025/12/19 11:56:46 socat[8169] E connect(6, AF=3D2 192.168.1.1:48675,
16): Connection timed out

After investigating, I noticed that both netdevsim devices remain in
the DOWN state:

# ip net exec nssv ip link
25: eni374np1@if26: <NO-CARRIER,BROADCAST,UP> mtu 1500 qdisc noqueue
state DOWN mode DEFAULT group default qlen 1000
    link/ether 2e:5f:c8:84:82:e5 brd ff:ff:ff:ff:ff:ff
# ip net exec nscl ip link
26: eni765np1@if25: <NO-CARRIER,BROADCAST,UP> mtu 1500 qdisc noqueue
state DOWN mode DEFAULT group default qlen 1000
    link/ether ee:78:d1:b7:d6:00 brd ff:ff:ff:ff:ff:ff

It appears that linking two netdevsim devices does not automatically
bring the interfaces up. As a workaround, I moved the following
commands out of setup_ns() and placed them after the netdevsim devices
are linked:

        ip netns exec nssv ip link set dev $NSIM_SV_NAME up
        ip netns exec nscl ip link set dev $NSIM_CL_NAME up

With this change, the test runs successfully.

Do you think I=E2=80=99m missing something here, or is this the expected be=
havior?

Thanks.

> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Co-developed-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  v9:
>    - Based on feedback from Willem, in busy_poll_test.sh:
>      - shortened long lines,
>      - used more reader friendly variable names
>      - moved constants into variables
>      - fixed the SPDX-License-Identifier
>      - reduced code duplication
>    - In busy_poller.c:
>      - Added a comment explaining the ifdef blob
>      - Fixed some types for strtoul and added explicit casts
>
>  v5:
>    - Updated commit message to replace netcat with socat and fixed
>      misspelling of netdevsim. No functional/code changes.
>
>  v4:
>    - Updated busy_poll_test.sh:
>      - use socat instead of nc
>      - drop cli.py usage from the script
>      - removed check_ynl
>    - Updated busy_poller.c:
>      - use netlink to configure napi parameters
>
>  v3:
>    - New in v3
>
>  tools/testing/selftests/net/.gitignore        |   1 +
>  tools/testing/selftests/net/Makefile          |   3 +-
>  tools/testing/selftests/net/busy_poll_test.sh | 165 +++++++++
>  tools/testing/selftests/net/busy_poller.c     | 346 ++++++++++++++++++
>  4 files changed, 514 insertions(+), 1 deletion(-)
>  create mode 100755 tools/testing/selftests/net/busy_poll_test.sh
>  create mode 100644 tools/testing/selftests/net/busy_poller.c
>
> diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selft=
ests/net/.gitignore
> index 217d8b7a7365..85b0c4a2179f 100644
> --- a/tools/testing/selftests/net/.gitignore
> +++ b/tools/testing/selftests/net/.gitignore
> @@ -2,6 +2,7 @@
>  bind_bhash
>  bind_timewait
>  bind_wildcard
> +busy_poller
>  cmsg_sender
>  diag_uid
>  epoll_busy_poll
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftes=
ts/net/Makefile
> index 26a4883a65c9..3ccfe454db1a 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -96,9 +96,10 @@ TEST_PROGS +=3D fdb_flush.sh
>  TEST_PROGS +=3D fq_band_pktlimit.sh
>  TEST_PROGS +=3D vlan_hw_filter.sh
>  TEST_PROGS +=3D bpf_offload.py
> +TEST_PROGS +=3D busy_poll_test.sh
>
>  # YNL files, must be before "include ..lib.mk"
> -YNL_GEN_FILES :=3D ncdevmem
> +YNL_GEN_FILES :=3D ncdevmem busy_poller
>  TEST_GEN_FILES +=3D $(YNL_GEN_FILES)
>
>  TEST_FILES :=3D settings
> diff --git a/tools/testing/selftests/net/busy_poll_test.sh b/tools/testin=
g/selftests/net/busy_poll_test.sh
> new file mode 100755
> index 000000000000..7db292ec4884
> --- /dev/null
> +++ b/tools/testing/selftests/net/busy_poll_test.sh
> @@ -0,0 +1,165 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +source net_helper.sh
> +
> +NSIM_SV_ID=3D$((256 + RANDOM % 256))
> +NSIM_SV_SYS=3D/sys/bus/netdevsim/devices/netdevsim$NSIM_SV_ID
> +NSIM_CL_ID=3D$((512 + RANDOM % 256))
> +NSIM_CL_SYS=3D/sys/bus/netdevsim/devices/netdevsim$NSIM_CL_ID
> +
> +NSIM_DEV_SYS_NEW=3D/sys/bus/netdevsim/new_device
> +NSIM_DEV_SYS_DEL=3D/sys/bus/netdevsim/del_device
> +NSIM_DEV_SYS_LINK=3D/sys/bus/netdevsim/link_device
> +NSIM_DEV_SYS_UNLINK=3D/sys/bus/netdevsim/unlink_device
> +
> +SERVER_IP=3D192.168.1.1
> +CLIENT_IP=3D192.168.1.2
> +SERVER_PORT=3D48675
> +
> +# busy poll config
> +MAX_EVENTS=3D8
> +BUSY_POLL_USECS=3D0
> +BUSY_POLL_BUDGET=3D16
> +PREFER_BUSY_POLL=3D1
> +
> +# IRQ deferral config
> +NAPI_DEFER_HARD_IRQS=3D100
> +GRO_FLUSH_TIMEOUT=3D50000
> +SUSPEND_TIMEOUT=3D20000000
> +
> +setup_ns()
> +{
> +       set -e
> +       ip netns add nssv
> +       ip netns add nscl
> +
> +       NSIM_SV_NAME=3D$(find $NSIM_SV_SYS/net -maxdepth 1 -type d ! \
> +               -path $NSIM_SV_SYS/net -exec basename {} \;)
> +       NSIM_CL_NAME=3D$(find $NSIM_CL_SYS/net -maxdepth 1 -type d ! \
> +               -path $NSIM_CL_SYS/net -exec basename {} \;)
> +
> +       # ensure the server has 1 queue
> +       ethtool -L $NSIM_SV_NAME combined 1 2>/dev/null
> +
> +       ip link set $NSIM_SV_NAME netns nssv
> +       ip link set $NSIM_CL_NAME netns nscl
> +
> +       ip netns exec nssv ip addr add "${SERVER_IP}/24" dev $NSIM_SV_NAM=
E
> +       ip netns exec nscl ip addr add "${CLIENT_IP}/24" dev $NSIM_CL_NAM=
E
> +
> +       ip netns exec nssv ip link set dev $NSIM_SV_NAME up
> +       ip netns exec nscl ip link set dev $NSIM_CL_NAME up
> +
> +       set +e
> +}
> +
> +cleanup_ns()
> +{
> +       ip netns del nscl
> +       ip netns del nssv
> +}
> +
> +test_busypoll()
> +{
> +       suspend_value=3D${1:-0}
> +       tmp_file=3D$(mktemp)
> +       out_file=3D$(mktemp)
> +
> +       # fill a test file with random data
> +       dd if=3D/dev/urandom of=3D${tmp_file} bs=3D1M count=3D1 2> /dev/n=
ull
> +
> +       timeout -k 1s 30s ip netns exec nssv ./busy_poller         \
> +                                            -p${SERVER_PORT}      \
> +                                            -b${SERVER_IP}        \
> +                                            -m${MAX_EVENTS}       \
> +                                            -u${BUSY_POLL_USECS}  \
> +                                            -P${PREFER_BUSY_POLL} \
> +                                            -g${BUSY_POLL_BUDGET} \
> +                                            -i${NSIM_SV_IFIDX}    \
> +                                            -s${suspend_value}    \
> +                                            -o${out_file}&
> +
> +       wait_local_port_listen nssv ${SERVER_PORT} tcp
> +
> +       ip netns exec nscl socat -u $tmp_file TCP:${SERVER_IP}:${SERVER_P=
ORT}
> +
> +       wait
> +
> +       tmp_file_md5sum=3D$(md5sum $tmp_file | cut -f1 -d' ')
> +       out_file_md5sum=3D$(md5sum $out_file | cut -f1 -d' ')
> +
> +       if [ "$tmp_file_md5sum" =3D "$out_file_md5sum" ]; then
> +               res=3D0
> +       else
> +               echo "md5sum mismatch"
> +               echo "input file md5sum: ${tmp_file_md5sum}";
> +               echo "output file md5sum: ${out_file_md5sum}";
> +               res=3D1
> +       fi
> +
> +       rm $out_file $tmp_file
> +
> +       return $res
> +}
> +
> +test_busypoll_with_suspend()
> +{
> +       test_busypoll ${SUSPEND_TIMEOUT}
> +
> +       return $?
> +}
> +
> +###
> +### Code start
> +###
> +
> +modprobe netdevsim
> +
> +# linking
> +
> +echo $NSIM_SV_ID > $NSIM_DEV_SYS_NEW
> +echo $NSIM_CL_ID > $NSIM_DEV_SYS_NEW
> +udevadm settle
> +
> +setup_ns
> +
> +NSIM_SV_FD=3D$((256 + RANDOM % 256))
> +exec {NSIM_SV_FD}</var/run/netns/nssv
> +NSIM_SV_IFIDX=3D$(ip netns exec nssv cat /sys/class/net/$NSIM_SV_NAME/if=
index)
> +
> +NSIM_CL_FD=3D$((256 + RANDOM % 256))
> +exec {NSIM_CL_FD}</var/run/netns/nscl
> +NSIM_CL_IFIDX=3D$(ip netns exec nscl cat /sys/class/net/$NSIM_CL_NAME/if=
index)
> +
> +echo "$NSIM_SV_FD:$NSIM_SV_IFIDX $NSIM_CL_FD:$NSIM_CL_IFIDX" > \
> +     $NSIM_DEV_SYS_LINK
> +
> +if [ $? -ne 0 ]; then
> +       echo "linking netdevsim1 with netdevsim2 should succeed"
> +       cleanup_ns
> +       exit 1
> +fi
> +
> +test_busypoll
> +if [ $? -ne 0 ]; then
> +       echo "test_busypoll failed"
> +       cleanup_ns
> +       exit 1
> +fi
> +
> +test_busypoll_with_suspend
> +if [ $? -ne 0 ]; then
> +       echo "test_busypoll_with_suspend failed"
> +       cleanup_ns
> +       exit 1
> +fi
> +
> +echo "$NSIM_SV_FD:$NSIM_SV_IFIDX" > $NSIM_DEV_SYS_UNLINK
> +
> +echo $NSIM_CL_ID > $NSIM_DEV_SYS_DEL
> +
> +cleanup_ns
> +
> +modprobe -r netdevsim
> +
> +exit 0
> diff --git a/tools/testing/selftests/net/busy_poller.c b/tools/testing/se=
lftests/net/busy_poller.c
> new file mode 100644
> index 000000000000..99b0e8c17fca
> --- /dev/null
> +++ b/tools/testing/selftests/net/busy_poller.c
> @@ -0,0 +1,346 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <assert.h>
> +#include <errno.h>
> +#include <error.h>
> +#include <fcntl.h>
> +#include <inttypes.h>
> +#include <limits.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <ynl.h>
> +
> +#include <arpa/inet.h>
> +#include <netinet/in.h>
> +
> +#include <sys/epoll.h>
> +#include <sys/ioctl.h>
> +#include <sys/socket.h>
> +#include <sys/types.h>
> +
> +#include <linux/genetlink.h>
> +#include <linux/netlink.h>
> +
> +#include "netdev-user.h"
> +
> +/* The below ifdef blob is required because:
> + *
> + * - sys/epoll.h does not (yet) have the ioctl definitions included. So,
> + *   systems with older glibcs will not have them available. However,
> + *   sys/epoll.h does include the type definition for epoll_data, which =
is
> + *   needed by the user program (e.g. epoll_event.data.fd)
> + *
> + * - linux/eventpoll.h does not define the epoll_data type, it is simply=
 an
> + *   opaque __u64. It does, however, include the ioctl definition.
> + *
> + * Including both headers is impossible (types would be redefined), so I=
've
> + * opted instead to take sys/epoll.h, and include the blob below.
> + *
> + * Someday, when glibc is globally up to date, the blob below can be rem=
oved.
> + */
> +#if !defined(EPOLL_IOC_TYPE)
> +struct epoll_params {
> +       uint32_t busy_poll_usecs;
> +       uint16_t busy_poll_budget;
> +       uint8_t prefer_busy_poll;
> +
> +       /* pad the struct to a multiple of 64bits */
> +       uint8_t __pad;
> +};
> +
> +#define EPOLL_IOC_TYPE 0x8A
> +#define EPIOCSPARAMS _IOW(EPOLL_IOC_TYPE, 0x01, struct epoll_params)
> +#define EPIOCGPARAMS _IOR(EPOLL_IOC_TYPE, 0x02, struct epoll_params)
> +#endif
> +
> +static uint32_t cfg_port =3D 8000;
> +static struct in_addr cfg_bind_addr =3D { .s_addr =3D INADDR_ANY };
> +static char *cfg_outfile;
> +static int cfg_max_events =3D 8;
> +static int cfg_ifindex;
> +
> +/* busy poll params */
> +static uint32_t cfg_busy_poll_usecs;
> +static uint32_t cfg_busy_poll_budget;
> +static uint32_t cfg_prefer_busy_poll;
> +
> +/* IRQ params */
> +static uint32_t cfg_defer_hard_irqs;
> +static uint64_t cfg_gro_flush_timeout;
> +static uint64_t cfg_irq_suspend_timeout;
> +
> +static void usage(const char *filepath)
> +{
> +       error(1, 0,
> +             "Usage: %s -p<port> -b<addr> -m<max_events> -u<busy_poll_us=
ecs> -P<prefer_busy_poll> -g<busy_poll_budget> -o<outfile> -d<defer_hard_ir=
qs> -r<gro_flush_timeout> -s<irq_suspend_timeout> -i<ifindex>",
> +             filepath);
> +}
> +
> +static void parse_opts(int argc, char **argv)
> +{
> +       int ret;
> +       int c;
> +
> +       if (argc <=3D 1)
> +               usage(argv[0]);
> +
> +       while ((c =3D getopt(argc, argv, "p:m:b:u:P:g:o:d:r:s:i:")) !=3D =
-1) {
> +               switch (c) {
> +               case 'u':
> +                       cfg_busy_poll_usecs =3D strtoul(optarg, NULL, 0);
> +                       if (cfg_busy_poll_usecs =3D=3D ULONG_MAX ||
> +                           cfg_busy_poll_usecs > UINT32_MAX)
> +                               error(1, ERANGE, "busy_poll_usecs too lar=
ge");
> +                       break;
> +               case 'P':
> +                       cfg_prefer_busy_poll =3D strtoul(optarg, NULL, 0)=
;
> +                       if (cfg_prefer_busy_poll =3D=3D ULONG_MAX ||
> +                           cfg_prefer_busy_poll > 1)
> +                               error(1, ERANGE,
> +                                     "prefer busy poll should be 0 or 1"=
);
> +                       break;
> +               case 'g':
> +                       cfg_busy_poll_budget =3D strtoul(optarg, NULL, 0)=
;
> +                       if (cfg_busy_poll_budget =3D=3D ULONG_MAX ||
> +                           cfg_busy_poll_budget > UINT16_MAX)
> +                               error(1, ERANGE,
> +                                     "busy poll budget must be [0, UINT1=
6_MAX]");
> +                       break;
> +               case 'p':
> +                       cfg_port =3D strtoul(optarg, NULL, 0);
> +                       if (cfg_port > UINT16_MAX)
> +                               error(1, ERANGE, "port must be <=3D 65535=
");
> +                       break;
> +               case 'b':
> +                       ret =3D inet_aton(optarg, &cfg_bind_addr);
> +                       if (ret =3D=3D 0)
> +                               error(1, errno,
> +                                     "bind address %s invalid", optarg);
> +                       break;
> +               case 'o':
> +                       cfg_outfile =3D strdup(optarg);
> +                       if (!cfg_outfile)
> +                               error(1, 0, "outfile invalid");
> +                       break;
> +               case 'm':
> +                       cfg_max_events =3D strtol(optarg, NULL, 0);
> +
> +                       if (cfg_max_events =3D=3D LONG_MIN ||
> +                           cfg_max_events =3D=3D LONG_MAX ||
> +                           cfg_max_events <=3D 0)
> +                               error(1, ERANGE,
> +                                     "max events must be > 0 and < LONG_=
MAX");
> +                       break;
> +               case 'd':
> +                       cfg_defer_hard_irqs =3D strtoul(optarg, NULL, 0);
> +
> +                       if (cfg_defer_hard_irqs =3D=3D ULONG_MAX ||
> +                           cfg_defer_hard_irqs > INT32_MAX)
> +                               error(1, ERANGE,
> +                                     "defer_hard_irqs must be <=3D INT32=
_MAX");
> +                       break;
> +               case 'r':
> +                       cfg_gro_flush_timeout =3D strtoull(optarg, NULL, =
0);
> +
> +                       if (cfg_gro_flush_timeout =3D=3D ULLONG_MAX)
> +                               error(1, ERANGE,
> +                                     "gro_flush_timeout must be < ULLONG=
_MAX");
> +                       break;
> +               case 's':
> +                       cfg_irq_suspend_timeout =3D strtoull(optarg, NULL=
, 0);
> +
> +                       if (cfg_irq_suspend_timeout =3D=3D ULLONG_MAX)
> +                               error(1, ERANGE,
> +                                     "irq_suspend_timeout must be < ULLO=
NG_MAX");
> +                       break;
> +               case 'i':
> +                       cfg_ifindex =3D strtoul(optarg, NULL, 0);
> +                       if (cfg_ifindex =3D=3D ULONG_MAX)
> +                               error(1, ERANGE,
> +                                     "ifindex must be < ULONG_MAX");
> +                       break;
> +               }
> +       }
> +
> +       if (!cfg_ifindex)
> +               usage(argv[0]);
> +
> +       if (optind !=3D argc)
> +               usage(argv[0]);
> +}
> +
> +static void epoll_ctl_add(int epfd, int fd, uint32_t events)
> +{
> +       struct epoll_event ev;
> +
> +       ev.events =3D events;
> +       ev.data.fd =3D fd;
> +       if (epoll_ctl(epfd, EPOLL_CTL_ADD, fd, &ev) =3D=3D -1)
> +               error(1, errno, "epoll_ctl add fd: %d", fd);
> +}
> +
> +static void setnonblock(int sockfd)
> +{
> +       int flags;
> +
> +       flags =3D fcntl(sockfd, F_GETFL, 0);
> +
> +       if (fcntl(sockfd, F_SETFL, flags | O_NONBLOCK) =3D=3D -1)
> +               error(1, errno, "unable to set socket to nonblocking mode=
");
> +}
> +
> +static void write_chunk(int fd, char *buf, ssize_t buflen)
> +{
> +       ssize_t remaining =3D buflen;
> +       char *buf_offset =3D buf;
> +       ssize_t writelen =3D 0;
> +       ssize_t write_result;
> +
> +       while (writelen < buflen) {
> +               write_result =3D write(fd, buf_offset, remaining);
> +               if (write_result =3D=3D -1)
> +                       error(1, errno, "unable to write data to outfile"=
);
> +
> +               writelen +=3D write_result;
> +               remaining -=3D write_result;
> +               buf_offset +=3D write_result;
> +       }
> +}
> +
> +static void setup_queue(void)
> +{
> +       struct netdev_napi_get_list *napi_list =3D NULL;
> +       struct netdev_napi_get_req_dump *req =3D NULL;
> +       struct netdev_napi_set_req *set_req =3D NULL;
> +       struct ynl_sock *ys;
> +       struct ynl_error yerr;
> +       uint32_t napi_id;
> +
> +       ys =3D ynl_sock_create(&ynl_netdev_family, &yerr);
> +       if (!ys)
> +               error(1, 0, "YNL: %s", yerr.msg);
> +
> +       req =3D netdev_napi_get_req_dump_alloc();
> +       netdev_napi_get_req_dump_set_ifindex(req, cfg_ifindex);
> +       napi_list =3D netdev_napi_get_dump(ys, req);
> +
> +       /* assume there is 1 NAPI configured and take the first */
> +       if (napi_list->obj._present.id)
> +               napi_id =3D napi_list->obj.id;
> +       else
> +               error(1, 0, "napi ID not present?");
> +
> +       set_req =3D netdev_napi_set_req_alloc();
> +       netdev_napi_set_req_set_id(set_req, napi_id);
> +       netdev_napi_set_req_set_defer_hard_irqs(set_req, cfg_defer_hard_i=
rqs);
> +       netdev_napi_set_req_set_gro_flush_timeout(set_req,
> +                                                 cfg_gro_flush_timeout);
> +       netdev_napi_set_req_set_irq_suspend_timeout(set_req,
> +                                                   cfg_irq_suspend_timeo=
ut);
> +
> +       if (netdev_napi_set(ys, set_req))
> +               error(1, 0, "can't set NAPI params: %s\n", yerr.msg);
> +
> +       netdev_napi_get_list_free(napi_list);
> +       netdev_napi_get_req_dump_free(req);
> +       netdev_napi_set_req_free(set_req);
> +       ynl_sock_destroy(ys);
> +}
> +
> +static void run_poller(void)
> +{
> +       struct epoll_event events[cfg_max_events];
> +       struct epoll_params epoll_params =3D {0};
> +       struct sockaddr_in server_addr;
> +       int i, epfd, nfds;
> +       ssize_t readlen;
> +       int outfile_fd;
> +       char buf[1024];
> +       int sockfd;
> +       int conn;
> +       int val;
> +
> +       outfile_fd =3D open(cfg_outfile, O_WRONLY | O_CREAT, 0644);
> +       if (outfile_fd =3D=3D -1)
> +               error(1, errno, "unable to open outfile: %s", cfg_outfile=
);
> +
> +       sockfd =3D socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
> +       if (sockfd =3D=3D -1)
> +               error(1, errno, "unable to create listen socket");
> +
> +       server_addr.sin_family =3D AF_INET;
> +       server_addr.sin_port =3D htons(cfg_port);
> +       server_addr.sin_addr =3D cfg_bind_addr;
> +
> +       /* these values are range checked during parse_opts, so casting i=
s safe
> +        * here
> +        */
> +       epoll_params.busy_poll_usecs =3D cfg_busy_poll_usecs;
> +       epoll_params.busy_poll_budget =3D (uint16_t)cfg_busy_poll_budget;
> +       epoll_params.prefer_busy_poll =3D (uint8_t)cfg_prefer_busy_poll;
> +       epoll_params.__pad =3D 0;
> +
> +       val =3D 1;
> +       if (setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &val, sizeof(val=
)))
> +               error(1, errno, "poller setsockopt reuseaddr");
> +
> +       setnonblock(sockfd);
> +
> +       if (bind(sockfd, (struct sockaddr *)&server_addr,
> +                sizeof(struct sockaddr_in)))
> +               error(0, errno, "poller bind to port: %d\n", cfg_port);
> +
> +       if (listen(sockfd, 1))
> +               error(1, errno, "poller listen");
> +
> +       epfd =3D epoll_create1(0);
> +       if (ioctl(epfd, EPIOCSPARAMS, &epoll_params) =3D=3D -1)
> +               error(1, errno, "unable to set busy poll params");
> +
> +       epoll_ctl_add(epfd, sockfd, EPOLLIN | EPOLLOUT | EPOLLET);
> +
> +       for (;;) {
> +               nfds =3D epoll_wait(epfd, events, cfg_max_events, -1);
> +               for (i =3D 0; i < nfds; i++) {
> +                       if (events[i].data.fd =3D=3D sockfd) {
> +                               conn =3D accept(sockfd, NULL, NULL);
> +                               if (conn =3D=3D -1)
> +                                       error(1, errno,
> +                                             "accepting incoming connect=
ion failed");
> +
> +                               setnonblock(conn);
> +                               epoll_ctl_add(epfd, conn,
> +                                             EPOLLIN | EPOLLET | EPOLLRD=
HUP |
> +                                             EPOLLHUP);
> +                       } else if (events[i].events & EPOLLIN) {
> +                               for (;;) {
> +                                       readlen =3D read(events[i].data.f=
d, buf,
> +                                                      sizeof(buf));
> +                                       if (readlen > 0)
> +                                               write_chunk(outfile_fd, b=
uf,
> +                                                           readlen);
> +                                       else
> +                                               break;
> +                               }
> +                       } else {
> +                               /* spurious event ? */
> +                       }
> +                       if (events[i].events & (EPOLLRDHUP | EPOLLHUP)) {
> +                               epoll_ctl(epfd, EPOLL_CTL_DEL,
> +                                         events[i].data.fd, NULL);
> +                               close(events[i].data.fd);
> +                               close(outfile_fd);
> +                               return;
> +                       }
> +               }
> +       }
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +       parse_opts(argc, argv);
> +       setup_queue();
> +       run_poller();
> +       return 0;
> +}
> --
> 2.25.1
>
>

