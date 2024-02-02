Return-Path: <linux-kselftest+bounces-4034-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2328479B2
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 20:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BCBA1F2628D
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 19:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6A315E5D6;
	Fri,  2 Feb 2024 19:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b="ZdHsQtxZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cvs.openbsd.org (cvs.openbsd.org [199.185.137.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E10B15E5C6;
	Fri,  2 Feb 2024 19:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.185.137.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706902344; cv=none; b=Wm8eobPS9b80WQwr0yV3Uk8zQ7f8ApwUU5CCgImeS2vkM26xbyF64K1c5dK7aDLqtFFif1wabm9bUfezWs28N/+NaTLKxmzbnlG9kD8kyEU9SDWnjph0Eh9BF7Mj9MD/koFwOvOTz3SIfWw8d+h9P0LbzQqekETDCncrUfh8Iyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706902344; c=relaxed/simple;
	bh=ekn8zZyh2SJ/K4/UbZI/dsGbE82SD/gtWKgnDxS+Csg=;
	h=From:To:Subject:In-reply-to:References:MIME-Version:Content-Type:
	 Date:Message-ID; b=Uh3Rbv9YxbeoDIEGmMTUW0Di0S7H+iDZwhdGzPD6Q2jK8CuvmU2iGipB9kYS4UJfL20P6uT/WiIfeK/p6RsoKYrjfTnF2WAYctWMOX82GYbjc1WalzgLWfKL+oK1vykE25Aa2prMhYctxY+uNYYwn31rjBoIA+9Y1XHL7diWJFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org; spf=pass smtp.mailfrom=openbsd.org; dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b=ZdHsQtxZ; arc=none smtp.client-ip=199.185.137.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openbsd.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=selector1; bh=ekn8zZyh2S
	J/K4/UbZI/dsGbE82SD/gtWKgnDxS+Csg=; h=date:references:in-reply-to:
	subject:to:from; d=openbsd.org; b=ZdHsQtxZd7zV7xxA41DRY2ESVMUbSAnvR1xc
	AlK7ecM9Ucc9edCmBIKnSpBApeWQwf3odD6e7TBICtNVqhp2Zva5TXONs0ssS378pCBvkM
	4lyOWSpIn7akT2yQnl1fhqedjWlWt2K7DRAapspanK04WySI/fAE7WB4yp1ASTvAcVJv76
	dOREtdXKhniP8HAbBjy9NG4YE4EhcjBPAESBMP3Yu43xtw8YvyKPC3muuRLI2uNjjRC1mB
	4cz9yJYYcle46GXKmS9Z4NPB4cVl9QFhxzXe68UB5hOodzmyCJfxFaqihHUt55frwCB07R
	gkgopKTD0GkEtx/ZgDrPzaJwnw==
Received: from cvs.openbsd.org (localhost [127.0.0.1])
	by cvs.openbsd.org (OpenSMTPD) with ESMTP id 78374f08;
	Fri, 2 Feb 2024 12:32:16 -0700 (MST)
From: "Theo de Raadt" <deraadt@openbsd.org>
To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
    Jeff Xu <jeffxu@chromium.org>, Jeff Xu <jeffxu@google.com>,
    Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org,
    keescook@chromium.org, jannh@google.com, sroettger@google.com,
    willy@infradead.org, gregkh@linuxfoundation.org,
    torvalds@linux-foundation.org, usama.anjum@collabora.com,
    rdunlap@infradead.org, jorgelo@chromium.org, groeck@chromium.org,
    linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
    linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
    linux-hardening@vger.kernel.org
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
                  Jeff Xu <jeffxu@chromium.org>,
                  Jeff Xu <jeffxu@google.com>,
                  Jonathan Corbet <corbet@lwn.net>,
                  akpm@linux-foundation.org, keescook@chromium.org,
                  jannh@google.com, sroettger@google.com,
                  willy@infradead.org, gregkh@linuxfoundation.org,
                  torvalds@linux-foundation.org,
                  usama.anjum@collabora.com, rdunlap@infradead.org,
                  jorgelo@chromium.org, groeck@chromium.org,
                  linux-kernel@vger.kernel.org,
                  linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
                  pedro.falcato@gmail.com, dave.hansen@intel.com,
                  linux-hardening@vger.kernel.org
Subject: Re: [PATCH v8 0/4] Introduce mseal
In-reply-to: <20240202192137.6lupguvhtdt72rbr@revolver>
References: <20240131175027.3287009-1-jeffxu@chromium.org> <20240131193411.opisg5yoyxkwoyil@revolver> <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com> <20240201204512.ht3e33yj77kkxi4q@revolver> <CALmYWFupdK_wc6jaamjbrZf-PzHwJ_4=b69yCtAik_7uu3hZug@mail.gmail.com> <20240202151345.kj4nhb5uog4aknsp@revolver> <CABi2SkUSWLHM5KD=eK9bJrt3bBsEaB3gEpvJgr0LSTAE2G00Tg@mail.gmail.com> <20240202192137.6lupguvhtdt72rbr@revolver>
Comments: In-reply-to "Liam R. Howlett" <Liam.Howlett@Oracle.com>
   message dated "Fri, 02 Feb 2024 14:21:37 -0500."
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <98845.1706902336.1@cvs.openbsd.org>
Date: Fri, 02 Feb 2024 12:32:16 -0700
Message-ID: <85714.1706902336@cvs.openbsd.org>

> What I'm more concerned about is what happens if you call mseal() on a
> range and it can mseal a portion.  Like, what happens to the first vma
> in your test_seal_unmapped_middle case?  I see it returns an error, but
> is the first VMA mseal()'ed? (no it's not, but test that)

That is correct, Liam.

Unix system calls must be atomic.

They either return an error, and that is a promise they made no changes.

Or they do the work required, and then return success.

In OpenBSD, all mimmutable() aspects were carefully studied to gaurantee
this behaviour.

I am not an expert in the Linux kernel to make the assessment; someone
who is qualified must make that assessment.  Fuzzing with tests is a good
way to judge it simpler.

