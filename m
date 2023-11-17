Return-Path: <linux-kselftest+bounces-253-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A36287EF513
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Nov 2023 16:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 663F4280D48
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Nov 2023 15:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AC530344;
	Fri, 17 Nov 2023 15:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bN23w5/0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2989A1C692;
	Fri, 17 Nov 2023 15:21:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B63AC433C9;
	Fri, 17 Nov 2023 15:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700234504;
	bh=a62fWKk1eb9TGQvUS98DVjVF8hvQAFvABnre5JNQoEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bN23w5/0fkbwH6Ux7LE55aOXFOYTr0ENOl+hXq012Ozqn1YyoPo/1CHxCrW8C9EHH
	 rSnIL1R8H2Te2q0iMwVjo+PmgKPDt1wfV/18ptt4yyj1qPXEmc6t4PhscXTMjhCOKi
	 JdMUH1PdSEY8m/hZoLuQ1tS0cji/iXIFBCLdgfuF9WyIUkKG6Dxvk9h6SP/8qIrotA
	 /3nZTvF6G4nbz58TKCMUjr64WIP/Tu85BDncjLts1A1dfMnweWh489XpgEOWY1fgV6
	 OFG8H1k9jLgEE68rfqyfPTNrdDUXCHke888mHpYO+V9T4F8flFi9FSe5CosEm0Cgp3
	 +2IrbMUy7zDQw==
Date: Fri, 17 Nov 2023 15:21:39 +0000
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com,
	linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net-next 14/14] selftests: mlxsw: Add PCI reset test
Message-ID: <20231117152139.GA164483@vergenet.net>
References: <cover.1700047319.git.petrm@nvidia.com>
 <f0dea3a59ae1e8eb73be5cb1269383bf1bcc922c.1700047319.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0dea3a59ae1e8eb73be5cb1269383bf1bcc922c.1700047319.git.petrm@nvidia.com>

+ linux-kselftest ML, Shuah Khan

On Wed, Nov 15, 2023 at 01:17:23PM +0100, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> Test that PCI reset works correctly by verifying that only the expected
> reset methods are supported and that after issuing the reset the ifindex
> of the port changes.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  .../selftests/drivers/net/mlxsw/pci_reset.sh  | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100755 tools/testing/selftests/drivers/net/mlxsw/pci_reset.sh
> 
> diff --git a/tools/testing/selftests/drivers/net/mlxsw/pci_reset.sh b/tools/testing/selftests/drivers/net/mlxsw/pci_reset.sh
> new file mode 100755
> index 000000000000..fe0343b95e6c
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/mlxsw/pci_reset.sh
> @@ -0,0 +1,58 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Test that PCI reset works correctly by verifying that only the expected reset
> +# methods are supported and that after issuing the reset the ifindex of the
> +# port changes.
> +
> +lib_dir=$(dirname $0)/../../../net/forwarding
> +
> +ALL_TESTS="
> +	pci_reset_test
> +"
> +NUM_NETIFS=1
> +source $lib_dir/lib.sh
> +source $lib_dir/devlink_lib.sh
> +
> +pci_reset_test()
> +{
> +	RET=0
> +
> +	local bus=$(echo $DEVLINK_DEV | cut -d '/' -f 1)
> +	local bdf=$(echo $DEVLINK_DEV | cut -d '/' -f 2)
> +
> +	if [ $bus != "pci" ]; then
> +		check_err 1 "devlink device is not a PCI device"
> +		log_test "pci reset"
> +		return
> +	fi
> +
> +	if [ ! -f /sys/bus/pci/devices/$bdf/reset_method ]; then
> +		check_err 1 "reset is not supported"
> +		log_test "pci reset"
> +		return
> +	fi
> +
> +	[[ $(cat /sys/bus/pci/devices/$bdf/reset_method) == "bus" ]]
> +	check_err $? "only \"bus\" reset method should be supported"
> +
> +	local ifindex_pre=$(ip -j link show dev $swp1 | jq '.[]["ifindex"]')
> +
> +	echo 1 > /sys/bus/pci/devices/$bdf/reset
> +	check_err $? "reset failed"
> +
> +	# Wait for udev to rename newly created netdev.
> +	udevadm settle
> +
> +	local ifindex_post=$(ip -j link show dev $swp1 | jq '.[]["ifindex"]')
> +
> +	[[ $ifindex_pre != $ifindex_post ]]
> +	check_err $? "reset not performed"
> +
> +	log_test "pci reset"
> +}
> +
> +swp1=${NETIFS[p1]}
> +tests_run
> +
> +exit $EXIT_STATUS
> -- 
> 2.41.0
> 

