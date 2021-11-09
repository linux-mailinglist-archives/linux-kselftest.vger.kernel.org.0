Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDDD44AFF3
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Nov 2021 16:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbhKIPEU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Nov 2021 10:04:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:33658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234372AbhKIPEP (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Nov 2021 10:04:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9008C61051;
        Tue,  9 Nov 2021 15:01:26 +0000 (UTC)
Date:   Tue, 9 Nov 2021 16:01:22 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     shuah@kernel.org, christian@brauner.io, nathan@kernel.org,
        ndesaulniers@google.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] selftests: cgroup: build error multiple outpt files
Message-ID: <20211109150122.fbqcrnbtgtas5jid@wittgenstein>
References: <20211105162530.3307666-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211105162530.3307666-1-anders.roxell@linaro.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 05, 2021 at 05:25:29PM +0100, Anders Roxell wrote:
> When building selftests/cgroup: with clang the following error are seen:
> 
> clang -Wall -pthread    test_memcontrol.c cgroup_util.c ../clone3/clone3_selftests.h  -o /home/anders/.cache/tuxmake/builds/current/kselftest/cgroup/test_memcontrol
> clang: error: cannot specify -o when generating multiple output files
> make[3]: *** [../lib.mk:146: /home/anders/.cache/tuxmake/builds/current/kselftest/cgroup/test_memcontrol] Error 1
> 
> Rework to add the header files to LOCAL_HDRS before including ../lib.mk,
> since the dependency is evaluated in '$(OUTPUT)/%:%.c $(LOCAL_HDRS)' in
> file lib.mk.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---

Thanks!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
