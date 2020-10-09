Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408ED288849
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Oct 2020 14:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732995AbgJIMHT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Oct 2020 08:07:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57156 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730726AbgJIMHT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Oct 2020 08:07:19 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kQrB7-0008Oj-Q5; Fri, 09 Oct 2020 12:07:17 +0000
Date:   Fri, 9 Oct 2020 14:07:17 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Tommi Rantala <tommi.t.rantala@nokia.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH 00/13] selftests fixes
Message-ID: <20201009120717.qerrilcv4tp53on4@wittgenstein>
References: <20201008122633.687877-1-tommi.t.rantala@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201008122633.687877-1-tommi.t.rantala@nokia.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 08, 2020 at 03:26:20PM +0300, Tommi Rantala wrote:
> Hi, small fixes to issues I hit with selftests.
> 
> Tommi Rantala (13):
>   selftests: filter kselftest headers from command in lib.mk
>   selftests: pidfd: fix compilation errors due to wait.h
>   selftests: add vmaccess to .gitignore
>   selftests/harness: prettify SKIP message whitespace again
>   selftests: pidfd: use ksft_test_result_skip() when skipping test
>   selftests: pidfd: skip test on kcmp() ENOSYS
>   selftests: pidfd: add CONFIG_CHECKPOINT_RESTORE=y to config
>   selftests: pidfd: drop needless linux/kcmp.h inclusion in
>     pidfd_setns_test.c
>   selftests: android: fix multiple definition of sock_name
>   selftests: proc: fix warning: _GNU_SOURCE redefined
>   selftests: core: use SKIP instead of XFAIL in close_range_test.c
>   selftests: clone3: use SKIP instead of XFAIL
>   selftests: binderfs: use SKIP instead of XFAIL

This mostly deals with stuff I maintain but it can go via the selftest
tree, thanks!

Christian
