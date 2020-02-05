Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0600D153325
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2020 15:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgBEOhZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Feb 2020 09:37:25 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40811 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726208AbgBEOhY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Feb 2020 09:37:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580913443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jWlvFwUdUv+RENWF5c/fy1loseX2NrAzZ8YGZViIh9Q=;
        b=T3BQCGCPM3yOFZ/oTsd8805wVqLa8EUs/plB5goGiLeHlmRsASUoJcvU/J9f4OkBr1MfCi
        kStS7uTiVxpz1HyEBChQMD1i+RrrNhpXrGDS6aqc2cXseCssvm57u8nlV+Tcsfs75cc3dH
        lgDURVKRuRVye+1RU1fzgLvvYh37x+w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-EYHNL88NPEGvIMXyBXQm4Q-1; Wed, 05 Feb 2020 09:37:21 -0500
X-MC-Unique: EYHNL88NPEGvIMXyBXQm4Q-1
Received: by mail-wr1-f70.google.com with SMTP id z15so1297154wrw.0
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Feb 2020 06:37:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jWlvFwUdUv+RENWF5c/fy1loseX2NrAzZ8YGZViIh9Q=;
        b=IuiElWTBRs87f+hLGTvR8oZ/x4EV53SXQAIJzXl286NLymaeEKcR88etFHz1+XNCQk
         WVgayyMTSzBrw48Mc5qBqHTcwYAyPHhLmyBTtlQWj/wsFEJugY8zcA/3Gi3FHBdSZV5/
         6q4McoFfmFhWCvw8fBY5OaT6WnNGU76zwMUi7YeIWEgNl6YXqgvR3AoaF1pXx601wDIE
         OaGnvaEWXFCfVHKj470wH/rxYuk8zc+oXmFPKD08HTGbcAeXtDNCBrqOwaheiv7XC4nJ
         uzXfVZxBi4IPvZAobdMPd3rbnBGDJhUfaSr3bajdZudL5ndDLvTkoWLMuN2Cy6KaWeVy
         1ckw==
X-Gm-Message-State: APjAAAX/w8ojP+HU3r51U4MXwTar/Xa4zO52q6mUZLunF6NRWLYkPfSN
        jnE/BoXVpv5uEEv+u0a0FdiM1hDO4zKyivK/srYanXLHMlQI/fL0s5Nom+b3Jf8KDbLKlM0ypdp
        JijWwZtHkpbHjhIAOUrhDsECP/G3c
X-Received: by 2002:a5d:6144:: with SMTP id y4mr28122024wrt.367.1580913439821;
        Wed, 05 Feb 2020 06:37:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqzDnnQbP+VZROCaAZ6agojL2psHiA+jWmvjshHhDZUxQyLaSpAQAtfLUiTomj0vKySe4pbwqg==
X-Received: by 2002:a5d:6144:: with SMTP id y4mr28122006wrt.367.1580913439652;
        Wed, 05 Feb 2020 06:37:19 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id g128sm8208807wme.47.2020.02.05.06.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 06:37:19 -0800 (PST)
Subject: Re: [PATCH 2/3] kvm: mmu: Separate generating and setting mmio ptes
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ben Gardon <bgardon@google.com>
Cc:     Peter Xu <peterx@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20200203230911.39755-1-bgardon@google.com>
 <20200203230911.39755-2-bgardon@google.com>
 <87sgjpkve2.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1a920cd0-530b-f380-a81a-da7cc6969f3e@redhat.com>
Date:   Wed, 5 Feb 2020 15:37:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87sgjpkve2.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 05/02/20 14:37, Vitaly Kuznetsov wrote:
>> +static void mark_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, u64 gfn,
>> +			   unsigned int access)
>> +{
>> +	u64 mask = make_mmio_spte(vcpu, gfn, access);
>> +	unsigned int gen = get_mmio_spte_generation(mask);
>> +
>> +	access = mask & ACC_ALL;
>> +
>>  	trace_mark_mmio_spte(sptep, gfn, access, gen);
> 'access' and 'gen' are only being used for tracing, would it rather make
> sense to rename&move it to the newly introduced make_mmio_spte()? Or do
> we actually need tracing for both?

You would have the same issue with sptep.

> Also, I dislike re-purposing function parameters.

Yes, "trace_mark_mmio_spte(sptep, gfn, mask & ACC_ALL, gen);" is
slightly better.

Paolo

