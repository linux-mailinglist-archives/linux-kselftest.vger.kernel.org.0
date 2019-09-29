Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB12C13BF
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Sep 2019 09:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfI2HMI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 29 Sep 2019 03:12:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48970 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbfI2HMI (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 29 Sep 2019 03:12:08 -0400
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 89768C047B68
        for <linux-kselftest@vger.kernel.org>; Sun, 29 Sep 2019 07:12:07 +0000 (UTC)
Received: by mail-pg1-f199.google.com with SMTP id d3so6585080pgv.9
        for <linux-kselftest@vger.kernel.org>; Sun, 29 Sep 2019 00:12:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P/07bfk0u9FOPSIi+/T+KZxeVmIxde3ui9tl/6EY7Uk=;
        b=OuAe6Tk8neze+1nBXWLT8sV15erH0r4C3ZPk68S/2Zm3o02DGNcciMMxIT+r/BOumx
         hkfv7MhQDAbC+FFmqmh8XbYZpx0/k6zay1MOvf0yK9y9fWjUx+Hw4C4iUBA9U8UQ4NUu
         /U2oUDomgBGcpTqLuw4fIVhKOtueRsT1p4q8NuxUS6f7Z2IZAOrnIbDgyjFq0ZLCC1Ni
         RXpGWHNBTdAIsr53Zd1UTEnF+3TsWRiPc/p+o1xZ5+JlU5yqf6b8fw8kq8EvRjG7NCfN
         rvQN+VPHWLQIw/G7ZwKVeRakDoACx2MdA9Cr7LvgABJbr3p090kM4wis794bYN67TaTk
         A/Hw==
X-Gm-Message-State: APjAAAVug5F/fQg5x+SpNxsOBWrWwxkqNmudGd3LAmDs79UV2/8fX0LI
        m1+Skp0QdJQz7l1XReioGPTyxyG7PLJ+QTq1OgTWwJIh7b5vraYisqtjJtB1t1yWZ9oS/MRU8EB
        +y/424r5bSDa5vDER8LoKmhnllZTu
X-Received: by 2002:a17:90a:dd43:: with SMTP id u3mr19471738pjv.98.1569741127080;
        Sun, 29 Sep 2019 00:12:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyT+gSha82rifzCEuzdxLi+0ibYQqsvVe35iZyNCwNHd4ziL61GxDzJcbhT+7FTuiVhY6lhRQ==
X-Received: by 2002:a17:90a:dd43:: with SMTP id u3mr19471722pjv.98.1569741126763;
        Sun, 29 Sep 2019 00:12:06 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s97sm14566118pjc.4.2019.09.29.00.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 00:12:06 -0700 (PDT)
Date:   Sun, 29 Sep 2019 15:11:57 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH 2/9] KVM: selftests: Add demand paging content to the
 demand paging test
Message-ID: <20190929071157.GA8903@xz-x1>
References: <20190927161836.57978-1-bgardon@google.com>
 <20190927161836.57978-3-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190927161836.57978-3-bgardon@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 27, 2019 at 09:18:30AM -0700, Ben Gardon wrote:
> The demand paging test is currently a simple page access test which, while
> potentially useful, doesn't add much versus the existing dirty logging
> test. To improve the demand paging test, add a basic userfaultfd demand
> paging implementation.
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---
>  .../selftests/kvm/demand_paging_test.c        | 157 ++++++++++++++++++
>  1 file changed, 157 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
> index 5f214517ba1de..61ba4e6a8214a 100644
> --- a/tools/testing/selftests/kvm/demand_paging_test.c
> +++ b/tools/testing/selftests/kvm/demand_paging_test.c
> @@ -11,11 +11,14 @@
>  
>  #include <stdio.h>
>  #include <stdlib.h>
> +#include <sys/syscall.h>

[1]

>  #include <unistd.h>
>  #include <time.h>
> +#include <poll.h>
>  #include <pthread.h>
>  #include <linux/bitmap.h>
>  #include <linux/bitops.h>
> +#include <linux/userfaultfd.h>
>  
>  #include "test_util.h"
>  #include "kvm_util.h"
> @@ -29,6 +32,8 @@
>  /* Default guest test virtual memory offset */
>  #define DEFAULT_GUEST_TEST_MEM		0xc0000000
>  
> +#define __NR_userfaultfd 323

This line can be dropped if with [1] above?

[...]

> +static void *uffd_handler_thread_fn(void *arg)
> +{
> +	struct uffd_handler_args *uffd_args = (struct uffd_handler_args *)arg;
> +	int uffd = uffd_args->uffd;
> +	int64_t pages = 0;
> +
> +	while (!quit_uffd_thread) {
> +		struct uffd_msg msg;
> +		struct pollfd pollfd[1];
> +		int r;
> +		uint64_t addr;
> +
> +		pollfd[0].fd = uffd;
> +		pollfd[0].events = POLLIN;
> +
> +		r = poll(pollfd, 1, 2000);

This may introduce an unecessary 2s delay when quit.  Maybe we can
refer to how userfaultfd selftest did with this (please see
uffd_poll_thread() in selftests/vm/userfaultfd.c on usage of pipefd).

Thanks,

-- 
Peter Xu
