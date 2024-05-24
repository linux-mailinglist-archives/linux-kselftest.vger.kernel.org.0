Return-Path: <linux-kselftest+bounces-10658-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8948CE13C
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 08:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FE291C20F1E
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 06:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66595A4C0;
	Fri, 24 May 2024 06:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2AEojRY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532AE3D575;
	Fri, 24 May 2024 06:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716533906; cv=none; b=FjjBN9Oa16pvNOQfgphpjcY86CM9F2jZG8yQSX3H6wNA6uo5QRE0mpkDVeCugDYVumtPmjY6rhGRhMmjx8ulnAoHNOsZXo0MsSE6n17m1EGeknJzKlDPygfBUWddVcA4YNSvBw7YE+fUWrDUZrar+gRi2361fCA/f8HkliicVJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716533906; c=relaxed/simple;
	bh=VHScqeC2fmLF26N/w+C050h4YTn2N+1Eu/SkdWLkdsk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=lWJ6kPinW/mW5r9TKH8XK3YNtX37rYwly69Y5U1REuuowOYITf+UMiTIe2i9R6XD2teBKHZhtC/VOiNZFzeLA5KnSayIIvhj4Osjiekps58Y+TUPy+Dq/sY4gIjbo6xgsBLPWCwhL+lnQAXgBbIvHvPNQFrPW3lKmUxr503wS98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2AEojRY; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-681907aebebso416175a12.1;
        Thu, 23 May 2024 23:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716533904; x=1717138704; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WUxSDJgPVHpIgkdW/SJCU4zEFv1caSZKZZ1ujvSgGJk=;
        b=X2AEojRYczbWEOe18ry1bGSu7rfhgqM0+YoYiTSCizR3McMQXGSSUqs8H1Hg4F54xg
         m1EXvQkJdVZaAp1+aTcn+na/DqKqSwC+pStqWv6z1SGr2fcYU/DEIDoxOw6KFQ3ZEXBa
         AnJJtbO5dBEATfdJBAxv7d15IuvHZjQDUfjwBG48kpPs0N2EzaRZEUP1Or6IfFn1F7BO
         KadUyOhy7r1BQijTug9MXnnCPwaiCUinKOtub8G6pgGRVOpP++6I+FK8cJM2PoD/RF6d
         d4O4m6R6LVgpsHJ+0H/7RgW/xSF/7lxsQW5bjcTXcJB6+QG1hz6N5WNiPDruaVvqC1S7
         ij+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716533904; x=1717138704;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WUxSDJgPVHpIgkdW/SJCU4zEFv1caSZKZZ1ujvSgGJk=;
        b=ub1pXiLsTOhIOMkC9/b+dKytkbuK/uMcSGcrpGFxcw2MTj6QCdSYnkun2COHG1fvYr
         oIW3EWg1KaCoc8ziqjLoFDst6xf9qOXqhBsBV8XBeyThJkAdD4fvbAleILmk66M7M+zZ
         zrRAYEDf+9pacqcPxqMrcegCPfB13+eBnBz1XwWpZafgAbjJWZEalkpJkmhPKKayURC1
         HkNqCE6PSIDIkBPGMdvl906cBRAvGnlqKzFhv4RkACR7OSKhx5GzPVZlKdfWT4y8Qg9W
         juv59gBBG7szhY2DRBounRXf3cFKCrWW4H6FFQ6u4D0uczErL69F1zepyLLzxsVEyr/t
         fO9A==
X-Forwarded-Encrypted: i=1; AJvYcCWCaelZ5YVcvCZZy3W6X+dYkRA3gPcQ4LoGPkMo5RfWFl+ZjVxc0/XJIDkBwuYSBRhvQOQCEVxZIWYLASG/T0VfKgT8hcZqLnUOYsNBKJl471rFcnXtJDppzwfnvQiWYnHzv0hw11XGb7vAw5Bq
X-Gm-Message-State: AOJu0YwwKNNPnxzHB3bTcv48rV+m5/XnVsapy3LhC7eoGu8c7wAP4PLt
	Nl1ZmfTXmB0mlvTmbpi3pEiKWbsNczjLZ6d2IY4mH6HIMU2IST6t
X-Google-Smtp-Source: AGHT+IEyVxDn/tS3CPfkN4tv2etQTfMV97SvgDd69GnzXXAD79FVP1cAiZsDA/Dek/GUkxq0C6bqvA==
X-Received: by 2002:a05:6a21:3e05:b0:1af:5d8e:c6c with SMTP id adf61e73a8af0-1b212d5df8emr1657909637.18.1716533904568;
        Thu, 23 May 2024 23:58:24 -0700 (PDT)
Received: from dw-tp ([129.41.58.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c7d1b46sm6763385ad.110.2024.05.23.23.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 23:58:23 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Donet Tom <donettom@linux.ibm.com>
Cc: Shuah Khan <shuah@kernel.org>, Matthew Wilcox <willy@infradead.org>, Tony Battersby <tonyb@cybernetics.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>, Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH] selftest: mm: Test if hugepage does not get leaked during __bio_release_pages()
In-Reply-To: <d551d1cd-a02f-42aa-9de2-10ff7757224c@redhat.com>
Date: Fri, 24 May 2024 12:23:15 +0530
Message-ID: <87msofsntw.fsf@gmail.com>
References: <20240523063905.3173-1-donettom@linux.ibm.com> <20240523121344.6a67a109e0af2ba70973b34b@linux-foundation.org> <d551d1cd-a02f-42aa-9de2-10ff7757224c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>


dropping stable email again.

David Hildenbrand <david@redhat.com> writes:

> On 23.05.24 21:13, Andrew Morton wrote:
>> On Thu, 23 May 2024 01:39:05 -0500 Donet Tom <donettom@linux.ibm.com> wrote:
>> 
>>> Commit 1b151e2435fc ("block: Remove special-casing of compound
>>> pages") caused a change in behaviour when releasing the pages
>>> if the buffer does not start at the beginning of the page. This
>>> was because the calculation of the number of pages to release
>>> was incorrect.
>>> This was fixed by commit 38b43539d64b ("block: Fix page refcounts
>>> for unaligned buffers in __bio_release_pages()").
>>>
>>> We pin the user buffer during direct I/O writes. If this buffer is a
>>> hugepage, bio_release_page() will unpin it and decrement all references
>>> and pin counts at ->bi_end_io. However, if any references to the hugepage
>>> remain post-I/O, the hugepage will not be freed upon unmap, leading
>>> to a memory leak.
>>>
>>> This patch verifies that a hugepage, used as a user buffer for DIO
>>> operations, is correctly freed upon unmapping, regardless of whether
>>> the offsets are aligned or unaligned w.r.t page boundary.
>>>
>> 
>
> Two SOF, is there a Co-developed-by: missing?
>

Sorry about that. Andrew, could you please add the tag (let me know if you
would like me to send v2). Will take care of it next time.

Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

-ritesh

