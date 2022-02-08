Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A216E4AE04F
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 19:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384502AbiBHSFG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 13:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384451AbiBHSFF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 13:05:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58A6C061576;
        Tue,  8 Feb 2022 10:05:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8164761769;
        Tue,  8 Feb 2022 18:05:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92F3C004E1;
        Tue,  8 Feb 2022 18:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644343503;
        bh=x3ZJuDBTniUyDf3Xnvsfn74XEYbYNZ//7DynsFShFaQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TyvPKbJKH33KIeXflepn3AXItCnR743wcrZ3ppKSgbz+7JA41e40pOowWKFbyRxd2
         CQYpK8aHcVcBmHKdHPYOCZwWztqeMZp1PVl/jq+Ql2mwIrkKurq2sOq3zm/ulOPDk4
         1NrVdwu3pVGy/qH17MaQNjQL8xdnpaNmSjw80sXJRjbQIRSCUyLx7gyV1ZqGkxJ2KF
         /eOWTHnTvJGSwGoGHO4zb8QbdX0mcQVui6yvJS2tW5t1wKrO0rOBdI4Qnr6XYllAd7
         aGM4Mr0HwaDczU5/h7yOdUwUqD8BNB79yFRooUnWinLqL2hiJoTdBqNaY8npT4MRAB
         g+z277SmdDm2w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9F2D25C043B; Tue,  8 Feb 2022 10:05:03 -0800 (PST)
Date:   Tue, 8 Feb 2022 10:05:03 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Add missing - to `--do-allmodconfig` in usage
Message-ID: <20220208180503.GR4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220208105240.43600-1-pmenzel@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220208105240.43600-1-pmenzel@molgen.mpg.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Feb 08, 2022 at 11:52:40AM +0100, Paul Menzel wrote:
> The usage currently lists `--doallmodconfig`, resulting in:
> 
>     $ tools/testing/selftests/rcutorture/bin/torture.sh --doallmodconfig
>     Unknown argument --doallmodconfig
>     […]
> 
> Add the missing dash for `--do-allmodconfig`.
> 
> Fixes: a115a775a8d5 ("torture: Add "make allmodconfig" to torture.sh")
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>

Good eyes, thank you!

I will add your Reported-by and your Fixes line (with attribution) to
this commit in -rcu:

dbc3fa1ffb4b ("torture: Make torture.sh help message match reality")

							Thanx, Paul

> ---
>  tools/testing/selftests/rcutorture/bin/torture.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
> index eae88aacca2a..3adcc83dd55d 100755
> --- a/tools/testing/selftests/rcutorture/bin/torture.sh
> +++ b/tools/testing/selftests/rcutorture/bin/torture.sh
> @@ -72,7 +72,7 @@ usage () {
>  	echo "       --configs-locktorture \"config-file list w/ repeat factor (10*LOCK01)\""
>  	echo "       --configs-scftorture \"config-file list w/ repeat factor (2*CFLIST)\""
>  	echo "       --doall"
> -	echo "       --doallmodconfig / --do-no-allmodconfig"
> +	echo "       --do-allmodconfig / --do-no-allmodconfig"
>  	echo "       --do-clocksourcewd / --do-no-clocksourcewd"
>  	echo "       --do-kasan / --do-no-kasan"
>  	echo "       --do-kcsan / --do-no-kcsan"
> -- 
> 2.34.1
> 
