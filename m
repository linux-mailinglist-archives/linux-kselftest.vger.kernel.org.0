Return-Path: <linux-kselftest+bounces-45291-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 199BCC4D11C
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 11:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB3204F61B6
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 10:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9C334C804;
	Tue, 11 Nov 2025 10:27:59 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F5934B674
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Nov 2025 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762856879; cv=none; b=l3Xb+S1UZuA/CNaqtOV14OhEEXI7rCdysEw7v/iul/iVeUgjIahplbSaWigRXkLVkJoxNd9WaPHC3gomI8yeY0NNeM6DmGvn6ziD0hEteV0blXFQyfXyTDlJrNCjh8sMe6pLGMHHGodcif2UOQg6YImjtFPU8m+ENpCMP6tzjFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762856879; c=relaxed/simple;
	bh=/8CzXfuHcEJlSJRA11zs4FnS8Nv46Y0bC/+D45XIcAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVsRhd9+sSSD3E4ChsWVccL7TxYthcf1FPjgc+HhhxbXHbDisjBFdE8OKYeWiBUObz5FdFJIF4xZw5TSZKBSWocphARSOCJDfcBGkd0WpSy2QD/vw3CAYaNpcMcYafv0epYkQgy7GDqS03DVYb9V8eNkOnPF4vW3E+gqGU9As1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-3c9859913d0so2262244fac.0
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Nov 2025 02:27:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762856876; x=1763461676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXcNh9uEcUlM67NldM+wkaR6qeKY7aCoNzjVAfRE4U8=;
        b=Xpnuo7mSlXIRvc1gXNzi0FvJz99FFRojk0EM3t58EP6LEzzOGT0IuEZyaRwlikCo1L
         ZFlT/AZbtLv9V0HDtcPyFT4b1HK/euQ6y1w1i+M6oicKboPx7jAG1oDiQ6FMKnsEy46V
         DbqbVTidfOXTuvcPV8kHGbmb80QCugHeEzlLJg5WQ9ogisjqxQWUFhkR46BdwxdNFyuq
         sQvPYkwpifj/w4/qlXoRKV3+MhFdbz1zpRxE+886tniPXHlR/ByCPN4cykt3Qyr5/777
         N6Y1U7x6UN62ZwmGT4oLmExiM+brn2LsAhgblhpvkA7cuhVkrb27AxRvkn2h8ibf/V7D
         xOFg==
X-Forwarded-Encrypted: i=1; AJvYcCWXJBN56Hn53ZI4f7QfZr61NXCnah50MSKjOdkSvZGqcSK6KRED4ujIDjknTbRHpPRz/q2nB7KsbD14Vx3FAw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxsxeKQygqvcnXzLKOnzfDHlbDL2T4yvlkVUUCwYdYVywt6LDu
	AarGUZ54GQwvc8ZY9oWWc/vROOLAD3Vj9y6CSm3AFq/Uw/iZb5+zlUPk
X-Gm-Gg: ASbGnctTRARid6b4gAJcwUC6elTqL++fiGZ/1cDW39Bi5h9Yubbft/ZEKPlNy++s9ZL
	qyF/eNY665KcDKovwN2gWa694+zE8LflnHTDt/XdSSNgaxWVBOGl/CT0W2CxDNGKDGlkTKK/1Px
	W1l5+qwc2wXatzAiVpuP3s0uHF+4ON1qBAZBeVKaHHI4jpFkMO2OcIvPt15ZYGKHi2rXZpxaxtb
	QDq/KoqFBKLL0BUEQg5pNa/qth0Qb5WGM/nIFo8wJ6o9z92jzC/wcfdkuzVDblWF8O/GXj7R5lX
	lL+mMxB0UKSdNOBBE8z30C6+gGDWCVqtUhjoZWeYQmbbtDUu/XoLS8Be27cDD9uZdvLQlJCb7wF
	BwWU1iMPJld60CRp0tGRstp5omod+5pVdFNgaMpEfbG/tCb9g35bmvP8MFr9fcqp7XWBLP1xOub
	WxKQ==
