Return-Path: <linux-kselftest+bounces-43068-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D37E6BD6FE3
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 03:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2892B18A732E
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 01:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07202609DC;
	Tue, 14 Oct 2025 01:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vunw790x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5852E21D3E6;
	Tue, 14 Oct 2025 01:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760405876; cv=none; b=p0Vp2j/hAuxA7NfR/eWQbt4C1XXT4ROlKf33s5DylXAuG4fL8o7LjnTxFhxnlXq/nch188KDR93E5aiy0t8Ifhf60nOFUrjQ6WE/Rw8/CSvErfKR3XeBs+pHS73huH9oz/FhkvekK02HYfh3qblqUCicAJEsbf9/vBmAIcXlDNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760405876; c=relaxed/simple;
	bh=HrFBjoy4Zs+VZwHot4gEOtOJxRXfilQq4zCyRDBqeHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Rox6PwqCgz7tNdA+njPhqXNLOMrd+K4aHmtNuyO/vof1/MYHF72LOryXKZ5hgEDsK923CqiWjeNzhE0ICtE1Ggfl6BSBhkj2JbgDaPhZUXE1FbBC0hHZiwNSOuD0VNnvN1Wvgf7UTImNXadMxrJ+u3CmBYUxzfxBhq3NlSd9Lzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Vunw790x; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=SCW41sazUXG5KcMtr/XAw0GQBM/OgQxXYdOpaMbHEK8=; b=Vunw790xEYTNY49uEhIAewJymb
	X5GikfhFUMnMl1ReMC5pYd1Xn1RLzH93C4HAYlVR/5MEu6Rri2ErZ9/du8zhiCFmDbbPVkXSb6kBQ
	0AA3G9tsERMPDzo9RApk/350l6/1GQjLh8ExHR0hoN/son9IFKunn3cpwV5b3sbNfLBlzkjAEWnnl
	fRkGvuoT+TmAXOZ4AIqtD5lW46KClOooxYpNXv8ljjl19q7MmHh2tZICmayRdETwSetCKmp2vFm/8
	mPjAXxPvMTzmupw/prDDCTKAbl5DsN3yZc/0EapJIkVXicoPgsxMPGd16wHyOMFdv/ImqxcZlXB1v
	+fqikLhw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8Tyl-0000000EuFp-3tOW;
	Tue, 14 Oct 2025 01:37:31 +0000
Message-ID: <b16d76de-688a-4697-bcfe-06f2785a1d3c@infradead.org>
Date: Mon, 13 Oct 2025 18:37:30 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][v3] hung_task: Panic after fixed number of hung tasks
To: lirongqing <lirongqing@baidu.com>, Jonathan Corbet <corbet@lwn.net>,
 Russell King <linux@armlinux.org.uk>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Andrew Morton <akpm@linux-foundation.org>, Lance Yang
 <lance.yang@linux.dev>, Masami Hiramatsu <mhiramat@kernel.org>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>, Shuah Khan <shuah@kernel.org>,
 "Paul E . McKenney" <paulmck@kernel.org>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, Feng Tang
 <feng.tang@linux.alibaba.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Kees Cook
 <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Phil Auld <pauld@redhat.com>, Joel Granados <joel.granados@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 David Hildenbrand <david@redhat.com>, Florian Westphal <fw@strlen.de>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20251012115035.2169-1-lirongqing@baidu.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251012115035.2169-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 10/12/25 4:50 AM, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 

> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a51ab46..7d9a8ee 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1992,14 +1992,20 @@
>  			the added memory block itself do not be affected.
>  
>  	hung_task_panic=
> -			[KNL] Should the hung task detector generate panics.
> -			Format: 0 | 1
> +			[KNL] Number of hung tasks to trigger kernel panic.
> +			Format: <int>
> +
> +			Set this to the number of hung tasks that must be
> +			detected before triggering a kernel panic.
> +
> +			0: don't panic
> +			1: panic immediately on first hung task
> +			N: panic after N hung tasks are detect

			                            are detected

>  
> -			A value of 1 instructs the kernel to panic when a
> -			hung task is detected. The default value is controlled
> -			by the CONFIG_BOOTPARAM_HUNG_TASK_PANIC build-time
> -			option. The value selected by this boot parameter can
> -			be changed later by the kernel.hung_task_panic sysctl.
> +			The default value is controlled by the
> +			CONFIG_BOOTPARAM_HUNG_TASK_PANIC build-time option. The value
> +			selected by this boot parameter can be changed later by the
> +			kernel.hung_task_panic sysctl.
>  
>  	hvc_iucv=	[S390]	Number of z/VM IUCV hypervisor console (HVC)
>  				terminal devices. Valid values: 0..8


-- 
~Randy


