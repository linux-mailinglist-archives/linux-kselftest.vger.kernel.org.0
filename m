Return-Path: <linux-kselftest+bounces-10683-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 872AD8CECA4
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 May 2024 01:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 423F5281E83
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 23:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA12515572C;
	Fri, 24 May 2024 23:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ccCfzOGh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1202C1553A1
	for <linux-kselftest@vger.kernel.org>; Fri, 24 May 2024 23:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716592595; cv=none; b=qWIpkAe2POGoB1PB13l8pzkUfxsHBP0zmC2QNBUWemcd9dVShYzDMsCcgLERyHP3CTMVs3GHrujPShXIq5IHhqqhKhnJRSPArCVDWLesMN9AlAPJ37esH3OFH/ex8HrZut2WhCxsqWCFcWXKWIW64fKeDPOV7OfE+2ele/ftLVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716592595; c=relaxed/simple;
	bh=Y7I1w3NIY80FaZLYX1Gavh/lqC4JjyMBM4H9YaMYdHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SZxk7SC+0GqckJ0bJzCU0JgEv5cuGuM0GhROV1he7KoKc/RsO6/95eVdPqUzldhsUeb+Zu9ldLSJyARyAFRmDCuTgcshCv/PP1XqTVT5DOkMzMGbQJP8ZOQ6uTuVWhQ94z3YBz17BR1328d3/yjDDynhX+oW9z1J84lW2oATnVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ccCfzOGh; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: geliang@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716592591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z2uwCfu2jscoa5V5s+WTAFPg+4Fve3as4zISaAXGli0=;
	b=ccCfzOGh5VgqUv7o3CgvqFdJJr31yri0xDXVtZUHHHJYpk8Rpt1nfD0/IakSbbZG4L6vjj
	92G5ttiSkfv8JbnQbDIbVmAAs+UaaPWOQFWIU+Yw+3KVJSH33fW0FiCexdyYcZ7oGF6ref
	LABVNxhHt9E1z0kniqOVIiAp6qe8sBY=
X-Envelope-To: andrii@kernel.org
X-Envelope-To: eddyz87@gmail.com
X-Envelope-To: mykolal@fb.com
X-Envelope-To: ast@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: song@kernel.org
X-Envelope-To: yonghong.song@linux.dev
X-Envelope-To: john.fastabend@gmail.com
X-Envelope-To: kpsingh@kernel.org
X-Envelope-To: sdf@google.com
X-Envelope-To: haoluo@google.com
X-Envelope-To: jolsa@kernel.org
X-Envelope-To: shuah@kernel.org
X-Envelope-To: tanggeliang@kylinos.cn
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: linux-kselftest@vger.kernel.org
Message-ID: <80fbda0d-d366-4aa8-83e7-f7a5bdc5236a@linux.dev>
Date: Fri, 24 May 2024 16:16:22 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 3/6] selftests/bpf: Use post_socket_cb in
 connect_to_fd_opts
To: Geliang Tang <geliang@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <cover.1716520609.git.tanggeliang@kylinos.cn>
 <34180b520025f700f65d23b41148109e4214c697.1716520609.git.tanggeliang@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <34180b520025f700f65d23b41148109e4214c697.1716520609.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/23/24 8:21 PM, Geliang Tang wrote:
> +static int cc_cb(int fd, void *opts)
> +{
> +	struct cb_opts *cb_opts = (struct cb_opts *)opts;
> +
> +	return setsockopt(fd, SOL_TCP, TCP_CONGESTION, cb_opts->cc,
> +			  strlen(cb_opts->cc) + 1);

Since this cc_cb is in the test itself, it should use ASSERT_* such that the 
error output will be more useful. The same (use ASSERT_* whenever makes sense) 
goes for all cb functions in this set. In particular for the cb that does more 
than setsockopt in patch 5.


