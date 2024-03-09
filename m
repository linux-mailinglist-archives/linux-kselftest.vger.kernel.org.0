Return-Path: <linux-kselftest+bounces-6137-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F161B87719B
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Mar 2024 15:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5B02281BA4
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Mar 2024 14:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC354436B;
	Sat,  9 Mar 2024 14:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="IPR+SSJk";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="iVvx3FEj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC1940878;
	Sat,  9 Mar 2024 14:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.235.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709994313; cv=none; b=kX96wxeatoAkaPymav6xeO5BEiStehOWV0E/J6P3pDIt6s6j0uQBvWi7zs9k8dDtO/xSZF+7O6dOqG3RG9J6K+6xTNTlDLzsiq09EcfJTkCm2Sbpq0Y1a1FUsh1PBxKIG+680CGeexJYquT0j1N+7OTBLk9LAUVvlMC1pUop+AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709994313; c=relaxed/simple;
	bh=iWj34sjzo6IYnYFwenWG7FCvbM9RDs7toJvPBK1qmCY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Jv68UMCOLZnL10ltAi4O54xwhcY5l9/CFgyi2WgDZiTIUfXqVH4SS3gJznhvE4qM3YWZq1a+CkgpurpIDeXttNSVJWxAgGfIQxy4T0uAWzNHHUpXPj0vpgTYUrzvNEXeEIfkONDH09ytYXVcLcw0AXbZUfA0KfX1+vjChSeFxLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr; spf=pass smtp.mailfrom=alu.unizg.hr; dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b=IPR+SSJk; dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b=iVvx3FEj; arc=none smtp.client-ip=161.53.235.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 7AF6F601A1;
	Sat,  9 Mar 2024 15:25:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1709994305; bh=iWj34sjzo6IYnYFwenWG7FCvbM9RDs7toJvPBK1qmCY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=IPR+SSJkNiyj2/zrycd1bmvtcacuNyPxUpJlSaPTuMkagZtoSgnOD1nW+s9uQHtyf
	 FeDnd1ahEGbfPMqOZeWwI4DThipDYaweLx/NX0J8lbx4l3STXfe88JEaINMUIcmOMc
	 qHmATciQz9/ndaeoBoc0Lnsuf08e1XUnbAyjZcDvFEo77rhnU1kWiMNM8mJuaWgMtJ
	 cy7/41pgP3oSYaKzgxofBLkLHCAM81TXt1VlC2ZHW0NItNrT+HM0vU2AxMdRDb6eky
	 MLygKZoYx9wtqvw4nsCPB192KvNKZdLII+TJk34hFTfIO4zV2ZxV52cDFbXe21Wc5U
	 jHxoRRIHULl2w==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1SZs1EMjTPbz; Sat,  9 Mar 2024 15:25:03 +0100 (CET)
Received: from [192.168.178.20] (dh207-40-27.xnet.hr [88.207.40.27])
	by domac.alu.hr (Postfix) with ESMTPSA id 5CDFA60189;
	Sat,  9 Mar 2024 15:25:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1709994303; bh=iWj34sjzo6IYnYFwenWG7FCvbM9RDs7toJvPBK1qmCY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=iVvx3FEj7/ZfdSyxpFZilLVdjIo/FwQmbqcCQVJ0aKtz+mZueSqiiAoRX9R0QjTgx
	 +nNOCJstDu9mzI3sDK+Tp9W7mZu9qyviG4jV+kZr1uNpGk7Jr8yHZ6zDwCylq819va
	 rzvg5BEZHadtzBELVWXM31vjth3MuhU7eC9Rhfw4Gx3CeUi1xeRyZ84ocEuaeBcacO
	 MLO5LqV9L5tC9sv6I8TBPBh9D7LGD+BF9a8QBe87VuSH23dWLM7Y3u3JPMq+YcTSip
	 +um9cnZ+iI2s3hftONCbrnrTrey5cW3u8k4BaN4/J0THyrMcxTqMFsnffujEmaoYqz
	 aoqW+ds1L73hg==
Message-ID: <877426e1-fc7e-467f-944c-9d6c450f11dd@alu.unizg.hr>
Date: Sat, 9 Mar 2024 15:25:02 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG net-next selftests/pidfd] Hang in ./pidfd_setns_test
 pidfd_send_signal()
Content-Language: en-US
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
To: Christian Brauner <brauner@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <e2ba3f8c-80e6-477d-9cea-1c9af820e0ed@alu.unizg.hr>
In-Reply-To: <e2ba3f8c-80e6-477d-9cea-1c9af820e0ed@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

There seems to be some additional insight.

Trying to kill the processes so the testsuite might hopefully continue, this was
the result: unkillable (-SIGKILL) processes, which can also not be traced with
strace, and neither the selftest suite continued.

root     1000955    2931  0 01:05 pts/2    00:00:00 ./pidfd_setns_test
root     1000956 1000955 99 01:05 pts/2    14:09:03 [pidfd_setns_tes] <defunct>
root     1037946 1005609  0 15:19 pts/3    00:00:00 grep --color=auto pidfd_setns_tes
root@defiant:/home/marvin/linux/kernel/net-next# strace -p 1000955
strace: Could not attach to process. If your uid matches the uid of the target process, check the setting of /proc/sys/kernel/yama/ptrace_scope, or try again as the root user. For more details, see /etc/sysctl.d/10-ptrace.conf: Operation not permitted
strace: attach: ptrace(PTRACE_SEIZE, 1000955): Operation not permitted
root@defiant:/home/marvin/linux/kernel/net-next# strace -p 1000956
strace: Could not attach to process. If your uid matches the uid of the target process, check the setting of /proc/sys/kernel/yama/ptrace_scope, or try again as the root user. For more details, see /etc/sysctl.d/10-ptrace.conf: Operation not permitted
strace: attach: ptrace(PTRACE_SEIZE, 1000956): Operation not permitted
root@defiant:/home/marvin/linux/kernel/net-next#

Hope this helps.

It would be very interesting to see now what exactly eats 99% of a CPU core, but
I am not enough technologically savvy for this task ATM.

Best regards,
Mirsad Todorovac

