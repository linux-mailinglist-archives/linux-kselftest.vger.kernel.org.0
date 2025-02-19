Return-Path: <linux-kselftest+bounces-27016-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 353B3A3CA92
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 21:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D26961781BF
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 20:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26042505A0;
	Wed, 19 Feb 2025 20:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cS8/Y9/j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DA224E4DE
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Feb 2025 20:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739998605; cv=none; b=dquu5NqaO+mMMsODtsFNmTMsiLwBoP703g3Xvb9gBMaAaC/i8Rhi9sVNRkEGzreIius7kr65qCY7VhLuPuqsCsUTUTMw2gGQqooIluYcnEenu2qQfZ/umw2tJLlbBaLHErIaEG8KCd86olrsXnOU0xeO9nK0NMlxydx0dibE7iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739998605; c=relaxed/simple;
	bh=QnG8SEamObBuiIMCf7KmVArDMeAn6Gi4mO2vSDLCQt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ON0fL1IedPGTXN1H1/pmADMjkfmBKrTXgMvr59T3DI0JkOCSAeot8crabQGQJQwvBc7hDnXpiBNa/TtYartuyR/zfeUy3eZBxyRLBf7CysD1+q1wd3l6IjDLg1ZeWgWXYkHtCMwYHDyzqjm+t8JJapIziHW9oat/k0JGnfmDslA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cS8/Y9/j; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22117c396baso8625ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Feb 2025 12:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739998603; x=1740603403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QnG8SEamObBuiIMCf7KmVArDMeAn6Gi4mO2vSDLCQt0=;
        b=cS8/Y9/jpsiQgjkKSWR42u3QNW7sYnizn7Po5GKizgz7m0HLt7VY+eWgZc3TuqEs5D
         ItczCY7D37cqQIXgJsYQueINM6rac772LDHofk29ZJMCx4QwxkB+LuSktZTX8MaDL7xn
         0HLJUionlg4jDtbD2vRq6w+RkFozB0JNjRauB2p6BiAgadA9JPuie+V55GiWkce/CCYr
         DYj6DVMDn5mOK7L+xvnahXUSyGPNu2bW37SkTnoBgrfwnVY4ZOOrov7080oTDjEQkEev
         P5kFqcxxyRnVhFigRnh+vRYpc/wYGbnSQZFw7Krf6S7cse1wXKDM6dh6ADkJOnriRFyE
         6CJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739998603; x=1740603403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QnG8SEamObBuiIMCf7KmVArDMeAn6Gi4mO2vSDLCQt0=;
        b=DdGlrs1Lm9EoN7yizLdDal5EuIpIKSabWeSmi3A2kXRcBqE2wQfncNVoa1GiKCEsYC
         ox3UD4NcL2Rjh0VqMa1VkfZVfsJVQRob2RCz3fPrid9d3Bb7ye3YXNVfh6mbmZR/HkGB
         QNIMeyRuOIvaS6qD/H0Kqj4Q2+jcuEkj1TCEIY8hWZzzMMvZTKpdTBppD5OmTswPaD2D
         Rnu0AsNjQF1IoyZgXb+tRZ4u+v01qPNqnUtAIeBj7IQLx6lYrJU60iIPvo4arIboRq6b
         iQBXaJvbUJ/eKVVJ7h2SiRNzx8KdpfHGbo0mgrw3QNyKueV67E0a/Fk7vgjpbJBAamvl
         AH9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXij4liBPKGGRgiFNoxRoObUnbBwzLPNMKoqV/VfA5r2Ng+KEoClli36jYTbWIDpoehGdStz/Tnx3anJMx/9WI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwZUoMaRwOxiaScryj6khjdJCd4cIB/x1V4fmNP0SoibSDU9kz
	wsA/r0vBtpsJ40E6fPA7qR40wzh4xLwJBrtJrQ7AlmopVtko0guAFecTd5RUVXf+CBf3MGF2/l9
	zcOJk6lDVLQE0DCpSxMx4GxZ5F1OwLO9lLciT
