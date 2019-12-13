Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8742311DEAC
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2019 08:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725770AbfLMHbY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Dec 2019 02:31:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:57774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfLMHbY (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Dec 2019 02:31:24 -0500
Received: from localhost (unknown [84.241.199.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E8AE22527;
        Fri, 13 Dec 2019 07:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576222284;
        bh=0F8E162DkAWc/zBDQj4WVQCnjIhvDR7U2JWM3qSA8Gk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1+/UVeWVO2Wrn7jAbXlNXC7NhAymCnGCkhK2IQpdzv5XP+YLF0tJZiAMRBvMAmOi0
         +Ddexmj9YWSYX9Mua3F5jFu7vYOCcS6ZFP0g+zUTUE5//EMjGEkGAm/qMavRIYReHi
         o9IU/c4ucTsbMlIDDgYin8wHACA9vcyXqcStx3j0=
Date:   Fri, 13 Dec 2019 08:31:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     shuah@kernel.org, mcgrof@kernel.org, scott.branden@broadcom.com,
        tiwai@suse.de, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: firmware: Fix it to do root uid check and skip
Message-ID: <20191213073121.GH1750354@kroah.com>
References: <20191213015606.23058-1-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213015606.23058-1-skhan@linuxfoundation.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 12, 2019 at 06:56:06PM -0700, Shuah Khan wrote:
> firmware attempts to load test modules that require root access
> and fail. Fix it to check for root uid and exit with skip code
> instead.
> 
> Before this fix:
> 
> selftests: firmware: fw_run_tests.sh
> modprobe: ERROR: could not insert 'test_firmware': Operation not permitted
> You must have the following enabled in your kernel:
> CONFIG_TEST_FIRMWARE=y
> CONFIG_FW_LOADER=y
> CONFIG_FW_LOADER_USER_HELPER=y
> CONFIG_IKCONFIG=y
> CONFIG_IKCONFIG_PROC=y
> not ok 1 selftests: firmware: fw_run_tests.sh # SKIP
> 
> With this fix:
> 
> selftests: firmware: fw_run_tests.sh
> skip all tests: must be run as root
> not ok 1 selftests: firmware: fw_run_tests.sh # SKIP
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  tools/testing/selftests/firmware/fw_lib.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/firmware/fw_lib.sh b/tools/testing/selftests/firmware/fw_lib.sh
> index b879305a766d..5b8c0fedee76 100755
> --- a/tools/testing/selftests/firmware/fw_lib.sh
> +++ b/tools/testing/selftests/firmware/fw_lib.sh
> @@ -34,6 +34,12 @@ test_modprobe()
>  
>  check_mods()
>  {
> +	local uid=$(id -u)
> +	if [ $uid -ne 0 ]; then
> +		echo "skip all tests: must be run as root" >&2
> +		exit $ksft_skip
> +	fi
> +
>  	trap "test_modprobe" EXIT
>  	if [ ! -d $DIR ]; then
>  		modprobe test_firmware
> -- 
> 2.20.1
> 

Reviwed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
