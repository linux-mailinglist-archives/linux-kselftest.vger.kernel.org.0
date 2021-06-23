Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9E83B2008
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jun 2021 20:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhFWSLJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Jun 2021 14:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWSLI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Jun 2021 14:11:08 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46286C061574
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Jun 2021 11:08:50 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id d9so4622010ioo.2
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Jun 2021 11:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tgehAGNUXn4xZZ1zKYidRvVGVrVlom0a3F4JBtm3tQ8=;
        b=WpsRMzOrRbL6X3CZ09rN4UmhgMiiUWQxcsPbskC7V5/edqYwo5Rf50jSXYZgUpWHxg
         ewpq6ch9oB2cjjcAkZSMWLfw7EEvcbSu98a6OXxzzAt8o7CFKA+4J6q7GnQsRNIS06r7
         5S+IejWUIoUQR1PJUjF20ScvZDBhu15dSIHvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tgehAGNUXn4xZZ1zKYidRvVGVrVlom0a3F4JBtm3tQ8=;
        b=cHJypMDliX/HeTAFSA1mnaobUgBrPcrw9PlhUGlQn5+sdCBytb7NQ58q4qEBss1xAM
         HQxa0zTQ0Qablh0Xj992dlOXLHJK9H7ZP2/d+HmmEPDKpwIeq1qD8JnYFuBaXFo9ISK7
         RBI9L9Ae5c/x7bRTcuNMmAwU80gu518KcR88JLquc013JCi4g47OmrEBthN5bQ+f3keP
         FRFQxyNgZnzLBiezF7OVVlSrz1ERK0u9Ze0/uxVC+Xs1p5v04njZ0Kbc12H7BZ8/uDrd
         muSp0t4YhW9T8Odncg4MO87TFCBmUHKLqi/KcVoEUlMckWsf7kFJR9Eu/gXsb1Q0AdJl
         nzlQ==
X-Gm-Message-State: AOAM53304iZNq2ZpYTtrlx1kKy/u58CixXkvFfFqbKx9t8Bw3JJ0JLBp
        8o9MmojzK4xVdK+c41+H7c4x7w==
X-Google-Smtp-Source: ABdhPJyRk5Ey9JCFR3yvt7TDKAkrIEDzjwBCBT6b5ipHnYtVMFF5U9VMPwwHXr38FNkeEI/FGqr45A==
X-Received: by 2002:a6b:7609:: with SMTP id g9mr645424iom.184.1624471729573;
        Wed, 23 Jun 2021 11:08:49 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e14sm317839ilc.47.2021.06.23.11.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 11:08:49 -0700 (PDT)
Subject: Re: Kernel selftests and backward compatibility?
To:     Vitaly Chikunov <vt@altlinux.org>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Cc:     "Dmitry V. Levin" <ldv@altlinux.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210623142608.xx6qc3mkzc72z2cr@altlinux.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a068b01b-9549-3c6b-f0c5-7c68e9bc1c23@linuxfoundation.org>
Date:   Wed, 23 Jun 2021 12:08:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210623142608.xx6qc3mkzc72z2cr@altlinux.org>
Content-Type: text/plain; charset=koi8-r; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Vitaly,

On 6/23/21 8:26 AM, Vitaly Chikunov wrote:
> Shuah,
> 
> Do kselftests require to be backward-compatible?
> 

Kselftests from the latest kernel can run on older kernels. In that
respect they are backward compatible.

It is possible that a newly added test is for a new feature and new
API and as a result could be skipped on older kernels.



> I see Documentation/dev-tools/kselftest.rst does not require this, but
> maybe it's assumed like in other test suites (or in perf).
> 
> | In general, the rules for selftests are
> |
> |  * Do as much as you can if you're not root;
> |
> |  * Don't take too long;
> |
> |  * Don't break the build on any architecture, and
> |
> |  * Don't cause the top-level "make run_tests" to fail if your feature is
> |    unconfigured.
> 

Correct. We don't explicitly state that the tests are backward
compatible, however they are. We don't do any revision checks.
We keep adding new tests and enhancements to existing tests in
every release. New tests depend on new kernel features and headers
and they could fail to build. However the suite will build the tests
it can build and will run the test it can run.

> For example LTP says:
> 
> | LTP test should be as backward compatible as possible. [...]
> |
> | Therefore LTP test for more current features should be able to cope with older
> | systems.
> 
> Also, (it's said[1]) perf, even though in kernel tree, is supposed to work
> properly on any (older/newer) version of Linux.
> 
> Can you clarify this point in kselftest.rst?
> 
> I think, this would be useful for future kselftests developers, users,
> and packagers. (Currently, I package for ALT Linux kselftests (and perf)
> from the latest mainline branch, so people could test even older kernels
> with the latest kselftests.
> 
> If there is policy to be backward-compatible kselftests in the future
> could reach a state where users would run them in all pass mode (without
> selecting only working tests). This, in turn, would increase [ease of]
> usability of tests and thus frequency of their run and consequentially
> quality kernel testing overall.
> 

The policy is kselftests from new kernel can run on older kernels.
Tests that don't meet dependencies and privileges to run are skipped.
We do have newer tests that don't fail gracefully if dependencies aren't
met and those cases are considered as bugs.

We have a wide range of tests in the suite. Some tests are at the
granularity of a specific system call flag. It would be difficult to 
isolate all pass. What we can come close to is skipping tests that don't
meet dependencies consistently and we strive to do this and consider the
ones that don't meet as bugs and fix them.

Hope this gives you a context around backward compatibility.

thanks,
--- Shuah



