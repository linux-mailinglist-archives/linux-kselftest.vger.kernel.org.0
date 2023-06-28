Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFED5741AC5
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 23:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjF1VYP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 17:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjF1VXT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 17:23:19 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A0844A0
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Jun 2023 14:19:27 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-55ac8fcc887so108254a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Jun 2023 14:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687987167; x=1690579167;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K5o+u/LcqTyeF7/tUgJ+GtCurg1xt5x0j01M6c1nAM4=;
        b=BCMWJuhTCYqZq6awzCXGu8UvyS2OPUrlieTFwEo1aixq5Xm4ugYyzQEZiCU0iQjT//
         6uyBs7WKvusL/hPaakVVZBI1lGlxqLFW7rmrIpxWPkKdW8qlcymcdjYLR9fhMpAkqnoU
         hteN8adl4qjM+9L6EUO+99LkcnIqnhIQCR8L3l7fzf9U7HOyaxrmLxMgYoZSg5SnHIAo
         aenSx++qrBS33ZdMXjDaqUqEq70zxlh8/GRc1UmnWy+bQHoA0/B+jEZYNdNp/N/SfEoU
         ZaWTs/3jaNhAoEBXGpj7n437t82993zaOrSHY0JPeAFO1T70ng4IstUq0B22D6mGt0RM
         51Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687987167; x=1690579167;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K5o+u/LcqTyeF7/tUgJ+GtCurg1xt5x0j01M6c1nAM4=;
        b=QegiBEc7WM/QNV1nS+aaKL8NzOMRSJEas4suvfunghCaD5XOx67+0kzcsKuQqnvrPy
         bCCwMsmkrcQQPtZZ+7gPYKT+yry/dygpD2h831ljqnidrNlbMsUYMBw6NNhkDevUTUiU
         IQCGuE3oKqzD1WRhlfZeZ1QYWekKePB0s/XAMzg9QTHL7iy5D8J82MnOdDv4UpJR/p4M
         IEdbvVVEx5SLwa3fOGEwxntUn6+iY981TBcubwBJ1wlioa6EcIWLNASHSfc5GELgMBAt
         2Q/tdv5+1If4VuKQTgowHtH7Q75QyhtyhcAj02/jP2Pby17TTkZvmWjGAN4cV5kmObzW
         Mn8Q==
X-Gm-Message-State: AC+VfDwRGRIi6HMtjcmj7tgsrdZ7QigjXz0a6qAvU+FdTgxlH9k6Ky72
        eGkq1Ey1JPrtfIbk5sf8Sciy1faIeq0=
X-Google-Smtp-Source: APBJJlFWTrCAksdjDLaWtoLnz03DHBL3ow8XZSb9snqil8RyAkcgS/ASGh4N/YLbWfA+kzmLN3QQ66SKxQI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:7645:b0:263:4dca:ae63 with SMTP id
 s5-20020a17090a764500b002634dcaae63mr68584pjl.6.1687987167013; Wed, 28 Jun
 2023 14:19:27 -0700 (PDT)
Date:   Wed, 28 Jun 2023 14:19:25 -0700
In-Reply-To: <20230607123700.40229-2-cloudliang@tencent.com>
Mime-Version: 1.0
References: <20230607123700.40229-1-cloudliang@tencent.com> <20230607123700.40229-2-cloudliang@tencent.com>
Message-ID: <ZJyj3QDu9eAtJ+eq@google.com>
Subject: Re: [PATCH v3 1/4] KVM: selftests: Introduce __kvm_pmu_event_filter
 to improved event filter settings
From:   Sean Christopherson <seanjc@google.com>
To:     Jinrong Liang <ljr.kernel@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 07, 2023, Jinrong Liang wrote:
> -static struct kvm_pmu_event_filter *remove_event(struct kvm_pmu_event_filter *f,
> +static struct kvm_pmu_event_filter *remove_event(struct __kvm_pmu_event_filter *__f,
>  						 uint64_t event)

Can you tack on a patch to drop the return?  None of the callers consume it, and
it incorrectly implies that the incoming filter isn't modified.

>  {
>  	bool found = false;
>  	int i;
> +	struct kvm_pmu_event_filter *f = (void *)__f;

Nit, reverse xmas tree is preferred:

	struct kvm_pmu_event_filter *f = (void *)__f;
	bool found = false;
	int i;

Hoever, I don't think this one needs to cast, the cast is only necessary when
invoking a KVM ioctl(), e.g. I believe this should work:

static void remove_event(struct __kvm_pmu_event_filter *f, uint64_t event)
{
	bool found = false;
	int i;

	for (i = 0; i < f->nevents; i++) {
		if (found)
			f->events[i - 1] = f->events[i];
		else
			found = f->events[i] == event;
	}
	if (found)
		f->nevents--;
}
> @@ -569,19 +554,16 @@ static void run_masked_events_test(struct kvm_vcpu *vcpu,
>  				   const uint64_t masked_events[],
>  				   const int nmasked_events)
>  {
> -	struct kvm_pmu_event_filter *f;
> +	struct __kvm_pmu_event_filter f = {
> +	    .nevents = nmasked_events,
> +	    .action = KVM_PMU_EVENT_ALLOW,
> +	    .flags = KVM_PMU_EVENT_FLAG_MASKED_EVENTS,

Tabs, not spaces please.

> +static int set_pmu_single_event_filter(struct kvm_vcpu *vcpu, uint64_t event,
> +				       uint32_t flags, uint32_t action)
> +{
> +	struct __kvm_pmu_event_filter f = {
> +	    .nevents = 1,
> +	    .flags = flags,
> +	    .action = action,
> +	    .events = {
> +		event,

Tabs.
