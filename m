Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2481278DE0
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Sep 2020 18:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbgIYQQA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Sep 2020 12:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbgIYQP7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Sep 2020 12:15:59 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9498C0613CE;
        Fri, 25 Sep 2020 09:15:59 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 9F94829D78D
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>, luto@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        willy@infradead.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, kernel@collabora.com
Subject: Re: [PATCH v6 1/9] kernel: Support TIF_SYSCALL_INTERCEPT flag
Organization: Collabora
References: <20200904203147.2908430-1-krisman@collabora.com>
        <20200904203147.2908430-2-krisman@collabora.com>
        <202009221243.6BC5635E@keescook> <874kno6yct.fsf@collabora.com>
        <202009231349.4A25EAF@keescook>
        <87o8luuvze.fsf@nanos.tec.linutronix.de>
Date:   Fri, 25 Sep 2020 12:15:54 -0400
In-Reply-To: <87o8luuvze.fsf@nanos.tec.linutronix.de> (Thomas Gleixner's
        message of "Fri, 25 Sep 2020 10:00:21 +0200")
Message-ID: <87k0whsuh1.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> On Wed, Sep 23 2020 at 13:49, Kees Cook wrote:
>> On Wed, Sep 23, 2020 at 04:18:26PM -0400, Gabriel Krisman Bertazi wrote:
>>> Kees Cook <keescook@chromium.org> writes:
>>> Yes, we can, and I'm happy to follow up with that as part of my TIF
>>> clean up work, but can we not block the current patchset to be merged
>>> waiting for that, as this already grew a lot from the original feature
>>> submission?
>>
>> In that case, I'd say just add the new TIF flag. The consolidation can
>> come later.
>
> No. This is exactly the wrong order. Cleanup and consolidation have
> precedence over features. I'm tired of 'we'll do that later' songs,
> simply because in the very end I'm going to be the idiot who mops up the
> resulting mess.
>

No problem.  I will follow up with a patchset consolidating those flags
into this syscall_intercept interface I proposed.  I assume there is no
immediate concerns with the consolidation approach itself.

-- 
Gabriel Krisman Bertazi
