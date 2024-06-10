Return-Path: <linux-kselftest+bounces-11610-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBECA902BE7
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 00:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 561751F22B51
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 22:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB8D1509B9;
	Mon, 10 Jun 2024 22:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V89JTE8L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AA7145B09
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2024 22:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718060174; cv=none; b=K9SWDmo+o72h+7k8Sqtfx/Hx/zRvAhkQna3ayz1nj9s9+oetn3IFViQ4SRTE56a8MvQ8HIgF9NPGELY0uiktvex2uzWiS2yQYcLKbPdq+zcc7Q01wkwHyMbwH14GHS5eaCVKpSGdWcXc8EWlqNmIUTKt3Mr2MHMk6Cj23JmQ778=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718060174; c=relaxed/simple;
	bh=BH1JboYIwXkKCG3pKMamJmIfStNwRUMSg5VBmTCr0WY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TFnU+HUBGfK6GlpKqvJYPVIDV8yvavz6ZzfYVaOFulvZ8KA2LUG2peSn7EYFJ/kFOPEU/NExP96t4s5VjscKq0vyjI9yn30MRbzCJLRrIj2j/KTyhhKgocUsBIGvXLi1Oip3RAQXBh9H0GqOMtRvB0moe6964uWPhUTRrG7mL4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V89JTE8L; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-35f1bc63981so1450745f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2024 15:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718060171; x=1718664971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=quTZIKCYwo1oMqK9GegsysfKZz3tpeEKNEIgMJqv2pE=;
        b=V89JTE8LT99wpQvASXfV6HTLqug3bj2Fw7SF9h5QJ/eyqteIdLiFgBgFiHgfhHISKl
         Pj0l8mCp1vJBKG76XTIE31csIl5UV1kFD4ZE3FVQhRsKEJBPgtaB0qkTFB6i+uapyLJc
         4mQA+s4ibjZpw8k9xmL7xXk8fJCegif7vQnsWr2LKYasSTAig5RAN8pZHLon1z2eiEZi
         wQo0Gr5IqstVB6S7mJUAERJH5k7Mtz5kMg8xngPPNqn/5skdOwGpsz3v1RX8mUsMyT5k
         wv0F9NbzvprU2a7a4O1wIfo+qGqfoFbCOh1dwKGEUc9x/qo4r0ehkCfs0apZUkNxFhff
         IHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718060171; x=1718664971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=quTZIKCYwo1oMqK9GegsysfKZz3tpeEKNEIgMJqv2pE=;
        b=WMfm/ZiYLVXb07f1xHlBvfk0oIZfNn+ClidIHJOlow2NJRn0uk9HYjCvp1hlhwHA4y
         MU5jID/7zk3Ci5X15Yc03J0XDN7cz1BK5KVut/OSpWAlepUrZOeKmEupi0Qu60D1tQgi
         AOMufG4Byroi7ExXs7sIzHVXUE+4QWj86Rzx45qKJF12MK41/Riw9qq7+z+o0loR5nFl
         IFNQXUznVdwdBtQPBAzCMu2vbZwaSiJxo5xmjEqZAGiknK98nKLUxnUmeRh36rETri8c
         B6BLqdRNB0tchi1ylIQ3fs0lfyNGr20MSUC3sllTc6AqeoQv6Td2kD/XsY7noiqqOJED
         +1tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmw1HHlRC+ZWeh5zIwCbLgFSZ3XMKnOJnaI8HFWS5tJ/RH19mKAlH9wFg+erl22i7gqELBvPXDAGihpembfIZRksps1+PXKmT9WGUl5yBP
X-Gm-Message-State: AOJu0YyN5fqFN/Acizdvek7XUcCzm5tF7iOnNHBAVS9W21519CLgnBYy
	8fHMCYWE4Mo79ou6Rux2igpZGHmevfZNu3r8VrQ9mfzW5A9PXXixST31wbeTzcW4A5ObweQK22A
	vJRNLJIsOaxWsGikOmYZ7baSjiaU0QBnJoKqz
