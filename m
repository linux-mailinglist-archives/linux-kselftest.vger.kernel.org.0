Return-Path: <linux-kselftest+bounces-42354-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF93BA035F
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 17:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 068543229C1
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 15:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD0A307492;
	Thu, 25 Sep 2025 15:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gol47kuJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BE72E22BD
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812809; cv=none; b=T3FMW7uCjW+xT7/1dvOiq+DkfW4sIOaKD+uKSNjLtK9gKNv8rwN2rmC7wgcFsFQ5MenJROe5mwbcxNJpjyT9rP0OayRJ9jN0xAOBeYA+NtQ/84FW/Z2JeAYo4FL0BGgjqPvr267VYdAYrBQwc5Yj+rBQXnkbmgkI8KUu/7acs+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812809; c=relaxed/simple;
	bh=0EpGH4MwDbcizlCggFCTnPr7IrP4J3CDCKfs8jvP9TY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ivsSwwP6fsCdMNRZcmkuOSV24OCOO9sJguAiAQQTc51iTGWvcYxa4TjKwr1poWeXGKPm3xuTT5iDuv8LBmgrmcs04QIN29zYtTmcPxLhxd6QsrFGBU2kdXElKIvfuJBFP+/mi6a9iDV/dSM/R7LF5blvY1pTaHRHJTmCPVw1e64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gol47kuJ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e2eb787f2so1006795b3a.3
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 08:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758812807; x=1759417607; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jh5MSqTLsjrp4fvoa9f2K3rue2zEjmwO4t9rR+bj9fI=;
        b=gol47kuJ9acsLtfW2IwzLWuooJIDmQq9873ZhWoEj0JftEk9oLWpBQHhtr6z+kSE9S
         0FEb//SunmT1U27blL0FfCErzAsfpWHhRBt72y8ofi6U3LYzhdRjOu4OZvDkXgwGvlRg
         TIiMBVIlZwQKQpVM4W5NsB+uikjrtD0uprCYWZgH+uDrthU2nIw7XKcD13wiFZQvYEhf
         jp6pdIANl8aTL/KS6flRmI0oWxkm4un0kP/vi4aWbqUcWpmkIuM/gN5EPJBTxMt91B9g
         5xnee3VAsB5Wa8NoGCaei1vOP3W2RzwjY8lsSRJox9AVbyrVuuEfUONujYaouQAuDzKM
         r05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758812807; x=1759417607;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jh5MSqTLsjrp4fvoa9f2K3rue2zEjmwO4t9rR+bj9fI=;
        b=aj6ktmMjOnh7hCR5xC/19w1/ZFaBYRPR2l1WLDINoqO74bJE1Eqn0dLksYEegHQ43k
         Now7b2M0hD6sLGM0rYD1rv+oTknR1hGNNnGF1liPqTJKgwif1S39o1WMzKO7aXKfhXAV
         Ixc12KdOpqAkkwQQhJia7sQtKyo/yzSJQlNK4LqXgrEqxQ2GVopSzoqPWeqCFLjB4Hxt
         biIxKF29s+qQhaWVOonuQOOJdMopsUPM5zoVA0c7/3atqfktAEj7sh5b6Qvour4X53lw
         RbIINYwbMfgELr0YIShFjoU7oU7zzrBEACGh2b4HXhk3GuVtgE7NPmhTwjX9qYbKh7EV
         XOXw==
X-Forwarded-Encrypted: i=1; AJvYcCVJRcP6WhRYJSg8yiyL/+DGplNtDu0UGlqYrBw+VGglmwTgAtEJ6I6ewo55jzMpQl1X+lgA8d65snOIM7yr+pk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ3XM8Bmf6akV+9E0z1aqF9+wg6toM+DjP9ReCuGH9MMJnV8MA
	z7tRn0WjCg0lQrGGweMTwQ3g6m5//04/trlRa3FO3we70q9EUWLUzoSTvHN7ZFvQ1xrAF4lcoMm
	ZyHFzUA==
