Return-Path: <linux-kselftest+bounces-28824-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4340A5E0F4
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 16:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32E21881E54
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 15:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE04254854;
	Wed, 12 Mar 2025 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvCD+UwC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ED824BBFA;
	Wed, 12 Mar 2025 15:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794525; cv=none; b=PcY5NjnoNr+vmE65I9ZM95bKD5EbIXc7n7ojq3xFa8OxyW6LyAjKYCPWqqca4NkAyr2wdigVnc0J7S2H3bwja6ds8lxYDdTF+cg/qMWX6/p2CF1GG2AKfjeqtLxPJegPFM3sjrU2y5Ogg9PbGX2qCQq7Tu6lT9WwX/gW68YhLbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794525; c=relaxed/simple;
	bh=KCLCWORRVefheQNdDvOR0SPuly0YIxWRFHekJNtrfY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CMyyIaSQDm+7AHODHeCwDQ45mMkJPXzXP6xGqUb2FalE+l5Uu6R0uvnIkciobuuMiyF74xcsLeIp/tLvjxW1re42LDF/Poxh1wPiryLzlUnLBeQxH5A8GxrSScv/QgUowbtx6GzahOw8WyX4r3y7q7RmnxJHNdh26bMcdCm/FiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvCD+UwC; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-523fa0df55dso893921e0c.1;
        Wed, 12 Mar 2025 08:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741794522; x=1742399322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CA0E1+QIouT26J6b1C6kkNeaBYQ2U15SMRJrDpKVBNE=;
        b=UvCD+UwCD4W8U8YZ8N9VbDlxYM6yLfb0qvq80PIPksoFfKQmEowms94ic08dT6dKrB
         nsPU8OyX0X5NGiC2/Quc3zX9LX1V0bp8G+gCj9pq/2lkd5yWCk0m954hcw+s47JNzARX
         6kY68KZ8XXerWK30jKKvHa+FHbJpNWLu2lPiXONSa46qVLbv7O5nbJlwH+8wHOQvpZJ8
         IVg1rTVwTfm2eHpZnPxWtvetDW8ox/GMX3H1lA9a2ZKb1J17iuFneOq8X1q8rluar+58
         OY3NpUyR0ZJRxC6cdwEJEU5SIrCMq/qlT//be3iB27v7L8KNHP92YQEC+a9Q4ii52Xu9
         ZRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741794522; x=1742399322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CA0E1+QIouT26J6b1C6kkNeaBYQ2U15SMRJrDpKVBNE=;
        b=Fd820hhdrQiT0VYEaJCrkdnjifpNljkdDiBFCDlBHfgusoYFFAl+uFTVMhvltH48do
         P4UXiIisDf6gxSE0PfYA2cZ9sMeRuTz0F0J9xDJHJT1qcd+TTTjeO/dzlqNBQ3bB957l
         6B7cyU3mxeJdmEZlCgKXj+mpAVSM7dTV0M03g1exmUXWtlHemuGu4BcAG8L+bOFej8iu
         SmrWyPtI4wemb5Bxb7kg5rlIJnvJAAsVEBP17skaS5thUWjbN6Mlu7FpmBzxqv5g8qhj
         5AsqNcoms1UJe3z7K8E6rCsF3MZtgYfdd5jg8mw6FGkACgFr2v/HJfACOMhBmdaQsoKs
         K/7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBqOhHDBfDItUvpk42ymTWNhX7E9v9ZXqoZTxZn7d8tRGfdygbFihk/y5kUQBViPcuGDIinMsxYvRqafVLrpwo@vger.kernel.org, AJvYcCXJrxuhm1lGUqbjNH8uuoLqE1feALZBZtbpYJ9uJmpWnGwwRD2Wk/UEp8GPLZUZgOlw21rrZTJFjPp+mfugjYk=@vger.kernel.org, AJvYcCXsOYg9Ej/sjt5YULc889i4J0qYybThFVappaDPiNGazH9pnOoNvuADlF44pRgvw+TpBrdF0qLnL8M5XQz+@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+7UrEaDuIuKCwWBjd4odBt4WXRcOcL3rC4xq2kxt7VPrK3GLF
	Wkp8dAv185qi2mZ/3NWXjHKLcbp96uQx046SelUrXe2GO2v71I3Bj44OLKoN6pSkJRCvwCZv0Nh
	m/HpoNre6bTE5OtSbZCCrGZIYvT4=
X-Gm-Gg: ASbGncsGWFmNmDpQ0fmz7QkNZP9/n4reNdLSjSiGA6LEAHso4tJQrr2aXlTNtTA/E/c
	rAaOA85jcwLIPuaQxz/UAfkqRiCx8dG74gbk0h/IRrLkkBS0GjPiVRrL4x8tEzs19QNhYFN0igv
	XqmJZc+x+W0ytQ96uW+kR3EUETAYz5tLtRQxabXu0ZOhX8w2t1ZrLQ6jfHhA==
