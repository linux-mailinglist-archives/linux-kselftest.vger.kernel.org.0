Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8F54967B3
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jan 2022 23:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbiAUWMj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jan 2022 17:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiAUWMj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jan 2022 17:12:39 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516EEC06173D
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Jan 2022 14:12:39 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id l24-20020a17090aec1800b001b55738f633so327598pjy.1
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Jan 2022 14:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7W5fZ4/3+YDkiPOESVuTV8Qsje56I2iPwkvvGyw3F90=;
        b=QVxTzTt5hSy+20MsNu5t2oMrg4eOCs5D/sfzCPtsw8JCbOE+k81GeR5RwhVwR/SKh/
         dzVPfJnXT2zBgu8iiczmUszLNFxWOUOeNrNhVdPKkybQM7NGcHQ6rijsvW9ZO3rAZFGw
         4gJYvOwZOTAma8cgTdL5k12rO+o+mbdVWovKWrXjTou6wvOrs5A+NVX/KtAuQICYZZek
         QJPoDalxVDDO4vweT7E5FKksmG4DfRZqYYAAxLVLDnavOyT1a/HIr6FDucvQhbW7v+BU
         1GM3sFxwxnQGIunaLJ5hHX4v8bbDmTjLcYApdlz4y82JU2tAC1XscUWykeaKIwoXhcpu
         qwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7W5fZ4/3+YDkiPOESVuTV8Qsje56I2iPwkvvGyw3F90=;
        b=F9T1pqM/Jwve6VoMXWLwvsQCTiyhd//P+wsif5vTi11fDF3EmI9iowMjv/NenchhSk
         qSVe4cQ0tLeqhbqU+DFwXtGbjIs7NmUJR9DTj101CbIse/VY75niHYAByFzoPRHg65Ov
         Kjr+VeRVQC7gEMwmGlhqC5Ddr+1vPyJjhqcg9TZVF6Zq61pnD2lYoTqjtTx4FwkcClIw
         9gyW0N1dSahOH/VOvJy6OEdgGrNXqkQNbI7WqPEvLcRzS9qjXRdDt8z8uWhUTAZJilxo
         vJ9E9VtXllUcczU7RdMkRUR7FyImhU1nJaKZL3hv89TETUH9TWF2+iHXqfhnbFpEq8IS
         ey0Q==
X-Gm-Message-State: AOAM533acOhiI8BiUZ08mTj/Tf+pJ/+7ZLR5RuatmuaF38prb9wt2vOS
        D5S1L6Lz8s6rKyBlP2VmEANFFThUAakUFIblxb07yg==
X-Google-Smtp-Source: ABdhPJzfvhsCjDXBj8JKkx9G7ywzhIYYm4i3GTBaEHnQVpjzrriW42Q9cpif6KvRN54GayL6xNH45D9QxSCtpsTRwM8=
X-Received: by 2002:a17:902:dacf:b0:14b:2225:2f06 with SMTP id
 q15-20020a170902dacf00b0014b22252f06mr3347976plx.123.1642803158536; Fri, 21
 Jan 2022 14:12:38 -0800 (PST)
MIME-Version: 1.0
References: <20220118223506.1701553-1-dlatypov@google.com> <20220118223506.1701553-3-dlatypov@google.com>
In-Reply-To: <20220118223506.1701553-3-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 21 Jan 2022 17:12:26 -0500
Message-ID: <CAFd5g46vj-+SyXP-B+AVZ58aNbD2weRCQ63tDG=HfBn3dttbUQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] kunit: drop unused intermediate macros for ptr
 inequality checks
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 18, 2022 at 5:35 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> We have the intermediate macros for KUNIT_EXPECT_PTR_GT() and friends,
> but these macros don't exist.
>
> I can see niche usecases for these macros existing, but since we've been
> fine without them for so long, let's drop this dead code.
>
> Users can instead cast the pointers and use the other GT/LT macros.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Oh, whoops, I didn't even realize we were missing those variants.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
