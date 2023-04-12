Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081FA6DF4A2
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 14:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjDLMEH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 08:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjDLMEH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 08:04:07 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62627EDB;
        Wed, 12 Apr 2023 05:03:34 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PxLv23jRZz4xFd;
        Wed, 12 Apr 2023 22:02:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1681300974;
        bh=F2asZabOHB6NFbG/61+yCHm7pNGbmMoPx7zSLypENV8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ZCoiEQfgaiE/bZtcYlseLoEYcgDNCwRRRkiGiDyYQZsS03TbfFMK2zAhdn0/Dkbp1
         Jlx5HIoOnLCoNpgz8bKYSvhF/J+Px5h1z9qgUFJcnon++nGadrZ9CkewLugX7MxClR
         0SW8FjfYbWjQOk5cV+L9Gn5l175bm6lSnrPsJKexIJM3mgtScgB7OEy2YFBmG5u5Hb
         5g4QfGb8c2mJikMUqLHYtgfX7FaJ2l2FDxxl89Eb1uFr/zPo9gYcZXwAd4aeEsoxvu
         qRgucGhd93n1LxX8TRpoL3tWEXkCmnNWdyXwVu3xcYoBT4LfgSE3GtyCHpvrbtohBe
         clSQmaVwolwWg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Deming Wang <wangdeming@inspur.com>, shuah@kernel.org
Cc:     npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Deming Wang <wangdeming@inspur.com>
Subject: Re: [PATCH] selftests/powerpc: Replace obsolete memalign() with
 posix_memalign()
In-Reply-To: <20230412111237.2007-1-wangdeming@inspur.com>
References: <20230412111237.2007-1-wangdeming@inspur.com>
Date:   Wed, 12 Apr 2023 22:02:50 +1000
Message-ID: <87o7nti9zp.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Deming Wang <wangdeming@inspur.com> writes:
> memalign() is obsolete according to its manpage.
>
> Replace memalign() with posix_memalign() and remove malloc.h include
> that was there for memalign().
>
> As a pointer is passed into posix_memalign(), initialize *s to NULL
> to silence a warning about the function's return value being used as
> uninitialized (which is not valid anyway because the error is properly
> checked before p is returned).

The patch doesn't do that. There is no p?

I think you've copied the change log for a whole bunch of commits but
not updated them to be accurate for each change?

cheers

> diff --git a/tools/testing/selftests/powerpc/stringloops/strlen.c b/tools/testing/selftests/powerpc/stringloops/strlen.c
> index 9055ebc484d0..f9c1f9cc2d32 100644
> --- a/tools/testing/selftests/powerpc/stringloops/strlen.c
> +++ b/tools/testing/selftests/powerpc/stringloops/strlen.c
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include <malloc.h>
>  #include <stdlib.h>
>  #include <string.h>
>  #include <time.h>
> @@ -51,10 +50,11 @@ static void bench_test(char *s)
>  static int testcase(void)
>  {
>  	char *s;
> +	int ret;
>  	unsigned long i;
>  
> -	s = memalign(128, SIZE);
> -	if (!s) {
> +	ret = posix_memalign((void **)&s, 128, SIZE);
> +	if (ret < 0) {
>  		perror("memalign");
>  		exit(1);
>  	}
> -- 
> 2.27.0
