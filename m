Return-Path: <linux-kselftest+bounces-26053-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4C1A2D005
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 22:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CA5016830A
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 21:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9586D1B040B;
	Fri,  7 Feb 2025 21:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KDuP03m6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B5B198E81
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Feb 2025 21:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738965027; cv=none; b=odnx4OTK/Trr5isx48EKfA7t/myf/PCw+8ADI73k0KBDKLyylZ4T6q5Sr7h40x05jmTC6N2FGc0tZsSBu53Ic7Ni/1NBeWuZrRxYN2ASxoPID5A/11X7a/W37euUJbaycv+z8m5dFwQtfd5UsJZbjt38+1w6iDQ7WxR/7rRDs/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738965027; c=relaxed/simple;
	bh=DaiuwdXV+e5Udz/gDTYrC6Cm/Dr7M9iTNsCd5vdoSwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nfN7mSnp+jjXNAtat6qCDpJUG7yq3EfkL4v+i1OrgeqvxqLb2Sf3x/xy9L0JH58+AsNic/tMoSf4XLGlkPH/fyeQyiF7JL/Z8ykXBqe/aRyI+lLKyYt2cviS3dYS4zeNpXLVeEUs6YU6M9tlnpIFBYzLyvhpCXqchoJ+vlGjKLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KDuP03m6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738965024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wt/rhXICuGKPz6p+qSVDOoOIpUebsnzqpQhWZ7aI0s4=;
	b=KDuP03m6/dd+qwR2l8sMfk+y18vsRxnkxOxdpN4EUCzqGJuwDFjFKfFcJZp9MgVyRERR4g
	NVk8ZXe/WVmCNs1muXpkp5te56Jl+ekSKF97lhNrlD1n2c8ltdAlo1HPqa9Zxe1i3dJB0w
	7Q8qYFQARkxHgFbWPDGmN4afeQFE6QE=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-Eq5FZEPvPdKs14mEjFfiYg-1; Fri, 07 Feb 2025 16:50:23 -0500
X-MC-Unique: Eq5FZEPvPdKs14mEjFfiYg-1
X-Mimecast-MFC-AGG-ID: Eq5FZEPvPdKs14mEjFfiYg
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-21f1919a7beso52550295ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Feb 2025 13:50:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738965017; x=1739569817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wt/rhXICuGKPz6p+qSVDOoOIpUebsnzqpQhWZ7aI0s4=;
        b=gfIvjBz2E+eILREmpG06wuOFDJ6C8a60vatO/91EwV+dqbork6zAsg9yrZaxvHTHcd
         tpAwjb1UE/i9g/z9iF3wmKl64RSI+F8lwg4xrMi9jTTAHEAe1zO5EkmE0Nj2czYOxb2+
         EC6vafU7FmQ0aDVBlhylgybHZB77b3OV3etN3ugv5cuvSy4U+PCOJWt9aU4g5UZ/lKWS
         GkR7JVSoHw0MBCnUt5uEmGG5psHSDB9Jp7fXNO4D/H2WBd5tpcQgBxrTxbCdWBOeehGx
         LdOhCLJ7q4oMGuovNDzqCUzeYfrYeu25JcjGV5hb2Of8Uv2xFv0crfTTC3KVo8X0YPtX
         lKOA==
X-Forwarded-Encrypted: i=1; AJvYcCW4gZM3E+2istmUNMceuF+ZpguMUrCCE8FM8meW2MEhJVdPojPFfmxSh4aFKyaRCy4Jcen7hTATfGrDiFyYFI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdUc3Lm6JEfV7CKgQL3rPNP06F6F1qR70pOFuaV8pbL4gQhUlH
	M2Ka01Q2QF2E0DmN/FUnpVqnK8Uo3b+EwEPLlCqwXrRwJssv1HAr0on3JEEYYg4Rrh0tnDHQ39h
	4CQdzcGzd6cH5LKcXWs6g5Yckc6GgnXirYvQ2HSQZlNm8sbczjZvUVt8HgL9Yi6HFIbb4S1dF0M
	ZEe4o8MZWRWyC4M7/KTO0FD/XPVI4hJ7pss1YTlzhz
