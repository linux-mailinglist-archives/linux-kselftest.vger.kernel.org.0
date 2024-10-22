Return-Path: <linux-kselftest+bounces-20427-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C22C09AB9C7
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 01:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 791EB2818B3
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 23:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6822E1CDA25;
	Tue, 22 Oct 2024 23:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b="lFjN3toC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cvs.openbsd.org (cvs.openbsd.org [199.185.137.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E822A198846;
	Tue, 22 Oct 2024 23:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.185.137.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729638057; cv=none; b=DZvUgZDQwCahltSyJFwg4mViN8R1jrbkWBpUAvhLa6W65J7fR86lKE0d2l7fhYC0vzH0m39XEUQ0fbK9YIs3vnBoIsG3p7VJEJ3Hwz9ife66+qzpGOn1NUByjz9ClmwPoovXSKXcF51bzHZnUQzgBH+/5JbG0fkWKX2DngAGYs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729638057; c=relaxed/simple;
	bh=WHzMrjfMruvIpHlEeAVxdb46yOKuKbxbn7rKbjAxujE=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=RBgEik8JF6BtdBt5jcZX0dgrzqzfyXYh5/sU9kPld29MJ7CFGNKO2Eg1YXz1ZsBqnYPeZ5omefFCgc+o7NY4n8raLDHfxVjLFnv1IidY6N7USZ5A1XJtExhVqsJibvYw/j8peIZrVyfDyJcrqu+OjqdRrld7JQ4qp2bjZ9UNh/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org; spf=pass smtp.mailfrom=openbsd.org; dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b=lFjN3toC; arc=none smtp.client-ip=199.185.137.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openbsd.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=selector1; bh=WHzMrjfMru
	vIpHlEeAVxdb46yOKuKbxbn7rKbjAxujE=; h=date:references:in-reply-to:
	subject:cc:to:from; d=openbsd.org; b=lFjN3toCofQICkNsgOwYoO6iSIp7lx39o
	awIIft8WIVAsZ9DztAffz7LJqnfH4DTfPocBxsBD6t67EXKeu3eipzkVdvleVoAkNZ8a1P
	FsKJ7gzPEwP+23He9FJlEzg2+K3mmwy/TILcjoDQXKU7Fr6PoNzr95etBic+wJMXZ/vuhj
	4eq9tNnt5AhWjWtsvhiBVvSqiRqdBo1C3er+wU8Vh4PYeCnf+6CUwY5tE15VpSZmmVxoxZ
	PeiduAN5QDp9t7qyBuIpDDjWLMJRYGzQArETpt9tnzpcSrNafYSiou39NpF7libGRiz3Cn
	CI3803K611G0LzgunV2rb1ur943gA==
Received: from cvs.openbsd.org (localhost [127.0.0.1])
	by cvs.openbsd.org (OpenSMTPD) with ESMTP id 373605c3;
	Tue, 22 Oct 2024 16:54:10 -0600 (MDT)
From: "Theo de Raadt" <deraadt@openbsd.org>
To: Vlastimil Babka <vbabka@suse.cz>
cc: Jeff Xu <jeffxu@chromium.org>,
    Pedro Falcato <pedro.falcato@gmail.com>, akpm@linux-foundation.org,
    keescook@chromium.org, torvalds@linux-foundation.org,
    usama.anjum@collabora.com, corbet@lwn.net, Liam.Howlett@oracle.com,
    lorenzo.stoakes@oracle.com, jeffxu@google.com, jorgelo@chromium.org,
    groeck@chromium.org, linux-kernel@vger.kernel.org,
    linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
    jannh@google.com, sroettger@google.com,
    linux-hardening@vger.kernel.org, willy@infradead.org,
    gregkh@linuxfoundation.org, surenb@google.com, merimus@google.com,
    rdunlap@infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] mseal: Two fixes for madvise(MADV_DONTNEED) when sealed
In-reply-to: <8f68ad82-2f60-49f8-b150-0cf183c9cc71@suse.cz>
References: <20241017005105.3047458-1-jeffxu@chromium.org> <20241017005105.3047458-2-jeffxu@chromium.org> <5svaztlptf4gs4sp6zyzycwjm2fnpd2xw3oirsls67sq7gq7wv@pwcktbixrzdo> <CABi2SkXwOkoFcUUx=aALWVqurKhns+JKZqm2EyRTbHtROK8SKg@mail.gmail.com> <r5ljdglhtbapgqddtr6gxz5lszvq2yek2rd6bnllxk5i6difzv@imuu3pxh5fcc> <CABi2SkXArA+yfodoOxDbTTOpWCbU5Ce1p1HadSo0=CL23K4-dQ@mail.gmail.com> <8f68ad82-2f60-49f8-b150-0cf183c9cc71@suse.cz>
Comments: In-reply-to Vlastimil Babka <vbabka@suse.cz>
   message dated "Tue, 22 Oct 2024 17:55:43 +0200."
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Oct 2024 16:54:10 -0600
Message-ID: <35887.1729637650@cvs.openbsd.org>

Vlastimil Babka <vbabka@suse.cz> wrote:

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
>=20
> Could the same effect be simply achieved with MADV_COLD/MADV_PAGEOUT? That
> should be able to reclaim the pages as well if they are indeed not used, =
but
> it's non-destructive and you don't want to allow destructive madvise anyw=
ay
> (i.e. no throwing away data that would be replaced by zeroes or original
> file content on the next touch) so it seems overall a better fit for seal=
ed
> areas?

Comment from the sidelines: That seems clever enough.

