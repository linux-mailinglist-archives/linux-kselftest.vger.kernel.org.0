Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4904F455FB1
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Nov 2021 16:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbhKRPk7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Nov 2021 10:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbhKRPk6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Nov 2021 10:40:58 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E976C061574;
        Thu, 18 Nov 2021 07:37:58 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id n85so6386033pfd.10;
        Thu, 18 Nov 2021 07:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H63tYC9VZirdHLdx/wP8j9KfA3u77nm8eK5aUwcmc7I=;
        b=Ot44ei6RVgNJ5wnsuAEPY40LMWLWkuTl2NwglGZJNZuR/RWtL5KSG4zquBUqAGWHRG
         YDlKNg1IDgejuR6glbKGB1/pmrtqvnwncEi49hvjMN8DI39LgpuhQHzzp9IRseu+9f6B
         F0MERHdaZTbVfXmi7rtzVWLfzWP2YIE0dK3JIB9ZGgt0b6SulkIfJ/V/CxksY8gE7hGQ
         D6glIFn5yKzH7q7Dh1VHuEWQFbCtvFYal4SVEr8P9nuHXp+ACGGnh6Y0UwDmH3Zx/U5S
         TU5s6FWCLSDK0Q7X5r2sto8TNlqAb0WcI8gLyE8x62hL/v/0fUTM2n/1YgWINckDfhix
         gOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H63tYC9VZirdHLdx/wP8j9KfA3u77nm8eK5aUwcmc7I=;
        b=qGnbwzLy5Mloh73+Nvu5B/VFuW4qomiabF3dDJlV/1sY8oskCPdFrqO+yRQupFAD0u
         bk7XkhUoblbKoE7ZxUt5ohud49jt9+7RX0Ef1nEAtcapa/uExT3mF8SZUouH4BQ7y+Q1
         7Eozw7JJU+ZpZAMRVPMgedrnAJU2cTS1UwxKkCiZvDqVspEOZbKyForKN90ig+mvIAWt
         rTg6k54cYdM5yXLPiIr7hMnZ9W93m6wK/KNH4McQ+PWgMRuFqMHMy1KySbF9saXKLGWB
         Q1EIrNQbPvB3uSLTRCpYbsSaJiYhBojf468+qmbclHLBq+fvJSxzjkKYK1AbmrGrDtzO
         uJiA==
X-Gm-Message-State: AOAM5322yX7BER87o66yIlePPyPKkhJyYy6fSc7obQYJG9aLGY6ZvXDl
        XoRNdrKj1t7PhtJAk5zVcjb9y2IuQWmlIERKSYQ=
X-Google-Smtp-Source: ABdhPJxIsnca/WuiwlgH8hsoVhfQYGtrxibEd8TAes0FdIYphIVtlfbpdo5+QCOP1kZOQYVCmDaitDtW5IBftZ0MXRs=
X-Received: by 2002:a63:d00c:: with SMTP id z12mr11871225pgf.334.1637249877960;
 Thu, 18 Nov 2021 07:37:57 -0800 (PST)
MIME-Version: 1.0
References: <CA+3zgmtHdCE3TZn3Hc8+nsYc+mHHvACNgFY_Z_Z4nCAmhSnQPg@mail.gmail.com>
 <CA+G9fYuFqFyYXkvGK8jVCZAiDZW_oNG4dNY_2q9BG__uXRR1DQ@mail.gmail.com>
In-Reply-To: <CA+G9fYuFqFyYXkvGK8jVCZAiDZW_oNG4dNY_2q9BG__uXRR1DQ@mail.gmail.com>
From:   Tim Lewis <elatllat@gmail.com>
Date:   Thu, 18 Nov 2021 10:37:46 -0500
Message-ID: <CA+3zgmtwFQNc05why_bT1fXxPM2ShHtZ=MaB6QOmkYw81wKn6A@mail.gmail.com>
Subject: Re: Re: [PATCH 5.10 000/578] 5.10.80-rc2 review
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 18, 2021 at 5:41 AM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
...
> I have noticed intermittent failures on slow devices.
...
> When the test runs more than X time (45 sec i guess) the script will
> be killed by the runner script.

In my test environment proc-uptime-001 seems to be passing ~40% (N=10)
of the time,
and taking approximately 0.60 seconds  (~11 seconds / 18 tests).

kselftest is not timing individual targets (maybe it should?),
so I don't have a timing history but it used to pass 100% (N=60) of the time.

> We will add this as known intermittent failure.

Thanks, I'll remove it from my tests.

Data for the numbers above:

for X in $(seq 1 10) ; do echo $X && time make TARGETS="proc"
kselftest | grep -P "ok.*proc-uptime-001" ; done
1
ok 10 selftests: proc: proc-uptime-001

real    0m10.605s
user    0m3.427s
sys    0m7.239s
2
not ok 10 selftests: proc: proc-uptime-001 # exit=134

real    0m10.808s
user    0m3.237s
sys    0m6.614s
3
ok 10 selftests: proc: proc-uptime-001

real    0m10.577s
user    0m3.377s
sys    0m7.269s
4
ok 10 selftests: proc: proc-uptime-001

real    0m12.424s
user    0m3.215s
sys    0m7.402s
5
not ok 10 selftests: proc: proc-uptime-001 # exit=134

real    0m11.101s
user    0m3.257s
sys    0m6.883s
6
not ok 10 selftests: proc: proc-uptime-001 # exit=134

real    0m10.797s
user    0m3.199s
sys    0m6.671s
7
not ok 10 selftests: proc: proc-uptime-001 # exit=134

real    0m12.817s
user    0m3.308s
sys    0m7.177s
8
not ok 10 selftests: proc: proc-uptime-001 # exit=134

real    0m10.816s
user    0m3.201s
sys    0m6.663s
9
not ok 10 selftests: proc: proc-uptime-001 # exit=134

real    0m10.832s
user    0m3.145s
sys    0m6.721s
10
ok 10 selftests: proc: proc-uptime-001

real    0m10.664s
user    0m3.337s
sys    0m7.375s
