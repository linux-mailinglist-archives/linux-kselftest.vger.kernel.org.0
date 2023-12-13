Return-Path: <linux-kselftest+bounces-1814-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8B5810B6B
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 08:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A2851C20FC5
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 07:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA5118C07;
	Wed, 13 Dec 2023 07:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="boPZd2hx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9BBC14F;
	Wed, 13 Dec 2023 07:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8947CC433C9;
	Wed, 13 Dec 2023 07:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702452282;
	bh=1fqvxKFylBtBPcoXQPyYTVMKhnaamEgQ++fwy6GHEkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=boPZd2hxFPasz5O41tQ5oqu+2UKNIgQgPPUhaqWQ3hQfkC0+UezbISRFJN2VRdcZu
	 XxZDJV8C3w3Ks0nS3LzxYkdJDukb0SHKTkXSxe0SlepWr9HyNjLK7A/aP+c3+Fs1L1
	 CP8FBi4QmpJc/9etU1QzET4clOkK3L9Gms1ybH8s=
Date: Wed, 13 Dec 2023 08:24:39 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
	sroettger@google.com, willy@infradead.org,
	torvalds@linux-foundation.org, jeffxu@google.com,
	jorgelo@chromium.org, groeck@chromium.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
Subject: Re: [RFC PATCH v3 01/11] mseal: Add mseal syscall.
Message-ID: <2023121343-scalping-urging-0dbc@gregkh>
References: <20231212231706.2680890-1-jeffxu@chromium.org>
 <20231212231706.2680890-2-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212231706.2680890-2-jeffxu@chromium.org>

On Tue, Dec 12, 2023 at 11:16:55PM +0000, jeffxu@chromium.org wrote:
> +config MSEAL
> +	default n

Minor nit, "n" is always the default, no need to call it out here.

> +	bool "Enable mseal() system call"
> +	depends on MMU
> +	help
> +	  Enable the virtual memory sealing.
> +	  This feature allows sealing each virtual memory area separately with
> +	  multiple sealing types.

You might want to include more documentation as to what this is for,
otherwise distros / users will not know if they need to enable this
or not.

thanks,

greg k-h

