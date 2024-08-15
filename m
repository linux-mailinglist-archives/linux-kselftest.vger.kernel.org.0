Return-Path: <linux-kselftest+bounces-15385-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2E9952A34
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 09:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B27C283A0F
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 07:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9899817B51C;
	Thu, 15 Aug 2024 07:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5fhLhXE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15712176AC1;
	Thu, 15 Aug 2024 07:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723708605; cv=none; b=c1X0B+RGycaWQ2/rfa2e63AO5pCpMGCEeiM9aDYgkDUuD8b2I4M6msW7mgV+hiCySDeijzFyT2NAI+uYYvGEQL50dllz7qki2YYp616VNSVepc2VyZvhom2opNBzNqZ1maPtwd8A9Cj3SLaNRF5WlUK0C+1g6f7iON2DVJyknvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723708605; c=relaxed/simple;
	bh=yPqL/Vl4cHrWI9TeW3BIpMOg30zZQUvOVQSCoFP9JQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dz3JoAMXs3c7g1x1kPTHo5FKkxujXl5YwJXQUQzkUUSJQjD21t2dPpUIlD42oXqLTxQ9ABwoP4lFl7zN7cgw4nCDW/adMaVqHyJApiaBnROjFnKMDI6EoDhanf9gn2zZK35Jf6ECyyZHob3suw5RCklhox3FuZOzA5tu2eY65uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5fhLhXE; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d394313aceso459534a91.3;
        Thu, 15 Aug 2024 00:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723708603; x=1724313403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PZFumA3T0nWrA0tHEOuHISEhmHpu/mfJFFX0epjyzEQ=;
        b=X5fhLhXEHeQ4AQ6+wYuCAuHbi0cJecqX8c1mAlSpzvSHfleHY10QQ2aexnqcP6Yis4
         Y3IOvNEIDzYXuuJ+eIznof46KHJE/eRc+P+xA9313+fgXN1WPl1r9R/kfVoKdfcGtAvy
         2omLqjF7Lb45946ssX8QSuU7x2vEvxvyoYdFeTHCDOhio3COh76mOaSKVXI2YknVAMl0
         kimtSTh92AYMOjy0sDKoD8T9pRPVIulkALz65r8sgrWhtqbeXjQlNgtStBEfG9VdUyyS
         8ZeC7nlSGjHmw7QGU3OEtGsq7A90KvALwmOW1Vogz1hfhSTbrobO5eXeda5GftZ1xPmE
         6KBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723708603; x=1724313403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZFumA3T0nWrA0tHEOuHISEhmHpu/mfJFFX0epjyzEQ=;
        b=CDSQvbjLMi8C5K6vkC5HERYb2XQZwL4JwT0VyOTdrR9LqysyVWoNKHJbWLKTFDSS2v
         4jKPoN7193JkjT/wjDEwyenYiZ9o7551TA/SKSubmFSDH2lvYTCfB6ZHAnDmt5laNbud
         0X8e4JJErsLcv4bXTQINpGHtWzL1CnfSUMJ/UbGAASbWCzXydmoU90Vz+2AKOQxvo0Ax
         jV0U2GefhfOhLDiOi3zx4kNWQxpQ3NecKME0xcPQ+kmSVgFbkFfUoUx3QHcdpMZywOM7
         WpQ7ubP21+1nxJKhTpu2cbJsiRE4RETcH0w6uFGlcK4EgX/YpxKeS4Qmx0E7NAv1nT1n
         NKlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVc8dr6sBb1s97IgozKeJzYdONzy8TBjZUd0au+stV76oeJBSbgt8/c7ia4kuq/ugn9nwaI3O67xbPs5V43BCiaQmWEPNjhoRVpjjDNslch0cYp3GUdDmOdZJ/k3NtMUa+FuXZUvXLvJFYGsEI3vBcEqoHki1ZfzKX0+ZUEwLujU8tTjWpg
X-Gm-Message-State: AOJu0YzhQvS7Fv6wQsNd8vmQp4zHaEy6kz1PQh5KitPzPv3VVsevABnL
	inCaSOgL7vf3GcOb0LNUaIMeOhl1k1T5p0uEQ/WhREDFprf0KaN8
X-Google-Smtp-Source: AGHT+IHw5O4ewI8x/a7lIqXV5CCZGZvBZpZYtjA5gSFdMNgXbg4m+Arv2m97kgNb3kAhU/r+cv8yeA==
X-Received: by 2002:a17:90b:4b01:b0:2ca:8b71:21f4 with SMTP id 98e67ed59e1d1-2d3aaa999b0mr6168882a91.18.1723708603176;
        Thu, 15 Aug 2024 00:56:43 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac7dcf8csm2980435a91.17.2024.08.15.00.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 00:56:42 -0700 (PDT)
