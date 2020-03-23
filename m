Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D399018F807
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Mar 2020 16:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbgCWPBj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Mar 2020 11:01:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40292 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbgCWPBj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Mar 2020 11:01:39 -0400
Received: by mail-wm1-f66.google.com with SMTP id a81so9430133wmf.5;
        Mon, 23 Mar 2020 08:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BWEC9ZUJwJUU11ZALKTe1h8BQNjpF356QgpNgKWIUoE=;
        b=AOJwFAB1resLDZutvmi/+Ua1YOuM3V8Hhym7YQwdnrtmA3HsjJ/D/3vxdQt2lzVuef
         Zkt6toc903FIYLdJnqGeyWl0+KC6V7X8DSxRQvjcZvbfapr4u2eBamcOP0+/Wzsh1FkZ
         volmrNfS7NvrqsvvkPw884hir8sZfv0j2o1wXs+G7q/h9eQELhKu++IuTgg2sIgXZado
         jLeM6XlEMKyGUPa0Wy9762LEEy9I12RQu3/kgF0ecx7KYOVy+NQmJCXIuW0ndGbITJYl
         fgsPXIY2pIdgLatRRnUuEx7/T3fo+ay2sT8r9s80AgqPJtN4X22j+fFAmloaRZYlMcS9
         RPOQ==
X-Gm-Message-State: ANhLgQ1K77hUwP31fePsHuXE+oO2AEBwW76BQeONQzAhCQLFSxO7TFCM
        tzSVPY82erpijnplXul3b24=
X-Google-Smtp-Source: ADFU+vsspAc0mN88NYcQRgh9Bxnqb2zzcB6GAD3hGAuDATOrq/kOx0m1rO63Ka+RBS0/ayBdXsvjIA==
X-Received: by 2002:a05:600c:d4:: with SMTP id u20mr12421355wmm.83.1584975697314;
        Mon, 23 Mar 2020 08:01:37 -0700 (PDT)
Received: from localhost (ip-37-188-135-150.eurotel.cz. [37.188.135.150])
        by smtp.gmail.com with ESMTPSA id k204sm8490964wma.17.2020.03.23.08.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 08:01:36 -0700 (PDT)
Date:   Mon, 23 Mar 2020 16:01:34 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] tools/testing/selftests/vm/mlock2-tests: fix mlock2
 false-negative errors
Message-ID: <20200323150134.GN7524@dhcp22.suse.cz>
References: <20200322013525.1095493-1-aquini@redhat.com>
 <CALvZod4GjRFLRX=S_YFYnJk-kL6tjveYEDOBFS76NqrURERHHQ@mail.gmail.com>
 <20200323141659.GA23364@optiplex-lnx>
 <20200323142941.GK7524@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323142941.GK7524@dhcp22.suse.cz>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon 23-03-20 15:29:43, Michal Hocko wrote:
> On Mon 23-03-20 10:16:59, Rafael Aquini wrote:
> > On Sun, Mar 22, 2020 at 09:31:04AM -0700, Shakeel Butt wrote:
> > > On Sat, Mar 21, 2020 at 6:35 PM Rafael Aquini <aquini@redhat.com> wrote:
> > > >
> > > > Changes for commit 9c4e6b1a7027f ("mm, mlock, vmscan: no more skipping pagevecs")
> > > > break this test expectations on the behavior of mlock syscall family immediately
> > > > inserting the recently faulted pages into the UNEVICTABLE_LRU, when MCL_ONFAULT is
> > > > passed to the syscall as part of its flag-set.
> > > 
> > > mlock* syscalls do not provide any guarantee that the pages will be in
> > > unevictable LRU, only that the pages will not be paged-out. The test
> > > is checking something very internal to the kernel and this is expected
> > > to break.
> > 
> > It was a check expected to be satisfied before the commit, though. 
> > Getting the mlocked pages inserted directly into the unevictable LRU,
> > skipping the pagevec, was established behavior before the aforementioned
> > commit, and even though one could argue userspace should not be aware,
> > or care, about such inner kernel circles the program in question is not an 
> > ordinary userspace app, but a kernel selftest that is supposed to check
> > for the functionality correctness.
> 
> But mlock (in neither mode) is reall forced to put pages to the

ble I meant to say "is not really forced"

> UNEVICTABLE_LRU for correctness. If the test is really depending on it
> then the selftest is bogus. A real MCL_ONFAULT test should focus on the
> user observable contract of this api. And that is that a new mapping
> doesn't fault in the page during the mlock call but the memory is locked
> after the memory is faulted in. You can use different methods to observe
> locked memory - e.g. try to reclaim it and check or check /proc/<pid>/smaps

I have just checked the testcase and I believe it is really dubious to
check for page flags. Those are really an internal implementation
detail. All the available information is available in the
/proc/<pid>/smaps file which is already parsed in the test so the test
is easily fixable.
-- 
Michal Hocko
SUSE Labs
