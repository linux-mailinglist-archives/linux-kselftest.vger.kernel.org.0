Return-Path: <linux-kselftest+bounces-11880-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60640907A10
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 19:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D5C01C237C9
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 17:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F72D14A4D0;
	Thu, 13 Jun 2024 17:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLmEkgNi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF5514B081;
	Thu, 13 Jun 2024 17:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718300353; cv=none; b=d1c/hf6Z+G1jxuvZz74VShKlQ5BRY71EcF69vWK7OwD9KHT5LvF4GQwCf2a+oLy/n8/mT3ZSFxSdJbZhgo0p2YepLAtiyx/AUPG4aO2B4dQZXgf8V6BscZkvspqyMaPLSPF0DgDdOajnPpMvm6LN+ZMXoLbpiXn74vcL6SUCdRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718300353; c=relaxed/simple;
	bh=cM/32dqi6fZt6LQTmM2EuhniCZp3BnJkhJ9u/IvhkK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=paEG9jWIEj62Rl+3eqIbCqGWMwysOYvy660eFmBi0EvVD7ElSOMTxzNi9VihkRV0McAq5Skm5hpiGUeBjNIyTPT0u9NuAMXOsFBOuDkpl1Luwx7PfcPxzSw3zWocdrei3V9eYdGwjZupuBQoaYdtHRUqFXG2pFDyYXSAtOuM5v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLmEkgNi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C36C2BBFC;
	Thu, 13 Jun 2024 17:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718300352;
	bh=cM/32dqi6fZt6LQTmM2EuhniCZp3BnJkhJ9u/IvhkK4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=vLmEkgNiXKte5/uSoWuxw8K2LivuOoveM9eY5IF53RdFd2/aHR3HPlsyeJbzOxJCM
	 0ab8T/A/5ugDDiTNIKpJUsZI5NNfA2P5ojQ6p4L9AOmyGZy7hmApe2Ie1KuPnd2oWQ
	 kXNonU/JFutpllQ1SgrHvwSMciwJbVQ2fuUAAt4YrxDI6cXqqJmXwL82KdipaQUc/E
	 27x5unmbWSKF3Y27/q/MwCanDS7OIVp5BbCztEwJpnc1QSFA3CWP0Fu1cfZtxAyc7T
	 fdohD6WjscUhX3c/2T1Lu6zPrXCytxcvyKT19RP1XnEvWL9VBWu28a3Yjg/+b/qIzM
	 +1cPrEz6SQm/Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2E965CE0760; Thu, 13 Jun 2024 10:39:12 -0700 (PDT)
Date: Thu, 13 Jun 2024 10:39:12 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Nilay Shroff <nilay@linux.ibm.com>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, hch@lst.de, sagi@grimberg.me,
	davidgow@google.com, akpm@linux-foundation.org,
	venkat88@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] list: introduce a new cutting helper
Message-ID: <c65e7fef-cfee-4360-b03c-cfdd832912a4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <f0e4c51c-8227-4f5c-876f-38fbb4a0e1bf@linux.ibm.com>
 <ZmrscxG51gFRDVlM@kbusch-mbp>
 <c475f0d8-3bc9-4d65-8fce-586f4b75b4fc@linux.ibm.com>
 <ZmsD_HDLBQAqOOU3@kbusch-mbp.dhcp.thefacebook.com>
 <31eb40f9-d68d-4348-b1fd-3cf057939297@paulmck-laptop>
 <ZmsGfle1aZQauzRb@kbusch-mbp.dhcp.thefacebook.com>
 <73b994eb-c689-48e0-b09c-a414041a0525@paulmck-laptop>
 <ZmsS9DZWl8TccvKz@kbusch-mbp.dhcp.thefacebook.com>
 <046f42c5-34b5-41a2-9680-5ef86ef25c01@paulmck-laptop>
 <ZmsZ_lKgOlB6Wypy@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmsZ_lKgOlB6Wypy@kbusch-mbp.dhcp.thefacebook.com>

On Thu, Jun 13, 2024 at 10:10:38AM -0600, Keith Busch wrote:
> On Thu, Jun 13, 2024 at 09:01:47AM -0700, Paul E. McKenney wrote:
> > 
> > Is there a way to avoid this issue by making this be a statement parameter
> > to a macro?
> 
> Something like this? It appears to work for the intended use, at least.
> 
> ---
> diff --git a/include/linux/rculist.h b/include/linux/rculist.h
> index 3dc1e58865f77..cdd2e5c0d5cdb 100644
> --- a/include/linux/rculist.h
> +++ b/include/linux/rculist.h
> @@ -204,6 +204,30 @@ static inline void list_replace_rcu(struct list_head *old,
>  	old->prev = LIST_POISON2;
>  }
>  
> +
> +static inline void __list_cut_start(struct list_head *list,
> +				    struct list_head *head,
> +				    struct list_head *entry)
> +{
> +	list->next = entry;
> +	list->prev = head->prev;
> +	__list_del(entry->prev, head);
> +}
> +
> +static inline void __list_cut_end(struct list_head *list,
> +				  struct list_head *entry)
> +{
> +	entry->prev = list;
> +	list->prev->next = list;
> +}
> +
> +#define list_cut_rcu(list, head, entry, sync)		\
> +	do {						\
> +		__list_cut_start(list, head, entry);	\

At this point, old readers might see the new list starting from "head"
and new readers see the new (shorter) list, again, starting from "head".
Presumably no readers can yet see "list".

> +		sync;					\

There are now no old readers, and thus no readers that can see
any elements in the list starting from "entry".

> +		__list_cut_end(list, entry); 		\

And this fixes up the list now headed by "list".

So:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

And another argument for lambdas, not that there is a shortage of
arguments against them.  ;-)

> +	} while (0)
> +
>  /**
>   * __list_splice_init_rcu - join an RCU-protected list into an existing list.
>   * @list:	the RCU-protected list to splice
> --

