Return-Path: <linux-kselftest+bounces-7009-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 428FB895F9F
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 00:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A13EC2868FB
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 22:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F163249FE;
	Tue,  2 Apr 2024 22:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZtpnuJTs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD7222615
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Apr 2024 22:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712097208; cv=none; b=cbD0nGPK8qc1oLp2v4DNtOqaeEYfHLMI9zHkyOhaDa5POAKSEENlsXx37LOp/aKH/9B/mYQl98Xg9yrdOyhiMr8JYFYEtrRMgpfWkOOEZYW+lHn8+89tQsNYzv1x7qncxaLy972hLkjXroJpBPTfMS2oOHwBOc4yH2o2zySwNC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712097208; c=relaxed/simple;
	bh=kkzlSA66i26GYwqP48fW+uIkvk54teFui2Jrdf90kTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BRDy7OjFyKLdXsrv0JIsckO4QPLw8onuuAh6jLoudpTXN74P5lrTFt2eWP09za7N5LeG1yLR6AOL8PWeyKsiz1iiD96IGeYRuBb63BoxkR1rPXrbrNAW6W/HlXWL74rpcfD49GyYzy2J92tK/RNnToiCkx+ua3nto9xYlsTwTXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZtpnuJTs; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e5a1261d-0366-4459-b78c-86557d6e1834@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712097204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8S9cgMSyZXFXQwkW18aRhug4biM7UCnBGh847SJ+7ak=;
	b=ZtpnuJTsEoaGToEeRIPVsngQ6SP0HDjZo4AX3xGVWx57B+V9xFeemlcIC7Tr2v3wGnG1Q4
	/yz+6FW6Hxuf5wf8AuXJkNGtdvU9VohoiDrFTFRtyg5A4YgwUwQbf0gj+7B66nNHcecRNP
	8rCpXv387lfHd/Byk3qyJ4ggr26l6Nw=
Date: Tue, 2 Apr 2024 15:33:18 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next 4/8] selftests/bpf: Add recv_msg_from_client
 to network helpers
To: Jordan Rife <jrife@google.com>
Cc: linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Daan De Meyer <daan.j.demeyer@gmail.com>, bpf@vger.kernel.org
References: <20240329191907.1808635-1-jrife@google.com>
 <20240329191907.1808635-5-jrife@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240329191907.1808635-5-jrife@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/29/24 12:18 PM, Jordan Rife wrote:
> +int recvmsg_from_client(int sockfd, struct sockaddr_storage *src_addr)
> +{
> +	struct timeval tv;
> +	struct msghdr hdr;
> +	struct iovec iov;
> +	char data[64];
> +	fd_set rfds;
> +
> +	FD_ZERO(&rfds);
> +	FD_SET(sockfd, &rfds);
> +
> +	tv.tv_sec = 2;
> +	tv.tv_usec = 0;
> +
> +	if (select(sockfd + 1, &rfds, NULL, NULL, &tv) <= 0 ||

The socket fd created by the helpers in network_helpers.c should be a blocking 
socket and has a 3s default delay. select should not be needed. Try to stay with 
the default. If the default turned out to be too flaky in the bpf CI in the 
future, one default change is easier.

> +	    !FD_ISSET(sockfd, &rfds))
> +		return -1;
> +
> +	memset(&iov, 0, sizeof(iov));
> +	iov.iov_base = data;
> +	iov.iov_len = sizeof(data);
> +
> +	memset(&hdr, 0, sizeof(hdr));
> +	hdr.msg_name = src_addr;
> +	hdr.msg_namelen = sizeof(struct sockaddr_storage);
> +	hdr.msg_iov = &iov;
> +	hdr.msg_iovlen = 1;
> +
> +	return recvmsg(sockfd, &hdr, 0);
> +}


