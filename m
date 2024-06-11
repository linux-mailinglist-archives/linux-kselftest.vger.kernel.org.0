Return-Path: <linux-kselftest+bounces-11696-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4121A90433F
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 20:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 473CC1C21D9D
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 18:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6854F548FD;
	Tue, 11 Jun 2024 18:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wGG0wpqU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744EF38F82
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 18:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718129589; cv=none; b=lytgNG/prhojmDWacZfHIcHeUZmfxNKGvRhNEoXUv7neALNeUUH3ZU9gD73slACDjnUFMmh1BZIh5HU/6+GMgrj+KwKFCFIe2zoBzTsa3U6mnjK3ySVeLk9SIPqw7Xx5jgcq/JPv7GuruIeWUFO3saD22uaCSXUUDR/gb/i+7bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718129589; c=relaxed/simple;
	bh=vCFN9DbXeYqnfHdOtYGCDSbVXeeLGnkorizhFNNPcD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d13qTbpluGNoTPi7+OOCv7NV09+PpwRSzJVSEuqX1838f898h/s4XQfNtITcDFRojihlYkzdKLpsN5cNzioROc8pNTmUlzClKcz+6hO0HmGuljSsZGDDb4sTJAPmQ/5Hu7kNfTff1lGSt+XJv/jp4Vz1oJcmKwuqaTz4HyspihY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wGG0wpqU; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-35dc1d8867eso4686729f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 11:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718129586; x=1718734386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhMpc/bkyf85hQ35VDvGcznVMmv9iMFVbkxrvyl/q1o=;
        b=wGG0wpqU/ssghpz/Xb6BLKTfGjiSjw+rBYCDQE3FhuVP1f7iI+xTD24DJ4dQ8mIFDg
         pTrV4AYNqD0/WYJsW23wmP7VYiYr5ERfI2vcoeg0iKFUXkgbdp0ZSjMj3reD4YvN8/9g
         UV98Ug0nRsW4sJ6mcEunVZlWYSux0liIyTH/sb8foNpXj7wbPXUH5EUZZZMuqV7PJpDN
         zui3w6bpykWBstAWkBWtxcVglWgAn5JWJdLV/7HTcxJ9LWDLgqsSnqaUGOab7DmPG+uW
         Vapd3fiR1Pd/2EA14GpFRpS+nY+rXpvB9uc25aBsEXtxyXK6nbMAIjfIcFISoD/DCht7
         hmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718129586; x=1718734386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YhMpc/bkyf85hQ35VDvGcznVMmv9iMFVbkxrvyl/q1o=;
        b=nN1S1aEvbN0JD4lji/NRI2JPXGPhvNPx+owjRZOapVzyEgILBVSwVGaxYgPlnIWnWN
         WUP2sZISAyF0vLoOfOBb5EoQE0rWhTKFaxA/KgUZKtojs18D6IR3CbB9RL20guXS9PKO
         6Nccku7knSvKG74KWLTVIhmZSTvuDUyOmP/M0Sc1A4nZWM0+8+/77vCSZVCyTqtwcZQ/
         6Tb9oOZoFiPxDfIrL6pnSDW1BoDioRlzOyWHYRw4RG2HmCPpz5DTTR7GYSs3kOxZF0XV
         vQkp+/zh1GAaetlt/MdN8vX7nVTnpUeQwoSQu2+xt3W3b/b7vv2VHzIdwMgzrzgWWt1F
         ynbw==
X-Forwarded-Encrypted: i=1; AJvYcCUd3ewc4WiASGdtPlAtyyV0UuaGuHfz/mmW6Fktk3d1BFyElbWYAX7d7/E4F+/9oUJXc+MvgRTVNtVbErh4hIPMEk0Ai7JZmv7okNb3McoS
X-Gm-Message-State: AOJu0Yx5yF/emw2knD+qUV+oMDwV63NhakmRC9YnmPG0E4XU3H643z1c
	Aj0RxLv0/WDoebJAaYDO/3krJ+aHBzQ/rTYh2UDOoT8/h8ZZ86o5qSLRQGK0TBOoAmrA/RkK/nb
	8+sqU5punYXHrj0f0zzNCbvstdHK5HWrHKQpu
