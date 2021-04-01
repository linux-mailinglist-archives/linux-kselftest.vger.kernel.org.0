Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFCC352386
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Apr 2021 01:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234968AbhDAX1P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Apr 2021 19:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbhDAX1O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Apr 2021 19:27:14 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F32C061788
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Apr 2021 16:27:14 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id k25so3824986iob.6
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Apr 2021 16:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n/Cy9GFSSG292kbWWXXjaNyNH/4apg+3HJDMSJ6lS/0=;
        b=cnGPeiI0reWFraLFVR4ze+oO/uopDQHdjCCjQGr7HYMB3+g/7D7+MyXjBwAxVqqAcg
         Z8gbSe19fHzXp+1tRlQB/wNt++TDIlccEIj7DzgssBOoHWqg75WcMQgHetZEA9vQ0dHS
         puqYQ22lO5Y3r6baZBtXdEkpznip1fHW1wVA4YeOAe7hqwQG7NsMkRxDy5ISkk6VicP3
         1YUxLe90IYzaODAl/7qi/l5c8aJZVpFzu4nvs4zzw8zcadsqPrjCtailwDOurWHsK7Pq
         TAQ9MNeZ8X4tgyvF9z7uXQ7rQgaoAf/R/qSlyHDc41d9/ou94mxwOVG4pGPJVC2W7w1b
         n6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n/Cy9GFSSG292kbWWXXjaNyNH/4apg+3HJDMSJ6lS/0=;
        b=NejXfQdfGfUITqOtcvQh4yMbfMo6HBSya6XjBTAYO4RO3kUFtf4ArKQ+/IZaPvEdUt
         gnvtwXhGO6ksxEwPJD5j0npqFclToCgcOF3NepvcAcHaGyECpvVHVbDQ6/2aW9fivoZU
         Sax2SdCywwZmQGWtHOR176Ph7Ka+LWkmxcNeNGy/wxVkNOmmVSKHlMc3EZwvEjfND+bK
         rerOnIEZhrL1EpvdTh2kx+sOK8afYI7VqCBmv09HM9V31FEZ5T+wp4XWzHOdxGu/HzW1
         Cdjlr3WryFPmOjt9Mr3CXCSRFdZFN+oTSW81nasSW2+u7Fx7TyvdZyE3c9GHueoDwDvX
         mv3Q==
X-Gm-Message-State: AOAM530eW28c+2m0BLy0IgfookVvfsBkwFeKbENxMtyNuZwD+bUJk36x
        LdXlTUaf58xzS57N7/jaXqHPJ8dry6KkpS+8j6TsNQ==
X-Google-Smtp-Source: ABdhPJy5WrUR32ElfKa80MigZbS1m8oMj+ZQkP4ozZ9oygO7G1Z+PTnvQcBiDCoRD/ZUi/2BaLZkWoRmbEi3OD8LhqQ=
X-Received: by 2002:a5d:8453:: with SMTP id w19mr8595652ior.25.1617319633765;
 Thu, 01 Apr 2021 16:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210401114504.13466-1-psampat@linux.ibm.com> <20210401114504.13466-3-psampat@linux.ibm.com>
In-Reply-To: <20210401114504.13466-3-psampat@linux.ibm.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Thu, 1 Apr 2021 16:27:04 -0700
Message-ID: <CAAYoRsWKw2eXXoXGhdaM2pqhvDGXz8o=hV5K5HmYaZvetxv96w@mail.gmail.com>
Subject: Re: [RFC v2 2/2] selftest/cpuidle: Add support for cpuidle latency measurement
To:     Pratik Rajesh Sampat <psampat@linux.ibm.com>
Cc:     rjw@rjwysocki.net, Daniel Lezcano <daniel.lezcano@linaro.org>,
        shuah@kernel.org, ego@linux.vnet.ibm.com, svaidy@linux.ibm.com,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, pratik.r.sampat@gmail.com,
        dsmythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Pratik,

On Thu, Apr 1, 2021 at 4:45 AM Pratik Rajesh Sampat
<psampat@linux.ibm.com> wrote:
>
...

> To run this test specifically:
> $ make -C tools/testing/selftests TARGETS="cpuidle" run_tests

I have not become any smarter than I was with version 1,
and still assumed that the "$" meant regular user.
Please put it as "#" or separate the two steps, compile and run.

>
> There are a few optinal arguments too that the script can take

optional

Suggest to also specifically mention how to run without re-compile,

# ./cpuidle.sh -v

Note also that the test still leaves all idle states disabled when done.

>         [-h <help>]
>         [-i <run timer tests>]
>         [-m <location of the module>]
>         [-o <location of the output>]
>         [-v <verbose> (run on all cpus)]
> Default Output location in: tools/testing/selftest/cpuidle/cpuidle.log

...

> +cpu_is_online()
> +{
> +       cpu=$1
> +       if [ ! -f "/sys/devices/system/cpu/cpu$cpu/online" ]; then
> +               echo 0

incorrect. should be:

> +               echo 1

... Doug
