Return-Path: <linux-kselftest+bounces-41732-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2B6B80995
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 17:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA3F86236BB
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 15:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC005333A87;
	Wed, 17 Sep 2025 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Fbq2AHxG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9511369B4;
	Wed, 17 Sep 2025 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123184; cv=none; b=Pvmwd8jrvgnqWCsseJ43bUzhDIR73KrnKwKOhjB7EFklknTjAUM+U6tR4/Lf0jHtB/q5el2l29FOkGvwViZWHlbL75LK5b5DURUcoWgj4be0Mf3LTOLTjPOaYs1Gvu0X2L5aiM/gCp1+D6DDZrSCgxgD3XnDqvnH5EqA0cOTNsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123184; c=relaxed/simple;
	bh=Hc351q4nYxBtizLPpdMYPsra/T/ADj1HoY+Za3zpojg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GTtWW73ZQKHtoazL92kYnGic9eMb9cA7NH0/n0RbTiECoHCPItp1J2pT/UFbK7VR9/2WdM0n9plVyvZ0Q4Df74e4pzyfH9dVahmTH0QRLL6rni9LxV+C5hqHcpNsmiL5LOYk+Fl9Q9g8KVG4bP7MxzKZ/4PtZNsIU3sGnMsCZoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Fbq2AHxG; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5878A1A0E8F;
	Wed, 17 Sep 2025 15:33:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2A93D6063E;
	Wed, 17 Sep 2025 15:33:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 36D80102F1BF4;
	Wed, 17 Sep 2025 17:32:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758123180; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=KvBFi2h1uOxbQSe3Qg7pMz9oi1pLN3OKIQs0ZmF1Qzk=;
	b=Fbq2AHxGtY47IIcSa4Culc0rQoPlBe6J/KabnGGAnkRHAImzIyRedtbsPZLnBcuH928DBF
	zqdZk+la6iUXkeNOEFqwVW2en9mAgIB+TjRSRQcwum+LM48/+2zWzuAm0zW+U/WE3Niskn
	sLrFBtXum9AmBL6yoAP5mHAHQPaBz30jp7tKLyaGBDwTSXJo/iQ1fG7WA51k2/xJPCwqg2
	LFLMZgY9FO2gSSfsWGmPDgf+XJKxnHnLVi90kOzUGCGI24PrcDtW52tX6mCRKLZTW6/WTm
	sEUV2z180ESgNff9cRCU+VULMjFt7a+91OrnBMr4zfIdF1KAExOCtcm3kgV5mg==
Message-ID: <6ac21f07-45ef-4e80-bedf-c0470df47bc7@bootlin.com>
Date: Wed, 17 Sep 2025 17:32:55 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 03/14] selftests/bpf: test_xsk: Fix memory
 leaks
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Alexis Lothore <alexis.lothore@bootlin.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250904-xsk-v3-0-ce382e331485@bootlin.com>
 <20250904-xsk-v3-3-ce382e331485@bootlin.com> <aMmlNc1z5ULnOjJY@boxer>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <aMmlNc1z5ULnOjJY@boxer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Maciej

On 9/16/25 7:58 PM, Maciej Fijalkowski wrote:
> On Thu, Sep 04, 2025 at 12:10:18PM +0200, Bastien Curutchet (eBPF Foundation) wrote:
>> Some tests introduce memory leaks by not freeing all the pkt_stream
>> objects they're creating.
>>
>> Fix these memory leaks.
> 
> I would appreciate being more explicit here as I've been scratching my
> head here.
> 

Indeed it lacks details sorry. IIRC I spotted these with valgrind, maybe 
I can add valgrind's output to the commit log in next iteration.

>  From what I see the problem is with testapp_stats_rx_dropped() as it's the
> one case that uses replace and receive half of pkt streams, both of which
> overwrite the default pkt stream. So we lose a pointer to one of pkt
> streams and leak it eventually.
> 

Exactly, we lose pointers in some cases when xsk->pkt_stream gets 
replaced by a new stream. testapp_stats_rx_dropped() is the most 
convoluted of these cases.

Best regards,
-- 
Bastien Curutchet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


