Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 144061512E0
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2020 00:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgBCXTH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Feb 2020 18:19:07 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44002 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgBCXTH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Feb 2020 18:19:07 -0500
Received: by mail-ot1-f68.google.com with SMTP id p8so15327081oth.10
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Feb 2020 15:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JZG+WtSGQs6QhG818eTrKWkOuEkoqiXKe+iz1pu4uMw=;
        b=kiJFgYh6yNJ0L2ecPXo+0jXN+6U8xrb9JtkyYqy3sE8LUhPMl5p9RBaffqUCdGGebE
         LV+1NURfNHCoklIRGG5UNpDL9JKrjRsBcDgdIU3Iy/5OBH0RAIagWOKEuawsfHnf+6Mn
         s/jyyzcRMDOKwGgOLBGycQM/xhhQapE69IRjL5t9dVaxVA4H4X/DSJWWMUV00IWeo6/n
         UmoAq69ILXgEvKgYpWH2xqUdIJkUvgeG30WzbMVUAt5FG9mvhFfM9KfAG1lmqVurAUfI
         lW5YiBxG4Bah8vesGavRLFwf9pBAk2vCpClJHZs2LMQlSNGHpYa9ZepQ1UvIUxR/Yxsz
         lNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JZG+WtSGQs6QhG818eTrKWkOuEkoqiXKe+iz1pu4uMw=;
        b=BXLQDka2+4de7QG1KDlFGW8i4G17l/2AWjE6bQL4/sVNq1MuHBiZW2w4PVHHeGa3vC
         ov94eagL+fqxunaG4jTljgvJ8QWucUUf6Xa+rbXodHgnfOcylDOd8KNHcxaFhqVWPVSF
         64x9wmjISd784XpBorwc0NAbZBlTfRJoGzeu1OaMOfcqIlbcUqWo8qkU0+4Y49w6x7Fu
         5lp8b8rDN0a50zbcSezDnhX6vZOPqM6yuW33zlgly0rQIqdz/K9WFiw0cyUsoOkltTMy
         E7AVrGNWoQuM0gaQ5kU5Eo3AgKc3Cny3ukhUeRlLNyws4b0LWdooYq7/gLEBLL/R8OuW
         U+Aw==
X-Gm-Message-State: APjAAAWkyknElYH4bzwgYgJOhM8YkxhHdJQDJpWvJWR2k4v6fNRdeGkq
        ZHxdCHCH9qFaQKGvQlWHCbOF6v68ktQ7zZ60DQRrpw==
X-Google-Smtp-Source: APXvYqwaAdLyjwn98pa+6a96VcAqNjbWTndQSAHzQhZDsrfJdeG21nIO+WKsmdVQsFSjR17QNJNgzKBxSy1spQxw+A4=
X-Received: by 2002:a9d:2028:: with SMTP id n37mr20463716ota.127.1580771945917;
 Mon, 03 Feb 2020 15:19:05 -0800 (PST)
MIME-Version: 1.0
References: <20200115012651.228058-1-almasrymina@google.com>
 <20200115012651.228058-7-almasrymina@google.com> <7ce6d59f-fd73-c529-2ad6-edda9937966d@linux.ibm.com>
 <alpine.DEB.2.21.2001291257510.175731@chino.kir.corp.google.com> <98c83a41-b864-5950-488c-443f6ef60b91@linux.ibm.com>
In-Reply-To: <98c83a41-b864-5950-488c-443f6ef60b91@linux.ibm.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 3 Feb 2020 15:18:55 -0800
Message-ID: <CAHS8izOh5nbTbv3+UxdLH-LHD-RKNEHoCzHCExggTbvgta-itg@mail.gmail.com>
Subject: Re: [PATCH v10 7/8] hugetlb_cgroup: Add hugetlb_cgroup reservation tests
To:     Sandipan Das <sandipan@linux.ibm.com>
Cc:     David Rientjes <rientjes@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
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

On Wed, Jan 29, 2020 at 10:11 PM Sandipan Das <sandipan@linux.ibm.com> wrote:
>
> Hi David,
>
> On 30/01/20 2:30 am, David Rientjes wrote:
> > On Thu, 23 Jan 2020, Sandipan Das wrote:
> >
> >> For powerpc64, either 16MB/16GB or 2MB/1GB huge pages are supported depending
> >> on the MMU type (Hash or Radix). I was just running these tests on a powerpc64
> >> system with Hash MMU and ran into problems because the tests assume that the
> >> hugepage size is always 2MB. Can you determine the huge page size at runtime?
> >>
> >
> > I assume this is only testing failures of the tools/testing/selftests
> > additions that hardcode 2MB paths and not a kernel problem?  In other
> > words, you can still boot, reserve, alloc, and free hugetlb pages on ppc
> > after this patchset without using the selftests?
> >
>
> Yes, its just the hardcoded paths. I didn't run into any kernel problems.
>

Sandipan, I updated the tests to not assume 2MB page size, but I'm
having trouble getting a setup with a non-2MB default size to test
with. I'm uploading v11 of the series shortly, please let me know if
the problem persists.

> - Sandipan
>
