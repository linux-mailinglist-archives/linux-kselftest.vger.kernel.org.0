Return-Path: <linux-kselftest+bounces-44491-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 543D2C23494
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 06:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C51C434D2E2
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 05:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209AD1E25F9;
	Fri, 31 Oct 2025 05:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dfIE5cT5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0D9AD4B
	for <linux-kselftest@vger.kernel.org>; Fri, 31 Oct 2025 05:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761888131; cv=none; b=I2XP5Kh7OuJbHAU135U+aqSNqwZNnl6J1Q8cD6ngOzwoGVzMRFIt/GpPJfeKf4SJVHGG2hkwprl0kvi9KVE/9hG8zHBvl5VSl5DG2aUc/2M1dmZk/PRMt1CJ2kJbvmexr1GkM5SrYfKOZpySd972hrzSffjOyxTpvefcROESGbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761888131; c=relaxed/simple;
	bh=fA5TQ0hqll+fs0L3PVcf+H2osXI7NzoXFI92inedJ/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L592YBDfYiGBVeIKVT6uez00kjq5b3ftj43KTOQWTNI6SmrkP3+SY16tB8y37MmP3f9c0x/QJ4iQ8xBFbu2iP00/7lGuFFbk2rS5Ulk0MkVCxAYh6l6ZGIcIl1hEDZG9++vgZOl7jGSD8Yu/SnlMg/fP7GLvvVknd1gwKtZk9Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dfIE5cT5; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2926ee64-8a82-4baa-bc6f-f81d1beb6833@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761888124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MRbZ51hguhYVPoRsdSGy0WiPypFJNA22EaihYHkBG6s=;
	b=dfIE5cT5SXWht4wneK0rWLXoH722bhZGSfSYJjow4siEnSTSXGEJAQOT/KwLOfViXf140g
	zsov52xN2Yc4xxcYeetl9Y7/tR/LyZxm3aTcF+Mp2tj9Ynq+QKUIxIoY6wcwhQOcs9tc/w
	mNr6ntEsY5JUwNlfc9qU4QQXWMDQzxk=
Date: Thu, 30 Oct 2025 22:21:46 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] bpftool: Print map ID upon creation and support
 JSON output
Content-Language: en-GB
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 bpf@vger.kernel.org
Cc: alan.maguire@oracle.com, Quentin Monnet <qmo@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20251030210655.3938262-1-harshit.m.mogalapalli@oracle.com>
 <20251030210655.3938262-2-harshit.m.mogalapalli@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251030210655.3938262-2-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 10/30/25 2:06 PM, Harshit Mogalapalli wrote:
> It is useful to print map ID on successful creation.
>
> JSON case:
> $ ./bpftool -j map create /sys/fs/bpf/test_map4 type hash key 4 value 8 entries 128 name map4
> {"id":12}
>
> Generic case:
> $ ./bpftool  map create /sys/fs/bpf/test_map5 type hash key 4 value 8 entries 128 name map5
> Map successfully created with ID: 15
>
> Bpftool Issue: https://github.com/libbpf/bpftool/issues/121
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


