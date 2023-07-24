Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3F075F53B
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 13:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjGXLgh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 07:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjGXLgY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 07:36:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8AC10E3
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jul 2023 04:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690198513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eMJT6NzbKAHchuNQihrlyERlClqLTiPaYVCXQcFFroU=;
        b=OHAAnjuSP/brcgJcG39PKyl9H86OLDBiCtwWKCoXPwagjjPLvQw4FbYojDkEG4kLV8CuSS
        fbMLYqwFxwS5dFam2+O2f5kvmR/qf1PdKeGuUmhubBiirw9JMohfqymvigYL9ZYsVMc/ZB
        jFfdnBoNt+jsj9EIUo0GWP5iXIzOp3U=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-xb5MfbkvOXi4IgRjmnyyjg-1; Mon, 24 Jul 2023 07:35:11 -0400
X-MC-Unique: xb5MfbkvOXi4IgRjmnyyjg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b93f4c300bso35271511fa.0
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jul 2023 04:35:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690198510; x=1690803310;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eMJT6NzbKAHchuNQihrlyERlClqLTiPaYVCXQcFFroU=;
        b=BZVXukSlWz9MIo1cX5zMyylNn48dW0853eMkAowE09FJA9FOLU+TSSXqF2b2zTujOs
         J/rrBcPCxKulSI8+zixFrVKVBKw5XKOof2gAxerbBqX/IbUDv7GbDSQwHTEWsAOCXrIW
         SmvA3+VPaVvZMfhVj9RCQ3uGHSDpNUjq7umWk7oAb1HYv98hhw9MlVbe9i47vyVfHoyo
         N2hn0eDx0gjWZfPz88MAxTaRBUwYQcHaI3PvwA1oBifR//SN4pjCUJYY5TIz895wm7um
         ggwYR5LDSHWRvxb00RGbqMB/aIJoI0Km/fk8zXospSLC9QwAb31H+iKajEESdUgAc8Q/
         8iaQ==
X-Gm-Message-State: ABy/qLYSzHrCafenQASESBRTF39SRv8l9FsMp6N+PxuJO4mcHgfGptnF
        /PLu+zRczuVEEuLlRZ32NKKXpPXxADcgrb/MgOYA82DMsn1IXbWJGYKsO1s8IaFT/gF4C0TOc3q
        Kjykq+Q6YB1Kmg+RhDolc81KRgUQh
X-Received: by 2002:a2e:96d1:0:b0:2b5:81bc:43a8 with SMTP id d17-20020a2e96d1000000b002b581bc43a8mr5173087ljj.0.1690198510174;
        Mon, 24 Jul 2023 04:35:10 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH6NuX+DPeSWpje6qdrDA76gRAGJ3wU7DiH93+PySyeupLPmy7RrJfQSrOoZuFGAXHyST8Hyw==
X-Received: by 2002:a2e:96d1:0:b0:2b5:81bc:43a8 with SMTP id d17-20020a2e96d1000000b002b581bc43a8mr5173075ljj.0.1690198509742;
        Mon, 24 Jul 2023 04:35:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73d:bb00:91a5:d1c:3a7e:4c77? (p200300cbc73dbb0091a50d1c3a7e4c77.dip0.t-ipconnect.de. [2003:cb:c73d:bb00:91a5:d1c:3a7e:4c77])
        by smtp.gmail.com with ESMTPSA id c22-20020a05600c0ad600b003fa98908014sm12663923wmr.8.2023.07.24.04.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 04:35:09 -0700 (PDT)
Message-ID: <83a3f3e5-d41b-07d5-0dfd-ed9a380baae4@redhat.com>
Date:   Mon, 24 Jul 2023 13:35:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 6/8] selftests/mm: Make migration test robust to
 failure
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Florent Revest <revest@chromium.org>,
        Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
References: <20230724082522.1202616-1-ryan.roberts@arm.com>
 <20230724082522.1202616-7-ryan.roberts@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230724082522.1202616-7-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 24.07.23 10:25, Ryan Roberts wrote:
> The `migration` test currently has a number of robustness problems that
> cause it to hang and leak resources.
> 
> Timeout: There are 3 tests, which each previously ran for 60 seconds.
> However, the timeout in mm/settings for a single test binary was set to
> 45 seconds. So when run using run_kselftest.sh, the top level timeout
> would trigger before the test binary was finished. Solve this by meeting
> in the middle; each of the 3 tests now runs for 20 seconds (for a total
> of 60), and the top level timeout is set to 90 seconds.
> 
> Leaking child processes: the `shared_anon` test fork()s some children
> but then an ASSERT() fires before the test kills those children. The
> assert causes immediate exit of the parent and leaking of the children.
> Furthermore, if run using the run_kselftest.sh wrapper, the wrapper
> would get stuck waiting for those children to exit, which never happens.
> Solve this by setting the "parent death signal" to SIGHUP in the child,
> so that the child is killed automatically if the parent dies.
> 
> With these changes, the test binary now runs to completion on arm64,
> with 2 tests passing and the `shared_anon` test failing.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

