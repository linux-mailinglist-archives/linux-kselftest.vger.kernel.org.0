Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F7E76DFB7
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 07:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjHCFYy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 01:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjHCFYx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 01:24:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38183199F
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Aug 2023 22:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691040245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CwpRObE3Mu0PTmBnHo+CXP3E6KvsETU6GJ0mZhuN6xE=;
        b=QCpP1tYSB5sJ50A8oprNOUlUcibrC8QdQFvP4R036krYWRtiwFRPpf7Rg35DTlxdgCBK1R
        KLZI4hP8kqmpG7UQZxlZkGvxV3ACrrSXKZxx28gyoAUoys6MgO24RoOfflyQopJWm/pYtS
        l+iqQlKGcunE69HAJqh0dpMmQgdlrrk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-R3P5EVwlNziHNLi9AH4Fzg-1; Thu, 03 Aug 2023 01:24:03 -0400
X-MC-Unique: R3P5EVwlNziHNLi9AH4Fzg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7682705c039so71594585a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Aug 2023 22:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691040243; x=1691645043;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CwpRObE3Mu0PTmBnHo+CXP3E6KvsETU6GJ0mZhuN6xE=;
        b=Axn7sst6I2gQAF6YVLFYIhyI9uWnNDHKaF9VQyYPStPes1EXLbcHb4dLkKhc8hdHV/
         /yCJYUTAnBL0iwxY/IBFEfYMll8SjcGY5b0hx2vyz8ruDm2fDPiteGrvZMNverdtAa0l
         1xnZxozVcDD5g6H6km7xO0FT43fLD9snumIO51q5oOa+HdXv3d0uhm/bq6Mk1yjerdLv
         QS36q4gwWUHYgUx/qZ/ky+wHZfBoj6HrYDKM7lZswz7tOoyqOwJ4NlFy6vYYWBmPjEVI
         4qPf8LK92Pfv79HVZ+bvLW1zRWCoyg8R2rK5tDBKEj5G+Lwe6rbX4P2BJaBs1oFnCKx9
         C7wA==
X-Gm-Message-State: ABy/qLYSfb9WMiqe7Ot99LwCjA8KJrqpJsZQKlr699VH22g27kGwV0vP
        s2cC2ZBBj9aEg7nFlkVZM7PT1rgpkaFxMOXQOL9wrBercNGHqf9R509OITA+9CJ23kT/UPPjWLu
        FGQD3KhuAkh69CS5Ynn/IulVf4dl2
X-Received: by 2002:a05:620a:143:b0:76c:c0bc:bfe0 with SMTP id e3-20020a05620a014300b0076cc0bcbfe0mr7406644qkn.39.1691040243446;
        Wed, 02 Aug 2023 22:24:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG9V4+uJSXQAwi0H0dkJp+F78Nd+MiTS9NDoSbIzUTQI0U2Rml5xhIcMIe8fWoAu/WSFk+tXA==
X-Received: by 2002:a05:620a:143:b0:76c:c0bc:bfe0 with SMTP id e3-20020a05620a014300b0076cc0bcbfe0mr7406633qkn.39.1691040243220;
        Wed, 02 Aug 2023 22:24:03 -0700 (PDT)
Received: from [192.168.8.105] (tmo-081-137.customers.d1-online.com. [80.187.81.137])
        by smtp.gmail.com with ESMTPSA id d13-20020a05620a158d00b0076cce1e9a1csm1219870qkk.31.2023.08.02.22.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 22:24:02 -0700 (PDT)
Message-ID: <54de068f-94ff-ce75-333d-7f1f79e2743f@redhat.com>
Date:   Thu, 3 Aug 2023 07:23:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kselftest@vger.kernel.org,
        David Matlack <dmatlack@google.com>
References: <20230712075910.22480-1-thuth@redhat.com>
 <20230712075910.22480-3-thuth@redhat.com> <ZMq0nYYDbOX1cOKN@google.com>
 <ZMrLMYxj3s+vHGrQ@google.com>
From:   Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 2/4] KVM: selftests: x86: Use TAP interface in the
 sync_regs test
In-Reply-To: <ZMrLMYxj3s+vHGrQ@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 02/08/2023 23.31, Sean Christopherson wrote:
> On Wed, Aug 02, 2023, Sean Christopherson wrote:
>> Oh, and no need to post "KVM: selftests: Rename the ASSERT_EQ macro" in the next
>> version, I'm planning on grabbing that one straightaway.
> 
> After paging this all back in...
> 
> I would much prefer that we implement the KVM specific macros[*], e.g. KVM_ONE_VCPU_TEST(),
> and build on top of those.  I'm definitely ok doing a "slow" conversion, i.e. starting
> with a few easy tests.  IIRC at some point I said I strongly preferred an all-or-nothing
> approach, but realistically I don't think we'll make progress anytime soon if we try to
> boil the ocean.

At least I don't have enough spare time to do such a big conversion all at 
once - I'm only occasionally looking at the KVM selftests, mostly for s390x, 
and I also lack the knowledge how to test all those x86 tests. So don't 
expect such a big conversion from me, all I can provide is a small patch 
here or there.

> But I do think we should spend the time to implement the infrastructure right away.  We
> may end up having to tweak the infrastructure down the road, e.g. to convert other tests,
> but I would rather do that then convert some tests twice.
> 
> [*] https://lore.kernel.org/all/Y2v+B3xxYKJSM%2FfH@google.com

Sorry, I somehow completely missed that KVM_ONE_VCPU_TEST suggestion when 
picking up the series up again after working on other stuff for more than 
half a year. I'll try to incorporate this into the next version.

(the other patches don't need a fixture, so I think they shouldn't be 
affected by this?)

  Thomas

