Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A8E28883A
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Oct 2020 14:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732456AbgJIMDm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Oct 2020 08:03:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57010 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgJIMDm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Oct 2020 08:03:42 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kQr7c-00083q-DF; Fri, 09 Oct 2020 12:03:40 +0000
Date:   Fri, 9 Oct 2020 14:03:39 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Tommi Rantala <tommi.t.rantala@nokia.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH 05/13] selftests: pidfd: use ksft_test_result_skip() when
 skipping test
Message-ID: <20201009120339.vcg6vds2frawu7b6@wittgenstein>
References: <20201008122633.687877-1-tommi.t.rantala@nokia.com>
 <20201008122633.687877-6-tommi.t.rantala@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201008122633.687877-6-tommi.t.rantala@nokia.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 08, 2020 at 03:26:25PM +0300, Tommi Rantala wrote:
> There's planned tests != run tests in pidfd_test when some test is
> skipped:
> 
>   $ ./pidfd_test
>   TAP version 13
>   1..8
>   [...]
>   # pidfd_send_signal signal recycled pid test: Skipping test
>   # Planned tests != run tests (8 != 7)
>   # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Fix by using ksft_test_result_skip():
> 
>   $ ./pidfd_test
>   TAP version 13
>   1..8
>   [...]
>   ok 8 # SKIP pidfd_send_signal signal recycled pid test: Unsharing pid namespace not permitted
>   # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:1 error:0
> 
> Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
> ---

Thanks, I never got around to fixing this myself.
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
