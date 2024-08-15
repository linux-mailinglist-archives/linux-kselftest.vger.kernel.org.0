Return-Path: <linux-kselftest+bounces-15449-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85375953B62
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 22:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 235692867BC
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 20:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD821465A3;
	Thu, 15 Aug 2024 20:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="efbNr9hq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A477DA73
	for <linux-kselftest@vger.kernel.org>; Thu, 15 Aug 2024 20:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723753397; cv=none; b=AgE2UjCSFlHSE+jhalAf6HhHtT7Kgw0I4TV5E/8UnVONwXtoZ3Xo5qXoqYC9D6ogylLpH5vrAnhZ6mXZ7r1Y0tyZp3KmtCg9L6h3QLOxmzH2eHvcA4e9V+yXndQBWe6DmUHZEFmRa7e6SG1GRnHe2MFsxbs38HbwR3/oPLk/BL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723753397; c=relaxed/simple;
	bh=QzSG5BZ0eoq0V5ijHIA+jOeQZefE+Y4eiNTu0Y8gq/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=UutB6UBoJ+bPxuXWJTilK+p8s9/jcfCAP/6DmjSbcVxjIld2h640l3z7yPz6C/jQVZuF9T/OxZwX3icvjLfKOrdekwELDkozWrNOIHWubRtC909hzEQTWvu/N1VxRX2z+XOoNAzZ7sBpSiiMNYplqtITY20EgMT+PSZLQHcZf2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=efbNr9hq; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5d5f24d9df8so730676eaf.2
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Aug 2024 13:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723753395; x=1724358195; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovAsWBVT3KfnNuExqSaLYNn0wD3OHoIaOCw5GGvv0GI=;
        b=efbNr9hq9mIax4X/ViiXuWpEbK8WqYA1XnP67H5ixLfssI3GR6a7ZSxtLuITGIjqBr
         wwKWy9KAUWJ/t0MFmT7MNce2BIfXnNbhOoNZDu2O9n2LydBcHqedk8aArce+bAJbHjKC
         5pFH6NuhGTuzCaCec+VBdtr+LXwUkLfs+aevA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723753395; x=1724358195;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovAsWBVT3KfnNuExqSaLYNn0wD3OHoIaOCw5GGvv0GI=;
        b=bVMMVh1XN1Th4kDcXDzfZCVZ+rmsHIhiKK9dvqb3yWgaDkvwoIRzAJkHtE+74hqPw8
         E+STVol1fP1PKbZJ61U4rxWBLRWvAclGw1YhomSH31CedBkIvcLuoIEQkrIf2HyQBTgD
         GVbTe/FWvIbxzvylKZOj0PU6Z48OAFKVl1urvrPL211gpgX2zdOSjXU/U3Xkf5a+4N+3
         n5p7U94BXAXEGXlOZz6k34mPgwioP92Q3zcgi44G2q1w8+qsmWLtnGkP9UkLxlbUSAkp
         /st1+QeBJE3m5kVdmr8ObSc0VG+qSU/oqsR2qIcsyVrEXq3/z12b1DdyWNZbnoMf9pJN
         Faqw==
X-Forwarded-Encrypted: i=1; AJvYcCVjXNjb6qSQ/I6kHL+670Yx5J9HGEDuzu2/q/0rmS1qTxtC2WrK+laCOALus/f5n50nkdn4pJNISyeR02X7z69JDtDhfXObXFSe7ztYTG/A
X-Gm-Message-State: AOJu0YwOZzRIgkLUQLyToDEBkpvyI12FgyQtUnT8RRvvHPEpUA1nf4U9
	2FBQUbCWQPFi18vmMiMy/SUxWxVOpjuyOiVm7czzyvqhCAXB6pvDO/yjX9SwVzwIMcPFjxnOnIn
	JfFxbF4RQ+IqrD+ymet248Jzi6hEmAEghRYge
