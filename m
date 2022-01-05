Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E681485CAE
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jan 2022 00:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245585AbiAEX4R (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jan 2022 18:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245538AbiAEX4O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jan 2022 18:56:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD1FC061201;
        Wed,  5 Jan 2022 15:56:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77CD6B81CFF;
        Wed,  5 Jan 2022 23:56:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5D5C36AFA;
        Wed,  5 Jan 2022 23:56:10 +0000 (UTC)
Date:   Wed, 5 Jan 2022 18:56:09 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] selftests/ftrace: func_event_triggers: fix typo in user
 message
Message-ID: <20220105185609.4ca10a41@gandalf.local.home>
In-Reply-To: <20211226023204.18315-1-rdunlap@infradead.org>
References: <20211226023204.18315-1-rdunlap@infradead.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, 25 Dec 2021 18:32:04 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> Correct typo of "it's" to "it".
> 

Shuah, want to take this?

-- Steve

> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/ftrace/test.d/ftrace/func_event_triggers.tc |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20211224.orig/tools/testing/selftests/ftrace/test.d/ftrace/func_event_triggers.tc
> +++ linux-next-20211224/tools/testing/selftests/ftrace/test.d/ftrace/func_event_triggers.tc
> @@ -85,7 +85,7 @@ run_enable_disable() {
>  	echo $check_disable > $EVENT_ENABLE
>      done
>      sleep $SLEEP_TIME
> -    echo " make sure it's still works"
> +    echo " make sure it still works"
>      test_event_enabled $check_enable_star
>  
>      reset_ftrace_filter

