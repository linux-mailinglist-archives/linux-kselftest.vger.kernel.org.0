Return-Path: <linux-kselftest+bounces-44010-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0AAC07535
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 18:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28ADE1C40EF4
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 16:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC159264F9C;
	Fri, 24 Oct 2025 16:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQBvotmE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2541255F22;
	Fri, 24 Oct 2025 16:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761323532; cv=none; b=XT/0NDqSJ/eHVVkM3IQg8LQB5pkXD37HkMW4ZU6zZOTfRUezUvs3rMuKFCjxeXbrRlQqfePvWEmbOuw+XXGXDrhx57DHakhOJk9omahmAh9FZC4Dbw/OMVjZNZEFK09KzXIjB6yq4MLBFdXzUADBnkdpvRd9oS+/ui69pQM8Kn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761323532; c=relaxed/simple;
	bh=QJbCv3dorbwltFD/bJzgSaTHfSbrFysNBhH68NyQCsQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qOuweu0J9d0owd139yf1lKQ12u8xAcdwnYsDx0sjcPkcADK0AbJS/J2b9Cb/WEdwSb9o8ZByZ9SjZ2drOVV5EQamyevJ/fHtTp4ZfiM1wmFEzi7R8whxMlq0++8LUiD8rqGmOLu8y2MV+0/G7tTUNIJy+h61oSd5v/d6JF9DdhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQBvotmE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2000DC4CEF1;
	Fri, 24 Oct 2025 16:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761323532;
	bh=QJbCv3dorbwltFD/bJzgSaTHfSbrFysNBhH68NyQCsQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=BQBvotmEc5dzMUOyFMp+OMBmfTgmrRhBErDoqsVtOUIac28Aei5feBsG+d6vWY+eH
	 4rAwrLMrav/Om5Wu+34l5Zh/ZdiKAZNe/spxILBg7OvBrf96+1l1WkxlPvIpTqvRQ7
	 o19C49hbbzpyKu3z4AaWqKMsgc3zYpt4hxwzt3IhoN+3GnU6ixD20eF3I/5RBJLXXV
	 6iLI27UaGc5v+ZFG/JA+jKVBH4F0mjV5CP/w8IDhuoCcMoM7xc6rvJ1jlUDafQxdnm
	 nHkhw2WOVMOY7nsK5QmVCTsQspttcngQFPoqSJzd4afy/wK447GLF80f+oEiQqctyz
	 ak5vAp0wzFTwQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  akpm@linux-foundation.org,
  brauner@kernel.org,  corbet@lwn.net,  graf@amazon.com,  jgg@ziepe.ca,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-mm@kvack.org,  masahiroy@kernel.org,  ojeda@kernel.org,
  rdunlap@infradead.org,  rppt@kernel.org,  tj@kernel.org
Subject: Re: [PATCHv7 3/7] kho: drop notifiers
In-Reply-To: <CA+CK2bB_xPAsHXU62Hd5iBt-+Jf2BiXQM4M-QEL=AA_Xu-APhg@mail.gmail.com>
	(Pasha Tatashin's message of "Fri, 24 Oct 2025 12:15:32 -0400")
References: <20251022005719.3670224-1-pasha.tatashin@soleen.com>
	<20251022005719.3670224-4-pasha.tatashin@soleen.com>
	<mafs0ikg7fbez.fsf@kernel.org>
	<CA+CK2bDrrg0UoJXpeN+Au2-sreYrZ+DHVcEUidzPw2Qk60orgg@mail.gmail.com>
	<mafs0o6pwe1sy.fsf@kernel.org> <mafs0jz0ke1qd.fsf@kernel.org>
	<CA+CK2bB_xPAsHXU62Hd5iBt-+Jf2BiXQM4M-QEL=AA_Xu-APhg@mail.gmail.com>
Date: Fri, 24 Oct 2025 18:32:09 +0200
Message-ID: <mafs0frb8dzw6.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24 2025, Pasha Tatashin wrote:

> On Fri, Oct 24, 2025 at 11:52=E2=80=AFAM Pratyush Yadav <pratyush@kernel.=
org> wrote:
>>
>> On Fri, Oct 24 2025, Pratyush Yadav wrote:
>>
>> > On Fri, Oct 24 2025, Pasha Tatashin wrote:
>> >
>> >>> > -int kho_add_subtree(struct kho_serialization *ser, const char *na=
me, void *fdt)
>> >>> > +int kho_add_subtree(const char *name, void *fdt)
>> >>> >  {
>> >>> > -     int err =3D 0;
>> >>> > -     u64 phys =3D (u64)virt_to_phys(fdt);
>> >>> > -     void *root =3D page_to_virt(ser->fdt);
>> >>> > +     struct kho_sub_fdt *sub_fdt;
>> >>> > +     int err;
>> >>> >
>> >>> > -     err |=3D fdt_begin_node(root, name);
>> >>> > -     err |=3D fdt_property(root, PROP_SUB_FDT, &phys, sizeof(phys=
));
>> >>> > -     err |=3D fdt_end_node(root);
>> >>> > +     sub_fdt =3D kmalloc(sizeof(*sub_fdt), GFP_KERNEL);
>> >>> > +     if (!sub_fdt)
>> >>> > +             return -ENOMEM;
>> >>> >
>> >>> > -     if (err)
>> >>> > -             return err;
>> >>> > +     INIT_LIST_HEAD(&sub_fdt->l);
>> >>> > +     sub_fdt->name =3D name;
>> >>> > +     sub_fdt->fdt =3D fdt;
>> >>> >
>> >>> > -     return kho_debugfs_fdt_add(&kho_out.dbg, name, fdt, false);
>> >>> > +     mutex_lock(&kho_out.fdts_lock);
>> >>> > +     list_add_tail(&sub_fdt->l, &kho_out.sub_fdts);
>> >>> > +     err =3D kho_debugfs_fdt_add(&kho_out.dbg, name, fdt, false);
>> >>>
>> >>> I think you should remove sub_fdt from the list and kfree() it on er=
ror
>> >>> here. Otherwise we signal an error to the caller and they might free
>> >>> sub_fdt->fdt, which will later result in a use-after-free at
>> >>> __kho_finalize().
>> >>
>> >> I think, it is better to simply do:
>> >> WARN_ON_ONCE(kho_debugfs_fdt_add(...));
>> >> Now debugfs is optional, and there is no reason to return an error to
>> >> a caller if kho_debugfs_fdt_add() fails
>> >
>> > Yeah, that works too.
>>
>> On a second thought, maybe pr_warn() instead of WARN_ON()? This isn't an
>> assertion since the debugfs creation can fail for many reasons. It isn't
>> expected to always succeed. So a full WARN_ON() splat seems overkill.
>
> I sent it with WARN_ON_ONCE(), I can change it to pr_warn_once() if
> there is another revision, otherwise we can just send a separate patch
> to make the change it is not that important.

Yep, makes sense.

--=20
Regards,
Pratyush Yadav

