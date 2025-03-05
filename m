Return-Path: <linux-kselftest+bounces-28347-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A75FA50E27
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 22:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A1177A853A
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 21:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C332263C7B;
	Wed,  5 Mar 2025 21:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BYObyRBI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38DB263890
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Mar 2025 21:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741211368; cv=none; b=lEBYz2z1Y/tBt7UX5Vb1czr30z50iARWU8mYGYLkabt8aP6567071G62IJh/z9cVjevJA//Bsav3HbRpQVxThTUkSJbY+icSUK/t4V4+FijdVYaGCa5AejMGm5MjpE6FFItxMEt+ym+3N/Afm4NwQbJP94pTJ7t1oR06xiZoplk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741211368; c=relaxed/simple;
	bh=LRJVuLEqeYXR3kO4MxhRsCf150DENkpLf9kgHGf2dx4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kfHBxW4Us9q5wdL7rG8eps9ByNty1uWeDwW9RbxrZm+Do8pDc2f6iIqpUV0zwKn3weXkfRSpcfaSjxbzSMls1O1MR60Viwvb4T9a+WGEQ2W6T2nhjMft76NjkTOCET46BsQSo/TRoB2zG8JMFLg9U+ZmKGTQHYYtTGffwLfufag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BYObyRBI; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2234e5347e2so150944745ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Mar 2025 13:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741211366; x=1741816166; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=omvL6JKP93PIw7TY0fUbQoFMf9D9z+VnaM97mXHofWw=;
        b=BYObyRBI69V5Hq018DAcS33/Hxc0c1TRQuIrtqhFWCnH9cNM2CuhI6yUrLSR5Y9ucN
         K8OtBG2FSeNv4n+fywJTyBs8aoV0IqW11vHHYSDTXGuMhVgAT9yIZlymtreBj+zZaoBc
         RjYlwdb0AKvpcv/tQ9C6f/CviElNWbFoAtY6aaYXyfeGSC8HhD2eFAe+YtgTFZokRXO9
         5XAXmq/z7uoqrt9A0tWkXXIj55kEwllMONhDuLOfhEZazdLMZn1azXEQVMOAVCY17vY0
         PXk0XHDzQx8ljQEPEHV5xA5iNcUA4U9hkd4DjPqrdyd9WAeBWK+gHOFYSqRB0PB9B9Eg
         N1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741211366; x=1741816166;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=omvL6JKP93PIw7TY0fUbQoFMf9D9z+VnaM97mXHofWw=;
        b=DPjyt5QnZLASLDkQZ8Y5Uj7OG2RSv0lais6tyVTDtrt+cepvRexzQgF6tMbxT3YRmS
         J6/2we4xN3X2NiffA8U2dk6X5kuisUQRrxkRXgnfI5yznx/sGTpBh/8PW++2E3RDKq2p
         XV+vNz4cDn37yVdd6hsZkvmQoTPvzc3NgsKGVbT4jp6QcPZdRfLT7gWZI6ro3SU6n3Rb
         Y8GdySBrw5kWXPopq/uVfFlP+gWSRkEaJREuwdLQoOhuqUno7mFWJIgyrpiGCzsIMtGX
         CXaDWFckEcb9OpuTav8WuKWiPLmuz5IR3PVW9BGWcx9xErj8Mol8L2pyzCK56pQVsQ0N
         wn3g==
X-Forwarded-Encrypted: i=1; AJvYcCU5MQAp+mI8waQE//Jc5gU+Xp4m/+xB2SEO58iUzVfzBrmzwL7okZC06YCt+a90W4+Tseb1BAjw0NThg6GLzzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpDpaQVExgc9nKIBFf0H59yXi9yiXjsdyeVrjUFDD5nWHUCHvG
	brAvGCYpuEikXEHmGu00Bv7shP1BE724r7rmWL7qX6oKoGf/wKv7eFQniXA4BQ==
