Return-Path: <linux-kselftest+bounces-36831-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8090BAFED3A
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 17:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71F695A64AD
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 15:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203082E54DE;
	Wed,  9 Jul 2025 15:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EBK4/Whb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9451E2D1914
	for <linux-kselftest@vger.kernel.org>; Wed,  9 Jul 2025 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073601; cv=none; b=nBo+AtsI+27Dp2j5u0YTzdyI7ukWh05VmjjmAS+J2CXsuAhNEQ8NVIYVPbqtuqaWXXFFITINJt5iOdJvOqnAMYVoMZcSoyo0qLKOlE5kmuviTQsRJw26vOw+UXh3oORzcVH9WGR9nKiO8gy5pu7OsRQZMO4+WxobDLtWiq/Wv+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073601; c=relaxed/simple;
	bh=hvwdwQ64KjVHwTy47XVtw9Pp+Ymb1X2ttmMlI9VRYTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kl6N4ClhNHGCxTF4L7B1Utw3VOjtJFnCDpPVxon0tmZCcrkm1Id519/LVPlbioxTwJR1rPVMYDROxbxGNAL7ZrZM8Z3kRljxFJ0FNDIHKPhtiwHcBzDA5ixbSQmBJHp84Q88VHadX27b9hrH70+nzW7RF5TPTyYTCFbg8QZCN74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EBK4/Whb; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a7fc24ed5cso321081cf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Jul 2025 08:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752073598; x=1752678398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fd2LSjDPzvM9cn+8iN5hrypSfDyrgOivdhgeXar2Dyk=;
        b=EBK4/WhbpXKRcYKp8LI/KJKQH80Tryc5aL/tYHdWjZg+bipx9MKa4TLqcxGU8QRdAc
         e8WnArb+SVDqcedch5UJjHK/F4Xi9XrMzYAJCiGrdqXgvK8js0vjOChlX1KMwc2kMuWV
         ij2tiE2m84cTsFUIDFqx3+60q7PIEqy3lHcfA7x11Usf6Lx0bws7T4iBJsLbISsEmScJ
         jAJS6EiC5Um5ctsWeXF+5hgFsR3YWO+q9VM4KLdx3urhg/Twy224I/UDSBBgE1n48xDS
         0PiQLTn4SsEDCnmZ36EBS5lNWpnssUpbUj78wOzFQ8heI1HhuEqjyMicxCDDtGpErjpv
         HfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752073598; x=1752678398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fd2LSjDPzvM9cn+8iN5hrypSfDyrgOivdhgeXar2Dyk=;
        b=G7ccj4N+3fm0RNBUn9ppPyO1pQOmSzXA/gkJ1xdzwEaLw1ke/c4nS0k34gxfrY5Jb8
         ofC3qxgkzIqyPKfrTBmNFUHmrSsz0VGkPZ4/SRvd6Buk10RYpejb2XiXHnOMQUHqsu+w
         eyiFTIi7tVgV7raUyj0i0bi/teO4iQA43Q1J0pT4WkJgRhouFCPX+BTxfXbyleMbi2Sy
         RnHaYeUiQl3E+FPpJl7Vd88fXVxphNdXOa3Bgmf8neDqVFljxheZdCVfZzVDBr0gG3Gw
         hXfNKAU9l2OXYozF/o5Mm83ZKSZyTAaPwpv5NbRKDF11Elno0/o3cbWOr+mnQRW+tkY6
         MY5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVn4VBOTZnirQtszfg1/Lnzj4qCw1NwYs1You6CnNNj7ZCUx8/N4LxNctdI/sxtLJsFbaNHNY1WZpv0t35tESE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ3a1QphjLS1LZpjdgDqP0NnVJ5fj+SszV1EhlecIeOB19bkIG
	xUtdYrQnJ2O3zkyyb7U8uMaVf7bEOocmgsCQqF8ASzQjDACEwT+NDZGAyj3lgxPGDsUHm9jUmZl
	HfDDDSlWlc78JQ/PqwlUNDDoAy8blk2JsC3FtImwO
X-Gm-Gg: ASbGncsER7IoeYCbtoQWIlfp28RB1Gz4ULUx5/JHWN/CHdhq+j7U8bpDVzCy7OiZvCk
	Pxu5HWCM3vFA0OYVv1x/YGYccRJOThTcZRxqA6dEElRLPZB7k8+sjL9tmBpL/Nh+wuIhEd2XPVd
	iLIwiwup/dS8RWsUcX2zKr15w/akCnsGLdYwsn2zTKXAv2BWfOCZA4mXvhTwD5d3ScFO5AdJG26
	2/9rX3A1w==
X-Google-Smtp-Source: AGHT+IFObe64g8yHGu0QvxHsq+CwSkBURq49auTx3IFoft8wHRZU0csu9NWkwFe0ATMRPTvxjGwBT7kJkbtOJQwk4cM=
X-Received: by 2002:ac8:5f0f:0:b0:4a4:d827:7f93 with SMTP id
 d75a77b69052e-4a9dca9ca39mr4738371cf.0.1752073597764; Wed, 09 Jul 2025
 08:06:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704060727.724817-1-surenb@google.com> <20250704060727.724817-8-surenb@google.com>
 <f532558b-b19a-40ea-b594-94d1ba92188d@lucifer.local> <CAJuCfpGegZkgmnGd_kAsR8Wh5SRv_gtDxKbfHdjpG491u5U5fA@mail.gmail.com>
 <f60a932f-71c0-448f-9434-547caa630b72@suse.cz> <CAJuCfpE2H9-kRz6xSC43Ja0dmW+drcJa29hwQwQ53HRsuqRnwg@mail.gmail.com>
 <3b3521f6-30c8-419e-9615-9228f539251e@suse.cz>
In-Reply-To: <3b3521f6-30c8-419e-9615-9228f539251e@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 9 Jul 2025 15:06:26 +0000
X-Gm-Features: Ac12FXztVJ5s9fCB7K-LjcBbs5GAqT1LZ8_q7BFwH_XHKRDYfr41flVEbIRKQLo
Message-ID: <CAJuCfpEgwdbEXKoMyMFiTHJMV15_g77-7N-m6ykReHLjD9rFLQ@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] fs/proc/task_mmu: read proc/pid/maps under per-vma lock
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org, 
	Liam.Howlett@oracle.com, david@redhat.com, peterx@redhat.com, 
	jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org, 
	shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, tjmercier@google.com, 
	kaleshsingh@google.com, aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 3:03=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> On 7/9/25 16:43, Suren Baghdasaryan wrote:
> > On Wed, Jul 9, 2025 at 1:57=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz>=
 wrote:
> >>
> >> On 7/8/25 01:10, Suren Baghdasaryan wrote:
> >> >>> +     rcu_read_unlock();
> >> >>> +     vma =3D lock_vma_under_mmap_lock(mm, iter, address);
> >> >>> +     rcu_read_lock();
> >> >> OK I guess we hold the RCU lock the whole time as we traverse excep=
t when
> >> >> we lock under mmap lock.
> >> > Correct.
> >>
> >> I wonder if it's really necessary? Can't it be done just inside
> >> lock_next_vma()? It would also avoid the unlock/lock dance quoted abov=
e.
> >>
> >> Even if we later manage to extend this approach to smaps and employ rc=
u
> >> locking to traverse the page tables, I'd think it's best to separate a=
nd
> >> fine-grain the rcu lock usage for vma iterator and page tables, if onl=
y to
> >> avoid too long time under the lock.
> >
> > I thought we would need to be in the same rcu read section while
> > traversing the maple tree using vma_next() but now looking at it,
> > maybe we can indeed enter only while finding and locking the next
> > vma...
> > Liam, would that work? I see struct ma_state containing a node field.
> > Can it be freed from under us if we find a vma, exit rcu read section
> > then re-enter rcu and use the same iterator to find the next vma?
>
> If the rcu protection needs to be contigous, and patch 8 avoids the issue=
 by
> always doing vma_iter_init() after rcu_read_lock() (but does it really av=
oid
> the issue or is it why we see the syzbot reports?) then I guess in the co=
de
> quoted above we also need a vma_iter_init() after the rcu_read_lock(),
> because although the iterator was used briefly under mmap_lock protection=
,
> that was then unlocked and there can be a race before the rcu_read_lock()=
.

Quite true. So, let's wait for Liam's confirmation and based on his
answer I'll change the patch by either reducing the rcu read section
or adding the missing vma_iter_init() after we switch to mmap_lock.

