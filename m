Return-Path: <linux-kselftest+bounces-34928-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA45EAD9500
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 21:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0A45189F30B
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 19:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7EF239E6F;
	Fri, 13 Jun 2025 19:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="buj9gY8E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6BE238D49
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 19:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749841918; cv=none; b=hJFyF6UAyd1mnGAXEHypm/8brU5BJ2+6zibRQO1uyhLjnVE8usrNfZW8FTVyWwmZq5nT81XF0cLz/Q7KDg/VFjFxeXENnqyOpiU7yJMBiW/wTKN1ezVJVZo2jg/Gs0McXWledik8IQFWwuPSsObQqDWZMdBBTHFMyKlfWHGZlJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749841918; c=relaxed/simple;
	bh=SGtE0l1MW17H7LDg5MmX9lFL2Ia41F3/cPofyObujdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LH++ihrHFg0u/mtkD9euksmdaHIhvzyAzfsYUQzRjFbuKhKe/PffEgcjVyVAyXux6Neayf2CfB2ELXQLT2O0nZJAZWodz7WrW3xn2vcUlHQnHqryVYyBOC3wBYz16grf+3iMqdkLdg8XfbLHlMWRHTpKmTf+d42wfhOMZwSjWfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=buj9gY8E; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a58ef58a38so28821cf.0
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 12:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749841916; x=1750446716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3MLioFcu25SrzT1JXLpM40JWU5zBFcetADxV3Ug7jaY=;
        b=buj9gY8EZPI/uPl9AwToUmtpRBDqog+TuIhxb7fT2ZG4nDAtJ4G2dX1IuK4cLIgGUa
         5Oti0y56pUT4rxJanyI5H3a5cykOT279dro0NawPaEoi3vdKu0WHOSSMWheOpwkzWqe7
         7Fl0ALYbgRUzmwxD2qxMozCgeKjl3xpS1Z3BYG/1QeoDShLH4ER73vgjNwEnXtIarf6m
         TklXnR7EHqF81PRbjqE/GRZ5PyrzGrODGjL/VccDfxaTfMSFcP1bcpUY8ePnrBgdf//v
         eHs2p2KSoM8LAKvRoNENIy2pnC4AVBuXEvZkT8kLsUOoKoMducW4OAXGvgCIrkgW/qjd
         Q9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749841916; x=1750446716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3MLioFcu25SrzT1JXLpM40JWU5zBFcetADxV3Ug7jaY=;
        b=mcpA+mzVCJaVFcz+6w+KAOf3de6ShRZy+bezvUQrmFX0pb34Wtsk6l2TyKZlatWUTU
         2czvxwUXVS6Ntc8hikZobTVa+SiPFuNW4udBZlDadal/fAghX9yFsc7vVKhwQyyj+YLX
         GBNnh04MTu4Gl4aYFbu2i/VHm9XciQ2SU/MfqChbOMI8qDlPm4wth+YYtGcZKQVOzpd/
         W2MyXz3gWgE+Uatl6R9cl9ECqv1/iKF0AQ8ZnQR8ulG+mvELKco5GefstHxylIBkiMSM
         jQWKiDVkr7RT2p30DDOPLQ/BtRJZcfRPclxqUzVBGC9EpfYQ2rAQ0+KjbQ/CUkE7gE8m
         GAyw==
X-Forwarded-Encrypted: i=1; AJvYcCU5ImtKYVGmwQrAMmG0qjrQXVUjny4nJG6wOXgUPCgxexV9YrXHyY0pSc6dIbkQDpf6KsuZtBHH2oJVXOGGy7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJYO4fMR5RM2Y0LTk8QkV8vm2Yn7PAGS8VohVXu1b9TOhwgtUM
	dIj18c/c55WQSM+QOQ0o1J/OaSlC9tOPhvPtDx6l2m5l2U2YG6RhCrysW6C1vwmCkGvMSVyogKj
	Un5PDsMQkrKeVOM+ATeTUdKTf33sRZswVXzatmQfZ
X-Gm-Gg: ASbGncvtigrGY8pY9s3AueJrobVyn9wPvu6hw+Kon+30gDcmD1PnYg4jvSnfh/kmrv+
	JywZOknrC5qNGAFFhKlLktIFOtYH/iW8pmpLnxWruIs7bXeGq1C8DnoPT8DGMHpI5OXEcZROCoY
	AN+ttarKimgnNgdpP++DU+faK0BjMzfNimI2vz+SfVhA==
X-Google-Smtp-Source: AGHT+IFvnQIut+5bnSYDZt2/+KLVzB00ESAWF3T/ASeTAbTQtzNN2t7bhybaTsWELXSkO5KBPEuQ4qfCSd8Vl9SZ45Q=
X-Received: by 2002:a05:622a:118a:b0:494:763e:d971 with SMTP id
 d75a77b69052e-4a73c74bad2mr380121cf.23.1749841915704; Fri, 13 Jun 2025
 12:11:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604231151.799834-1-surenb@google.com> <e1863f40-39ab-4e5b-984a-c48765ffde1c@lucifer.local>
