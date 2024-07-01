Return-Path: <linux-kselftest+bounces-12988-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5A491D9FA
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 10:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A95E42820BF
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 08:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373F454F87;
	Mon,  1 Jul 2024 08:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eYd9C5+K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C912C6BB;
	Mon,  1 Jul 2024 08:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719822800; cv=none; b=K+96CLRxrzyjYxMQouBtDweSGZKd4vbzPr0uDFOfi6mhDwjFBG1K1qXwmxHvY6H98zQ8XRvsedb6nMFWRfVKxk5yBZpkAlueTEvdv6su6WInM3jKHpXzjrTPkGUK0m/1YCXSRJeJJGyObI+Mfxnnl68pV2kPS//yue1ufmztnE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719822800; c=relaxed/simple;
	bh=KJK9NggzMkpfJ3LPI28wGASdmgxIriUy+xQWzpaXGQY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ipia4v+UgYYQ4fN4kfbgFd5aYOc7ARHJ+QPDOunnmR+06YV1i/BwOEdrmTUBZXdLJnvUGS/bG+6E1Vqw3ZpUtL5FsPxWFPxXXwc18+SZ5MfqIur7wIiwMOX42JC+zx6f9NMcghWl+b+FDnO5rHkq6vFhzAAt7JMDqGLDU0WjWrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eYd9C5+K; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719822796;
	bh=KJK9NggzMkpfJ3LPI28wGASdmgxIriUy+xQWzpaXGQY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=eYd9C5+KXuppOBjQ6nsOw3yaGVfV0BRaXjFaqZTtjK9pc3Q7mnWNbW3Jn66PLron9
	 LAqaovV4cGwx3yYnJX2rh+I770R5vKjWu+cXrENlirWih1I3qhD9hEn+tZwsn3EJkd
	 vbdrWOb+9Dr7zGWFdJEN2Fn65Jfr2e57jAPlCcAHDZKcI0Y4glZdgGPlbMk4X2iF5W
	 mcN7k4ha+Jd2S4BWOk0lOJUanvA8luW8qZzcZwqUvV+AsZ7oi6HZsPA4BhmK6XYtKz
	 Mj5ZLRDF1TcnkDELjR9gndSC1jrvGM9VUFc9OL3vYHILjdinMD6UINNlKxfHT+dB7X
	 syRmFbiOp+ZDQ==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6507C3782109;
	Mon,  1 Jul 2024 08:33:12 +0000 (UTC)
Message-ID: <f7d8502e-21b8-43f9-ad81-dbbe07df5300@collabora.com>
Date: Mon, 1 Jul 2024 13:33:08 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] selftests: firmware: conform test to TAP
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kees Cook <keescook@chromium.org>
References: <20240520163759.1427653-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240520163759.1427653-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Adding missing maintainer and reviser.

