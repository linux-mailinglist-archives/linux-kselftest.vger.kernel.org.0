Return-Path: <linux-kselftest+bounces-21703-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E215B9C2238
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 17:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1686287744
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 16:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4B8198E79;
	Fri,  8 Nov 2024 16:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="eEncoVXW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3188198A10
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Nov 2024 16:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731083808; cv=none; b=C5xJkROaFEwIEn2VNIhtjI1mesYgOCRY36Rf/cV2htADVD2ljxpn/Pux+E3uveyKJ/95qruTiE9WrBDh7cPgOwChRRGzTCvf4Am6gv4NzJrc78eb070KpwCDYbbvqmkHuOpH5WzsgfOqKBXkFkQ+sU9eYJbzwZeE+jDRCVEvB3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731083808; c=relaxed/simple;
	bh=LzNaxM9KrhW3ZrGh4NBFhruLWuJnUnJPx1+8qsqWMT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4F7sw/9vte21/nv0X89qjQ22ePPUFW6iK5TWn9U6gprghFcSPuRrTrEky9yz5lLdNaol8lqZn2Igc9+qR+/I87nIV4npRKzEGLefwPGgqT+888UyiOuBtb7mVH8xQSZz1uuOb72F1qLGrDUr0CJ6zASMSsC1k9l6NCjYiVWZqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=eEncoVXW; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e79f73aaeso1936235b3a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Nov 2024 08:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731083805; x=1731688605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QS8BQ3gfR6RtS75Ov9p2KtjtH2EnXJjrhkRBjJ4mnSg=;
        b=eEncoVXWYdU+kDkqCZiuZ+bWpJ/bOSVyTlhVaQognIexchwUXBAdRujyUacQLyFuVR
         kAG+ke1C4lajqYY3u25fWFYHwsc//ju4nV6dsSLxSjX8zucSYtB7IYOioy8w7VWWJC/S
         XcK6oFcJpJnCCGmqYjWCrR2WQHMHNSKhshvOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731083805; x=1731688605;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QS8BQ3gfR6RtS75Ov9p2KtjtH2EnXJjrhkRBjJ4mnSg=;
        b=Fm5kU+sxwlcXJ5STMjpzbsBuIkPYlTwJZS+dHnGFar/pRJtST0kRUijJM9v5vKQJBj
         Z/adiJ+iPYivsDi76Nw6jWzdXJ7ntuAv8CX7f36KS5YFyjWHdnVYRRZA99WRfa8GbvpS
         bUSkkZnnhLFhN4+oAqHGL65tjt8fRD2FImTJox7zW19WfrglBTSMSz3kO+VrofGBUH14
         l/EGMYUx16XTrFjzm2ccBAsvU/LZGKRqhYq1oPyShA1MhoyNP0yVA2jDulxR3CoY114G
         VmD9RJvCAW5+vB0M+WYaVaJrV5rev/cU0+mWxYgXekBlBJ1zObw6/L5ioIyhEdNai+Qb
         wUaA==
X-Forwarded-Encrypted: i=1; AJvYcCXb/NEcRY49A1sLT29KGRhYzkHq5g0izd3dYZNdDIvmM0WsxD+slmHwmGBcOKBHFQveu3f8TvkTejro1AzTb6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz4mp0YuDxNdNgdMeUdaaoB3zsQxhv+uy0b9CmwLF1CGRB64Za
	/SQX/KSEc05flS+WL5snM1eXpWpPbJAd9HJxaHtxKbSKx1u8UApP1HotA9hdg9I=
X-Google-Smtp-Source: AGHT+IENVoppqlgQEkiFWw8GRLaPHzp+XloRM/QJxLirGsjy5scrJWwhXJj0ZUqMtjbRh7P2GKdm+g==
X-Received: by 2002:a05:6a20:7faa:b0:1d0:2531:b2b9 with SMTP id adf61e73a8af0-1dc22b00bd8mr4855041637.36.1731083804985;
        Fri, 08 Nov 2024 08:36:44 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a5ebaasm3911351b3a.191.2024.11.08.08.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 08:36:44 -0800 (PST)
Date: Fri, 8 Nov 2024 08:36:41 -0800
From: Joe Damato <jdamato@fastly.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, corbet@lwn.net, hdanton@sina.com,
	bagasdotme@gmail.com, pabeni@redhat.com, namangulati@google.com,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, peter@typeblog.net,
	m2shafiei@uwaterloo.ca, bjorn@rivosinc.com, hch@infradead.org,
	willy@infradead.org, skhawaja@google.com, kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v8 5/6] selftests: net: Add busy_poll_test
