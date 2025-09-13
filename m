Return-Path: <linux-kselftest+bounces-41442-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E853B5621B
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Sep 2025 17:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1286563E2B
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Sep 2025 15:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BA22EC571;
	Sat, 13 Sep 2025 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrm/jLac"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6647288D6;
	Sat, 13 Sep 2025 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757779019; cv=none; b=WJufly01mBDtW8OQqBodmUiTG93L+emmlt0s7Kc4fDAtM7BtoCtfTjIj2x73h+jKtXUDqNYYN293DwlbjiZb/AtOFAH3Di2tYJWVS8bvW6tpDBfXTYm0bqUtY2h07kFDveUx8/iMoZNbmEgJ49b3Q8cCl5ORUC08NKzR/jPcLPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757779019; c=relaxed/simple;
	bh=nRCcV6XQDlSAmgdXSomym0TQOZoWzvKA529zhmNuGeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGSRvD46iUJ1vv0aI0nSMlDiMR2wov/RsvPgIEYCuNtSx2Xbhm4j7ynUvwTdLuGSCFtk2fjx6Dv12zHOQe5Ne4QNVW/raOgDd4pQ2VzJYlV1SGWhqNILqNeztKdUwy8ueyYuugLvlLrEtTaHtNYjyHmRmkFWh51Esf5LijUpGkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrm/jLac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242E0C4CEEB;
	Sat, 13 Sep 2025 15:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757779019;
	bh=nRCcV6XQDlSAmgdXSomym0TQOZoWzvKA529zhmNuGeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lrm/jLacQGlQJdj7DxN1yuh7P8rRXwg+np4PYpU1cJdMi79z2ruulBvr+PWFI4BNZ
	 pCET6gNIu6eKa95+X49goACVMG+kzX+DDoNy+lhM0cHJKFfUwwP4TlVwGoiyHDoNip
	 DRiYKt1zUruO4Au6eRYlsl2Co8cJu+JJ6TOc2/zS0hGESln8dOsl4zG2FsiUc3+dN6
	 76jZCykYJDlvP945NN9+0qcMqnCt2OnIfN3Ztl5myhaBjX7k+f1uhs6zFNbUu2h8zo
	 8ycmFd9IH6BJ/w8vKPZbNdXXyg0ISekgKh/745MM9OGyysUIfpOvN+240vahgQ2KqN
	 lXV/X4pMaia4g==
Date: Sat, 13 Sep 2025 23:56:54 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Dawid Niedzwiecki <dawidn@google.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 1/5] revocable: Revocable resource management
Message-ID: <aMWURgOIdu71_X57@tzungbi-laptop>
References: <20250912081718.3827390-1-tzungbi@kernel.org>
 <20250912081718.3827390-2-tzungbi@kernel.org>
 <DCQP9ZJ0DFBO.3O3W57IDYN08I@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DCQP9ZJ0DFBO.3O3W57IDYN08I@kernel.org>

On Fri, Sep 12, 2025 at 11:05:20AM +0200, Danilo Krummrich wrote:
> On Fri Sep 12, 2025 at 10:17 AM CEST, Tzung-Bi Shih wrote:
> > +/**
> > + * struct revocable_provider - A handle for resource provider.
> > + * @srcu: The SRCU to protect the resource.
> > + * @res:  The pointer of resource.  It can point to anything.
> > + * @kref: The refcount for this handle.
> > + */
> > +struct revocable_provider {
> > +	struct srcu_struct srcu;
> > +	void __rcu *res;
> > +	struct kref kref;
> > +};
> 
> I think a revocable provider should provide an optional revoke() callback where
> users of the revocable provider can release the revoked resource.
>
> But this can also be done as a follow-up.

Understood.  Since this effectively delegates the memory of `res` to the
struct revocable provider, I propose we name the callback .release().

> > +/**
> > + * struct revocable - A handle for resource consumer.
> > + * @rp: The pointer of resource provider.
> > + * @idx: The index for the RCU critical section.
> > + */
> > +struct revocable {
> > +	struct revocable_provider *rp;
> > +	int idx;
> > +};
> 
> I think I asked about this in the previous version (but I don't remember if
> there was an answer):

Yes, in v1 https://lore.kernel.org/chrome-platform/aJ7HUJ0boqYndbtD@google.com/.

> In Rust we get away with a single Revocable<T> structure, but we're using RCU
> instead of SRCU. It seems to me that the split between struct revocable and
> struct revocable_provider is only for the SRCU index? Or is there any other
> reason?

Yes, for the SRCU index.

> > +/**
> > + * revocable_provider_free() - Free struct revocable_provider.
> > + * @rp: The pointer of resource provider.
> > + *
> > + * This sets the resource `(struct revocable_provider *)->res` to NULL to
> > + * indicate the resource has gone.
> > + *
> > + * This drops the refcount to the resource provider.  If it is the final
> > + * reference, revocable_provider_release() will be called to free the struct.
> > + */
> > +void revocable_provider_free(struct revocable_provider *rp)
> > +{
> > +	rcu_assign_pointer(rp->res, NULL);
> > +	synchronize_srcu(&rp->srcu);
> > +	kref_put(&rp->kref, revocable_provider_release);
> > +}
> > +EXPORT_SYMBOL_GPL(revocable_provider_free);
> 
> I think naming this "free" is a bit misleading, since what it basically does is
> 
>   (1) Revoke access to the resource.
> 
>   (2) Drop a reference count of struct revocable_provider.
> 
> In a typical application there may still be struct revocable instances that have
> a reference to the provider, so we can't claim that it's freed here.
> 
> So, given that, I'd rather call this revocable_provider_revoke().

Ack, will fix it in the next version.

> > +static void devm_revocable_provider_free(void *data)
> > +{
> > +	struct revocable_provider *rp = data;
> > +
> > +	revocable_provider_free(rp);
> > +}
> 
> Same here, I'd call this devm_revocable_provider_revoke().

Ack, will fix it in the next version.

> > +DEFINE_FREE(revocable, struct revocable *, if (_T) revocable_release(_T))
> > +
> > +#define _REVOCABLE(_rev, _label, _res)						\
> > +	for (struct revocable *__UNIQUE_ID(name) __free(revocable) = _rev;	\
> > +	     (_res = revocable_try_access(_rev)) || true; ({ goto _label; }))	\
> > +		if (0) {							\
> > +_label:										\
> > +			break;							\
> > +		} else
> > +
> > +#define REVOCABLE(_rev, _res) _REVOCABLE(_rev, __UNIQUE_ID(label), _res)
> 
> This is basically the same as Revocable::try_access_with() [1] in Rust, i.e.
> try to access and run a closure.
> 
> Admittedly, REVOCABLE_TRY_ACCESS_WITH() is pretty verbose and I also do not have
> a great idea to shorten it.
> 
> Maybe you have a good idea, otherwise I'm also fine with the current name.
> 
> Otherwise, maybe it's worth to link to the Rust Revocable API for reference?

No, I don't have a good idea either.  Will use REVOCABLE_TRY_ACCESS_WITH()
to align with Rust Revocable API in the next version.

