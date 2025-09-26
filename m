Return-Path: <linux-kselftest+bounces-42440-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD065BA28A2
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 08:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FE2C1C2375C
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 06:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2475427E06D;
	Fri, 26 Sep 2025 06:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="n9pzeObF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A334E27C150
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Sep 2025 06:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758868793; cv=none; b=OYi7gIvpUC2hf3ny1WS1EeXs6PWSLloVqWFnqbEiJMme6dtf/0IEwLkLSH3BbFI3B11zQ/2IQ3Uk7aOG2o/muMfAccMfHac4+f0tD+CZTryVhKceyA5Q9XBXSP0y9kxHSdUe/g9V52GPP9BUhCKpRf1eOK3FXc9QHL2h9bFXwg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758868793; c=relaxed/simple;
	bh=Cpbap+PDFOu/VEl1phJ1AaBhj44ckD2ndve8aVh1LpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IEw6b3NNLoDW8k5jsfShjuS6f4rTrdZZgY5Jq3I5B2v+4WXee6Wr42/i5RUH9QS/ZCVT2yuloaZk8OkmOKkc+fDLUI1SxGbwXLahNJ79zFsyKiSLGkfXWe9lls5qEshB6s6TRXpF3pEqudvUtTzNVouTvTyQE4GVE7VmoPBE9N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=n9pzeObF; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 14FD3C003F2;
	Fri, 26 Sep 2025 06:39:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3ED3D606B5;
	Fri, 26 Sep 2025 06:39:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 399E8102F1866;
	Fri, 26 Sep 2025 08:39:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758868781; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=14z+TiK5hRCFldcX29BYnmuev1AbaddAl5M7Wwnpuio=;
	b=n9pzeObFQGhOsimHXI/Q2R5MmFDVYe7YeGAJUjDx9YdIooVqxZIhHuO1nD/e/D5hraeNp0
	4n3HB4/ok//4cT5x1rXCethF0MoQSXvAOTMh3XgJaICaksphflgl2S987lxWSGeBYUALC/
	zGTj31yB5SXNaOJhUi6sDbAFLmyGCaEAY+4X4F9UGTrJ0UiRT0s6HXcfLIdyKhI+yu1Ygz
	Nq6dd9KrpXLOuNRZad4GOY7vJkFHoO9GGg8ElYQArHy8U7aY/S5e6lpduNBGTPG0oNfMpF
	yj+KGv1qTYUPutnWbWxcJ0OtEWNthQSTNTNCEEtgR3DzfJhNeAY6Ur3DelHtOQ==
Message-ID: <fd600cd5-062e-4806-9e8e-b7f6aacad242@bootlin.com>
Date: Fri, 26 Sep 2025 08:39:28 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 04/15] selftests/bpf: test_xsk: fix memory
 leak in testapp_stats_rx_dropped()
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
References: <20250924-xsk-v4-0-20e57537b876@bootlin.com>
 <20250924-xsk-v4-4-20e57537b876@bootlin.com> <aNVEiTJywHNJeEzL@boxer>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <aNVEiTJywHNJeEzL@boxer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Maciej,

On 9/25/25 3:32 PM, Maciej Fijalkowski wrote:
> On Wed, Sep 24, 2025 at 04:49:39PM +0200, Bastien Curutchet (eBPF Foundation) wrote:
>> testapp_stats_rx_dropped() generates pkt_stream twice. The last
>> generated is released by pkt_stream_restore_default() at the end of the
>> test but we lose the pointer of the first pkt_stream.
>>
>> Release the 'middle' pkt_stream when it's getting replaced to prevent
>> memory leaks.
>>
>> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
>> ---
>>   tools/testing/selftests/bpf/test_xsk.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing/selftests/bpf/test_xsk.c
>> index 8d7c38eb32ca3537cb019f120c3350ebd9f8c6bc..eb18288ea1e4aa1c9337d16333b7174ecaed0999 100644
>> --- a/tools/testing/selftests/bpf/test_xsk.c
>> +++ b/tools/testing/selftests/bpf/test_xsk.c
>> @@ -536,6 +536,13 @@ static void pkt_stream_receive_half(struct test_spec *test)
>>   	struct pkt_stream *pkt_stream = test->ifobj_tx->xsk->pkt_stream;
>>   	u32 i;
>>   
>> +	if (test->ifobj_rx->xsk->pkt_stream != test->rx_pkt_stream_default)
>> +		/* Packet stream has already been replaced so we have to release this one.
>> +		 * The newly created one will be freed by the restore_default() at the
>> +		 * end of the test
>> +		 */
>> +		pkt_stream_delete(test->ifobj_rx->xsk->pkt_stream);
> 
> I don't see why this one is not addressed within test case
> (testapp_stats_rx_dropped()) and other fix is (testapp_xdp_shared_umem()).
> 

pkt_stream_receive_half() can be used by other tests. I thought it would 
be more convenient for people writing testapp_*() functions if they 
didn't have to worry about releasing these kind of pointer themselves.

The same approach can't be used in testapp_xdp_shared_umem(), because we 
need to wait for the test to complete before releasing the pointers.


-- 
Bastien Curutchet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


