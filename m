Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0484E28863A
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Oct 2020 11:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733167AbgJIJnu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Oct 2020 05:43:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53912 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731745AbgJIJnu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Oct 2020 05:43:50 -0400
Received: from [81.92.17.135] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kQowG-0006CR-Tp; Fri, 09 Oct 2020 09:43:49 +0000
Date:   Fri, 9 Oct 2020 11:43:48 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Tommi Rantala <tommi.t.rantala@nokia.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 13/13] selftests: binderfs: use SKIP instead of XFAIL
Message-ID: <20201009094348.zptvlivvepnp2gjv@wittgenstein>
References: <20201008122633.687877-1-tommi.t.rantala@nokia.com>
 <20201008122633.687877-14-tommi.t.rantala@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201008122633.687877-14-tommi.t.rantala@nokia.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 08, 2020 at 03:26:33PM +0300, Tommi Rantala wrote:
> XFAIL is gone since 9847d24af95c ("selftests/harness: Refactor XFAIL
> into SKIP"), use SKIP instead.
> 
> Fixes: 9847d24af95c ("selftests/harness: Refactor XFAIL into SKIP")
> Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
> ---

Thanks!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
