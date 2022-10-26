Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC31860E5B7
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Oct 2022 18:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbiJZQs2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Oct 2022 12:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbiJZQs2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Oct 2022 12:48:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EB9CA8A0;
        Wed, 26 Oct 2022 09:48:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9F3161FB7;
        Wed, 26 Oct 2022 16:48:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B7AC433D6;
        Wed, 26 Oct 2022 16:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666802906;
        bh=EZcwUTBtTAhU+xuOY4mD+QmNoKlLy5BdxEljkR5QW/Q=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=YJLZdo1r01gsqdJu4vSYCpfa5TydcMhc5Iq8CaFSH4q0l1XD6LsDBLDa6i0jl9ZeF
         90Oj0dj0ZojC1ZOsVe4jPcs3hsdxtEVqVYKrS8xRm0USGrm6OHFO5hO0xhhWunFEk3
         I8ddQ0Z0qYBqtGape/4qi9dGxHd7NFem598V/dkkHuUrq/d0Z3raDkZRyRlPnYrfSa
         jFH4h1Btfa1Gw8OqPwST/nhmYBlo/lK6e6+0yvGToQliscMr/7NPmhk+Ew8kgWbRiw
         s+JW/FdoNQzqyvzx7lV66XhPwMWUkxjJsIylU7ymjfrVDEOel3eexc0xRVLVTHHav0
         YpTCy0UJS/vEg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E14D75C05F8; Wed, 26 Oct 2022 09:48:25 -0700 (PDT)
Date:   Wed, 26 Oct 2022 09:48:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: always rebuild the sysroot when
 running a test
Message-ID: <20221026164825.GN5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221026054508.19634-1-w@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026054508.19634-1-w@1wt.eu>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 26, 2022 at 07:45:08AM +0200, Willy Tarreau wrote:
> Paul and myself got trapped a few times by not seeing the effects of
> applying a patch to the nolibc source code until a "make clean" was
> issued in the nolibc directory. It's particularly annoying when trying
> to confirm that a proposed patch really solves a problem (or that
> reverting it reintroduces the problem).
> 
> The reason for the sysroot not being rebuilt was that it can be quite
> slow. But in fact it's only slow after a "make clean" issued at the
> kernel's topdir, because it's the main "make headers" that can take a
> tens of seconds; as long as "usr/include" still contains headers, the
> "headers_install" phase is only a quick "rsync", and rebuilding the
> whole nolibc sysroot takes a bit less than one second, which is perfectly
> acceptable for a test, even more once the time lost caused by misleading
> results if factored in.
> 
> This patch marks the sysroot target as phony and starts by clearing
> the previous sysroot for the current architecture before reinstalling
> it. Thanks to this, applying a patch to nolibc makes the effect
> immediately visible to "make nolibc-test":
> 
>   $ time make -j -C tools/testing/selftests/nolibc nolibc-test
>   make: Entering directory '/k/tools/testing/selftests/nolibc'
>     MKDIR   sysroot/x86/include
>   make[1]: Entering directory '/k/tools/include/nolibc'
>   make[2]: Entering directory '/k'
>   make[2]: Leaving directory '/k'
>   make[2]: Entering directory '/k'
>     INSTALL /k/tools/testing/selftests/nolibc/sysroot/sysroot/include
>   make[2]: Leaving directory '/k'
>   make[1]: Leaving directory '/k/tools/include/nolibc'
>     CC      nolibc-test
>   make: Leaving directory '/k/tools/testing/selftests/nolibc'
> 
>   real    0m0.869s
>   user    0m0.716s
>   sys     0m0.149s
> 
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Link: https://lore.kernel.org/all/20221021155645.GK5600@paulmck-ThinkPad-P17-Gen-1/
> Signed-off-by: Willy Tarreau <w@1wt.eu>

Works like a champ with reverting and unreverting c9388e0c1c6c
("tools/nolibc/string: Fix memcmp() implementation"), thank you!!!

I have queued this.  I expect to push this into the next merge window,
thus avoiding the need to document the need for "make clean" in my
pull request.  ;-)

							Thanx, Paul

> ---
>  tools/testing/selftests/nolibc/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> index 69ea659caca9..22f1e1d73fa8 100644
> --- a/tools/testing/selftests/nolibc/Makefile
> +++ b/tools/testing/selftests/nolibc/Makefile
> @@ -95,6 +95,7 @@ all: run
>  sysroot: sysroot/$(ARCH)/include
>  
>  sysroot/$(ARCH)/include:
> +	$(Q)rm -rf sysroot/$(ARCH) sysroot/sysroot
>  	$(QUIET_MKDIR)mkdir -p sysroot
>  	$(Q)$(MAKE) -C ../../../include/nolibc ARCH=$(ARCH) OUTPUT=$(CURDIR)/sysroot/ headers_standalone
>  	$(Q)mv sysroot/sysroot sysroot/$(ARCH)
> @@ -133,3 +134,5 @@ clean:
>  	$(Q)rm -rf initramfs
>  	$(call QUIET_CLEAN, run.out)
>  	$(Q)rm -rf run.out
> +
> +.PHONY: sysroot/$(ARCH)/include
> -- 
> 2.35.3
> 
