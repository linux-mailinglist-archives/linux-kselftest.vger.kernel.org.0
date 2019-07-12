Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7746741F
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2019 19:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfGLRZV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Jul 2019 13:25:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52832 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbfGLRZV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Jul 2019 13:25:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 87BD530821B2;
        Fri, 12 Jul 2019 17:25:21 +0000 (UTC)
Received: from redhat.com (ovpn-122-246.rdu2.redhat.com [10.10.122.246])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1646A60BFB;
        Fri, 12 Jul 2019 17:25:21 +0000 (UTC)
Date:   Fri, 12 Jul 2019 13:25:17 -0400
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     shuah@kernel.org
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH] selftests/livepatch: only consider supported arches
Message-ID: <20190712172517.GA15872@redhat.com>
References: <20190712171402.15930-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712171402.15930-1-joe.lawrence@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 12 Jul 2019 17:25:21 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 12, 2019 at 01:14:02PM -0400, Joe Lawrence wrote:
> Only run the livepatching self-tests on x86_64 and ppc64le arches.
> 
> Reported-by: Jiri Benc <jbenc@redhat.com>
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> ---
>  tools/testing/selftests/livepatch/Makefile | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/tools/testing/selftests/livepatch/Makefile b/tools/testing/selftests/livepatch/Makefile
> index fd405402c3ff..9842fb473d42 100644
> --- a/tools/testing/selftests/livepatch/Makefile
> +++ b/tools/testing/selftests/livepatch/Makefile
> @@ -1,5 +1,16 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> +ARCH ?= $(shell uname -m 2>/dev/null || echo not)
> +
> +ifeq ($(ARCH),x86_64)
> +livepatch_supported := 1
> +endif
> +ifeq ($(ARCH),ppc64le)
> +livepatch_supported := 1
> +endif
> +
> +ifdef livepatch_supported
> +
>  TEST_PROGS_EXTENDED := functions.sh
>  TEST_PROGS := \
>  	test-livepatch.sh \
> @@ -7,3 +18,5 @@ TEST_PROGS := \
>  	test-shadow-vars.sh
>  
>  include ../lib.mk
> +
> +endif
> -- 
> 2.21.0
> 

Hi Shuah,

This was change was a quick and dirty fix to avoid inadvertent errors
reported by run_kselftest.sh on arches unsupported by livepatch.

Ideally we would check CONFIG_TEST_LIVEPATCH instead of the arches
directly:  This would allow distros to "turn off" this particular set of
selftests through the kernel configuration.  Also, setting 
CONFIG_TEST_LIVEPATCH=m determines whether supporting livepatch
self-test modules (in lib/livepatch) will be built.  Without it, these
self-test scripts are useless.

However, I didn't see that $(CONFIG_TEST_LIVEPATCH) was set when
invoking tools/testing/selftests/livepatch/Makefile.  I don't know how
tools/testing/selftests/vDSO/Makefile is using $(CONFIG_X86_32) but
perhaps that isn't working either.

Any suggestions?  Should we modify the test scripts themselves to deal
with a !CONFIG_TEST_LIVEPATCH environment?

Thanks,

-- Joe
