Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE54478DAB4
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Aug 2023 20:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbjH3Sg4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Aug 2023 14:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242561AbjH3JB7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Aug 2023 05:01:59 -0400
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF012CCB
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Aug 2023 02:01:53 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RbJFW2w2VzMqSYV;
        Wed, 30 Aug 2023 09:01:51 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4RbJFV6lhYzMpp9y;
        Wed, 30 Aug 2023 11:01:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1693386111;
        bh=GPuobfew1UhhdtqGSwSghFtfdXBk0VcPKhAtepB/RTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o1bRc4GkTkSUL/c1YwpOHDzHtq0/J3LM4hmcOG9H7JEuR37BFeK1khzjwlKpgoC+x
         2kh+DS9foGoCP7Lef8MAhV3iBtVjRws/N/bNsBxTxNgs9aYBPqZDxxCP5RjPzT/RSg
         x8KcJ3O6FnvaS+tGwebfCE0jMZuIN8GPsy/cU3Tg=
Date:   Wed, 30 Aug 2023 11:01:47 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>
Cc:     shuah@kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/landlock: Fix a resource leak
Message-ID: <20230830.Ahqu4iepha4I@digikod.net>
References: <20230830060858.2841-1-dingxiang@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830060858.2841-1-dingxiang@cmss.chinamobile.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

Thanks for this fix. A few suggestions:

On Wed, Aug 30, 2023 at 02:08:58PM +0800, Ding Xiang wrote:
> The opened file should be closed before return,
> otherwise resource leak will occur
> 
> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
> ---
>  tools/testing/selftests/landlock/fs_test.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 83d565569512..687a66ea9799 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -124,13 +124,17 @@ static bool supports_filesystem(const char *const filesystem)
>  		return true;
>  
>  	/* filesystem can be null for bind mounts. */
> -	if (!filesystem)
> +	if (!filesystem) {
> +		fclose(inf);
>  		return true;

Can you please change these two lines (and the next hunk) with a
`goto out` (and then don't add the if braces), initialize res to true
when it is declared, and add the `out` label below?

> +	}
>  
>  	len = snprintf(str, sizeof(str), "nodev\t%s\n", filesystem);
> -	if (len >= sizeof(str))
> +	if (len >= sizeof(str)) {
> +		fclose(inf);
>  		/* Ignores too-long filesystem names. */
>  		return true;
> +	}
>  
>  	res = fgrep(inf, str);

out:
>  	fclose(inf);
> -- 
> 2.38.1
> 
> 
> 
