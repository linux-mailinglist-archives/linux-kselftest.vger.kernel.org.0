Return-Path: <linux-kselftest+bounces-46282-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE8FC7B63B
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 19:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EF279363658
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 18:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C5C2F1FD2;
	Fri, 21 Nov 2025 18:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="opMSeP94"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B342E8DE3
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 18:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763751229; cv=none; b=F/+jhrJ9Ez4Ajt4ZmduuyWP4McyqYYBgFT8wigI+wDzIzTifQ1KVo0kHOCHDRRCLiXuXEuU8AMLpegmlMbd/nbXQt1r0wzzHGKM+DOdhVMH98+kvJukxcRtlnehu+x3shBSuUmKbWkWxnhv34qnWnwLavBRGMBtSF2q943HDAqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763751229; c=relaxed/simple;
	bh=/gR+DD4YHu60vyg4njZqEWkRUdbqNzFbV6dRSuVF/os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XYubb+oHxAuhdJYB4DtH8QUB7JYfqARjLR3taETsA3YtM+LqFJH7ZV3xALZBnIMNOOvA/d50oit2bAgMbrPAN5eL3L1GboEOp6B0eY5zdTL4IkwyJG/hA2V9DsQ8o+7iRKbh/9h+YmOZURKHjRv4Pc2BhCNG7zfgt8oSnQBFgHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=opMSeP94; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5aee549c-5ae2-45a7-b658-7918d2a918cb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763751214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p8onk54l/YwinE/efiEVhku+RvNWF2uzqhskvQpUYCM=;
	b=opMSeP94T51+vyvAwMHV3MpS5vRx3MrV1l2GLckufWXK6Ie7jT6Nmx3QuYsv4jD4mLl3EA
	DlSntpip7aUOLW9j0iqOjy9n/ARVe+NQ+TEga7BZ3/XlqXWg0dvnWbMRl1KPXOxwxh60ES
	5pfORbC91a4Osqp5uqCqD9NsgjGN+uk=
Date: Fri, 21 Nov 2025 10:53:25 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 0/2] selftests/bpf: networking test cleanups
To: Hoyeon Lee <hoyeon.lee@suse.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Amery Hung <ameryhung@gmail.com>
References: <20251121081332.2309838-1-hoyeon.lee@suse.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20251121081332.2309838-1-hoyeon.lee@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/21/25 12:13 AM, Hoyeon Lee wrote:
> This series finishes the sockaddr_storage migration in the networking
> selftests by removing the remaining open-coded IPv4/IPv6 wrappers
> (addr_port/tuple in cls_redirect, sa46 in select_reuseport). The tests
> now use sockaddr_storage directly. No other custom socket-address
> wrappers remain after this series, so the churn stops here and behavior
> is unchanged.

I added Amery's Reviewed-by. Please keep the tag in the future when the 
newer revision doesn't have major changes.

Applied. Thanks.


