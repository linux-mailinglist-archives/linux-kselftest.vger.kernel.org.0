Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AD952CED5
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 May 2022 11:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbiESJAm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 May 2022 05:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbiESJAm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 May 2022 05:00:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F15A5022;
        Thu, 19 May 2022 02:00:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2A93617C7;
        Thu, 19 May 2022 09:00:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835FCC385AA;
        Thu, 19 May 2022 09:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652950840;
        bh=dF0FH60gJWkqlbjGCCXS67g6UQvlG7opUBzrK6LwxmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZFmw0KIAaHHW7y+NPVu8+lfaadngQyO8TShE1cUfLmct+dUcAVYWBXpvyGIks4Z/F
         Umx5mDrQ8z6pdpxCdvS+yMjWq5xSfhcHEKk6FBsXNh5Sk9H0DtWjzR5cyftlDr5jvs
         UL4uUlVHJm/V7Oa8K3qLTWApAQ1mw34IG/T8V1eH369NzoxbJPhdELVrTTlJ/9tSEh
         R/2Jr6HhZ1ss0mWcsBl8m2TA9EaMP1R/8u9G+nWP22GxGTJI8v0fo4fz6e06M142Xa
         lTL2pt9Q2zPWvNveSoknOasWl/NsNGcJg4s8ExmHGML20mbL1Lps6RpXtaRTDPchw3
         b9iqhvfElEWJQ==
Date:   Thu, 19 May 2022 11:00:32 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, rientjes@google.com,
        willy@infradead.org, hannes@cmpxchg.org, guro@fb.com,
        minchan@kernel.org, kirill@shutemov.name, aarcange@redhat.com,
        hch@infradead.org, oleg@redhat.com, david@redhat.com,
        jannh@google.com, shakeelb@google.com, peterx@redhat.com,
        jhubbard@nvidia.com, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 1/1] selftests: vm: add process_mrelease tests
Message-ID: <20220519090032.4wyjggifnfisgjbr@wittgenstein>
References: <20220518204316.13131-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220518204316.13131-1-surenb@google.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 18, 2022 at 01:43:16PM -0700, Suren Baghdasaryan wrote:
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
> 
> $ mrelease_test
> Success reaping a child with 1MB of memory allocations
> 
> On failure the test reports the failure. Sample outputs:
> 
> $ mrelease_test
> All process_mrelease attempts failed!
> 
> $ mrelease_test
> process_mrelease: Invalid argument
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---

Thanks your adding selftests, Suren!
Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>