X-Google-Smtp-Source: AGHT+IEVcWsyGM1w0GH1nNrshkk20Pnc8ghwxFB8MAUOFgcR14npidYwrEDITe3+YHWa4Mb/5XspEYhl1Ac=
X-Received: from pga11.prod.google.com ([2002:a05:6a02:4f8b:b0:b4c:213a:e7aa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3282:b0:262:1611:6528
 with SMTP id adf61e73a8af0-2e7cdda0840mr4939471637.29.1758812806367; Thu, 25
 Sep 2025 08:06:46 -0700 (PDT)
Date: Thu, 25 Sep 2025 08:06:44 -0700
In-Reply-To: <3a82a197-495f-40c3-ae1b-500453e3d1ec@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827175247.83322-2-shivankg@amd.com> <20250827175247.83322-7-shivankg@amd.com>
 <diqztt1sbd2v.fsf@google.com> <aNSt9QT8dmpDK1eE@google.com>
 <dc6eb85f-87b6-43a1-b1f7-4727c0b834cc@amd.com> <b67dd7cd-2c1c-4566-badf-32082d8cd952@redhat.com>
 <aNVFrZDAkHmgNNci@google.com> <3a82a197-495f-40c3-ae1b-500453e3d1ec@redhat.com>
Message-ID: <aNVahJkpJVVTVEkK@google.com>
Subject: Re: [PATCH kvm-next V11 4/7] KVM: guest_memfd: Use guest mem inodes
 instead of anonymous inodes
From: Sean Christopherson <seanjc@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Shivank Garg <shivankg@amd.com>, Ackerley Tng <ackerleytng@google.com>, willy@infradead.org, 
	akpm@linux-foundation.org, pbonzini@redhat.com, shuah@kernel.org, 
	vbabka@suse.cz, brauner@kernel.org, viro@zeniv.linux.org.uk, dsterba@suse.com, 
	xiang@kernel.org, chao@kernel.org, jaegeuk@kernel.org, clm@fb.com, 
	josef@toxicpanda.com, kent.overstreet@linux.dev, zbestahu@gmail.com, 
	jefflexu@linux.alibaba.com, dhavale@google.com, lihongbo22@huawei.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, ziy@nvidia.com, matthew.brost@intel.com, 
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, 
	gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com, 
	tabba@google.com, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	pvorel@suse.cz, bfoster@redhat.com, vannapurve@google.com, chao.gao@intel.com, 
	bharata@amd.com, nikunj@amd.com, michael.day@amd.com, shdhiman@amd.com, 
	yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com, 
	michael.roth@amd.com, aik@amd.com, jgg@nvidia.com, kalyazin@amazon.com, 
	peterx@redhat.com, jack@suse.cz, hch@infradead.org, cgzones@googlemail.com, 
	ira.weiny@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	chao.p.peng@intel.com, amit@infradead.org, ddutile@redhat.com, 
	dan.j.williams@intel.com, ashish.kalra@amd.com, gshan@redhat.com, 
	jgowans@amazon.com, pankaj.gupta@amd.com, papaluri@amd.com, yuzhao@google.com, 
	suzuki.poulose@arm.com, quic_eberman@quicinc.com, 
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 25, 2025, David Hildenbrand wrote:
> On 25.09.25 15:41, Sean Christopherson wrote:
> > Regarding timing, how much do people care about getting this into 6.18 in
> > particular?
> 
> I think it will be beneficial if we start getting stuff upstream. But
> waiting a bit longer probably doesn't hurt.
> 
> > AFAICT, this hasn't gotten any coverage in -next, which makes me a
> > little nervous.
> 
> Right.
> 
> If we agree, then Shivank can just respin a new version after the merge
> window.

Actually, if Shivank is ok with it, I'd be happy to post the next version(s).
I'll be focusing on the in-place conversion support for the next 1-2 weeks, and
have some (half-baked) refactoring changes to better leverage the inode support
from this series.

I can also plop the first three patches (the non-KVM changes) in a topic branch
straightaway, but not feed it into -next until the merge window closes.  The 0-day
bots scrapes kvm-x86, so that'd get us some early build-bot exposure, and we can
stop bugging the non-KVM folks.  Then when the dust settles on the KVM changes,
I can throw them into the same topic branch.

