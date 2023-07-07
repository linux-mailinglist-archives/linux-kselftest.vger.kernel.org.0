Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C993874B7CF
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 22:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjGGUXU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 16:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGGUXT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 16:23:19 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78B3170F
        for <linux-kselftest@vger.kernel.org>; Fri,  7 Jul 2023 13:23:18 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-40371070eb7so16331cf.1
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jul 2023 13:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688761398; x=1691353398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUimeKJYxhpgKclI6L5R79wAVOIgG6dRaplv0HPA/iE=;
        b=AZQAXmXwMSlnzJ/3zxxvnmRe0zCnV0bn0b99w40paOUFk8ypRivPK3cwbOWf+4zH2Q
         xXn0qnfryq6PzPBAwB9zH4sPMh6kungbMooMxgvoM48EnlnvuN6n8b6LspT84L8732Ky
         dOS3x+Cq2D4BeaVzi+di1yPdE9vX9sKPtZJwOqoRTOuVQXERevi0y9CCmYRbUw5YTibI
         aDKyMpSsOb7BQ7WWc//E9ShhaP9rY1GrHfIv7M7eDa4Ec87IGHVmiK2LINWcdMNoVVvw
         q8gYDuuRLZZjM6S8Y7vESAOJ6orrcfLaHf+seMNrb2qXkdkJkXTEN/JwpsdRs56YxnEA
         ZV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688761398; x=1691353398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUimeKJYxhpgKclI6L5R79wAVOIgG6dRaplv0HPA/iE=;
        b=BijNXq0fG7P4TbIcj/Qng/VQig2ejd0ah8I1NXZ8XZtOz9DVYEua81Taq5UZmwb42P
         /+oAp6yejNCn7iFnLTn741IJTI+KpSLp89mz9pOpknvEpDUAIgufmyMRQJpCeQU8+x4B
         rMrZeyDokHbwGpsVPE7u/3xgo0eaoTE7EtyC4m2+KLCoo8D6WBqK5eLr68rRrZ/PIHiY
         ZtorYNlGb6TxsbB8G2jPwJxvMAIJW23ku1OQxiNGi9GAuFfInBKXRcnvCjCIQ39UsaRC
         b1jQmPE4/A1/hhRcMmuQsScSEXjodqYBqyIaUAjMfIzzDphKjELz+O5KCt2V4wsGHyCC
         nXTw==
X-Gm-Message-State: ABy/qLbJ8N0TY9qeH6MpOY2cJxH16BWGi4gKL6o9iHYpCkocHcNm7jH/
        OP6VCnlPfgxDiXVvrBJ8ncevOGP5oGUfhBE2pEZo
X-Google-Smtp-Source: APBJJlFtWfEyzGX60X2EmuVZBGt6AzH3MjMlRnlUsg60DTKrDdudj5Qu7JxL2L0fJY1qqaRpULB9HKHWEAkwpXK4BVs=
X-Received: by 2002:ac8:5906:0:b0:403:a090:41c5 with SMTP id
 6-20020ac85906000000b00403a09041c5mr46367qty.16.1688761397763; Fri, 07 Jul
 2023 13:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <895ef450-4fb3-5d29-a6ad-790657106a5a@intel.com>
In-Reply-To: <895ef450-4fb3-5d29-a6ad-790657106a5a@intel.com>
From:   John Stultz <jstultz@google.com>
Date:   Fri, 7 Jul 2023 13:23:07 -0700
Message-ID: <CANDhNCpiLFP-YKhNFWeZ8TJbygFfGczVfRFJo6xMzVT2NrKKPA@mail.gmail.com>
Subject: Re: ww_mutex.sh hangs since v5.16-rc1
To:     Li Zhijian <zhijianx.li@intel.com>
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com,
        open list <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Joel Fernandes <joelaf@google.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 30, 2021 at 5:26=E2=80=AFPM Li Zhijian <zhijianx.li@intel.com> =
wrote:
>
> LKP/0Day found that ww_mutex.sh cannot complete since v5.16-rc1, but
> I'm pretty sorry that we failed to bisect the FBC, instead, the bisection=
 pointed
> to a/below merge commit(91e1c99e17) finally.
>
> Due to this hang, other tests in the same group are also blocked in 0Day,=
 we
> hope we can fix this hang ASAP.
>
> So if you have any idea about this, or need more debug information, feel =
free to let me know :)
>
> BTW, ww_mutex.sh was failed in v5.15 without hang, and looks it cannot re=
produce on a vm.
>

So, as part of the proxy-execution work, I've been recently trying to
understand why the patch series was causing apparent hangs in the
ww_mutex test with large(64) cpu counts.
I was assuming my changes were causing a lost wakeup somehow, but as I
dug in I found it looked like the stress_inorder_work() function was
live-locking.

I noticed that adding printks to the logic would change the behavior,
and finally realized I could reproduce a livelock against mainline by
adding a printk before the "return -EDEADLK;" in __ww_mutex_kill(),
making it clear the logic was timing sensitive.  Then searching around
I found this old and unresolved thread.

Part of the issue is that we may not hit the timeout check at the end
of the loop, as the EDEADLK case short-cuts back to retry, allowing
the test to effectively get stuck.

But I know with ww_mutexes there's supposed to be a guarantee of
forward progress as the older context wins, but it's not clear to me
that works here. The EDEADLK case results in a releasing and
reacquiring of the locks (only with the contended lock being taken
first), and if a second EDEADLK occurs, it starts over again from
scratch (though with the new contended lock being chosen first instead
- which seems to lose any progress).

So maybe the test has broken that guarentee in how it restarts, or
with 128 threads trying to acquire a random order of 16 locks without
contention (and the order shifting slightly each time it does see
contention) it might just be a very big space to resolve if we don't
luck into good timing.

Anyway, I wanted to get some feedback from folks who have a better
theoretical understanding of the ww_mutexes. With large cpu counts are
we just asking for trouble here? Is the test doing something wrong? Or
is there possibly a ww_mutex bug under this?

thanks
-john
