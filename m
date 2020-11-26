Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5812C51B7
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Nov 2020 11:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387517AbgKZKAV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Nov 2020 05:00:21 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39313 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387445AbgKZKAV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Nov 2020 05:00:21 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kiE4V-0000Yn-Ar; Thu, 26 Nov 2020 10:00:15 +0000
Date:   Thu, 26 Nov 2020 11:00:12 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Xingxing Su <suxingxing@loongson.cn>
Cc:     Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/clone3: Add gun99 to compile in Makefile.
Message-ID: <20201126100012.hy6fhores67tnekv@wittgenstein>
References: <1606374734-12639-1-git-send-email-suxingxing@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1606374734-12639-1-git-send-email-suxingxing@loongson.cn>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 26, 2020 at 03:12:14PM +0800, Xingxing Su wrote:
> CFLAGS add -std=gnu99.
> 
> Fllowing build error:
> 
> test_core.c: In function ‘test_cgcore_destroy’:
> test_core.c:87:2: error: ‘for’ loop initial declarations are only
> allowed in C99 mode
>   for (int i = 0; i < 10; i++) {
>   ^
> test_core.c:87:2: note: use option -std=c99 or -std=gnu99 to compile
> your code
> 
> Signed-off-by: Xingxing Su <suxingxing@loongson.cn>
> ---

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Seems alright to me and apparently some selftests already set. Though
another option would be to just move the declaration. But I don't think
it matters that much here.

I'd change the commit message slightly though:

[PATCH] selftests/clone3: Fix build error

When compiling the selftests with the -std=gnu99 option the build can
fail with

  Fllowing build error:
  
  test_core.c: In function ‘test_cgcore_destroy’:
  test_core.c:87:2: error: ‘for’ loop initial declarations are only
  allowed in C99 mode
    for (int i = 0; i < 10; i++) {
    ^
  test_core.c:87:2: note: use option -std=c99 or -std=gnu99 to compile

Add -std=gnu99 to the clone3 selftest Makefile to fix this.


>  tools/testing/selftests/clone3/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/clone3/Makefile b/tools/testing/selftests/clone3/Makefile
> index ef7564c..88354a8 100644
> --- a/tools/testing/selftests/clone3/Makefile
> +++ b/tools/testing/selftests/clone3/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -CFLAGS += -g -I../../../../usr/include/
> +CFLAGS += -g -std=gnu99 -I../../../../usr/include/ 
>  LDLIBS += -lcap
>  
>  TEST_GEN_PROGS := clone3 clone3_clear_sighand clone3_set_tid \
> -- 
> 1.8.3.1
> 
