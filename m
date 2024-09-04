Return-Path: <linux-kselftest+bounces-17126-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A7196BE5B
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 15:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CE081F24456
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 13:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AF51E531;
	Wed,  4 Sep 2024 13:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="CWFPRWOv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104F71D9321;
	Wed,  4 Sep 2024 13:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725456237; cv=none; b=hVaNOh+jjpoWlf9hmQ0F6se/qDymUUMbPHJnpqoZpD0NChc46IieHX66hudHjjACwkNd/yhImaZyWGkoVl9Rrxb2bTnTfiV6I6Tdw9x1iWZC5BzlulN+d7IHqeLidxYuxXF+PAgU/e8iT4LWqa27FjVSpnMSvRvpqid1agxPrI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725456237; c=relaxed/simple;
	bh=z/6x6HxIH7lyVMLfedwKLVfYeqbo5dz4ARrxodKWaGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k0qK9hXs+wI+4XlKwH4c7l/8lZNOvz3Dz82CWYptuAq4cviZ3dAPM9famigYzLDs0vZHmjhKFxqL6day3ERP/Xx4Yspej4vWtm920TdgUd2OdzUCQi2EjcCcvApKkmfpKZf13GtvAeG5GrSiuWvh5fl7rlQcnpiuv2US4g67Ctk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=CWFPRWOv; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3NFOAj+YITGbfqpTG/opvnFh0aZiVcPLLOMCI+yzbOk=; b=CWFPRWOvcrBLl2epmgxOBK+14F
	dEQApEgNExEwBZ14+CgbVTnnDQ4K+7BuxBSDUNCmg1ldMcD5BKMBmO4riT2D4v3/qKNGZNNppqtzT
	vEegc936UAvgoK+YXt+NjWTHZYO2FtVT+nb7R58EtCCnXn9VT4fbZFCt+7Ksx3j3XzQkw2oYAdvhm
	HalhWYyKBvlZToyj8t4oyrwwZBL40CCtb8ptWVxggb4iHHCSDstX+jtsgNZY2Xzyco0i78Y1ynVrC
	AUCJthxzO4RdPKfcP1c8VS6BII5N4rEZUEucV8wbBGYii6dSE0bu02rS4WlXAPSb3b5kAPqlg1a76
	unFA51Kg==;
Received: from [177.172.122.98] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1slpyy-009WNA-HT; Wed, 04 Sep 2024 15:23:36 +0200
Message-ID: <63bbeec6-718f-49ad-974d-fb3958bd1564@igalia.com>
Date: Wed, 4 Sep 2024 10:23:26 -0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] selftests/futex: Order calls in futex_requeue
To: Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
 Bill Wendling <morbo@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Shuah Khan <shuah@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Marco Elver <elver@google.com>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Nathan Chancellor <nathan@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Justin Stitt <justinstitt@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Darren Hart <dvhart@infradead.org>, linux-kselftest@vger.kernel.org,
 kernel-team@android.com, Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Davidlohr Bueso <dbueso@suse.de>, llvm@lists.linux.dev,
 John Stultz <jstultz@google.com>
References: <20240903203915.3383774-1-edliaw@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20240903203915.3383774-1-edliaw@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Edward,

Thanks for your patch!

Em 03/09/2024 17:39, Edward Liaw escreveu:
> Similar to fbf4dec70277 ("selftests/futex: Order calls to
> futex_lock_pi"), which fixed a flake in futex_lock_pi due to racing
> between the parent and child threads.
> 
> The same issue can occur in the futex_requeue test, because it expects
> waiterfn to make progress to futex_wait before the parent starts to
> requeue. This is mitigated by the parent sleeping for WAKE_WAIT_US, but
> it still fails occasionally. This can be reproduced by adding a sleep in
> the waiterfn before futex_wait:
> 
> TAP version 13
> 1..2
> not ok 1 futex_requeue simple returned: 0
> not ok 2 futex_requeue simple returned: 0
> not ok 3 futex_requeue many returned: 0
> not ok 4 futex_requeue many returned: 0
> 
> Instead, replace the sleep with barriers to make the sequencing
> explicit.
> 

Reviewed-by: André Almeida <andrealmeid@igalia.com>

