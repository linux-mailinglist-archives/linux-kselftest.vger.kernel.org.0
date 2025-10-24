Return-Path: <linux-kselftest+bounces-43992-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DB5C07173
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 17:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2636D35C331
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 15:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E9F32B9AC;
	Fri, 24 Oct 2025 15:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmS/OtrF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9DE2DA765;
	Fri, 24 Oct 2025 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761321149; cv=none; b=o1H7yR3g3PA3vcIJpV8fsTlfBsqWK7YORF/bdDEQvucpnNEFnwe3JD+o0c4A+Pr/S5EryaYYGA4/KH5BSH/KnwWOTEiN4fAq598n/V7r5NurkHqgYehamnLDlV0nsm0EZ1UaBRlvOo0ADIAp8y0MxVz+Ve+we60/B5BH8y9N7vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761321149; c=relaxed/simple;
	bh=hN57D+m8bfZOyaql25Ql2BNoX4IBCg8l7ydroV/tKz0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qqi7K+WiuVaYeraPaHaW6gnW3hFcp7a0OM2wx19ruB7EZuBOeMBvnXWsljGKFv5D/JBjH+l7hpNiO5ltXW/yfUPZfkNqJWFUVVYWQ+I+Z8opwPPXkAv57MoVY1SfFJvfmK7K7J9mkzEg2lTFSsLzhn2V846gYODKy8Eg7GsoN4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmS/OtrF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EF6C4CEF1;
	Fri, 24 Oct 2025 15:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761321149;
	bh=hN57D+m8bfZOyaql25Ql2BNoX4IBCg8l7ydroV/tKz0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hmS/OtrFuMY/e8rrKApoVlK6kToisDX80rTEqsylwmg+YmFSMbqGuRSosQ2ziAcBi
	 jbPOVLF8KOBXTJXRxl1OSHbIQo2H29kyfcKZkMUKBpJrIwaH5wpIe4N/H+9zRlasMH
	 kYcaEH/CycQEoRHV6B5Lrel8kpBTARMqYaaf5OT0PrvTJtOh+0usoO1I7FFlgwdk+7
	 wu34rIi0QCLtGoEHvw//qh8xp7MjinNmo7GtZmfTxGX5Ppo3ULQ6lzQuSkPw13/BMx
	 dY8wu/l8fW+yG9wQ9I+frPOeQJmEwLhCw0JkqWqgkZ7EshbZFuuPGRTCV/DqK1E4BG
	 EMwY35Ot7E8wA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  akpm@linux-foundation.org,
  brauner@kernel.org,  corbet@lwn.net,  graf@amazon.com,  jgg@ziepe.ca,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-mm@kvack.org,  masahiroy@kernel.org,  ojeda@kernel.org,
  rdunlap@infradead.org,  rppt@kernel.org,  tj@kernel.org
Subject: Re: [PATCHv7 3/7] kho: drop notifiers
In-Reply-To: <mafs0o6pwe1sy.fsf@kernel.org> (Pratyush Yadav's message of "Fri,
	24 Oct 2025 17:50:53 +0200")
References: <20251022005719.3670224-1-pasha.tatashin@soleen.com>
	<20251022005719.3670224-4-pasha.tatashin@soleen.com>
	<mafs0ikg7fbez.fsf@kernel.org>
	<CA+CK2bDrrg0UoJXpeN+Au2-sreYrZ+DHVcEUidzPw2Qk60orgg@mail.gmail.com>
	<mafs0o6pwe1sy.fsf@kernel.org>
Date: Fri, 24 Oct 2025 17:52:26 +0200
Message-ID: <mafs0jz0ke1qd.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Oct 24 2025, Pratyush Yadav wrote:

> On Fri, Oct 24 2025, Pasha Tatashin wrote:
>
>>> > -int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt)
>>> > +int kho_add_subtree(const char *name, void *fdt)
>>> >  {
>>> > -     int err = 0;
>>> > -     u64 phys = (u64)virt_to_phys(fdt);
>>> > -     void *root = page_to_virt(ser->fdt);
>>> > +     struct kho_sub_fdt *sub_fdt;
>>> > +     int err;
>>> >
>>> > -     err |= fdt_begin_node(root, name);
>>> > -     err |= fdt_property(root, PROP_SUB_FDT, &phys, sizeof(phys));
>>> > -     err |= fdt_end_node(root);
>>> > +     sub_fdt = kmalloc(sizeof(*sub_fdt), GFP_KERNEL);
>>> > +     if (!sub_fdt)
>>> > +             return -ENOMEM;
>>> >
>>> > -     if (err)
>>> > -             return err;
>>> > +     INIT_LIST_HEAD(&sub_fdt->l);
>>> > +     sub_fdt->name = name;
>>> > +     sub_fdt->fdt = fdt;
>>> >
>>> > -     return kho_debugfs_fdt_add(&kho_out.dbg, name, fdt, false);
>>> > +     mutex_lock(&kho_out.fdts_lock);
>>> > +     list_add_tail(&sub_fdt->l, &kho_out.sub_fdts);
>>> > +     err = kho_debugfs_fdt_add(&kho_out.dbg, name, fdt, false);
>>>
>>> I think you should remove sub_fdt from the list and kfree() it on error
>>> here. Otherwise we signal an error to the caller and they might free
>>> sub_fdt->fdt, which will later result in a use-after-free at
>>> __kho_finalize().
>>
>> I think, it is better to simply do:
>> WARN_ON_ONCE(kho_debugfs_fdt_add(...));
>> Now debugfs is optional, and there is no reason to return an error to
>> a caller if kho_debugfs_fdt_add() fails
>
> Yeah, that works too.

On a second thought, maybe pr_warn() instead of WARN_ON()? This isn't an
assertion since the debugfs creation can fail for many reasons. It isn't
expected to always succeed. So a full WARN_ON() splat seems overkill.

[...]

-- 
Regards,
Pratyush Yadav

