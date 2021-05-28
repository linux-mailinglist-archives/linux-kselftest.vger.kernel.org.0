Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3E7394653
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 May 2021 19:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhE1RVz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 May 2021 13:21:55 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:42272 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhE1RVy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 May 2021 13:21:54 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id CEB1D72C8B5;
        Fri, 28 May 2021 20:20:18 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 9330C4A46E8;
        Fri, 28 May 2021 20:20:18 +0300 (MSK)
Date:   Fri, 28 May 2021 20:20:17 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kselftest@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: tools/testing/selftests/ptrace/vmaccess.c hangs
Message-ID: <20210528172017.gsvm66ux3cruavh6@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

Possible ptrace related bug in tools/testing/selftests/ptrace/vmaccess.c -
it timeout every time I run it on any kernel I try, in vm or bare metal.

Does it run correctly for anybody?

Example vmaccess from v5.12 source tree run on 5.13.0+rc2 on bare metal
Supermicro server (AMD EPYC):

  5.10.35-rt-alt1.rt39:~# /usr/lib/kselftests/ptrace/vmaccess
  TAP version 13
  1..2
  # Starting 2 tests from 1 test cases.
  #  RUN           global.vmaccess ...
  #            OK  global.vmaccess
  ok 1 global.vmaccess
  #  RUN           global.attach ...
  # attach: Test terminated by timeout
  #          FAIL  global.attach
  not ok 2 global.attach
  # FAILED: 1 / 2 tests passed.
  # Totals: pass:1 fail:1 xfail:0 xpass:0 skip:0 error:0

Just to confirm for the latest kernel, it behaves the same [for drm-tip
based] on 5.13rc2. Also, just tested on 5.11.21 with the same failure.

Other ptrace tests pass.

Thanks,

