Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822313E5C8C
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Aug 2021 16:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240460AbhHJOJ2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Aug 2021 10:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238554AbhHJOJ0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Aug 2021 10:09:26 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33950C0613D3;
        Tue, 10 Aug 2021 07:09:04 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id t66so22479926qkb.0;
        Tue, 10 Aug 2021 07:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=N+Mqo44friizGPZUJX1Ewr3TjH86QyYiAYe5f7DbBYA=;
        b=OYurtlbEe4ErTd65/L3fC+rqU6BiBOgPghCMJqZKL3PtLC9v97HJDdlhXWmIrJ+ZSY
         at4xkApKIZMwRbLlM791u3ckYEzSnguZ8OUEnRdJVkmbU2XnWY+vJuupPUGOLbr0FUTH
         /IG0uXFSvztgZQZg07NSJ+SZkS+7dZfnZjg9hhq+e2kY/ON9+qd0K7Ca/aOu8dIhgHOg
         ziR37EaThLBLZXZalzWlpS/srlfJxHxqqEBdykLNJghedp+hcyhkXezPyNtvrkQzscCe
         LMzFWCpcgbDxybPrVT1mLNwgVNTU9EM6u0YaQN+MI7mrIr6155XkzayFPINki+fi21YC
         TpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=N+Mqo44friizGPZUJX1Ewr3TjH86QyYiAYe5f7DbBYA=;
        b=X0NgvOV07Ug6yJMVLYpmUITdaffR5m2+ggkyVH/8k6JhGY2w6+OozVxPXHUnvhU7ds
         xwCCJIsOzt9p8imq/mnjPkaTnp6alagZRqzQPoz4uMIeGigWqf821Qz8iVflLqV5PNqh
         PouJnFrZLjVQeKEA2eL0+jfedxdR+wlHkxqEhI1gGOr1S/aodVewTxil8KQCGlAi9kOc
         MJGF41c8mbwX0QEJ3tNqF0indZZAp2OSqN4Y07Z9gOBY2hzoxiQNK2uI07AHUf5TDajz
         AhRjL5tqHULKBzFl0NEGsbzdCzRgABQWDtbHYSxGa4gcch3EHLr126iw/kSTLN4nmrkz
         2JoA==
X-Gm-Message-State: AOAM531PMp+AgWkduxpYt8MIdnl3iDRsFm26vSF/okh97gVIV9QincBO
        XrbMG1nB8XA+YB38dMqI9+U=
X-Google-Smtp-Source: ABdhPJwOt2Dt7W2XQ8abETFNU3b+kRYO8Ccx+wjswwLY8WD3pp+TNQrBooGa5qSHPeUDGV1LZmCM4Q==
X-Received: by 2002:ae9:c10a:: with SMTP id z10mr27838964qki.71.1628604543451;
        Tue, 10 Aug 2021 07:09:03 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id f24sm2318309qtp.1.2021.08.10.07.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 07:09:02 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     SeongJae Park <sj38.park@gmail.com>, akpm@linux-foundation.org,
        shuah@kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH] selftests/damon/debugfs_attrs: Add missing execute permission
Date:   Tue, 10 Aug 2021 14:08:58 +0000
Message-Id: <20210810140858.24122-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <YRJisBs9AunccCD4@kroah.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

On Tue, 10 Aug 2021 13:27:44 +0200 Greg KH <gregkh@linuxfoundation.org> wrote:

> On Tue, Aug 10, 2021 at 11:20:50AM +0000, SeongJae Park wrote:
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > Commit 04edafbc0c07 ("mm/damon: add user space selftests") of
> > linux-mm[1] gives no execute permission to 'debugfs_attrs.sh' file.
> > This results in a DAMON selftest failure as below:
> > 
> >     $ make -C tools/testing/selftests/damon run_tests
> >     make: Entering directory '/home/sjpark/linux/tools/testing/selftests/damon'
> >     TAP version 13
> >     1..1
> >     # selftests: damon: debugfs_attrs.sh
> >     # Warning: file debugfs_attrs.sh is not executable, correct this.
> >     not ok 1 selftests: damon: debugfs_attrs.sh
> >     make: Leaving directory '/home/sjpark/linux/tools/testing/selftests/damon'
> > 
> > To solve the problem, this commit adds the execute permission for
> > 'debugfs_attrs.sh' file.
> > 
> > [1] https://github.com/hnaz/linux-mm/commit/04edafbc0c07
> > 
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > ---
> >  tools/testing/selftests/damon/debugfs_attrs.sh | 0
> >  1 file changed, 0 insertions(+), 0 deletions(-)
> >  mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_attrs.sh
> > 
> > diff --git a/tools/testing/selftests/damon/debugfs_attrs.sh b/tools/testing/selftests/damon/debugfs_attrs.sh
> > old mode 100644
> > new mode 100755
> > -- 
> > 2.17.1
> > 
> 
> Why not fix the tools to execute the file properly as changing the mode
> of a file does not work well with all tools that we use (i.e. patch
> files.)

Ok, It sounds make some sense.  Hence, I posted this patch:
https://lore.kernel.org/linux-kselftest/20210810140459.23990-1-sj38.park@gmail.com/


Thanks,
SeongJae Park

[...]