X-Gm-Gg: ASbGncstTqlZ9QFsFbLEMs4u/KodkZPFd2YfjlFOzEdqrLJUzjRbCD5k6hsbpxzTgEt
	8yvqva0dqQbwmqugflt0qyn12XG+q+YEsyDUZbthyPZ/f3OlpnzgKMJl2/NrAOUAdhL/hhgI2U6
	Kdcs0bKnUQg/OSkcOEPZjGqKDlu5Y=
X-Google-Smtp-Source: AGHT+IFe/qAXXHMG11QgG9tLNjslwzcmEjlHXjncZ98KGM4VEwqJXA9x482HDiIZJNWdb53GcTKtRVIS9ahIvNUCJ8c=
X-Received: by 2002:a17:902:f68c:b0:216:7aaa:4c5f with SMTP id
 d9443c01a7336-2218e0f2c10mr437695ad.3.1739998602713; Wed, 19 Feb 2025
 12:56:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
 <CAC_TJveMB1_iAUt81D5-+z8gArbVcbfDM=djCZG_bRVaCEMRmg@mail.gmail.com>
 <45297010-a0a4-4a42-84e8-6f4764eab3b3@lucifer.local> <41af4ffb-0383-4d00-9639-0bf16e1f5f37@redhat.com>
 <a2e12142-3eb2-48c9-b0d9-35a86cb56eec@lucifer.local> <CAC_TJvf6fOACObzR0ANFFrD+ecrP8MbXEZ_ZdzRu0Lg4RunS9g@mail.gmail.com>
 <e07dfd31-197c-49d0-92bd-12aad02daa7e@lucifer.local>
In-Reply-To: <e07dfd31-197c-49d0-92bd-12aad02daa7e@lucifer.local>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Wed, 19 Feb 2025 12:56:31 -0800
X-Gm-Features: AWEUYZkrEux9sPcJzlJVUSGba3dMcQMqfgKzAP1pAI9URr8_0NHa8B2vfhArMAE
Message-ID: <CAC_TJvfBvZZc=xyB0jez2VCDit-rettfQf7H4xhQbN7bYxKw-A@mail.gmail.com>
Subject: Re: [PATCH 0/4] mm: permit guard regions for file-backed/shmem mappings
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Juan Yescas <jyescas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 11:20=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Feb 19, 2025 at 10:52:04AM -0800, Kalesh Singh wrote:
> > On Wed, Feb 19, 2025 at 1:17=E2=80=AFAM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > On Wed, Feb 19, 2025 at 10:15:47AM +0100, David Hildenbrand wrote:
> > > > On 19.02.25 10:03, Lorenzo Stoakes wrote:
> > > > > On Wed, Feb 19, 2025 at 12:25:51AM -0800, Kalesh Singh wrote:
> > > > > > On Thu, Feb 13, 2025 at 10:18=E2=80=AFAM Lorenzo Stoakes
> > > > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > > > >
> > > > > > > The guard regions feature was initially implemented to suppor=
t anonymous
> > > > > > > mappings only, excluding shmem.
> > > > > > >
> > > > > > > This was done such as to introduce the feature carefully and =
incrementally
> > > > > > > and to be conservative when considering the various caveats a=
nd corner
> > > > > > > cases that are applicable to file-backed mappings but not to =
anonymous
> > > > > > > ones.
> > > > > > >
> > > > > > > Now this feature has landed in 6.13, it is time to revisit th=
is and to
> > > > > > > extend this functionality to file-backed and shmem mappings.
> > > > > > >
> > > > > > > In order to make this maximally useful, and since one may map=
 file-backed
