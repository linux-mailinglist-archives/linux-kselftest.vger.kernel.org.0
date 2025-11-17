Return-Path: <linux-kselftest+bounces-45728-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5086AC63986
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 11:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C74C74EBFC7
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 10:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44588318156;
	Mon, 17 Nov 2025 10:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="qMpFKE1S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB4330E0ED;
	Mon, 17 Nov 2025 10:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763375771; cv=none; b=DkR8UuX7LBSBqcksQXsEwkfTG99m9SwBMS8sZJLKqK56PIt0buR0jBv4qE2V2j1ZjBIRoz4eXTtvyAItUbica4hpi/jNH11hrB5GZaaXIeIlnP4wlrlwv9lzZIbwCCmibYpJFvFu6A1ZWb/3ajnLPMqp/PZbO/hOQagayLTbAAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763375771; c=relaxed/simple;
	bh=KSPgCJ97GRrXpoW8hmZWLmE3w95TFWqPKFOCt/clTYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnZ1dtppJaZB8hxrLZRCbgEpMNjiOoZw5+1GiQF0bwD1RbRUTFkAaLl7to6wvVE4ImgSODWauLT39k6K5BOxACvpJvMm0bdSQ2NafaefRuy5S+vbU6mGO3t3OGpOX+7hN6t/aZTB9fh/rJVcIkmoZ9QcE6wwEHFSRiaq6IFkSvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=qMpFKE1S; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qpvjh85w8VDGNQb2IXNPCd6h49MYt/U9hPxq6g2rhVo=; b=qMpFKE1Sp3WYzrMNjZ9RjtZl2W
	BoA9JBEs+QF5mBK02P4guR6OQZVu0kaROCnbqM+ePHT0iHCbx3AyFEX4DVM9WsEtZH5iN5nJLh8ME
	je/uRn0lhp3JRnkXFIOsxWWMG7MnxPbJrOui0tA03DD5iyf61dL7mQtxE7+Zk80zqUqNItRV0QNIR
	u9XzjySt2tM0hckulZXoIQBhlrfA5zHzdlSySrJ7doYLVKNMBn4g2D0SexIbGRk+/7MGJXHFjyScZ
	3m+FVgqgvR/jAWFIb53qI/gbHzh1CBRkeEvB9MI7wbTp1MWMh+aesS3mNqLj86UV8BECPLLHlBr3/
	aaa9vwQg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vKwaW-00ENIH-37; Mon, 17 Nov 2025 10:36:00 +0000
Date: Mon, 17 Nov 2025 02:35:55 -0800
From: Breno Leitao <leitao@debian.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v4 5/5] selftests: netconsole: validate target
 resume
Message-ID: <fd4jjkw6hpkyydg2uk6ys2paa3z3egsmfim3xidjtyyzxeg33n@jjww2sd4xcas>
References: <20251116-netcons-retrigger-v4-0-5290b5f140c2@gmail.com>
 <20251116-netcons-retrigger-v4-5-5290b5f140c2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251116-netcons-retrigger-v4-5-5290b5f140c2@gmail.com>
X-Debian-User: leitao

On Sun, Nov 16, 2025 at 05:14:05PM +0000, Andre Carvalho wrote:
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
>  .../selftests/drivers/net/lib/sh/lib_netcons.sh    | 35 ++++++--
>  .../selftests/drivers/net/netcons_resume.sh        | 97 ++++++++++++++++++++++
>  3 files changed, 128 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
> index 33f4816216ec..7dc9e5b23d5b 100644
> --- a/tools/testing/selftests/drivers/net/Makefile
> +++ b/tools/testing/selftests/drivers/net/Makefile
> @@ -17,6 +17,7 @@ TEST_PROGS := \
>  	netcons_cmdline.sh \
>  	netcons_fragmented_msg.sh \
>  	netcons_overflow.sh \
> +	netcons_resume.sh \
>  	netcons_sysdata.sh \
>  	netcons_torture.sh \
>  	netpoll_basic.py \
> diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
> index 87f89fd92f8c..6157db660067 100644
> --- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
> +++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
> @@ -203,19 +203,21 @@ function do_cleanup() {
>  function cleanup_netcons() {
>  	# delete netconsole dynamic reconfiguration
>  	# do not fail if the target is already disabled
> -	if [[ ! -d "${NETCONS_PATH}" ]]
> +	local TARGET_PATH=${1:-${NETCONS_PATH}}
> +
> +	if [[ ! -d "${TARGET_PATH}" ]]
>  	then
>  		# in some cases this is called before netcons path is created
>  		return
>  	fi
> -	if [[ $(cat "${NETCONS_PATH}"/enabled) != 0 ]]
> +	if [[ $(cat "${TARGET_PATH}"/enabled) != 0 ]]
>  	then
> -		echo 0 > "${NETCONS_PATH}"/enabled || true
> +		echo 0 > "${TARGET_PATH}"/enabled || true
>  	fi
>  	# Remove all the keys that got created during the selftest
> -	find "${NETCONS_PATH}/userdata/" -mindepth 1 -type d -delete
> +	find "${TARGET_PATH}/userdata/" -mindepth 1 -type d -delete
>  	# Remove the configfs entry
> -	rmdir "${NETCONS_PATH}"
> +	rmdir "${TARGET_PATH}"
>  }
>  
>  function cleanup() {
> @@ -377,6 +379,29 @@ function check_netconsole_module() {
>  	fi
>  }
>  
> +function wait_target_state() {
> +	local TARGET=${1}
> +	local STATE=${2}
> +	local TARGET_PATH="${NETCONS_CONFIGFS}"/"${TARGET}"
> +	local ENABLED=0
> +
> +	if [ "${STATE}" == "enabled" ]
> +	then
> +		local ENABLED=1

ENABLED is already marked as local above. "local" here is unnecessary.

Other than that, and with the "trap" fix, it might be in good shape.

Thanks for this selftest.
--breno

--
pw-bot: cr

