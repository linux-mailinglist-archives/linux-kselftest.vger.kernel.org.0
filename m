Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2B2222CAE
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jul 2020 22:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgGPUWl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jul 2020 16:22:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38877 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgGPUWl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jul 2020 16:22:41 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jwAOp-0006ue-Ci; Thu, 16 Jul 2020 20:22:35 +0000
Date:   Thu, 16 Jul 2020 22:22:34 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Andy Lutomirski <luto@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        gofmanp@gmail.com, linux-api@vger.kernel.org, x86@kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org, jannh@google.com
Subject: Re: [PATCH v4 0/2] Syscall User Redirection
Message-ID: <20200716202234.wryj7pj7zmwcrxxx@wittgenstein>
References: <20200716193141.4068476-1-krisman@collabora.com>
 <202007161300.7452A2C5@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202007161300.7452A2C5@keescook>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 16, 2020 at 01:04:38PM -0700, Kees Cook wrote:
> On Thu, Jul 16, 2020 at 03:31:39PM -0400, Gabriel Krisman Bertazi wrote:
> > This is v4 of Syscall User Redirection.  The implementation itself is
> > not modified from v3, it only applies the latest round of reviews to the
> > selftests.
> > 
> > __NR_syscalls is not really exported in header files other than
> > asm-generic for every architecture, so it felt safer to optionally
> > expose it with a fallback to a high value.
> > 
> > Also, I didn't expose tests for PR_GET as that is not currently
> > implemented.  If possible, I'd have it supported by a future patchset,
> > since it is not immediately necessary to support this feature.
> 
> Thanks! That all looks good to me.

Don't have any problem with this but did this ever get exposure on
linux-api? This is the first time I see this pop up.

Christian