X-Google-Smtp-Source: AGHT+IFmvmy9iswgqOLOcDOP/y32JIWT7KzVxafuZ88HvWc86Q6Y1lF5Pfz2SbEHPCwQueonamIu49Xyo62slcy4wk8=
X-Received: by 2002:a05:6000:e81:b0:35f:1c34:adfc with SMTP id
 ffacd0b85a97d-35f1c34bddamr5036095f8f.67.1718129585417; Tue, 11 Jun 2024
 11:13:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531213439.2958891-1-jiaqiyan@google.com> <21841726-6427-5a92-a3d1-8aac2687c01a@huawei.com>
 <CACw3F52Ws2R-7kBbo29==tU=FOV=8aiWFZH2aL2DS_5nuTGO=w@mail.gmail.com>
 <2738aa0e-99d8-44d7-ac81-e38fd64591b7@oracle.com> <CACw3F50rh08o0hAG1rSfUnuJ3wezjCa8_ZE4rUGRUntUfx+-OQ@mail.gmail.com>
 <f446406d-7739-4367-ac68-0a3f30c04612@oracle.com>
In-Reply-To: <f446406d-7739-4367-ac68-0a3f30c04612@oracle.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Tue, 11 Jun 2024 11:12:51 -0700
Message-ID: <CACw3F53489qhO+B9oxJhzwd7U_-w=GSO7AH_tbRb6fzjzovuKg@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Userspace controls soft-offline HugeTLB pages
To: Jane Chu <jane.chu@oracle.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>, naoya.horiguchi@nec.com, 
	akpm@linux-foundation.org, shuah@kernel.org, corbet@lwn.net, 
	osalvador@suse.de, rientjes@google.com, duenwen@google.com, fvdl@google.com, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, muchun.song@linux.dev, 
	Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 10:55=E2=80=AFAM Jane Chu <jane.chu@oracle.com> wro=
te:
>
> On 6/10/2024 3:55 PM, Jiaqi Yan wrote:
>
> > Thanks for your feedback, Jane!
> >
> > On Mon, Jun 10, 2024 at 12:41=E2=80=AFPM Jane Chu <jane.chu@oracle.com>=
 wrote:
