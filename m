Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E51E71463B
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 May 2023 10:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjE2IVz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 May 2023 04:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjE2IVy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 May 2023 04:21:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB9EA7;
        Mon, 29 May 2023 01:21:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C3866151B;
        Mon, 29 May 2023 08:21:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B15FC433D2;
        Mon, 29 May 2023 08:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685348512;
        bh=hlRfSmclHorz/xxdGaOQVbJyEMbb50M9sLXS/0qDFBc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F7aNNZ3mc+PZkqJA45ygSx+UJ6f/HCGNpzvlBHq9jxyRQqJRaZneWktBBFpKcbnDU
         f4QKeXE4h/uITvXCEvSO10zjJ0Rc3DXxFblByeaPru1F3LSss44C/00fPnTWmCbm0O
         h3il6LEKKXdQCfR8z+uRnfXKUYLDDtlDocAPWPr02GTbRks85+I66+/B29xgaAsqWb
         zKywh495Z4voqVZe6OVzcrmrJTa7E7rwSt7YI21qbiGuEg2RD/pyCn68UfMRhEuXRU
         YDCWxCUHQbIj3PxtycbFU8ylUXwC3CKsENdrqU1yVetzfy0bJiRu++oCACuhIkBa4Y
         UZ2RZhQSNwIiA==
Date:   Mon, 29 May 2023 17:21:49 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     sunliming <sunliming@kylinos.cn>
Cc:     rostedt@goodmis.org, beaub@linux.microsoft.com,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] tracing/user_events: Handle matching arguments that is
 null from dyn_events
Message-Id: <20230529172149.fec12da876356c1a679d8bcb@kernel.org>
In-Reply-To: <20230529065110.303440-1-sunliming@kylinos.cn>
References: <20230529065110.303440-1-sunliming@kylinos.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 29 May 2023 14:51:10 +0800
sunliming <sunliming@kylinos.cn> wrote:

> When A registering user event from dyn_events has no argments, it will pass the
> matching check, regardless of whether there is a user event with the same name
> and arguments. Add the matching check when the arguments of registering user
> event is null.

OK, since the user_events doesn't support multi-definitions on the same name
event, this should be checked.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> 
> Signed-off-by: sunliming <sunliming@kylinos.cn>
> ---
>  kernel/trace/trace_events_user.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index e90161294698..0d91dac206ff 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -1712,6 +1712,8 @@ static bool user_event_match(const char *system, const char *event,
>  
>  	if (match && argc > 0)
>  		match = user_fields_match(user, argc, argv);
> +	else if (match && argc == 0)
> +		match = list_empty(&user->fields);
>  
>  	return match;
>  }
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
