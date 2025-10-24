Return-Path: <linux-kselftest+bounces-43991-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BE606C07176
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 17:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E8A875653E7
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 15:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E596333746;
	Fri, 24 Oct 2025 15:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVzGB7lq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4658832E681;
	Fri, 24 Oct 2025 15:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761321056; cv=none; b=aj9pb6oF6lgBJOo58Ap3owMSkZDMN3uSqvNaKwbYFRmb6AB8XKNVkVSAgGL6FKh2z7FQtjByy7Jk3euOxwAdeyG7sCDhkG4LuNaIcrxDCSVCT+7NAYiWXlJGc4ulGmWdDfSbYAU10LzRbg/BEylY71PcB3nFXklGABkjf3XwAXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761321056; c=relaxed/simple;
	bh=/PyVVXZMWN4PunxnwU8KXSOp8sSTJb6YyMZNyGFJrqk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YZ691gvLFzNKXpKb5oiuI4WN9CYuVylvD5C0Q11PxoCt+YZU1omYdbt6FD2MuoXbzRWfHnqzkeyiU7eoNqVfmyzdjzvVkjUIF4uh0uGqt+S/b4Y4ocfWJ6dPzt8wuzq0CMhka12XOw2ytz7QXXhenmYdpKAjdeTGomqX3bxQZy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVzGB7lq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2638EC4CEF7;
	Fri, 24 Oct 2025 15:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761321056;
	bh=/PyVVXZMWN4PunxnwU8KXSOp8sSTJb6YyMZNyGFJrqk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=eVzGB7lqmsOpkNO3nJ7BzRCB/x+t6IzqwNR0w6WsW74BW6wbUEGBiCdGRtUvQxiQM
	 Wnf0wusKk4RGiTTeZowjY+T1Q6M6Q7JI0ycTRaFOcKN1wUHfBHiFO5Ftjvd7QUCuKr
	 iiNKX5F1RnhHjCfCPRd62eLKjhyAGuMbrN7E2F57BE5M7qubSvelrgZFODQK1z2sXT
	 Yt3YrZVuK5qu1oPzVPLvFeQe/3PwvCCJgIEz2tgg3+3DxINHjcykc0Ce+XhNFj15dL
	 JfSxTtp3/vfeBf9FfxYVRVZOmeu3TkHrPyhIaf+/MQoTaZ2BV1BvZKI0p00TcloiMu
	 64S4lZX17ZvGQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  akpm@linux-foundation.org,
  brauner@kernel.org,  corbet@lwn.net,  graf@amazon.com,  jgg@ziepe.ca,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-mm@kvack.org,  masahiroy@kernel.org,  ojeda@kernel.org,
  rdunlap@infradead.org,  rppt@kernel.org,  tj@kernel.org
Subject: Re: [PATCHv7 3/7] kho: drop notifiers
In-Reply-To: <CA+CK2bDrrg0UoJXpeN+Au2-sreYrZ+DHVcEUidzPw2Qk60orgg@mail.gmail.com>
	(Pasha Tatashin's message of "Fri, 24 Oct 2025 09:11:16 -0400")
References: <20251022005719.3670224-1-pasha.tatashin@soleen.com>
	<20251022005719.3670224-4-pasha.tatashin@soleen.com>
	<mafs0ikg7fbez.fsf@kernel.org>
	<CA+CK2bDrrg0UoJXpeN+Au2-sreYrZ+DHVcEUidzPw2Qk60orgg@mail.gmail.com>
Date: Fri, 24 Oct 2025 17:50:53 +0200
Message-ID: <mafs0o6pwe1sy.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Oct 24 2025, Pasha Tatashin wrote:

>> > -int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt)
>> > +int kho_add_subtree(const char *name, void *fdt)
>> >  {
>> > -     int err = 0;
>> > -     u64 phys = (u64)virt_to_phys(fdt);
>> > -     void *root = page_to_virt(ser->fdt);
>> > +     struct kho_sub_fdt *sub_fdt;
>> > +     int err;
>> >
>> > -     err |= fdt_begin_node(root, name);
>> > -     err |= fdt_property(root, PROP_SUB_FDT, &phys, sizeof(phys));
>> > -     err |= fdt_end_node(root);
>> > +     sub_fdt = kmalloc(sizeof(*sub_fdt), GFP_KERNEL);
>> > +     if (!sub_fdt)
>> > +             return -ENOMEM;
>> >
>> > -     if (err)
>> > -             return err;
>> > +     INIT_LIST_HEAD(&sub_fdt->l);
>> > +     sub_fdt->name = name;
>> > +     sub_fdt->fdt = fdt;
>> >
>> > -     return kho_debugfs_fdt_add(&kho_out.dbg, name, fdt, false);
>> > +     mutex_lock(&kho_out.fdts_lock);
>> > +     list_add_tail(&sub_fdt->l, &kho_out.sub_fdts);
>> > +     err = kho_debugfs_fdt_add(&kho_out.dbg, name, fdt, false);
>>
>> I think you should remove sub_fdt from the list and kfree() it on error
>> here. Otherwise we signal an error to the caller and they might free
>> sub_fdt->fdt, which will later result in a use-after-free at
>> __kho_finalize().
>
> I think, it is better to simply do:
> WARN_ON_ONCE(kho_debugfs_fdt_add(...));
> Now debugfs is optional, and there is no reason to return an error to
> a caller if kho_debugfs_fdt_add() fails

Yeah, that works too.

>
>>
>> > +     mutex_unlock(&kho_out.fdts_lock);
>> > +
>> > +     return err;
>> >  }
>> >  EXPORT_SYMBOL_GPL(kho_add_subtree);
>> >
>> > -int register_kho_notifier(struct notifier_block *nb)
>> > +void kho_remove_subtree(void *fdt)
>> >  {
>> > -     return blocking_notifier_chain_register(&kho_out.chain_head, nb);
>> > -}
>> > -EXPORT_SYMBOL_GPL(register_kho_notifier);
>> > +     struct kho_sub_fdt *sub_fdt;
>> > +
>> > +     mutex_lock(&kho_out.fdts_lock);
>> > +     list_for_each_entry(sub_fdt, &kho_out.sub_fdts, l) {
>>
>> list_for_each_entry_safe() here since we delete.
>
> Not needed, we are breaking from the iterator when deleting.

Makes sense. Didn't think of that.

[...]

-- 
Regards,
Pratyush Yadav

