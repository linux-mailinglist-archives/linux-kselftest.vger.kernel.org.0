Return-Path: <linux-kselftest+bounces-20502-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7B19AD40D
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 20:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1714C2851F4
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 18:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88991D0957;
	Wed, 23 Oct 2024 18:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a7btn8rN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199FE1CF7D2
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Oct 2024 18:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729708440; cv=none; b=btTP4gYWNOeccYbLWGsQ0OHXeXOH+QshS3WYiAiG1Z2+is0L+pSvdTPDfWVoRmvQyvgm9MeqNfpGZS9+xGrRQMyYSQeUJv2oW5ojm+pU2jBIRkTwXJfwHMhaclRAyjgn/7d7FgCXmk1J2WfRueesXGjEyyToHyRGauGG6p/B4Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729708440; c=relaxed/simple;
	bh=46H7PDaCQ2mc9wWUN9y7o0ZuIliZ1TptrpK1yyyphmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7hR7vB+T/kQ3dDYLI09molSU7ghjoroVUQgwmPKjoRAfI//fxdk0xpkxUyd1lf++2qVvkx++VVwidjf9wdIt4pmjKsygn29vzlbOVOxrzHvk/DdWrfrgKZJ0ob5y6yIF4lcbqjZx8oxsXrGwJe9z9NsqMGhGiBrz1m83VmEi54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=a7btn8rN; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5eb84216a1cso1100eaf.3
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Oct 2024 11:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729708438; x=1730313238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVm15+JO2o8mM+w0yinyleN/ZVNf1YYgHDbnm3S0yro=;
        b=a7btn8rNnH8nXRpDaDj2v3n/XNA91arJe1m8yIoWj6RL+eN+viwdqn3YgWCeG8nQu9
         s4u8fzXpZNhf8cFEEYlNqJMa6Jqm3YWaUSWmFQ06gYV1Cen1RIeK79vybBbO3I/DqxPs
         Vv2vyk408aPMYc5I2ubchlAnrtS1Y2DB1NQ7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729708438; x=1730313238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVm15+JO2o8mM+w0yinyleN/ZVNf1YYgHDbnm3S0yro=;
        b=pyWi+GuBrld9+C1dk0P+ugmUmDAW/xIZicOgEggvGL1b7nQcznlomYqiniOG7acNEC
         E8vuU7s7HGrPknHEe7VWmhwu5HCOD30mElG0CRdsUtwuvL1iZg6DDlyrveZpxlNH8c3N
         eM+oWdBdwEJiUIndf42AhSAxYvZL390SgV4goFxG2VyWgg5JzraeiHUSV52PcVHO6kiW
         GilYCcBTb9rV8DKSO1Ikk86tmNYzNpTSt+/HdHVtGB1tIYPlAs7jH5u2QEuwMwZv23PD
         7hn7AlKcDT2ooc1pFxQwmqP4qd1rakW8DCKF4bSOBbgxF3X9A4OdROj44MemdgNhhlHp
         DwMw==
X-Forwarded-Encrypted: i=1; AJvYcCXIbmj9QlgjtyNcHv17ygaBZAD1XSVQJaq/NJrFHm0MMOfX1duMP1Ff6RzTkiog4Dw4wB43lQ/BgMUypAH55SQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzau4zOyAnoPwB6ChMAjQen7eGmQBoj5/Uig3IpbEuDTlNGPOsl
	W32ufv0BYe57O0bPqrxP2fu/hi2qor4vdKcXTfDJnca7CtSfgKXdU6reWyOfiF9OefUCPOJ7kxn
	+Et2mbphdrw0wb3b93MCwZMvWSPlaka4bz5Jr