Message-ID: <Zy4-GUoYKBo_inRc@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	netdev@vger.kernel.org, corbet@lwn.net, hdanton@sina.com,
	bagasdotme@gmail.com, pabeni@redhat.com, namangulati@google.com,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, peter@typeblog.net,
	m2shafiei@uwaterloo.ca, bjorn@rivosinc.com, hch@infradead.org,
	willy@infradead.org, skhawaja@google.com, kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20241108045337.292905-1-jdamato@fastly.com>
 <20241108045337.292905-6-jdamato@fastly.com>
 <672e26ec429be_2a4cd22944c@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <672e26ec429be_2a4cd22944c@willemb.c.googlers.com.notmuch>

On Fri, Nov 08, 2024 at 09:57:48AM -0500, Willem de Bruijn wrote:
> Joe Damato wrote:
> > Add an epoll busy poll test using netdevsim.
> > 
> > This test is comprised of:
> >   - busy_poller (via busy_poller.c)
> >   - busy_poll_test.sh which loads netdevsim, sets up network namespaces,
> >     and runs busy_poller to receive data and socat to send data.
> > 
> > The selftest tests two different scenarios:
> >   - busy poll (the pre-existing version in the kernel)
> >   - busy poll with suspend enabled (what this series adds)
> > 
> > The data transmit is a 1MiB temporary file generated from /dev/urandom
> > and the test is considered passing if the md5sum of the input file to
> > socat matches the md5sum of the output file from busy_poller.
> 
> Nice test.
> 
> Busy polling does not affect data integrity. Is the goal of this test
> mainly to get coverage, maybe observe if the process would stall
> indefinitely?

Just to get coverage and make sure data makes it from point A to
point B intact despite suspend being enabled.

The last paragraph of the commit message highlights that netdevsim
functionality is limited, so the test uses what is available. It can
be extended in the future, when netdevsim supports more
functionality.

Paolo wanted a test and this is the best test we can provide given
the limitations of the testing environment.

> > netdevsim was chosen instead of veth due to netdevsim's support for
> > netdev-genl.
> > 
> > For now, this test uses the functionality that netdevsim provides. In the
> > future, perhaps netdevsim can be extended to emulate device IRQs to more
> > thoroughly test all pre-existing kernel options (like defer_hard_irqs)
> > and suspend.

[...]

The rest of the feedback below seems pretty minor; I don't think
it's worth spinning a v9 and re-sending just for this.

If anything this can be handled with a clean up commit in the
future.

Jakub: please let me know if you prefer to see a v9 for this?

