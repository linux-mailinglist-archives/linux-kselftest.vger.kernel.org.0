Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A3170FF29
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 22:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236479AbjEXUXZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 16:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236520AbjEXUXY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 16:23:24 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEF110B;
        Wed, 24 May 2023 13:23:23 -0700 (PDT)
Date:   Wed, 24 May 2023 22:23:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1684959801; bh=KBR+D5DkiEabYDakDmSuQC67ISME1Q3hgqDEWVsqjMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A0YLG6pn5tmEp6NyVYaG5HAAlcAJ4N1aXkQRyvb6/j4CVevfkuOWmme/cGz97ViEB
         z5J56HrqK9kMm3mS7OKFM014cOWiVWQq2ZDgcyF8qy1qrg+uY/W1rjc/MiWNioAmEF
         MORGw0mDiOZlyHMpoTk5kgOMXGrWssNzXauX2XeM=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     w@1wt.eu, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Subject: Re: [PATCH 03/13] selftests/nolibc: print name instead of number for
 EOVERFLOW
Message-ID: <aece1813-e20a-4645-b86e-b1d9e2ae9934@t-8ch.de>
References: <cover.1684949267.git.falcon@tinylab.org>
 <e3c9bf5ccdae920f0609486256c52de8233aecb6.1684949267.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e3c9bf5ccdae920f0609486256c52de8233aecb6.1684949267.git.falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-05-25 01:46:54+0800, Zhangjin Wu wrote:
> EOVERFLOW will be used in the coming time64 syscalls support.
> 
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>

> ---
>  tools/testing/selftests/nolibc/nolibc-test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> index c570bb848c1a..227ef2a3ebba 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -106,6 +106,7 @@ const char *errorname(int err)
>  	CASE_ERR(EDOM);
>  	CASE_ERR(ERANGE);
>  	CASE_ERR(ENOSYS);
> +	CASE_ERR(EOVERFLOW);
>  	default:
>  		return itoa(err);
>  	}
> -- 
> 2.25.1
> 