> > > > > > > mappings read-only (for instance ELF images), we also remove =
the
> > > > > > > restriction on read-only mappings and permit the establishmen=
t of guard
> > > > > > > regions in any non-hugetlb, non-mlock()'d mapping.
> > > > > >
> > > > > > Hi Lorenzo,
> > > > > >
> > > > > > Thank you for your work on this.
> > > > >
> > > > > You're welcome.
> > > > >
> > > > > >
> > > > > > Have we thought about how guard regions are represented in /pro=
c/*/[s]maps?
> > > > >
> > > > > This is off-topic here but... Yes, extensively. No they do not ap=
pear
> > > > > there.
> > > > >
> > > > > I thought you had attended LPC and my talk where I mentioned this
> > > > > purposefully as a drawback?
> > > > >
> > > > > I went out of my way to advertise this limitation at the LPC talk=
, in the
> > > > > original series, etc. so it's a little disappointing that this is=
 being
> > > > > brought up so late, but nobody else has raised objections to this=
 issue so
> > > > > I think in general it's not a limitation that matters in practice=
.
> > > > >
> >
> > Sorry for raising this now, yes at the time I believe we discussed
> > reducing the vma slab memory usage for the PROT_NONE mappings. I
> > didn't imagine that apps could have dependencies on the mapped ELF
> > ranges in /proc/self/[s]maps until recent breakages from a similar
> > feature. Android itself doesn't depend on this but what I've seen is
> > banking apps and apps that have obfuscation to prevent reverse
> > engineering (the particulars of such obfuscation are a black box).
>
> Ack ok fair enough, sorry, but obviously you can understand it's
> frustrating when I went to great lengths to advertise this not only at th=
e
> talk but in the original series.
>
> Really important to have these discussions early. Not that really we can =
do
> much about this, as inherently this feature cannot give you what you need=
.
>
> Is it _only_ banking apps that do this? And do they exclusively read
> /proc/$pid/maps? I mean there's nothing we can do about that, sorry.

Not only banking apps but that's a common category.

> If that's immutable, then unless you do your own very, very, very slow cu=
stom
> android maps implementation (that will absolutely break the /proc/$pid/ma=
ps
> scalability efforts atm) this is just a no-go.
>

Yeah unfortunately that's immutable as app versions are mostly
independent from the OS version.

We do have something that handles this by encoding the guard regions
in the vm_flags, but as you can imagine it's not generic enough for
upstream.

> >
> > > > > >
> > > > > > In the field, I've found that many applications read the ranges=
 from
> > > > > > /proc/self/[s]maps to determine what they can access (usually r=
elated
> > > > > > to obfuscation techniques). If they don't know of the guard reg=
ions it
> > > > > > would cause them to crash; I think that we'll need similar entr=
ies to
> > > > > > PROT_NONE (---p) for these, and generally to maintain consisten=
cy
> > > > > > between the behavior and what is being said from /proc/*/[s]map=
s.
> > > > >
> > > > > No, we cannot have these, sorry.
> > > > >
> > > > > Firstly /proc/$pid/[s]maps describes VMAs. The entire purpose of =
this
> > > > > feature is to avoid having to accumulate VMAs for regions which a=
re not
> > > > > intended to be accessible.
> > > > >
> > > > > Secondly, there is no practical means for this to be accomplished=
 in