> >> On 6/7/2024 3:22 PM, Jiaqi Yan wrote:
> >>
> >>> On Tue, Jun 4, 2024 at 12:19=E2=80=AFAM Miaohe Lin <linmiaohe@huawei.=
com> wrote:
> >>>> On 2024/6/1 5:34, Jiaqi Yan wrote:
> >>>>> Correctable memory errors are very common on servers with large
> >>>>> amount of memory, and are corrected by ECC, but with two
> >>>>> pain points to users:
> >>>>> 1. Correction usually happens on the fly and adds latency overhead
> >>>>> 2. Not-fully-proved theory states excessive correctable memory
> >>>>>      errors can develop into uncorrectable memory error.
> >>>> Thanks for your patch.
> >>> Thanks Miaohe, sorry I missed your message (Gmail mistakenly put it i=
n
> >>> my spam folder).
> >>>
> >>>>> Soft offline is kernel's additional solution for memory pages
> >>>>> having (excessive) corrected memory errors. Impacted page is migrat=
ed
> >>>>> to healthy page if it is in use, then the original page is discarde=
d
> >>>>> for any future use.
> >>>>>
> >>>>> The actual policy on whether (and when) to soft offline should be
> >>>>> maintained by userspace, especially in case of HugeTLB hugepages.
> >>>>> Soft-offline dissolves a hugepage, either in-use or free, into
> >>>>> chunks of 4K pages, reducing HugeTLB pool capacity by 1 hugepage.
> >>>>> If userspace has not acknowledged such behavior, it may be surprise=
d
> >>>>> when later mmap hugepages MAP_FAILED due to lack of hugepages.
> >>>> For in use hugetlb folio case, migrate_pages() is called. The hugetl=
b pool
> >>>> capacity won't be modified in that case. So I assume you're referrin=
g to the
> >>> I don't think so.
> >>>
> >>> For in-use hugetlb folio case, after migrate_pages, kernel will
> >>> dissolve_free_hugetlb_folio the src hugetlb folio. At this point
> >>> refcount of src hugetlb folio should be zero already, and
> >>> remove_hugetlb_folio will reduce the hugetlb pool capacity (both
> >>> nr_hugepages and free_hugepages) accordingly.
> >>>
> >>> For the free hugetlb folio case, dissolving also happens. But CE on
> >>> free pages should be very rare (since no one is accessing except
> >>> patrol scrubber).
> >>>
> >>> One of my test cases in patch 2/3 validates my point: the test case
> >>> MADV_SOFT_OFFLINE a mapped page and at the point soft offline
> >>> succeeds, both nr_hugepages and nr_freepages are reduced by 1.
> >>>
> >>>> free hugetlb folio case? The Hugetlb pool capacity is reduced in tha=
t case.
> >>>> But if we don't do that, we might encounter uncorrectable memory err=
or later
> >>> If your concern is more correctable error will develop into more
> >>> severe uncorrectable, your concern is absolutely valid. There is a
> >>> tradeoff between reliability vs performance (availability of hugetlb
> >>> pages), but IMO should be decided by userspace.
> >>>
> >>>> which will be more severe? Will it be better to add a way to compens=
ate the
> >>>> capacity?
> >>> Corner cases: What if finding physically contiguous memory takes too
> >>> long? What if we can't find any physically contiguous memory to
> >>> compensate? (then hugetlb pool will still need to be reduced).
> >>>
> >>> If we treat "compensate" as an improvement to the overall soft offlin=
e
> >>> process, it is something we can do in future and it is something
> >>> orthogonal to this control API, right? I think if userspace explicitl=
y
> >>> tells kernel to soft offline, then they are also well-prepared for th=
e
> >>> corner cases above.
> >>>
> >>>>> In addition, discarding the entire 1G memory page only because of
> >>>>> corrected memory errors sounds very costly and kernel better not
> >>>>> doing under the hood. But today there are at least 2 such cases:
> >>>>> 1. GHES driver sees both GHES_SEV_CORRECTED and
> >>>>>      CPER_SEC_ERROR_THRESHOLD_EXCEEDED after parsing CPER.
> >>>>> 2. RAS Correctable Errors Collector counts correctable errors per
> >>>>>      PFN and when the counter for a PFN reaches threshold
> >>>>> In both cases, userspace has no control of the soft offline perform=
ed
> >>>>> by kernel's memory failure recovery.
> >>>> Userspace can figure out the hugetlb folio pfn range by using `page-=
types -b huge
> >>>> -rlN` and then decide whether to soft offline the page according to =
it. But for
> >>>> GHES driver, I think it has to be done in the kernel. So add a contr=
ol in /sys/
> >>>> seems like a good idea.
> >>> Thanks.
> >>>
> >>>>> This patch series give userspace the control of soft-offlining
> >>>>> HugeTLB pages: kernel only soft offlines hugepage if userspace has
> >>>>> opt-ed in for that specific hugepage size, and exposed to userspace
> >>>>> by a new sysfs entry called softoffline_corrected_errors under
> >>>>> /sys/kernel/mm/hugepages/hugepages-${size}kB directory:
> >>>>> * When softoffline_corrected_errors=3D0, skip soft offlining for al=
l
> >>>>>     hugepages of size ${size}kB.
> >>>>> * When softoffline_corrected_errors=3D1, soft offline as before thi=
s
> >>>> Will it be better to be called as "soft_offline_corrected_errors" or=
 simplify "soft_offline_enabled"?
