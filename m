Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94D701512CE
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2020 00:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgBCXQe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Feb 2020 18:16:34 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40765 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbgBCXQe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Feb 2020 18:16:34 -0500
Received: by mail-ot1-f66.google.com with SMTP id i6so15355011otr.7
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Feb 2020 15:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gsc+LSdKFmfEHsLu/PX4b/f2W5uTYqD7V4ZzUh0Ir80=;
        b=PuWaEsvTmioKz64Q7uPVIOp/N9rPTq6akD7fqQtuRHWmOto7GXFjEFiiaZpfiF2Oxm
         iiczLvMdxA7gX9/mjBZ8ZtnwN2sHqrC4OBRhqMuKo/g8CFJUF+GRekmD2R+YG1Iv8ntP
         fvondbVEOz76kPzh9Un/lXTwJbkoWs/H0ReXrgjISGWRnNPuEoN9WDxUbtR5u29xfZkT
         oAskXk7P2RCKYytwQ3FeJKx5ywr9hbBBXemLv/eTKuTK7Wqc8IrNS1TLr78w9ZSqkxGE
         M2MJ58f6NMmbvet66LP8q6Ze6KZ4eCoAqPGksDNrj2NLgtH1atGYQqMO7zviLvsOv0oa
         pnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gsc+LSdKFmfEHsLu/PX4b/f2W5uTYqD7V4ZzUh0Ir80=;
        b=aCnR1y1Fjy6Euy6kMrZaESjiLLpOVO+Cd8R/W06M7idtcteAqTd7j3os3ph41Ktaqc
         S+gcW+Me4PY2qCUK1N7btqqVMd6BEIjiphGlTZ3Pk6AhjRkG1F+oIrkcUPrAMMusyPbR
         58Rx9fnqbATh/7e2ut1BsxRmg/IbzwOeui67AJk1ptKHHmt91/pW8wLvRxrdAlMtc8kB
         Nb4kD133aPcio+iocuRHiGIybbAvcaKHPxJVpOSbKJgnk/wIi+GFf3mSwJZl+Zbz4PRu
         aBR/A/vzC9a9qxJUZvA/8fFYhzQ1+GPUgSBoNpCRkcEuvyA6iDqj61rWGChsFylN+WIU
         EY9Q==
X-Gm-Message-State: APjAAAXDSC3MSjtIBclX1Vl6Wm4jk77lkGnAKYxMGhn8w4ue54Mzwg5b
        IpMblqeld8SbJDI2ISUuAXwzicBqs92UNzEuo+N58A==
X-Google-Smtp-Source: APXvYqxks0BGaZknNqKFAhn+gbM4R5qvozx7t1UrbqkSMA2wJouCmnamEYFBah6ouIgs/03HiorFYLE+SdLRPuvskdA=
X-Received: by 2002:a9d:518b:: with SMTP id y11mr18610845otg.349.1580771791890;
 Mon, 03 Feb 2020 15:16:31 -0800 (PST)
MIME-Version: 1.0
References: <20200115012651.228058-1-almasrymina@google.com> <alpine.DEB.2.21.2001291303230.175731@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.2001291303230.175731@chino.kir.corp.google.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 3 Feb 2020 15:16:21 -0800
Message-ID: <CAHS8izNq17U6i-RzHZ6tCOVQza_CGngJc0X2ZmqPHTH7y4kfdg@mail.gmail.com>
Subject: Re: [PATCH v10 1/8] hugetlb_cgroup: Add hugetlb_cgroup reservation counter
To:     David Rientjes <rientjes@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Shakeel Butt <shakeelb@google.com>, shuah <shuah@kernel.org>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> > Proposed Solution:
> > A new page counter named
> > 'hugetlb.xMB.reservation_[limit|usage|max_usage]_in_bytes'. This counter has
> > slightly different semantics than
> > 'hugetlb.xMB.[limit|usage|max_usage]_in_bytes':
> >
>
> Changelog looks like it needs to be updated with the new resv naming.
>

I updated to the rsvd naming, which you suggested earlier and Mike
agreed was better.

> > +
> >  static inline
> >  struct hugetlb_cgroup *hugetlb_cgroup_from_css(struct cgroup_subsys_state *s)
> >  {
>
> Small nit: hugetlb_cgroup_get_counter(), to me, implies incrementing a
> reference count, perhaps a better name would be in order.  No strong
> preference.
>

Changed
> >       /* Add the events file */
> > -     cft = &h->cgroup_files_dfl[2];
> > +     cft = &h->cgroup_files_dfl[4];
> >       snprintf(cft->name, MAX_CFTYPE_NAME, "%s.events", buf);
> >       cft->private = MEMFILE_PRIVATE(idx, 0);
> >       cft->seq_show = hugetlb_events_show;
>
> Any cleanup to __hugetlb_cgroup_file_dfl_init() and
> __hugetlb_cgroup_file_legacy_init() that is possible would be great in a
> follow-up patch :)
>

Will do!

> Other than that, this looks very straight forward.
>
> Acked-by: David Rientjes <rientjes@google.com>