> > > > > /proc/$pid/maps in _any_ way - as no metadata relating to a VMA i=
ndicates
> > > > > they have guard regions.
> > > > >
> > > > > This is intentional, because setting such metadata is simply not =
practical
> > > > > - why? Because when you try to split the VMA, how do you know whi=
ch bit
> > > > > gets the metadata and which doesn't? You can't without _reading p=
age
> > > > > tables_.
> >
> > Yeah the splitting becomes complicated with any vm flags for this...
> > meaning any attempt to expose this in /proc/*/maps have to
> > unconditionally walk the page tables :(
>
> It's not really complicated, it's _impossible_ unless you made literally
> all VMA code walk page tables for every single operation. Which we are
> emphatically not going to do :)
>
> And no, /proc/$pid/maps is _never_ going to walk page tables. For obvious
> performance reasons.
>
> >
> > > > >
> > > > > /proc/$pid/smaps _does_ read page tables, but we can't start pret=
ending
> > > > > VMAs exist when they don't, this would be completely inaccurate, =
would
> > > > > break assumptions for things like mremap (which require a single =
VMA) and
> > > > > would be unworkable.
> > > > >
> > > > > The best that _could_ be achieved is to have a marker in /proc/$p=
id/smaps
> > > > > saying 'hey this region has guard regions somewhere'.
> > > >
> > > > And then simply expose it in /proc/$pid/pagemap, which is a better =
interface
> > > > for this pte-level information inside of VMAs. We should still have=
 a spare
> > > > bit for that purpose in the pagemap entries.
> > >
> > > Ah yeah thanks David forgot about that!
> > >
> > > This is also a possibility if that'd solve your problems Kalesh?
> >
> > I'm not sure what is the correct interface to advertise these. Maybe
> > smaps as you suggested since we already walk the page tables there?
> > and pagemap bit for the exact pages as well? It won't solve this
> > particular issue, as 1000s of in field apps do look at this through
> > /proc/*/maps. But maybe we have to live with that...
>
> I mean why are we even considering this if you can't change this anywhere=
?
> Confused by that.
>
> I'm afraid upstream can't radically change interfaces to suit this
> scenario.
>
> We also can't change smaps in the way you want, it _has_ to still give
> output per VMA information.

Sorry I wasn't suggesting to change the entries in smaps, rather
agreeing to your marker suggestion. Maybe a set of ranges for each
smaps entry that has guards? It doesn't solve the use case, but does
make these regions visible to userspace.

>
> The proposed change that would be there would be a flag or something
> indicating that the VMA has guard regions _SOMEWHERE_ in it.
>
> Since this doesn't solve your problem, adds complexity, and nobody else
> seems to need it, I would suggest this is not worthwhile and I'd rather n=
ot
> do this.
>
> Therefore for your needs there are literally only two choices here:
>
> 1. Add a bit to /proc/$pid/pagemap OR
> 2. a new interface.
>
> I am not in favour of a new interface here, if we can just extend pagemap=
.
>
> What you'd have to do is:
>
> 1. Find virtual ranges via /proc/$pid/maps
> 2. iterate through /proc/$pid/pagemaps to retrieve state for all ranges.
>

Could we also consider an smaps field like:

VmGuards: [AAA, BBB), [CCC, DDD), ...

or something of that sort?


> Since anything that would retrieve guard region state would need to walk
> page tables, any approach would be slow and I don't think this would be a=
ny
> less slow than any other interface.
>
> This way you'd be able to find all guard regions all the time.
>
> This is just the trade-off for this feature unfortunately - its whole
> design ethos is to allow modification of -faulting- behaviour without
> having to modify -VMA- behaviour.
>
> But if it's banking apps whose code you can't control (surprised you don'=
t
> lock down these interfaces), I mean is this even useful to you?
>
> If your requirement is 'you have to change /proc/$pid/maps to show guard
> regions' I mean the answer is that we can't.
>
> >
> > We can argue that such apps are broken since they may trip on the
> > SIGBUS off the end of the file -- usually this isn't the case for the
> > ELF segment mappings.
>
> Or tearing of the maps interface, or things getting unmapped or or
> or... It's really not a sane thing to do.
>
> >
> > This is still useful for other cases, I just wanted to get some ideas
> > if this can be extended to further use cases.
>
> Well I'm glad that you guys find it useful for _something_ ;)
>
> Again this wasn't written only for you (it is broadly a good feature for
> upstream), but I did have your use case in mind, so I'm a little
> disappointed that it doesn't help, as I like to solve problems.
>
> But I'm glad it solves at least some for you...

I recall Liam had a proposal to store the guard ranges in the maple tree?

I wonder if that can be used in combination with this approach to have
a better representation of this?

>
> >
> > Thanks,
> > Kalesh
> >
> >
> > >
> > > This bit will be fought over haha
> > >
> > > >
> > > > --
> > > > Cheers,
> > > >
> > > > David / dhildenb
> > > >

