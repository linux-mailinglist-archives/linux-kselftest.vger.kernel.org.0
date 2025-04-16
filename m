Return-Path: <linux-kselftest+bounces-30951-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D1AA8B933
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 14:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60A235A0C19
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 12:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C1D13777E;
	Wed, 16 Apr 2025 12:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="FZ0weLGh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294ED1AAC4
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Apr 2025 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744806818; cv=none; b=Ytgl+4P1Jj0SBqypTgPYS8XWn1i2987bEZfOb6dzEm6O8kDH96Y4z9Fu4HiTGcov6DLrJVMd/nGKVqoOx3YUIS92HrrhiLThgj2AzPb9qm05k1FMu6VLUgdWNlaZhy2W31zeoptsERCISGJlZua/kcldV5kyWdikfTlKZCwhFEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744806818; c=relaxed/simple;
	bh=9d94ym3bPDNkwZlJGX1nTqM8nOdX3wW3K5m0RSRbFEs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XZxz/eVZTyG2ZMFMcpiNeZGxSurXZhv/jUAsmjvQv6EAU0ROR18LM3zCuH1bjhcY2B+yUTEhvZXMlE269nhr0T9Scvv6XlcC/8NOgNgqZGjl1kxNgCMLqw390PmBgE52cArfs5VJsogmUskqmCYcSQGtN5kDOUdGsf3qBGKbkJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=FZ0weLGh; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1u51xD-002mks-82; Wed, 16 Apr 2025 14:33:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=V1Q5znUGpZkb+vVcXtQ/KxHIEvFXCx3Bs5in36njKjM=; b=FZ0weLGhuMgVgOKLyimlvfC4+o
	WbZyd74vpg0y8hU5z9m79uce8y0DCtW74FHTQulxV7vV9clAOsJ0QCBSGiN5xKrZNdNNXNDch8dpT
	/ZSytHJGrekPchJ8DDnJl1GSjanx8QtTcS1F07gUeocY37RvCNsoChz1fLtuWn9HETA5QYbD8nL+M
	5da01vX+RWqat3xwgiQB5a2nGUPeqF4IyShRB7oAKKc+PLA+hTr+8STvnlAegNo+aGcoCv74p6ImM
	qcbNsW1TjoB3xytj0jvrd3kBa9/v2KsiQURmHYm0f41NZWIft6IngVSFk/U+1U2COV64rjmYACWKX
	3zDondXg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1u51xC-0000hv-T6; Wed, 16 Apr 2025 14:33:23 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1u51xB-008Dyl-Pm; Wed, 16 Apr 2025 14:33:21 +0200
Message-ID: <66bf942f-dfdb-4ce9-bd95-8b734e7afa53@rbox.co>
Date: Wed, 16 Apr 2025 14:33:20 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH bpf-next v2 5/9] selftests/bpf: Add selftest for
 sockmap/hashmap redirection
To: Jiayuan Chen <mrpre@163.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Jakub Sitnicki <jakub@cloudflare.com>
References: <20250411-selftests-sockmap-redir-v2-0-5f9b018d6704@rbox.co>
 <20250411-selftests-sockmap-redir-v2-5-5f9b018d6704@rbox.co>
 <ghhz3pi3oh3rylyd5t6gfa3x7m35q4ei5liwytmcbfit4r4pit@4al5vrpx7exl>
Content-Language: pl-PL, en-GB
In-Reply-To: <ghhz3pi3oh3rylyd5t6gfa3x7m35q4ei5liwytmcbfit4r4pit@4al5vrpx7exl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/11/25 16:31, Jiayuan Chen wrote:
> On Fri, Apr 11, 2025 at 01:32:41PM +0200, Michal Luczaj wrote:
>> +static void test_send_redir_recv(int sd_send, int send_flags, int sd_peer,
>> +				 int sd_in, int sd_out, int sd_recv,
>> +				 struct maps *maps, int status)
>> +{
>> +	unsigned int drop, pass;
>> +	char *send_buf = "ab";
>> +	char recv_buf = '\0';
>> +	ssize_t n, len = 1;
>> +	/* Zero out the verdict map */
>> +	if (xbpf_map_update_elem(maps->verd, &u32(SK_DROP), &u32(0), BPF_ANY) ||
>> +	    xbpf_map_update_elem(maps->verd, &u32(SK_PASS), &u32(0), BPF_ANY))
>> +		return;
>> +
>> +	if (xbpf_map_update_elem(maps->in, &u32(0), &u64(sd_in), BPF_NOEXIST))
>> +		return;
>> +
>> +	if (xbpf_map_update_elem(maps->out, &u32(0), &u64(sd_out), BPF_NOEXIST))
>> +		goto del_in;
>> +
>> +	/* Last byte is OOB data when send_flags has MSG_OOB bit set */
>> +	if (send_flags & MSG_OOB)
>> +		len++;
>> +	n = send(sd_send, send_buf, len, send_flags);
>> +	if (n >= 0 && n < len)
>> +		FAIL("incomplete send");
>> +	if (n < 0) {
>> +		/* sk_msg redirect combo not supported? */
>> +		if (status & SUPPORTED || errno != EACCES)
>> +			FAIL_ERRNO("send");
>> +		goto out;
>> +	}
>> +
>> +	if (!(status & SUPPORTED)) {
>> +		handle_unsupported(sd_send, sd_peer, sd_in, sd_out, sd_recv,
>> +				   maps->verd, status);
>> +		goto out;
>> +	}
>> +
>> +	errno = 0;
>> +	n = recv_timeout(sd_recv, &recv_buf, 1, 0, IO_TIMEOUT_SEC);
>> +	if (n != 1) {
>> +		FAIL_ERRNO("recv_timeout()");
>> +		goto out;
>> +	}
> I prefer multiple send and receive operations, or implementing a loop at
> the outer level.

If you referring to MSG_OOB that "emulates" multiple send(), that's quite
deliberate: to exercise what is actually happening on
unix_stream_sendmsg(, MSG_OOB). And, well, to follow the selftests logic
in sockmap_listen.c:pairs_redir_to_connected().

Would you rather have it split anyway?

Thanks,
Michal

