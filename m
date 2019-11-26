Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A159109829
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2019 04:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfKZDzO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Nov 2019 22:55:14 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34394 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbfKZDzO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Nov 2019 22:55:14 -0500
Received: by mail-lj1-f194.google.com with SMTP id m6so11083095ljc.1
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Nov 2019 19:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=jpmKSRiJVeUJXgN2GyGxen55p/yccWN0FKHO19CAFVE=;
        b=JwQ9vdguWg5+4q7zWM3b3iwlCGcQyETozpN0qTWBy1n+SIvu6IuTh4PzsmCTjlJ+0/
         vgvWl87TrHHTQa6vC8mNoRlpPChfMs+6p22CdKCnzJhz7OXNvyk06CUt+sgaa5wmwDN/
         HZAeuxcl4TDfonIGK2AbNGOcy8LhR7W+rHHO+yejgVi4Ae9TREnR4RefDWdX5+Fit38e
         7pd1Ncqyf7+PeHOCsNufeDQ97KClKn7IbYIhGAEPmf044FcyAPBHip0l7jo3ntZYbHFg
         QEq+JvMRubVcAPsrcd/C18LevU4Vc/HV5jciRxtzQLleSIWwM2cxRR4PnkIt6z7YJQiG
         dHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=jpmKSRiJVeUJXgN2GyGxen55p/yccWN0FKHO19CAFVE=;
        b=rJwQIC6po6E0DxPGUFQ1JDsHKRFMrbDul7NZ0zhKpTV+eqNr1zBdSTzWRAgL4IhyAU
         uhMxRW+8yaUBSXTdSx9AG2jjYZYdb+o4iT9koKLq+qhbBMBC/Zdd0urTr8SwwrvgW4if
         p692drH18j0vjXzpI4J1YgJiDKLxLdBW6hUgKyUw/GNzmp7W3wydKAZKSFxzz9A5Ta1E
         mem4pul1+0F4EPZoiMcpq359X2wYi7J3S8D3OSGblfJpCf6k6zSF1KVHUy0DQHEXbz2A
         Afnk9qebGINJJnFL1XI3tvKbRDK+xYMKvZnwZ2dCp+yoOtpyu98JxY0q9ChB8sOnVoVp
         6Ouw==
X-Gm-Message-State: APjAAAXZXMs2C3UHLhNIkp7stkDkSM+Dr8ZseG8vLS4CqMOXhk68EtgR
        WwdVadsz0y4Y5LRwm28LL6bb5jmExJpAEgi4WrK8awtJVIA=
X-Google-Smtp-Source: APXvYqwih9V2svwM3xs4eurIBFbf6d9bvsSgmgrySI1N9FoXlgeJnNmdzyuRtdiRGPGmNmD52iZje5jLyLG8MxDGmO8=
X-Received: by 2002:a2e:a410:: with SMTP id p16mr24801147ljn.46.1574740511113;
 Mon, 25 Nov 2019 19:55:11 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 26 Nov 2019 09:25:00 +0530
Message-ID: <CA+G9fYtgEfa=bq5C8yZeF6P563Gw3Fbs+-h_oy1e4G_1G0jrgw@mail.gmail.com>
Subject: selftests:netfilter: nft_nat.sh: internal00-0 Error Could not open
 file \"-\" No such file or directory
To:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, pablo@netfilter.org, fw@strlen.de,
        jeffrin@rajagiritech.edu.in, horms@verge.net.au,
        yanhaishuang@cmss.chinamobile.com, lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Do you see the following error while running selftests netfilter
nft_nat.sh test ?
Are we missing any kernel config fragments ? We are merging configs
from the directory.

# selftests netfilter nft_nat.sh
netfilter: nft_nat.sh_ #
# Cannot create namespace file \"/var/run/netns/ns1\" File exists
create: namespace_file #
# internal00-0 Error Could not open file \"-\" No such file or directory
Error: Could_not #
#
: _ #
#
: _ #
# internal00-0 Error Could not open file \"-\" No such file or directory
Error: Could_not #
#
: _ #
#
: _ #
# internal00-0 Error Could not open file \"-\" No such file or directory
Error: Could_not #
#
: _ #
#
: _ #
# <cmdline>16-12 Error syntax error, unexpected counter
Error: syntax_error, #
# list counter inet filter ns0in
counter: inet_filter #
#      ^^^^^^^
: _ #
# ERROR ns0in counter in ns1 has unexpected value (expected packets 1 bytes 84)
ns0in: counter_in #
# <cmdline>16-12 Error syntax error, unexpected counter
Error: syntax_error, #
# list counter inet filter ns0in
counter: inet_filter #
#      ^^^^^^^
: _ #
# <cmdline>16-12 Error syntax error, unexpected counter


Full test log:
https://lkft.validation.linaro.org/scheduler/job/1021542#L14602
https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20191125/testrun/1021542/log

Dashboard link,
https://qa-reports.linaro.org/lkft/linux-mainline-oe/tests/kselftest/netfilter_nft_nat.sh
https://qa-reports.linaro.org/lkft/linux-next-oe/tests/kselftest/netfilter_nft_nat.sh

metadata:
  git branch: master
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git commit: c165016bac2719e05794c216f9b6da730d68d1e3
  git describe: next-20191125
  make_kernelversion: 5.4.0-rc8
  kernel-config:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/hikey/lkft/linux-next/653/config
  build-location:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/hikey/lkft/linux-next/653

Best regards
Naresh Kamboju
