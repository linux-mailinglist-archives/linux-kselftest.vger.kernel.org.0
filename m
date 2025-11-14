Return-Path: <linux-kselftest+bounces-45638-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DA40BC5CBEC
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 12:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9B3F4346174
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 11:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE902E9EA4;
	Fri, 14 Nov 2025 11:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="lkLPNbMw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018F741C71;
	Fri, 14 Nov 2025 11:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763118184; cv=none; b=invPvZEREze2TF/oTnhEmfilbQ5iqLnf5F06lfST0MJ+39Qe0r6LmitWz9jJL+f0jRmFWTiIn148GYZBFz0qmb+nGarf4oBPn0mm4Ps1/9/eiIdlSseB8+u6LIseQQR0jx+hBZig5guLTUYKXbhvH1K52BoL/Ntt/f4PbHvw09U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763118184; c=relaxed/simple;
	bh=Cnd3i8hJwHqxEotTw/L4vO4JD1pf10/yPF9ANPjYXLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OR02mkGrQwrUg32Rmp+oSZuvL0OJUotGY3rgPRwEjML77wBcKxD4s3yDXkAYRPqUYVoem3pUUH1iiJAHDCyTTf1sPuX5i/DIV7zXc2pwQD2Mxm84swV+mFGEoxRvvl12uUU1IGN+RqZhp7csG68o1Bb3RbbYfWYb+DJTPyPN/Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=lkLPNbMw; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gcLv/ZBu75FckasMK9m4dMqsbuzOS/jsXywWPBx65B8=; b=lkLPNbMwhzfNZ4c4N3G21OGTLa
	lisDQzlyY7wDb8fpoovzvvlAX8GeWnh4y7tSbkFRKabrw2aK+UU2fgoJGPcZVZebLP+5uj2u0MMht
	o0Pr3Yx4WG8FM+tFqQgoutcepmaQCV0/E6/KcYCPX32FUYfceSpg9Eou+oXxG085ka0ewUJ6R7hmb
	70KH74yPba2uwvd+q7/FX9W6v0YnN4VuZzZ+HrDHI6BV4N+iJ60f8g1AhGQ43xhnxnh0FNrtbS231
	jgRS9PaqdtdUGETpkDDfKLxiLMM0H9K53GB0C874zVBeVS91uI2pTbCm8SQ1Y4sU12kMxt86UtOpg
	9wV5ZgEQ==;
Received: from [191.8.29.151] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vJrZc-000Q41-3d; Fri, 14 Nov 2025 12:02:35 +0100
Message-ID: <4b0730bc-db62-45a0-a454-507c36be3a3e@igalia.com>
Date: Fri, 14 Nov 2025 08:02:31 -0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] selftests/futex: skip tests if shmget unsupported
To: Carlos Llamas <cmllamas@google.com>
Cc: kernel-team@android.com, Davidlohr Bueso <dave@stgolabs.net>,
 Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Shuah Khan <shuah@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>
References: <20251113204054.3566557-1-cmllamas@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20251113204054.3566557-1-cmllamas@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 13/11/2025 17:40, Carlos Llamas escreveu:
> On systems where the shmget() syscall is not supported, tests like
> anon_page and shared_waitv will fail. Skip these tests in such cases to
> allow the rest of the test suite to run.
> 
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: André Almeida <andrealmeid@igalia.com>

