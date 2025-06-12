Return-Path: <linux-kselftest+bounces-34797-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E41ECAD69C4
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 09:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B8753AC403
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 07:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9BA21D3EC;
	Thu, 12 Jun 2025 07:59:26 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47FC21771F;
	Thu, 12 Jun 2025 07:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749715166; cv=none; b=s3RXJDIaPF0jM0K8VX/eTaIp8FcZ4s4ksyLBPrUiqiHO4GHGiPkSFfuqwaDiiW2+25swM3DEmJ3C8Nesf2UO/fq4ssMVZk2dT5GT0pv/OGUNt3YrLLnezqBuesL3d9jhibfuSaPmfmM8Czu6lZenmeLf9NAtkrTo4hrXC3MzHf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749715166; c=relaxed/simple;
	bh=tYh197tkZa5hHOKuUeE8HoOoivjmnDPiZOSGRonpliQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C0AzxRvIZde8o4XV545eXqiU9tcsmgL5D8JMSDAVI7/0hjebCAMIRb3mJrQEcBkftB7+VrQfXA2UndpbFQWm3QbL3mzLZFFFj53dCFavBUBzUeVeYWHGytpHEb+qIcrMipQxK86oyQqZn8MZkZPMexCpKIZ8CUot2lZt0LwvJ7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <alexei.starovoitov@gmail.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <eddyz87@gmail.com>, <haoluo@google.com>,
	<jakub@cloudflare.com>, <john.fastabend@gmail.com>, <jolsa@kernel.org>,
	<kpsingh@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <martin.lau@linux.dev>, <mhal@rbox.co>,
	<mykolal@fb.com>, <sdf@fomichev.me>, <shuah@kernel.org>, <song@kernel.org>,
	<thinker.li@gmail.com>, <wangfushuai@baidu.com>, <yonghong.song@linux.dev>
Subject: Re: [PATCH] selftests/bpf: fix signedness bug in redir_partial()
Date: Thu, 12 Jun 2025 15:57:00 +0800
Message-ID: <20250612075700.24193-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <CAADnVQ+SSPhZNN05F2-MS_79Vhp+mSTWF3Ss1rcoWRnaDjFx+A@mail.gmail.com>
References: <CAADnVQ+SSPhZNN05F2-MS_79Vhp+mSTWF3Ss1rcoWRnaDjFx+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc7.internal.baidu.com (172.31.50.51) To
 bjkjy-mail-ex22.internal.baidu.com (172.31.50.16)
X-FEAS-Client-IP: 172.31.50.16
X-FE-Policy-ID: 52:10:53:SYSTEM

>> When xsend() returns -1 (error), the check 'n < sizeof(buf)' incorrectly
>> treats it as success due to unsigned promotion. Explicitly check for -1
>> first.
>>
>> Fixes: a4b7193d8efd ("selftests/bpf: Add sockmap test for redirecting partial skb data")
>> Signed-off-by: wangfushuai <wangfushuai@baidu.com>
> 
> Looks good, but please spell out your name as First Last
> in both From and Signed-off
> 
> Also use [PATCH bpf-next] in subject
> 
> pw-bot: cr

Will fix and send v2 shortly. Thanks for the review!

--
Regards,
Wang
 
>> ---
>>  tools/testing/selftests/bpf/prog_tests/sockmap_listen.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
>> index 1d98eee7a2c3..f1bdccc7e4e7 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
>> @@ -924,6 +924,8 @@ static void redir_partial(int family, int sotype, int sock_map, int parser_map)
>>                 goto close;
>>
>>         n = xsend(c1, buf, sizeof(buf), 0);
>> +       if (n == -1)
>> +               goto close;
>>         if (n < sizeof(buf))
>>                 FAIL("incomplete write");
>>
>> --
>> 2.36.1

