Return-Path: <linux-kselftest+bounces-13890-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFBF93512C
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 19:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13BF41F22CCC
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 17:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360641459FC;
	Thu, 18 Jul 2024 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fOiAXBC/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EF61459F7
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Jul 2024 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721323030; cv=none; b=Gya6AT+WTslECE/+kdZArjX1R+CONAc9RVQs5nXDExwrcn2RnCYBH9k6rIguL1i4iKTM2mD8sRZ1+lBPwNT/jsHgCFdMBnc5OeFSksmfj4xiMpfxkFCDgBiaHVsKaMMqSMHBwz9mNqGJZ2VQtlnF9KX2kFUD6O1CcIneQvef8os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721323030; c=relaxed/simple;
	bh=rI4frp63Jxnsj31MWHYAeYEx6wRJkL13+FH1JRSRuiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K2DVNY0WjF3gUJ3qBaTiAwyImfL60bpIlkmj+rpu/XleDB7joS1eHBHo6zsGa3I8KygKvOVke3kVtp8mLuwYor4RF5Gy8tdpJiIwulvKGOTamVWq7RLwa1JfHINXubiqtgglydNVT3AI0QLLGQqt1YMm5jdCtAmwthub6jDTVpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fOiAXBC/; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: yikai.lin@vivo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721323026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C/vJB6s3AXh8HptKIgTma6VmUjB5HKeVFmr7SdBDgZU=;
	b=fOiAXBC/kyz2LAaqNNHfG2fOAtNGuc5Ww5UfjpbSDyxyvaa7HOdLqQS0u7B0g6c0WbPuvv
	+YIdQVsJS7dQX41is49dTAVl5/js2A9ZDEQoZj6qzrYFXq9dJ5t91aphMRNlxswUfTBMcD
	or0l2TE/2+d7INfy8cRveItONpPrP4g=
X-Envelope-To: ast@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: andrii@kernel.org
X-Envelope-To: eddyz87@gmail.com
X-Envelope-To: song@kernel.org
X-Envelope-To: yonghong.song@linux.dev
X-Envelope-To: john.fastabend@gmail.com
X-Envelope-To: kpsingh@kernel.org
X-Envelope-To: sdf@fomichev.me
X-Envelope-To: haoluo@google.com
X-Envelope-To: jolsa@kernel.org
X-Envelope-To: mattbobrowski@google.com
X-Envelope-To: rostedt@goodmis.org
X-Envelope-To: mhiramat@kernel.org
X-Envelope-To: mathieu.desnoyers@efficios.com
X-Envelope-To: mykolal@fb.com
X-Envelope-To: shuah@kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: linux-trace-kernel@vger.kernel.org
X-Envelope-To: linux-kselftest@vger.kernel.org
X-Envelope-To: opensource.kernel@vivo.com
Message-ID: <9642ad1d-e227-417e-a9ff-b69b2cb2d0d9@linux.dev>
Date: Thu, 18 Jul 2024 10:16:54 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 0/3] add bpf_file_d_path helper and selftests
To: Lin Yikai <yikai.lin@vivo.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 opensource.kernel@vivo.com
References: <20240718115153.1967859-1-yikai.lin@vivo.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240718115153.1967859-1-yikai.lin@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/18/24 4:51 AM, Lin Yikai wrote:
> v1:
>   - patch 2:
>     - [1/2] add bpf_file_d_path helper
>     - [2/2] add selftest to it
> 
> Hi, we are looking to add the "bpf_file_d_path" helper,
> used to retrieve the path from a struct file object.
> 	bpf_file_d_path(void *file, char *dst, u32 size);
> 	
> It's worth noting that the "file" parameter is defined as "void*" type.
> 
> * Our problems *
> Previously, we encountered issues
> on some user-space operating systems(OS):
> 
> 1.Difficulty using vmlinux.h
> (1) The OS lacks support for bpftool.
> We can not use:
> "bpftool btf dump file /sys/kernel/btf/vmlinux format c > vmlinux.h".
> Bpftool need a separate complex cross-compilation environment to build.
> 
> (2) Many duplicate definitions between OS and vmlinux.h.
> 
> (3) The vmlinux.h size is large (2.8MB on arm64/Android),
> causing increased ebpf prog size and user space consumption.

The compiled bpf prog size is increased by 2.8MB because it included vmlinux.h?

> 
> 2.The "struct file" has many internal variables and definitions,
> and maybe change along with Linux version iterations,
> making it hard to copy it to OS.

If vmlinux.h is not convenience in your use case, you can try to define "struct 
file" with __attribute__((preserve_access_index)) and the libbpf will adjust the 
bpf prog against the running kernel.

There was a discussion a year ago about bpf helpers freeze. No new helper can be 
added since then. The same goes for this one.

pw-bot: cr

