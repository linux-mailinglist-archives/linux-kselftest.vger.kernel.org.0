Return-Path: <linux-kselftest+bounces-45864-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B62C69A88
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 14:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6F1543506BC
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 13:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A2827B32D;
	Tue, 18 Nov 2025 13:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YOpIZ3S5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899132FFFBF
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 13:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763473526; cv=none; b=rQFrcvrny+Z7o6mZA3yh95TsEStiaYqrsGuzmOeoMB7hxeXgVW11xDKXLpKaUOuXZkBZLjNLCplB+c6JNiRBcyxht4BWcReMePdHBjzZucXl4jzu++XAmgv43oqhnWo/171Pq26zg0gUEI9Vax76ydrLuOxZtmvpqmwzvnTeipU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763473526; c=relaxed/simple;
	bh=w1mWsjOcrsPhjc4R8mAA3gTC71UH37uVKrh/Ni8utEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=X4EJNkaiwZbzl6mQc+2O+IGCyAZxE18+WXCApZv/xESeIc622OGRT6nFkEKcj0LcfSavOrtUkYCXx+gopWrC22s2XVLoT36NDcosFHEypTov0S5uwzNjYMfvYN+d5K1cEwdVuZv1/CSRCD0KW4MTSqGB79trVLGQNd0g6KpsRtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YOpIZ3S5; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dd3d34a0-c5e9-44f0-a813-c972e91b8eb0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763473512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QGKPQF0y5A/yl97OC4p5pS+sRK08oluFnC6kWkR5B3I=;
	b=YOpIZ3S5q0kbPjioWTGJBBU9szS/gtDM082eqwDEsrAeoT1hpU+PzzHC0TiOTxS0XaoC+9
	HBm2yLdFIaNxEXXDwD+tBAlTDey2widJ83jEHb8BIsmJ6yB2qoGaHQrQeHTzJgtyZZDqvE
	u4i3ZQ5gstOPQugl6pX0Xc9Gg+qinPI=
Date: Tue, 18 Nov 2025 13:45:09 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf: Add tests for SHA hash kfuncs
To: Daniel Hodges <git@danielhodges.dev>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:BPF [SELFTESTS] (Test Runners & Infrastructure)"
 <bpf@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20251117211413.1394-1-git@danielhodges.dev>
 <20251117211413.1394-3-git@danielhodges.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251117211413.1394-3-git@danielhodges.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 17/11/2025 21:13, Daniel Hodges wrote:
> Add selftests to validate the SHA-256, SHA-384, and SHA-512 hash kfuncs
> introduced in the BPF crypto subsystem. The tests verify both correct
> functionality and proper error handling.
> 
> Test Data:
> All tests use the well-known NIST test vector input "abc" and validate
> against the standardized expected outputs for each algorithm. This ensures
> the BPF kfunc wrappers correctly delegate to the kernel crypto library.
> 
> Signed-off-by: Daniel Hodges <git@danielhodges.dev>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

