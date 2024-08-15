Return-Path: <linux-kselftest+bounces-15389-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF8F952ACB
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 10:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CAACB20DDB
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 08:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313D91991C2;
	Thu, 15 Aug 2024 08:16:01 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CF029CFB;
	Thu, 15 Aug 2024 08:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723709761; cv=none; b=fFj0HCLmkpoyWMNhfQrT2a1YfG4TTUzbvx7W+Z/0U85QTDzGdNVRh7Si7XZXKxhpLQu197ICmJtJPHdJbZ5uzmCg3EK27kAfSyQvljSM2O3X0kkNCVg1jA8TtKbJnQ//PwJ4TzqsV5ETcfKEbLmZsf+V+tDsvP8YI6I6JZp6/3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723709761; c=relaxed/simple;
	bh=KkLYdhuog4F3+nwjpJH8jhF/XDr7P07zOi+aWfc00cQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obXnBaihM3vZ/QuQrSuag7GS7Cq8Gpmw4c8rLctzi+LRcsCyM/6SQpjCUfQAo8Prnpg6ZZtWsXmWZ4NK2J+grrXb3IPmneEWgwBR/oZ7Praapgej58O8GMQxgDrZNNYR/oIFGbj4yYjvtbPAYg3j1HPIUGifBDC/t7kvUB8sX5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-530e2235688so628441e87.3;
        Thu, 15 Aug 2024 01:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723709757; x=1724314557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFQNwhOTfPKgopngHN0Dpaks+z4Mb+lZVbFkj2Buw8U=;
        b=F2ipKBehQuiJHeuT39KTiafrlYnn5VP+Xa9MBb/CGAkXR9ORHTUP0qpZ9Fd8fpjKWv
         9PjYic3i3x93lK1WBFuTTasRUisXJivuc0OUUOgQdBtCaRpZJkwAtGgHnBwnFE4sIB9n
         9r3jQcGavGBsrlKEBhnsVN7TW2fB2hE7OexscFfy3FTHwYqhd252pAhNmcZk3eoVD9b8
         irebUAMJrRRtVG4MWYGhgBpU1w5WvqybmG3KmsQ7c02bPeJToiHpuYAEKyEAUpDE9edz
         A0EutIpuhqiHntaLDG01vaz+B3+WO/y857Z0zXf6kBN8tAYeOy20+CCK8/hCTeENiN/6
         0Nww==
X-Forwarded-Encrypted: i=1; AJvYcCXMXO2w6Vxn7OG1PypyyEwKIAAhGjOEiij0xPGIoVX4N3Ca1X9mV9BzrkRjHVqKKRzzs0ZBYoMbaJPN0+FF6ZAs6z4Iuu/M7xel1nAK3ZbTJWDbaEe4LWUPmpSuI8Prn3f7KNUcGqay+lzncUFiXT0Z3VAtye1uu+4xcJrKPAenWue0T5ju
X-Gm-Message-State: AOJu0YzKCn0/PKyX3lwYRiRv2IJvYyP+7mRDz734BeCbvB/PKWy5r1Uz
	FNaF968rjjmG3ZhST9+FSOogg7eV3YVLqJzESwEH0/LDVOHY4qwi
X-Google-Smtp-Source: AGHT+IFkK3RNmLJHa4BA4SVcWkTYoWSvoPUd7QXg4hAxCWg8NwLhbhZBp7ojxoVD4u/lO70niFohHg==
X-Received: by 2002:a05:6512:158f:b0:52f:1ef:bafe with SMTP id 2adb3069b0e04-532eda7a52fmr3523045e87.22.1723709756874;
        Thu, 15 Aug 2024 01:15:56 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838eedf1sm64699966b.91.2024.08.15.01.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 01:15:56 -0700 (PDT)
Date: Thu, 15 Aug 2024 01:15:53 -0700
From: Breno Leitao <leitao@debian.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, David Wei <dw@davidwei.uk>,
	Willem de Bruijn <willemb@google.com>,
	Petr Machata <petrm@nvidia.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v2] net: netconsole: selftests: Create a new
 netconsole selftest
Message-ID: <Zr25OecANx77Y+4O@gmail.com>
References: <20240813183825.837091-1-leitao@debian.org>
 <Zr20tNtSUdW_JG8T@Laptop-X1>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr20tNtSUdW_JG8T@Laptop-X1>