> > diff --git a/tools/testing/selftests/net/busy_poll_test.sh b/tools/testing/selftests/net/busy_poll_test.sh
> > new file mode 100755
> > index 000000000000..ffc74bc62e5a
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/busy_poll_test.sh
> > @@ -0,0 +1,164 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0-only
> 
> Why the different SPDX between the two files?
> 
> > +source net_helper.sh
> > +
> > +NSIM_DEV_1_ID=$((256 + RANDOM % 256))
> > +NSIM_DEV_1_SYS=/sys/bus/netdevsim/devices/netdevsim$NSIM_DEV_1_ID
> > +NSIM_DEV_2_ID=$((512 + RANDOM % 256))
> > +NSIM_DEV_2_SYS=/sys/bus/netdevsim/devices/netdevsim$NSIM_DEV_2_ID
> > +
> > +NSIM_DEV_SYS_NEW=/sys/bus/netdevsim/new_device
> > +NSIM_DEV_SYS_DEL=/sys/bus/netdevsim/del_device
> > +NSIM_DEV_SYS_LINK=/sys/bus/netdevsim/link_device
> > +NSIM_DEV_SYS_UNLINK=/sys/bus/netdevsim/unlink_device
> > +
> > +setup_ns()
> > +{
> > +	set -e
> > +	ip netns add nssv
> > +	ip netns add nscl
> > +
> > +	NSIM_DEV_1_NAME=$(find $NSIM_DEV_1_SYS/net -maxdepth 1 -type d ! \
> > +		-path $NSIM_DEV_1_SYS/net -exec basename {} \;)
> > +	NSIM_DEV_2_NAME=$(find $NSIM_DEV_2_SYS/net -maxdepth 1 -type d ! \
> > +		-path $NSIM_DEV_2_SYS/net -exec basename {} \;)
> > +
> > +	# ensure the server has 1 queue
> > +	ethtool -L $NSIM_DEV_1_NAME combined 1 2>/dev/null
> > +
> > +	ip link set $NSIM_DEV_1_NAME netns nssv
> > +	ip link set $NSIM_DEV_2_NAME netns nscl
> > +
> > +	ip netns exec nssv ip addr add '192.168.1.1/24' dev $NSIM_DEV_1_NAME
> > +	ip netns exec nscl ip addr add '192.168.1.2/24' dev $NSIM_DEV_2_NAME
> > +
> > +	ip netns exec nssv ip link set dev $NSIM_DEV_1_NAME up
> > +	ip netns exec nscl ip link set dev $NSIM_DEV_2_NAME up
> > +
> > +	set +e
> > +}
> > +
> > +cleanup_ns()
> > +{
> > +	ip netns del nscl
> > +	ip netns del nssv
> > +}
> > +
> > +test_busypoll()
> > +{
> > +	tmp_file=$(mktemp)
> > +	out_file=$(mktemp)
> > +
> > +	# fill a test file with random data
> > +	dd if=/dev/urandom of=${tmp_file} bs=1M count=1 2> /dev/null
> > +
> > +	timeout -k 1s 30s ip netns exec nssv ./busy_poller -p48675 -b192.168.1.1 -m8 -u0 -P1 -g16 -i${NSIM_DEV_1_IFIDX} -o${out_file}&
> 
> nit: consider variables for all repeated constants, including IP addresses and ports
> > +
> > +	wait_local_port_listen nssv 48675 tcp
> > +
> > +	ip netns exec nscl socat -u $tmp_file TCP:192.168.1.1:48675
> > +
> > +	wait
> > +
> > +	tmp_file_md5sum=$(md5sum $tmp_file | cut -f1 -d' ')
> > +	out_file_md5sum=$(md5sum $out_file | cut -f1 -d' ')
> > +
> > +	if [ "$tmp_file_md5sum" = "$out_file_md5sum" ]; then
> > +		res=0
> > +	else
> > +		echo "md5sum mismatch"
> > +		echo "input file md5sum: ${tmp_file_md5sum}";
> > +		echo "output file md5sum: ${out_file_md5sum}";
> > +		res=1
> > +	fi
> > +
> > +	rm $out_file $tmp_file
> 
> Delete these in cleanup()?
> 
> > +
> > +	return $res
> > +}
> > +
> > +test_busypoll_with_suspend()
> > +{
> 
> Main feedback: this function is practically a duplicate of the prev.
> Consider deduplicating them with one optional argument that enables
> suspend mode in busy_poller.
> 
> > +	tmp_file=$(mktemp)
> > +	out_file=$(mktemp)
> > +
> > +	# fill a test file with random data
> > +	dd if=/dev/urandom of=${tmp_file} bs=1M count=1 2> /dev/null
> > +
> > +	timeout -k 1s 30s ip netns exec nssv ./busy_poller -p48675 -b192.168.1.1 -m8 -u0 -P1 -g16 -d100 -r50000 -s20000000 -i${NSIM_DEV_1_IFIDX} -o${out_file}&
> > +
> > +	wait_local_port_listen nssv 48675 tcp
> > +
> > +	ip netns exec nscl socat -u $tmp_file TCP:192.168.1.1:48675
> > +
> > +	wait
> > +
> > +	tmp_file_md5sum=$(md5sum $tmp_file | cut -f1 -d' ')
> > +	out_file_md5sum=$(md5sum $out_file | cut -f1 -d' ')
> > +
> > +	if [ "$tmp_file_md5sum" = "$out_file_md5sum" ]; then
> > +		res=0
> > +	else
> > +		echo "md5sum mismatch"
> > +		echo "input file md5sum: ${tmp_file_md5sum}";
> > +		echo "output file md5sum: ${out_file_md5sum}";
> > +		res=1
> > +	fi
> > +
> > +	rm $out_file $tmp_file
> > +
> > +	return $res
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
> > +echo $NSIM_DEV_1_ID > $NSIM_DEV_SYS_NEW
> > +echo $NSIM_DEV_2_ID > $NSIM_DEV_SYS_NEW
> > +udevadm settle
> 
> is this generally available on systems under test?
> 
> > +
> > +setup_ns
> > +
> > +NSIM_DEV_1_FD=$((256 + RANDOM % 256))
> 
> repeated magic constants
> 
> > +exec {NSIM_DEV_1_FD}</var/run/netns/nssv
> > +NSIM_DEV_1_IFIDX=$(ip netns exec nssv cat /sys/class/net/$NSIM_DEV_1_NAME/ifindex)
> > +
> > +NSIM_DEV_2_FD=$((256 + RANDOM % 256))
> > +exec {NSIM_DEV_2_FD}</var/run/netns/nscl
> > +NSIM_DEV_2_IFIDX=$(ip netns exec nscl cat /sys/class/net/$NSIM_DEV_2_NAME/ifindex)
> > +
> > +echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX $NSIM_DEV_2_FD:$NSIM_DEV_2_IFIDX" > $NSIM_DEV_SYS_LINK
> > +if [ $? -ne 0 ]; then
> > +	echo "linking netdevsim1 with netdevsim2 should succeed"
> > +	cleanup_ns
> > +	exit 1
> > +fi
> > +
> > +test_busypoll
> > +if [ $? -ne 0 ]; then
> > +	echo "test_busypoll failed"
> > +	cleanup_ns
> > +	exit 1
> > +fi
> > +
> > +test_busypoll_with_suspend
> > +if [ $? -ne 0 ]; then
> > +	echo "test_busypoll_with_suspend failed"
> > +	cleanup_ns
> > +	exit 1
> > +fi
> > +
> > +echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX" > $NSIM_DEV_SYS_UNLINK
> > +
> > +echo $NSIM_DEV_2_ID > $NSIM_DEV_SYS_DEL
> > +
> > +cleanup_ns
> > +
> > +modprobe -r netdevsim
> > +
> > +exit 0
> > diff --git a/tools/testing/selftests/net/busy_poller.c b/tools/testing/selftests/net/busy_poller.c
> > new file mode 100644
> > index 000000000000..8d8aa9e5939a
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/busy_poller.c
> > @@ -0,0 +1,328 @@
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
> > +
> > +#include <arpa/inet.h>
> > +#include <netinet/in.h>
> > +
> > +#include <sys/ioctl.h>
> > +#include <sys/epoll.h>
> > +#include <sys/socket.h>
> > +#include <sys/types.h>
> > +
> > +#include <linux/netlink.h>
> > +#include <linux/genetlink.h>
> > +#include "netdev-user.h"
> > +#include <ynl.h>
> > +
> > +/* if the headers haven't been updated, we need to define some things */
> 
> This should not be needed, as headers are taken from $KERNELSRC/usr after
> make headers_install.
> 
> Generally discouraged for tests (else every new feature test for a new
> features is forced to adds such checks).
> 
> > +#if !defined(EPOLL_IOC_TYPE)
> > +struct epoll_params {
> > +	uint32_t busy_poll_usecs;
> > +	uint16_t busy_poll_budget;
> > +	uint8_t prefer_busy_poll;
> > +
> > +	/* pad the struct to a multiple of 64bits */
> > +	uint8_t __pad;
> > +};
> > +
> > +#define EPOLL_IOC_TYPE 0x8A
> > +#define EPIOCSPARAMS _IOW(EPOLL_IOC_TYPE, 0x01, struct epoll_params)
> > +#define EPIOCGPARAMS _IOR(EPOLL_IOC_TYPE, 0x02, struct epoll_params)
> > +#endif
> > +
> > +static uint32_t cfg_port = 8000;
> > +static struct in_addr cfg_bind_addr = { .s_addr = INADDR_ANY };
> > +static char *cfg_outfile;
> > +static int cfg_max_events = 8;
> > +static int cfg_ifindex;
> > +
> > +/* busy poll params */
> > +static uint32_t cfg_busy_poll_usecs;
> > +static uint16_t cfg_busy_poll_budget;
> > +static uint8_t cfg_prefer_busy_poll;
> > +
> > +/* IRQ params */
> > +static uint32_t cfg_defer_hard_irqs;
> > +static uint64_t cfg_gro_flush_timeout;
> > +static uint64_t cfg_irq_suspend_timeout;
> > +
> > +static void usage(const char *filepath)
> > +{
> > +	error(1, 0,
> > +	      "Usage: %s -p<port> -b<addr> -m<max_events> -u<busy_poll_usecs> -P<prefer_busy_poll> -g<busy_poll_budget> -o<outfile> -d<defer_hard_irqs> -r<gro_flush_timeout> -s<irq_suspend_timeout> -i<ifindex>",
> > +	      filepath);
> > +}
> > +
> > +static void parse_opts(int argc, char **argv)
> > +{
> > +	int ret;
> > +	int c;
> > +
> > +	if (argc <= 1)
> > +		usage(argv[0]);
> > +
> > +	while ((c = getopt(argc, argv, "p:m:b:u:P:g:o:d:r:s:i:")) != -1) {
> > +		switch (c) {
> > +		case 'u':
> > +			cfg_busy_poll_usecs = strtoul(optarg, NULL, 0);
> > +			if (cfg_busy_poll_usecs == ULONG_MAX ||
> > +			    cfg_busy_poll_usecs > UINT32_MAX)
> > +				error(1, ERANGE, "busy_poll_usecs too large");
> > +			break;
> > +		case 'P':
> > +			cfg_prefer_busy_poll = strtoul(optarg, NULL, 0);
> > +			if (cfg_prefer_busy_poll == ULONG_MAX ||
> 
> Here and elsewhere: not possible due to size of var (here: uint8_t)
> I'm surprised that the compiler does not mention this.
> 
> > +			    cfg_prefer_busy_poll > 1)
> > +				error(1, ERANGE,
> > +				      "prefer busy poll should be 0 or 1");
> > +			break;
> > +		case 'g':
> > +			cfg_busy_poll_budget = strtoul(optarg, NULL, 0);
> > +			if (cfg_busy_poll_budget == ULONG_MAX ||
> > +			    cfg_busy_poll_budget > UINT16_MAX)
> > +				error(1, ERANGE,
> > +				      "busy poll budget must be [0, UINT16_MAX]");
> > +			break;
> > +		case 'p':
> > +			cfg_port = strtoul(optarg, NULL, 0);
> > +			if (cfg_port > UINT16_MAX)
> > +				error(1, ERANGE, "port must be <= 65535");
> > +			break;
> > +		case 'b':
> > +			ret = inet_aton(optarg, &cfg_bind_addr);
> > +			if (ret == 0)
> > +				error(1, errno,
> > +				      "bind address %s invalid", optarg);
> > +			break;
> > +		case 'o':
> > +			cfg_outfile = strdup(optarg);
> > +			if (!cfg_outfile)
> > +				error(1, 0, "outfile invalid");
> > +			break;
> > +		case 'm':
> > +			cfg_max_events = strtol(optarg, NULL, 0);
> > +
> > +			if (cfg_max_events == LONG_MIN ||
> > +			    cfg_max_events == LONG_MAX ||
> > +			    cfg_max_events <= 0)
> > +				error(1, ERANGE,
> > +				      "max events must be > 0 and < LONG_MAX");
> > +			break;
> > +		case 'd':
> > +			cfg_defer_hard_irqs = strtoul(optarg, NULL, 0);
> > +
> > +			if (cfg_defer_hard_irqs == ULONG_MAX ||
> > +			    cfg_defer_hard_irqs > INT32_MAX)
> > +				error(1, ERANGE,
> > +				      "defer_hard_irqs must be <= INT32_MAX");
> > +			break;
> > +		case 'r':
> > +			cfg_gro_flush_timeout = strtoull(optarg, NULL, 0);
> > +
> > +			if (cfg_gro_flush_timeout == ULLONG_MAX)
> > +				error(1, ERANGE,
> > +				      "gro_flush_timeout must be < ULLONG_MAX");
> > +			break;
> > +		case 's':
> > +			cfg_irq_suspend_timeout = strtoull(optarg, NULL, 0);
> > +
> > +			if (cfg_irq_suspend_timeout == ULLONG_MAX)
> > +				error(1, ERANGE,
> > +				      "irq_suspend_timeout must be < ULLONG_MAX");
> > +			break;
> > +		case 'i':
> > +			cfg_ifindex = strtoul(optarg, NULL, 0);
> > +			if (cfg_ifindex == ULONG_MAX)
> > +				error(1, ERANGE,
> > +				      "ifindex must be < ULONG_MAX");
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (!cfg_ifindex)
> > +		usage(argv[0]);
> > +
> > +	if (optind != argc)
> > +		usage(argv[0]);
> > +}

