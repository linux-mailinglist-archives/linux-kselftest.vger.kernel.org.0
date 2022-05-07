Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5178051EA58
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 May 2022 23:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237288AbiEGVaX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 May 2022 17:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235745AbiEGVaU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 May 2022 17:30:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB9BBC32;
        Sat,  7 May 2022 14:26:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7273E60F1D;
        Sat,  7 May 2022 21:26:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8936FC385A6;
        Sat,  7 May 2022 21:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651958791;
        bh=TpnUc2DE5KFYkQnmUd4Sv+a4aCiTuBPeApHJNytttBc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pjNdf+wv67dGI3O/VbxZIjKLTI4TigjrucaDTW42JMGnwVsHYqDS8DWIqz2NfVoro
         WHoPr6hO0dYaQ1qFYxgMcWuCydf7PV5uLp3JKveImP52BsWIAMb5rZtzFotNj0Mt9I
         gJ1WKCPuoNGe/7DZs+5m8H8FGmaQB4n98c3jdvRo=
Date:   Sat, 7 May 2022 14:26:30 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joel Savitz <jsavitz@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: Re: [PATCH] selftests: clarify common error when running gup_test
Message-Id: <20220507142630.56f7ee13658d6fd78cc2d88f@linux-foundation.org>
In-Reply-To: <20220502224942.995427-1-jsavitz@redhat.com>
References: <20220502224942.995427-1-jsavitz@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon,  2 May 2022 18:49:42 -0400 Joel Savitz <jsavitz@redhat.com> wrote:

> 
> The gup_test binary will fail showing only the output of perror("open") in
> the case that /sys/kernel/debug/gup_test is not found. This will almost
> always be due to CONFIG_GUP_TEST not being set, which enables
> compilation of a kernel that provides this file.
> 
> Add a short error message to clarify this failure and point the user to
> the solution.
> 
> --- a/tools/testing/selftests/vm/gup_test.c
> +++ b/tools/testing/selftests/vm/gup_test.c
> @@ -18,6 +18,8 @@
>  #define FOLL_WRITE	0x01	/* check pte is writable */
>  #define FOLL_TOUCH	0x02	/* mark page accessed */
>  
> +#define GUP_TEST_FILE "/sys/kernel/debug/gup_test"
> +
>  static unsigned long cmd = GUP_FAST_BENCHMARK;
>  static int gup_fd, repeats = 1;
>  static unsigned long size = 128 * MB;
> @@ -204,9 +206,11 @@ int main(int argc, char **argv)
>  	if (write)
>  		gup.gup_flags |= FOLL_WRITE;
>  
> -	gup_fd = open("/sys/kernel/debug/gup_test", O_RDWR);
> +	gup_fd = open(GUP_TEST_FILE, O_RDWR);
>  	if (gup_fd == -1) {
>  		perror("open");
> +		fprintf(stderr, "Unable to open %s: check that CONFIG_GUP_TEST=y\n",
> +				GUP_TEST_FILE);
>  		exit(1);
>  	}
>  

Sidhartha did a similar thing:
https://lkml.kernel.org/r/20220405214809.3351223-1-sidhartha.kumar@oracle.com

(Which is now in mm-stable at
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm)

Although in retroreview, it should have printed that to stderr rather
than to stdout.

