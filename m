Return-Path: <linux-kselftest+bounces-37999-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 799D9B122BD
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 19:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40B223AE983
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 17:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8A62EF66B;
	Fri, 25 Jul 2025 17:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E9teVUjs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911E37080D
	for <linux-kselftest@vger.kernel.org>; Fri, 25 Jul 2025 17:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753463550; cv=none; b=AFJiAXenC2LaOZTLBOgd1gYImUq0qJaMLV7mG18RI8pfv43sBuIBUJn2Ibm7ERh+q2v5alTvwXiMNXxAWa5MxQsr13/VPGVALPLPxzJyI/Uyw80GKlwtkz3Boq50ZyyxxonqItyym3hAUgJ+SO+cFDs4oI1Mq2M7mi7lIpHdN70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753463550; c=relaxed/simple;
	bh=LR/1fr+927w5gHz+7V9YvJuD7wXmf2oW8T6mJhnxcas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/T8tDL3jDd0NKppd/bVznpF/iSAw8wHSHtstDcm3R6muzHdHRlznFfLuErqCAcmdxc6tmpObA+TGu33a7RnLd1EXem9juZsPfyZwTd0ohaurCtY5+sxR3VCT/ACV8XdPc4JVS+MoVFRSg+Zj/IjH7fC9DFsHu9AeTlvPpWd4pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E9teVUjs; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4561b43de62so4745e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Jul 2025 10:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753463547; x=1754068347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LR/1fr+927w5gHz+7V9YvJuD7wXmf2oW8T6mJhnxcas=;
        b=E9teVUjspWShKsMgc1oLy+m9iwkIFL+C/fjG0YE/EIYK/XzXXxa23KCQz3naomeZi8
         Y8HxbHREoCTKbCdWMqpi2V+pL5yhNCwb3XjQOpjt6PtPOvZuTlPg7RcJAUwnhXriZhS/
         N99P2J2YKRZFR7pKAsOCoTwBmdLM5Jqj8qGv1XHcn5KjgQJYMYIbDlgWyHFUkRoYQF4y
         1j+lHWwY0JnAJesKI32cLe5FJ6iYckQpFND98nOQLNJL/+FOLyytMGPuyCrCj08wDxmy
         idRL64mD3bs2vITGHRXBzT4/FnvvsbQ94mIFPvde9MQ6j7mvhKRS8sEYdovkMvVIDRUV
         SbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753463547; x=1754068347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LR/1fr+927w5gHz+7V9YvJuD7wXmf2oW8T6mJhnxcas=;
        b=QyoRmmQWmLtA3ms3NQiKQSKYYOw10K0JFN+ZKAeM7c7U74V6d0YZtAw3ZGiJlP100l
         aQJzS02SwrPiOGh/cgalrZrQfnp8+9hg3t7/IoPkyDtpG+Iho554hTEXmXrshpOANyxD
         3G+nM0Yu7Yq400KBwpXyTuUWqZqSuM3HPIDYwOzdsPXUqknzbb7dU5+zUNZNbFgOfLun
         DfEUI1977AaJOVNOz44Qlkty/W0RoUJUQaPUXLSVzdYy4pXSdmlGpDurRtQwP/DdilxE
         UHLga+iTRdiXMQ0SVRCv4gEFv1iFoQTSOLRykK6i4Tv5wLUfq9up4unYIH54LrmHfoOr
         9NLg==
X-Forwarded-Encrypted: i=1; AJvYcCVdrDpbGLsDKGaYEKwEMzvG2LumpCKkWm0RHOyFwmE+pSSIUES8C6esdDeCQQbkqI8Zj/9Dev8Q1fQERT6owP4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo7spKg7dHivzzVOWiuseu8/2VvxXgTtFuOe4eyB4WZYdeNfnZ
	WBcRNb4TdmTw8qNRq/RExlj7WYIh+DQ70tdrHqDvahi9RE0LnTfiQpyhq9wEVsZfSwhl5EnPxYR
	blpE0b5A2zU47aXf0xO09AQrl473Xic73Iycto+FK
X-Gm-Gg: ASbGncvR5kcupt5uuAVXDDHD5m9taPuTsU9J/5uUTigDgRsD0AY6DRBGmhWgADx3pQC
	w4DuBXh2R+w754p9lL9z50qHZLq2Mb7IVW4r4LMujPf/jP9Z8vWz9uX5IZ6sYEO6AOvNZpM/DeP
	4fe7SEm3P3F/m3vdYBLfHW2D1k6UzZClw7vVe0UpqzGQwTL0/kDR3h/FVTDOOGNM8a5yY9EStDg
	ZwSyVS8vBYY5L3w4VMp6lmCF9UKhXVy4wufcs3uCB2e+g==
X-Google-Smtp-Source: AGHT+IFhxhJzavWiG8TnAC5bSyEUCITgigk6eSOkbePzjanT6OdYE8Du+O+akeu9UoPZ+9VboPkoI9eK3HhR7G1bjjE=
X-Received: by 2002:a05:600c:1c86:b0:453:65f4:f4c8 with SMTP id
 5b1f17b1804b1-45874e2b93cmr1367085e9.3.1753463546532; Fri, 25 Jul 2025
 10:12:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752232673.git.lorenzo.stoakes@oracle.com> <8f41e72b0543953d277e96d5e67a52f287cdbac3.1752232673.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <8f41e72b0543953d277e96d5e67a52f287cdbac3.1752232673.git.lorenzo.stoakes@oracle.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 25 Jul 2025 19:11:49 +0200
X-Gm-Features: Ac12FXz5v7hwHYZVZo-PcQftTdDT8-58CkHFg3QHIWJWk_i7JJUmY1B0j5KtsNs
Message-ID: <CAG48ez0KjHHAWsJo76GuuYYaFCH=3n7axN2ryxy7-Vabp5JA-Q@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] mm/mremap: permit mremap() move of multiple VMAs
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 1:38=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> Note that any failures encountered will result in a partial move. Since a=
n
> mremap() can fail at any time, this might result in only some of the VMAs
> being moved.
>
> Note that failures are very rare and typically require an out of a memory
> condition or a mapping limit condition to be hit, assuming the VMAs being
> moved are valid.

Hrm. So if userspace tries to move a series of VMAs with mremap(), and
the operation fails, and userspace assumes the old syscall semantics,
userspace could assume that its memory is still at the old address,
when that's actually not true; and if userspace tries to access it
there, userspace UAF happens?

If we were explicitly killing the userspace process on this error
path, that'd be fine; but since we're just returning an error, we're
kind of making userspace believe that the move hasn't happened? (You
might notice that I'm generally in favor of killing userspace
processes when userspace does sufficiently weird things.)

I guess it's not going to happen particularly often since mremap()
with MREMAP_FIXED is a weirdly specific operation in the first place;
normal users of mremap() (like libc's realloc()) wouldn't have a
reason to use it...

