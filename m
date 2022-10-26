Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD0160E264
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Oct 2022 15:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbiJZNoi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Oct 2022 09:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbiJZNoe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Oct 2022 09:44:34 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD693891;
        Wed, 26 Oct 2022 06:44:31 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 29457723;
        Wed, 26 Oct 2022 13:44:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 29457723
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1666791871; bh=FqnFi4P5DBvM5d8tmGPGlXGFwx5FCJWH+bst9DteRAc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=CeNjxMF/ta3zdJ4CUZbmazV5gjDlcKydZf1p91Mx0yq0i77JTdCiG4FDJG61WMszN
         vYCJz7gBnXbFhtFMSHESN39VbIXQtnS5xe1Q68JidusN9kRryJHHk8YnkzG4E//cGq
         0C8PlP0sbSDtVWg6vkj1cmm26Fz/Hk9GLUqfZWTBoLgH3pO1UogzBnR+Bz3DZakZhH
         xlZ4NeoYpbLp3tOUEbLSEOjyaLPdy5d+P2dNirwvamrGIXFi6PU8JaJJ8ZBOVsENNp
         q0Tjl4z3c7HF/HrRRfTIJDe+oQHezsR1RpwkPFT9QtgofZlBHkje4OubQcWhAz2+WZ
         zDbIJXTYEghzQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH hid v11 14/14] Documentation: add HID-BPF docs
In-Reply-To: <Y1k0QUxp38OhKg+1@debian.me>
References: <20221025093458.457089-1-benjamin.tissoires@redhat.com>
 <20221025093458.457089-15-benjamin.tissoires@redhat.com>
 <Y1k0QUxp38OhKg+1@debian.me>
Date:   Wed, 26 Oct 2022 07:44:30 -0600
Message-ID: <87a65id7i9.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> The wordings are somewhat confusing, so here's the alternative:

I've been kind of ignoring these editorial comments of yours, but this
bit of bikeshedding kind of exceeded my threshold.

> diff --git a/Documentation/hid/hid-bpf.rst b/Documentation/hid/hid-bpf.rst
> index ba35aa2e2ba836..c59bce4b9cf214 100644
> --- a/Documentation/hid/hid-bpf.rst
> +++ b/Documentation/hid/hid-bpf.rst
> @@ -27,88 +27,89 @@ Assuming you have a joystick that is getting older, it is common to see it
>  wobbling around its neutral point. This is usually filtered at the application
>  level by adding a *dead zone* for this specific axis.
>  
> -With HID-BPF, we can apply this filtering in the kernel directly so userspace
> -does not get woken up when nothing else is happening on the input controller.
> +With HID-BPF, the filter can be applied in the kernel directly so that
> +userspace does not get woken up when nothing else is happening on the input
> +controller.

How does a shift to the passive voice help here?  What is the problem
you are trying to solve?

> -Of course, given that this dead zone is specific to an individual device, we
> -can not create a generic fix for all of the same joysticks. Adding a custom
> -kernel API for this (e.g. by adding a sysfs entry) does not guarantee this new
> -kernel API will be broadly adopted and maintained.
> +Of course, given that dead zone filter is device-specific, it is not possible

                       ^
Missing article -------+

> +to create a generic fix for all of the same joysticks. Adding a custom
> +kernel API for this (e.g. by adding a sysfs entry) does not guarantee that
> +the API will be broadly adopted and maintained.
>  
> -HID-BPF allows the userspace program to load the program itself, ensuring we
> -only load the custom API when we have a user.
> +HID-BPF allows the userspace program to load the program itself, ensuring that
> +custom API is only needed for edge cases (like esoteric joysticks)

That (beyond the missing article) changes the meaning of the sentence;
it no longer really makes sense.

I'll stop here.

Bagas, I've asked this several times: *please* stop trying to tell other
contributors what to do and, instead, focus on contributing something
useful yourself.  You seem to have the energy and interest to do
worthwhile stuff - please do that!

Thanks,

jon