X-Google-Smtp-Source: AGHT+IHLGbkE5Oo4IYlY3tWegFIJ6lm7Wf/IIJ6qevixwoPKrt15CKBR9bfEkXM+gXkwnZyxMgOtkG3lSgqMgDT/5dQ=
X-Received: by 2002:a05:6870:5590:b0:27b:b2e0:6af with SMTP id
 586e51a60fabf-28ccb40e51emr1031801fac.2.1729708438196; Wed, 23 Oct 2024
 11:33:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017005105.3047458-1-jeffxu@chromium.org> <20241017005105.3047458-2-jeffxu@chromium.org>
 <5svaztlptf4gs4sp6zyzycwjm2fnpd2xw3oirsls67sq7gq7wv@pwcktbixrzdo>
 <CABi2SkXwOkoFcUUx=aALWVqurKhns+JKZqm2EyRTbHtROK8SKg@mail.gmail.com>
 <r5ljdglhtbapgqddtr6gxz5lszvq2yek2rd6bnllxk5i6difzv@imuu3pxh5fcc>
 <CABi2SkXArA+yfodoOxDbTTOpWCbU5Ce1p1HadSo0=CL23K4-dQ@mail.gmail.com> <8f68ad82-2f60-49f8-b150-0cf183c9cc71@suse.cz>
In-Reply-To: <8f68ad82-2f60-49f8-b150-0cf183c9cc71@suse.cz>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 23 Oct 2024 11:33:46 -0700
Message-ID: <CABi2SkW6onjPipzhwqQ7iiOFJx3vtwnB2wFizqe01j1Wf3kqYQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mseal: Two fixes for madvise(MADV_DONTNEED) when sealed
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Pedro Falcato <pedro.falcato@gmail.com>, akpm@linux-foundation.org, 
	keescook@chromium.org, torvalds@linux-foundation.org, 
	usama.anjum@collabora.com, corbet@lwn.net, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, jeffxu@google.com, jorgelo@chromium.org, 
	groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, jannh@google.com, 
	sroettger@google.com, linux-hardening@vger.kernel.org, willy@infradead.org, 
	gregkh@linuxfoundation.org, deraadt@openbsd.org, surenb@google.com, 
	merimus@google.com, rdunlap@infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vlastimil

On Tue, Oct 22, 2024 at 8:55=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 10/17/24 22:57, Jeff Xu wrote:
> > On Thu, Oct 17, 2024 at 1:49=E2=80=AFPM Pedro Falcato <pedro.falcato@gm=
ail.com> wrote:
> >> >
> >> > > > For file-backed, private, read-only memory mappings, we previous=
ly did
> >> > > > not block the madvise(MADV_DONTNEED). This was based on
> >> > > > the assumption that the memory's content, being file-backed, cou=
ld be
> >> > > > retrieved from the file if accessed again. However, this assumpt=
ion
> >> > > > failed to consider scenarios where a mapping is initially create=
d as
> >> > > > read-write, modified, and subsequently changed to read-only. The=
 newly
> >> > > > introduced VM_WASWRITE flag addresses this oversight.
> >> > >
> >> > > We *do not* need this. It's sufficient to just block discard opera=
tions on read-only
> >> > > private mappings.
> >> > I think you meant blocking madvise(MADV_DONTNEED) on all read-only
> >> > private file-backed mappings.
> >> >
> >> > I considered that option, but there is a use case for madvise on tho=
se
> >> > mappings that never get modified.
> >> >
> >> > Apps can use that to free up RAM. e.g. Considering read-only .text
> >> > section, which never gets modified, madvise( MADV_DONTNEED) can free
> >> > up RAM when memory is in-stress, memory will be reclaimed from a
> >> > backed-file on next read access. Therefore we can't just block all
> >> > read-only private file-backed mapping, only those that really need t=
o,
> >> > such as mapping changed from rw=3D>r (what you described)
> >>
> >> Does anyone actually do this? If so, why? WHYYYY?
> >>
> > This is a legit use case, I can't argue that it isn't.
>
> Could the same effect be simply achieved with MADV_COLD/MADV_PAGEOUT? Tha=
t
> should be able to reclaim the pages as well if they are indeed not used, =
but
> it's non-destructive and you don't want to allow destructive madvise anyw=
ay
> (i.e. no throwing away data that would be replaced by zeroes or original
> file content on the next touch) so it seems overall a better fit for seal=
ed
> areas?
>
Thanks for the suggestion. This opens a new way to solve this, I need
to do some research and testing  to verify the solutions work for us.
I will respond after I'm done with those.

Best regards,
-Jeff

