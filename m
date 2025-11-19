Return-Path: <linux-kselftest+bounces-45957-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25835C6D978
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 10:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 265992CD26
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 09:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0949A33555B;
	Wed, 19 Nov 2025 09:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="JTYNDviC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45233330B10;
	Wed, 19 Nov 2025 09:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763543277; cv=none; b=KxWF8087WVnu4z7HQ9fTXMfXyqbPYHsDc1vT0b81mav4RoBtCP7rHLHDZa643e0N72X8S86RRTj6ffDBEH+1ilWjpLm75CZAKVoiLuGNdH+zOVWUBJAe4o4UQU4J+FfvBQOp85tEv0xopbCDpkWb0iuzIA+Z+k0NjO8e/ybkXns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763543277; c=relaxed/simple;
	bh=bnmQzEcti01FWptwQuX16UbHkuZUQ5+JWDfmwfx0nqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJmu9jx00lCzzrHAE1n2/O5hjycITm8hhwVAMVz2WjbbhU57VF1TPhUMryZkVhHOWfRdlKxmlKx6IE+y8Gxukh2KobOPxBRi5xOAwVxlmixLYP+X0tlnHqoM46r2naIjk0AFrk7ddgxk2dKOBa23wMzY22qh7F1zsNg30tgyKFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=JTYNDviC; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rcb/XnE2TwFf/pN8kHchOfB4JCdyaPK5TEfa2OELNx8=; b=JTYNDviCFTq6htF5okFKRtbZWY
	2XEGS8kpHNWCJOePs0LVCKKWaLWtUlZjDK4fc3zFOZ2MOrePgRBSAfJ/zmWH6C2QqSTLlzYZ1Rd4+
	aWdGUgZkMeHCB8uPkwAAvJKdVn2hpgZJtH4qUbBTwOIDTPzrM5fXmHZj0S5bGiu7MhZ41ut5UAqhS
	1g/8YEA4Dvmt1LKwEXJRy+txInm+IURY9BOF4SqqttiCtfThtRUlIGCrcYd0ZjyYoFCApHCmMsOMS
	Ud8we02MTEMzD/L2RS9u2XvjQ0gSc2d83+qw++LNl/s8esB0wJjzRcQeYpnAjh/QlaYdEfLF0eCsM
	Y0ZS/8rQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vLeA8-00FxZB-Gf; Wed, 19 Nov 2025 09:07:40 +0000
Date: Wed, 19 Nov 2025 01:07:34 -0800
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Andre Carvalho <asantostc@gmail.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/4] netconsole: Dynamic allocation of
 userdata buffer
Message-ID: <crrdw3y2mgkhkgnuvgemuyy6px5hfru5yadhqu3jrhvkbkbec7@kiat7q7jbav6>
References: <20251113-netconsole_dynamic_extradata-v2-0-18cf7fed1026@meta.com>
 <20251113-netconsole_dynamic_extradata-v2-3-18cf7fed1026@meta.com>
 <ucjifexudkswvaef5c25hbzszdnzsnx3drdaqkf7ytdpi6qzk6@pd46ih2slt3w>
 <CAGSyskVSLtG-JyboQ6TLVKwMvHVH8YmgLJE1wFTU2czxCWFCzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGSyskVSLtG-JyboQ6TLVKwMvHVH8YmgLJE1wFTU2czxCWFCzQ@mail.gmail.com>
X-Debian-User: leitao

> > >  static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
> > > @@ -937,7 +953,9 @@ static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
> > >
> > >       ud = to_userdata(item->ci_parent);
> > >       nt = userdata_to_target(ud);
> > > -     update_userdata(nt);
> > > +     ret = update_userdata(nt);
> > > +     if (ret < 0)
> > > +             goto out_unlock;
> > >       ret = count;
> > >  out_unlock:
> > >       mutex_unlock(&dynamic_netconsole_mutex);
> > > @@ -1193,7 +1211,10 @@ static struct configfs_attribute *netconsole_target_attrs[] = {
> > >
> > >  static void netconsole_target_release(struct config_item *item)
> > >  {
> > > -     kfree(to_target(item));
> > > +     struct netconsole_target *nt = to_target(item);
> >
> > Thinking about this now, I suppose netconsole might be reading this in
> > parallel, and then we are freeing userdata mid-air.
> >
> > Don't we need the target_list_lock in here ?
> 
> This method is called after drop_netconsole_target(), which removes
> the target from target_list. This guarantees that we won't race with
> write_ext_msg().
> Also, a config_group cannot be removed while it still has child items.
> This guarantees that we won't race with userdata or attribute
> operations.
> So I believe this is safe.

Thanks for checking it!

--breno