In-Reply-To: <e1863f40-39ab-4e5b-984a-c48765ffde1c@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 13 Jun 2025 12:11:43 -0700
X-Gm-Features: AX0GCFvFrVv3MRasBZx4Viw_BkVYZSdZQVHNBuDMFpy95J_U6Iwdmy5s59K2S_Y
Message-ID: <CAJuCfpFCucv9+-MBtaqbA3=omb8rT2jJ5_vjdtX7DZLzN3xG6A@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] use per-vma locks for /proc/pid/maps reads and PROCMAP_QUERY
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	tjmercier@google.com, kaleshsingh@google.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 8:01=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> Hi Suren,
>
> I promised I'd share VMA merging scenarios so we can be absolutely sure w=
e have
> all cases covered, I share that below. I also included information on spl=
it.

Thanks Lorenzo! This is great and very helpful.

>
> Hopefully this is useful! And maybe we can somehow put in a comment or co=
mmit
> msg or something somewhere? Not sure if a bit much for that though :)

I'll see if I can add a short version into my next cover letter.

>
> Note that in all of the below we hold exclusive mmap, vma + rmap write lo=
cks.
>
> ## Merge with change to EXISTING VMA
>
> ### Merge both
>
>                       start    end
>                          |<---->|
>                  |-------********-------|
>                    prev   middle   next
>                   extend  delete  delete
>
> 1. Set prev VMA range [prev->vm_start, next->vmend)
> 2. Overwrite prev, middle, next nodes in maple tree with prev
> 3. Detach middle VMA
> 4. Free middle VMA
> 5. Detach next VMA
> 6. Free next VMA

This case should be fine with per-vma locks while reading
/proc/pid/maps. In the worst case we will report some of the original
vmas before the merge and then the final merged vma, so prev might be
seen twice but no gaps should be observed.

>
> ### Merge left full
>
>                        start        end
>                          |<--------->|
>                  |-------*************
>                    prev     middle
>                   extend    delete
>
> 1. Set prev VMA range [prev->vm_start, end)
> 2. Overwrite prev, middle nodes in maple tree with prev
> 3. Detach middle VMA
> 4. Free middle VMA

Same as the previous case. Worst case we report prev twice - once
before the merge, once after the merge.

>
> ### Merge left partial
>
>                        start   end
>                          |<---->|
>                  |-------*************
>                    prev     middle
>                   extend  partial overwrite
>
> 1. Set prev VMA range [prev->vm_start, end)
> 2. Set middle range [end, middle->vm_end)
> 3. Overwrite prev, middle (partial) nodes in maple tree with prev

We might report prev twice here and this might cause us to retry if we
see a temporary gap between old prev and new middle vma. But retry
should handle this case, so I think we are good here.

>
> ### Merge right full
>
>                start        end
>                  |<--------->|
>                  *************-------|
>                     middle     next
>                     delete    extend
>
> 1. Set next range [start, next->vm_end)
> 2. Overwrite middle, next nodes in maple tree with next
> 3. Detach middle VMA
> 4. Free middle VMA

Worst case we report middle twice.

>
> ### Merge right partial
>
>                    start    end
>                      |<----->|
>                  *************-------|
>                     middle     next
>                     shrink    extend
>
> 1. Set middle range [middle->vm_start, start)
> 2. Set next range [start, next->vm_end)
> 3. Overwrite middle (partial), next nodes in maple tree with next

Worse case we retry and report middle twice.

>
> ## Merge due to introduction of proposed NEW VMA
>
> These cases are easier as there's no existing VMA to either remove or par=
tially
> adjust.
>
> ### Merge both
>
>                        start     end
>                          |<------>|
>                  |-------..........-------|
>                    prev  (proposed)  next
>                   extend            delete
>
> 1. Set prev VMA range [prev->vm_start, next->vm_end)
> 2. Overwrite prev, next nodes in maple tree with prev
> 3. Detach next VMA
> 4. Delete next VMA

Worst case we report prev twice after retry.

>
> ### Merge left
>
>                        start     end
>                          |<------>|
>                  |-------..........
>                    prev  (proposed)
>                   extend
>
> 1. Set prev VMA range [prev->vm_start, end)
> 2. Overwrite prev node in maple tree with newly extended prev

Worst case we report prev twice.

>
> (This is what's used for brk() and bprm_mm_init() stack relocation in
> relocate_vma_down() too)
>
> ### Merge right
>
>                        start     end
>                          |<------>|
>                          ..........-------|
>                          (proposed)  next
>                                     extend
>
> 1. Set next VMA range [start, next->vm_end)
> 2. Overwrite next node in maple tree with newly extended next

This will show either a legit gap + original next or the extended next
with no gap. Both ways we are fine.

>
> ## Split VMA
>
> If new below:
>
>                     addr
>                 |-----.-----|
>                 | new .     |
>                 |-----.-----|
>                      vma
> Otherwise:
>
>                     addr
>                 |-----.-----|
>                 |     . new |
>                 |-----.-----|
>                      vma
>
> 1. Duplicate vma
> 2. If new below, set new range to [vma-vm_start, addr)
> 3. Otherwise, set new range to [addr, vma->vm_end)
> 4. If new below, Set vma range to [addr, vma->vm_end)
> 5. Otherwise, set vma range to [vma->vm_start, addr)
> 6. Partially overwrite vma node in maple tree with new

These are fine too. We will either report before-split view or after-split =
view.
Thanks,
Suren.

>
> Cheers, Lorenzo

