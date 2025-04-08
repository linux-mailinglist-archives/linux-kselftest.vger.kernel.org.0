Return-Path: <linux-kselftest+bounces-30363-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D33BA80DC2
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 16:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68A5C4E1861
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 14:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C361D79A3;
	Tue,  8 Apr 2025 14:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ReOsdXO+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136581E4929;
	Tue,  8 Apr 2025 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744122076; cv=none; b=BtpVQpwv3uYuhC2nzxIRxFEo2UOTrPosmq65dkR4xjQgY4KNoA9pdyux1KmQfF4XAsDo6Z9wni+NQnGwSrD0MRC46Kcf9vfUV/43EA3UqYfSLVlXF9gJIASsFz16cFXYUcMlhcSp7TJfBKOBwW78fEpEf5+yHpzwKE+ak2tU1FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744122076; c=relaxed/simple;
	bh=FXvpcnjh4KW/Iak+N9xM6BGXxzODihNocBL7PxMwEsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gO4KkNR/T91v8lzS61/Sv/LlLJ/11XbxHn8SyYKHjglHZupKk4MvOZGb16yujYliLj8pBU0mhqDDqZkFakFn2oKboC+lYGVQH6AVBbA/cAvDSMnSYMFdvpd1FgFLU2/QZQ5be65AGOyw2n4nVjatKd6oSge5VAsEV3p1UhazWcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ReOsdXO+; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YosJInAbT4fDD/KwRyqL6BKmxeFbvN+2LjbD48SXxxo=; b=ReOsdXO+GtMDld1mD7ycasIHZs
	/ytnQX4loth8sLfo/HcN43i0ljj1ih+XlY6mgxcQ65CB1ezYW3likeRgDZvW6cpeQNdM0kzBxZMEG
	5CQJs9AOoJMSGg2o8xjGiSNZVj+jsUUgw+gfezKMG2CCROjNK03Sj047rc5n1/17tkqylO5gpQG6X
	HlCWiY6DtnrQZgoTzVoCIdQ1qyKGvfuYI1Vpl4/lIM75BVv1GOLAZF3lkmd7Z99Z51fnHbt+FA9yi
	HR+Nr+MFOgb3AJoZLqw4fPoxtx6MgpBCFMvoeilHoa3JErF5vTpp3nxepkZ+nIkurZZ6rRzri6zOj
	dsVx6NfA==;
Received: from [187.57.129.172] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1u29p7-00DLZb-PL; Tue, 08 Apr 2025 16:21:10 +0200
Message-ID: <2b254cf0-7b55-4db6-a80c-e81377405fde@igalia.com>
Date: Tue, 8 Apr 2025 11:21:05 -0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/futex: futex_waitv wouldblock test should fail
To: Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Darren Hart <dvhart@infradead.org>, linux-kselftest@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 kernel-team@android.com, Davidlohr Bueso <dave@stgolabs.net>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20250404221225.1596324-1-edliaw@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20250404221225.1596324-1-edliaw@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thank you Edward,

Em 04/04/2025 19:12, Edward Liaw escreveu:
> Testcase should fail if -EWOULDBLOCK is not returned when expected value
> differs from actual value from the waiter.
> 
> Fixes: 9d57f7c79748920636f8293d2f01192d702fe390 ("selftests: futex: Test sys_futex_waitv() wouldblock")
> Signed-off-by: Edward Liaw <edliaw@google.com>

Reviewed-by: André Almeida <andrealmeid@igalia.com>

