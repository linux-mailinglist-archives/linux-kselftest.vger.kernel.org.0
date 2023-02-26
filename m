Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBDF6A2E55
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Feb 2023 06:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjBZFae (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 26 Feb 2023 00:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBZFad (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 26 Feb 2023 00:30:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC57AC153;
        Sat, 25 Feb 2023 21:30:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FAC0B80B07;
        Sun, 26 Feb 2023 05:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C69BC433D2;
        Sun, 26 Feb 2023 05:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1677389428;
        bh=kMiKvSkb038+QPnW4dyUZBgrNR77GVNbTMcPAKsJoCg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1lnF48nQ6RD68VEkAU0hQS/bb9PdL3A/+q24DiuPpT5y2PxV4ToPq/XDxBSQEEeyY
         +fGmk27+DmjuJWBVpya2b0hUgtTxLe9HdWlRtfR4E4RiOWVt2Vo+3RVo+Uv8VoGoQX
         2KGlsG3KcM5JG+MD78OXwrhPt5ilcs1yZOyXzoO4=
Date:   Sat, 25 Feb 2023 21:30:27 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, hannes@cmpxchg.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v3 3/3] selftests/mm: add new selftests for KSM
Message-Id: <20230225213027.69c27e7790898c32e66312ea@linux-foundation.org>
In-Reply-To: <20230224044000.3084046-4-shr@devkernel.io>
References: <20230224044000.3084046-1-shr@devkernel.io>
        <20230224044000.3084046-4-shr@devkernel.io>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 23 Feb 2023 20:40:00 -0800 Stefan Roesch <shr@devkernel.io> wrote:

> This adds three new tests to the selftests for KSM. These tests use the
> new prctl API's to enable and disable KSM.
> 
> ...
>
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index d90cdc06aa59..507cb22bdebd 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -29,7 +29,8 @@ MACHINE ?= $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/' -e 's/ppc64.*/p
>  # LDLIBS.
>  MAKEFLAGS += --no-builtin-rules
>  
> -CFLAGS = -Wall -I $(top_srcdir) -I $(top_srcdir)/usr/include $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
> +CFLAGS = -Wall -I $(top_srcdir)/tools/include/uapi
> +CFLAGS += -I $(top_srcdir) -I $(top_srcdir)/usr/include $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
>  LDLIBS = -lrt -lpthread
>  TEST_GEN_FILES = cow
>  TEST_GEN_FILES += compaction_test

This change runs afoul of the recently merged 8eb3751c73bec
("selftests: vm: Fix incorrect kernel headers search path").

I did this:

--- a/tools/testing/selftests/mm/Makefile~selftests-mm-add-new-selftests-for-ksm
+++ b/tools/testing/selftests/mm/Makefile
@@ -29,7 +29,7 @@ MACHINE ?= $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/' -e 's/ppc64.*/p
 # LDLIBS.
 MAKEFLAGS += --no-builtin-rules
 
-CFLAGS = -Wall -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
+CFLAGS = -Wall -I $(top_srcdir) -I $(top_srcdir)/tools/include/uapi $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
 LDLIBS = -lrt -lpthread
 TEST_GEN_FILES = cow
 TEST_GEN_FILES += compaction_test
_

But I expect it's a bit wrong.  Please check?