Date: Thu, 15 Aug 2024 15:56:36 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, David Wei <dw@davidwei.uk>,
	Willem de Bruijn <willemb@google.com>,
	Petr Machata <petrm@nvidia.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v2] net: netconsole: selftests: Create a new
 netconsole selftest
Message-ID: <Zr20tNtSUdW_JG8T@Laptop-X1>
References: <20240813183825.837091-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813183825.837091-1-leitao@debian.org>

On Tue, Aug 13, 2024 at 11:38:16AM -0700, Breno Leitao wrote:
> Adds a selftest that creates two virtual interfaces, assigns one to a
> new namespace, and assigns IP addresses to both.
> 
> It listens on the destination interface using socat and configures a
> dynamic target on netconsole, pointing to the destination IP address.
> 
> The test then checks if the message was received properly on the
> destination interface.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Changelog:
> 
> v2:
>  * Change the location of the path (Jakub)
>  * Move from veth to netdevsim
>  * Other small changes in dependency checks and cleanup
> 
> v1:
>  * https://lore.kernel.org/all/ZqyUHN770pjSofTC@gmail.com/
> 
>  MAINTAINERS                                   |   1 +
>  tools/testing/selftests/drivers/net/Makefile  |   1 +
>  .../selftests/drivers/net/netcons_basic.sh    | 223 ++++++++++++++++++
>  3 files changed, 225 insertions(+)
>  create mode 100755 tools/testing/selftests/drivers/net/netcons_basic.sh
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a9dace908305..ded45f1dff7e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15770,6 +15770,7 @@ M:	Breno Leitao <leitao@debian.org>
>  S:	Maintained
>  F:	Documentation/networking/netconsole.rst
>  F:	drivers/net/netconsole.c
> +F:	tools/testing/selftests/drivers/net/netcons_basic.sh
>  
>  NETDEVSIM
>  M:	Jakub Kicinski <kuba@kernel.org>
> diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
> index e54f382bcb02..928530b26abc 100644
> --- a/tools/testing/selftests/drivers/net/Makefile
> +++ b/tools/testing/selftests/drivers/net/Makefile
> @@ -3,6 +3,7 @@
>  TEST_INCLUDES := $(wildcard lib/py/*.py)
>  
>  TEST_PROGS := \
> +	netcons_basic.sh \
>  	ping.py \
>  	queues.py \
>  	stats.py \
> diff --git a/tools/testing/selftests/drivers/net/netcons_basic.sh b/tools/testing/selftests/drivers/net/netcons_basic.sh
> new file mode 100755
> index 000000000000..e0e58fc7e89f
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/netcons_basic.sh
> @@ -0,0 +1,223 @@
> +#!/usr/bin/env bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# This test creates two netdevsim virtual interfaces, assigns one of them (the
> +# "destination interface") to a new namespace, and assigns IP addresses to both
> +# interfaces.
> +#
> +# It listens on the destination interface using socat and configures a dynamic
> +# target on netconsole, pointing to the destination IP address.
> +#
> +# Finally, it checks whether the message was received properly on the
> +# destination interface.  Note that this test may pollute the kernel log buffer
> +# (dmesg) and relies on dynamic configuration and namespaces being configured.
> +#
> +# Author: Breno Leitao <leitao@debian.org>
> +
> +set -euo pipefail
> +
> +SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
> +
> +# Simple script to test dynamic targets in netconsole
> +SRCIF="" # to be populated later
> +SRCIP=192.168.1.1
> +DSTIF="" # to be populated later
> +DSTIP=192.168.1.2
> +
> +PORT="6666"
> +MSG="netconsole selftest"
> +TARGET=$(mktemp -u netcons_XXXXX)
> +NETCONS_CONFIGFS="/sys/kernel/config/netconsole"
> +NETCONS_PATH="${NETCONS_CONFIGFS}"/"${TARGET}"
> +# This will have some tmp values appended to it in set_network()
> +NAMESPACE="netconsns_dst"
> +
> +# IDs for netdevsim
> +NSIM_DEV_1_ID=$((256 + RANDOM % 256))
> +NSIM_DEV_2_ID=$((512 + RANDOM % 256))
> +
> +# Used to create and delete namespaces
> +source "${SCRIPTDIR}"/../../net/lib.sh

If you want to source net/lib.sh, you need to add it to Makefile. e.g.

TEST_INCLUDES := ../../../net/lib.sh

See example in tools/testing/selftests/drivers/net/bonding/Makefile

Thanks
Hangbin

