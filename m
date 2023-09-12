Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BE079D760
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 19:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjILRSL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Sep 2023 13:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbjILRSK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Sep 2023 13:18:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B7B10F6;
        Tue, 12 Sep 2023 10:18:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC702C433C7;
        Tue, 12 Sep 2023 17:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1694539084;
        bh=c2Ov69hO0AC4q1Ltdb0qHvD5gAxgfLF2qaudopzkkCk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kezSafD+vHrENLsiYBzEm37IOQg3Bw6BjYSSsBdcd588oUNoikJNXGPLkGNbD3JWB
         zIqxiSblsWziF/22AK6lLQFj/e0GOO1sZtNW0434skNnVWcKK9yPekM98UVsBbQg+d
         LPr0653efBwugzZ06KokYAw83E8DUPVypy9W+fXI=
Date:   Tue, 12 Sep 2023 10:18:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     dan.carpenter@linaro.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: cgroup: fix test_zswap error path and
 meaningless check
Message-Id: <20230912101802.25b280ac306694ff02001706@linux-foundation.org>
In-Reply-To: <20230912083800.57435-1-cerasuolodomenico@gmail.com>
References: <20230912083800.57435-1-cerasuolodomenico@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 12 Sep 2023 10:38:00 +0200 Domenico Cerasuolo <cerasuolodomenico@gmail.com> wrote:

> Replace destruction paths with simple returns before the test cgroup is
> created, there is nothing to free or destroy at that point.
> 
> Remove pointless check, stored_pages is a size_t and cannot be < 0.
> 
> ...
>
> @@ -208,8 +208,6 @@ static int test_no_kmem_bypass(const char *root)
>  		free(trigger_allocation);
>  		if (get_zswap_stored_pages(&stored_pages))
>  			break;
> -		if (stored_pages < 0)
> -			break;
>  		/* If memory was pushed to zswap, verify it belongs to memcg */
>  		if (stored_pages > stored_pages_threshold) {
>  			int zswapped = cg_read_key_long(test_group, "memory.stat", "zswapped ");

stored_pages will be set to -1 on error.  It would be better to cast
stored_pages to ssize_t in the check, rather than simply ignoring
errors?