X-Google-Smtp-Source: AGHT+IEWSnXDkOOuWxy4buVy5+bH83YnyNR4w4o3Mv7K46VM8aoNm19YQLygFNgF60V3lHzBQ/YzJdQu2mPPWV96c9Q=
X-Received: by 2002:adf:f707:0:b0:35f:1243:a956 with SMTP id
 ffacd0b85a97d-35f2b2c173bmr921417f8f.23.1718060170659; Mon, 10 Jun 2024
 15:56:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531213439.2958891-1-jiaqiyan@google.com> <21841726-6427-5a92-a3d1-8aac2687c01a@huawei.com>
 <CACw3F52Ws2R-7kBbo29==tU=FOV=8aiWFZH2aL2DS_5nuTGO=w@mail.gmail.com> <2738aa0e-99d8-44d7-ac81-e38fd64591b7@oracle.com>
In-Reply-To: <2738aa0e-99d8-44d7-ac81-e38fd64591b7@oracle.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Mon, 10 Jun 2024 15:55:58 -0700
Message-ID: <CACw3F50rh08o0hAG1rSfUnuJ3wezjCa8_ZE4rUGRUntUfx+-OQ@mail.gmail.com>
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

Thanks for your feedback, Jane!

On Mon, Jun 10, 2024 at 12:41=E2=80=AFPM Jane Chu <jane.chu@oracle.com> wro=
te:
>
> On 6/7/2024 3:22 PM, Jiaqi Yan wrote:
>
> > On Tue, Jun 4, 2024 at 12:19=E2=80=AFAM Miaohe Lin <linmiaohe@huawei.co=
m> wrote:
> >> On 2024/6/1 5:34, Jiaqi Yan wrote:
> >>> Correctable memory errors are very common on servers with large
> >>> amount of memory, and are corrected by ECC, but with two
> >>> pain points to users:
> >>> 1. Correction usually happens on the fly and adds latency overhead
> >>> 2. Not-fully-proved theory states excessive correctable memory
> >>>     errors can develop into uncorrectable memory error.
> >> Thanks for your patch.
> > Thanks Miaohe, sorry I missed your message (Gmail mistakenly put it in
> > my spam folder).
> >
> >>> Soft offline is kernel's additional solution for memory pages
> >>> having (excessive) corrected memory errors. Impacted page is migrated
> >>> to healthy page if it is in use, then the original page is discarded
> >>> for any future use.
> >>>
> >>> The actual policy on whether (and when) to soft offline should be
> >>> maintained by userspace, especially in case of HugeTLB hugepages.
> >>> Soft-offline dissolves a hugepage, either in-use or free, into
> >>> chunks of 4K pages, reducing HugeTLB pool capacity by 1 hugepage.
> >>> If userspace has not acknowledged such behavior, it may be surprised
> >>> when later mmap hugepages MAP_FAILED due to lack of hugepages.
> >> For in use hugetlb folio case, migrate_pages() is called. The hugetlb =
pool
> >> capacity won't be modified in that case. So I assume you're referring =
to the
> > I don't think so.
> >
> > For in-use hugetlb folio case, after migrate_pages, kernel will
> > dissolve_free_hugetlb_folio the src hugetlb folio. At this point
> > refcount of src hugetlb folio should be zero already, and
> > remove_hugetlb_folio will reduce the hugetlb pool capacity (both
> > nr_hugepages and free_hugepages) accordingly.
> >
> > For the free hugetlb folio case, dissolving also happens. But CE on
> > free pages should be very rare (since no one is accessing except
> > patrol scrubber).
> >
> > One of my test cases in patch 2/3 validates my point: the test case
> > MADV_SOFT_OFFLINE a mapped page and at the point soft offline
> > succeeds, both nr_hugepages and nr_freepages are reduced by 1.
> >
> >> free hugetlb folio case? The Hugetlb pool capacity is reduced in that =
case.
> >> But if we don't do that, we might encounter uncorrectable memory error=
 later
