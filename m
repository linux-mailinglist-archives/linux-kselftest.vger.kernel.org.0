Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7C60105649
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2019 17:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfKUQAW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Nov 2019 11:00:22 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38333 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUQAW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Nov 2019 11:00:22 -0500
Received: by mail-wr1-f67.google.com with SMTP id i12so5073004wro.5
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Nov 2019 08:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:message-id:subject:mime-version;
        bh=O0e6oC+dc+C6T07uVJ3h9cKzgYkiR7jOH6Iaxjd1HVg=;
        b=X23ZzNYLas/XuQg+bFpRScfCUAlmWIIIe/GnD0EPDy93P2Ia1BFrpmpO5yh8WA7py3
         sUFef9Cfd7uKscC8mEAhQ9mbwnd7KrIobLvdQIJDb4EquQ8aZa1GCGH28LuCD2kF94aw
         3BaKK3v7xq+oqxhiK7IdC90iBkXPRwShnJ2+dm/qyAdoZBj0n/kC3eKZiTEzz5DHE32r
         0X64DvxWTjl/Js6JMsTc7IzQBcDV+EQjx5FBIPUxzrRZpTcIlhPH1OD/53/JZ/B6dchu
         JGoMyxamPJjI7P1PdKFcbM7vapIfHbUeUMUR83wNxDfLM21M6gpK47gmQ7QEal/ZviUJ
         VFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:message-id:subject:mime-version;
        bh=O0e6oC+dc+C6T07uVJ3h9cKzgYkiR7jOH6Iaxjd1HVg=;
        b=uW0EoUbg4k94sQ4s4Un3UIHfmewLiFWT9u8XHDSFwws89PJijX27Hy5cO3Vp18Q+bl
         qvMq9dtJo/0S6wCZMJtuol4OB2pG6vWTFdIzCe0yvcBLoeSlliRmho7AtxAigi6BBXld
         6IiJGlc5HN1xiTT6ZLQ64MpTeh0c5SUG4qA/sWgGtrGj6VZSp1IFa5CjzMBBfAkjhmKc
         JmEpqqpR1h87djjZfXcVu1smwM8JVytV3QNUU3upgRZCoDViJerDt8gdCCqtMFViuP9y
         6GBpvwhXH1gd2bKm2A0R3JrD+iRTN2mfBu6c6eaDvSSq2Wd9WO5+86D6Q9tzczdeiNCl
         9+Rw==
X-Gm-Message-State: APjAAAVY/ROLMtk8dtOBsVGPo2YbYh+XGhEPByv9uHN1QOTim9Cd6zIN
        Yy/ycu9H+S1GY3oPR8lOBZtjBQ==
X-Google-Smtp-Source: APXvYqwagULip2yj5oGSW4gvVHly6sHUkhL72UCmnaeSS38e5f+QKcjO1hsn/mKCusVH83svMV6a/A==
X-Received: by 2002:a5d:678c:: with SMTP id v12mr11619820wru.116.1574352020608;
        Thu, 21 Nov 2019 08:00:20 -0800 (PST)
Received: from 172.17.0.4 (ci.linaro.org. [88.99.136.175])
        by smtp.gmail.com with ESMTPSA id o7sm2349790wrv.63.2019.11.21.08.00.19
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Nov 2019 08:00:20 -0800 (PST)
From:   ci_notify@linaro.org
X-Google-Original-From: linaro-infrastructure-errors@lists.linaro.org
Date:   Thu, 21 Nov 2019 16:00:19 +0000 (UTC)
To:     lkft-triage@lists.linaro.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, naresh.kamboju@linaro.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Message-ID: <369224957.1857.1574352020003.JavaMail.javamailuser@localhost>
Subject: next-20191121 kselftest results
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_1856_393805633.1574352019350"
X-Jenkins-Job: LKFT Notify kselftest on next
X-Jenkins-Result: SUCCESS
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

