Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FE055A2A0
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jun 2022 22:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiFXU33 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jun 2022 16:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiFXU32 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jun 2022 16:29:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AC4522F4;
        Fri, 24 Jun 2022 13:29:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67582B82C0F;
        Fri, 24 Jun 2022 20:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6E6C34114;
        Fri, 24 Jun 2022 20:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656102565;
        bh=O++sAY0uz8ogMjYc9G/jGVGDKWn+wwGZ/0EKb1rWQcc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=USSsVe2Gp4KnH6BmgaGjWm1xE1Ni0ksS9ro+zQM5XChfpdO2sNjxifbkyScj7rts5
         E08gHTaTSHibL+a5BbG66vvZxvjI7FJBuFilDB5e7EY41HM+nT+bYlAh0IMuNcqjIg
         SrKAVw1dkCGo2T8+FELqVNrdVspxBclXyji85wEFHH30vo9N6HTKg1XpZahOKL1dyV
         Tar27HlDdhC6C32uy5Gjj9mw2EwMV20t5+xDQu/Okjst+85uyKZV0jI5Lqi6vjBuvG
         Z/jNghpWswgUrgmYA3raIspBBitHiOzTTrO8b3x4YmHjGfDfzbE3W1SaXgDyD/ij9V
         nszkQvCHCGhTQ==
From:   SeongJae Park <sj@kernel.org>
To:     Gautam <gautammenghani201@gmail.com>
Cc:     sj@kernel.org, shuah@kernel.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftests/damon: add support for checking secureboot status
Date:   Fri, 24 Jun 2022 20:29:21 +0000
Message-Id: <20220624202921.80867-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220624195239.7293-1-gautammenghani201@gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Gautam,


On Sat, 25 Jun 2022 01:22:39 +0530 Gautam <gautammenghani201@gmail.com> wrote:

> The kernel is in lockdown mode when secureboot is enabled and hence
> debugfs cannot be used. But the error printed after running tests does
> not indicate this currently:
> 
> >TAP version 13
> >1..6
> ># selftests: damon: debugfs_attrs.sh
> ># cat: /sys/kernel/debug/damon/monitor_on: Operation not permitted
> ># _debugfs_common.sh: line 48: [: =: unary operator expected
> ># cat: /sys/kernel/debug/damon/attrs: Operation not permitted
> ># _debugfs_common.sh: line 11: /sys/kernel/debug/damon/attrs: Operation 
> > not permitted
> ># writing 1 2 3 4 5 to /sys/kernel/debug/damon/attrs doesn't return 0
> ># expected because: valid input
> ># _debugfs_common.sh: line 16: /sys/kernel/debug/damon/attrs: Operation 
> > not permitted
> >not ok 1 selftests: damon: debugfs_attrs.sh # exit=1
> 
> 
> After adding the check for secureboot, the output is as follows:
> 
> >TAP version 13
> >1..6
> ># selftests: damon: debugfs_attrs.sh
> ># debugfs cannot work with secureboot enabled
> >not ok 1 selftests: damon: debugfs_attrs.sh # exit=1
> 
> 
> Signed-off-by: Gautam <gautammenghani201@gmail.com>
> ---
>  tools/testing/selftests/damon/_chk_dependency.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>  mode change 100644 => 100755 tools/testing/selftests/damon/_chk_dependency.sh
> 
> diff --git a/tools/testing/selftests/damon/_chk_dependency.sh b/tools/testing/selftests/damon/_chk_dependency.sh
> old mode 100644
> new mode 100755
> index 0189db81550b..6e45c1fe230e
> --- a/tools/testing/selftests/damon/_chk_dependency.sh
> +++ b/tools/testing/selftests/damon/_chk_dependency.sh
> @@ -26,3 +26,13 @@ do
>  		exit 1
>  	fi
>  done
> +
> +secureboot_error="Operation not permitted"
> +for f in attrs target_ids monitor_on
> +do
> +	status=$( cat "$DBGFS/$f" 2>&1 )
> +	if [ "${status#*$secureboot_error}" != "$status" ]; then
> +		echo "debugfs cannot work with secureboot enabled"

I think the check makes sense, but I think there could be more reasons for the
read error other than secure boot.  How about making the error mesage more
clear for the error case and our guess?  E.g., "permission for reading
$DBGFS/$f denied; maybe secureboot enabled?"

> +		exit 1

This is not a test failure but we are just skipping the test as running the
test here makes no sense.  Hence I think '$ksft_skip' could be a better return
code.


Thanks,
SJ

> +	fi
> +done
> -- 
> 2.36.1
