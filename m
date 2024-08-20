Return-Path: <linux-kselftest+bounces-15799-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6633F9590E2
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 01:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1DCD1C20FEE
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 23:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B00A1C8245;
	Tue, 20 Aug 2024 23:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEBdLcF7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2AF107A0;
	Tue, 20 Aug 2024 23:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724195199; cv=none; b=c4cnfghuM+uylQ5lHw1DZgf9q2EKW1F69YoqdhO+bj/jb2NJ7d2zh/W3PW0OZt8zVZyYXgNg0z4yZZ1/kpvjZMYPmP6hQNe/2BcUN+Gd8YrzL3sLgR5xH+8z7FlwHByy34hNUUgqO8wkr+9m/hekyWG6vjvL/skoplkVDaL+yGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724195199; c=relaxed/simple;
	bh=ykJbsh+yXEzqA527szztRYLhUfRNUDRcnKxSvB+ndjE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=as+HoO/e8+0uujCPBZPfe4Ol+c2/n0NPi7Z7v8/Hk4uhYgubWQES8n1cw+bRLmerDVEmykDQYkvVg2VPEo7jL0CuHmTMzU5B3tTXnREg+qoQNQ48XN4z0SSfoTJwUlxWmOQLp+y97ToRqQ/2jlClFKj4y2yE9Qb5Z4yy69bCPr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEBdLcF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FBFC4AF09;
	Tue, 20 Aug 2024 23:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724195198;
	bh=ykJbsh+yXEzqA527szztRYLhUfRNUDRcnKxSvB+ndjE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VEBdLcF74hlk9VN+GIosyLt7P2w34iAp8UYxBxVQQVZjR0m+8GB4U+nDuFsKFYael
	 kBHpDLCr/KoFEWFIJBxkru+nYXprj88tu0GiosxouuGdN0TJ2l1+A68qF5cdTMHdfi
	 m/RieKS7hmqI3BiaeMS+THMeAfnq1OR1hkCXOnD6hRWvSXn4TRb54gZOvMMXzKhO6W
	 iSOgzkF6lQYf9c9gPoh0CW4+pZjo+8P6w+z8DcfLl3XUIGmMe1q7+Ihfo7yBb6iQq+
	 FiFeEtZ+WCI+5KOxY3tE33nZVfwgOlsIFksF4AkTptKbn7tQFeV+qQxFcQKqtRy/Yq
	 j+v2XzWKEMIXg==
Date: Tue, 20 Aug 2024 16:06:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 liuhangbin@gmail.com, petrm@nvidia.com, matttbe@kernel.org, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org, Willem de Bruijn
 <willemb@google.com>, David Wei <dw@davidwei.uk>,
 linux-kernel@vger.kernel.org (open list), linux-kselftest@vger.kernel.org
 (open list:KERNEL SELFTEST FRAMEWORK)
Subject: Re: [PATCH net-next v5] net: netconsole: selftests: Create a new
 netconsole selftest
Message-ID: <20240820160636.7bfc4d5a@kernel.org>
In-Reply-To: <20240819090406.1441297-1-leitao@debian.org>
References: <20240819090406.1441297-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Aug 2024 02:03:53 -0700 Breno Leitao wrote:
> +function check_for_dependencies() {
> +	if [ "$(id -u)" -ne 0 ]; then
> +		echo "This test must be run as root" >&2
> +		exit "${ksft_skip}"
> +	fi
> +
> +	if ! which socat > /dev/null ; then
> +		echo "SKIP: socat(1) is not available" >&2
> +		exit "${ksft_skip}"
> +	fi
> +
> +	if ! which ip > /dev/null ; then
> +		echo "SKIP: ip(1) is not available" >&2
> +		exit "${ksft_skip}"
> +	fi
> +
> +	if ! which udevadm > /dev/null ; then
> +		echo "SKIP: udevadm(1) is not available" >&2
> +		exit "${ksft_skip}"
> +	fi
> +
> +	if [ ! -d "${NETCONS_CONFIGFS}" ]; then
> +		echo "SKIP: directory ${NETCONS_CONFIGFS} does not exist. Check if NETCONSOLE_DYNAMIC is enabled" >&2
> +		exit "${ksft_skip}"
> +	fi
> +
> +	if ip link show "${DSTIF}" 2> /dev/null; then
> +		echo "SKIP: interface ${DSTIF} exists in the system. Not overwriting it." >&2
> +		exit "${ksft_skip}"
> +	fi

nit: maybe ip addr list to see if the 192.168.1.x network is already in
use? 

> +}
> +
> +# ========== #
> +# Start here #
> +# ========== #
> +modprobe netdevsim 2> /dev/null || true
> +modprobe netconsole 2 > /dev/null || true
> +
> +# The content of kmsg will be save to the following file
> +OUTPUT_FILE="/tmp/${TARGET}"
> +
> +# Check for basic system dependency and exit if not found
> +check_for_dependencies
> +# Set current loglevel to KERN_INFO(6), and default to KERN_NOTICE(5)
> +echo "6 5" > /proc/sys/kernel/printk

nit: should we not undo this in clenaup?

> +# Remove the namespace, interfaces and netconsole target on exit
> +trap cleanup EXIT
> +# Create one namespace and two interfaces
> +set_network
> +# Create a dynamic target for netconsole
> +create_dynamic_target
> +# Listed for netconsole port inside the namespace and destination interface
> +listen_port_and_save_to "${OUTPUT_FILE}" &
> +# Wait for socat to start and listen to the port.
> +wait_local_port_listen "${NAMESPACE}" "${PORT}" udp
> +# Send the message
> +echo "${MSG}: ${TARGET}" > /dev/kmsg
> +# Wait until socat saves the file to disk
> +busywait "${BUSYWAIT_TIMEOUT}" test -s "${OUTPUT_FILE}"
> +
> +# Make sure the message was received in the dst part
> +# and exit
> +validate_result "${OUTPUT_FILE}"

Main reason Im complaining, I see:

[    6.686720] netconsole: unknown parameter '2' ignored

in the kernel logs when the test runs.

Is it expected?
-- 
pw-bot: cr

