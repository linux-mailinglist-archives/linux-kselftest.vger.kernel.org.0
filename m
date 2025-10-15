Return-Path: <linux-kselftest+bounces-43201-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E077BBDEAFC
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 15:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B3EE4F982A
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 13:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93A7324B3A;
	Wed, 15 Oct 2025 13:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bj3kAtTv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87675322C67;
	Wed, 15 Oct 2025 13:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760533905; cv=none; b=nhU8BvnPWsR9m/9hJVemTQLIw4M1hibSHf7S9sr5ZDheU03zGqXSzZH/4EmLLZ8hKyKmvxhfmHnFffKMZzHhHEYk6kGJ5Z4NHp3qdNvY0bSxCGtNDdNMYbWxAEOd1FwY5/4iUa0ZZdqVktUMqUY5vxOB8qb5NjooKKJcKDBj9cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760533905; c=relaxed/simple;
	bh=omexcsvQOP6L3u6VXqhGkYJUOCWIegna1Gz630OIFyA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uxlxJ4GcLgaqwBVRDTrzafXfC6efcAsEEN4sx0CJMoocMUHZPmvfwseZq8/yattjG1i3wwjxjiPE8fQEtThZur9MQ5MUn7f69eZyDTTkvxLVP1kRkMVtE2HkOO7HFjtypDEkAk08gceaxbqvoPpCGjzkIpNMpWN5KOApdx6pr5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bj3kAtTv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D96DC4CEF8;
	Wed, 15 Oct 2025 13:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760533905;
	bh=omexcsvQOP6L3u6VXqhGkYJUOCWIegna1Gz630OIFyA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bj3kAtTvuMH0wrdZEdcvWcUEePwq0ISRRyCNWlhSpLuB6WQVpbV0vTd0PuT52xlAS
	 w7KFR5RXN7/WBOhy+YS726di7J4JaoI0d4fan+f4IiCJjqlVJlAD6MHu/578kiA4xV
	 A7MpgIXtEEOQ9yi9IE0weQsmeyVwMca2PpXfMUgC5LiwVYlWewTC95p0Ly4cPNO73I
	 ee2bIlA/rLBudcBVPP1aqtm+RtpYrRb21GqaDgDvR67Eavpg7HBO7oE3YZV4ydK+kr
	 qXsz8moSzdIAmz4widHWgoPA0mJBioHsEaAlz0wePPBt+CHyNvMboHoe7gy/H8nOV8
	 I60zSTotKp7SQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  akpm@linux-foundation.org,
  brauner@kernel.org,  corbet@lwn.net,  graf@amazon.com,  jgg@ziepe.ca,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-mm@kvack.org,  masahiroy@kernel.org,  ojeda@kernel.org,
  rdunlap@infradead.org,  rppt@kernel.org,  tj@kernel.org,
  jasonmiu@google.com,  dmatlack@google.com,  skhawaja@google.com
Subject: Re: [PATCH 1/2] liveupdate: kho: warn and fail on metadata or
 preserved memory in scratch area
In-Reply-To: <CA+CK2bD4z_j_jMhMtrvvQ5nOMEFT6yrRHk9rk7BEiQPSPCHiqA@mail.gmail.com>
	(Pasha Tatashin's message of "Wed, 15 Oct 2025 08:40:26 -0400")
References: <20251015053121.3978358-1-pasha.tatashin@soleen.com>
	<20251015053121.3978358-2-pasha.tatashin@soleen.com>
	<mafs0zf9sjrgc.fsf@kernel.org>
	<CA+CK2bD4z_j_jMhMtrvvQ5nOMEFT6yrRHk9rk7BEiQPSPCHiqA@mail.gmail.com>
Date: Wed, 15 Oct 2025 15:11:41 +0200
Message-ID: <mafs0qzv4jomq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15 2025, Pasha Tatashin wrote:

> On Wed, Oct 15, 2025 at 8:10=E2=80=AFAM Pratyush Yadav <pratyush@kernel.o=
rg> wrote:
>>
>> On Wed, Oct 15 2025, Pasha Tatashin wrote:
>>
>> > It is invalid for KHO metadata or preserved memory regions to be locat=
ed
>> > within the KHO scratch area, as this area is overwritten when the next
>> > kernel is loaded, and used early in boot by the next kernel. This can
>> > lead to memory corruption.
>> >
>> > Adds checks to kho_preserve_* and KHO's internal metadata allocators
>> > (xa_load_or_alloc, new_chunk) to verify that the physical address of t=
he
>> > memory does not overlap with any defined scratch region. If an overlap
>> > is detected, the operation will fail and a WARN_ON is triggered. To
>> > avoid performance overhead in production kernels, these checks are
>> > enabled only when CONFIG_KEXEC_HANDOVER_DEBUG is selected.
>> >
>> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>> > ---
>> >  kernel/liveupdate/Kconfig                   | 15 ++++++++++
>> >  kernel/liveupdate/kexec_handover.c          | 32 ++++++++++++++++++---
>> >  kernel/liveupdate/kexec_handover_debug.c    | 18 ++++++++++++
>> >  kernel/liveupdate/kexec_handover_internal.h |  9 ++++++
>> >  4 files changed, 70 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
>> > index 522b9f74d605..d119f4f3f4b1 100644
>> > --- a/kernel/liveupdate/Kconfig
>> > +++ b/kernel/liveupdate/Kconfig
>> > @@ -27,4 +27,19 @@ config KEXEC_HANDOVER_DEBUGFS
>> >         Also, enables inspecting the KHO fdt trees with the debugfs bi=
nary
>> >         blobs.
>> >
>> > +config KEXEC_HANDOVER_DEBUG
>> > +     bool "Enable Kexec Handover debug checks"
>> > +     depends on KEXEC_HANDOVER_DEBUGFS
>>
>> Why the dependency on debugfs? Why can't the debug checks be enabled
>> independently?
>
> Because there is one kexec_handover_debug.c file, that I thought would
> make sense to use for both, but now thinking about this, perhaps we
> should split the code: KEXEC_HANDOVER_DEBUGFS and
> KEXEC_HANDOVER_DEBUG, and add two files:
> kexec_handover_debugfs.c and kexec_handover_debug.c, this would avoid
> ifdefs in .c.

Sounds good.

>
>>
>> > +     help
>> > +       This option enables extra sanity checks for the Kexec Handover
>> > +       subsystem.
>> > +
>> > +       These checks verify that neither preserved memory regions nor =
KHO's
>> > +       internal metadata are allocated from within a KHO scratch area.
>> > +       An overlap can lead to memory corruption during a subsequent k=
exec
>> > +       operation.
>>
>> I don't think the checks that are done should be listed here since as
>> soon as another check is added this list will become out of date.
>
> I thought it could be expanded when new features are added, but I can
> remove this description.

Yes, but it is easy to forget to do so.

>
>>
>> > +
>> > +       If an overlap is detected, the kernel will print a warning and=
 the
>> > +       offending operation will fail. This should only be enabled for
>>
>> This also describes the behaviour of the checks, which might change
>> later. Maybe for some checks the operation won't fail? I suppose just
>> leave it at "the kernel will print a warning"?
>
> If it changes, and Kconfig should be updated as well.
>
>>
>> > +       debugging purposes due to runtime overhead.
>> >  endmenu
[...]

--=20
Regards,
Pratyush Yadav

