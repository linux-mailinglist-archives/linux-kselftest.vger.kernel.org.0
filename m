Return-Path: <linux-kselftest+bounces-1884-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2576F8123F4
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 01:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5D58281381
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 00:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622DB389;
	Thu, 14 Dec 2023 00:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zugocgvm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C6A109
	for <linux-kselftest@vger.kernel.org>; Wed, 13 Dec 2023 16:36:05 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-42598c2b0b7so62211cf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Dec 2023 16:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702514164; x=1703118964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rh/JIPLuSc5XTJsnIXetpV5afhDLqc5qWgt+ZxYeVCQ=;
        b=zugocgvmf1lxu84yfv4X9DbDntLR0AzZNqnReBvdS2ZE8OIoEw93XOQHmlvBQ0TZUn
         857KK9j5mIUY3RRJspg+5g/UO/nyZR4x0W7oBG53ARP+Th6LvdCQhNm3lVTD14GqjNhW
         VkGFrYefsMSFtfiQjVsFypCX4azcnrMif+HBWhdbf9p6wk8LqkBDBIFPj/qhvI07TsTW
         XwodgsLBUWbZMpE4ZlglFfU0eQApAafb1wh4721RL7hl/pFxr8HTSCO7AqKeo3b4LLXf
         BxIlqususmWl76ubddE7o8dq48aSKph0oKJxDUX9aKBeu3Buy0fqyi97CNfhoQJSG14G
         KSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702514164; x=1703118964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rh/JIPLuSc5XTJsnIXetpV5afhDLqc5qWgt+ZxYeVCQ=;
        b=XOLjerzwV35FTsPjaCsjN8BilIOwDrWrY0xn2BiUZhVbOFJqE7x1jLfhmxaSepbKmm
         5N/S83sG5cubMnN0DsJOSbGajVeMFyzybEWkQ3vUcd/tRF4jjsGkJp6Iq0ZK0gpSYLIE
         33VsWJq3w3miSZVk05Rr9sJLpaTkJMGK7L9HVH2t71EZxJe9XekouMC3kZ6CKI/MYEPj
         3cjR1rggb1DKCrMKG5z6MVMS0j2vqX6hRzOLYrYkNL9upDSMeafx6A4paFd6K5GgY88r
         ATCBX0hpD5ZLqkn3EHFSs6Y8LG9lnValzPCNLW0lN2y+id2k5XWln3teMpSVQH3fa15/
         nQPQ==
X-Gm-Message-State: AOJu0Ywj9zeYnV3gsVlM50d2U+fKvAYeX1/URGKI8X6bsQvqsbPGKpVe
	AWoCKj6n93zh3xRSJUPdg0EirkinqH0R9pkZ6aa2+Q==
X-Google-Smtp-Source: AGHT+IFV9mswBOSTplU3GbpxbWwY83oDLBB8lfMgKwsXIlFx4/MATC30VcWkHbqFp7WCIuN5thSLGmaeWN2qqtvo+f4=
X-Received: by 2002:a05:622a:1a15:b0:425:47fc:e6e6 with SMTP id
 f21-20020a05622a1a1500b0042547fce6e6mr1655213qtb.4.1702514164149; Wed, 13 Dec
 2023 16:36:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212231706.2680890-1-jeffxu@chromium.org> <20231212231706.2680890-12-jeffxu@chromium.org>
 <CAHk-=wgn02cpoFEDQGgS+5BUqA2z-=Ks9+PNd-pEJy8h+NOs5g@mail.gmail.com>
In-Reply-To: <CAHk-=wgn02cpoFEDQGgS+5BUqA2z-=Ks9+PNd-pEJy8h+NOs5g@mail.gmail.com>
From: Jeff Xu <jeffxu@google.com>
Date: Wed, 13 Dec 2023 16:35:26 -0800
Message-ID: <CALmYWFu39nzHvBmRsA326GcmV9u=eM-2aCGOvLK31rrb2R9NEw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 11/11] mseal:add documentation
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, sroettger@google.com, willy@infradead.org, 
	gregkh@linuxfoundation.org, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com, 
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 4:39=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 12 Dec 2023 at 15:17, <jeffxu@chromium.org> wrote:
> > +
> > +**types**: bit mask to specify the sealing types, they are:
>
> I really want a real-life use-case for more than one bit of "don't modify=
".
>
For the real-life use case question, Stephen R=C3=B6ttger and I put
description in the cover letter as well as the open discussion section
(mseal() vs immutable()) of patch 0/11.  Perhaps you are looking for more
details in chrome usage of the API, e.g. code-wise ?

> IOW, when would you *ever* say "seal this area, but MADV_DONTNEED is ok"?
>
The MADV_DONTNEED is OK for file-backed mapping.
As state in man page of madvise: [1]

"subsequent accesses of pages in the range will succeed,  but will
result in either repopulating the memory contents from the up-to-date
contents of the underlying mapped file"

> Or when would you *ever* say "seal this area, but mprotect()" is ok.
>
The fact  that openBSD allows RW=3D>RO transaction, as in its man page [2]

 "  At present, mprotect(2) may reduce permissions on immutable pages
  marked PROT_READ | PROT_WRITE to the less permissive PROT_READ."

suggests application might desire multiple ways to seal the "PROT" bits.

E.g.
Applications that wants a full lockdown of PROT and PKEY might use
SEAL_PROT_PKEY (Chrome case and implemented in this patch)

Application that desires RW=3D>RO transaction, might implement
SEAL_PROT_DOWNGRADEABLE, or specifically allow RW=3D>RO.
(not implemented but can be added in future as extension if  needed.)

> IOW, I want to know why we don't just do the BSD immutable thing, and
> why we need this multi-level sealing thing.
>
The details are discussed in mseal() vs immutable()) of the cover letter
(patch 0/11)

In short, BSD's immutable is designed specific for libc case, and Chrome
case is just different (e.g. the lifetime of those mappings and requirement=
 of
free/discard unused memory).

Single bit vs multi-bits are still up for discussion.
If there are strong opinions on the multiple-bits approach, (and
no objection on applying MM_SEAL_DISCARD_RO_ANON to the .text part
during libc dynamic loading, which has no effect anyway because it is
file backed.), we could combine all three bits into one. A side note is tha=
t we
could not add something such as SEAL_PROT_DOWNGRADEABLE later,
since pkey_mprotect is sealed.

I'm open to one bit approach. If we took that approach,
We might consider the following:

mseal() or
mseal(flags), flags are reserved for future use.

I appreciate a direction on this.

 [1] https://man7.org/linux/man-pages/man2/madvise.2.html
 [2] https://man.openbsd.org/mimmutable.2

-Jeff



>                Linus

