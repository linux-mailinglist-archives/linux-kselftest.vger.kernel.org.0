Return-Path: <linux-kselftest+bounces-46010-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA77EC70495
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 18:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 8F1732F211
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 17:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAF9364E9D;
	Wed, 19 Nov 2025 16:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rAtBzfyP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A18A364027
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 16:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763571530; cv=none; b=UhC/mGUNNIOGZtBYNm3hcTCdBFcNT+GijJOVcGE5lxnJL+7P8UMIKwa8sCqPRcossEOilfuC3vL2Ro7eAX5NakXdVfs2zvbZZ/zBK2wKQLULnifYKYp4JMdQj6bgvrzZ5tCGysfPbe/4GK2QnOvPyNZ1s+OywHUQrtCS1+J7ZVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763571530; c=relaxed/simple;
	bh=eiGS+x24M0vUaaZR2W+48F4LZdd9/vvmdy3L2LaHIiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KWK/l2+F6d0TyAh9D+b0WM1WNhsY25PA2x3sFqo3OInJmu2TTwK/uiAiKwMrZUCPSOGXVCxIxfO+sXOCIDNT3mmAra81mF1jZpv264PMJnssRIIiGXoy9Bi9dOyVFp/7eZmC/HwdJ0i7qUTTAlCMvm8f2ZYYr/0QTOpLqK9peWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rAtBzfyP; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8edc1bae-8a28-4d8b-bf52-249bea05537f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763571513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lv4CTLyeccPuS8dft5xHIpzhHPS08XwFHFC7fRT/dUg=;
	b=rAtBzfyPNXLqYrN2R4z3dREOJW4kAipYVDNEk68txV7ymN86eAy72JoSzDoEq/hclgAHOv
	iP5yvC5fPbuSn9EUDcQIh+MIjgj/WAiNWwlY7x5QdO4rJtXWL+m3KGRmkDu05d9o16kOkb
	v+m24yEQt1IlnbsUjNcu+F89ypi2zxU=
Date: Wed, 19 Nov 2025 08:57:47 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [bpf-next v1 1/5] selftests/bpf: use sockaddr_storage instead of
 addr_port in cls_redirect test
To: Hoyeon Lee <hoyeon.lee@suse.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20251115225550.1086693-1-hoyeon.lee@suse.com>
 <20251115225550.1086693-2-hoyeon.lee@suse.com>
 <9ed9de08-9a5b-4fc9-9213-ca918dafea0b@linux.dev>
 <CAK7-dKbxgFqw8cjfw3oWvZCQat=UKUq7u4zU+nx4xw-g5m4n_Q@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAK7-dKbxgFqw8cjfw3oWvZCQat=UKUq7u4zU+nx4xw-g5m4n_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/18/25 7:09 PM, Hoyeon Lee wrote:
> For the “family” field, agreed. ss_family is sufficient, and the tuple
> wrapper can be removed. If you're okay with that direction, I can drop
> the family field and resend patches 1 and 2 with that cleanup applied.

Please re-spin patch 1 and 2 with the 'struct tuple' cleanup. The 
patch's title should have "PATCH bpf-next v???". Take a look at other 
patches posted in the mailing list.