> >>> "soft_offline_enabled" is less optimal as it can't be extended to
> >>> support something like "soft offline this PFN if something repeatedly
> >>> requested soft offline this exact PFN x times". (although I don't
> >>> think we need it).
> >> The "x time" thing is a threshold thing, and if your typical applicati=
on
> >> needs to have a say about performance(and maintaining physically
> >> contiguous memory) over RAS, shouldn't that be baked into the driver
> >> rather than hugetlbfs ?
> > I mostly agree, only that I want to point out the threshold has
> > already been maintained by some firmware. For example, CPER has
> > something like the following defined in UEFI Spec Table N.5: Section
> > Descriptor:
> >
> >    Bit 3 - Error threshold exceeded: If set, OS may choose to discontin=
ue
> >    use of this resource.
> >
> > In this case, I think "enable_soft_offline" is a better name for "OS
> > choose to discontinue use of this page" (enable_soft_offline=3D1) or no=
t
> > (enable_soft_offline=3D0). WDYT?
>
> Yes, as long as enable_soft_offline=3D1 is the default. Out of thought, I

For sure, like this patcheset, I will ensure enable_soft_offline keeps
the "default on" behavior.

> suppose the CE count and threshold can be retrieved by the GHES driver?

Unfortunately GHES doesn't have visibility to CE count and threshold
value (RAS Correctable Errors Collector does by itself) . GHES driver
only knows it from the CPER_SEC_ERROR_THRESHOLD_EXCEEDED bit in the
CPER reported by some firmware.

> I haven't checked. If so, maybe another way is to implement a per task
> CE threshold: add a new field.ce_thresholdto the tsak struct, add a
> function to prctl(2) for a user thread to specify a CE threshold, also a
> function to retrieve the firmware defined default CE threshold, and let
> soft_offline_page() check against the task->ce_threshold to decide
> whether to offline the page. If you want to apply the CE threshold to
> patrol scrub triggered soft offline, than you could define a
> global/system wide CE threshold. That said, this might be an overblown
> to what you need, I'm just letting it out there for the sake of brain
> storming.

Thanks for your great idea! But yeah, it sounds like an overkill for
the current problem. I think starting with OS-wide control of whether
to soft offline any page already gives much better flexibility to
userspace.

>
> >
> >> Also, I am not comfortable with this being hugetlbfs specific. What is
> >> the objection to creating a "soft_offline_enabled" switch that is
> >> applicable to any user page size?
> > I have no objection to making the "soft_offline_enabled" switch to
> > apply to anything (hugetlb, transparent hugepage, raw page, etc). The
> > only reason my current patch is hugetlb specific is because
> > softoffline behavior is very disruptive in the hugetlb 1G page case,
> > and I want to start with a limited scope in my first attempt.
> >
> > If Miaohe, you, and other people are fine with making it applicable to
> > any user pages, maybe a better interface for this could be at
> > something like /sys/devices/system/memory/enable_soft_offline
> > (location-wise close to /sys/devices/system/memory/soft_offline_page)?
>
> Or, you could use /proc/sys/vm/enable_soft_offline, side by side with
> the existing 'memory_failure_early_kill' and 'memory_failure_recovery'
> switches.

I was actually looking into this better option, but your reply beats me ;)

>
> You could also make 'enable_soft_offline' a per process option, similar
> to 'PR_MCE_KILL_EARLY' in prctl(2).*
> *
>
> thanks,
>
> -jane
>
> >
> >> thanks,
> >>
> >> -jane
> >>
> >>> softoffline_corrected_errors is one char less, but if you insist,
> >>> soft_offline_corrected_errors also works for me.
> >>>
> >>>> Thanks.
> >>>> .
> >>>>

