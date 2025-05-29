Return-Path: <linux-kselftest+bounces-33977-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88311AC771E
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 06:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4928D4E6CA0
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 04:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564832512E5;
	Thu, 29 May 2025 04:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CcbW3Ysc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2595E35957
	for <linux-kselftest@vger.kernel.org>; Thu, 29 May 2025 04:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748492818; cv=none; b=LeUEpaas/fis+s7GG+rAkDML6FR8+8Y6S7/ZlYxPG4164oTo2QU2gan6FuSY891o6JHcwGi3PLoL1KKi+hzDYyVGIMvfbSFFr4W5KGUCOKug+pGEvYPgMKACOL797sb0wb5VlVDTMoHsKYe8onPN9IZBd1GH7hChiEDuTi2NcKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748492818; c=relaxed/simple;
	bh=pYPKV5QdqytLtYiDi2Lew5nroHWz5XB/ByBnjfZiH9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FH1VtKfYDGSrU/q619MFXO3UtfhtHnJrUGAX1P5Ydv+Bc5zUn84iTLt7TqZV8ry47aT36ejZYRtDUc/HdDPqqJzcEwWD/+DPL8vDOV2RHAiNeV/PrlazgIiX+10a7g7bvUP8cFNOYSKf2O5wuNm6AgRjFs+QGqektmztHWIraR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CcbW3Ysc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748492815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ex3pdBmkOUDRqy601U9SQqEbyhPUzX43nDu/KUjEDkA=;
	b=CcbW3Ysc6PzyTw3jq9p1g+aCRGFOkHmEO45HWGkNxiNNGrxHSlcJmc/DoK010OMyyDlAYp
	epFR/LeE1GHRIX9lQ6lvUeKmTBPnqFv4OLY9OgUfLkCMWtcPEGWRLlQyXqjJYVbThE1ALe
	uWS7c0tilr+L1n1T2YV8UEinS3OssaQ=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-kmJGPqpfNnyi_XHtO6fMQw-1; Thu, 29 May 2025 00:26:53 -0400
X-MC-Unique: kmJGPqpfNnyi_XHtO6fMQw-1
X-Mimecast-MFC-AGG-ID: kmJGPqpfNnyi_XHtO6fMQw_1748492813
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-70e2b627b47so8899277b3.2
        for <linux-kselftest@vger.kernel.org>; Wed, 28 May 2025 21:26:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748492813; x=1749097613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ex3pdBmkOUDRqy601U9SQqEbyhPUzX43nDu/KUjEDkA=;
        b=tkcC14iFMraZgf4gngVIIg0ybxeQBUzG2IceRBbqOhudG6iVchUzgrHXC6gjnDuDGN
         E6qjuR+p1ojcTPMPRHLbRvLoVbTtIx21JBIqGGjY4eOyp6/AEPWfmLNOEIvUz6bGlMKI
         GRKKeydDiFHXXChr0aad62cL5GJo5nB6F4G91okoIf8KZlupgudHlktGi/1IijTxREBZ
         KJdlHPtb7kLrMRKyHnB11Zqot8TnYmNiGE/Lbt6kMoyvl0dNLzRuN8dJEcVPLNiads+A
         Dm3JVTNmAeu7YghUErMLeTQ1+zBTSdgS4cDv2+blYUuzGuHKIqzBtZBkFHku3jflo7DU
         hcbw==
X-Forwarded-Encrypted: i=1; AJvYcCWLn5x7qbHzmMIXt/LEV4hucTmXNzL1iK2rItb3uG5ZtPlWfPk8IpFKZ4IzNwXfuTKYrQZe2LBTBBtaU2LAl9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQGJLdc5SemY9OhXhLIUZv3RUnSVqCRw5/LDnWZyTvAmNnu3Fr
	Ws09pnUidQYza1ICAKj+pXoQ0/MTFs0a46np6slPpc2LIRjap7WMwAg37yHODKnEFnlB8EvfTq/
	zu9405/8HuiBeXi2FdHDBQLZgkaXFngR8YT498LWIk2sV5WBJIV1O4HZvm0s2xGTkgaD2BLP8Mx
	k0Al7SbVWVMnj8PsIO5ocSz4F/Z8unxAEuOa7BIgWEJdNI
X-Gm-Gg: ASbGncvwnbLs+DkDXEzOJTkKdmqWxsFoiiQXQp2efnpIyU405KXVAndSJoCzW1MsqAX
	wX/WVuYEMWCrm3OygBIkHD61BCcufiCP5bWUSljoGVDsFaONbO43R/9YOPP+iAc3PrxPZpf8=
