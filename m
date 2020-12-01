Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96AA12CB10A
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Dec 2020 00:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgLAXra (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Dec 2020 18:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgLAXra (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Dec 2020 18:47:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B746AC0613CF;
        Tue,  1 Dec 2020 15:46:49 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606866407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JgIOpsf5LPtRog4ZlP7P6So7zHuSC1VIRrzzYKueefM=;
        b=f5YY7G1DAL8bRimVjlZA6B3TVNlcO4rPU/jpUj6oSkaTIYj4KJ0LrJAGaUogg6Jaur6Ioh
        3Am8yAABYiatEx0YuSAXnACslJd0HVAsSubi99TL18q1HW/XlAh0orhFWAPa5m6nHsRPOp
        bR+7h/Oz96i9S8bOu8FJwi+qwLU9ZW80gcXbqFSB6To8fYmr5Vt2Ou5Cbpas4CP1Ksdw0N
        +m7Oz3BCuPvuiHx7VJsRjOA7/nI56dKz7U8xrII7OEFou8jGf8A/G7DGRH+jGQoinz/SaH
        Cg7x0knOEGf+0DvjAan5IM5jrpxGlgkD+fBiid4UBwaiSvYtymeurfqI/HJoNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606866407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JgIOpsf5LPtRog4ZlP7P6So7zHuSC1VIRrzzYKueefM=;
        b=ADs6QvH5URJ+Rn5saeUG17RwepRbFMdHYbkzOVewg4UtdAka84q/I3FHV19M5KWyluJF4/
        ac/guvANx/UcxABA==
To:     Jonathan Corbet <corbet@lwn.net>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     luto@kernel.org, keescook@chromium.org, gofmanp@gmail.com,
        christian.brauner@ubuntu.com, peterz@infradead.org,
        willy@infradead.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org, x86@kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v8 7/7] docs: Document Syscall User Dispatch
In-Reply-To: <20201201152119.3654ba61@lwn.net>
References: <20201127193238.821364-1-krisman@collabora.com> <20201127193238.821364-8-krisman@collabora.com> <20201201152119.3654ba61@lwn.net>
Date:   Wed, 02 Dec 2020 00:46:47 +0100
Message-ID: <874kl5f5so.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 01 2020 at 15:21, Jonathan Corbet wrote:
> On Fri, 27 Nov 2020 14:32:38 -0500
> Gabriel Krisman Bertazi <krisman@collabora.com> wrote:
>
>> Explain the interface, provide some background and security notes.
>> 
>> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> Nice to see documentation included...:)  One nit:
>> ---
>> Changes since v7:
>>   - Change process -> thread (Florian Weimer)
>>   - Drop bogus reference to CONFIG_SYSCALL_USER_DISPATCH (me)
>>   - Document the interval as a half-open interval (me)
>> ---
>>  .../admin-guide/syscall-user-dispatch.rst     | 87 +++++++++++++++++++
>>  1 file changed, 87 insertions(+)
>>  create mode 100644 Documentation/admin-guide/syscall-user-dispatch.rst
>
> You need to add this file to index.rst in that directory as well so it
> gets included in the docs build.

Fixed that already after trying to build it :)