X-Gm-Gg: ASbGncsK7QjnvxyZ546pf6tuvdAlb73s6rkq1i2u4NKp8D/nVQPR45hz6tq0L3T3AJ8
	jZz+PDYIUp9MT9q1OjnGt5V5FlxQhGWHUIicIF5PCrWiRwxtv9b0ylXtdF4yO
X-Received: by 2002:a17:903:1108:b0:21f:4c8b:c4de with SMTP id d9443c01a7336-21f4e7428e7mr75240155ad.42.1738965016967;
        Fri, 07 Feb 2025 13:50:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMvuVYzR38ErU+ifgu+mCfqp/ihxTEzre+fWzUScLMCCUFSChUFoi8+zuc1opaccCYbwst09rlbD+RHdPBbw4=
X-Received: by 2002:a17:903:1108:b0:21f:4c8b:c4de with SMTP id
 d9443c01a7336-21f4e7428e7mr75239895ad.42.1738965016621; Fri, 07 Feb 2025
 13:50:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128163859.1883260-1-agruenba@redhat.com> <yoxmbxirfwr6tpl4lp3jnnb26ef3omhjna5b7p4d6522xvmnco@3eajr5hkfmhp>
In-Reply-To: <yoxmbxirfwr6tpl4lp3jnnb26ef3omhjna5b7p4d6522xvmnco@3eajr5hkfmhp>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 7 Feb 2025 22:50:05 +0100
X-Gm-Features: AWEUYZmF6nIf5aRYDSSXBkpBUfXVGKwt-1ffEK-4nKvj6uOlvVkZ8k7qSvT4pQk
Message-ID: <CAHc6FU5DDKga1ma72Dnvsj23DLJ3GyMd-CM0qx83EKhvo5p2ow@mail.gmail.com>
Subject: Re: [PATCH 00/21] bcachefs: eytzinger code
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Shuah Khan <shuah@kernel.org>, linux-bcachefs@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 7:56=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
> On Tue, Jan 28, 2025 at 05:38:37PM +0100, Andreas Gruenbacher wrote:
> > Kent, to continue our discussion from last November, I've gone through
> > more parts of the eytzinger code and as a result, here are some patches
> > for you to consider.
> >
> > What I've not looked at are the eytzinger_to_inorder and
> > inorder_to_eytzinger functions, as well as the implementation of sort.
> > Those functions could use a bit more documentation, but the code iself
> > looks reasonable.
> >
> >
> > Shuah, I've also had a quick look at converting the tests into kernel
> > selftests, but that hasn't gone very far because of the lack of support
> > for basic functions like __fls(), __ffs(), ffz(), and
> > rounddown_pow_of_two() in selftests.  Are there any plans for making
> > those kinds of primitives generally available to selftests?
>
> Ping on this patchset - can you throw up a git repo that's ready to be
> applied directly, and have you run the test that failed yourself to
> confirm the fix?

Did you miss this message?

  https://lore.kernel.org/linux-bcachefs/20250130103400.1899121-1-agruenba@=
redhat.com/

The test results at:

  https://evilpiepirate.org/~testdashboard/ci?user=3Dkmo&branch=3Deytzinger

are still for the initial version, but I've applied the fix right away:

  https://git.kernel.org/pub/scm/linux/kernel/git/agruen/linux.git/log/?h=
=3Dbcachefs

On top of that, I've got a small patch that adds eytzinger0_find self
tests. That patch still needs testing before I can post it, though.

Oh, and let me warn you about "bcachefs: Run the eytzinger tests on
modprobe" again: this really is FOR DEBUGGING ONLY, so please do not
merge.

Thanks,
Andreas



> Also, I'll make an exception for this patchset if need be, but fyi:
> in the future I'm getting out of the game of running tests for people.
>
> Either run ktest locally, or get redhat to chip in on the cluster and
> I'll give you CI access (and I highly reccomend that option, it'll get
> you quick feedback with a nice dashboard and you can use it for non
> bcachefs work as well).
>


