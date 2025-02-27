Return-Path: <linux-kselftest+bounces-27818-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C1EA48C54
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 00:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68AC016D260
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 23:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF01623E333;
	Thu, 27 Feb 2025 23:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TmKxl2ev"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0F222576A
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2025 23:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740697490; cv=none; b=L295XKbgn022D+RCenMBiT9Y+tli19DZHc3JuY7R+BZY7Gbjrt2P4xDDDXgiTA5G8M4AMNuM6f3OegM4Kni0Eu9xE9Wpw0Wg8T+4zylx28F93g310HQDbnqkcjopsME/i0nEcA26QtNIaISEd40PXkv/0fE4gmnxmc+Dq4UwXws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740697490; c=relaxed/simple;
	bh=KQnDSWfCyG4GFZ8z+w71H8Ba87KJiLSAkaj1oH1XyiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NSPEhX7Vk3ZSz3CWJ1nXz0OFB/u5JFP785C2DShUrdCkHDBMYIfl4ELot8jfh1DSfnuEQ8lH+bwiLVfah7/w9jgebSQyWWd+j/RcfD+r/S6cOi6GUY4/Yh8FEyUoreRKa543kNT2DeYwPXNv+PqcPHl8p7XsRNL1KSnPwtUWsHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TmKxl2ev; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <84f25c32-1aa6-42d6-a5b1-efce822bfcd6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740697477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s53PsMsT+VnZgU2wt1QKLZK3VWcUDg2UEoFqQhBbfUs=;
	b=TmKxl2ev/7M/7kekUDzsyg4xu4/zQ0gcoHcFm9HW//fxbejxAifn9SEiGLWsOsWJSLpks8
	9sFT6ChRjHvb2hmy8pvRw9ui4rDdewvIDBIXcYaZ8f/afR5jSwHJsiA1aEh3uknP90Kn91
	3NaCKozg+PAo/v7rQIHf28cPHu5sE3Y=
Date: Thu, 27 Feb 2025 15:04:26 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 1/3] bpf, sockmap: avoid using sk_socket after
 free
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: cong.wang@bytedance.com, john.fastabend@gmail.com, jakub@cloudflare.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, mhal@rbox.co,
 sgarzare@redhat.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 mrpre@163.com, syzbot+dd90a702f518e0eac072@syzkaller.appspotmail.com
References: <20250226132242.52663-1-jiayuan.chen@linux.dev>
 <20250226132242.52663-2-jiayuan.chen@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250226132242.52663-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/26/25 5:22 AM, Jiayuan Chen wrote:
> Use RCU lock to protect sk_socket, preventing concurrent close and release
> by another thread.
> 
> Because TCP/UDP are already within a relatively large critical section:
> '''
> ip_local_deliver_finish
>    rcu_read_lock
>    ip_protocol_deliver_rcu
>        tcp_rcv/udp_rcv
>    rcu_read_unlock
> '''
> 
> Adding rcu_read_{un}lock() at the entrance and exit of sk_data_ready
> will not increase performance overhead.

Can it use a Fixes tag?

