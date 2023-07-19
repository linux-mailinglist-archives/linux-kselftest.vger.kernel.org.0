Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA750758AC0
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 03:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjGSBSD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 21:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGSBR4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 21:17:56 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B341BC9;
        Tue, 18 Jul 2023 18:17:55 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b8a462e0b0so39364735ad.3;
        Tue, 18 Jul 2023 18:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689729475; x=1690334275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dFOCio/Zfe9p1GfONJpPjKEYD+NkX9/ELuqh7E52mvg=;
        b=HAtDb+vL7iVnVrTmPPHFbJrX424J4PzNY0HmDcoxOr5X0XtC5WME1g9PEQImowgBmE
         eArhOXtvvHYX38Ih+X6X9k7+qy/ug6fbuFxrDKMFBxulS+O+svM3ye9Q4QBahMbTIKmv
         GBCegjLMpcsMGfL9ZD0RBd6ta34Hf7eklbyd9iVnNgKARKCRo6PMQUQfBxmZHFbF1UrX
         Y2WLdjIJms66+qioMRWZTOmpDmqx/HAMlRqtr8mi28q3cav6iig2X4EnV+bw0Qk9/2y9
         i5Treeohd0D7I2noquW4xogtn6ShsOrhg1jnEXTc0IbXZ+BoswU3msMYwHbSppRl5Dgd
         Xmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689729475; x=1690334275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFOCio/Zfe9p1GfONJpPjKEYD+NkX9/ELuqh7E52mvg=;
        b=W2bE6IBSsIQDZhWBMjOVFmC2ninuomSp1BQLowreiRPrS8EaJ0NUx87F/45kfo/iNd
         kUecibCjnDFvcJVFrPihPgwhzkKhXx9IDJx4rgfwE1t2Feheq0lPsXqwd6XlyXNGVqf+
         FYcKauJHEf/NjeQ+7f2/N8ilCgGGMLYzn7+qt0DSJsu05r95QJw03LHPspb00l2csODz
         5lz9YmzxSLLAD+PZyZdq5xu2llfSOg0cujBu6kAvD7WW3UM8irs8qoDP7hQmQPQMHSKQ
         HkO0EtK/xRwygkhyG2s7G0wo5bUHjy3VwCacA0/Q0mQ8be+YxMGojMC1TS/E7tAo1tLe
         hZkQ==
X-Gm-Message-State: ABy/qLbOM5X5kLo/d4n5xD4ZkM2fQTIntApsHVd87ljLC7LIeazAH/R/
        tRE5NpHZanzCYBUp1pjuOhc=
X-Google-Smtp-Source: APBJJlHLMooADvkzsEJd0Dr4zmRECjLci1WF8vpqqPwXK99fqbAuJNx+LcT4xGDc8m7QZ1HlH3dJew==
X-Received: by 2002:a17:902:f54d:b0:1b9:f1bd:b18b with SMTP id h13-20020a170902f54d00b001b9f1bdb18bmr1315043plf.6.1689729474705;
        Tue, 18 Jul 2023 18:17:54 -0700 (PDT)
Received: from localhost ([192.55.54.50])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902c14400b001b9bebb7a9dsm2500203plj.90.2023.07.18.18.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 18:17:54 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:17:52 -0700
From:   Isaku Yamahata <isaku.yamahata@gmail.com>
To:     Jinrong Liang <ljr.kernel@gmail.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
Subject: Re: [PATCH v4 4/6] KVM: selftests: Add test cases for unsupported
 PMU event filter input values
Message-ID: <20230719011752.GD25699@ls.amr.corp.intel.com>
References: <20230717062343.3743-1-cloudliang@tencent.com>
 <20230717062343.3743-5-cloudliang@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230717062343.3743-5-cloudliang@tencent.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 17, 2023 at 02:23:41PM +0800,
Jinrong Liang <ljr.kernel@gmail.com> wrote:

> From: Jinrong Liang <cloudliang@tencent.com>
> 
> Add test cases to verify the handling of unsupported input values for the
> PMU event filter. The tests cover unsupported "action" values, unsupported
> "flags" values, and unsupported "nevents" values. All these cases should
> return an error, as they are currently not supported by the filter.
> Furthermore, the tests also cover the scenario where setting non-existent
> fixed counters in the fixed bitmap does not fail.
> 
> Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
> ---
>  .../kvm/x86_64/pmu_event_filter_test.c        | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> index ffcbbf25b29b..63f85f583ef8 100644
> --- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> @@ -32,6 +32,10 @@
>  #define MAX_FILTER_EVENTS		300
>  #define MAX_TEST_EVENTS		10
>  
> +#define PMU_EVENT_FILTER_INVALID_ACTION		(KVM_PMU_EVENT_DENY + 1)
> +#define PMU_EVENT_FILTER_INVALID_FLAGS			(KVM_PMU_EVENT_FLAG_MASKED_EVENTS + 1)

flag is a bit mask. Not number. So +1 sounds weird.
As KVM_PMU_EVENT_FLAGS_VALID_MASK = 1,  this happens to get wanted result, though.


> +#define PMU_EVENT_FILTER_INVALID_NEVENTS		(MAX_FILTER_EVENTS + 1)
> +
>  /*
>   * This is how the event selector and unit mask are stored in an AMD
>   * core performance event-select register. Intel's format is similar,
> @@ -757,6 +761,8 @@ static int set_pmu_single_event_filter(struct kvm_vcpu *vcpu, uint64_t event,
>  
>  static void test_filter_ioctl(struct kvm_vcpu *vcpu)
>  {
> +	uint8_t nr_fixed_counters = kvm_cpu_property(X86_PROPERTY_PMU_NR_FIXED_COUNTERS);
> +	struct __kvm_pmu_event_filter f;
>  	uint64_t e = ~0ul;
>  	int r;
>  
> @@ -777,6 +783,26 @@ static void test_filter_ioctl(struct kvm_vcpu *vcpu)
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

-- 
Isaku Yamahata <isaku.yamahata@gmail.com>
