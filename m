Return-Path: <linux-kselftest+bounces-17543-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1585972206
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 20:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0AD0B23241
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 18:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE58318950F;
	Mon,  9 Sep 2024 18:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yiGKhLwC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m/U+ppRA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AAD183CDB;
	Mon,  9 Sep 2024 18:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725907268; cv=none; b=MWzy193i6aP3CX/+3qkJz+TGq0QTs5LKX2x1lmrhj7LTL4shwqzMyRnfbTqZcLqA+nrbqZrnRGJUsaTQW+HoakqFfIvG86/S9BdoTgkwNgwt6rUW6gio46KOubaXxv17y7RoUiM9fsvh76iQ6IZwq7dwoTIQ5I2P97rIQDimBBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725907268; c=relaxed/simple;
	bh=IMB2ddC2C/+OMulKRxgSAZuiybaAYZky2VdBqbQeSaM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dLw+P92bEvsjUMKWfiQWNVaOIu8jNoJ0kfB01E6y5UiYm3tWycxyJZByQW1Igs/6fVDKxSPR5ywlcR+ofAlQySLoiVfGiItprFvkXt6JPvuyCXLUV2hGW3UaEa0UFqJTkWLC8qTdUOchgJrouhPduaTi8jcskuPiGdD3EZK2qW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yiGKhLwC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m/U+ppRA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725907264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8d/e/WqW+TccWosTKlTnlfl4kTaANpng+iQcmt58tpM=;
	b=yiGKhLwCC6YB6oz+v/4IiyOnG+AnsbURE0O/MSXGENL0HQlrsNh0dn6KCSJ/YbzIpFsQ9T
	MXvV/oFcdPai0QfsN1yUMXEQbfjB+0Evap+0X2zLVlloSn4bF18R8ZPUtm6cEv8z3wNUmJ
	MsUCoOo9ggD4/pZ3vFFU2QbnEw72+Aw6lyegjtyonq1txUTQRC3/TeqKpWtUgNCy82R4we
	Hb6mo0atsEEXQ9+DR3m1/xS6s0CDMA00vCy745uryuJ8erJgH0XczsloW9FLs0Fq4kRu7M
	V55wGl+fYBCEr2iqrGmyNsft7IjDEWq+M+Cu7XFzWkIH/KMsZ+itKCJRMmo85g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725907264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8d/e/WqW+TccWosTKlTnlfl4kTaANpng+iQcmt58tpM=;
	b=m/U+ppRAXpy2kpSpHIBAkC8553tGXUos1+Rewg5P9ArOYaVWy3ywn8F5O2Q4EnQyfRbJD4
	uLAvudLD/bkCKtDQ==
To: Zhen Lei <thunder.leizhen@huawei.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, David Gow
 <davidgow@google.com>, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com
Cc: Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 3/3] debugobjects: Use hlist_cut_number() to optimize
 performance and improve readability
In-Reply-To: <20240904134152.2141-4-thunder.leizhen@huawei.com>
References: <20240904134152.2141-1-thunder.leizhen@huawei.com>
 <20240904134152.2141-4-thunder.leizhen@huawei.com>
Date: Mon, 09 Sep 2024 20:41:04 +0200
Message-ID: <87jzfkbrgf.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Sep 04 2024 at 21:41, Zhen Lei wrote:

> Currently, there are multiple instances where several nodes are extracted
> from one list and added to another list. One by one extraction, and then
> one by one splicing, not only low efficiency, readability is also poor.
> The work can be done well with hlist_cut_number() and hlist_splice_init(),
> which move the entire sublist at once.
>
> When the number of nodes expected to be moved is less than or equal to 0,
> or the source list is empty, hlist_cut_number() safely returns 0. The
> splicing is performed only when the return value of hlist_cut_number() is
> greater than 0.
>
> For two calls to hlist_cut_number() in __free_object(), the result is
> obviously positive, the check of the return value is omitted.

Sure but hlist_cut_number() suffers from the same problem as the current
code. If is a massive cache line chase as you actually have to walk the
list to figure out where to cut it off.

All related functions have this problem and all of this code is very
strict about boundaries. Instead of accurately doing the refill, purge
etc. we should look into proper batch mode mechanisms. Let me think
about it.

Thanks,

        tglx



