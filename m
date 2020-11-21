Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015C42BBAC7
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Nov 2020 01:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgKUAS7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Nov 2020 19:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbgKUAS7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Nov 2020 19:18:59 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3F5C0613CF
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Nov 2020 16:18:57 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id 10so9464231pfp.5
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Nov 2020 16:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y0pJ80u9Eh3VfP4FijeIg1t6JgwYwt6NQdfyVaOMVqE=;
        b=mNRCMhZyQ/r9RL3BPK9hfjr6LmrPY+hxr51iSpROvULOHDBUzO13Rwd6Wet+Jt8YkQ
         SZ0TaMbRptcV50sXt1vb+wVP9NafY9vzBYVZUNArYXHLE7+A4yLDXUMFSa+074SUw703
         MVLGoKCigzZWPNfYE4syBih8Ql2Xm14hqF8eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y0pJ80u9Eh3VfP4FijeIg1t6JgwYwt6NQdfyVaOMVqE=;
        b=q9meiHfwVnh65ZzHG2GRK02toKZDBUgvstSGLZJQOp9D0IcD+Oye2QhXR1sdzBMC5K
         ZmIml29hSn0L92TKSOc4gLK/SsSYkaVTb0oR6mwWH99Q+YSq9i3V0oyol/tuqyOR/+8u
         KXABniOTNQeo0M8Sn60iTEbCfsLtxA1GgAFPzeTd+xJqqiiMMQXAFTBhWHf8jT+DSFEC
         Gmf0+7NGiBNpfTEfkFCZazReitU4x7jQA4mQ2gNjOlFgQTyEZhuFZw+0yPSQQkGQb8w9
         ySfINSBHXNu1FE7Fn6vVKWQKyBKMAyDhDpwv7E2kpIvzly3YP/5X+W3B2IT8D8PVADsp
         sK9A==
X-Gm-Message-State: AOAM533ACvod/XD309SicoynBowTpFxpLOZJdYIE5q4kgGsIRYabdDpS
        tfP6BsBJe61zN6Yip4MnyxPY3w==
X-Google-Smtp-Source: ABdhPJzP1ocgUqyGygpfPM6J58fbWHahsI32yjgRzdo//NPDt9wt5xzy+MOU6yVXIize6sAPdn+HRA==
X-Received: by 2002:aa7:86d8:0:b029:18b:585b:3b16 with SMTP id h24-20020aa786d80000b029018b585b3b16mr15538520pfo.72.1605917937114;
        Fri, 20 Nov 2020 16:18:57 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c11sm5470547pjn.26.2020.11.20.16.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 16:18:56 -0800 (PST)
Date:   Fri, 20 Nov 2020 16:18:55 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     luto@kernel.org, Rich Felker <dalias@libc.org>, tglx@linutronix.de,
        christian.brauner@ubuntu.com, peterz@infradead.org,
        willy@infradead.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org, x86@kernel.org, gofmanp@gmail.com,
        kernel@collabora.com
Subject: Re: [PATCH v7 3/7] kernel: Implement selective syscall userspace
 redirection
Message-ID: <202011201618.62E507D@keescook>
References: <20201118032840.3429268-1-krisman@collabora.com>
 <20201118032840.3429268-4-krisman@collabora.com>
 <87a6vdmedy.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6vdmedy.fsf@collabora.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 19, 2020 at 12:43:05PM -0500, Gabriel Krisman Bertazi wrote:
> The existing interface could be extended with a flags field as part of
> the opcode passed in argument 2, which is currently reserved, and then
> return a FD, just like seccomp(2) does.  So it is not like the current
> patches couldn't be extended in the future if needed, unless I'm
> mistaken.

Yes, I'd prefer this series go in as-is, and if there is a need for
extending the API, arg2 can have more values added.

-- 
Kees Cook
