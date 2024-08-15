Return-Path: <linux-kselftest+bounces-15396-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C82E952D08
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 12:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED0BAB236CD
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 10:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364311BCA08;
	Thu, 15 Aug 2024 10:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lD4WUaEa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027981BC9FA;
	Thu, 15 Aug 2024 10:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723718848; cv=none; b=QFavy86qzkgGNQfgW/Iz3D2/xfDhDAp0p1IGiVAyq43+ipxXnP5FsyKpiWKkDQ6gn3n6vHDk2A2qdRXFvmRbGGQ/ZtmkIWRqSepmERYemrWBYbsPqxidQiAjHzhrBdFkLmXgxBXgrMjkCMHU4Ca7k3T4qO74Y2lxgRZ1rM6rVOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723718848; c=relaxed/simple;
	bh=SyUtfx9pndMgeXZmYY2NIaXgUM3Zbg6Fhj7I0i2AHR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K82HDkGaLlPWig6ki8t2N4+whEKJImvYhT/49a5NvOKd3W5sXAf764DlDsF274ylM2lOjwtm//uN8uQgA6+z0tS/y8FhyqCf5up1rJJHm7p23EQbWrMLWyFrqUbMlRdfto+FDuPkvXsd80nZqUwoUvXd580zj8i5ThwigP0ewQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lD4WUaEa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E065C32786;
	Thu, 15 Aug 2024 10:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723718847;
	bh=SyUtfx9pndMgeXZmYY2NIaXgUM3Zbg6Fhj7I0i2AHR0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lD4WUaEabRGgDzakUvnjXTt5NgxW2xLoSDXncAE4R2dVHTG/snMpaLvsP8jmbiB+0
	 faSmE42q2VXOeyV/naxUH260N56kWZLom1x2lIf2VGM8XfxZCdoft+xt4sAvSQ0PxM
	 C0FV8+1Q4LqfM/qkQz1/HP+L+BbMnQtGVOX1YH9JSHOTls7SxNycKztWVUl3urvlNA
	 DYTc2TgE7N+z9z5/m61qpD7S3qU86R2IJqi8vZcITqmn2mLjjkSfjNdATvk+MIPgkV
	 HZmzX+9pvAiiMuAVn/6Uhvt0NDSCIyzmh/YezwR2oo7/bkbgzMu6mqy4sYH9XnmR5O
	 C1YyYEBeQ83og==
Message-ID: <127af9ef-2d69-4765-a8f0-0dece3b6dd1d@kernel.org>
Date: Thu, 15 Aug 2024 12:47:22 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next v3] net: netconsole: selftests: Create a new
 netconsole selftest
To: Breno Leitao <leitao@debian.org>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 liuhangbin@gmail.com, petrm@nvidia.com, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, David Wei <dw@davidwei.uk>,
 Willem de Bruijn <willemb@google.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20240815095157.3064722-1-leitao@debian.org>
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20240815095157.3064722-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Breno,

On 15/08/2024 11:51, Breno Leitao wrote:
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
> v3:
>  * Defined CONFIGs in config file (Jakub)
>  * Identention fixes (Petr Machata)
>  * Use setup_ns in a better way (Matthieu Baerts)
>  * Add dependencies in TEST_INCLUDES (Hangbin Liu)

Thank you for the v3!

I only looked here at how 'setup_ns' was used, (and a few other
Bash-related stuff), but not at the test itself.

I have a few comments, but I don't consider them as blocking if you
prefer to continue with the current version.

(...)

> diff --git a/tools/testing/selftests/drivers/net/netcons_basic.sh b/tools/testing/selftests/drivers/net/netcons_basic.sh
> new file mode 100755
> index 000000000000..929f27a0fd9c
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/netcons_basic.sh
> @@ -0,0 +1,226 @@

(...)

> +# This will have some tmp values appended to it in set_network()
> +NAMESPACE="netconsns_dst"

nit: the comment is no longer correct: if this variable is set before
being used with setup_ns, the netns will not have a unique name, but it
will use the one defined here. Maybe not what you want?

See this code from lib.sh where "ns_name" is "NAMESPACE":

  # Some test may setup/remove same netns multi times
  if [ -z "${!ns_name}" ]; then
          eval "${ns_name}=${ns_name,,}-$(mktemp -u XXXXXX)"
  else
          cleanup_ns "${!ns_name}"
  fi

So it will not set a new value, but it will try to clean any netns with
this "netconsns_dst" name. I guess that's fine, but maybe you prefer to
do like the others and simply define "NAMESPACE" to an empty string?

