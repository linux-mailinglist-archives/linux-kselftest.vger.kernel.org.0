Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E417D708427
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 May 2023 16:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjEROoo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 May 2023 10:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjEROon (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 May 2023 10:44:43 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F07DE
        for <linux-kselftest@vger.kernel.org>; Thu, 18 May 2023 07:44:42 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3f389c519e5so11158191cf.2
        for <linux-kselftest@vger.kernel.org>; Thu, 18 May 2023 07:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1684421081; x=1687013081;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=obhgUzt9f6O2yq2OScYiSLzmPyBEa1gRm2MaMRKe5ow=;
        b=Xhj0iznqnM9003UxxM6XKADJGQU/zEHYZmW3Aa8pXsAuPHpfiPqC0/mDD8QQPG6ZqN
         0Y7LTj1fvE63plVXwi6gAVcWC520Y0rnqcYRtXQ/i3CqBeJo/Vpfp2LahF65MVyBrlZr
         PIDybiXdTvDRLOLmztgSUkqooX6wim0hVkbQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684421081; x=1687013081;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=obhgUzt9f6O2yq2OScYiSLzmPyBEa1gRm2MaMRKe5ow=;
        b=biEH8yfGYOc7+EGoSQWxhThIjWBV9FsKaJCkxJ/7vKJPyjBWlBse2y7qR9I9szH9Nk
         AslqF24NJHUfkoQPpmUC1nRFElTsSaMU9KJ9wAtNgsjeBe8S8mQYnh+kkkAmxY8NSYyr
         nFBWtvJVHH8/6Wc0evNB1dDYczRJeAo5LCDJbML4k8hjyQRxLe7vRd+QA8rVsu63U+v5
         Tg8epjmah0d+m+tIW3wUwbrqf8xy4k8VJGSb9Cz7cSZYHcJIR5p6eu+Ryu9xBiduX7Zo
         dhujlLhshuwOpVEqHXIxwGglYc/Z/Innd2J0AxJ7u7gMMskZnHfsqKnYdzJ4XhUQ3yqA
         jlkQ==
X-Gm-Message-State: AC+VfDzrhwTAjAEhL8dC+7ucQT4mpYTKPA5nRyApqei4B4X3GrNhDwkI
        w8FaaB7LRtZ1bSJkleDaS20cqQ==
X-Google-Smtp-Source: ACHHUZ5UEp/sYvgIRP+AfymF/lDAdCglojfb5BwU1Qm8SGU8iIjhL4zgebJdare1GtGPlXo6PtHKPw==
X-Received: by 2002:ac8:5b88:0:b0:3f5:37eb:1fba with SMTP id a8-20020ac85b88000000b003f537eb1fbamr5443748qta.23.1684421081388;
        Thu, 18 May 2023 07:44:41 -0700 (PDT)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id b28-20020a05620a127c00b0075941df3365sm436934qkl.52.2023.05.18.07.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 07:44:40 -0700 (PDT)
Date:   Thu, 18 May 2023 14:44:40 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH RFC 1/4] mm/mremap: Optimize the start addresses in
 move_page_tables()
Message-ID: <20230518144440.GA813364@google.com>
References: <20230518021825.712742-1-joel@joelfernandes.org>
 <20230518021825.712742-2-joel@joelfernandes.org>
 <CAHk-=wi20GzWeK=vUoreX6AXOEmeJKczou1McCOC9JytVO=TQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wi20GzWeK=vUoreX6AXOEmeJKczou1McCOC9JytVO=TQg@mail.gmail.com>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 17, 2023 at 09:12:07PM -0700, Linus Torvalds wrote:
> On Wed, May 17, 2023 at 7:18 PM Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> >
> > This warning will only trigger when there is mutual alignment in the
> > move operation. A solution, as suggested by Linus Torvalds [2], is to
> > initiate the copy process at the PMD level whenever such alignment is
> > present.
> 
> So this patch is actually simpler than I thought it would be.
> 
> But I'm a bit nervous about it. In particular, it ends doing
> 
>         old_end = old_addr + len;
>         ... expand old_addr/new_addr down to the pmd boundary ..
>         return len + old_addr - old_end;        /* how much done */
> 
> doesn't that return value end up being nonsensical now?

Aargh, Sorry to miss that. Yes, it ends up being bogus in the case where the
loop broke out early due to failure (but only on the first PMD move failure
AFAICS). In the success case (or failures after the first PMD move), it does
not matter because old_addr is updated to what it was without the
optimization.

> In particular, I think it can return a *negative* value, because of
> how old_addr was moved down, and the "now much done" might indeed be
> "negative" in the sense that it failed the move even "before" the
> original starting point.
> 
> And that negative value then ends up being a large positive one as an
> "unsigned long", of course.
> 
> So I get the feeling that it wants something like
> 
>         if (old_addr + len < old_end)
>                 return 0;

I think that will fix it (thanks!). The main thing I think is to not mess up
the second call to move_page_tables() in mremap where it tries to move the
half-moved stuff back:

  move_page_tables(new_vma, new_addr, vma, old_addr, moved_len,  true);

There moved_len comes from the return value of the first call to
move_page_tables().

If we realigned, and then the first PMD alloc failed, moved_len might be
negative as you pointed. If the first PMD move passed, then there is no
issue as I mentioned above.

I will fix this in the next revision and also add a test case for this, I am
wondering how to test it without some kind of error-injection to make the
first PMD copy fail. In any case, I will try to hack my local kernel to test
that.

thanks,

 - Joel


> there at the end.
> 
> But maybe there is something in there that guarantees that that case
> never happens. I didn't think too deeply about it, I just felt this
> looked odd.
> 
>                Linus
