Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B3077C40C
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 01:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjHNXtu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 19:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbjHNXta (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 19:49:30 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAF710C8;
        Mon, 14 Aug 2023 16:49:29 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso3652376a12.1;
        Mon, 14 Aug 2023 16:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692056969; x=1692661769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=br6OSR0B9+M+i2ApSCaNNWHBqjYVfS4RRcgrjd9CMp4=;
        b=V2osuCtpdwgI6KMK3nJNnMne+hWBmVAzcfzyzX5ePvfDyho2bzmh+kfSkTG/KzowLA
         nptcg3Bkw35RcZEVuPSd9hVeZiPXlVia5shOllZiFH+xfELTGdWuiiBu2uJqKhzQNjlo
         RfqgzojN0w/Srvf7iRLz5XAQtwrs8Xoi3h8QEioQ+DL0QrVMabh9p+Jku2GEQe8ZC/mZ
         K+w0WYjmG/7JlUlqiix74JQtk3QfjJr4n2+CXV0UuTWhWEl8+b7CdZOoMJYBX6GTu5SF
         z9TlPVPNBEAq9scnRjpPvL1avlcnh/8rCdBinVzhGmDPOCaWzBijpS4zJHRrsyBJlJIo
         upAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692056969; x=1692661769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=br6OSR0B9+M+i2ApSCaNNWHBqjYVfS4RRcgrjd9CMp4=;
        b=N7625TlO6ZKPQqMafkqTS/tsGANaipEX39jcMIUyS8NXIDu/iK6bsWQrWDhmXHbiRn
         dxVjcrQxP+/ntJSo28Q65nqqABaNjIfjg/5GU4Mf1tPDdGli5JsuLJ6fHYiU2bhnhTAg
         2Rx15b3sb4vEQ/OhUG3tiIqTWnm3meWe+lPjj3UL9o/FEG8sY/Dr+r8b/MypKXq05WTs
         ku1F3AkiJ/NkLx6QCjcqaDKnQ9FhYWWNoiiYpl1jvnHz/hIv4rIXrWXG0/LCfnLqRAi2
         kqTXzZUixZ80VtUh4ZC3TudS80vGvoxr5W/JFlDyYWEPim7Dk6HA3l/KIvVdHmS4rI64
         g7+w==
X-Gm-Message-State: AOJu0YxBLKXUIBV7PxLUsPGX/evq0/AIEJi69br6qrumNtgQ4gUJrjqn
        uYi8lfiNDvpgWLIFYmh6Fe0=
X-Google-Smtp-Source: AGHT+IH4CCajQQNmCMYkXdaClMswtCVN/4396syxM9HzwwTvCAR1c6hIFT7ZD9s4SkTh5JgQsAnvdA==
X-Received: by 2002:a05:6a21:7189:b0:137:53d1:405 with SMTP id wq9-20020a056a21718900b0013753d10405mr12333022pzb.26.1692056969368;
        Mon, 14 Aug 2023 16:49:29 -0700 (PDT)
Received: from localhost ([192.55.55.51])
        by smtp.gmail.com with ESMTPSA id c16-20020aa78810000000b00687933946ddsm8418263pfo.23.2023.08.14.16.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 16:49:28 -0700 (PDT)
Date:   Mon, 14 Aug 2023 16:49:26 -0700
From:   Isaku Yamahata <isaku.yamahata@gmail.com>
To:     Jinrong Liang <ljr.kernel@gmail.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, isaku.yamahata@gmail.com
Subject: Re: [PATCH v6 3/6] KVM: selftests: Introduce __kvm_pmu_event_filter
 to improved event filter settings
Message-ID: <20230814234926.GD2257301@ls.amr.corp.intel.com>
References: <20230810090945.16053-1-cloudliang@tencent.com>
 <20230810090945.16053-4-cloudliang@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230810090945.16053-4-cloudliang@tencent.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 10, 2023 at 05:09:42PM +0800,
Jinrong Liang <ljr.kernel@gmail.com> wrote:

> From: Jinrong Liang <cloudliang@tencent.com>
> 
> Add custom "__kvm_pmu_event_filter" structure to improve pmu event
> filter settings. Simplifies event filter setup by organizing event
> filter parameters in a cleaner, more organized way.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
> ---
>  .../kvm/x86_64/pmu_event_filter_test.c        | 182 +++++++++---------
>  1 file changed, 90 insertions(+), 92 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> index 5ac05e64bec9..94f5a89aac40 100644
> --- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> @@ -28,6 +28,10 @@
>  
>  #define NUM_BRANCHES 42
>  
> +/* Matches KVM_PMU_EVENT_FILTER_MAX_EVENTS in pmu.c */
> +#define MAX_FILTER_EVENTS		300

Can we simply use KVM_PMU_EVENT_FILTER_MAX_EVENTS and remove MAX_FILTER_EVENTS?


> +#define MAX_TEST_EVENTS		10
> +
>  /*
>   * This is how the event selector and unit mask are stored in an AMD
>   * core performance event-select register. Intel's format is similar,
> @@ -69,21 +73,33 @@
>  
>  #define INST_RETIRED EVENT(0xc0, 0)
>  
> +struct __kvm_pmu_event_filter {
> +	__u32 action;
> +	__u32 nevents;
> +	__u32 fixed_counter_bitmap;
> +	__u32 flags;
> +	__u32 pad[4];
> +	__u64 events[MAX_FILTER_EVENTS];
> +};
> +

Is this same to struct kvm_pmu_event_filter?

Except two trivial issue, looks good to me.
-- 
Isaku Yamahata <isaku.yamahata@gmail.com>
