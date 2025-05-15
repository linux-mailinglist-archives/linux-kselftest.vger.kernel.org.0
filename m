Return-Path: <linux-kselftest+bounces-33080-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE97AB8447
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 12:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28A03BB6CA
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 10:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9BB22D9EA;
	Thu, 15 May 2025 10:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="rSbTnGeO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01A92101AE;
	Thu, 15 May 2025 10:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747306174; cv=none; b=j1r2BfA2m0sf/plJR6nkHQ4JW2ZJAEJ+MuANn2Z4auwdLXTN928VeRfO+KTgpBTiNHoDU+sRkDLz7cDDtWFepyr/dFazS6SaE/WcAUbEnW1zC9FDQVxN3peFIPNp839xyVcR7i+AlUx/UYv/KirelTUf7XlNMH2MeDGvmg9Brfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747306174; c=relaxed/simple;
	bh=tFsaYwqq/XOzOdN/T6tvc0f3OJ5+Koygucog5fYi5MM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DJjWHmkbcVSJlu9dQ6eR8v7sPNECFe5L10jsgIFP6aqn0Sd3gPST1ljbe12LVkUqBC2nUbaGcR3TY0n6V7EYFj1uEapmHRi2dkChTQmes88YE8MSw1SUIkW0hIkEuIO++4oStQ0MB21tW+VEDOGaiseyLAvIZOGyKqoyR5xJuyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=rSbTnGeO; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uFW9R-003Sxf-5e; Thu, 15 May 2025 12:49:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=V6U6TgHHp/PrCB7JP5WcdZvqqmCnTPEWOC9eHJ6fj7g=; b=rSbTnGeOXgUUZBXM8rnA+9aHVC
	CSmRTGuKx/AjREk3ptDoi8ce4/ca0+IsQCpOJBsMLp4XwtIz49eYXWP1ZTy+yFPJTxApv0LpjNfGT
	RpgZaSo/yCMcbnQbI1ecLwlwOYEvtvLvn2J8Z3bfWf1KicGz/EoE2Ll4Z9eRAGO+z+OrA6MiOvQ1e
	EjoeCGvslArs21ree5Nhd4eUqWnACocdgg/vBlQvp11l8fVDosoJPhpfGa6+XDWzYBTX2xQISP+0N
	/T9snvZJm07zovXMVlB+jP+fua4ntxwJT3h8G/YmZ+X8y3dHS/rRMzAxJ053DdamXJO9G8lOCd6QE
	bUlqYSIg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uFW9Q-0004ip-56; Thu, 15 May 2025 12:49:20 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uFW9F-008WYe-MC; Thu, 15 May 2025 12:49:09 +0200
Message-ID: <069def19-1a77-4677-9bc9-70a44215cd05@rbox.co>
Date: Thu, 15 May 2025 12:49:08 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 4/8] selftests/bpf: Introduce verdict programs
 for sockmap_redir
To: John Fastabend <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jakub Sitnicki <jakub@cloudflare.com>,
 Jiayuan Chen <mrpre@163.com>
References: <20250515-selftests-sockmap-redir-v3-0-a1ea723f7e7e@rbox.co>
 <20250515-selftests-sockmap-redir-v3-4-a1ea723f7e7e@rbox.co>
 <20250515042900.5dox2mozx455tekm@gmail.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <20250515042900.5dox2mozx455tekm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/15/25 06:29, John Fastabend wrote:
> On 2025-05-15 00:15:27, Michal Luczaj wrote:
>> Instead of piggybacking on test_sockmap_listen, introduce
>> test_sockmap_redir especially for sockmap redirection tests.
>>
>> Suggested-by: Jiayuan Chen <mrpre@163.com>
>> Acked-by: John Fastabend <john.fastabend@gmail.com>
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> ---
> 
> LGTM, this is a net new patch in v3 though correct? In the future
> only carry the Acks into patches that are from the previous version
> and not substantially changed.

Will do, sorry.

Note that I wasn't being sneaky, I asked about it in the cover letter :)

Thanks,
Michal

> All the same thanks for doing this. For this patch.
> 
> Acked-by: John Fastabend <john.fastabend@gmail.com>