X-Google-Smtp-Source: AGHT+IEwMnrfmTUUhtgaFEht4W0jLhciN2H+QwwDuDuuqk78N4SEzPJpVf7zDnoxKn+kGqiZORe/HsXaaWWtiCnmhvw=
X-Received: by 2002:a05:6870:4694:b0:25d:e3d:b441 with SMTP id
 586e51a60fabf-2701c522a1bmr776847fac.40.1723753394618; Thu, 15 Aug 2024
 13:23:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814071424.2655666-1-jeffxu@chromium.org> <slrsrycj73xrph5o2poicpt4cogpqw36bbwi5iqykvyce4pve3@suldmmv2mmo5>
 <CABi2SkV2LcrkYOGzkGm80eYw-mhPNN=Q=P3aKGm0j8_gAwXjog@mail.gmail.com>
 <mlwues5aus4uie52zi2yi6nwlaopm2zpe4qtrnki7254qlggwl@cqd42ekhrxez>
 <CABi2SkVrk-MyMGVDzRZi++7tzCu6k92Vz4hyaVHY2nbYDxd97g@mail.gmail.com>
 <szuouie2gbpaj6gynixelasgeo5fxtn5fd3vbmebzve2x3auum@2q4cjchfajvh>
 <CALmYWFv+cy4mL85e4fLCC6fbt4FxB1ONSnVaBcezN84bCbEr5A@mail.gmail.com> <nu4c2nh5jsm6ldb2xvyw5ilgvekalq5lsfrxjw6xsx7txrwygt@r63xfvdt7cjk>
In-Reply-To: <nu4c2nh5jsm6ldb2xvyw5ilgvekalq5lsfrxjw6xsx7txrwygt@r63xfvdt7cjk>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 15 Aug 2024 13:23:02 -0700
Message-ID: <CABi2SkU84jZFa8qGPQen9g16zQ9E-Z9VOuUE+HjNDSMCPoRA1g@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] mremap refactor: check src address for vma
 boundaries first.
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@google.com>, 
	Jeff Xu <jeffxu@chromium.org>, akpm@linux-foundation.org, willy@infradead.org, 
	torvalds@linux-foundation.org, pedro.falcato@gmail.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	lorenzo.stoakes@oracle.com, mpe@ellerman.id.au, oliver.sang@intel.com, 
	vbabka@suse.cz, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 1:14=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Jeff Xu <jeffxu@google.com> [240815 13:23]:
> > On Thu, Aug 15, 2024 at 9:50=E2=80=AFAM Liam R. Howlett <Liam.Howlett@o=
racle.com> wrote:
> > >
> > > * Jeff Xu <jeffxu@chromium.org> [240814 23:46]:
> > > > On Wed, Aug 14, 2024 at 12:55=E2=80=AFPM Liam R. Howlett
> > > > <Liam.Howlett@oracle.com> wrote:
> > > > > The majority of the comments to V2 are mine, you only told us tha=
t
> > > > > splitting a sealed vma is wrong (after I asked you directly to an=
swer)
> > > > > and then you made a comment about testing of the patch set. Besid=
es the
> > > > > direct responses to me, your comment was "wait for me to test".
> > > > >
> > > > Please share this link for  " Besides the direct responses to me, y=
our
> > > > comment was "wait for me to test".
> > > > Or  pop up that email by responding to it, to remind me.  Thanks.
> > >
> > > [1].
> >
> > That is responding to Andrew, to indicate V2 patch has dependency on
> > arch_munmap in PPC. And I will review/test the code, I will respond to
> > Andrew directly.
> >
> > PS Your statement above is entirely false, and out of context.
> >
> > " You only told us that splitting a sealed vma is wrong (after I asked
> > you directly to answer) and then you made a comment about testing of
> > the patch set. Besides the direct responses to me, your comment was
> > "wait for me to test".
>
> [1] has your "wait for me to test" to hold up a patch set, [2] has you
> answering my direct question to you and making the untested comment to
> someone else.
>
This is the last time that I'm trying to clarify this.
[1] is my response to Andrew and Pedro.
[2] is my comments about V2 lack of test , i.e. no selftest change, no
extra tests added.

-Jeff

> So, entirely true.
>
> Liam
>
> [1]. https://lore.kernel.org/all/CALmYWFs0v07z5vheDt1h3hD+3--yr6Va0ZuQeaA=
To+-8MuRJ-g@mail.gmail.com/
> [2]. https://lore.kernel.org/all/CALmYWFvURJBgyFw7x5qrL4CqoZjy92NeFAS750X=
aLxO7o7Cv9A@mail.gmail.com/