> > If your concern is more correctable error will develop into more
> > severe uncorrectable, your concern is absolutely valid. There is a
> > tradeoff between reliability vs performance (availability of hugetlb
> > pages), but IMO should be decided by userspace.
> >
> >> which will be more severe? Will it be better to add a way to compensat=
e the
> >> capacity?
> > Corner cases: What if finding physically contiguous memory takes too
> > long? What if we can't find any physically contiguous memory to
> > compensate? (then hugetlb pool will still need to be reduced).
> >
> > If we treat "compensate" as an improvement to the overall soft offline
> > process, it is something we can do in future and it is something
> > orthogonal to this control API, right? I think if userspace explicitly
> > tells kernel to soft offline, then they are also well-prepared for the
> > corner cases above.
> >
> >>> In addition, discarding the entire 1G memory page only because of
> >>> corrected memory errors sounds very costly and kernel better not
> >>> doing under the hood. But today there are at least 2 such cases:
> >>> 1. GHES driver sees both GHES_SEV_CORRECTED and
> >>>     CPER_SEC_ERROR_THRESHOLD_EXCEEDED after parsing CPER.
> >>> 2. RAS Correctable Errors Collector counts correctable errors per
> >>>     PFN and when the counter for a PFN reaches threshold
> >>> In both cases, userspace has no control of the soft offline performed
> >>> by kernel's memory failure recovery.
> >> Userspace can figure out the hugetlb folio pfn range by using `page-ty=
pes -b huge
> >> -rlN` and then decide whether to soft offline the page according to it=
. But for
> >> GHES driver, I think it has to be done in the kernel. So add a control=
 in /sys/
> >> seems like a good idea.
> > Thanks.
> >
> >>> This patch series give userspace the control of soft-offlining
> >>> HugeTLB pages: kernel only soft offlines hugepage if userspace has
> >>> opt-ed in for that specific hugepage size, and exposed to userspace
> >>> by a new sysfs entry called softoffline_corrected_errors under
> >>> /sys/kernel/mm/hugepages/hugepages-${size}kB directory:
> >>> * When softoffline_corrected_errors=3D0, skip soft offlining for all
> >>>    hugepages of size ${size}kB.
> >>> * When softoffline_corrected_errors=3D1, soft offline as before this
> >> Will it be better to be called as "soft_offline_corrected_errors" or s=
implify "soft_offline_enabled"?
> > "soft_offline_enabled" is less optimal as it can't be extended to
> > support something like "soft offline this PFN if something repeatedly
> > requested soft offline this exact PFN x times". (although I don't
> > think we need it).
>
> The "x time" thing is a threshold thing, and if your typical application
> needs to have a say about performance(and maintaining physically
> contiguous memory) over RAS, shouldn't that be baked into the driver
> rather than hugetlbfs ?

I mostly agree, only that I want to point out the threshold has
already been maintained by some firmware. For example, CPER has
something like the following defined in UEFI Spec Table N.5: Section
Descriptor:

  Bit 3 - Error threshold exceeded: If set, OS may choose to discontinue
  use of this resource.

In this case, I think "enable_soft_offline" is a better name for "OS
choose to discontinue use of this page" (enable_soft_offline=3D1) or not
(enable_soft_offline=3D0). WDYT?

>
> Also, I am not comfortable with this being hugetlbfs specific. What is
> the objection to creating a "soft_offline_enabled" switch that is
> applicable to any user page size?

I have no objection to making the "soft_offline_enabled" switch to
apply to anything (hugetlb, transparent hugepage, raw page, etc). The
only reason my current patch is hugetlb specific is because
softoffline behavior is very disruptive in the hugetlb 1G page case,
and I want to start with a limited scope in my first attempt.

If Miaohe, you, and other people are fine with making it applicable to
any user pages, maybe a better interface for this could be at
something like /sys/devices/system/memory/enable_soft_offline
(location-wise close to /sys/devices/system/memory/soft_offline_page)?

>
> thanks,
>
> -jane
>
> >
> > softoffline_corrected_errors is one char less, but if you insist,
> > soft_offline_corrected_errors also works for me.
> >
> >> Thanks.
> >> .
> >>

