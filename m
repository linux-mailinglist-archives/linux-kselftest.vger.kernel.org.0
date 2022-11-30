Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F1263E359
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Nov 2022 23:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiK3WWs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Nov 2022 17:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiK3WWr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Nov 2022 17:22:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E729486A02
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 14:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669846913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tlhpALrMiGoDzod2chq2VQOjgDroj9IY+e5BnNee0KE=;
        b=iQNEI/QbW3+pEuIuDCp3RCJY18f4Wpf+fbqQ2yBUdktsC43WXxFThKf7awRO3AirN0zyxN
        4cMpVf/VZc1qoQwlau6dbns/ZlbCZVnXgdO/BMmu7lMutHwd6Rp96H4NEzf90SIByYYWZf
        z+jBUs5VcEi5TcIjWBmRdmx62Cy/ooU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-578-3bQ5No7PNnq6GYzdMJvfsg-1; Wed, 30 Nov 2022 17:21:51 -0500
X-MC-Unique: 3bQ5No7PNnq6GYzdMJvfsg-1
Received: by mail-qk1-f197.google.com with SMTP id i21-20020a05620a405500b006fb25ba3e00so41742485qko.1
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 14:21:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tlhpALrMiGoDzod2chq2VQOjgDroj9IY+e5BnNee0KE=;
        b=NAqOnEiyY1OBmp4eFVmLxqlu9gqXBuY7fZDmo7hiBrdqTfoYCHI3kJyUaRuh/qfztN
         BIoqMoVKFr3FwJh9C8FWiCHGNreBnweRAmc0zhgc3C9D7VCw0PZqARq0HH9LnqHqABuV
         FYJDfZkG8DOrL1UX8GATwQo6ETocAgfFftN+Qpv+M85TCIeDZccEFUl8ZPKwVa9PNA0Q
         wi+1xOuzlkhMpPyld3/qLaTn7zrSZx/Tt/jCJGQJCnRnR0qqiTrnRB9ptiKDgf4v0LHu
         9TK6iP6ioUzMSbqKHte4diyGnK+hXjaFEeBkWosDd1thK7JAdXvzhClpuCeimmi0Kxqd
         Txmg==
X-Gm-Message-State: ANoB5plNw8B1pPo3tRv/NlORyKl84W2pgg/IjgNkdkl2GxoC8Qf9c7mf
        +Jj9lOLVE4+5kn1gN4YxOF73L2gqtj3+FNAgAzjVnXttN10DBfU08JUAHijnaOe+62ARpULy7En
        onKe9fWIe0NKPeYHA04u7CM1WMMxO
X-Received: by 2002:a05:622a:5148:b0:3a5:176b:b1c7 with SMTP id ew8-20020a05622a514800b003a5176bb1c7mr45906994qtb.303.1669846911429;
        Wed, 30 Nov 2022 14:21:51 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5x6fLVYxdQdtQ3S17/M5EP6Kje/BXfVF/HWhKe4z6jDPn3Tn+3o1h4Xk+08JZsDArklog9hg==
X-Received: by 2002:a05:622a:5148:b0:3a5:176b:b1c7 with SMTP id ew8-20020a05622a514800b003a5176bb1c7mr45906973qtb.303.1669846911142;
        Wed, 30 Nov 2022 14:21:51 -0800 (PST)
Received: from [192.168.1.9] (pool-68-160-135-240.bstnma.fios.verizon.net. [68.160.135.240])
        by smtp.gmail.com with ESMTPSA id j8-20020ac85c48000000b0039ee562799csm1632825qtj.59.2022.11.30.14.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 14:21:50 -0800 (PST)
Subject: Re: [PATCH v2 0/2] livepatch: Move tests from lib/livepatch to
 selftests/livepatch
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, jpoimboe@redhat.com,
        Petr Mladek <pmladek@suse.com>
References: <20220630141226.2802-1-mpdesouza@suse.com>
 <3f9f91a3-4c08-52f4-1d3c-79f835271222@linuxfoundation.org>
 <alpine.LSU.2.21.2207010931270.13603@pobox.suse.cz>
 <8ff95ef5-db76-171d-4c4c-a84d9981290d@linuxfoundation.org>
 <20220715144526.GF2737@pathway.suse.cz>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <aae71b0b-74e3-5874-b12f-bf0d42d851e4@redhat.com>
Date:   Wed, 30 Nov 2022 17:22:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220715144526.GF2737@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/15/22 10:45 AM, Petr Mladek wrote:
> On Fri 2022-07-01 16:13:50, Shuah Khan wrote:
>> On 7/1/22 1:48 AM, Miroslav Benes wrote:
>>> On Thu, 30 Jun 2022, Shuah Khan wrote:
>>>>
>>>> Sorry Nack on this. Let's not add modules under selftests. Any usage of
>>>> module_init()
>>>> doesn't belong under selftests.
>>
>> Yes I did and after reviewing and thinking about it some more, I decided this
>> is the right direction go down on.
> 
> Do you have some particular reason why building modules in selftests
> directory might cause problems, please?
> 
> IMHO, the reason that the test modules are in lib is because the
> modules were there before selftests. Developers historically loaded them
> manually or they were built-in. Selftest were added later and are just
> another way how the module can be loaded. This is the case,
> for example, for lib/test_printf.c.
> 
> Otherwise, I do not see any big difference between building binaries
> and modules under tools/tests/selftests. As I said, in the older
> thread, IMHO, it makes more sense to have the selftest sources
> self-contained.
> 
> 
> There actually seems to be a principal problem in the following use
> case:
> 
> --- cut Documentation/dev-tools/kselftest.rst ---
> Kselftest from mainline can be run on older stable kernels. Running tests
> from mainline offers the best coverage. Several test rings run mainline
> kselftest suite on stable releases. The reason is that when a new test
> gets added to test existing code to regression test a bug, we should be
> able to run that test on an older kernel. Hence, it is important to keep
> code that can still test an older kernel and make sure it skips the test
> gracefully on newer releases.
> --- cut Documentation/dev-tools/kselftest.rst ---
> 
> together with
> 
> --- cut Documentation/dev-tools/kselftest.rst ---
>  * First use the headers inside the kernel source and/or git repo, and then the
>    system headers.  Headers for the kernel release as opposed to headers
>    installed by the distro on the system should be the primary focus to be able
>    to find regressions.
> --- cut Documentation/dev-tools/kselftest.rst ---
> 
> It means that selftests should support running binaries built against
> newer kernel sources on system running older kernel. But this might
> be pretty hard to achieve and maintain.
> 
> The normal kernel rules are exactly the opposite. Old binaries must
> be able to run on newer kernels. The old binaries were built against
> older headers.
> 
> IMHO, the testing of stable kernels makes perfect sense. And if we
> want to support it seriously than we need to allow building new
> selftests against headers from the old to-be-tested kernel. And
> it will be possible only when the selftests sources are as much
> selfcontained as possible.
> 
> Does this makes any sense, please?
> 

Gentle bump.  Shuah, I believe that Marcos will be preparing a v3 based
on review comments on the second patch.  We never resolved questions
surrounding building modules selftests/ (the first patch) though.

Regards,
-- 
Joe

