Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A296F173888
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2020 14:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgB1NmA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Feb 2020 08:42:00 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48090 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgB1NmA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Feb 2020 08:42:00 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j7fts-0002rn-Jc; Fri, 28 Feb 2020 13:41:56 +0000
Date:   Fri, 28 Feb 2020 14:41:55 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Christian Kellner <christian@kellner.me>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: pidfd: Add pidfd_fdinfo_test in .gitignore
Message-ID: <20200228134155.2rzxeqwrlofmtre4@wittgenstein>
References: <966567c7dbaa26a06730d796354f8a086c0ee288.1582847778.git.christophe.leroy@c-s.fr>
 <DB631DFB-DF8B-4B95-AC50-74F1ED733CAE@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DB631DFB-DF8B-4B95-AC50-74F1ED733CAE@ubuntu.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 28, 2020 at 01:18:44AM +0100, Christian Brauner wrote:
> On February 28, 2020 1:00:08 AM GMT+01:00, Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> >The commit identified below added pidfd_fdinfo_test
> >but failed to add it to .gitignore
> >
> >Fixes: 2def297ec7fb ("pidfd: add tests for NSpid info in fdinfo")
> >Cc: stable@vger.kernel.org
> >Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> >---
> > tools/testing/selftests/pidfd/.gitignore | 1 +
> > 1 file changed, 1 insertion(+)
> >
> >diff --git a/tools/testing/selftests/pidfd/.gitignore
> >b/tools/testing/selftests/pidfd/.gitignore
> >index 3a779c084d96..39559d723c41 100644
> >--- a/tools/testing/selftests/pidfd/.gitignore
> >+++ b/tools/testing/selftests/pidfd/.gitignore
> >@@ -2,4 +2,5 @@ pidfd_open_test
> > pidfd_poll_test
> > pidfd_test
> > pidfd_wait
> >+pidfd_fdinfo_test
> > pidfd_getfd_test
> 
> Thanks for spotting this.
> I'll pick this up along with other fixes I have waiting.
> 
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Applied, thanks!
Christian
