Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1595118F6EF
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Mar 2020 15:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgCWO3p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Mar 2020 10:29:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39361 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgCWO3p (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Mar 2020 10:29:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id a9so11989326wmj.4;
        Mon, 23 Mar 2020 07:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PgGrbAJ9j98exfSo98nJNMVRX6RscOjYHAK4YDkqU6w=;
        b=UwDcH+L2EuL558+CYxzr3YdodBQrK7RwZYhK4o5BYMuBCh40UA9vLaebQSscaa1weW
         deLRMuzzmTqyMvEmHhvFqrWaKXetpT2y/nmPctnd+c6WaADbQc936d/EiRVTLJYp+49V
         jDHqI7FBldPgJrLATnyVa7XD9jYxFpOglnn7eYJ5cQmJH/rdS53Jwb6w+9mSTcMJv7yi
         tzc7zChTaHio0BSpA/anT6+CsaenSoucpBe2D0NfarZ6DhcuN8+/IhErVfxoTuf1lwSC
         Z7ey86JId0C6tM4T3Bo4VU+IxPAlAWF8fs/ORHdQkCnvjpvJbZR0h0B6+uZDwSCYOogL
         uwiA==
X-Gm-Message-State: ANhLgQ2xofHj+FE67i7ET4M+6cqY0CbjeVo22AJonX8pnZgHl2djuS5u
        M0mO00Rk+wjyI0wH5TM1TPM=
X-Google-Smtp-Source: ADFU+vv5KrI51E89paspeXPPrGtzXE/bYqE9+eI3q6rJMUr8Di29zK/34i9JOiFoFKnhNovbBsc6Qw==
X-Received: by 2002:a1c:de82:: with SMTP id v124mr27142143wmg.70.1584973783317;
        Mon, 23 Mar 2020 07:29:43 -0700 (PDT)
Received: from localhost (ip-37-188-135-150.eurotel.cz. [37.188.135.150])
        by smtp.gmail.com with ESMTPSA id n2sm25447536wro.25.2020.03.23.07.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 07:29:42 -0700 (PDT)
Date:   Mon, 23 Mar 2020 15:29:41 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] tools/testing/selftests/vm/mlock2-tests: fix mlock2
 false-negative errors
Message-ID: <20200323142941.GK7524@dhcp22.suse.cz>
References: <20200322013525.1095493-1-aquini@redhat.com>
 <CALvZod4GjRFLRX=S_YFYnJk-kL6tjveYEDOBFS76NqrURERHHQ@mail.gmail.com>
 <20200323141659.GA23364@optiplex-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323141659.GA23364@optiplex-lnx>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon 23-03-20 10:16:59, Rafael Aquini wrote:
> On Sun, Mar 22, 2020 at 09:31:04AM -0700, Shakeel Butt wrote:
> > On Sat, Mar 21, 2020 at 6:35 PM Rafael Aquini <aquini@redhat.com> wrote:
> > >
> > > Changes for commit 9c4e6b1a7027f ("mm, mlock, vmscan: no more skipping pagevecs")
> > > break this test expectations on the behavior of mlock syscall family immediately
> > > inserting the recently faulted pages into the UNEVICTABLE_LRU, when MCL_ONFAULT is
> > > passed to the syscall as part of its flag-set.
> > 
> > mlock* syscalls do not provide any guarantee that the pages will be in
> > unevictable LRU, only that the pages will not be paged-out. The test
> > is checking something very internal to the kernel and this is expected
> > to break.
> 
> It was a check expected to be satisfied before the commit, though. 
> Getting the mlocked pages inserted directly into the unevictable LRU,
> skipping the pagevec, was established behavior before the aforementioned
> commit, and even though one could argue userspace should not be aware,
> or care, about such inner kernel circles the program in question is not an 
> ordinary userspace app, but a kernel selftest that is supposed to check
> for the functionality correctness.

But mlock (in neither mode) is reall forced to put pages to the
UNEVICTABLE_LRU for correctness. If the test is really depending on it
then the selftest is bogus. A real MCL_ONFAULT test should focus on the
user observable contract of this api. And that is that a new mapping
doesn't fault in the page during the mlock call but the memory is locked
after the memory is faulted in. You can use different methods to observe
locked memory - e.g. try to reclaim it and check or check /proc/<pid>/smaps

-- 
Michal Hocko
SUSE Labs
