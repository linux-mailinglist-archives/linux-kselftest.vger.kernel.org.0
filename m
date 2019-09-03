Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9A6A6AA3
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2019 16:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfICOAa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Sep 2019 10:00:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33444 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfICOA3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Sep 2019 10:00:29 -0400
Received: by mail-wr1-f65.google.com with SMTP id u16so17646980wrr.0
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Sep 2019 07:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:message-id:subject:mime-version;
        bh=v+D7sRxJDsgl0H2Mipyfx2rLnZbA6lhTUPJHn7sstls=;
        b=kvDF20iN8hJ61/KbyVYQaU03ORRG8PTQO8XwAe1J66j/ABt5XCxrw+OdF773467CGo
         lpIqwnrRAp4uV1quPMoQHHyGq+cV1PgMAX31vlLQiOF6/YbMAFmHMepyRgaSpJ0lbrkK
         rn61Ve9I0ncxdNuIZNrClaRyVqYOReFucQ2H69Fu/RkyxLgHY0dX5HkW+aZMpya9Yozm
         6cN9AKThE9KzSVJuGAPRc5JClcJ52OhU+46xI/pm4DNGbKF78cdCRbkz8MKbfA5jxzkE
         2jvUVEtj7EBpdY/EOhXkLFB73O6bnByPB5XX+z0Hv7Kkxyap4viEJCgKZT387f2968vf
         ijjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:message-id:subject:mime-version;
        bh=v+D7sRxJDsgl0H2Mipyfx2rLnZbA6lhTUPJHn7sstls=;
        b=Qd6GUPQCVgKwpx0Awk83IsqPfbIqn4o91GtsDuObgyh8F+2kEfzgzQ2X5D5HBuHa5R
         mFoWGekU6f5StXd86wCkfE2kL3vSX9AR8JvokU4q7UCY6Z2JcnDeOZeNYVcfgXTYOm2N
         s5AyDKl6jd3r2ds+ucrX0RRMBpxBOWEVFMF9KfHBZo6e2ReyyMDKSrZIFvr0ndwc8DUN
         mcBGVS74nYu0MYFkGw/nyb2LnQB93d0g4y17GobGkl8VDWR+hi46SK5pPxiloZnhwuXQ
         zRHzhQt0f8a9k9UE8Bb0rO2MY/A78YtaEggX5r6FfEa1qFqQ/avpuO3/dfPHLCN9zRRX
         x9NQ==
X-Gm-Message-State: APjAAAUppq6XXq1FxoUGEVnvJNqj0rW3uUTmrwArpfOi4Zo7eJR+iaPr
        VnQoLPTKuyNhW/h0XhONnAz3KQ==
X-Google-Smtp-Source: APXvYqw47E/VCbGg4z8f/13fA2by3bbIYAImpRgsrlR3e9K550LD1FsCgMK/128wkyNMmZdemmftsw==
X-Received: by 2002:a5d:40cd:: with SMTP id b13mr819011wrq.236.1567519227393;
        Tue, 03 Sep 2019 07:00:27 -0700 (PDT)
Received: from jenkins (ci.linaro.org. [88.99.136.175])
        by smtp.gmail.com with ESMTPSA id t22sm14535289wmi.11.2019.09.03.07.00.25
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Sep 2019 07:00:26 -0700 (PDT)
From:   ci_notify@linaro.org
X-Google-Original-From: linaro-infrastructure-errors@lists.linaro.org
Date:   Tue, 3 Sep 2019 14:00:25 +0000 (UTC)
To:     lkft-triage@lists.linaro.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, naresh.kamboju@linaro.org,
        linux-kselftest@vger.kernel.org
Message-ID: <943338456.3594.1567519226589.JavaMail.javamailuser@localhost>
Subject: next-20190903 kselftest results
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_3593_1393400232.1567519225617"
X-Jenkins-Job: LKFT Notify kselftest on next
X-Jenkins-Result: SUCCESS
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

------=_Part_3593_1393400232.1567519225617
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Summary
------------------------------------------------------------------------
kernel: 5.3.0-rc7
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git branch: master
git commit: 7dc4585e03786f84d6e9dc16caa3ba5b8b44d986
git describe: next-20190903
Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20190903

Regressions (compared to build next-20190902)
------------------------------------------------------------------------
No regressions                                                                                                          
                                                                                                                       
Fixes (compared to build next-20190902)                                                                   
------------------------------------------------------------------------                                               
No fixes

In total:
------------------------------------------------------------------------
Ran 12 total tests in the following environments and test suites.
pass 0
fail 12
xfail 0
skip 0

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15 - arm
- x86_64

Test Suites
-----------
* boot-lkft-kselftests-master-598
* boot-lkft-kselftests-vsyscall-mode-native-master-598
* boot-lkft-kselftests-vsyscall-mode-none-master-598


Failures
------------------------------------------------------------------------

i386:
* boot-lkft-kselftests-master-598/x86

juno-r2:
* boot-lkft-kselftests-master-598/juno-r2

qemu_x86_64:
* boot-lkft-kselftests-master-598/qemu

x86:
* boot-lkft-kselftests-vsyscall-mode-none-master-598/x86
* boot-lkft-kselftests-vsyscall-mode-native-master-598/x86
* boot-lkft-kselftests-master-598/x86

qemu_i386:
* boot-lkft-kselftests-master-598/qemu

qemu_arm:
* boot-lkft-kselftests-master-598/qemu-arm

x15:
* boot-lkft-kselftests-master-598/x15

dragonboard-410c:
* boot-lkft-kselftests-master-598/dragonboard-410c

hi6220-hikey:
* boot-lkft-kselftests-master-598/hi6220-hikey-r2

qemu_arm64:
* boot-lkft-kselftests-master-598/qemu-arm


Skips
------------------------------------------------------------------------
No skips


-- 
Linaro LKFT
https://lkft.linaro.org
------=_Part_3593_1393400232.1567519225617--
