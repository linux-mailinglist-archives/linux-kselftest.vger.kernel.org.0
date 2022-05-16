Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B25E528FDC
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 May 2022 22:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiEPUIK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 May 2022 16:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348166AbiEPT62 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 May 2022 15:58:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FCB49264;
        Mon, 16 May 2022 12:50:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84DA2B81616;
        Mon, 16 May 2022 19:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935D8C385AA;
        Mon, 16 May 2022 19:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652730612;
        bh=c9r69ta/pgxS3FOpdoClSBJRVIanwTUSIou4mXA0xUE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WgaBWsOAOi6+eSvu+qcU0oRd7ohRjg2NXoreiK/6vli6xzxmefDn1Rl/E2OqUAuX5
         qOwQozDSYm/Jj7EmXsZNnxk8gQLzxpAt5XVjOf4cYEbfWoPxS1PGx5O6L3SLqoRh0q
         SgAjbp2rAemKlBR3RLVhWv8nUMMZbVpSw5Pg7uD4=
Date:   Mon, 16 May 2022 12:50:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     mhocko@suse.com, rientjes@google.com, willy@infradead.org,
        hannes@cmpxchg.org, guro@fb.com, minchan@kernel.org,
        kirill@shutemov.name, aarcange@redhat.com, brauner@kernel.org,
        hch@infradead.org, oleg@redhat.com, david@redhat.com,
        jannh@google.com, shakeelb@google.com, peterx@redhat.com,
        jhubbard@nvidia.com, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 1/1] selftests: vm: add process_mrelease tests
Message-Id: <20220516125010.53ab9a27733f361e5965ed7f@linux-foundation.org>
In-Reply-To: <20220516075538.1276644-1-surenb@google.com>
References: <20220516075538.1276644-1-surenb@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 16 May 2022 00:55:38 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> Introduce process_mrelease syscall sanity tests which include tests
> which expect to fail:
> - process_mrelease with invalid pidfd and flags inputs
> - process_mrelease on a live process with no pending signals
> and valid process_mrelease usage which is expected to succeed.
> Because process_mrelease has to be used against a process with a pending
> SIGKILL, it's possible that the process exits before process_mrelease
> gets called. In such cases we retry the test with a victim that allocates
> twice more memory up to 1GB. This would require the victim process to
> spend more time during exit and process_mrelease has a better chance of
> catching the process before it exits and succeeding.
> 
> On success the test reports the amount of memory the child had to
> allocate for reaping to succeed. Sample output:
>     Success reaping a child with 1MB of memory allocations
> 
> On failure the test reports the failure. Sample outputs:
>     All process_mrelease attempts failed!
>     process_mrelease: Invalid argument
> 
> ...
>
> --- a/tools/testing/selftests/vm/run_vmtests.sh
> +++ b/tools/testing/selftests/vm/run_vmtests.sh
> @@ -287,6 +287,22 @@ else
>  	echo "[PASS]"
>  fi
>  
> +echo "---------------------"
> +echo "running mrelease_test"
> +echo "---------------------"
> +./mrelease_test
> +ret_val=$?
> +
> +if [ $ret_val -eq 0 ]; then
> +	echo "[PASS]"
> +elif [ $ret_val -eq $ksft_skip ]; then
> +	 echo "[SKIP]"
> +	 exitcode=$ksft_skip
> +else
> +	echo "[FAIL]"
> +	exitcode=1
> +fi
> +
>  echo "-------------------"
>  echo "running mremap_test"
>  echo "-------------------"

Can you please redo this against
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm branch mm-stable
or mm-unstable.  Or against linux-next?

This script now has a helper function run_test which I think can be
used here.
