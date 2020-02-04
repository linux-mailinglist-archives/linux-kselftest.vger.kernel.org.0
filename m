Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44A89152260
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2020 23:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbgBDWdl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Feb 2020 17:33:41 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38281 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727563AbgBDWdl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Feb 2020 17:33:41 -0500
Received: by mail-ot1-f65.google.com with SMTP id z9so75110oth.5
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Feb 2020 14:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r4vakGMhq6osED8dfnagmL3LnH1bwD9GWqExnkD8isg=;
        b=nsFcX+UkIOs3W64Y+ii8sN4utrUNClWWK5j8fLw1Ozps4Upa29eosAErByGTJMMSqn
         Uf54fKPlPvLy5rfQ9BS358JoA3gtI3jRPeOyoIzrFbZSX8/bmN5BY7kBdDXJ6C8KwkR0
         9i8ASESnQJDGufhIdNEgD9F9netV75Xy/p+TGbhvSsb6/ewtPCOO2S64aoJ9fnpC7UKY
         jFombvtN7ivWbvbzKzGqbC8qRE58Ytm3Yjx1iGJNsOFNfC8IrPVmU6sPiPncRg2RYTMw
         pYaT+e7IB6zBYtbxpTG8uREOPXipUZkLdLF+1xsoG8xZvthYb28fCvuwZokw362nmqfi
         y07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r4vakGMhq6osED8dfnagmL3LnH1bwD9GWqExnkD8isg=;
        b=ZYri1h26dAobT1DE9HoBstjEOX7DIU8lxjZ/2t9tNcxZ86ZSJ+ymo/JF4mA7FRt4fj
         Tv2TtiqTfThTaCC2MVQGkLuD+/1d1F7qX3KxpvpXMy55LQ+064PBp12wuAM25eBvGlU3
         fh0e3wyTmKdoWh4UwP5uiMPzJjabYtDE8L0CaQ03T99ToiRWqdb6lXnby56siVIEylJG
         MtmL3CTkdBN43Z+fC1n+6pPbvW2JAozbRuO9Y2wYlkNJIZcTmXpgXw9SQOeHRPi/dC8M
         NenXKQpshjMzx+Yox5hOKFoPRb8CDPMPT59x8+GzVwVeMOLArsOmXW0ZZeik+aIuq9CA
         UgtQ==
X-Gm-Message-State: APjAAAV0BaF9/Ew0HL+RQFjrnaZ6PZ93LFemhJIIjBSof7xa+fH0jANN
        mFxMzMFvy9BBi5c0mnUT7LHmcQ1ad0PKEd+B0sLnng==
X-Google-Smtp-Source: APXvYqwAB6r7PiMCLRtXLPkmBSmepkc4OT2+jLlJkQ9zZgPfaqu9E0ylfzzT6UFq8J3qZq5LgZpjdufN9HeUGzf+FTk=
X-Received: by 2002:a9d:7b4e:: with SMTP id f14mr23746990oto.355.1580855620419;
 Tue, 04 Feb 2020 14:33:40 -0800 (PST)
MIME-Version: 1.0
References: <20200203232248.104733-1-almasrymina@google.com>
 <20200203232248.104733-8-almasrymina@google.com> <0fa5d77c-d115-1e30-cb17-d6a48c916922@linux.ibm.com>
 <CAHS8izPobKi_w8R4pTt_UyfxzBJJYuNUw+Z6hgFfvZ1Xma__YA@mail.gmail.com>
In-Reply-To: <CAHS8izPobKi_w8R4pTt_UyfxzBJJYuNUw+Z6hgFfvZ1Xma__YA@mail.gmail.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 4 Feb 2020 14:33:29 -0800
Message-ID: <CAHS8izNmSYumXpYXT1d8tAm36=-BRjXqdCDjLB6UNMwn5xhPZg@mail.gmail.com>
Subject: Re: [PATCH v11 8/9] hugetlb_cgroup: Add hugetlb_cgroup reservation tests
To:     Sandipan Das <sandipan@linux.ibm.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, shuah <shuah@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Feb 4, 2020 at 12:36 PM Mina Almasry <almasrymina@google.com> wrote:
>
> On Tue, Feb 4, 2020 at 8:26 AM Sandipan Das <sandipan@linux.ibm.com> wrote:
> >
> >
> > There are still a couple of places where 2MB page size is being used.
> > These are my workarounds to get the tests running on ppc64.
> >
>
> Thanks for the changes!
>
> > Also I had missed running charge_reserved_hugetlb.sh the last time.
> > Right now, it stops at the following scenario.
> >
> > Test normal case with write.
> > private=, populate=, method=2, reserve=
> > nr hugepages = 10
> > writing cgroup limit: 83886080
> > writing reseravation limit: 83886080
> >
> > Starting:
> > hugetlb_usage=0
> > reserved_usage=0
> > expect_failure is 0
> > Putting task in cgroup 'hugetlb_cgroup_test'
> > Method is 2
> > Executing ./write_to_hugetlbfs -p /mnt/huge/test -s 83886080 -w  -m 2  -l
> > Writing to this path: /mnt/huge/test
> > Writing this size: 83886080
> > Not populating.
> > Using method=2
> > Shared mapping.
> > RESERVE mapping.
> > Allocating using SHM.
> > shmid: 0x5, shmget key:0
> > shmaddr: 0x7dfffb000000
> > Writing to memory.
> > Starting the writes:
> > .write_result is 0
> > .After write:
> > hugetlb_usage=16777216
> > reserved_usage=83886080
> > ....kiling write_to_hugetlbfs
> > ...Received 2.
> > Deleting the memory
> > Done deleting the memory
> > 16777216
> > 83886080
> > Memory charged to hugtlb=16777216
> > Memory charged to reservation=83886080
> > expected (83886080) != actual (16777216): Reserved memory charged to hugetlb cgroup.
> > CLEANUP DONE
> >
> >
>
> So the problem in this log seems to be that this log line is missing:
>     echo Waiting for hugetlb memory to reach size $size.
>
> The way the test works is that it starts a process that writes the
> hugetlb memory, then it *should* wait until the memory is written,
> then it should record the cgroup accounting and kill the process. It
> seems from your log that the wait doesn't happen, so the test
> continues before the background process has had time to write the
> memory properly. Essentially wait_for_hugetlb_memory_to_get_written()
> never gets called in your log.
>
> Can you try this additional attached diff on top of your changes? I
> attached the diff and pasted the same here, hopefully one works for
> you:
>

I got my hands on a machine with 16MB default hugepage size and
charge_reserved_hugetlb.sh passes now after my changes. Please let me
know if you still run into issues.
