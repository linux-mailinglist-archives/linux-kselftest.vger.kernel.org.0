Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF6D6BBF4D
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Mar 2023 22:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjCOVpf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 17:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjCOVpf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 17:45:35 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0B46B977;
        Wed, 15 Mar 2023 14:45:31 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id r16so17845313qtx.9;
        Wed, 15 Mar 2023 14:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678916731;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tj5wSiHpgsPQkAUOP519Bw4E3uBkvA+7E2x9NgpDap4=;
        b=PfFjugJFwI2qEnx/uFMmVbdBfgZ/YKOK5MuYiZjhtEGcuMpY3BF5pizcovyhQY1WCX
         uey2v9lf7VJmc9MlTmCNNJbBg9Tgyi4NIfa/NfCa4JDNkWILS0sxK0sFoOlZqFhKYv1K
         aDD0UdSYh1fW9MhYu+OdYQYceD4xCIX7Xt7AhY8b+wb6F8Foo0zHFWl2oXCNrfphJRei
         FU5S9PNjGjpa74NycbMeletE90dEqgiN+JbJAM6oweSJi9FlPdsqvmRRvtIpX2+6zat6
         K8xdzexajEIvfzKjvZrn7ezpcxc1yKKu98E4KBIclgmw9v+a4m9OLy+cthRemjCt6qQs
         /fiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678916731;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tj5wSiHpgsPQkAUOP519Bw4E3uBkvA+7E2x9NgpDap4=;
        b=EkxMqb7HMsUYncIrEYKOh2JVdq6dp/3IH5UjBc8JbF7yQlZik1O7t7cXjf4NkIs2ou
         PrcYucAy0P2k7DbUJsfFhLr7QL6g3BVU0oQILrJnkCKIZih4Er357uOYIgKxD9C1PG1W
         PWUEXJlVT+zZ7ViAAKy0+frzaO+Isf8MLMdh+FqU0/UCb7c8do+vp/hQYcfmOhjPGM7Q
         MA3PSlz3KEY3JF/zrswi5CBhy3CTaqiZKf24D+4jN2vc18kdpNWrTkcswmYp8eqZy332
         5/WYM7zVdEm/yl30Rh61VMFzm27zQdtXHckgksm1IQOeuws+D/GWJchTHJmypRhGAthP
         S2BA==
X-Gm-Message-State: AO0yUKXpzKY40EVOn89riSGm/adK45Iiwsdv/0yWm+BjBPL2ALJEmthR
        GZmGqrCJGbrf/pqlSfXFa5o=
X-Google-Smtp-Source: AK7set88Ftf2/QdGNAw7pbEqsZC90+DXAllNFUEL/Ob4mXQLYvcSI+1CvMmXqr5/6oJzFL8tpal9ew==
X-Received: by 2002:ac8:570d:0:b0:3b8:58d0:b4e4 with SMTP id 13-20020ac8570d000000b003b858d0b4e4mr2337945qtw.33.1678916731050;
        Wed, 15 Mar 2023 14:45:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:1157:1a08:54ae:71f7? ([2600:1700:2442:6db0:1157:1a08:54ae:71f7])
        by smtp.gmail.com with ESMTPSA id 71-20020a37054a000000b007436d0e9408sm4524019qkf.127.2023.03.15.14.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 14:45:30 -0700 (PDT)
Message-ID: <155efcdb-2be6-16c4-42bc-37930639060a@gmail.com>
Date:   Wed, 15 Mar 2023 16:45:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [KTAP V2 PATCH] ktap_v2: add skip test result
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>, kernelci@groups.io,
        rmoar@google.com
Cc:     "Bird, Tim" <Tim.Bird@sony.com>,
        "davidgow@google.com" <davidgow@google.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "brendanhiggins@google.com" <brendanhiggins@google.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "guillaume.tucker@collabora.com" <guillaume.tucker@collabora.com>,
        "dlatypov@google.com" <dlatypov@google.com>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230310222002.3633162-1-rmoar@google.com>
 <BYAPR13MB2503C590A2AE6FEF6BCAC529FDBB9@BYAPR13MB2503.namprd13.prod.outlook.com>
 <CA+GJov5O6hGdjYMXjRd34MEZuyBuukyJCOsS=HeO30h43eLQbQ@mail.gmail.com>
 <4568b302-2a5a-4499-b2f7-12f89c031495@sirena.org.uk>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <4568b302-2a5a-4499-b2f7-12f89c031495@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/15/23 07:53, Mark Brown wrote:
> On Tue, Mar 14, 2023 at 06:03:59PM -0400, Rae Moar via groups.io wrote:
> 
>> One thing to note on the created churn: I have noticed a proportion of
>> kselftests currently implement skipped tests in a way that does not
>> use the SKIP directive. They use a comment of the format "# [SKIP]"
>> prior to a test result line with no SKIP directive. Thus, in order to
>> reach KTAP compliance the way skip tests are handled would need to be
>> changed in these cases anyways.
> 
> This is the documented way of reporting a skip in KTAP:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/dev-tools/ktap.rst#n97
> 
> TBH I'm finding it really hard to summon much enthusiasm for changing
> this except as part of some other incompatible update - the current
> format isn't ideal but deploying a change would be a bunch of hassle for
> the existing test automation systems.

Yes, there is no need to do a single specification change that results
in incompatibility.  But given the previous discussions there seem to
be plenty of other desired changes that will result in incompatibility.

My desire is to take our time to capture as much of the desired changes
as possible in version 2 of the specification.  And an expectation that
there will not need to be a version 3 of the specification for many years.
I will support not rushing version 2 of the specification so that this
goal can be realized.