X-Google-Smtp-Source: AGHT+IGgNahbxSbQna4G9Ni14R4KFZmtH4JnIZG+uLUGeQ1P4zqoNf+g/NrxbLm5rDHx4iRs96GD9OYdN2cqb4BzjTg=
X-Received: by 2002:a05:6122:3c43:b0:518:8753:34b0 with SMTP id
 71dfb90a1353d-52437de5a95mr97996e0c.4.1741794522420; Wed, 12 Mar 2025
 08:48:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312002117.2556240-1-jeffxu@google.com> <20250312002117.2556240-3-jeffxu@google.com>
 <c867bff9-2293-4890-af46-8a797cf512c2@lucifer.local> <64B6294F-B059-4744-8548-89D7B519BE72@kernel.org>
In-Reply-To: <64B6294F-B059-4744-8548-89D7B519BE72@kernel.org>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Wed, 12 Mar 2025 15:48:31 +0000
X-Gm-Features: AQ5f1JrWH_NUnvOlBfCLeU2iGn4bsAsglh4RBB13Bl-yre5HPY3wUm8KqBRNwZk
Message-ID: <CAKbZUD0M-kfxqD+AxjYK0LjnZhsxyJbGwhL5CGKzfOsFQpnKtg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/2] mseal: allow noop mprotect
To: Kees Cook <kees@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, jeffxu@chromium.org, 
	akpm@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	broonie@kernel.org, skhan@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, keescook@chromium.org, 
	rdunlap@infradead.org, jannh@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 3:28=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
>
>
> On March 12, 2025 6:49:39 AM PDT, Lorenzo Stoakes <lorenzo.stoakes@oracle=
.com> wrote:
> >On Wed, Mar 12, 2025 at 12:21:17AM +0000, jeffxu@chromium.org wrote:
> >> From: Jeff Xu <jeffxu@chromium.org>
> >>
> >> Initially, when mseal was introduced in 6.10, semantically, when a VMA
> >> within the specified address range is sealed, the mprotect will be rej=
ected,
> >> leaving all of VMA unmodified. However, adding an extra loop to check =
the mseal
> >> flag for every VMA slows things down a bit, therefore in 6.12, this is=
sue was
> >> solved by removing can_modify_mm and checking each VMA=E2=80=99s mseal=
 flag directly
> >> without an extra loop [1]. This is a semantic change, i.e. partial upd=
ate is
> >> allowed, VMAs can be updated until a sealed VMA is found.
> >>
> >> The new semantic also means, we could allow mprotect on a sealed VMA i=
f the new
> >> attribute of VMA remains the same as the old one. Relaxing this avoids=
 unnecessary
> >> impacts for applications that want to seal a particular mapping. Doing=
 this also
> >> has no security impact.
> >>
> >> [1] https://lore.kernel.org/all/20240817-mseal-depessimize-v3-0-d8d2e0=
37df30@gmail.com/
> >>
> >> Fixes: 4a2dd02b0916 ("mm/mprotect: replace can_modify_mm with can_modi=
fy_vma")
> >> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> >> ---
> >>  mm/mprotect.c | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/mm/mprotect.c b/mm/mprotect.c
> >> index 516b1d847e2c..a24d23967aa5 100644
> >> --- a/mm/mprotect.c
> >> +++ b/mm/mprotect.c
> >> @@ -613,14 +613,14 @@ mprotect_fixup(struct vma_iterator *vmi, struct =
mmu_gather *tlb,
> >>      unsigned long charged =3D 0;
> >>      int error;
> >>
> >> -    if (!can_modify_vma(vma))
> >> -            return -EPERM;
> >> -
> >>      if (newflags =3D=3D oldflags) {
> >>              *pprev =3D vma;
> >>              return 0;
> >>      }
> >>
> >> +    if (!can_modify_vma(vma))
> >> +            return -EPERM;
> >> +
> >>      /*
> >>       * Do PROT_NONE PFN permission checks here when we can still
> >>       * bail out without undoing a lot of state. This is a rather
> >> --
> >> 2.49.0.rc0.332.g42c0ae87b1-goog
> >>
> >
> >Hm I'm not so sure about this, to me a seal means 'don't touch', even if
> >the touch would be a no-op. It's simpler to be totally consistent on thi=
s
> >and makes the code easier everywhere.
> >
> >Because if we start saying 'apply mseal rules, except if we can determin=
e
> >this to be a no-op' then that implies we might have some inconsistency i=
n
> >other operations that do not do that, and sometimes a 'no-op' might be
> >ill-defined etc.
>
> Does mseal mean "you cannot call mprotect on this VMA" or does it mean "y=
ou cannot change this VMA". I've always considered it the latter since the =
entry point to making VMA changes doesn't matter (mmap, mprotect, etc) it's=
 the VMA that can't change. Even the internal function name is "can_modify"=
, and if the flags aren't changing then it's not a modification.
>
> I think it's more ergonomic to check for _changes_.

I think this is a slippery slope because some changes are not trivial
to deal with e.g
int fd =3D open("somefile")
void *ptr =3D mmap(0, 4096, PROT_READ, MAP_SHARED, fd, 0);
mmap(ptr, 4096, PROT_READ, MAP_FIXED | MAP_SHARED, fd, 0);


soooo on one hand, I don't really have grounds to say this patch is
incorrect. On the other hand, I'd like to see either a particular
problem or a consistent criteria we can apply to all VMA-related
situations.

--=20
Pedro