X-Received: by 2002:a05:690c:15:b0:70e:7ff6:9fd0 with SMTP id 00721157ae682-70f3147ae7amr69347317b3.35.1748492812669;
        Wed, 28 May 2025 21:26:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGa/qWJYpJ/+QQie7VzzCQqjW7fcD4CgkSyasKC81Gvwr9UAPZCZblvzZ/MNvjAq7MgTXKwRCRo7nhYrIssl3A=
X-Received: by 2002:a05:690c:15:b0:70e:7ff6:9fd0 with SMTP id
 00721157ae682-70f3147ae7amr69347107b3.35.1748492812231; Wed, 28 May 2025
 21:26:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515033857.132535-1-npache@redhat.com> <a8bc6012-578b-412a-8dc9-fa9349feaa8b@lucifer.local>
 <CAA1CXcD8FCdCsBkyW=Ppbr-ZRD8PNmPu-3khipX0fVK3mxs-EQ@mail.gmail.com> <c027a3db-eb6d-4a3c-98b0-635f3f842ee6@lucifer.local>
In-Reply-To: <c027a3db-eb6d-4a3c-98b0-635f3f842ee6@lucifer.local>
From: Nico Pache <npache@redhat.com>
Date: Wed, 28 May 2025 22:26:25 -0600
X-Gm-Features: AX0GCFubEhLqG8ZmT5mBKytjQcZ__0Xo41eeNzsj8MkbhGwDDub_V9w5CoIgzsg
Message-ID: <CAA1CXcAfbzwr7QC6JngPvTPtBSf=6WfnhVn+gK2rHMrSTuS8vw@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] mm: introduce THP deferred setting
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	rientjes@google.com, hannes@cmpxchg.org, rdunlap@infradead.org, 
	mhocko@suse.com, Liam.Howlett@oracle.com, zokeefe@google.com, 
	surenb@google.com, jglisse@google.com, cl@gentwo.org, jack@suse.cz, 
	dave.hansen@linux.intel.com, will@kernel.org, tiwai@suse.de, 
	catalin.marinas@arm.com, anshuman.khandual@arm.com, dev.jain@arm.com, 
	raquini@redhat.com, aarcange@redhat.com, kirill.shutemov@linux.intel.com, 
	yang@os.amperecomputing.com, thomas.hellstrom@linux.intel.com, 
	vishal.moola@gmail.com, sunnanyong@huawei.com, usamaarif642@gmail.com, 
	wangkefeng.wang@huawei.com, ziy@nvidia.com, shuah@kernel.org, 
	peterx@redhat.com, willy@infradead.org, ryan.roberts@arm.com, 
	baolin.wang@linux.alibaba.com, baohua@kernel.org, david@redhat.com, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	corbet@lwn.net, akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 5:25=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> To start with I do apologise for coming to this at v6, I realise it's
> irritating to have push back at this late stage. This is more so my attem=
pt
> to understand where this series -sits- so I can properly review it.