On 5/20/24 9:37 PM, Muhammad Usama Anjum wrote:
> Conform the layout, informational and status messages to TAP. No
> functional change is intended other than the layout of output messages.
> Without using TAP messages, the passed/failed/skip test names cannot be
> found. This is a prepartory patch, more patches will be sent to comform
> the test completely.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  .../selftests/firmware/fw_run_tests.sh        | 63 ++++++++++++-------
>  1 file changed, 40 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/testing/selftests/firmware/fw_run_tests.sh b/tools/testing/selftests/firmware/fw_run_tests.sh
> index f6d95a2d51249..5063c75345680 100755
> --- a/tools/testing/selftests/firmware/fw_run_tests.sh
> +++ b/tools/testing/selftests/firmware/fw_run_tests.sh
> @@ -6,6 +6,9 @@
>  
>  set -e
>  
> +DIR="$(dirname $(readlink -f "$0"))"
> +source "${DIR}"/../kselftest/ktap_helpers.sh
> +
>  TEST_DIR=$(dirname $0)
>  source $TEST_DIR/fw_lib.sh
>  
> @@ -26,54 +29,68 @@ run_tests()
>  	proc_set_force_sysfs_fallback $1
>  	proc_set_ignore_sysfs_fallback $2
>  	$TEST_DIR/fw_upload.sh
> +
> +	ktap_test_pass "Completed"
>  }
>  
>  run_test_config_0001()
>  {
> -	echo "-----------------------------------------------------"
> -	echo "Running kernel configuration test 1 -- rare"
> -	echo "Emulates:"
> -	echo "CONFIG_FW_LOADER=y"
> -	echo "CONFIG_FW_LOADER_USER_HELPER=n"
> -	echo "CONFIG_FW_LOADER_USER_HELPER_FALLBACK=n"
> +	ktap_print_msg "-----------------------------------------------------"
> +	ktap_print_msg "Running kernel configuration test 1 -- rare"
> +	ktap_print_msg "Emulates:"
> +	ktap_print_msg "CONFIG_FW_LOADER=y"
> +	ktap_print_msg "CONFIG_FW_LOADER_USER_HELPER=n"
> +	ktap_print_msg "CONFIG_FW_LOADER_USER_HELPER_FALLBACK=n"
>  	run_tests 0 1
>  }
>  
>  run_test_config_0002()
>  {
> -	echo "-----------------------------------------------------"
> -	echo "Running kernel configuration test 2 -- distro"
> -	echo "Emulates:"
> -	echo "CONFIG_FW_LOADER=y"
> -	echo "CONFIG_FW_LOADER_USER_HELPER=y"
> -	echo "CONFIG_FW_LOADER_USER_HELPER_FALLBACK=n"
> +	ktap_print_msg "-----------------------------------------------------"
> +	ktap_print_msg "Running kernel configuration test 2 -- distro"
> +	ktap_print_msg "Emulates:"
> +	ktap_print_msg "CONFIG_FW_LOADER=y"
> +	ktap_print_msg "CONFIG_FW_LOADER_USER_HELPER=y"
> +	ktap_print_msg "CONFIG_FW_LOADER_USER_HELPER_FALLBACK=n"
>  	proc_set_ignore_sysfs_fallback 0
>  	run_tests 0 0
>  }
>  
>  run_test_config_0003()
>  {
> -	echo "-----------------------------------------------------"
> -	echo "Running kernel configuration test 3 -- android"
> -	echo "Emulates:"
> -	echo "CONFIG_FW_LOADER=y"
> -	echo "CONFIG_FW_LOADER_USER_HELPER=y"
> -	echo "CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y"
> +	ktap_print_msg "-----------------------------------------------------"
> +	ktap_print_msg "Running kernel configuration test 3 -- android"
> +	ktap_print_msg "Emulates:"
> +	ktap_print_msg "CONFIG_FW_LOADER=y"
> +	ktap_print_msg "CONFIG_FW_LOADER_USER_HELPER=y"
> +	ktap_print_msg "CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y"
>  	run_tests 1 0
>  }
>  
> +ktap_print_header
> +
>  check_mods
>  check_setup
>  
> -echo "Running namespace test: "
> -$TEST_DIR/fw_namespace $DIR/trigger_request
> -echo "OK"
> -
>  if [ -f $FW_FORCE_SYSFS_FALLBACK ]; then
> +	ktap_set_plan "4"
> +
>  	run_test_config_0001
>  	run_test_config_0002
>  	run_test_config_0003
>  else
> -	echo "Running basic kernel configuration, working with your config"
> +	ktap_set_plan "2"
> +
> +	ktap_print_msg "Running basic kernel configuration, working with your config"
>  	run_tests
>  fi
> +
> +ktap_print_msg "Running namespace test: "
> +$TEST_DIR/fw_namespace $DIR/trigger_request
> +if [ $? -eq 0 ]; then
> +    ktap_test_pass "fw_namespace completed successfully"
> +else
> +    ktap_test_fail "fw_namespace failed"
> +fi
> +
> +ktap_finished

-- 
BR,
Muhammad Usama Anjum

