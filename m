Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1F5EAAC7F
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2019 21:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388682AbfIETzY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Sep 2019 15:55:24 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33635 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfIETzY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Sep 2019 15:55:24 -0400
Received: by mail-oi1-f193.google.com with SMTP id e12so2700177oie.0
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Sep 2019 12:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0E53FGGcFw2XkCPybueZ5rdV/s9NQh6tuW3+GUXCXGs=;
        b=VGbVic4g4iq558TW4/70JbzqBVSLs2OD6RYvmwl5QuMLvX12QTRqKBc25h98tnlvfd
         v80uRkHZ/GTRqZ9g0C91oXPt7FF9Cjg2RFsnqXMbw5eyQo4fETfoQfYqB3ODTpk1KGbT
         Sh7ZlY3E1TGKRoYaW0H4kZo4b2PTayljx1y2V3yNZ4Xk1AiYBIE7CMPHAO6aUXmgSVvL
         n+hxUokjuXNIO43xyQEVoEOE/WcMVZM7h6kPMc9wbPx58jxtemgv5zSJ0dDz0qRpK6Bu
         TGXYQQxbrjGOBl9YxOCNePENdnFw6LVmvebG7GfSIuvOrT+Ti3KvjxrDKiOToU7kEiSF
         wq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0E53FGGcFw2XkCPybueZ5rdV/s9NQh6tuW3+GUXCXGs=;
        b=Dg/MlwJSzrP0eAmAliWq1mjxr8v/E+CKz8EoJ55NBbWyKWQu15k+a2sAAvbRRYVbaW
         GLojKWpe+jK/pgW0h+vM/uMeeOgSgbJDaEZk082XFBRgtMxRmC+PgLCcoRwdPeUGMqcC
         hvXZY+64fZaX9G5RltdxYNslIazDadYgfZHBj2ynpprZ9e/V27/a0n6nMTFCP3uOfXp+
         7preRZiFZ8F/u8Us3Iv7W4dBfqqSfCp/cKTzsqhs8lCg/AlDXyzclIEYwEebcF3jocFU
         mDIxInoasduumcUWecs8Ly/UkIMgK23stVHugVPTdHP6DHwmIf02fLURLBnuJSNTSO2n
         Ymkg==
X-Gm-Message-State: APjAAAUe6yiGAxC9Gcc0dpqKgUnbTLUIB0EMt4ygWkaZKE8EKmkWZkqr
        17tIbPL6yzCjEowwQUFJngp1GUOmf3NSUamMSI09LA==
X-Google-Smtp-Source: APXvYqx6VttttrIJnDmBplUS87vH5bQEfhKTAgd32Tl3Oi50+6KfQnD/K/l60tl025VmSmrNPuDhwiRmvNSPrZdx/7U=
X-Received: by 2002:aca:da86:: with SMTP id r128mr4231021oig.103.1567713322635;
 Thu, 05 Sep 2019 12:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190826233240.11524-1-almasrymina@google.com>
 <20190828112340.GB7466@dhcp22.suse.cz> <CAHS8izPPhPoqh-J9LJ40NJUCbgTFS60oZNuDSHmgtMQiYw72RA@mail.gmail.com>
 <20190829071807.GR28313@dhcp22.suse.cz> <cb7ebcce-05c5-3384-5632-2bbac9995c15@oracle.com>
In-Reply-To: <cb7ebcce-05c5-3384-5632-2bbac9995c15@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 5 Sep 2019 12:55:11 -0700
Message-ID: <CAHS8izP=8WDvZvTjenX5CtdKfYTbOO+bU7oK1Nx=r7QZrBjpaw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] hugetlb_cgroup: Add hugetlb_cgroup reservation limits
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Michal Hocko <mhocko@kernel.org>, shuah <shuah@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        khalid.aziz@oracle.com, open list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 3, 2019 at 10:58 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 8/29/19 12:18 AM, Michal Hocko wrote:
> > [Cc cgroups maintainers]
> >
> > On Wed 28-08-19 10:58:00, Mina Almasry wrote:
> >> On Wed, Aug 28, 2019 at 4:23 AM Michal Hocko <mhocko@kernel.org> wrote:
> >>>
> >>> On Mon 26-08-19 16:32:34, Mina Almasry wrote:
> >>>>  mm/hugetlb.c                                  | 493 ++++++++++++------
> >>>>  mm/hugetlb_cgroup.c                           | 187 +++++--
> >>>
> >>> This is a lot of changes to an already subtle code which hugetlb
> >>> reservations undoubly are.
> >>
> >> For what it's worth, I think this patch series is a net decrease in
> >> the complexity of the reservation code, especially the region_*
> >> functions, which is where a lot of the complexity lies. I removed the
> >> race between region_del and region_{add|chg}, refactored the main
> >> logic into smaller code, moved common code to helpers and deleted the
> >> duplicates, and finally added lots of comments to the hard to
> >> understand pieces. I hope that when folks review the changes they will
> >> see that! :)
> >
> > Post those improvements as standalone patches and sell them as
> > improvements. We can talk about the net additional complexity of the
> > controller much easier then.
>
> All such changes appear to be in patch 4 of this series.  The commit message
> says "region_add() and region_chg() are heavily refactored to in this commit
> to make the code easier to understand and remove duplication.".  However, the
> modifications were also added to accommodate the new cgroup reservation
> accounting.  I think it would be helpful to explain why the existing code does
> not work with the new accounting.  For example, one change is because
> "existing code coalesces resv_map entries for shared mappings.  new cgroup
> accounting requires that resv_map entries be kept separate for proper
> uncharging."
>
> I am starting to review the changes, but it would help if there was a high
> level description.  I also like Michal's idea of calling out the region_*
> changes separately.  If not a standalone patch, at least the first patch of
> the series.  This new code will be exercised even if cgroup reservation
> accounting not enabled, so it is very important than no subtle regressions
> be introduced.
>

Yep, seems I'm not calling out these changes as clearly as I should.
I'll look into breaking them into separate patches. I'll probably put
them as a separate patch or right behind current patchset 4, since
they are really done to make removing the coalescing a bit easier. Let
me look into that.

> --
> Mike Kravetz
