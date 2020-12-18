Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D391A2DE318
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Dec 2020 14:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbgLRNGV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Dec 2020 08:06:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53392 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727240AbgLRNGV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Dec 2020 08:06:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608296694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e/CHgMLH2UdVHVqifkFPGlm0faQZyFjgpZO1JW9Bwng=;
        b=H7siudVoExcOES8FcVNtN7nqlGhjSCp0hUA6nJiqBFbFa+ifpuNgym4CAgsEEShmf2mklb
        aPaGStqKZuYSieThfOdDBXZ0cO3+wgNHOx3+RXcasLdsipjzx5Nl2SAnE2DArZXJ1ULfes
        OxR3+fJhp3gDpIzBFBoh/GVqqzKhMCc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-4DnBAfv_OZaJQ7JSE1Qw4w-1; Fri, 18 Dec 2020 08:04:52 -0500
X-MC-Unique: 4DnBAfv_OZaJQ7JSE1Qw4w-1
Received: by mail-wm1-f69.google.com with SMTP id k128so715652wme.7
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Dec 2020 05:04:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=e/CHgMLH2UdVHVqifkFPGlm0faQZyFjgpZO1JW9Bwng=;
        b=OTR4SY43X/ZtAcXVqAXVbtRUN3cg2GdWSr1qKUSg308BPs+rSJV/0hszNqtXtwu4jt
         ZhREHs9WTnZOB89579lOvHfnrjc3XV8XgGW076At6sysO9vM/vjyZuw2oOr8hUpN1O/R
         CGjyujfUce5kUbToSuNVzAli/fmiuP4LARoh8xJLrPG3KwDuNFj8ZNxlyttO3yK/czlx
         K6oTqlp7Onp8x7uLm1v05D6xSdjE24jA8LxnqXxOtVT7xHmuP5jKYDVRzZvn7+oe26Gs
         XCWNlp135wVRzoH95Z30UAsRAzLlf4+o9vBYCiS/sKoFWo89GUJpcFppZ055EcGT7OnJ
         2Bcg==
X-Gm-Message-State: AOAM530RKfSxDq705cZ+g9HNTlo0CVVs4i4u/0bmQecBp649UuZjeA7f
        TaYCwxqh/lffDJnJngX4Qr7Z/zFS08T7uuhIlw3Qce57OowdbguOaBO+0nA0l1zC3NpOoWdWEgZ
        xXYkSdrum8/5FlP2N30JA7R+5+ou3
X-Received: by 2002:a5d:674c:: with SMTP id l12mr4337394wrw.399.1608296690709;
        Fri, 18 Dec 2020 05:04:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwvXjhuHussNqD/bNTJR7GABzVwieD5LhDI+X6Xwo5OKXtYsMIhoNZrAqgzmYzqeytY6lA7sw==
X-Received: by 2002:a5d:674c:: with SMTP id l12mr4337352wrw.399.1608296690473;
        Fri, 18 Dec 2020 05:04:50 -0800 (PST)
Received: from [192.168.3.114] (p5b0c6327.dip0.t-ipconnect.de. [91.12.99.39])
        by smtp.gmail.com with ESMTPSA id k10sm12747574wrq.38.2020.12.18.05.04.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Dec 2020 05:04:49 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 08/10] mm/gup: limit number of gup migration failures, honor failures
Date:   Fri, 18 Dec 2020 14:04:48 +0100
Message-Id: <1671AFC0-3D06-4C4E-934D-CB6DC0AFE4A1@redhat.com>
References: <CA+CK2bCn++2Sk4-Eunibj6f+JoOL77uJQXGU2+dScHQ3RgC7_Q@mail.gmail.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, mike.kravetz@oracle.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        linux-kselftest@vger.kernel.org
In-Reply-To: <CA+CK2bCn++2Sk4-Eunibj6f+JoOL77uJQXGU2+dScHQ3RgC7_Q@mail.gmail.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
X-Mailer: iPhone Mail (18B92)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


> Am 18.12.2020 um 13:43 schrieb Pavel Tatashin <pasha.tatashin@soleen.com>:=

>=20
> =EF=BB=BFOn Fri, Dec 18, 2020 at 5:46 AM Michal Hocko <mhocko@suse.com> wr=
ote:
>>=20
>> On Thu 17-12-20 13:52:41, Pavel Tatashin wrote:
>> [...]
>>> +#define PINNABLE_MIGRATE_MAX 10
>>> +#define PINNABLE_ISOLATE_MAX 100
>>=20
>> Why would we need to limit the isolation retries. Those should always be
>> temporary failure unless I am missing something.
>=20
> Actually, during development, I was retrying isolate errors
> infinitely, but during testing found a hung where when FOLL_TOUCH
> without FOLL_WRITE is passed (fault in kernel without write flag), the
> zero page is faulted. The isolation of the zero page was failing every
> time, therefore the process was hanging.
>=20
> Since then, I fixed this problem by adding FOLL_WRITE unconditionally
> to FOLL_LONGTERM, but I was worried about other possible bugs that
> would cause hangs, so decided to limit isolation errors. If you think
> it its not necessary, I can unlimit isolate retires.
>=20
>> I am not sure about the
>> PINNABLE_MIGRATE_MAX either. Why do we want to limit that? migrate_pages
>> already implements its retry logic why do you want to count retries on
>> top of that? I do agree that the existing logic is suboptimal because
>=20
> True, but again, just recently, I worked on a race bug where pages can
> end up in per-cpu list after lru_add_drain_all() but before isolation,
> so I think retry is necessary.
>=20
>> the migration failure might be ephemeral or permanent but that should be
>> IMHO addressed at migrate_pages (resp. unmap_and_move) and simply report
>> failures that are permanent - e.g. any potential pre-existing long term
>> pin - if that is possible at all. If not what would cause permanent
>> migration failure? OOM?
>=20
> Yes, OOM is the main cause for migration failures. And also a few
> cases described in movable zone comment, where it is possible during
> boot some pages can be allocated by memblock in movable zone due to
> lack of memory resources (even if those resources were added later),
> hardware page poisoning is another rare example.
>=20

How is concurrent migration handled? Like memory offlining, compaction, allo=
c_contig_range() while trying to pin?


>> --
>> Michal Hocko
>> SUSE Labs
>=20

