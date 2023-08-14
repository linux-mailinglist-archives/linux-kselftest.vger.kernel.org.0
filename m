Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A0477C410
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 01:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjHNXv0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 19:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbjHNXvO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 19:51:14 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB1F10C8;
        Mon, 14 Aug 2023 16:51:13 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-686f8614ce5so4595608b3a.3;
        Mon, 14 Aug 2023 16:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692057072; x=1692661872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FJF1PG0CUa9p8j/7vKNB9TVHClkbYuczT+7ZndNAthc=;
        b=mrVz934cfEPwxddStWant3PHW5IfM1rNw8G55C49SmHBKNt2+/9tUzAG1kDQ7tHa4D
         HBy/yeyKzIeALvA5eeIfTnhy4JurY1XNHR0cJ+SUGAbU103Tq6PO16JoY9J+CQCWcZla
         L2M0qPO16v4DCUbRj79WekWILUAVAMAWZKQ5b5cWNi4hniUwiOA6YLKCq7kQauAyuIbv
         a2KOUra5aCC06gHTSxM1dYq1WAj2n6kUtCXRPm6pOcj5sOA72iu0zPPJGmFkcSJcuOWo
         uvGYLz8PeKxs6zZGJYTlslScsjgi7uAyAWRgN9UUpev2cQnzQkhfcu08JwgRtEMdieab
         IPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692057072; x=1692661872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJF1PG0CUa9p8j/7vKNB9TVHClkbYuczT+7ZndNAthc=;
        b=hMMX0f2MsNz7JZN8RMYRaQ8xPaRoAoCJjfv/ES41BEtqC5p5QF55UNWrehpIjPRFOg
         CouUwhSCcGOZN9+x8sbC93QjRiLWwZMq6Wn0igLWgaUgeP+4rhRD0EpBTsUQMYMqkiiT
         yR+F9dBXe4H7GY7/NngVJOFPMb2jMHBKflUyAoCeReBphCXwJ5p5qBEpeZBA9/ApgxZA
         LERo/8Z4Ux4GSOnSTgpmKv7tVftq4s+PhARV86zjdxU1Xgyvn5vJCkRkU/Qwvg8O4HZw
         i4UnDEeC28KAwC4fB08c0LRbAr89DAXXNiKQIG8yZt5Yi96GqEWw7KDLgA+tRDD1UziS
         qVyQ==
X-Gm-Message-State: AOJu0Yy4GhfoE+zFyuQw89E78qnuAhHHuDJrko/I+pfewFEC+tqmkcgu
        V1TMNQgKG6zVgprX/F3vBYM=
X-Google-Smtp-Source: AGHT+IH8i/jC+/MIEdsbdK3cJ8dmc9n58nECATIOzGuMTd5fZFP9hrrStQVXIWf43OBWbSmOWS/ZsQ==
X-Received: by 2002:a05:6a00:816:b0:686:2fde:4d6 with SMTP id m22-20020a056a00081600b006862fde04d6mr14806032pfk.6.1692057072558;
        Mon, 14 Aug 2023 16:51:12 -0700 (PDT)
Received: from localhost ([192.55.55.51])
        by smtp.gmail.com with ESMTPSA id s11-20020aa78d4b000000b006878f50d071sm8330655pfe.203.2023.08.14.16.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 16:51:12 -0700 (PDT)
Date:   Mon, 14 Aug 2023 16:51:11 -0700
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
Subject: Re: [PATCH v6 4/6] KVM: selftests: Add test cases for unsupported
 PMU event filter input values
Message-ID: <20230814235111.GE2257301@ls.amr.corp.intel.com>
References: <20230810090945.16053-1-cloudliang@tencent.com>
 <20230810090945.16053-5-cloudliang@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230810090945.16053-5-cloudliang@tencent.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 10, 2023 at 05:09:43PM +0800,
Jinrong Liang <ljr.kernel@gmail.com> wrote:

> From: Jinrong Liang <cloudliang@tencent.com>
> 
> Add test cases to verify the handling of unsupported input values for the
> PMU event filter. The tests cover unsupported "action" values, unsupported
> "flags" values, and unsupported "nevents" values. All these cases should
> return an error, as they are currently not supported by the filter.
> Furthermore, the tests also cover the case where setting non-existent
> fixed counters in the fixed bitmap does not fail.
> 
> Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
> ---
>  .../kvm/x86_64/pmu_event_filter_test.c        | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> index 94f5a89aac40..8b8bfee11016 100644
> --- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> @@ -32,6 +32,10 @@
>  #define MAX_FILTER_EVENTS		300
>  #define MAX_TEST_EVENTS		10
>  
> +#define PMU_EVENT_FILTER_INVALID_ACTION		(KVM_PMU_EVENT_DENY + 1)
> +#define PMU_EVENT_FILTER_INVALID_FLAGS			(KVM_PMU_EVENT_FLAGS_VALID_MASK << 1)
> +#define PMU_EVENT_FILTER_INVALID_NEVENTS		(MAX_FILTER_EVENTS + 1)
> +
>  /*
>   * This is how the event selector and unit mask are stored in an AMD
>   * core performance event-select register. Intel's format is similar,
> @@ -760,6 +764,8 @@ static int set_pmu_single_event_filter(struct kvm_vcpu *vcpu, uint64_t event,
>  
>  static void test_filter_ioctl(struct kvm_vcpu *vcpu)
>  {
> +	uint8_t nr_fixed_counters = kvm_cpu_property(X86_PROPERTY_PMU_NR_FIXED_COUNTERS);
> +	struct __kvm_pmu_event_filter f;
>  	uint64_t e = ~0ul;
>  	int r;
>  
> @@ -780,6 +786,26 @@ static void test_filter_ioctl(struct kvm_vcpu *vcpu)
>  					KVM_PMU_EVENT_FLAG_MASKED_EVENTS,
>  					KVM_PMU_EVENT_ALLOW);
>  	TEST_ASSERT(r == 0, "Valid PMU Event Filter is failing");
> +
> +	f = base_event_filter;
> +	f.action = PMU_EVENT_FILTER_INVALID_ACTION;
> +	r = do_vcpu_set_pmu_event_filter(vcpu, &f);
> +	TEST_ASSERT(r, "Set invalid action is expected to fail");
> +
> +	f = base_event_filter;
> +	f.flags = PMU_EVENT_FILTER_INVALID_FLAGS;
> +	r = do_vcpu_set_pmu_event_filter(vcpu, &f);
> +	TEST_ASSERT(r, "Set invalid flags is expected to fail");
> +
> +	f = base_event_filter;
> +	f.nevents = PMU_EVENT_FILTER_INVALID_NEVENTS;
> +	r = do_vcpu_set_pmu_event_filter(vcpu, &f);
> +	TEST_ASSERT(r, "Exceeding the max number of filter events should fail");
> +
> +	f = base_event_filter;
> +	f.fixed_counter_bitmap = ~GENMASK_ULL(nr_fixed_counters, 0);
> +	r = do_vcpu_set_pmu_event_filter(vcpu, &f);
> +	TEST_ASSERT(!r, "Masking non-existent fixed counters should be allowed");
>  }
>  
>  int main(int argc, char *argv[])
> -- 
> 2.39.3
> 

Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>
-- 
Isaku Yamahata <isaku.yamahata@gmail.com>