X-Google-Smtp-Source: AGHT+IEzVtMODbxRkCJvy3lTstnvvwHWNG9lfiDUwJA7fVsJcqlAOniXiPB2G6BGunxf9fRFY+u0kQ==
X-Received: by 2002:a05:6870:8123:b0:3e8:172f:da82 with SMTP id 586e51a60fabf-3e8172fdfd0mr1103253fac.19.1762856876015;
        Tue, 11 Nov 2025 02:27:56 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:8::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3e41eba8ce5sm7616709fac.4.2025.11.11.02.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 02:27:55 -0800 (PST)
Date: Tue, 11 Nov 2025 02:27:53 -0800
From: Breno Leitao <leitao@debian.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3 6/6] selftests: netconsole: validate target
 resume
Message-ID: <kv5q2fq3mypb4eenrk6z3j4yjfhrlmjdcgwrsgm7cefvso7n3x@j3mcnw3uaaq5>
References: <20251109-netcons-retrigger-v3-0-1654c280bbe6@gmail.com>
 <20251109-netcons-retrigger-v3-6-1654c280bbe6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109-netcons-retrigger-v3-6-1654c280bbe6@gmail.com>

On Sun, Nov 09, 2025 at 11:05:56AM +0000, Andre Carvalho wrote:
> Introduce a new netconsole selftest to validate that netconsole is able
> to resume a deactivated target when the low level interface comes back.
> 
> The test setups the network using netdevsim, creates a netconsole target
> and then remove/add netdevsim in order to bring the same interfaces
> back. Afterwards, the test validates that the target works as expected.
> 
> Targets are created via cmdline parameters to the module to ensure that
> we are able to resume targets that were bound by mac and interface name.
> 
> Signed-off-by: Andre Carvalho <asantostc@gmail.com>
> ---
>  tools/testing/selftests/drivers/net/Makefile       |  1 +
>  .../selftests/drivers/net/lib/sh/lib_netcons.sh    | 30 ++++++-
>  .../selftests/drivers/net/netcons_resume.sh        | 92 ++++++++++++++++++++++
>  3 files changed, 120 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
> index 68e0bb603a9d..fbd81bec66cd 100644
> --- a/tools/testing/selftests/drivers/net/Makefile
> +++ b/tools/testing/selftests/drivers/net/Makefile
> @@ -17,6 +17,7 @@ TEST_PROGS := \
>  	netcons_cmdline.sh \
>  	netcons_fragmented_msg.sh \
>  	netcons_overflow.sh \
> +	netcons_resume.sh \
>  	netcons_sysdata.sh \
>  	netpoll_basic.py \
>  	ping.py \
> diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
> index 8e1085e89647..88b4bdfa84cf 100644
> --- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
> +++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
> @@ -186,12 +186,13 @@ function do_cleanup() {
>  }
>  
>  function cleanup() {
> +	local TARGETPATH=${1:-${NETCONS_PATH}}
>  	# delete netconsole dynamic reconfiguration
> -	echo 0 > "${NETCONS_PATH}"/enabled
> +	echo 0 > "${TARGETPATH}"/enabled
>  	# Remove all the keys that got created during the selftest
> -	find "${NETCONS_PATH}/userdata/" -mindepth 1 -type d -delete
> +	find "${TARGETPATH}/userdata/" -mindepth 1 -type d -delete
>  	# Remove the configfs entry
> -	rmdir "${NETCONS_PATH}"
> +	rmdir "${TARGETPATH}"
>  
>  	do_cleanup
>  }
> @@ -350,6 +351,29 @@ function check_netconsole_module() {
>  	fi
>  }
>  
> +function wait_target_state() {
> +	local TARGET=${1}
> +	local STATE=${2}
> +	local FILE="${NETCONS_CONFIGFS}"/"${TARGET}"/"enabled"

local TARGET_PATH="${NETCONS_CONFIGFS}"/"${TARGET}"

> +
> +	if [ "${STATE}" == "enabled" ]
> +	then
> +		ENABLED=1

Shouldn't they be local variables in here ?

> +	else
> +		ENABLED=0
> +	fi
> +
> +	if [ ! -f "$FILE" ]; then

	if [ ! -f "${TARGET_PATH}" ]; then

> +		echo "FAIL: Target does not exist." >&2
> +		exit "${ksft_fail}"
> +	fi
> +
> +	slowwait 2 sh -c "test -n \"\$(grep \"${ENABLED}\" \"${FILE}\")\"" || {

	slowwait 2 sh -c "test -n \"\$(grep \"${ENABLED}\" \"${TARGET_PATH}/enabled\")\"" || {

> +		echo "FAIL: ${TARGET} is not ${STATE}." >&2
> +	}
> +}
> +
>  # A wrapper to translate protocol version to udp version
>  function wait_for_port() {
>  	local NAMESPACE=${1}
> diff --git a/tools/testing/selftests/drivers/net/netcons_resume.sh b/tools/testing/selftests/drivers/net/netcons_resume.sh
> new file mode 100755
> index 000000000000..404df7abef1b
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/netcons_resume.sh
> @@ -0,0 +1,92 @@
> +#!/usr/bin/env bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# This test validates that netconsole is able to resume a target that was
> +# deactivated when its interface was removed when the interface is brought
> +# back up.

Comment above is a bit harder to understand.

> +#
> +# The test configures a netconsole target and then removes netdevsim module to
> +# cause the interface to disappear. Targets are configured via cmdline to ensure
> +# targets bound by interface name and mac address can be resumed.
> +# The test verifies that the target moved to disabled state before adding
> +# netdevsim and the interface back.
> +#
> +# Finally, the test verifies that the target is re-enabled automatically and
> +# the message is received on the destination interface.
> +#
> +# Author: Andre Carvalho <asantostc@gmail.com>
> +
> +set -euo pipefail
> +
> +SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
> +
> +source "${SCRIPTDIR}"/lib/sh/lib_netcons.sh
> +
> +modprobe netdevsim 2> /dev/null || true
> +rmmod netconsole 2> /dev/null || true
> +
> +check_netconsole_module
> +
> +# Run the test twice, with different cmdline parameters
> +for BINDMODE in "ifname" "mac"
> +do
> +	echo "Running with bind mode: ${BINDMODE}" >&2
> +	# Set current loglevel to KERN_INFO(6), and default to KERN_NOTICE(5)
> +	echo "6 5" > /proc/sys/kernel/printk
> +
> +	# Create one namespace and two interfaces
> +	set_network
> +	trap do_cleanup EXIT

can we keep these trap lines outside of the loop?

> +
> +	# Create the command line for netconsole, with the configuration from
> +	# the function above
> +	CMDLINE=$(create_cmdline_str "${BINDMODE}")
> +
> +	# The content of kmsg will be save to the following file
> +	OUTPUT_FILE="/tmp/${TARGET}-${BINDMODE}"
> +
> +	# Load the module, with the cmdline set
> +	modprobe netconsole "${CMDLINE}"
> +	# Expose cmdline target in configfs
> +	mkdir ${NETCONS_CONFIGFS}"/cmdline0"
> +	trap 'cleanup "${NETCONS_CONFIGFS}"/cmdline0' EXIT
> +
> +	# Target should be enabled
> +	wait_target_state "cmdline0" "enabled"
> +
> +	# Remove low level module
> +	rmmod netdevsim
> +	# Target should be disabled
> +	wait_target_state "cmdline0" "disabled"
> +
> +	# Add back low level module
> +	modprobe netdevsim
> +	# Recreate namespace and two interfaces
> +	set_network
> +	# Target should be enabled again
> +	wait_target_state "cmdline0" "enabled"
> +
> +	# Listen for netconsole port inside the namespace and destination
> +	# interface
> +	listen_port_and_save_to "${OUTPUT_FILE}" &
> +	# Wait for socat to start and listen to the port.
> +	wait_local_port_listen "${NAMESPACE}" "${PORT}" udp
> +	# Send the message
> +	echo "${MSG}: ${TARGET}" > /dev/kmsg
> +	# Wait until socat saves the file to disk
> +	busywait "${BUSYWAIT_TIMEOUT}" test -s "${OUTPUT_FILE}"
> +	# Make sure the message was received in the dst part
> +	# and exit
> +	validate_msg "${OUTPUT_FILE}"
> +
> +	# kill socat in case it is still running
> +	pkill_socat
> +	# Cleanup & unload the module
> +	cleanup "${NETCONS_CONFIGFS}/cmdline0"
> +	rmmod netconsole

Why do we need to remove netconsole module in here?

Thanks for this patch. This is solving a real issue we have right now.
--breno

