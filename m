Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5D46B0609
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 12:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjCHLfC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 06:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjCHLe6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 06:34:58 -0500
X-Greylist: delayed 2489 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Mar 2023 03:34:55 PST
Received: from sym2.noone.org (sym.noone.org [IPv6:2a01:4f8:120:4161::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBD2984CA;
        Wed,  8 Mar 2023 03:34:54 -0800 (PST)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4PWqwr1gvfzvjfm; Wed,  8 Mar 2023 12:34:52 +0100 (CET)
Date:   Wed, 8 Mar 2023 12:34:51 +0100
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Christian Brauner <brauner@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        linux-kselftest@vger.kernel.org, Andrey Vagin <avagin@openvz.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/clone3: test clone3 with CLONE_NEWTIME
Message-ID: <20230308113451.a23d7rxbrsuacd6t@distanz.ch>
References: <20230308105126.10107-1-tklauser@distanz.ch>
 <20230308105320.10685-1-tklauser@distanz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308105320.10685-1-tklauser@distanz.ch>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-03-08 at 11:53:20 +0100, Tobias Klauser <tklauser@distanz.ch> wrote:
> Verify that clone3 can be called successfully with CLONE_NEWTIME in
> flags.

Appologies, I somehow messed up the recepient list in this patch leading
to it not being sent to LKML. Please let me know in case you want me to
send it again.

> Cc: Andrey Vagin <avagin@openvz.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>  tools/testing/selftests/clone3/clone3.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
> index cd4582129c7d..4fce46afe6db 100644
> --- a/tools/testing/selftests/clone3/clone3.c
> +++ b/tools/testing/selftests/clone3/clone3.c
> @@ -195,5 +195,8 @@ int main(int argc, char *argv[])
>  	test_clone3(CLONE_NEWPID, getpagesize() + 8, -E2BIG,
>  			CLONE3_ARGS_NO_TEST);
>  
> +	/* Do a clone3() in a new time namespace */
> +	test_clone3(CLONE_NEWTIME, 0, 0, CLONE3_ARGS_NO_TEST);
> +
>  	return !ksft_get_fail_cnt() ? ksft_exit_pass() : ksft_exit_fail();
>  }
> -- 
> 2.39.1
> 
