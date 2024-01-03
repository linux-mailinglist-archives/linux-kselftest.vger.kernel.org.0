Return-Path: <linux-kselftest+bounces-2600-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AAA8226B5
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 02:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A27401C21CD6
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 01:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C296A10FE;
	Wed,  3 Jan 2024 01:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GPXoqfoh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C1317984
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Jan 2024 01:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704246915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5+OwCGOsIHEiALaM4BtPfZn1YP8/WcwN0PC3E3A5Muo=;
	b=GPXoqfoh4ETj8OZvv0L+OHLoV0YhpvhOstzYc6Qf4XQvKe+WhWjfTaL4iHkpQpItXYz1UH
	k0J7RkNpyDOVh+qjQaHA7QgkqCgr1ZdqBOYQ7KrjbEprwuuoSaognuy5P4DnCs3GfGYM3z
	96ZuM0oazoT94+mF1z/uUZ8lDDSSHP4=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-1B7MxQ0RNQmSE1zincmDug-1; Tue, 02 Jan 2024 20:55:14 -0500
X-MC-Unique: 1B7MxQ0RNQmSE1zincmDug-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6da4d130a82so1098804b3a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Jan 2024 17:55:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704246913; x=1704851713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+OwCGOsIHEiALaM4BtPfZn1YP8/WcwN0PC3E3A5Muo=;
        b=TTCTWyttMAjBElcFvAyxN7LcReHdOlxjwWz8aE3fuIcCQaw6TMmFAqQUs8fUXGo+jC
         yoLZ7CdBiQqc1DFygXpQnO3PvB18mSZ3oL4xhR+pK52VhIMY4hx2TihlinAvIi28LlDy
         LAEtsV+tpSq3fysKavoQGwbslEdEsc8Uv5pNDlrBHGAv96PJ66F6J3Xd6N66xoIYKbGI
         o+K4zpWP3smyBAbhfEmrGl9Jdbwr0UyejjxAj7PAA87Q1WAuxJp2/2IMn1pCyvizj8aH
         eLU1MyZXX57eNYQtx5bhUZEK5XL2s+0jHyfDNczCVfax5W8BpJuxHk3uRrjFJJePHFV6
         a8WQ==
X-Gm-Message-State: AOJu0Yy2oVRsjYm0X4ZkEVP1UPHWzFgNo+mKyM4fsg58eHkV9ZtCX3Qb
	gz1L5yKwB+OyXK1Sv0ngwtOZUaQbwS6xuAkFQHWmHiTljSOr8JBtl4KNkqlKCu4vDrlQVmYasn2
	t2IwqCKDJ7pqS+YgVd+E4TOZ0SHTdDyu59Kvu
X-Received: by 2002:a17:902:d389:b0:1d4:f1c:6363 with SMTP id e9-20020a170902d38900b001d40f1c6363mr36694264pld.3.1704246913074;
        Tue, 02 Jan 2024 17:55:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFE1VRAgZlF4eJzDsAhgUMRAVjD8W2rPGkIhmIJMebLALfwg6LoEE4rio7wycrCnlrts/vgwQ==
X-Received: by 2002:a17:902:d389:b0:1d4:f1c:6363 with SMTP id e9-20020a170902d38900b001d40f1c6363mr36694251pld.3.1704246912799;
        Tue, 02 Jan 2024 17:55:12 -0800 (PST)
Received: from x1n ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902868500b001d096757ac1sm22501248plo.47.2024.01.02.17.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 17:55:12 -0800 (PST)
Date: Wed, 3 Jan 2024 09:54:58 +0800
From: Peter Xu <peterx@redhat.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	shuah@kernel.org, aarcange@redhat.com, lokeshgidra@google.com,
	david@redhat.com, ryan.roberts@arm.com, hughd@google.com,
	mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org,
	willy@infradead.org, Liam.Howlett@oracle.com, jannh@google.com,
	zhangpeng362@huawei.com, bgeffon@google.com, kaleshsingh@google.com,
	ngeoffray@google.com, jdduke@google.com, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 1/1] userfaultfd: fix move_pages_pte() splitting folio
 under RCU read lock
Message-ID: <ZZS-crdr54WqL7Ns@x1n>
References: <20240102233256.1077959-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240102233256.1077959-1-surenb@google.com>

On Tue, Jan 02, 2024 at 03:32:56PM -0800, Suren Baghdasaryan wrote:
> While testing the split PMD path with lockdep enabled I've got an
> "Invalid wait context" error caused by split_huge_page_to_list() trying
> to lock anon_vma->rwsem while inside RCU read section. The issues is due
> to move_pages_pte() calling split_folio() under RCU read lock. Fix this
> by unmapping the PTEs and exiting RCU read section before splitting the
> folio and then retrying. The same retry pattern is used when locking the
> folio or anon_vma in this function. After splitting the large folio we
> unlock and release it because after the split the old folio might not be
> the one that contains the src_addr.
> 
> Fixes: 94b01c885131 ("userfaultfd: UFFDIO_MOVE uABI")
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu


