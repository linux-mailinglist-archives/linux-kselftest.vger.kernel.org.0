Return-Path: <linux-kselftest+bounces-37096-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6927FB01B87
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 14:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECA33648322
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 12:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB0E28CF5F;
	Fri, 11 Jul 2025 12:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ia9o9Iau"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFAE1F4C8C;
	Fri, 11 Jul 2025 12:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752235790; cv=none; b=bVmw8bA+Z0bqRBmfcf3BhvR4VuS9BMpc/HwPOt8B6b81yYkIqMJAAeU7W3orBNXeO+GjXhYw1DdtFOGOQh1b88TD5pTzgZjf95lqbR8hu8XWfa5LFACI7Oa1ks8m430ySIr0X+BwtTDTAgys19JCqdg/tz7x7ZLTFTuiHAphGrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752235790; c=relaxed/simple;
	bh=1mUysb+8o08SdBBmYbBUyKMVp31ubQlaOrJqMOyPPks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/5k38YPBSgOdD/lRfwv2S8i20zG8F179hIxIfwQmDPNULXrsg9ok2fLgaljGrSrdVRVzVlzg6mMhMfNtoNFi+6Qzheh4cx2YIkvQyEtL6k6bnN3UCrw+8bL/dMd0u+ffdZAm3PVe9phiGWLIisNPyWrmkNmXxJjrs4h81K6u4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ia9o9Iau; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-73972a54919so1811763b3a.3;
        Fri, 11 Jul 2025 05:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752235788; x=1752840588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZh+h9FkEGoNBmFQ/fWxX9YZY8n00mTm9exBYWyxMyE=;
        b=Ia9o9Iau06WfbNNgeNWenOCOT/YMZjrI1fBkrN8Tv6jy04w0T1oArsOvkhkJrMU8pD
         RHEZU5u/Bo5n14oHuYoPJXOouCuQbzwMZjTDphy3OoDSKot+E5ddVZ5gdNA4FSWxJz9n
         pl6RaRqR5owwko5ImcQE5QHZgFhb7rmRDyj9J0AIe7ZPUCA2l7sjOkENQwnDKQVupfda
         8UGHFJZSZcCauXO5Wtrj9Ch58WCpOle+Gh20OopFfJVqqILovfkSekCYyEKHPtHCOmyS
         laCUmkm/7gHLSU/7w0UlhYK1TdJuxqG2m+jJ5kmu/zer4Yw7ep6Zvdwu5cO0BhMakZgm
         vSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752235788; x=1752840588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZh+h9FkEGoNBmFQ/fWxX9YZY8n00mTm9exBYWyxMyE=;
        b=a9p4p/FNUAgEdgLkLc4g+qxbEW22hjzOFhVvJkVcDrCWt+kiq+Qwz/xwSRuySVlIRp
         yRZGO/mjIpUHW+9eOkjZzO/cojM+YkKerGHLR5UYBO7GWJAEkvtC2aaLvvbkQa5LU1uG
         /foCIF8Fvz97+PXZAzyI2C76SyNgpivGMSCX+v8oAdGkOwSEkD5Sq7VemSrNiZxny7ax
         DtHJM2tHAxECsN4PG35M1YkYw+MAtBK9feuStPdy3oUxBdYEJvzywJk2okTXXHm6kPTL
         131RMcpQV2HGByOFYtlNIJtSynUe/UYK4y/XSXK1tnjtt56XzVFUW484z87sF568/w/B
         iE0w==
X-Forwarded-Encrypted: i=1; AJvYcCUgexyf/qbqRymTez8zYuNgThhqEmtGv5mR1Tu8rNxGdQ6DEguP9lPX0Zd8Tap2oPk+hs+khKY2Vn3/tEY=@vger.kernel.org, AJvYcCXQqD62FAzGVasz6s0Te5ypqNIYtCWD/bW3LjTT6loJiSTqDEcM3gRFkXDOP+nYsLPeeX4dgt9VAtJyAb+NSDEK@vger.kernel.org
X-Gm-Message-State: AOJu0YyQbbwR8+iQhCbVLi5302x6wld+tQzV9P7ytp/NSBXwQMV4DbNp
	+rtD6LmAiPPNN9vV0w3y7vWx570tZxHYvfM5k2cVui/65R1yfqpCEO/O