On Thu, Aug 15, 2024 at 03:56:36PM +0800, Hangbin Liu wrote:
> On Tue, Aug 13, 2024 at 11:38:16AM -0700, Breno Leitao wrote:
> > Adds a selftest that creates two virtual interfaces, assigns one to a
> > new namespace, and assigns IP addresses to both.
> > 
> > It listens on the destination interface using socat and configures a
> > dynamic target on netconsole, pointing to the destination IP address.
> > 
> > The test then checks if the message was received properly on the
> > destination interface.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> > Changelog:
> > 
> > v2:
> >  * Change the location of the path (Jakub)
> >  * Move from veth to netdevsim
> >  * Other small changes in dependency checks and cleanup
> > 
> > v1:
> >  * https://lore.kernel.org/all/ZqyUHN770pjSofTC@gmail.com/
> > 
> >  MAINTAINERS                                   |   1 +
> >  tools/testing/selftests/drivers/net/Makefile  |   1 +
> >  .../selftests/drivers/net/netcons_basic.sh    | 223 ++++++++++++++++++
> >  3 files changed, 225 insertions(+)
> >  create mode 100755 tools/testing/selftests/drivers/net/netcons_basic.sh
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index a9dace908305..ded45f1dff7e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -15770,6 +15770,7 @@ M:	Breno Leitao <leitao@debian.org>
> >  S:	Maintained
> >  F:	Documentation/networking/netconsole.rst
> >  F:	drivers/net/netconsole.c
> > +F:	tools/testing/selftests/drivers/net/netcons_basic.sh
> >  
> >  NETDEVSIM
> >  M:	Jakub Kicinski <kuba@kernel.org>
> > diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
> > index e54f382bcb02..928530b26abc 100644
> > --- a/tools/testing/selftests/drivers/net/Makefile
> > +++ b/tools/testing/selftests/drivers/net/Makefile
> > @@ -3,6 +3,7 @@
> >  TEST_INCLUDES := $(wildcard lib/py/*.py)
> >  
> >  TEST_PROGS := \
> > +	netcons_basic.sh \
> >  	ping.py \
> >  	queues.py \
> >  	stats.py \
> > diff --git a/tools/testing/selftests/drivers/net/netcons_basic.sh b/tools/testing/selftests/drivers/net/netcons_basic.sh
> > new file mode 100755
> > index 000000000000..e0e58fc7e89f
> > --- /dev/null
> > +++ b/tools/testing/selftests/drivers/net/netcons_basic.sh
> > @@ -0,0 +1,223 @@
> > +#!/usr/bin/env bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +# This test creates two netdevsim virtual interfaces, assigns one of them (the
> > +# "destination interface") to a new namespace, and assigns IP addresses to both
> > +# interfaces.
> > +#
> > +# It listens on the destination interface using socat and configures a dynamic
> > +# target on netconsole, pointing to the destination IP address.
> > +#
> > +# Finally, it checks whether the message was received properly on the
> > +# destination interface.  Note that this test may pollute the kernel log buffer
> > +# (dmesg) and relies on dynamic configuration and namespaces being configured.
> > +#
> > +# Author: Breno Leitao <leitao@debian.org>
> > +
> > +set -euo pipefail
> > +
> > +SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
> > +
> > +# Simple script to test dynamic targets in netconsole
> > +SRCIF="" # to be populated later
> > +SRCIP=192.168.1.1
> > +DSTIF="" # to be populated later
> > +DSTIP=192.168.1.2
> > +
> > +PORT="6666"
> > +MSG="netconsole selftest"
> > +TARGET=$(mktemp -u netcons_XXXXX)
> > +NETCONS_CONFIGFS="/sys/kernel/config/netconsole"
> > +NETCONS_PATH="${NETCONS_CONFIGFS}"/"${TARGET}"
> > +# This will have some tmp values appended to it in set_network()
> > +NAMESPACE="netconsns_dst"
> > +
> > +# IDs for netdevsim
> > +NSIM_DEV_1_ID=$((256 + RANDOM % 256))
> > +NSIM_DEV_2_ID=$((512 + RANDOM % 256))
> > +
> > +# Used to create and delete namespaces
> > +source "${SCRIPTDIR}"/../../net/lib.sh
> 
> If you want to source net/lib.sh, you need to add it to Makefile. e.g.
> 
> TEST_INCLUDES := ../../../net/lib.sh
> 
> See example in tools/testing/selftests/drivers/net/bonding/Makefile

Thanks. I will update.
--breno

