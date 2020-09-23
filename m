Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E052761DF
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Sep 2020 22:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgIWUSg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Sep 2020 16:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgIWUSg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Sep 2020 16:18:36 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79D7C0613CE;
        Wed, 23 Sep 2020 13:18:35 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 9B0BA28B795
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Kees Cook <keescook@chromium.org>, tglx@linutronix.de
Cc:     luto@kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, willy@infradead.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v6 1/9] kernel: Support TIF_SYSCALL_INTERCEPT flag
Organization: Collabora
References: <20200904203147.2908430-1-krisman@collabora.com>
        <20200904203147.2908430-2-krisman@collabora.com>
        <202009221243.6BC5635E@keescook>
Date:   Wed, 23 Sep 2020 16:18:26 -0400
In-Reply-To: <202009221243.6BC5635E@keescook> (Kees Cook's message of "Tue, 22
        Sep 2020 12:44:21 -0700")
Message-ID: <874kno6yct.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Fri, Sep 04, 2020 at 04:31:39PM -0400, Gabriel Krisman Bertazi wrote:
>> Convert TIF_SECCOMP into a generic TI flag for any syscall interception
>> work being done by the kernel.  The actual type of work is exposed by a
>> new flag field outside of thread_info.  This ensures that the
>> syscall_intercept field is only accessed if struct seccomp has to be
>> accessed already, such that it doesn't incur in a much higher cost to
>> the seccomp path.
>> 
>> In order to avoid modifying every architecture at once, this patch has a
>> transition mechanism, such that architectures that define TIF_SECCOMP
>> continue to work by ignoring the syscall_intercept flag, as long as they
>> don't support other syscall interception mechanisms like the future
>> syscall user dispatch.  When migrating TIF_SECCOMP to
>> TIF_SYSCALL_INTERCEPT, they should adopt the semantics of checking the
>> syscall_intercept flag, like it is done in the common entry syscall
>> code, or even better, migrate to the common syscall entry code.
>
> Can we "eat" all the other flags like ptrace, audit, etc, too? Doing
> this only for seccomp seems strange.

Hi Kees, Thanks again for the review.

Yes, we can, and I'm happy to follow up with that as part of my TIF
clean up work, but can we not block the current patchset to be merged
waiting for that, as this already grew a lot from the original feature
submission?

Also, Thomas do you mind this approach to reduce the usage of TIF_
flags?  I remember you suggested simply expanding the variable to 64
bits at some point.

Thanks,


-- 
Gabriel Krisman Bertazi
