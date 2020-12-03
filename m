Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B462CCCFE
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Dec 2020 04:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgLCDG2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Dec 2020 22:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbgLCDG2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Dec 2020 22:06:28 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E6FC061A4E
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Dec 2020 19:05:48 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id r24so568499lfm.8
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Dec 2020 19:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WjGqpET2Joyaoa7pzBRRAhyQfbOzaMh2Cn5V13dsplE=;
        b=I+pPbRO5c82mvmvPX68U+/RmZLa6WAUb1BetR7a1l1k0/uZe8sCTrzeNyeq1dOCIoN
         4wKCnXDzP6us8JTEPAqSkctAgAox+KlaWfH3bokxL2UzUPiKDe2JcXhumoRAPTjJazI1
         tTQlG/age4OsofVWBzdTcKpfzibcVHbov3KMGthT2vAVBWeKXz+MYC+WFiQyfjU4KHl8
         bE4D8BFDnu7w7HS6f4Znw3/X3tjJrk1oA0DnZgskez29UH42jFOAwslEfCGnYposIbWn
         wWUCESvpJStwijIfI/FI0xE9cGd36BNXMIre3tNgmFop7TGf9NvNZqw8XOPi4BaKuE61
         wkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WjGqpET2Joyaoa7pzBRRAhyQfbOzaMh2Cn5V13dsplE=;
        b=AL8WPFS7CmfpU09on8wvwyvd8/XimstvjLXvWHUJycf15bHtyrIj93vNpiCzaKDlCY
         XIoJdO7Fue+KikjJtkE0bl11LGRpm5w7VfeEAKIYXiTyAk7evs2w2jGAI5fY/nYgvb0N
         Y6Z9j+hYhwKwQ0yH9CHQ4NyvSgECqtmCzba5MxrUwqpiTsFclwEVuKncD3mg39CmwPGA
         lSvnsIScKU9BQslofx+4gubbjBYLTv11OoMBtHOitkHkwDaFbXjlRt1iYm+4M2mTf7xD
         KihkaGQzpl6tl4d58hImh8GuD6X5q+kysCGgedzwBh55uiprcObm179tmDa8kxf9WgFZ
         yQiQ==
X-Gm-Message-State: AOAM532HqrHlDFB4Z0rh2dOKndf5KkkgJtBs0hZvsLTDoLgFHe9iK5u6
        DX7fzQp7CEAprFvyGUAxK1zL2IfuuWThniz8cooe8A==
X-Google-Smtp-Source: ABdhPJx9+B/2Wz+X4W05KTZTghYz5A8vZdtxVvQbfTolC37irr33alvURfDzouHDIjdGl4Eyp/AZQA13tG3tovI4E2o=
X-Received: by 2002:a05:6512:110a:: with SMTP id l10mr426142lfg.167.1606964746628;
 Wed, 02 Dec 2020 19:05:46 -0800 (PST)
MIME-Version: 1.0
References: <20201202190824.1309398-1-dlatypov@google.com> <20201202190824.1309398-2-dlatypov@google.com>
In-Reply-To: <20201202190824.1309398-2-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 3 Dec 2020 11:05:35 +0800
Message-ID: <CABVgOSm=mrEwjTMy9TeGRwCnVqmEtJGiqSBiURQk7unfHYLH+g@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] kunit: tool: stop using bare asserts in unit test
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 3, 2020 at 3:09 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Use self.assertEqual/assertNotEqual() instead.
> Besides being more appropriate in a unit test, it'll also give a better
> error message by show the unexpected values.
>
> Also
> * Delete redundant check of exception types. self.assertRaises does this.
> * s/kall/call. There's no reason to name it this way.
>   * This is probably a misunderstanding from the docs which uses it
>   since `mock.call` is in scope as `call`.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Looks good, thanks!

Reviewed-by: David Gow <davidgow@google.com>


-- David
