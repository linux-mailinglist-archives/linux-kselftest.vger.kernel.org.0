Return-Path: <linux-kselftest+bounces-9376-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED29B8BB049
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 17:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29F391C225EB
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 15:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA155154C14;
	Fri,  3 May 2024 15:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="mjYlG1rJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C632E827;
	Fri,  3 May 2024 15:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714751508; cv=none; b=BZoP9t1GvDydVq21rr9u77sAwbtgnCEaEXsen68OAxev570mL71yC/KDGY9K96YHdj14Xf4ei4MG/Lzc+poM7oZhanubGQpzdi09A60hmScfZAEhA2bEJU8SJ0YQWOzByV6uNi2pDQ26yr5uuJC/3e1zM99VtfwjyBJ5s3Fq0Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714751508; c=relaxed/simple;
	bh=n3yMyo9Q31PRRTaBYtSASB/x9crJwpu1GMXUJF2qqJM=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uu0cy6Tx693eXNtqSURZ5o0kFevruG/GExjBAHPyAlzRtJyJM7G31dh1FAuYHVieJUsSxgGX2/vLSCPH7AFVQurVv7UVorRjZ5HWPOsK0QfUrdwDY3nA0LnQMJZ3z/gPuP3dNhJi1MPzEZ36JMR1huNniuVLKOiaI6yDxy3ti38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=mjYlG1rJ; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=w7udNYHhdb0T4xJLrpeD52hVLygOF3GDewL37UF5l7s=; b=mjYlG1rJvhPJZsgtNtWQ3vZbDM
	Smtt/BJjV50uOZuFoqbyHbZujF5ub006iD5Ze4W0gZWt6AE3DdJxmKGF/wdzUIq5tGSemU8c89F9O
	Fff2R3Lol8SQSzB86ywqd0vjsk8V2nuGRx/3vJ7MAKC/gF0F+PW46OrbKmk4shsHFoNNm4ZThKdkq
	A4UbIqkYShAZhPn//jGnVGcbW1qH7Rrr1JWI3A/kBWFItjMmqYgPWchOfplNFUoTbAmFth+mxcJwQ
	zAOQ+QRljmOiUzfjgILqTXo6DURhmHL6dXlvZw+e2VW6HF3KQain7OvAViCGA/004ZkkdCBtZvoK8
	QEXAOm/A==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1s2vBV-000IhL-Bh; Fri, 03 May 2024 17:51:31 +0200
Received: from [178.197.249.41] (helo=linux.home)
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1s2vC6-00057M-0Q;
	Fri, 03 May 2024 17:51:30 +0200
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: Add a null pointer check for
 the serial_test_tp_attach_query
From: Daniel Borkmann <daniel@iogearbox.net>
To: Kunwu Chan <chentao@kylinos.cn>, ast@kernel.org, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, kunwu.chan@hotmail.com
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240424020444.2375773-1-chentao@kylinos.cn>
 <20240424020444.2375773-5-chentao@kylinos.cn>
 <79df3541-5557-05fa-a81e-84728d509bfc@iogearbox.net>
Message-ID: <57c18a4f-24bb-24fe-b3f3-33b3987fb393@iogearbox.net>
Date: Fri, 3 May 2024 17:51:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <79df3541-5557-05fa-a81e-84728d509bfc@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27264/Fri May  3 10:24:33 2024)

On 5/3/24 5:47 PM, Daniel Borkmann wrote:
> On 4/24/24 4:04 AM, Kunwu Chan wrote:
>> There is a 'malloc' call, which can be unsuccessful.
>> Add the malloc failure checking to avoid possible null
>> dereference.
>>
>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>> ---
>>   tools/testing/selftests/bpf/prog_tests/tp_attach_query.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c b/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
>> index 655d69f0ff0b..302b25408a53 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
>> @@ -39,6 +39,9 @@ void serial_test_tp_attach_query(void)
>>       attr.wakeup_events = 1;
>>       query = malloc(sizeof(*query) + sizeof(__u32) * num_progs);
>> +    if (CHECK(!query, "malloc()", "error:%s\n", strerror(errno)))
> 
> Series looks reasonable, small nit on CHECK() : Lets use ASSERT*() macros given they are
> preferred over the latter :
> 
> if (!ASSERT_OK_PTR(buf, "malloc"))

( Also as a side-note: Fixes tag on all these patches is not needed given this will just
   end up spamming stable tree. If you indeed end up with NULL then the tests will just
   segfault & fail. )

>> +        return;
>> +
>>       for (i = 0; i < num_progs; i++) {
>>           err = bpf_prog_test_load(file, BPF_PROG_TYPE_TRACEPOINT, &obj[i],
>>                       &prog_fd[i]);
>>
> 


