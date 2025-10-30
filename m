Return-Path: <linux-kselftest+bounces-44390-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DA8C1EE7F
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 09:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5B2E400430
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 08:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE61A338F24;
	Thu, 30 Oct 2025 08:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jlsLX77L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775522D94BB
	for <linux-kselftest@vger.kernel.org>; Thu, 30 Oct 2025 08:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761811570; cv=none; b=cNAuedGXnjO4/PnajJC+y2hvvwH6TPwGne+GXw0WmvFhH8K6DjvE/P8X4/hCkovzXv8t8zpgYt0ww1aTgNiNDMf/czBHLdZw9stzgw2+jFFtI1EVvQ6Z7skhSCuQO3SS/IEJKGlaS+rXV0G4plnp+jXIDGicI+wCZzouErMX0PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761811570; c=relaxed/simple;
	bh=Op1t4LLfAXhJLesSQQ0Zr9Tb4KUF5kV6yD/hPL9PUSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E+/tWt1xpf4L5FmZMTW9VqH+N9j8mvZZU+b+p5iasefFVls6dQJmdZ/OO6gLQyfv4FBKjv9ktLwndkBZkyUMH744pkG0Kub9ylYYiYKfYYXhmTeBxlHAncZY/3hSwKsx+SzsrDMu7f7ZDKCDunxKdNNw48p9ExP2nLr/rwOD4Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jlsLX77L; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CFBC54E413EE;
	Thu, 30 Oct 2025 08:05:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7DDD96068C;
	Thu, 30 Oct 2025 08:05:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BD087102F2130;
	Thu, 30 Oct 2025 09:05:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761811555; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=yhO0zoxEkB9DzrUVoWIN7bjo6McuuEao4alqEu6uLBQ=;
	b=jlsLX77LeQNohInoJWs+ecJrRdx6EBTro8CMxvC3JPE0B4chG8p7w/UusCVGAaMnr+1by2
	rFS5EtZPlcXC37k9JwKwOBoYt/KYglMziIUjDzOeGvfy321aj9dfJZF9TnzJcKpv8gTVZw
	rgLMYpNIMH3sL363P1TBpmaGeu8RfX01IID9c9hEo0zVBeGeBD5S9L0Csk06GDMAt5wAWR
	orRWpcqnFmdeK7ZqniILIj0pWgsfiFoZfrm98KdvQUeXP/V3MSLz2BA0/sAmWDaqW+xkM8
	gJ2vmYsvzbnERCIb3kxPlDOb25QcesuUIsBpG5o16ja0PzlrIZZ1T59M42FzBQ==
Message-ID: <0e576e3d-7e77-43ec-8ec2-5867dcb44960@bootlin.com>
Date: Thu, 30 Oct 2025 09:05:47 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 00/15] selftests/bpf: Integrate test_xsk.c to
 test_progs framework
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
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
 Alexis Lothore <alexis.lothore@bootlin.com>,
 Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <20251029-xsk-v6-0-5a63a64dff98@bootlin.com>
 <CAADnVQ+ESBTW-+NOQ55HXLwODFZa+uHWzMpPAq1FfjPP4otH_A@mail.gmail.com>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <CAADnVQ+ESBTW-+NOQ55HXLwODFZa+uHWzMpPAq1FfjPP4otH_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 10/29/25 7:54 PM, Alexei Starovoitov wrote:
> On Wed, Oct 29, 2025 at 6:52 AM Bastien Curutchet (eBPF Foundation)
> <bastien.curutchet@bootlin.com> wrote:
>>
>> Hi all,
>>
>> The test_xsk.sh script covers many AF_XDP use cases. The tests it runs
>> are defined in xksxceiver.c. Since this script is used to test real
>> hardware, the goal here is to leave it as it is, and only integrate the
>> tests that run on veth peers into the test_progs framework.
>>
>> I've looked into what could improve the speed in the CI:
>> - some tests are skipped when run on veth peers in a VM (because they
>>    rely on huge page allocation or HW rings). This skipping logic still
>>    takes some time and can be easily avoided.
>> - the TEARDOWN test is quite long (several seconds on its own) because
>>    it runs the same test 10 times in a row to ensure the teardown process
>>    works properly
>>
>> With theses tests fully skipped in the CI and the veth setup done only
>> once for each mode (DRV / SKB), the execution time is reduced to about 5
>> seconds on my setup.
>> ```
>> $ tools/testing/selftests/bpf/vmtest.sh -d $HOME/ebpf/output-regular/ -- time ./test_progs -t xsk
>> [...]
>> real    0m 5.04s
>> user    0m 0.38s
>> sys     0m 1.61s
> 
> This is fine. I see
> Summary: 2/48 PASSED, 0 SKIPPED, 0 FAILED
> 
> real    0m8.165s
> user    0m1.795s
> sys     0m4.740s
> 
> on debug kernel with kasan which is ok.
> > But it conflicts with itself :(
> 
> $ test_progs -j -t xsk
> 
> All error logs:
> setup_veth:FAIL:ip link add veth0 numtxqueues 4 numrxqueues 4 type
> veth peer name veth1 numtxqueues 4 numrxqueues 4 unexpected error: 512
> (errno 2)
> test_xsk_drv:FAIL:setup veth unexpected error: -1 (errno 2)
> #664     xsk_drv:FAIL
> Summary: 1/24 PASSED, 0 SKIPPED, 1 FAILED
> 
> Pls fix the parallel run and not by adding "_serial", of course.
Oups, in my quest for speed I removed the 'test_ns' prefix. It didn't 
seem necessary since all tests are run at once, but I forgot about 
parallel execution between the DRV and SKB modes..

Sorry about this, I'll put back the 'test_ns' prefix.

It will be a good opportunity to address some of the AI feedback I received.


Best regards,
Bastien