(...)

> +link_ifaces() {
> +	local NSIM_DEV_SYS_LINK="/sys/bus/netdevsim/link_device"
> +	local SRCIF_IFIDX=$(cat /sys/class/net/"$SRCIF"/ifindex)
> +	local DSTIF_IFIDX=$(cat /sys/class/net/"$DSTIF"/ifindex)
> +
> +	exec {NAMESPACE_FD}</var/run/netns/"${NAMESPACE}"
> +	exec {INITNS_FD}</proc/self/ns/net
> +
> +	# Bind the dst interface to namespace
> +	ip link set "${DSTIF}" netns "${NAMESPACE}"
> +
> +	# Linking one device to the other one (on the other namespace}
> +	echo "${INITNS_FD}:$SRCIF_IFIDX $NAMESPACE_FD:$DSTIF_IFIDX" \
> +		> $NSIM_DEV_SYS_LINK
> +	if [ $? -ne 0 ]; then

Because of the 'set -e' defined above, I guess the script will stop just
before in case of error, no? Maybe better with:

  if ! echo "(...)" > $NSIM_DEV_SYS_LINK; then

(note that shellcheck should help to spot such issues I think)

> +		echo "linking netdevsim1 with netdevsim2 should succeed"
> +		cleanup
> +		exit ${ksft_skip}
> +	fi
> +}

(...)

> +function listen_port_and_save_to() {
> +	local OUTPUT=${1}
> +	# Just wait for 2 seconds
> +	timeout 2 ip netns exec "${NAMESPACE}" \
> +		socat UDP-LISTEN:"${PORT}",fork "${OUTPUT}"
> +}
> +
> +function validate_result() {
> +	local TMPFILENAME="$1"
> +
> +	# Check if the file exists
> +	if [ ! -f "$TMPFILENAME" ]; then
> +		echo "FAIL: File was not generated." >&2
> +		return ${ksft_fail}
> +	fi
> +
> +	if ! grep -q "${MSG}" "${TMPFILENAME}"; then
> +		echo "FAIL: ${MSG} not found in ${TMPFILENAME}" >&2
> +		cat "${TMPFILENAME}" >&2
> +	return ${ksft_fail}

nit: a tab is missing here.

> +	fi
> +
> +	# Delete the file once it is validated, otherwise keep it
> +	# for debugging purposes
> +	rm "${TMPFILENAME}"
> +	return ${ksft_pass}
> +}

(...)

> +# ========== #
> +# Start here #
> +# ========== #
> +modprobe netdevsim || true
> +modprobe netconsole || true

If errors can be expected, maybe clearer to mute stderr, not to confuse
the people reading the logs?

Same above with 'udevadm settle || true'.

> +
> +# The content of kmsg will be save to the following file
> +OUTPUT_FILE="/tmp/${TARGET}"
> +
> +# Check for basic system dependency and exit if not found
> +check_for_dependencies
> +# Remove the namespace, interfaces and netconsole target on exit
> +trap cleanup EXIT
> +# Create one namespace and two interfaces
> +set_network
> +# Create a dynamic target for netconsole
> +create_dynamic_target
> +# Listed for netconsole port inside the namespace and destination interface
> +listen_port_and_save_to "${OUTPUT_FILE}" &
> +
> +# Wait for socat to start and listen to the port.
> +sleep 1

I guess that's fine as it is, but it is often better to avoid a sleep
with a "random" value: CI can be very slow, e.g. when running without
KVM and/or with a debug kernel config. Here, wait_local_port_listen()
from net_helper.sh could probably be used. The script will then probably
wait less than 1 second.

> +# Send the message
> +echo "${MSG}: ${TARGET}" > /dev/kmsg
> +# Wait until socat saves the file to disk
> +sleep 1

For here, I'm not sure, but 'busywait()' could be used, waiting for the
OUTPUT_FILE to have a non 0 size?

If you do that, you can maybe increase the timeout you used above, to
support very slow environments.

But if you prefer, I guess you can also leave things like they are and
see if CIs are complaining (but these errors might not be easy to debug).

> +
> +# Make sure the message was received in the dst part
> +validate_result "${OUTPUT_FILE}"
> +ret=$?

Here as well, because of 'set -e', this line is probably useless.

  validate_result "${OUTPUT_FILE}" || ret=$?

(or exit directly from validate_result() )

> +
> +exit ${ret}

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


