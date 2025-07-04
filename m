Return-Path: <linux-kselftest+bounces-36596-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DD2AF9745
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 17:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A6DC1BC7BC3
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 15:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668701DE2D8;
	Fri,  4 Jul 2025 15:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="CqgD6mLf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4478E4501A;
	Fri,  4 Jul 2025 15:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751644190; cv=none; b=I1+It0Xh4iu3QSsGWEHKV571QSv2LIK7iH6j/p7GvpczSdxJdqG475MV7PuVTJjUhwAaV9J2/fa7hgsMQZePcaFdbxhyOAVfmFPXa2S5qKjklhverswGx0E481VTQbvYDHS5cr8rLhB9uyrD4ESUTCcZy/3ldzKWuk6TzBzdgE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751644190; c=relaxed/simple;
	bh=vPs2F2ZJUdLH88YYwUGJUiwQkRzfw0gyOT12ZIqjTJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JntVV7TQiCQmU7vNtc4GY48+cgpJ4EAN37mDduSV39WYENJiSlccGRYNr0mMKJgnGP67WQBX9E/ulcDTSNZnVswdaAI+wWMW1Y4azFQeJQUPHOggUnCOKegnnl8qfT5QcVoebWHHPdK5FW3vB1Y/AKWP5ewoSZ1Y5neTI1c4CJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=CqgD6mLf; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+AMZ30LNlP2Z2bZ8j41BcwAp6IeuatrbCsARCkcU0Nk=; b=CqgD6mLf8lrEGXCyT+ebBjqzH3
	kmQ8ny09RpVQ8RSMA0ohQd/HGc0npvDbpbMufNL4xTKynHcJUytWmkt4wBEx7ABV7/iNuXR3NTxRm
	XgsjkklwSo1L5ezxEghOnTpUFDw4asXZdovrbNuJnfV/hwgyTXkEeoOFV4bS5W/m+R4+/oFr85SmI
	DvRywf573MJygv4Yk9cqNNHEC09DD8vVf24eHJC322BwZG6E1ZRvZ/DxBu8/AsLFzTb81w1LcqAin
	SpNlcBYMFdjmbh4oNYHVQf+Jm/wE/PztqiiwyhTUybeuZB0Ir2Ef6a97cFupnOPqLzaQ8YSR/5MeY
	77cvrfKA==;
Received: from [179.100.5.63] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uXifU-00CUNA-W9; Fri, 04 Jul 2025 17:49:41 +0200
Message-ID: <61f90ebf-3cb4-4e81-a7d7-cfffe41d9d47@igalia.com>
Date: Fri, 4 Jul 2025 12:49:36 -0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] selftests/futex: Convert 32bit timespec struct to
 64bit version for 32bit compatibility mode
To: Terry Tritton <terry.tritton@linaro.org>
Cc: ttritton@google.com, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, linux-kselftest@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>,
 linux-kernel@vger.kernel.org, Wei Gao <wegao@suse.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Shuah Khan <shuah@kernel.org>
References: <20250704103521.10124-1-terry.tritton@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20250704103521.10124-1-terry.tritton@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Terry

Em 04/07/2025 07:35, Terry Tritton escreveu:
> sys_futex_wait() can not accept old_timespec32 struct, so userspace should
> convert it from 32bit to 64bit before syscall to support 32bit compatible mode.
> 
> This fix is based off [1]
> 
> Link: https://lore.kernel.org/all/20231203235117.29677-1-wegao@suse.com/ [1]
> 
> Originally-by: Wei Gao <wegao@suse.com>
> Signed-off-by: Terry Tritton <terry.tritton@linaro.org>
> ---

Thanks! It fixes the test when compiling with -m32.

However, please check the results ./scripts/checkpatch.pl, there are a 
lot of codestyle errors:

ERROR: trailing whitespace
#37: FILE: tools/testing/selftests/futex/include/futex2test.h:69:
+        struct __kernel_timespec ts = { $

ERROR: code indent should use tabs where possible
#37: FILE: tools/testing/selftests/futex/include/futex2test.h:69:
+        struct __kernel_timespec ts = { $

WARNING: please, no spaces at the start of a line
#37: FILE: tools/testing/selftests/futex/include/futex2test.h:69:
+        struct __kernel_timespec ts = { $

ERROR: trailing whitespace
#38: FILE: tools/testing/selftests/futex/include/futex2test.h:70:
+                .tv_sec = timo->tv_sec, $

ERROR: code indent should use tabs where possible
#38: FILE: tools/testing/selftests/futex/include/futex2test.h:70:
+                .tv_sec = timo->tv_sec, $

...



