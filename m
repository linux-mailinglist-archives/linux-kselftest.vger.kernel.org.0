Return-Path: <linux-kselftest+bounces-11718-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94280904729
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 00:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE992862BD
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 22:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA43155381;
	Tue, 11 Jun 2024 22:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oYfRHv+u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C034046444;
	Tue, 11 Jun 2024 22:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718145672; cv=none; b=T9H/+xrAVkm5YrmE/WlapM7MKn94lIsCWxkw/7NQn2D14azIULVbGfZGRhuf+l13IYpdP5FyqBKLjzNO2AL961MR4BwrKYFcTDQf2jSxcxZJd9X0t9P9zcJIOo053hALTKmsgwuJHyVJmd2srRy3Y/jyh3m+otlmATEoPim4ZL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718145672; c=relaxed/simple;
	bh=OhZYm424562dFi7gzOtDyfJQyLHkoQIZJKgJaFXdMDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IlGucj+tRUocXMT7GTBxUW0fVAkHXFNPgBoak+eopQAdPBCvdDMZ3v4kgGHzAwhw8fxYytbk7Gw/LlVFr9n6TG0ADpsqyae02jr+XKqVSHM5T4ztxKou95mkSeGOHUsDtFFK0zpkYSHF9vQX5Nptac66lOQLUu4tXQsDUZXjfrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oYfRHv+u; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ywBbGaPOeq2fMv0XWMs74qxEU0SIGLuY7vHTY5iY8/k=; b=oYfRHv+u76v9FmwrmVNPqx9Acx
	vRC8Qia98qviQJkpLtLhmC70Kzmp6BgZiYZ8dbtnmSvv6PlG5AXS821CxgaJu+unAv0KTvOt2HZUi
	flJ50feCWZ4gblKUmybyg/eIDnWEgtrdrIoKCa1ulwlg7+1w3Q1CbWcAcfiW5ETJ8+RcEpaL9EGL+
	jeAKBbI280YfuY4zgFggRWPrQJB3VA3UqKnEICeNtE2Tlqwkhgoq83k5vJPD212DK1m/zjISUGvlb
	yNaTnzJPITdbXTgFh7FC/lJBVd/xicmdqm0BiSLQiSpRxq/nsZ6Dv6DCWB8zl28Y+pvL3VIYdxBlN
	9KrOvEZg==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHAAn-0000000AQia-0nYq;
	Tue, 11 Jun 2024 22:41:01 +0000
Message-ID: <595b6353-6da6-432b-96b4-42c4e3ec1146@infradead.org>
Date: Tue, 11 Jun 2024 15:40:59 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mm/memfd: add documentation for MFD_NOEXEC_SEAL
 MFD_EXEC
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, cyphar@cyphar.com, david@readahead.eu,
 dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
 jeffxu@google.com, jorgelo@chromium.org, keescook@chromium.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, pobrn@protonmail.com, skhan@linuxfoundation.org,
 stable@vger.kernel.org
References: <20240611034903.3456796-1-jeffxu@chromium.org>
 <20240611034903.3456796-2-jeffxu@chromium.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240611034903.3456796-2-jeffxu@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/10/24 8:49 PM, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> Add documentation for memfd_create flags: MFD_NOEXEC_SEAL
> and MFD_EXEC
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> 
> ---
>  Documentation/userspace-api/index.rst      |  1 +
>  Documentation/userspace-api/mfd_noexec.rst | 86 ++++++++++++++++++++++
>  2 files changed, 87 insertions(+)
>  create mode 100644 Documentation/userspace-api/mfd_noexec.rst
> 
> diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
> index 5926115ec0ed..8a251d71fa6e 100644
> --- a/Documentation/userspace-api/index.rst
> +++ b/Documentation/userspace-api/index.rst
> @@ -32,6 +32,7 @@ Security-related interfaces
>     seccomp_filter
>     landlock
>     lsm
> +   mfd_noexec
>     spec_ctrl
>     tee
>  
> diff --git a/Documentation/userspace-api/mfd_noexec.rst b/Documentation/userspace-api/mfd_noexec.rst
> new file mode 100644
> index 000000000000..ec6e3560fbff
> --- /dev/null
> +++ b/Documentation/userspace-api/mfd_noexec.rst
> @@ -0,0 +1,86 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==================================
> +Introduction of non executable mfd

Missed:
                   non-executable

> +==================================
> +:Author:
> +    Daniel Verkamp <dverkamp@chromium.org>
> +    Jeff Xu <jeffxu@chromium.org>
> +
> +:Contributor:
> +	Aleksa Sarai <cyphar@cyphar.com>
> +
> +Since Linux introduced the memfd feature, memfds have always had their
> +execute bit set, and the memfd_create() syscall doesn't allow setting
> +it differently.
> +
> +However, in a secure-by-default system, such as ChromeOS, (where all
> +executables should come from the rootfs, which is protected by verified
> +boot), this executable nature of memfd opens a door for NoExec bypass
> +and enables “confused deputy attack”.  E.g, in VRP bug [1]: cros_vm
> +process created a memfd to share the content with an external process,
> +however the memfd is overwritten and used for executing arbitrary code
> +and root escalation. [2] lists more VRP of this kind.
> +
> +On the other hand, executable memfd has its legit use: runc uses memfd’s
> +seal and executable feature to copy the contents of the binary then
> +execute them. For such a system, we need a solution to differentiate runc's
> +use of executable memfds and an attacker's [3].
> +
> +To address those above:
> + - Let memfd_create() set X bit at creation time.
> + - Let memfd be sealed for modifying X bit when NX is set.
> + - Add a new pid namespace sysctl: vm.memfd_noexec to help applications to

                                                         help applications in

> +   migrating and enforcing non-executable MFD.
> +
> +User API
> +========

The rest looks good. Thanks.

-- 
~Randy

