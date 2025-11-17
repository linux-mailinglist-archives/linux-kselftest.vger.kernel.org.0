Return-Path: <linux-kselftest+bounces-45773-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB50C658A0
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 18:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C25894F1D01
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 17:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADF1302776;
	Mon, 17 Nov 2025 17:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtcT5GEj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ABD30214A
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Nov 2025 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763400699; cv=none; b=VT9z55Mw7edsiW1KABwguhLK7jprB5f4JwayEBYmCrqWZ2a3Eedd1u4FNNy2Z5QieJk6Te86dbjxbL6aZIIHD/qeBWwV0cKwmuVFFCTj0iV8GMwHoqTDwklkCoE6REaQf1qAgPefhqtprhHfJVeAP1K4dNZHWv/+e0BYCAFDYlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763400699; c=relaxed/simple;
	bh=WV7KJq3JWbWy4X8KgHXwI0VdrSU307t+6yjEnmz/ZNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hmrwx2w9TA/01ybCtd6NiYwoaPhJP31bAEJVKTVF+6CUNB5HH3sWBd6MnTPqA1+IxHERK8mjU+dN8ukqwVVVqEybDaJUVrXa3w/JLyH0EHbdySUJ1JA+BaBe+O3436liU5TfltfSUrSwcoPgrVyQ5k/W4zAhe/I1gsp0Iw7o2ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtcT5GEj; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6417313bddaso7505696a12.3
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Nov 2025 09:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763400696; x=1764005496; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WV7KJq3JWbWy4X8KgHXwI0VdrSU307t+6yjEnmz/ZNg=;
        b=BtcT5GEjHAi82OkM7vnyPINxTKMwDZ++r5ATRIEObYT4pT/+Ax8pZRr2WtiXpICVJ1
         K3Iv9bZOWyOOISAI1Q1A5q1o4NZ8FwN2th1ci5lx9PVJWa9rHkx5OQ2kyWBi+6r3VSGx
         M+KtkdiqQaNI/IR3coe7n/dLAcOTb83fk85ClADrK5JD/nRWC4tFGfi5mYVBhOl/bZox
         XUk2sjISJb1M1dqG5QE93IWX+Bqwru4pEPRX6wFlJATOZcc6LIY3ZZKQMrIhNVFF77uo
         ahzMkpbLS8mjfnd9GfREqny+kGY+H8A2z/UX+MQ9YtJnKpLHC9y7+GEiu5WmZXGYGrUN
         yvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763400696; x=1764005496;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WV7KJq3JWbWy4X8KgHXwI0VdrSU307t+6yjEnmz/ZNg=;
        b=Axm0L4k16Xr09QLXCLVMgfSU06Q0MtyOjojuE3JYvFV74dOSKhpDmESRTmCQEeymgb
         Fce9NCP5GeP6bkeQZThhESbp0ZY5taB2XcH/rGkQLbfPJWsbbD2xjT8yJUFpq+EDw7bV
         Dg+lWTqeQVEOTd8+4NWRMxGdWXB22tn+Ch/ftNrIwd0PpQ+Z71ZtXDXG7xkR8sFsa19C
         TsEDmu8PKi6iTB2XGIsfG8HWpqqH7rGMgoUFKhiSWEGbNhcKgcpFcblgqDgvVNTXj2a9
         j69TXVx/A+qmtHoqEbQJ6fcIHmea2776Wvdw7Pcqf/TY/G4YFrCtVdzG3WwVMbja4HZ4
         1Wmw==
X-Forwarded-Encrypted: i=1; AJvYcCVGhex9Yd446YrRUwlbxuwR6ufgZUqSnFY1C+GoRoMDA9Z2lgNObm3azxttWTxO4PKJDnYx+L4f6oNFgAQhV3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBp3A+RbMh21MM9JFCxOFdrJtXuFvHBTdIv7ALAZ2JLL84Tc6I
	YMAvprzTO885zqaOm/lAvyE9kRzLM5Kk2wYGuOOA33+vCE96sNYlf0SY2GJ1g3doDdFE+SlnxyQ
	CPfCpgKn39K5zzG+gyagDH+PUW0ZCtw==
X-Gm-Gg: ASbGncscofbMWoyCFQ7vzKR6FnK5sLtrMqucGNfNtoOtYPxh4xX0pJwwAbLyrq1maBH
	Y6DA80nh6DJtb3w3SomcyVL0Gyr5BQyQddWXeuV1voHY6xuD2AW0MJX+KT8pMTvqHSWZqp8eTHu
	GGaieMSdz5EvpZaw3WIndIrqIqxbeNQyUoWItmTxQfdVE+wzIgV4RN2Ez1rNahGTW1Fqo4sCisR
	bEpcIt4ENePnzklHFJHf7z4LTZIr128dnCdswvASFdRy+iGiT/Sy3pA5yc=
X-Google-Smtp-Source: AGHT+IFVNP2uP6Q0JshZHVUTd8X1+5WDmG7OavAZHYwuqKhkIu2hA2v7ot1RIcdD+T6gGeIwMDW97WO+/8hkBclFsrk=
X-Received: by 2002:a05:6402:5112:b0:640:a356:e797 with SMTP id
 4fb4d7f45d1cf-64350e2092amr11284922a12.13.1763400695483; Mon, 17 Nov 2025
 09:31:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113034623.3127012-1-cmllamas@google.com> <e0be6864-4260-4843-a432-d47437b5d43f@kernel.org>
 <4a60a703-d9c2-46a8-83b4-a7ecff7f6ba2@lucifer.local> <aRXyxWeh81-aTHaC@google.com>
 <b4291d0d-b913-4e61-9f9d-fbebd1eb4720@lucifer.local> <20251113153205.6507ecb308e7d09362905da7@linux-foundation.org>
 <9d30836b-9ddb-4432-aa39-85e32c2ea645@kernel.org> <20251114143909.14ecee31b88f179bc2858e30@linux-foundation.org>
In-Reply-To: <20251114143909.14ecee31b88f179bc2858e30@linux-foundation.org>
From: Ujwal Kundur <ujwal.kundur@gmail.com>
Date: Mon, 17 Nov 2025 23:01:22 +0530
X-Gm-Features: AWmQ_blYT_0n6-EoSgb5vkK1TfvHayH6Eh8aX8bnaH1niORp_lD21yGSPt8taXc
Message-ID: <CALkFLLJP7J7fUsUuo2TYseeDd+4JeC8pqJN9PwfhKFS3jd-TFQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/mm: fix division-by-zero in uffd-unit-tests
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Carlos Llamas <cmllamas@google.com>, Peter Xu <peterx@redhat.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Shuah Khan <shuah@kernel.org>, Brendan Jackman <jackmanb@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	"open list:MEMORY MANAGEMENT - USERFAULTFD" <linux-mm@kvack.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

> Commit 4dfd4bba8578 ("selftests/mm/uffd: refactor non-composite global
> vars into struct") moved some of the operations previously implemented
> in uffd_setup_environment() earlier in the main test loop.

> The calculation of nr_pages, which involves a division by page_size, now
> occurs before checking that default_huge_page_size() returns a non-zero
> This leads to a division-by-zero error on systems with !CONFIG_HUGETLB.

> Fix this by relocating the non-zero page_size check before the nr_pages
> calculation, as it was originally implemented.

Thanks for the fix! I never tested with CONFIG_HUGETLB turned off. We
now need tests for tests :)

Reviewed-by: Ujwal Kundur <ujwal.kundur@gmail.com>

