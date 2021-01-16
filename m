Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFBD2F89BA
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Jan 2021 01:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbhAPAB2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Jan 2021 19:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbhAPAB2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Jan 2021 19:01:28 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86288C061757
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Jan 2021 16:00:33 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id be12so5524163plb.4
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Jan 2021 16:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GbcRTwO4Py9PCASiY1YuohO9XCn71Gsdi46hwQnWEl8=;
        b=u6hXBbQKO2N4x8nIBPEaVhO/0sCJTrI6FL+Ens0rAcn+RjZcf9pFfg3xgjKMB5F4u3
         C18ArZDs1Rircdgu01RJPaV2Mxub8HMgAdJrtCipPzVIvWwTsIfq1idVIGENwwnuU3VA
         5OG/JcczDt5zL45Na2Rm9t1Ap5idXZThyG9OCpub4m2iAfXul122zjKDY5cesZWA/jx/
         LTS5V9lsHOM2SLckp65DzRan3RpdRbVvHzvBc308gdiHoT7pLF2jZvQBbS9C6C1v8Aen
         NUhnOLuYEnmntPWE2NZ44W8TXKOfJmt7xKi1zmxEFgI9AIrTUBoHEO2fCdxRrqEuBH8k
         YNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GbcRTwO4Py9PCASiY1YuohO9XCn71Gsdi46hwQnWEl8=;
        b=eaIG7eCVzTwMlX+OQU8eyp/PJlnJeL5C33MiK4DOWFqH7WRjlNCj5oIwhDi0sEF7tZ
         GzjMxYyYXdIHqejcV4XEB6NoiMDrUyfzk7XTEaDu4mm/SlW+47+ehLje+Xb20txyV0rI
         Zy1kaon3/iDXflhJOssEdTlEGYVZLGbHYecUcC1pAIN7t9CABJ+Ivl+FQmwAKQ8Gl6kk
         S0ODXOSiNFy1h70oggtUukqYf7EiA4zg+B/xfCv/AfrWl44IKcWIcUWZkBi5YXrHk7JP
         mrKVVgDR1hnyxqoqaNGqGAR+oJ06ebTWE4K9MubxGiA9OOLORs6mCcNaml9KXau77jG3
         wBCw==
X-Gm-Message-State: AOAM532Pi2p+pJsZAiyoLhVuPbapRZE5Fe8kQGTt8HdTRP68bcBjT9jC
        3cSSMXLpfh7eOKQ1Tz9VUiawhzdduI6JLg==
X-Google-Smtp-Source: ABdhPJwW1D63rhPKUfuQucpNll3MeH9K0by+Htu81WVwB0qMY/SS1W07DD42HefctcLFL0htvuDj1g==
X-Received: by 2002:a17:90b:204:: with SMTP id fy4mr13136166pjb.57.1610755232980;
        Fri, 15 Jan 2021 16:00:32 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id a29sm9016193pfr.73.2021.01.15.16.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 16:00:31 -0800 (PST)
Date:   Fri, 15 Jan 2021 16:00:24 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Shier <pshier@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Huth <thuth@redhat.com>, Jacob Xu <jacobhxu@google.com>,
        Makarand Sonare <makarandsonare@google.com>
Subject: Re: [PATCH 2/6] KVM: selftests: Avoid flooding debug log while
 populating memory
Message-ID: <YAIsmMrB1hwX804F@google.com>
References: <20210112214253.463999-1-bgardon@google.com>
 <20210112214253.463999-3-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112214253.463999-3-bgardon@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 12, 2021, Ben Gardon wrote:
> Peter Xu pointed out that a log message printed while waiting for the
> memory population phase of the dirty_log_perf_test will flood the debug
> logs as there is no delay after printing the message. Since the message
> does not provide much value anyway, remove it.

Does it provide value if something goes wrong?  E.g. if a vCPU doesn't finish,
how would one go about debugging?  Would it make sense to make the print
ratelimited instead of removing it altogether?
 
> Reviewed-by: Jacob Xu <jacobhxu@google.com>
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---
>  tools/testing/selftests/kvm/dirty_log_perf_test.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
> index 16efe6589b43..15a9c45bdb5f 100644
> --- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
> +++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
> @@ -146,8 +146,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>  	/* Allow the vCPU to populate memory */
>  	pr_debug("Starting iteration %lu - Populating\n", iteration);
>  	while (READ_ONCE(vcpu_last_completed_iteration[vcpu_id]) != iteration)
> -		pr_debug("Waiting for vcpu_last_completed_iteration == %lu\n",
> -			iteration);
> +		;
>  
>  	ts_diff = timespec_elapsed(start);
>  	pr_info("Populate memory time: %ld.%.9lds\n",
> @@ -171,9 +170,9 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>  
>  		pr_debug("Starting iteration %lu\n", iteration);
>  		for (vcpu_id = 0; vcpu_id < nr_vcpus; vcpu_id++) {
> -			while (READ_ONCE(vcpu_last_completed_iteration[vcpu_id]) != iteration)
> -				pr_debug("Waiting for vCPU %d vcpu_last_completed_iteration == %lu\n",
> -					 vcpu_id, iteration);
> +			while (READ_ONCE(vcpu_last_completed_iteration[vcpu_id])
> +			       != iteration)

I like the original better.  Poking out past 80 chars isn't the end of the world.

> +				;
>  		}
>  
>  		ts_diff = timespec_elapsed(start);
> -- 
> 2.30.0.284.gd98b1dd5eaa7-goog
> 