X-Gm-Gg: ASbGncsevaZfkm0BHV0Pr/nrpHkgr9+K5VE1iS+7dWC5it9Ex8fcxuaBGm0FIW6vKuc
	72RqZ4M5kG4wWVXJn54zpuZyhvECe0Uu0Bc9O4C6bvvhgunWjzehXnVNcAicSS/8VomxPw9xAbx
	mJB92c/KLiJlb+j/gdLRMeDtjAwXB7Z2+XFad9LMWrU/m5Ju4u8QSIB3QTQw4b5kzMIA09aum0t
	wh789JuOiA3rIE/hZmt6TTEOSfnabLcr/Ba3gZmDq1orzet7eLxh/+4tf0FLojlMV2wmlCPON1P
	dNYqXv6aN2+Nqwy4Nccpt0aYKUEWFSpUiwyMBRdD6YGUhtEWC9YZ74l873bRKFDeE+Lj/pWkTGj
	67/riy+N7hjKIENuaif+vsJvaOboZ
X-Google-Smtp-Source: AGHT+IHSkFlk8MRI3CZ7RZFHiHVlcup3GLPbGFJoYnXtQKvKTu0EkzQziZ13veZ5NCqPBYhRd4YuXQ==
X-Received: by 2002:a17:903:18a:b0:220:faa2:c90a with SMTP id d9443c01a7336-223f1cf3264mr68708715ad.37.1741211365880;
        Wed, 05 Mar 2025 13:49:25 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2240a59d176sm1897595ad.127.2025.03.05.13.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 13:49:24 -0800 (PST)
Date: Wed, 5 Mar 2025 13:49:13 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Zi Yan <ziy@nvidia.com>
cc: Hugh Dickins <hughd@google.com>, linux-mm@kvack.org, 
    Andrew Morton <akpm@linux-foundation.org>, 
    "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, 
    "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
    Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>, 
    Yang Shi <yang@os.amperecomputing.com>, Miaohe Lin <linmiaohe@huawei.com>, 
    Kefeng Wang <wangkefeng.wang@huawei.com>, Yu Zhao <yuzhao@google.com>, 
    John Hubbard <jhubbard@nvidia.com>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Kairui Song <kasong@tencent.com>, Liu Shixin <liushixin2@huawei.com>
Subject: Re: [PATCH v9 2/8] mm/huge_memory: add two new (not yet used)
 functions for folio_split()
In-Reply-To: <43642DB0-17E5-4B3E-9095-665806FE38C5@nvidia.com>
Message-ID: <fd0ca9d8-e8b2-dc2d-d2c7-030a49a13035@google.com>
References: <20250226210032.2044041-1-ziy@nvidia.com> <20250226210032.2044041-3-ziy@nvidia.com> <2fae27fe-6e2e-3587-4b68-072118d80cf8@google.com> <FB1376C8-E0AD-40CE-BDE8-AF9269EA68CC@nvidia.com> <238c28cb-ce1c-40f5-ec9e-82c5312f0947@google.com>
 <43642DB0-17E5-4B3E-9095-665806FE38C5@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 5 Mar 2025, Zi Yan wrote:
> On 5 Mar 2025, at 15:50, Hugh Dickins wrote:
> >
> > (Historically, there was quite a lot of difficulty in getting the order
> > of events in __split_huge_page_tail() to be safe: I wonder whether we
> > shall see a crop of new weird bugs from these changes. I note that your
> > loops advance forwards, whereas the old ones went backwards: but I don't
> > have anything to say you're wrong.  I think it's mainly a matter of how
> > the first tail or two gets handled: which might be why you want to
> > folio_set_order(folio, new_order) at the earliest opportunity.)
> 
> I am worried about that too. In addition, in __split_huge_page_tail(),
> page refcount is restored right after new tail folio split is done,
> whereas I needed to delay them until all new after-split folios
> are done, since non-uniform split is iterative and only the after-split
> folios NOT containing the split_at page will be released. These
> folios are locked and frozen after __split_folio_to_order() like
> the original folio. Maybe because there are more such locked frozen
> folios than before?

Sorry, I gave up trying to work out what you're asking me there.
Let's assume I don't know the answer.

Hugh

