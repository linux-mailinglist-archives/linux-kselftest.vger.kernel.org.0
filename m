Return-Path: <linux-kselftest+bounces-24607-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FDFA12ECA
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 23:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 828CD1883CA3
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 22:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9DF1DACB8;
	Wed, 15 Jan 2025 22:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E82tfRqX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3502D14A60C;
	Wed, 15 Jan 2025 22:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736981817; cv=none; b=LDUHSz9vgqFbpCxJiMkIJjzTAT+XvG2FgoXb0VjlhX3AXk+xU7Mrh1cuynds9onCBEN6JYtcCHvnHFZOfXtLxSc4pozuXr68EYuBkSKdm/no9x06+5F7sYiWfqFRmSJmf3H5qaw4JomxVoSmlU+S9THnPQWtxKB/FKj9N2YpPF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736981817; c=relaxed/simple;
	bh=44VBVDh1y25Pyfov8nyUQBukrb9Y7jivr9pU/8hKkeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pIR2fTCqg6CfxAK86vV/2JbIcfFrJkhzeNdNBaq85+2IFWa5Xj1pTJfoLeAIC2xcAq/zdCxPy3GjmQifMhh20Q17XsUaqtncqy0g/YedqtIneJrWGOoyhT9b7nJpuXfBCHRbkZpamPS46XoqPyrKxPeoDtovq7hYe5dPND6Pg04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=E82tfRqX; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=e3t+sE5c7F20pd/0hjWdIAKazrUAgFjySYN0mc/PB8o=; b=E82tfRqXxW3ZYOgLRVKyt4v6L7
	9y/hYa6VyzdPsH2uyhUFrFKasMASEvizdoZuDozC7Fc7j76el1akCc40tg9HPsE40pIQvxGrbcaZQ
	fhHJqiHsmrEV+pL//ra4VNOsfOWc1sYQdzaxy35jTdwFZzuLf+lErpk9eJBdtxeM6Q+DCaAfN+DrH
	CAfhRJ9A0tIePhROwxcBff41xrAni0eappVlqSUqlbshxALtTIhZYho1lnNITQnsdpu04h5Laoo8B
	3jgBscuZnHsYkMM8cFbdSBBEFC6BAESCPSoSzuOREQUM/MSZT6i+byg0OMd6bjZJQr4/KKxghQds3
	NtyzaFaw==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tYCJ3-0000000AxbX-1Zai;
	Wed, 15 Jan 2025 22:56:40 +0000
Message-ID: <417a5115-891b-41b9-bd2c-a77e813b4ef0@infradead.org>
Date: Wed, 15 Jan 2025 14:56:06 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 5/5] netconsole: docs: Add documentation for
 CPU number auto-population
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@meta.com, max@kutsevol.com, thepacketgeek@gmail.com
References: <20250115-netcon_cpu-v2-0-95971b44dc56@debian.org>
 <20250115-netcon_cpu-v2-5-95971b44dc56@debian.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250115-netcon_cpu-v2-5-95971b44dc56@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/15/25 5:35 AM, Breno Leitao wrote:
> Update the netconsole documentation to explain the new feature that
> allows automatic population of the CPU number.
> 
> The key changes include introducing a new section titled "CPU number
> auto population in userdata", explaining how to enable the CPU number
> auto-population feature by writing to the "populate_cpu_nr" file in the
> netconsole configfs hierarchy.
> 
> This documentation update ensures users are aware of the new CPU number
> auto-population functionality and how to leverage it for better
> demultiplexing and visibility of parallel netconsole output.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  Documentation/networking/netconsole.rst | 45 +++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
> index 94c4680fdf3e7e1a0020d11b44547acfd68072a5..bc9ccebdae7adadd7c57aef20a726536d7ab3173 100644
> --- a/Documentation/networking/netconsole.rst
> +++ b/Documentation/networking/netconsole.rst
> @@ -17,6 +17,8 @@ Release prepend support by Breno Leitao <leitao@debian.org>, Jul 7 2023
>  
>  Userdata append support by Matthew Wood <thepacketgeek@gmail.com>, Jan 22 2024
>  
> +Sysdata append support by Breno Leitao <leitao@debian.org>, Jan 15 2025
> +
>  Please send bug reports to Matt Mackall <mpm@selenic.com>
>  Satyam Sharma <satyam.sharma@gmail.com>, and Cong Wang <xiyou.wangcong@gmail.com>
>  
> @@ -238,6 +240,49 @@ Delete `userdata` entries with `rmdir`::
>  
>     It is recommended to not write user data values with newlines.
>  
> +CPU number auto population in userdata
> +--------------------------------------
> +
> +Inside the netconsole configfs hierarchy, there is a file called
> +`cpu_nr` under the `userdata` directory. This file is used to enable or disable
> +the automatic CPU number population feature. This feature automatically
> +populate the CPU number that is sending the message.

   populates

> +
> +To enable the CPU number auto-population::
> +
> +  echo 1 > /sys/kernel/config/netconsole/target1/userdata/cpu_nr
> +
> +When this option is enabled, the netconsole messages will include an additional
> +line in the userdata field with the format `cpu=<cpu_number>`. This allows the
> +receiver of the netconsole messages to easily differentiate and demultiplex
> +messages originating from different CPUs, which is particularly useful when
> +dealing with parallel log output.
> +
> +Example::
> +
> +  echo "This is a message" > /dev/kmsg
> +  12,607,22085407756,-;This is a message
> +   cpu=42
> +
> +In this example, the message was sent by CPU 42.
> +
> +.. note::
> +
> +   If the user has set a conflicting `cpu` key in the userdata dictionary,
> +   both keys will be reported, with the kernel-populated entry appearing after
> +   the user one. For example::
> +
> +     # User-defined CPU entry
> +     mkdir -p /sys/kernel/config/netconsole/target1/userdata/cpu
> +     echo "1" > /sys/kernel/config/netconsole/target1/userdata/cpu/value
> +
> +   Output might look like::
> +
> +     12,607,22085407756,-;This is a message
> +      cpu=1
> +      cpu=42    # kernel-populated value
> +
> +
>  Extended console:
>  =================
>  
> 

-- 
~Randy