------=_Part_1856_393805633.1574352019350
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Summary
------------------------------------------------------------------------
kernel: 5.4.0-rc8
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git branch: master
git commit: 9942eae47585ee056b140bbfa306f6a1d6b8f383
git describe: next-20191121
Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20191121

Regressions (compared to build next-20191120)
------------------------------------------------------------------------
No regressions                                                                                                          
                                                                                                                       
Fixes (compared to build next-20191120)                                                                   
------------------------------------------------------------------------                                               
No fixes

In total:
------------------------------------------------------------------------
Ran 51 total tests in the following environments and test suites.
pass 9
fail 42
xfail 0
skip 0

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- qemu_arm64
- qemu_x86_64
- x15 - arm
- x86_64

Test Suites
-----------
* kselftest


Failures
------------------------------------------------------------------------

dragonboard-410c:
* kselftest/arm64_fake_sigreturn_bad_magic
* kselftest/arm64_fake_sigreturn_bad_size
* kselftest/arm64_fake_sigreturn_bad_size_for_magic0
* kselftest/arm64_fake_sigreturn_duplicated_fpsimd
* kselftest/arm64_fake_sigreturn_misaligned_sp
* kselftest/arm64_fake_sigreturn_missing_fpsimd
* kselftest/arm64_mangle_pstate_invalid_compat_toggle
* kselftest/arm64_mangle_pstate_invalid_daif_bits
* kselftest/arm64_mangle_pstate_invalid_mode_el1h
* kselftest/arm64_mangle_pstate_invalid_mode_el1t
* kselftest/arm64_mangle_pstate_invalid_mode_el2h
* kselftest/arm64_mangle_pstate_invalid_mode_el2t
* kselftest/arm64_mangle_pstate_invalid_mode_el3h
* kselftest/arm64_mangle_pstate_invalid_mode_el3t

hi6220-hikey:
* kselftest/arm64_fake_sigreturn_bad_magic
* kselftest/arm64_fake_sigreturn_bad_size
* kselftest/arm64_fake_sigreturn_bad_size_for_magic0
* kselftest/arm64_fake_sigreturn_duplicated_fpsimd
* kselftest/arm64_fake_sigreturn_misaligned_sp
* kselftest/arm64_fake_sigreturn_missing_fpsimd
* kselftest/arm64_mangle_pstate_invalid_compat_toggle
* kselftest/arm64_mangle_pstate_invalid_daif_bits
* kselftest/arm64_mangle_pstate_invalid_mode_el1h
* kselftest/arm64_mangle_pstate_invalid_mode_el1t
* kselftest/arm64_mangle_pstate_invalid_mode_el2h
* kselftest/arm64_mangle_pstate_invalid_mode_el2t
* kselftest/arm64_mangle_pstate_invalid_mode_el3h
* kselftest/arm64_mangle_pstate_invalid_mode_el3t

x15:

i386:

x86:

qemu_arm64:
* kselftest/arm64_fake_sigreturn_bad_magic
* kselftest/arm64_fake_sigreturn_bad_size
* kselftest/arm64_fake_sigreturn_bad_size_for_magic0
* kselftest/arm64_fake_sigreturn_duplicated_fpsimd
* kselftest/arm64_fake_sigreturn_misaligned_sp
* kselftest/arm64_fake_sigreturn_missing_fpsimd
* kselftest/arm64_mangle_pstate_invalid_compat_toggle
* kselftest/arm64_mangle_pstate_invalid_daif_bits
* kselftest/arm64_mangle_pstate_invalid_mode_el1h
* kselftest/arm64_mangle_pstate_invalid_mode_el1t
* kselftest/arm64_mangle_pstate_invalid_mode_el2h
* kselftest/arm64_mangle_pstate_invalid_mode_el2t
* kselftest/arm64_mangle_pstate_invalid_mode_el3h
* kselftest/arm64_mangle_pstate_invalid_mode_el3t


Skips
------------------------------------------------------------------------
No skips


-- 
Linaro LKFT
https://lkft.linaro.org
------=_Part_1856_393805633.1574352019350--
