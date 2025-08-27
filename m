Return-Path: <linux-kselftest+bounces-40048-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1359AB38072
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 13:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38B371BA5E1B
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 11:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FD12D12EF;
	Wed, 27 Aug 2025 11:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E4v1qubR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U8TFjCj/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6825630DECF;
	Wed, 27 Aug 2025 11:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756292415; cv=none; b=STWQnzgQDvjHena8ZvgsnXsTGB7zxrl8GSTQEqO8KnnAjECSJCHrN6jMURfHQxS+keFXagOCl2zVWelknTz1Q9fuS7EIg2jClRoy50r3o/kz76VVTKg24blA0XnldPNjfw4o1VgdTyVLynAipdPbJFIfC26DeAq133yrq8lSbRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756292415; c=relaxed/simple;
	bh=089uvcPzKEMjllQfZC9ze5HF4s61d3lApct5f3CcAVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKBHugkYwQinlYIyZumxUlCHm1NaVv8flK33Xk/QT1Pj4nI0brG/RbnQB7ewJ4LaNkrr0AYwQGi3bC1kB9X5JhJlHmNDVmAVmIp28Mym9ZhSFCA3VwMPJ+k2eDI0Pfouy5g6GYiZFagSD165t6Q2Tz/ot9P/VS3VJoJ9zRvYXzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E4v1qubR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U8TFjCj/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 27 Aug 2025 13:00:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756292410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N7Pjc2TaTel/23f5s8SPnvNOw2jZdg7VRa902XINe/Y=;
	b=E4v1qubRYMYwkK4/AZdUy9rzDhRE9JkUOMtTv5TmHv7mLe9FsEKdSLe1ZjdXEUWpyLI8Nx
	ZzKOXsGMQhqbTdTT0N4/LT2nMwkZgLXxMdnMxxREu47/+Ls3MEhKI7Fb9MijbbYJHty3YE
	ZhpAP3/z6glnNSopiAIWGHQXfGq6927I7qFTnZ8h9n5z6OWpuTmvuCIzsIW8S6t8ILoGiQ
	40GkQsfAl36ysXBwAkosf0vH6JwVAHcZ7w9AzPr+1vAw3RBYcP4enkTAy7ir6mnIjvHwdW
	ItbF7H5H4QjD2JOnyxLGLHzE1KvG23NNcWIr2ZZxOvaKaph7lnOzNcaA/QJtxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756292410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N7Pjc2TaTel/23f5s8SPnvNOw2jZdg7VRa902XINe/Y=;
	b=U8TFjCj/Gd3JWBpo5tqKnTYOiZGM/WASjwFoe9mF31X9n5uSr463yIYSjBLcm1NSdI9NMe
	K4uL+fLUJLOU5MBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: bhanuseshukumar <bhanuseshukumar@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, shuah@kernel.org,
	peterz@infradead.org, dvhart@infradead.org, dave@stgolabs.net,
	andrealmeid@igalia.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	colin.i.king@gmail.com
Subject: Re: [PATCH v2] selftests: futex; Fix spelling in test messages
Message-ID: <20250827110009.H96ue6JM@linutronix.de>
References: <20250827105639.19156-1-bhanuseshukumar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250827105639.19156-1-bhanuseshukumar@gmail.com>

On 2025-08-27 16:26:39 [+0530], bhanuseshukumar wrote:
>     Correct few spelling mistakes in selftest output messages to improve
>     readability
> 
> Signed-off-by: bhanuseshukumar <bhanuseshukumar@gmail.com>

I am picking up patches and this got already fixed.

Sebastian

