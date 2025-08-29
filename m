Return-Path: <linux-kselftest+bounces-40255-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D13B3B57C
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 10:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5666B3AB9F0
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 08:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C38286402;
	Fri, 29 Aug 2025 08:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bIS0DTHE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EFD5CDF1
	for <linux-kselftest@vger.kernel.org>; Fri, 29 Aug 2025 08:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454869; cv=none; b=VR0Rlp/CSdeGSCWvDbIZ9/ngI9TfwxzkvVQgP639qvj9uNSaN+dAviYcen5EPQD/5xMNmoBU4zrXADkVQBxWkT9bXJoNo7cWKGdEMZXC261BjcbyPyJhKP97tbCaaET/lhtBER1r1eXHqX1lQpTtSFIIRgtXDsR9esTJPHG0ofo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454869; c=relaxed/simple;
	bh=g7hvdpZ9t6wXWWr1/ENXJqfBe4wdItmI1tbNY4EpySg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r0mdeTSnk5KVpmBcHkbL3qPSv6HceJNP6r5lO+lbZ8zgpieuNhFyo/MGZzMKwcNOhwqLXasTIxFh7yLSyEBWqL2sRinkPycp8j/o0Gcm6uZuLTsFiuPB2ygfqVEFBuqTQttDGRUjSF1+E1hRgtChCZy0Ufi/Ex3p1xrUnLdJjOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bIS0DTHE; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45b74ec7cd0so11458125e9.2
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Aug 2025 01:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756454866; x=1757059666; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mfOnoSdMFEY12A5kAdJIINWz+0z/4T/piULOnnacnTU=;
        b=bIS0DTHEF9fR7ZrdLM4+zYfJgQxpG2LW9dbWJn+SgW6zaJXuvVqjQJB5sPpD0J8qoH
         i3EbdNn8HloWmLhIK6FAePsd312jwoFC1ckrPWwiAHpSa1I7QB8SMwzjzbtizirTgfI8
         Zx583Ib2lwS00XZICwY9neEeP7kGpaUDY7gkjzPoKYYHzRtcTwe7t/GvNXcPvoEgfHyk
         0rAK+YKtXEXrxiGN2yaz87TI1cuq29OT0EeCfvv5Xp+ycNzc+NBjqoWdRC9mUc3DLury
         w1W5Y3YdtpdoqTrQuWFSerZKjb14iklSzoNVNp3KJmH5MVWCWIsTygIHXBJlUXXZvl/T
         nQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756454866; x=1757059666;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mfOnoSdMFEY12A5kAdJIINWz+0z/4T/piULOnnacnTU=;
        b=pvUATJRtJfqO1MHYwWphWDFog3oiJw9hKn5xMOE8x//ciAXeeRt6D/Tey0Rbm5MnH5
         ClD4nAX1Sz7mnH/jTYBhxMoSUEjIY3LAYP3YgUYn9wkpyySWLFgTz2SgmSgqaj1KwwrY
         j9vOqGiwTjID0U3ufFkJ2UKHJYRYsRbTz6FS6l0RTeoX6FrGSnBhzRzuC49UANP/2Acg
         hNKJFV+5J+ZJ8OAtXRCHI2pgKZD2IEUBjzi7C0l6bpGZgVheqBoQpVOVIrrHYLMgMgob
         4WL3OFcsjypammm9XgfrzLjxm7IED8xup9S3yttjduEQxEPCzNp9eOWioTJAuto3wMOs
         l6EA==
X-Forwarded-Encrypted: i=1; AJvYcCX1n2I2mygiPRrIRJtRAD5hi7HcKiKRYvEvsSDp3TTtEqwbuQzZE56IMNZa6QGwf2xYhES90Syxr3JZ8xWaH0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNM/gD+oy/5rV/EsQAFO6aWk+cqim9zoi94wSwrAwJ8+nYplrZ
	NdoI89B43Sz4icTgnue2QzwXxKgQNK9baIEvI+MJeWklIzxCHN8/DGnVpvtmD1A5EmBQEXRIn6y
	ulZ9uqiBEUmp3NA==
X-Google-Smtp-Source: AGHT+IFJ+ze82M8nDeFw85CqWHL6EDCvm/pvyvGMy6Ixf0Ev+KdhEZ+X2YsmGSD4LRNTVXGN7ctJ/yclVGX+Ag==
X-Received: from wrs1.prod.google.com ([2002:a05:6000:641:b0:3cb:ea8b:ea9f])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2c01:b0:3b3:9c75:acc6 with SMTP id ffacd0b85a97d-3c5de34badbmr20447829f8f.59.1756454866646;
 Fri, 29 Aug 2025 01:07:46 -0700 (PDT)
Date: Fri, 29 Aug 2025 08:07:46 +0000
In-Reply-To: <20250828155412.2b1b2095125428af24896af5@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250817065211.855-1-ujwal.kundur@gmail.com> <DCE2EJ3KWX3K.1Y198FHBV8UG7@google.com>
 <kd6uteyd4vzlnbdwzjydwd7hoqyxewc5fx24z5sq7svmtoa3oo@n57xyeu3vtyy> <20250828155412.2b1b2095125428af24896af5@linux-foundation.org>
X-Mailer: aerc 0.20.1
Message-ID: <DCERAA0PTPE2.1Y0KLQS6IO5O9@google.com>
Subject: Re: [PATCH v7 1/1] selftests/mm/uffd: Refactor non-composite global
 vars into struct
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Ujwal Kundur <ujwal.kundur@gmail.com>, <peterx@redhat.com>, <david@redhat.com>, 
	<lorenzo.stoakes@oracle.com>, <vbabka@suse.cz>, <rppt@kernel.org>, 
	<surenb@google.com>, <mhocko@suse.com>, <shuah@kernel.org>, 
	<linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

On Thu Aug 28, 2025 at 10:54 PM UTC, Andrew Morton wrote:
> On Thu, 28 Aug 2025 14:49:37 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:
>
>> * Brendan Jackman <jackmanb@google.com> [250828 08:37]:
>> > On Sun Aug 17, 2025 at 6:52 AM UTC, Ujwal Kundur wrote:
>> > > -static void noop_alias_mapping(__u64 __unused *start, size_t __unused len,
>> > > -			       unsigned long __unused offset)
>> > > +static void noop_alias_mapping(uffd_global_test_opts_t *gopts, __u64 __unused *start,
>> > > +			       size_t __unused len, unsigned long __unused offset)
>> > 
>> > After a rebase this is now falling afoul of the -Wunused-parameter added
>> > here:
>> > 
>> > https://lore.kernel.org/all/20250731160132.1795351-5-usama.anjum@collabora.com/T/#m0449dc0d6a5ac3b1f71f7182c13b6829e1b444cf
>> > 
>> > I really don't think we want that flag, I'll comment on that thread, but
>> > just as an FYI here too.
>> 
>> I was under the impression that it was decided to drop that flag,
>> otherwise I would have also spoken up about it.
>
> err, yes, I thought I'd dropped that.
>
> No -Wunused-parameter, please.
>
> The v2 series needs work and a v3 series is expected so I'll drop the
> v2 series "selftests/mm: Add compiler flags and fix found warnings".

Ah yep I said I'd reply to the other thread but upon re-reading it I
realised you were already against -Wunused-parameter, thanks for
dropping it.

