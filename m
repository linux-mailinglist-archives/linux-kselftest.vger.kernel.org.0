Return-Path: <linux-kselftest+bounces-25533-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6C7A25473
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 09:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAD2D1882213
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 08:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FCA1FAC23;
	Mon,  3 Feb 2025 08:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZQWJ8PfT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D691E9905
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Feb 2025 08:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738571717; cv=none; b=D87TNlVli3gj5KWmkDqOJH2cpa52BgaQzoGIJcVJCI6AHFcntaWV39KqcNaE62UrPQdLyL0dKplFrZ0IMfo35nX0cdJbLYEzKs3oc6owy/+wsNhPHXWVXtlYPE64+sPN/M7x6sMbPSqS9BZ2NZFdAUqp8ZN7NVwYFiTdQ+0/Bis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738571717; c=relaxed/simple;
	bh=AjeBmdJxOhB8EePWx9LMdeDziY3O7eZmfuZLVM3LnCA=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=PsqGkonAheQwENAeoX3umYyMO5wKfq8iAvHuYfxofscmWBXP7ELOGdx0CRE4gki7zxnkn2/M4JU6QkxIexj1WtURGDkgHxTxoQAuRw70xbF8s+UvBlcC5R4lcX1jk8PhuTaOnpx8NVimkuCvHBBOiSEmnC17RSvhDwiJESN8t7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZQWJ8PfT; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef9e38b0cfso7658120a91.0
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Feb 2025 00:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738571715; x=1739176515; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bCVGsPkdqv8VOcstVdRRWjGTGpKBIG2jSUrhWhisdPo=;
        b=ZQWJ8PfTXWf9rjNMsrbTjBAJbETXlU/CjR5KASUzY0l/Ub2eookgHzsLD363AJRHx/
         mrVTbegfVsjcApqwzcEBOSAtvHE50uT/nuV2S2k6sxkgf4hkW6YuBjk6jWffs2UPh354
         ihB5+AMeb70RmDTt9egjCIo8tRjleB3Ym3AsBI7VjUNPVI16F6CbvoC5pYs7cpL5sTUt
         7XQtWAC3Ky+siA/93SsIZaGLAJIdWEIP2gu86eQqppgOFLsLN2whPa6w3Yap5IB+pcDk
         IYQmpY+9GJs8oEh6St7eW/fxTlyNVqOTysF2OfUwtxAmDNQZKFx5crqzxsY0zieWl2gz
         P9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738571715; x=1739176515;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bCVGsPkdqv8VOcstVdRRWjGTGpKBIG2jSUrhWhisdPo=;
        b=Dm2iLgexOESfyWwUyiuCJimp8Zp7KpXn+SjTEzndxV2Nb7rc1ww3+AhBGBsSIOuf6l
         pws/igF6ieT7BgdtfzjbLe8k5enCWVnBHy/YBYk62m803o6zb+h+ANj8hvHuNQN6VeIn
         4LvIq3oyeN+Gqb1yXe1IO7UT4yrn/tIK9oM3KXY4cYvj8rHWbbcnHrgRKcR8UrSgNcel
         J3bMQ+JOWI/nJQahhqJ62eKnM8/pSTYUly3R8CcanLFmajZGveTqXCEJl9Qy0c+oM9gu
         hW9IiW9MuJFdQulDyqAOZ2CP2jZXTWE6vUM+b2+mTIXFlWoR3Qu5HH7amuyC3Wimb1nu
         TIuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBysWd5FTdN7JYEd4OsCTWvU5ZEr+/2Mj+yxTHI2BDWKYCJRZuSwAMgtKBhe+S7uL2cftduQ7rNU4uF8dMUV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi+HhgUsJ8X1ZCtR9ItTzOl+ynNU+Eg3bVKNQuDpkTE1ETVhAD
	/Bb2ngBI7dVa1/s7RcJshkTI2k0RS5OkazsodeXPtJ+mT0hKm/hth+O8ggQ4mg1G5kY05+ciPJY
	4dO1CnKo+IAz1c/f0miCPzQ==
X-Google-Smtp-Source: AGHT+IHj+Cug/2vDcc3qbw44IShUmb2Dal+tFzb8jNSGxbKWVsDIeVzNOQ+erfgJBUWM/FABAfOHIsgQxSoSDHqCzA==
X-Received: from pjbnc13.prod.google.com ([2002:a17:90b:37cd:b0:2ea:46ed:5d3b])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2748:b0:2f4:465d:5c94 with SMTP id 98e67ed59e1d1-2f83abd9978mr32152246a91.11.1738571714919;
 Mon, 03 Feb 2025 00:35:14 -0800 (PST)
Date: Mon, 03 Feb 2025 08:35:12 +0000
In-Reply-To: <83d44307f30ad8ce19de3edcdc00c179750e0e23.camel@infradead.org>
 (message from Amit Shah on Tue, 28 Jan 2025 10:42:57 +0100)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <diqzr04fpgsf.fsf@ackerleytng-ctop-specialist.c.googlers.com>
