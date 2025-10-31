Return-Path: <linux-kselftest+bounces-44549-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7217C26C20
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 20:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B0683A6C40
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 19:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC98C30EF72;
	Fri, 31 Oct 2025 19:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IEXhEahv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4FA2EFDA5
	for <linux-kselftest@vger.kernel.org>; Fri, 31 Oct 2025 19:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761938956; cv=none; b=X327LyAq+pRln3dd0tLgZvY9wfryqGZxNLBXdKa+IXuhfguGuCo+nUQDHhS4z6Jo3DxIh5o1gASlvx7I9fu5ATDqirfVEUu7xvG/DXUY8rD7ZJbqbuT0rhu/mXZADJDRR50e2NLlLzM0bLz3APQCnRECK8NRZFRFd0eC9svCpFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761938956; c=relaxed/simple;
	bh=tap3GZK35XqIeGc0MtuZbkLTyyOpeW4BuzXhKgfHbG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h06pmDL8qSLfMUpFT2HzIf7lIY1AihEpD7L5cQYAbkoQCy6UCEWVj7oheFGFsbA/RH8GLzUKZR6waMGfFKvEk6TPZEu6txyhegljfSTkLyZP4BuluDbIo1FE3Dq+gj4tBqwUc8C16bv2OPfyKCH1DpOvij9+2FDdgwKzHV0W2OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IEXhEahv; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d886e631-851b-4e2f-aecb-ecdb541dfedc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761938938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8D2DjveBXCBvaI02wp6eCLUtpmu3etH8CmtWre82fK8=;
	b=IEXhEahvBzCb9dsDqryxWKPeJMso0ZXHQY9gEyyNpqyl2hWF5u4qhEzAr0JRfRwCLqCIl1
	HeCAPFGpEsGQIA//gcpJQ0XzjPttZU94W4D7OjE6FZ446D8MMTQ5ZLa0qTB/iNnEkJvQ9I
	y+RDvv0IKt3SNjrcHkkaw2+ROSwlSv8=
Date: Fri, 31 Oct 2025 12:28:50 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf: integrate test_tc_edt into
 test_progs
To: alexis.lothore@bootlin.com
Cc: ebpf@linuxfoundation.org, bastien.curutchet@bootlin.com,
 thomas.petazzoni@bootlin.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev,
 bot+bpf-ci@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org
References: <20251031-tc_edt-v1-2-5d34a5823144@bootlin.com>
 <09feef91b51f675195b5b1b9a854d844c9999c0cebb429d785fe60f6c787dc8b@mail.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <09feef91b51f675195b5b1b9a854d844c9999c0cebb429d785fe60f6c787dc8b@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/31/25 9:20 AM, bot+bpf-ci@kernel.org wrote:
>> +static void run_test(void)
>> +{
>> +	__u64 rx_bytes_start, rx_bytes_end;
>> +	double rate_mbps, rate_error;
>> +	pthread_t server_thread = 0;
>> +	struct connection *conn;
>> +	__u64 ts_start, ts_end;
>> +	int ret;
>> +
>> +
>> +	conn = setup_connection();
>> +	if (!ASSERT_OK_PTR(conn, "setup client and server connection"))
>> +		return;
>> +
>> +	ret = pthread_create(&server_thread, NULL, run_server,
>> +			     (void *)(&conn->server_conn_fd));
>> +	if (!ASSERT_OK(ret, "start server rx thread"))
>> +		goto end_cleanup_conn;
>> +	if (!ASSERT_OK(read_rx_bytes(&rx_bytes_start), "read rx_bytes"))
>> +		goto end_kill_thread;
>> +	ts_start = get_time_ns();
>> +	while (true) {
>> +		send(conn->client_conn_fd, (void *)tx_buffer, BUFFER_LEN, 0);
>> +		ts_end = get_time_ns();
>> +		if ((ts_end - ts_start)/100000 >= TIMEOUT_MS) {
>                                           ^^^^^^
> 
> Does this time conversion use the correct divisor? The timeout check
> appears to divide nanoseconds by 100000, but TIMEOUT_MS is 2000
> milliseconds. Converting nanoseconds to milliseconds requires dividing
> by 1000000, not 100000. With the current calculation, the timeout would
> trigger after 200 milliseconds rather than 2000 milliseconds.

The report is correct, there is a typo in the denominator.

Use the send_recv_data() helper in network_helpers.c. It should simplify 
this test and no need to pthread_create, while loop, ....etc. 
send_recv_data limits by the number of bytes instead of the length of 
time. There is a target rate in this test, so it should be easy to 
convert from time limit to byte limit and reuse the send_recv_data.

pw-bot: cr