X-Gm-Gg: ASbGncuIZ385z/5FADu25CYII/uc6AccIyYXCQupv+RM11GQkBaxKcmhwYmziyZI7si
	lAaL0BxD4Lxzmtlz7ZJpwiHGopjdLGsFwqp8joNOXp3W08Tks/MHx6q/++NDvcy4E+S9QyCv6JN
	h4PKRT/53Xj6C7UoeJ9gYDBsXk9KMa5M/mgF+mNVLk9W0OYunVpRmk3dDn82O324trp1NUKur7W
	2a6Vz1MUWJlbJyAoxl4eeSKxvOG/0YXlTAJiFwmnx9cGclkFto7ST4F7+L3Yi/N/7xuOl2lq6sb
	SZO6pyVKnxHHiwEc9MjCfruQTHs6eqid2gnUNe82JqeliH5CJSoWW7ItHJ77teoIbeGJWNjm8gc
	VDijamqMnHAZyVa3yO4dPXDVypYHbbwzVFd8ud/jCLhxRVh1o
X-Google-Smtp-Source: AGHT+IE2NZ0+J8d0OK9Iy+YWW1/9BUq73Ob8bE/TFoBEJqMyC+uapo8S3f7XGSDKa5bAQ5+00q06WA==
X-Received: by 2002:a05:6a21:8dc7:b0:222:1802:2dd7 with SMTP id adf61e73a8af0-2313504f6f3mr4547110637.13.1752235787862;
        Fri, 11 Jul 2025 05:09:47 -0700 (PDT)
Received: from DESKTOP-GIED850.localdomain ([114.247.113.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe72913csm4944545a12.72.2025.07.11.05.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 05:09:47 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: lorenzo.stoakes@oracle.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	broonie@kernel.org,
	david@redhat.com,
	gkwang@linx-info.com,
	jannh@google.com,
	lianux.mm@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	p1ucky0923@gmail.com,
	ryncsn@gmail.com,
	shuah@kernel.org,
	sj@kernel.org,
	vbabka@suse.cz,
	zijing.zhang@proton.me,
	ziy@nvidia.com
Subject: Re: [PATCH v3] selftests/mm: add process_madvise() tests
Date: Fri, 11 Jul 2025 20:09:38 +0800
Message-ID: <20250711120938.15270-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e05e7e0d-02e3-435c-bb82-91200a868448@lucifer.local>
References: <e05e7e0d-02e3-435c-bb82-91200a868448@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Lorenzo Stoakes,

> On Fri, Jul 11, 2025 at 09:34:38AM +0100, Mark Brown wrote:
> > On Thu, Jul 10, 2025 at 12:28:13PM -0400, Zi Yan wrote:
> > > On 10 Jul 2025, at 4:42, Mark Brown wrote:
> > > > On Wed, Jul 09, 2025 at 10:46:07AM -0400, Zi Yan wrote:
> > > >
> > > > > Right. My /usr/include/sys does not have pidfd.h. IMHO selftests
> > > > > should not rely on userspace headers, otherwise we cannot test
> > > > > latest kernel changes.
> > > >
> > > > That's not realistic, we need to be able to use things like libc and for
> > > > many areas you'd just end up copying or reimplmenenting the userspace
> > > > libraries.  There's some concerns for sure, for example we used to have
> > >
> > > Sure. For libraries like libc, it is unrealistic to not rely on it.
> > > But for header files, are we expecting to install any kernel headers
> > > to the running system to get selftests compiled? If we are testing
> > > RC versions and header files might change before the actual release,
> > > that would pollute the system header files, right?
> >
> > Right, for the kernel's headers there's two things - we use a
> > combination of tools/include and 'make headers_install' which populates
> > usr/include in the kernel tree (apparently mm rejects the latter but it
> > is widely used in the selftests, especially for architecture specifics).
> > These install locally and used before the system headers.
> >
> > > > OTOH in a case like this where we can just refer directly to a kernel
> > > > header for some constants or structs then it does make sense to use the
> > > > kernel headers, or in other cases where we're testing things that are
> >
> > > That is exactly my point above.
> >
> > What was said was a bit stronger though, and might lead people down a
> > wheel reinvention path.
>
> Let's PLEASE not rehash all this again...
>
> This patch literally just needs PIDFD_SELF, I've provided a couple of ways
> of doing that without introducing this requirement.
>
> We already have a test that uses this with no problems ever reported on
> which this patch was based.
>
> Thanks.

You are absolutely right, and my apologies for introducing this
unnecessary header dependency.

Just to clarify, the build failure Zi Yan reported on arm64 was not
caused by PIDFD_SELF. It was from my use of the pidfd_open() glibc
wrapper in the test, which incorrectly pulled in the system's
<sys/pidfd.h>.

Based on our discussion and a review of other tests, I understand the
correct approach is to avoid such dependencies. I will fix this properly
in the next version by using a direct syscall wrapper for pidfd_open.
Thank you for the guidance.

Best regards,
Wang Lian

