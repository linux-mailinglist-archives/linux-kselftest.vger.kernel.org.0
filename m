Return-Path: <linux-kselftest+bounces-6070-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A3C875988
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 22:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB90F287E3C
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 21:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698A313BAD4;
	Thu,  7 Mar 2024 21:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UQzXnYIz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="knW+paWE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937C313B78E;
	Thu,  7 Mar 2024 21:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709847709; cv=none; b=qk+PbrgcU+DQhYsCPzzppp+T18M+SFziCMxrCK+BYuk8a9YvuyRLLGnzn7ifBpq8ZGCEKZMspca1Uhk4fPKWt6oGytgqx30rZZOQwGHCMFchE5/Sul7nmqD9F6193rPkI0Ctbn/8BuEh+g7ogkxusQ5gFOysHHR615nXuiHn8AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709847709; c=relaxed/simple;
	bh=Ixjm4nogiJUTLij26+s0DiDuO1CPi3hMpAyv44LmmnE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f3JryxPXJSSrN486SAXzhKzdIYiO5Dx9Wxh7dt6Deh3rhxlqOvpyc67eot3YCZf3qbeXnTcyqjDZYxj494lwAI4zTmZnyFvqwkrDsa5xWYEAOC47yXMoscXp65rAeByXvz0Hthnm0U0iL3dDI/FLX9UGfFp5I+g/Qx2kERI1UVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UQzXnYIz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=knW+paWE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709847705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J51bn/MPhKLiZqSjNkAxCTWUpQFJFjHDJr9fKKbMhp0=;
	b=UQzXnYIzkAJ2aqDQSAgryDMY5BJr8EcjwW5B/9LnB/9o91DGEt4qpbkPqoGG+nnuliym4k
	nl9c38y4oNzcn7uYVxTKy+3ll1cApvrcTJmUd27LHOXDD1ZG5PnHwPSRWqkLbZLGUs1ML8
	dc64MFdpigLQTiODM9Hqu3mOWjzP47aboNLbjT/fQvHlOHFmn+FIktKGw9qGQMv4NzDItp
	A8i1EUW6acUqy+sua1MBbZAaFkzjn6mQNmPyyBrjbro9V/YUx4uZTJpcVOvJPu8DI4ycc1
	wncLHtMqSxwYdNY3E/reHrbNTGVYER0FLu2YLj4qgWHAA9KiiHz6xZw6yc3CyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709847705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J51bn/MPhKLiZqSjNkAxCTWUpQFJFjHDJr9fKKbMhp0=;
	b=knW+paWE5plI07hXNEzINK2ZSPt6u4IAitFFEKbadFHNuAY3yu0pczoLSWLBa/y9nXJ3Fd
	4CUNBm9+GVuILaBg==
To: Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>, Stephen
 Boyd <sboyd@kernel.org>, Shuah Khan <shuah@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill
 Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-kselftest@vger.kernel.org, kernel-team@android.com,
 llvm@lists.linux.dev
Subject: Re: [PATCH v1 0/3] selftests/timers/posix_timers: various cleanups
In-Reply-To: <CAG4es9XXYzzrt3-eybtXZ2Cy9fTtEPiCbggDxPcaRY=fiKM78A@mail.gmail.com>
References: <20240304181140.644212-1-edliaw@google.com>
 <87bk7pu51w.ffs@tglx>
 <CAG4es9XXYzzrt3-eybtXZ2Cy9fTtEPiCbggDxPcaRY=fiKM78A@mail.gmail.com>
Date: Thu, 07 Mar 2024 22:41:45 +0100
Message-ID: <87sf11sorq.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Mar 07 2024 at 13:34, Edward Liaw wrote:
>> Thanks for picking those up and moving them forward. Any particular
>> reason why you didn't pick up the full set?
>
> I didn't know enough about the code to resolve some of the merges in the
> full set.  I had run into the issue with the test timer_distribution test
> hanging on the Android kernel and wanted to get that fixed first.

Fair enough. I've marked your series for my post merge window tree and
I'll have a look at the rest of the pile.

Thanks,

        tglx


