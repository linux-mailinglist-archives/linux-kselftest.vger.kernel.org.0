Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F714862B1
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jan 2022 11:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237676AbiAFKJX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jan 2022 05:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237026AbiAFKJW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jan 2022 05:09:22 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44B8C061212
        for <linux-kselftest@vger.kernel.org>; Thu,  6 Jan 2022 02:09:21 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id j83so5997491ybg.2
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Jan 2022 02:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=xVn1wMxF612KR4qd3v/+ZpMRoNnQHSmut43e76ryAy0=;
        b=ITSjOINvJbz26cSYFmAJMgjh4BRfFhbRo6wnwy0w0oE9bLf+0Y2t4VJqDY8S3TZxNS
         b8sJa7FA2RctFBONM7abZ6GuQ1ycd8lspdoyzuqWJplZYmksStuzrrUslLTN5S25KFtr
         nq1ZBnDqaKYx8p48IzPaRC7vqJfa3wYXIRUpl2VppdcvoEuG94LeC+TdL4G5OzFCAiYC
         nTtuwmfVXH3+c1fy2EvQtpoPX60Lwa6nHOcbUkYcQ6+0le90Wfn/gebH7m37gR98THSl
         0wc77C2e+aWYYvIT2gtJt7Yh1T+Zh3bJJupjfdasvUi/GJESiR6Uh45x1dVnymDr6+ck
         S7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xVn1wMxF612KR4qd3v/+ZpMRoNnQHSmut43e76ryAy0=;
        b=hHscZP4sIILUbaPNlVXS1SOzGkfVsfiGtpxYQM9XQmTWTF7Ytg45ivLC70Voef9vvf
         zwYMIakd2W7mK5aLZ6B51E7oNpOtzWxLO56MjcTnfrqzNwfhn/v9WTVu3DrOKvYtjGO4
         bsVt8F/OLzZ69HUkB62mAlCYM42l396KVIYo9LvTu185NHL/yscQ4NDv6jv4l/RfbFBT
         ww7f70MGhXhjqzDd2uVcTOSDHmdw79nmX6zNYy7AVx10h0Qc/hndKRk0SQNA2Lkyom3A
         ES8Kc88xqPQO8u9xfFgg6ZuosWIo9snFMFVD3Toviz3wBDA+nxJzuCu8PLRG9mwx4fAW
         YBjg==
X-Gm-Message-State: AOAM532WUzUfMTQnbYBsp/qePNBYgshiS4KdC9WsHld7PlGs8cEzC0uq
        R4hV8iH/GmQekdK+9BEvlzjCNQYhMm96D/qbWihxdw==
X-Google-Smtp-Source: ABdhPJyafnvQkHJQjBbud1GeweU7pR4nWug53MC0s3SnkvN9veseeb871oyKcvVs1bCnP7grujMZwj/vGB9np4QEeN0=
X-Received: by 2002:a25:73c7:: with SMTP id o190mr23466905ybc.108.1641463760658;
 Thu, 06 Jan 2022 02:09:20 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 6 Jan 2022 15:39:09 +0530
Message-ID: <CA+G9fYtaoxVF-bL40kt=FKcjjaLUnS+h8hNf=wQv_dKKWn_MNQ@mail.gmail.com>
Subject: txtimestamp.c:164:29: warning: format '0' expects argument of type
 'long unsigned int', but argument 3 has type 'int64_t' {aka 'long long int'} [-Wformat=]
To:     linux-stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Yangbo Lu <yangbo.lu@nxp.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jian Yang <jianyang@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

While building selftests the following warnings were noticed for arm
architecture on Linux stable v5.15.13 kernel and also on Linus's tree.

arm-linux-gnueabihf-gcc -Wall -Wl,--no-as-needed -O2 -g
-I../../../../usr/include/    txtimestamp.c  -o
/home/tuxbuild/.cache/tuxmake/builds/current/kselftest/net/txtimestamp
txtimestamp.c: In function 'validate_timestamp':
txtimestamp.c:164:29: warning: format '0' expects argument of type
'long unsigned int', but argument 3 has type 'int64_t' {aka 'long long
int'} [-Wformat=]
  164 |   fprintf(stderr, "ERROR: 0 us expected between 0 and 0\n",
      |                           ~~^
      |                             |
      |                             long unsigned int
      |                           0
  165 |     cur64 - start64, min_delay, max_delay);
      |     ~~~~~~~~~~~~~~~
      |           |
      |           int64_t {aka long long int}
txtimestamp.c: In function '__print_ts_delta_formatted':
txtimestamp.c:173:22: warning: format '0' expects argument of type
'long unsigned int', but argument 3 has type 'int64_t' {aka 'long long
int'} [-Wformat=]
  173 |   fprintf(stderr, "0 ns", ts_delta);
      |                    ~~^      ~~~~~~~~
      |                      |      |
      |                      |      int64_t {aka long long int}
      |                      long unsigned int
      |                    0
txtimestamp.c:175:22: warning: format '0' expects argument of type
'long unsigned int', but argument 3 has type 'int64_t' {aka 'long long
int'} [-Wformat=]
  175 |   fprintf(stderr, "0 us", ts_delta / NSEC_PER_USEC);
      |                    ~~^
      |                      |
      |                      long unsigned int
      |                    0

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

build link:
https://builds.tuxbuild.com/23HFntxpqyCx0RbiuadfGZ36Kym/

metadata:
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
  git commit: 734eb1fd2073f503f5c6b44f1c0d453ca6986b84
  git describe: v5.15.13
  toolchain: gcc-11
  kernel-config: https://builds.tuxbuild.com/23HFntxpqyCx0RbiuadfGZ36Kym/config


# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake

tuxmake --runtime podman --target-arch arm --toolchain gcc-10 \
 --kconfig https://builds.tuxbuild.com/23HFntxpqyCx0RbiuadfGZ36Kym/config \
  dtbs dtbs-legacy headers kernel kselftest kselftest-merge modules

--
Linaro LKFT
https://lkft.linaro.org