No worries at all! The only thing that frustrates/upsets me in
upstream mailing lists is unprovoked rudeness (which you have not
been).
>
> So please bear with me here :)
>
> So, I remain very confused. This may just be a _me_ thing here :)
>
> So let me check my understanding:
>
> 1. This series introduces this new THP deferred mode.
> 2. By 'follow-up' really you mean 'inspired by' or 'related to' right?
> 3. If this series lands before [1], commits 2 - 4 are 'undefined
>    behaviour'.
The khugepaged mTHP support should land first as without it, adding a
defer option to the global parameters, makes for undefined behavior in
the sysctls from a admin perspective.
>
> In my view if 3 is true this series should be RFC until [1] merges.
Ideally I was trying to get them merged together (Andrew actually had
them both in mm-new a few weeks ago, but a bug was found that got it
pulled, but that is fixed now). The series' complement each other
nicely.
>
> If I've got it wrong and this needs to land first, we should RFC [1].
The khugepaged series [1] should get merged first, but I was shooting
for both at the same time.
>
> That way we can un-RFC once the dependency is met.
>
> We have about 5 [m]THP series in flight at the moment, all touching at
> least vaguely related stuff, so any help for reviewers would be hugely
> appreciated thanks :)
>
> On Wed, May 21, 2025 at 04:41:54AM -0600, Nico Pache wrote:
> > On Tue, May 20, 2025 at 3:43=E2=80=AFAM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > On Wed, May 14, 2025 at 09:38:53PM -0600, Nico Pache wrote:
> > > > This series is a follow-up to [1], which adds mTHP support to khuge=
paged.
> > > > mTHP khugepaged support is a "loose" dependency for the sysfs/sysct=
l
> > > > configs to make sense. Without it global=3D"defer" and  mTHP=3D"inh=
erit" case
> > > > is "undefined" behavior.
> > >
> > > How can this be a follow up to an unmerged series? I'm confused by th=
at.
> > Hi Lorenzo,
> >
> > follow up or loose dependency. Not sure the correct terminology.
> >
>
> See above. Let's nail this down please.
>
> > Either way, as I was developing this as a potential solution for the
> > THP internal fragmentation issue, upstream was working on adding
> > mTHPs. By adding a new THP sysctl entry I noticed mTHP would now be
> > missing the same entry. Furthermore I was told mTHP support for
> > khugepaged was a desire, so I began working on it in conjunction. So
> > given the undefined behavior of defer globally while any mix of mTHP
> > settings, it became dependent on the khugepaged support. Either way
> > patch 1 of this series is the core functionality. The rest is to fill
> > the undefined behavior gap.
> > >
> > > And you're saying that you're introducing 'undefined behaviour' on th=
e
> > > assumption that another series which seems to have quite a bit of
> > > discussion let to run will be merged?
> > This could technically get merged without the mTHP khugepaged changes,
> > but then the reviews would probably all be pointing out what I pointed
> > out above. Chicken or Egg problem...
> > >
> > > While I'd understand if this was an RFC just to put the idea out ther=
e,
> > > you're not proposing it as such?
> > Nope we've already discussed this in both the MM alignment and thp
> > upstream meetings, no one was opposing it, and a lot of testing was
> > done-- by me, RH's CI, and our perf teams. Ive posted several RFCs
> > before posting a patchset.
> > >
> > > Unless there's a really good reason we're doing this way (I may be mi=
ssing
> > > something), can we just have this as an RFC until the series it depen=
ds on
> > > is settled?
> > Hopefully paragraph one clears this up! They were built in
> > conjunction, but posting them as one series didn't feel right (and
> > IIRC this was also discussed, and this was decided).
>
> 'This was also discussed and this was decided' :)
>
> I'm guessing rather you mean discussion was had with other reviewers and =
of
> course our earstwhile THP maintainer David, and you guys decided this mad=
e
> more sense?
>
> Obviously upstream discussion is what counts, but as annoying as it is, o=
ne
> does have to address the concerns of reviewers even if late to a series
> (again, apologies for this).
>
> So, to be clear - I'm not intending to hold up or block the series, I jus=
t
> want to understand how things are, this is the purpose here.

Thanks I do appreciate the discussion around the process as I am
fairly new to upstream work (at least to this magnitude). I have been
mostly downstream focused for the last 6 years and I'm trying to shift
upstream as much as possible. So please bear with me as I learn all
the minor undocumented caveats!
>
> Thanks!
>
> > >
> > > >
> > > > We've seen cases were customers switching from RHEL7 to RHEL8 see a
> > > > significant increase in the memory footprint for the same workloads=
.
> > > >
> > > > Through our investigations we found that a large contributing facto=
r to
> > > > the increase in RSS was an increase in THP usage.
> > > >
> > > > For workloads like MySQL, or when using allocators like jemalloc, i=
t is
> > > > often recommended to set /transparent_hugepages/enabled=3Dnever. Th=
is is
> > > > in part due to performance degradations and increased memory waste.
> > > >
> > > > This series introduces enabled=3Ddefer, this setting acts as a midd=
le
> > > > ground between always and madvise. If the mapping is MADV_HUGEPAGE,=
 the