Subject: Re: [RFC PATCH 00/39] 1G page support for guest_memfd
From: Ackerley Tng <ackerleytng@google.com>
To: Amit Shah <amit@infradead.org>
Cc: tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk, 
	jgg@nvidia.com, peterx@redhat.com, david@redhat.com, rientjes@google.com, 
	fvdl@google.com, jthoughton@google.com, seanjc@google.com, 
	pbonzini@redhat.com, zhiquan1.li@intel.com, fan.du@intel.com, 
	jun.miao@intel.com, isaku.yamahata@intel.com, muchun.song@linux.dev, 
	mike.kravetz@oracle.com, erdemaktas@google.com, vannapurve@google.com, 
	qperret@google.com, jhubbard@nvidia.com, willy@infradead.org, 
	shuah@kernel.org, brauner@kernel.org, bfoster@redhat.com, 
	kent.overstreet@linux.dev, pvorel@suse.cz, rppt@kernel.org, 
	richard.weiyang@gmail.com, anup@brainfault.org, haibo1.xu@intel.com, 
	ajones@ventanamicro.com, vkuznets@redhat.com, maciej.wieczor-retman@intel.com, 
	pgonda@google.com, oliver.upton@linux.dev, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-fsdevel@kvack.org
Content-Type: text/plain; charset="UTF-8"

Amit Shah <amit@infradead.org> writes:

> Hey Ackerley,

Hi Amit,

> On Tue, 2024-09-10 at 23:43 +0000, Ackerley Tng wrote:
>> Hello,
>> 
>> This patchset is our exploration of how to support 1G pages in
>> guest_memfd, and
>> how the pages will be used in Confidential VMs.
>
> We've discussed this patchset at LPC and in the guest-memfd calls.  Can
> you please summarise the discussions here as a follow-up, so we can
> also continue discussing on-list, and not repeat things that are
> already discussed?

Thanks for this question! Since LPC, Vishal and I have been tied up with
some Google internal work, which slowed down progress on 1G page support
for guest_memfd. We will have progress this quarter and the next few
quarters on 1G page support for guest_memfd.

The related updates are

1. No objections on using hugetlb as the source of 1G pages.

2. Prerequisite hugetlb changes.

+ I've separated some of the prerequisite hugetlb changes into another
  patch series hoping to have them merged ahead of and separately from
  this patchset [1].
+ Peter Xu contributed a better patchset, including a bugfix [2].
+ I have an alternative [3].
+ The next revision of this series (1G page support for guest_memfd)
  will be based on alternative [3]. I think there should be no issues
  there.
+ I believe Peter is also waiting on the next revision before we make
  further progress/decide on [2] or [3].

3. No objections for allowing mmap()-ing of guest_memfd physical memory
   when memory is marked shared to avoid double-allocation.

4. No objections for splitting pages when marked shared.

5. folio_put() callback for guest_memfd folio cleanup/merging.

+ In Fuad's series [4], Fuad used the callback to reset the folio's
  mappability status.
+ The catch is that the callback is only invoked when folio->page_type
  == PGTY_guest_memfd, and folio->page_type is a union with folio's
  mapcount, so any folio with a non-zero mapcount cannot have a valid
  page_type.
+ I was concerned that we might not get a callback, and hence
  unintentionally skip merging pages and not correctly restore hugetlb
  pages
+ This was discussed at the last guest_memfd upstream call (2025-01-23
  07:58 PST), and the conclusion is that using folio->page_type works,
  because
    + We only merge folios in two cases: (1) when converting to private
      (2) when truncating folios (removing from filemap).
    + When converting to private, in (1), we can forcibly unmap all the
      converted pages or check if the mapcount is 0, and once mapcount
      is 0 we can install the callback by setting folio->page_type =
      PGTY_guest_memfd
    + When truncating, we will be unmapping the folios anyway, so
      mapcount is also 0 and we can install the callback.

Hope that covers the points that you're referring to. If there are other
parts that you'd like to know the status on, please let me know which
aspects those are!

> Also - as mentioned in those meetings, we at AMD are interested in this
> series along with SEV-SNP support - and I'm also interested in figuring
> out how we collaborate on the evolution of this series.

Thanks all your help and comments during the guest_memfd upstream calls,
and thanks for the help from AMD.

Extending mmap() support from Fuad with 1G page support introduces more
states that made it more complicated (at least for me).

I'm modeling the states in python so I can iterate more quickly. I also
have usage flows (e.g. allocate, guest_use, host_use,
transient_folio_get, close, transient_folio_put) as test cases.

I'm almost done with the model and my next steps are to write up a state
machine (like Fuad's [5]) and share that.

I'd be happy to share the python model too but I have to work through
some internal open-sourcing processes first, so if you think this will
be useful, let me know!

Then, I'll code it all up in a new revision of this series (target:
March 2025), which will be accompanied by source code on GitHub.

I'm happy to collaborate more closely, let me know if you have ideas for
collaboration!

> Thanks,
>
> 		Amit

[1] https://lore.kernel.org/all/cover.1728684491.git.ackerleytng@google.com/T/
[2] https://lore.kernel.org/all/20250107204002.2683356-1-peterx@redhat.com/T/
[3] https://lore.kernel.org/all/diqzjzayz5ho.fsf@ackerleytng-ctop.c.googlers.com/
[4] https://lore.kernel.org/all/20250117163001.2326672-1-tabba@google.com/T/
[5] https://lpc.events/event/18/contributions/1758/attachments/1457/3699/Guestmemfd%20folio%20state%20page_type.pdf

