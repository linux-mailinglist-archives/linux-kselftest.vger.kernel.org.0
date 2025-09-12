Return-Path: <linux-kselftest+bounces-41292-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D09E7B54678
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 11:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 798FC560E65
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 09:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E47274669;
	Fri, 12 Sep 2025 09:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0u6qv5A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C2625785D;
	Fri, 12 Sep 2025 09:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757667924; cv=none; b=gJF/RHQTTAk5k7t4bB4rDsUHEqgG9GebjsLHBuOl4xZ+4ST6q+y1NIuDpZAcpAGAj4oqrT9n3mmd94uwzZjhEFMTjSVVCaNhxV81Fbe1AQcRSl2UhXdkGGq9zdD0WJkMR5+4UDJEuiKgEHx7ryY6bdeghzFk7cT/eiG4F+MOfWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757667924; c=relaxed/simple;
	bh=CqjnGTYUtFsjV4i7EQ5ZEIH80QjkINQH/T0xW4BLaVE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=LP4t0lGw68Wcvmk7Dx2J6+0sCIHH28WiRzzDV4eb/LOmAOkv0QvR+zSkZhgMILnt6G+efKXvN2JqzCuy9fa6B+ekeI8+y4JtS8YLQQqvTEXx3YLUTxt8wsfu5vJHKA3saEnSYbCR3qmXQl0VzOWyqp2UglqC3vYhEmt6Sg3VovU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0u6qv5A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B7CC4CEF1;
	Fri, 12 Sep 2025 09:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757667924;
	bh=CqjnGTYUtFsjV4i7EQ5ZEIH80QjkINQH/T0xW4BLaVE=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=g0u6qv5AjHNvvHAaR6AJrTnKsbag0JpSkGy0k6fZTJ3ZBgAnVY/uT241VOfs1hf9I
	 Iv7V9IX+Gs17hr03OR2JueI7OIjJcK/gkEQp4mI4VPOsH4SJ23xufRHNiTDOASVxdz
	 U8pQnZpDNBAQErUZRvc3U3QfnzpcZbNq2UXNM9BRLlc3R9w/DJvLofpbP13yAs5+y6
	 pyoth7CI+1HJy8zst/DTXGf6z1sp4BSnopxOQmsMSSE0YXxc6PYTztWKYQDc/HtqPM
	 FNXUqdxjyF+Lxfq7RTHEZHV8v3/oYhmVmT30/va/iongUQlkt43ZjGqUNetNW1R9oD
	 wzINnBzVoFz0Q==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Sep 2025 11:05:20 +0200
Message-Id: <DCQP9ZJ0DFBO.3O3W57IDYN08I@kernel.org>
Subject: Re: [PATCH v3 1/5] revocable: Revocable resource management
Cc: "Benson Leung" <bleung@chromium.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan" <shuah@kernel.org>, "Dawid
 Niedzwiecki" <dawidn@google.com>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>,
 <linux-kselftest@vger.kernel.org>
To: "Tzung-Bi Shih" <tzungbi@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250912081718.3827390-1-tzungbi@kernel.org>
 <20250912081718.3827390-2-tzungbi@kernel.org>
In-Reply-To: <20250912081718.3827390-2-tzungbi@kernel.org>

On Fri Sep 12, 2025 at 10:17 AM CEST, Tzung-Bi Shih wrote:
> +/**
> + * struct revocable_provider - A handle for resource provider.
> + * @srcu: The SRCU to protect the resource.
> + * @res:  The pointer of resource.  It can point to anything.
> + * @kref: The refcount for this handle.
> + */
> +struct revocable_provider {
> +	struct srcu_struct srcu;
> +	void __rcu *res;
> +	struct kref kref;
> +};

I think a revocable provider should provide an optional revoke() callback w=
here
users of the revocable provider can release the revoked resource.

But this can also be done as a follow-up.

> +/**
> + * struct revocable - A handle for resource consumer.
> + * @rp: The pointer of resource provider.
> + * @idx: The index for the RCU critical section.
> + */
> +struct revocable {
> +	struct revocable_provider *rp;
> +	int idx;
> +};

I think I asked about this in the previous version (but I don't remember if
there was an answer):

In Rust we get away with a single Revocable<T> structure, but we're using R=
CU
instead of SRCU. It seems to me that the split between struct revocable and
struct revocable_provider is only for the SRCU index? Or is there any other
reason?

> +/**
> + * revocable_provider_free() - Free struct revocable_provider.
> + * @rp: The pointer of resource provider.
> + *
> + * This sets the resource `(struct revocable_provider *)->res` to NULL t=
o
> + * indicate the resource has gone.
> + *
> + * This drops the refcount to the resource provider.  If it is the final
> + * reference, revocable_provider_release() will be called to free the st=
ruct.
> + */
> +void revocable_provider_free(struct revocable_provider *rp)
> +{
> +	rcu_assign_pointer(rp->res, NULL);
> +	synchronize_srcu(&rp->srcu);
> +	kref_put(&rp->kref, revocable_provider_release);
> +}
> +EXPORT_SYMBOL_GPL(revocable_provider_free);

I think naming this "free" is a bit misleading, since what it basically doe=
s is

  (1) Revoke access to the resource.

  (2) Drop a reference count of struct revocable_provider.

In a typical application there may still be struct revocable instances that=
 have
a reference to the provider, so we can't claim that it's freed here.

So, given that, I'd rather call this revocable_provider_revoke().

> +static void devm_revocable_provider_free(void *data)
> +{
> +	struct revocable_provider *rp =3D data;
> +
> +	revocable_provider_free(rp);
> +}

Same here, I'd call this devm_revocable_provider_revoke().

> +DEFINE_FREE(revocable, struct revocable *, if (_T) revocable_release(_T)=
)
> +
> +#define _REVOCABLE(_rev, _label, _res)						\
> +	for (struct revocable *__UNIQUE_ID(name) __free(revocable) =3D _rev;	\
> +	     (_res =3D revocable_try_access(_rev)) || true; ({ goto _label; }))=
	\
> +		if (0) {							\
> +_label:										\
> +			break;							\
> +		} else
> +
> +#define REVOCABLE(_rev, _res) _REVOCABLE(_rev, __UNIQUE_ID(label), _res)

This is basically the same as Revocable::try_access_with() [1] in Rust, i.e=
.
try to access and run a closure.

Admittedly, REVOCABLE_TRY_ACCESS_WITH() is pretty verbose and I also do not=
 have
a great idea to shorten it.

Maybe you have a good idea, otherwise I'm also fine with the current name.

Otherwise, maybe it's worth to link to the Rust Revocable API for reference=
?

With *_free() renamed to *_revoke(), feel free to add:

	Acked-by: Danilo Krummrich <dakr@kernel.org>

[1] https://rust.docs.kernel.org/kernel/revocable/struct.Revocable.html#met=
hod.try_access_with

