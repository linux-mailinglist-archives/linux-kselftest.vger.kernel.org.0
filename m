Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89AD6D00FF
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Mar 2023 12:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjC3KUU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Mar 2023 06:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjC3KUT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Mar 2023 06:20:19 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04BF76A4
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Mar 2023 03:20:18 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id p203so22754665ybb.13
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Mar 2023 03:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680171618;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M4Y2U0FWvmSoCA4G791gIQlcGTXzfS+ytaj/vB6IHj8=;
        b=YzxQCOnQFjFHPUjiapHw1RtYtsdvQdPN9v+tXcPIS8UgOpqCidJeCqzRCoOxLn3BZ5
         Spve3FZJlZiXCi3Rz2NLamEsPHmxoFXwq2+BFSrZv82KUrB2/Ml/7TgR7hRm+st0nLSb
         r8/ze+iW/xBgo+IR6IYZOXddoScuqFfLqsgRr+NDG7AOZ741o+ut7cQ4aPY2PFRh1tn5
         mLjb8oaVi2SZsWMThZOlJ9pb/BhhDStv/pyj4PNPCUtKDqfpws24Z5wwtyI2ZWWxFLqF
         nCLA40uJZ1X2TIiVmQ8ClUP7NdA8yteoU95pscy84u8anP3Op0ZEGt+T3M1M0LxFTail
         hfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680171618;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M4Y2U0FWvmSoCA4G791gIQlcGTXzfS+ytaj/vB6IHj8=;
        b=s80zIxHwQKMSv6J/mOIDOWSqBfjQRHOnuEo8Mo7hhBDDGsXfA+AjFnp3cjmQVXDqb6
         WcmW9E8pBthyX/FQUA8Y2zTd6311ccogwcaEIK3OhOrzIBQUSP7nL1AWMgaqYRFzIn5t
         zyqFzdPtNFyC4EFYNppMiOraShtgpqoJkFNUNM5t6AR+aG7piFe77kO9w/LrfaUea031
         P55GH2oBtSO9RBauyf5z2+cCzjOT8wmIyh9sOucNbYzPbVOsnnC3bZBsxkjDHMAEH1wv
         D01e5BsJ09VPR7tDgwUjcu0xfj2LjRu6uV9uBxAC38LHrxLSQUxXcxm9Ivwa+DRIW5hi
         NF+g==
X-Gm-Message-State: AAQBX9cFj3cb74zP13p8ntIob4xGZ9rWqem+mlPpGxRm3fAMMdq+Dif/
        LAA8Jd48VYmWmGd9CV9HFp4Rep7IumsTuAq/8eJrGg==
X-Google-Smtp-Source: AKy350bYVPEHqQ5xoTRP/N8VhBz9BbE320FyMjTjKmJbxkhF9Rb7xkNgUhqQlNApPJSBPs5Svebf2aircjV/J8MU0/8=
X-Received: by 2002:a25:16d6:0:b0:acc:1061:44a with SMTP id
 205-20020a2516d6000000b00acc1061044amr16607531ybw.50.1680171617974; Thu, 30
 Mar 2023 03:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230316123028.2890338-1-elver@google.com>
In-Reply-To: <20230316123028.2890338-1-elver@google.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 30 Mar 2023 12:19:40 +0200
Message-ID: <CANpmjNNZMHHjbN_5a3Krk1xPvT_WLKGUxueaKjUYJZkeDZ=AKw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] posix-timers: Prefer delivery of signals to the
 current thread
To:     elver@google.com, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 16 Mar 2023 at 13:31, Marco Elver <elver@google.com> wrote:
>
> From: Dmitry Vyukov <dvyukov@google.com>
>
> POSIX timers using the CLOCK_PROCESS_CPUTIME_ID clock prefer the main
> thread of a thread group for signal delivery.     However, this has a
> significant downside: it requires waking up a potentially idle thread.
>
> Instead, prefer to deliver signals to the current thread (in the same
> thread group) if SIGEV_THREAD_ID is not set by the user. This does not
> change guaranteed semantics, since POSIX process CPU time timers have
> never guaranteed that signal delivery is to a specific thread (without
> SIGEV_THREAD_ID set).
>
> The effect is that we no longer wake up potentially idle threads, and
> the kernel is no longer biased towards delivering the timer signal to
> any particular thread (which better distributes the timer signals esp.
> when multiple timers fire concurrently).
>
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Suggested-by: Oleg Nesterov <oleg@redhat.com>
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Marco Elver <elver@google.com>

Gentle ping...

Thanks,
-- Marco