> > > > page fault handler will act normally, making a hugepage if possible=
. If
> > > > the allocation is not MADV_HUGEPAGE, then the page fault handler wi=
ll
> > > > default to the base size allocation. The caveat is that khugepaged =
can
> > > > still operate on pages that are not MADV_HUGEPAGE.
> > > >
> > > > This allows for three things... one, applications specifically desi=
gned to
> > > > use hugepages will get them, and two, applications that don't use
> > > > hugepages can still benefit from them without aggressively insertin=
g
> > > > THPs at every possible chance. This curbs the memory waste, and def=
ers
> > > > the use of hugepages to khugepaged. Khugepaged can then scan the me=
mory
> > > > for eligible collapsing. Lastly there is the added benefit for thos=
e who
> > > > want THPs but experience higher latency PFs. Now you can get base p=
age
> > > > performance at the PF handler and Hugepage performance for those ma=
ppings
> > > > after they collapse.
> > > >
> > > > Admins may want to lower max_ptes_none, if not, khugepaged may
> > > > aggressively collapse single allocations into hugepages.
> > > >
> > > > TESTING:
> > > > - Built for x86_64, aarch64, ppc64le, and s390x
> > > > - selftests mm
> > > > - In [1] I provided a script [2] that has multiple access patterns
> > > > - lots of general use.
> > >
> > > OK so this truly is dependent on the unmerged series? Or isn't it?
> > >
> > > Is your testing based on that?
> > Most of the testing was done in conjunction, but independent testing
> > was also done on this series (including by a large customer that was
> > itching to try the changes, and they were very satisfied with the
> > results).
>
> You should make this very clear in the cover letter.
I will try to do better at updating and providing more information in
my cover letters and patches. I was never sure how much information to
include! I guess the more the merrier.
>
> > >
> > > Because again... that surely makes this series a no-go until we land =
the
> > > prior (which might be changed, and thus necessitate re-testing).
> > >
> > > Are you going to provide any of these numbers/data anywhere?
> > There is a link to the results in this cover letter
> > [3] - https://people.redhat.com/npache/mthp_khugepaged_defer/testoutput=
2/output.html
> > >
>
> Ultimately it's not ok in mm to have a link to a website that might go aw=
ay
> any time, these cover letters are 'baked in' to the commit log. Are you
> sure this website with 'testoutput2' will exist in 10 years time? :)
>
> You should at the very least add a summary of this data in the cover
> letter, perhaps referring back to this link as 'at the time of writing fu=
ll
> results are available at' or something like this.

Ok good to know I will find a way to summarize the performance and
result changes more cleanly in the cover letter.
>
> > > > - redis testing. This test was my original case for the defer mode.=
 What I
> > > >    was able to prove was that THP=3Dalways leads to increased max_l=
atency
> > > >    cases; hence why it is recommended to disable THPs for redis ser=
vers.
> > > >    However with 'defer' we dont have the max_latency spikes and can=
 still
> > > >    get the system to utilize THPs. I further tested this with the m=
THP
> > > >    defer setting and found that redis (and probably other jmalloc u=
sers)
> > > >    can utilize THPs via defer (+mTHP defer) without a large latency
> > > >    penalty and some potential gains. I uploaded some mmtest results
> > > >    here[3] which compares:
> > > >        stock+thp=3Dnever
> > > >        stock+(m)thp=3Dalways
> > > >        khugepaged-mthp + defer (max_ptes_none=3D64)
> > > >
> > > >   The results show that (m)THPs can cause some throughput regressio=
n in
> > > >   some cases, but also has gains in other cases. The mTHP+defer res=
ults
> > > >   have more gains and less losses over the (m)THP=3Dalways case.
> > > >
> > > > V6 Changes:
> > > > - nits
> > > > - rebased dependent series and added review tags
> > > >
> > > > V5 Changes:
> > > > - rebased dependent series
> > > > - added reviewed-by tag on 2/4
> > > >
> > > > V4 Changes:
> > > > - Minor Documentation fixes
> > > > - rebased the dependent series [1] onto mm-unstable
> > > >     commit 0e68b850b1d3 ("vmalloc: use atomic_long_add_return_relax=
ed()")
> > > >
> > > > V3 Changes:
> > > > - Combined the documentation commits into one, and moved a section =
to the
> > > >   khugepaged mthp patchset
> > > >
> > > > V2 Changes:
> > > > - base changes on mTHP khugepaged support
> > > > - Fix selftests parsing issue
> > > > - add mTHP defer option
> > > > - add mTHP defer Documentation
> > > >
> > > > [1] - https://lore.kernel.org/all/20250515032226.128900-1-npache@re=
dhat.com/
> > > > [2] - https://gitlab.com/npache/khugepaged_mthp_test
> > > > [3] - https://people.redhat.com/npache/mthp_khugepaged_defer/testou=
tput2/output.html
> > > >
> > > > Nico Pache (4):
> > > >   mm: defer THP insertion to khugepaged
> > > >   mm: document (m)THP defer usage
> > > >   khugepaged: add defer option to mTHP options
> > > >   selftests: mm: add defer to thp setting parser
> > > >
> > > >  Documentation/admin-guide/mm/transhuge.rst | 31 +++++++---
> > > >  include/linux/huge_mm.h                    | 18 +++++-
> > > >  mm/huge_memory.c                           | 69 ++++++++++++++++++=
+---
> > > >  mm/khugepaged.c                            |  8 +--
> > > >  tools/testing/selftests/mm/thp_settings.c  |  1 +
> > > >  tools/testing/selftests/mm/thp_settings.h  |  1 +
> > > >  6 files changed, 106 insertions(+), 22 deletions(-)
> > > >
> > > > --
> > > > 2.49.0
> > > >
> > >
> >
>
> Cheers, Lorenzo
>


