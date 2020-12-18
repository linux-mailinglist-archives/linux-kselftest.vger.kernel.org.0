Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3092DE2D1
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Dec 2020 13:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgLRM0l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Dec 2020 07:26:41 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59231 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgLRM0l (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Dec 2020 07:26:41 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kqEpZ-0005L6-Dd; Fri, 18 Dec 2020 12:25:57 +0000
Date:   Fri, 18 Dec 2020 13:25:55 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Giuseppe Scrivano <gscrivan@redhat.com>
Subject: Re: [PATCH] selftests/core: fix close_range_test build after XFAIL
 removal
Message-ID: <20201218122555.rlazqtui5pn5wm3u@wittgenstein>
References: <20201218112428.13662-1-tklauser@distanz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201218112428.13662-1-tklauser@distanz.ch>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 18, 2020 at 12:24:28PM +0100, Tobias Klauser wrote:
> XFAIL was removed in commit 9847d24af95c ("selftests/harness: Refactor
> XFAIL into SKIP") and its use in close_range_test was already replaced
> by commit 1d44d0dd61b6 ("selftests: core: use SKIP instead of XFAIL in
> close_range_test.c"). However, commit 23afeaeff3d9 ("selftests: core:
> add tests for CLOSE_RANGE_CLOEXEC") introduced usage of XFAIL in
> TEST(close_range_cloexec). Use SKIP there as well.
> 
> Cc: Giuseppe Scrivano <gscrivan@redhat.com>
> Fixes: 23afeaeff3d9 ("selftests: core: add tests for CLOSE_RANGE_CLOEXEC")
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---

Thanks for this! I already have a fix for this in my tree but I'm
dropping it and taking yours instead.

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Shuah, I'll be taking this through my tree since I'm adding selftests
for a vfs regression fix that I'll be sending before Sunday.

Christian
