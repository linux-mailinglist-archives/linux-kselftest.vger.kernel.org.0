Return-Path: <linux-kselftest+bounces-41415-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70ACBB55716
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 21:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E2EF567234
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 19:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF40F261B75;
	Fri, 12 Sep 2025 19:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="eyrkoQYz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB33223316;
	Fri, 12 Sep 2025 19:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757706632; cv=none; b=SWs7GOPAdKGDBrxa0Ayl5Na8hYmhrzKTxgOGTPg6jyqCjgFrQVdWj3bQZgpwWxTlK9xCL5frCjtfK5WuyI+FZgBRklX8LoUp5agSxa/G4m8oZeHo0KDLoX3rZ0MSj+AmydPbvLzw8ZOFYH5H1Sz6T2SgA39KvVXuIRJ820w7Wac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757706632; c=relaxed/simple;
	bh=kH0Etfqe/XOlFmBHHKtQDc7N2DneQalsVnpps9l0R6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NOzJjicotDyOnE6j/Zw0yXY6THDnjqXY58xUFGcoalYJ1Ie+LtA/k3jYbT+oHp8s38fJf6RTs9rS0gZQf2W8ILT6QfOH4zUZNGAQIW+oIKzAdeqJlC74QQuPbeBVFI5m4Dmd2skAAPOjG2BPVxx/zyZ5GMkmhqAdPP326glgsHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=eyrkoQYz; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=foQZSa0Fx1zsrk81kKmwxGxx0VIGTxQEN9lw7Ghz9tw=; b=eyrkoQYz2kV7utB6lrjyF0dyVd
	7I9DD7tMFLOIPBUIUCXPSACgxUUMwPICuBr+IGY858ryWSnPDHI1y8EsTCxpUVKlr0tt14OdtJGsY
	t5jih/wqEXtuJ9OAEY7eU7CzNjgumU1BryKC8pf/0Oz+YtdUs7zF4bPFPgZPKQykTlOxd9X8HJVM4
	JyRTfXC4Kaxqv9nL+zKFys+Kb4opjItwUhyNKojGqAmbS298Oyy5wG6lStj+Mj3hyrvkNrANQpFfg
	3LES95Pg6BU0rrqixpcQZrmjlJdCKLl/1eudFr7KxBHC8XwqCcjMYGhv8DItggnRLIHyGaVyOQ2tY
	ocVucTEQ==;
Received: from [191.204.197.103] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1ux9mN-00APet-Gm; Fri, 12 Sep 2025 21:49:55 +0200
Message-ID: <f4eaba67-625b-462f-9b3d-2bfa894b2a93@igalia.com>
Date: Fri, 12 Sep 2025 16:49:51 -0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/futex: Conditionally run futex_numa_mpol test
To: Wake Liu <wakel@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Darren Hart
 <dvhart@infradead.org>, Shuah Khan <shuah@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250908113721.4031242-1-wakel@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20250908113721.4031242-1-wakel@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 08/09/2025 08:37, Wake Liu escreveu:
> The futex_numa_mpol test requires libnuma, which is not available on
> all platforms. When the test is not built, the run.sh script fails
> because it unconditionally tries to execute the test binary.
> 
> Check for the futex_numa_mpol executable before running it. If the
> binary is not present, print a skip message and continue.
> 
> This allows the test suite to run successfully on platforms that do
> not have libnuma and therefore do not build the futex_numa_mpol
> test.
> 
> Signed-off-by: Wake Liu <wakel@google.com>

Reviewed-by: André Almeida <andrealmeid@igalia.com>

