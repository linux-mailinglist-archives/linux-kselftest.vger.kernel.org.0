Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF2A61D8EA
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Nov 2022 09:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiKEIwt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Nov 2022 04:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKEIws (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Nov 2022 04:52:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C63322528;
        Sat,  5 Nov 2022 01:52:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48428B81647;
        Sat,  5 Nov 2022 08:52:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714F0C433D6;
        Sat,  5 Nov 2022 08:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667638364;
        bh=ifUEBOIjQaHmKSCsfN+pCNH9FtC0PXujxXMPd3U2Z5s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZFK7Q0k5/PyWzAUtzXCwB/8pi6eFMlDppfJllc6PQHVruX4YQdFl8n3jRHPrF7Gih
         kOOMBl4WAyYako3HFAi9INuNy3ksMWbiSSw64aGskPAOyuwwt6jL/x7/G3SF6t3MRz
         nnMrgUEUUJUQZIbadctLQLLTGoA4HxxqYV33q99aUbb3O8opxaq/2r49PTm6olBjtS
         hKffbZA+xH4Tr0CyLTjLsq1XGupOKGaY3i+5PQ6RBDH+cpK9+n+OqaOaw4KXfNc2fS
         v1vur1WotNh2Bu879jcvKiqjje+MI57mT7F8za11dBx8mAplqbD72qnj47x7mtBv1p
         fpIz9RZcYWlwQ==
Date:   Sat, 5 Nov 2022 17:52:41 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Yipeng Zou <zouyipeng@huawei.com>
Cc:     <rostedt@goodmis.org>, <shuah@kernel.org>, <rdunlap@infradead.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/ftrace: event_triggers: wait longer for
 test_event_enable
Message-Id: <20221105175241.858bbd5b5337fc2b8a075ee9@kernel.org>
In-Reply-To: <20221104020931.231090-1-zouyipeng@huawei.com>
References: <20221104020931.231090-1-zouyipeng@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Yipeng,

On Fri, 4 Nov 2022 10:09:31 +0800
Yipeng Zou <zouyipeng@huawei.com> wrote:

> In some platform, the schedule event may came slowly, delay 100ms can't
> cover it.
> 
> I was notice that on my board which running in low cpu_freq,and this
> selftests allways gose fail.

This looks good to me, since this can just extend the waiting time to 1 sec.
(and most of the platforms have no effect)

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> 
> So maybe we can check more times here to wait longer.
> 
> Fixes: 43bb45da82f9 ("selftests: ftrace: Add a selftest to test event enable/disable func trigger")
> Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
> ---
>  .../ftrace/test.d/ftrace/func_event_triggers.tc   | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_event_triggers.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_event_triggers.tc
> index 8d26d5505808..3eea2abf68f9 100644
> --- a/tools/testing/selftests/ftrace/test.d/ftrace/func_event_triggers.tc
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_event_triggers.tc
> @@ -38,11 +38,18 @@ cnt_trace() {
>  
>  test_event_enabled() {
>      val=$1
> +    check_times=10		# wait for 10 * SLEEP_TIME at most
>  
> -    e=`cat $EVENT_ENABLE`
> -    if [ "$e" != $val ]; then
> -	fail "Expected $val but found $e"
> -    fi
> +    while [ $check_times -ne 0 ]; do
> +	e=`cat $EVENT_ENABLE`
> +	if [ "$e" == $val ]; then
> +	    return 0
> +	fi
> +	sleep $SLEEP_TIME
> +	check_times=$((check_times - 1))
> +    done
> +
> +    fail "Expected $val but found $e"
>  }
>  
>  run_enable_disable() {
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
