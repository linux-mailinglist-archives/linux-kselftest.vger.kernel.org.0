Return-Path: <linux-kselftest+bounces-36004-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E46E0AEC0CF
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 22:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C60564F43
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 20:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FEA21ADA3;
	Fri, 27 Jun 2025 20:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="PgigF6B0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103C8C2FB;
	Fri, 27 Jun 2025 20:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751055817; cv=none; b=HZjInVjr0UHBK0/zB7Qo2DzCHPKATZ8zCuTOIHuA90r5qoLfNk+eFgDUHIuWBfZ2dRcZt7hdL7unoGatbTWjFSHJV9847UGVxxSyFlSOUSRJofR8eXyWSch6qwLDSVMWfLtUijGoGy8C6cGdxj3iXafi46M08OT/TT74ba6v7Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751055817; c=relaxed/simple;
	bh=8LRAvUFeTwmz4rDd900x+Z+XteT5wGFcJVnT+hGaLP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h3ReBkcaFyx0OS0n5PUmlfN73VlbtJEdBYwYPObiIYOtaVXVFEzNJyYyhJCV2JasNXRz5eW3TrWcCcgX+40c6mMe1a40YL+cOZNowhmeUb1ZYAmCfFvjmOTn32M5DaVI1gFx6GrjZryyoPU1rSbW15hNJI3v1ZAwPAWXH1fCFgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=PgigF6B0; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LNuHdZp1p8Oowbp9pqTlemJ4dhvpEIex6NkU/PUOyGM=; b=PgigF6B0mR7Bk3asa15fereY3a
	LPqE/FIBEXopIv4s9QCLrpfaYUBgKU1u89vGKeK1muVH7XyHMxbqcQsGG2tS2YrSlQ1uHKiFWBQEz
	Lr/2r9vFkbEvN0Xv/FYTMn4jCq9aCt2/oLa6gNJjtS2ZChMJNe8/S8m2QWzBrou4fAH4Ckyq127dp
	tj0V8qFApRZZcxf5YQn2Q9uV1KnKj47ndCt9zpnmIylfOSfIRxx/LNeoDzL/a+dLMHTexTdZsIBNd
	+4NjBh6x0TVn5T3yxmTcpMY8SqOr555P/xg7x87szaSOqTug4SXO2VZua01RaYpX5c5RbgEUHUhO6
	4JV762+g==;
Received: from [191.204.192.64] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uVFbI-009XtB-C6; Fri, 27 Jun 2025 22:23:08 +0200
Message-ID: <96b3d0fa-7fd2-4d2b-a6d6-cc91ed1dca4e@igalia.com>
Date: Fri, 27 Jun 2025 17:23:03 -0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] selftests/futex: Add ASSERT_ macros
To: Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Peter Zijlstra
 <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-api@vger.kernel.org, kernel-dev@igalia.com,
 Darren Hart <dvhart@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Waiman Long <longman@redhat.com>
References: <20250626-tonyk-robust_futex-v5-0-179194dbde8f@igalia.com>
 <20250626-tonyk-robust_futex-v5-1-179194dbde8f@igalia.com>
 <87ecv6p364.ffs@tglx>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <87ecv6p364.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 26/06/2025 19:07, Thomas Gleixner escreveu:
> On Thu, Jun 26 2025 at 14:11, André Almeida wrote:
> 
>> Create ASSERT_{EQ, NE, TRUE, FALSE} macros to make test creation easier.
> 
> What's so futex special about this that it can't use the same muck in
> 
> tools/testing/selftests/kselftest_harness.h
> 

My previous version of this test used kselftest_harness.h, but Shuah 
request to keep consistency and don't use this header, giving that the 
rest of futex test doesn't use it:

https://lore.kernel.org/lkml/fe02f42b-7ba8-4a3b-a86c-2a4a7942fd3b@linuxfoundation.org/

> or at least share the implementation in some way?
> 
> Thanks,
> 
>          tglx


