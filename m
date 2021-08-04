Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417DC3DF979
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Aug 2021 03:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbhHDB6u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Aug 2021 21:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhHDB6t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Aug 2021 21:58:49 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01923C061764
        for <linux-kselftest@vger.kernel.org>; Tue,  3 Aug 2021 18:58:38 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id gs8so1310178ejc.13
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Aug 2021 18:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ik/aRIJnGF3BUxWdSYGMICWQOswUuEj2isGKQOk90Bc=;
        b=gbrIZDmSoqXU6IDsTYkf/KNp4sxEyt9n0JuBLXR4M+OQtbi6PO6/p5Jnabp3EgxaJd
         bc7GBDZviL+k0aVQ1+BjauRfFralpG13Y0UrqKmcsQLssFA3Bt56JjsTxcLY07z4fsE4
         0X8KVKQLiC1G7+i4LKomSEthomV5aEzZWq/9eXniewGLpKyqBAslfb45b6OnFkGGKFnW
         fjTQPFlxroF8tmwH/dHrhrVMRR2gyyCfgQ7w/tFTGEucUEVAiwTjaZ9b/k7qvBfEFs5A
         aJdXt9Py38xBkkXUKHIesIsuEoPRtU4vchx2c5Xew0LwGTbT+btlCIZFnlTI90PgamYL
         hlCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ik/aRIJnGF3BUxWdSYGMICWQOswUuEj2isGKQOk90Bc=;
        b=XbO69oyGazI3knn4Hh2aTE2WY06hLhknoCPVe1lH1KN4MPVFuwvIYQMbq2QkGuiNdU
         J4arbMj2Vg7XkBXiNdaTnIPPTxhCURJh4qorUqKAjrE3zV/NBGyT3B5ttlgtr7cTyr2m
         SrS/Mycq/y/Y8DEDDE65Ms/BlJsVt/c1y3lxLia6Hj5MWLO4ltN5gdFVjab6yRpiOJKS
         Xmb4J59AE4VhRGbz0JIJm5S8Je6oxk2Z+5/90CAB4a4fOTaYfRj9vty+156byMnm+2u5
         8ATy8By8vx0RhtT4/sipqO9XKpIHDxiOGmZL4+/qwQvYO4kCnO9dTsTcafWb1rpR2D17
         Q2Aw==
X-Gm-Message-State: AOAM5315yIxTxLIIusqK+PEPortjwgiO6w2tl+aBU63l87rJtPUexYQn
        AVwHn/9ZccDh+x6otm92qCI0a4moZ1ldZ5lmkpOJgA==
X-Google-Smtp-Source: ABdhPJzQAbg7ZiA7bYIZFGzoMIu4mWe0c4ITjnZ2a/lgbpe+gCh44StvMSOnBW+Q79sfkZh+BjVmKtJB5iVXqnl3vAQ=
X-Received: by 2002:a17:906:d7b2:: with SMTP id pk18mr23582718ejb.541.1628042316601;
 Tue, 03 Aug 2021 18:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626252248.git.zhansayabagdaulet@gmail.com> <c0f55420440d704d5b094275b4365aa1b2ad46b5.1626252248.git.zhansayabagdaulet@gmail.com>
In-Reply-To: <c0f55420440d704d5b094275b4365aa1b2ad46b5.1626252248.git.zhansayabagdaulet@gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 3 Aug 2021 21:58:00 -0400
Message-ID: <CA+CK2bBCeB=4mOX_UZd3ViWCpFGhv+Cz1Yk8UWO987KFg1h3cQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] selftests: vm: add KSM unmerge test
To:     Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
Cc:     shuah@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 14, 2021 at 4:56 AM Zhansaya Bagdauletkyzy
<zhansayabagdaulet@gmail.com> wrote:
>
> Add check_ksm_unmerge() function to verify that KSM is properly
> unmerging shared pages. For this, two duplicate pages are merged first
> and then their contents are modified. Since they are not identical
> anymore, the pages must be unmerged and the number of merged pages has
> to be 0. The test is run as follows: ./ksm_tests -U
>
> Signed-off-by: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
