Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 385CF71C05
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2019 17:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfGWPok (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Jul 2019 11:44:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45514 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfGWPok (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Jul 2019 11:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CBzbQAQ88+Tnqc6Sizg4AVsPyC78/8SBIlQyCkD9ikw=; b=3TzkdI0V+g60KZCDuKD6fvpjqT
        KQePii2fLsTVPTKF2Cr/GIzxZ6VOkY4CdgJiV3LdPT2wpRsmVY1Isvxygd5sEujjoa/4bT0MZZhUc
        Vgl7MiuFLf1sB4jh+PsR9NUC/Ll883Lc/Bz6LPvq1yoK40gS8TzDmcqTP772WjijWXphO1EFRnjwI
        bh4boXzjhJZwO7inrkpziM90KoO4XdxCRioXnfjCjIaE+c5hRaJeOtyxdPuRZyHLKApF38+O6b8VK
        U+6pen1d5jLqCrQqrqTEDvMcqTfcoRS0yVJJ+a7QLL4lH+H5iNzMLTngk7aoahScob/XKkF0Q9UES
        IuskWmoA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=[192.168.1.17])
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hpwxz-0000wm-3m; Tue, 23 Jul 2019 15:44:39 +0000
Subject: Re: [PATCH] selftests: kmod: Fix typo in kmod.sh
To:     Masanari Iida <standby24x7@gmail.com>,
        linux-kernel@vger.kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
References: <20190723102252.19931-1-standby24x7@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e803bc0d-d5f3-5821-181e-930e5099254a@infradead.org>
Date:   Tue, 23 Jul 2019 08:44:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190723102252.19931-1-standby24x7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/23/19 3:22 AM, Masanari Iida wrote:
> This patch fixes some spelling typos in kmod.sh
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  tools/testing/selftests/kmod/kmod.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kmod/kmod.sh b/tools/testing/selftests/kmod/kmod.sh
> index 0a76314b4414..8b944cf042f6 100755
> --- a/tools/testing/selftests/kmod/kmod.sh
> +++ b/tools/testing/selftests/kmod/kmod.sh
> @@ -28,7 +28,7 @@
>  # override by exporting to your environment prior running this script.
>  # For instance this script assumes you do not have xfs loaded upon boot.
>  # If this is false, export DEFAULT_KMOD_FS="ext4" prior to running this
> -# script if the filesyste module you don't have loaded upon bootup
> +# script if the filesystem module you don't have loaded upon bootup
>  # is ext4 instead. Refer to allow_user_defaults() for a list of user
>  # override variables possible.
>  #
> @@ -263,7 +263,7 @@ config_get_test_result()
>  config_reset()
>  {
>  	if ! echo -n "1" >"$DIR"/reset; then
> -		echo "$0: reset shuld have worked" >&2
> +		echo "$0: reset should have worked" >&2
>  		exit 1
>  	fi
>  }
> @@ -488,7 +488,7 @@ usage()
>  	echo Example uses:
>  	echo
>  	echo "${TEST_NAME}.sh		-- executes all tests"
> -	echo "${TEST_NAME}.sh -t 0008	-- Executes test ID 0008 number of times is recomended"
> +	echo "${TEST_NAME}.sh -t 0008	-- Executes test ID 0008 number of times is recommended"
>  	echo "${TEST_NAME}.sh -w 0008	-- Watch test ID 0008 run until an error occurs"
>  	echo "${TEST_NAME}.sh -s 0008	-- Run test ID 0008 once"
>  	echo "${TEST_NAME}.sh -c 0008 3	-- Run test ID 0008 three times"
> 


-- 
~Randy
