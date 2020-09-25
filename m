Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE71278220
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Sep 2020 10:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgIYIAZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Sep 2020 04:00:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54494 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbgIYIAZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Sep 2020 04:00:25 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601020823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A7tZCaYWus9D2ZS4daJYEMgBfuoBYxyWLPGiZSLMXaY=;
        b=s0CdCqEVfAgOYDqpHWHxDBGEKwSHX+1gkF5gQASiD2bmpXqe9VQdR5ae6y2w+5VoqzjcuJ
        YRCydyDRW8j2IcQU2v28TVTfy8PpS4aHvPXbd4dLdA5qJC0I7TZDzukKW0QhmbAXe5SJ4W
        6fVDMo5Dv/RvVMI1fgkyuERnBHmbxTNCNh9NvxzlQpNK/y38IMi/SydTOG04ilX8tbcp5L
        uaSQMYUkjxepoQxarE4in0DGKjSpHWYtI1iXYNCZrL++C5lO2nMW9d00yjvMzxSh2k+q+5
        Z2rGL/savL5yayxjT84r+gaFJy38DyhQ79xtIS44aK/MXM9d5gmm84Na1mjZRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601020823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A7tZCaYWus9D2ZS4daJYEMgBfuoBYxyWLPGiZSLMXaY=;
        b=MD8ejMcwGoLzfPtsVHTldRLXKZseJkJfn7HfyFevNDP1cROrhEJ9LqOV8G7BI5BtPPrUz9
        8iNRm1Weh5PRYgDg==
To:     Kees Cook <keescook@chromium.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     luto@kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, willy@infradead.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v6 1/9] kernel: Support TIF_SYSCALL_INTERCEPT flag
In-Reply-To: <202009231349.4A25EAF@keescook>
References: <20200904203147.2908430-1-krisman@collabora.com> <20200904203147.2908430-2-krisman@collabora.com> <202009221243.6BC5635E@keescook> <874kno6yct.fsf@collabora.com> <202009231349.4A25EAF@keescook>
Date:   Fri, 25 Sep 2020 10:00:21 +0200
Message-ID: <87o8luuvze.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 23 2020 at 13:49, Kees Cook wrote:
> On Wed, Sep 23, 2020 at 04:18:26PM -0400, Gabriel Krisman Bertazi wrote:
>> Kees Cook <keescook@chromium.org> writes:
>> Yes, we can, and I'm happy to follow up with that as part of my TIF
>> clean up work, but can we not block the current patchset to be merged
>> waiting for that, as this already grew a lot from the original feature
>> submission?
>
> In that case, I'd say just add the new TIF flag. The consolidation can
> come later.

No. This is exactly the wrong order. Cleanup and consolidation have
precedence over features. I'm tired of 'we'll do that later' songs,
simply because in the very end I'm going to be the idiot who mops up the
resulting mess.

Thanks,

        tglx
