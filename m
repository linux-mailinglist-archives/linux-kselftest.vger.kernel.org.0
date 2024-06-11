Return-Path: <linux-kselftest+bounces-11633-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A4F902E44
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 04:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25E01F224B9
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 02:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB08A94C;
	Tue, 11 Jun 2024 02:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NjeOmRux"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374A411712;
	Tue, 11 Jun 2024 02:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718072460; cv=none; b=sHxcPKTzIvaX0uQVlvVxqE0zKgYt95e2OuUqRrfY6aaRaM+4iDqyWlE7ru0L7utsf3bk92WrsKGoNWCAtaKblmj3A0Q/feJad2TrRLQ2r169TyrR2TJcI5r8TKTTwQvlT4erKWyPths3iV4sAupEa6k9D5FBqyGCxmV3pBdhYBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718072460; c=relaxed/simple;
	bh=V/PNTQDmYRnF9nQiLdiCEupgRkUujKPkEQVHPU+HxQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QARuKi0Za15KjRoUplK0M4HJmhmeHsR+RgqitsUwgXG1B2VOz4FAahx11ssp0zdPbN6iZqjKh8JxO9pJ+oH8vppvdgKboIar7NQBz57D18NFurxluRxQ5lzDOL5eGzh+dpQAZFFqgE92ZaO7rGPsPeRDaFNLN8CMEZ1nkkq2BTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NjeOmRux; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=d2cLskHqQK8hk38s4/1iX9SZkTIRIUV1aAaRQUth+3s=; b=NjeOmRuxVwrN8/kyK0fzcbla/G
	gjIVdM91KO0RO2HMnkLvsGdSplTE4NWKp/Zhtxnp/p3r6Wz+IOmusIr+z/iY0Lr7Te7xrTsEglxRF
	yzQVbMjWtDb3qZLjxt/PhBdJWcpSHAcgBJsIqGCJ0r4KipCq44vOuYeQa5FFH3Vj80hs26sCv8Z+M
	+i1jQLamzvjPcoxIBOKlNhumX61Mmpk26pWgDffWFH/HpERgm2xjAy2kG18mA7Kz/nFm+ZhuCVpcw
	trLo88MRF1Pv+0JwdwKJ+5G3N+e+owWfVtBUcAgONcWn9nFZtu1wBVT0Og+W1Sv9u6+mIS9shpmui
	ClLZNo9w==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGr7x-000000078R6-2y2o;
	Tue, 11 Jun 2024 02:20:49 +0000
Message-ID: <0988dfae-69d0-4fbf-b145-15f6e853cbcc@infradead.org>
Date: Mon, 10 Jun 2024 19:20:48 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] mm/memfd: add documentation for MFD_NOEXEC_SEAL
 MFD_EXEC
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, cyphar@cyphar.com, david@readahead.eu,
 dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
 jeffxu@google.com, jorgelo@chromium.org, keescook@chromium.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, pobrn@protonmail.com, skhan@linuxfoundation.org,
 stable@vger.kernel.org
References: <20240607203543.2151433-1-jeffxu@google.com>
 <20240607203543.2151433-2-jeffxu@google.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240607203543.2151433-2-jeffxu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi--

On 6/7/24 1:35 PM, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> Add documentation for memfd_create flags: FMD_NOEXEC_SEAL

s/FMD/MFD/

> and MFD_EXEC
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
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
> index 000000000000..0d2c840f37e1
> --- /dev/null
> +++ b/Documentation/userspace-api/mfd_noexec.rst
> @@ -0,0 +1,86 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==================================
> +Introduction of non executable mfd

                   non-executable mfd

> +==================================
> +:Author:
> +    Daniel Verkamp <dverkamp@chromium.org>
> +    Jeff Xu <jeffxu@chromium.org>
> +
> +:Contributor:
> +	Aleksa Sarai <cyphar@cyphar.com>
> +
> +Since Linux introduced the memfd feature, memfd have always had their

                                             memfds
i.e., plural

> +execute bit set, and the memfd_create() syscall doesn't allow setting
> +it differently.
> +
> +However, in a secure by default system, such as ChromeOS, (where all

                 secure-by-default

> +executables should come from the rootfs, which is protected by Verified
> +boot), this executable nature of memfd opens a door for NoExec bypass
> +and enables “confused deputy attack”.  E.g, in VRP bug [1]: cros_vm
> +process created a memfd to share the content with an external process,
> +however the memfd is overwritten and used for executing arbitrary code
> +and root escalation. [2] lists more VRP in this kind.

                                           of this kind.

> +
> +On the other hand, executable memfd has its legit use, runc uses memfd’s

                                                     use:

> +seal and executable feature to copy the contents of the binary then
> +execute them, for such system, we need a solution to differentiate runc's

           them. For such a system,

> +use of  executable memfds and an attacker's [3].
> +
> +To address those above.

                    above:

> + - Let memfd_create() set X bit at creation time.
> + - Let memfd be sealed for modifying X bit when NX is set.
> + - A new pid namespace sysctl: vm.memfd_noexec to help applications to

    - Add a new                                           applications in

> +   migrating and enforcing non-executable MFD.
> +
> +User API
> +========
> +``int memfd_create(const char *name, unsigned int flags)``
> +
> +``MFD_NOEXEC_SEAL``
> +	When MFD_NOEXEC_SEAL bit is set in the ``flags``, memfd is created
> +	with NX. F_SEAL_EXEC is set and the memfd can't be modified to
> +	add X later. MFD_ALLOW_SEALING is also implied.
> +	This is the most common case for the application to use memfd.
> +
> +``MFD_EXEC``
> +	When MFD_EXEC bit is set in the ``flags``, memfd is created with X.
> +
> +Note:
> +	``MFD_NOEXEC_SEAL`` implies ``MFD_ALLOW_SEALING``. In case that
> +	app doesn't want sealing, it can add F_SEAL_SEAL after creation.

        an app

> +
> +
> +Sysctl:
> +========
> +``pid namespaced sysctl vm.memfd_noexec``
> +
> +The new pid namespaced sysctl vm.memfd_noexec has 3 values:
> +
> + - 0: MEMFD_NOEXEC_SCOPE_EXEC
> +	memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
> +	MFD_EXEC was set.
> +
> + - 1: MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL
> +	memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
> +	MFD_NOEXEC_SEAL was set.
> +
> + - 2: MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED
> +	memfd_create() without MFD_NOEXEC_SEAL will be rejected.
> +
> +The sysctl allows finer control of memfd_create for old-software that

                                                       old software

> +doesn't set the executable bit, for example, a container with

                              bit;

> +vm.memfd_noexec=1 means the old-software will create non-executable memfd

                               old software

> +by default while new-software can create executable memfd by setting

                    new software

> +MFD_EXEC.
> +
> +The value of vm.memfd_noexec is passed to child namespace at creation
> +time, in addition, the setting is hierarchical, i.e. during memfd_create,

   time. In addition,

> +we will search from current ns to root ns and use the most restrictive
> +setting.
> +
> +[1] https://crbug.com/1305267
> +
> +[2] https://bugs.chromium.org/p/chromium/issues/list?q=type%3Dbug-security%20memfd%20escalation&can=1
> +
> +[3] https://lwn.net/Articles/781013/

-- 
~Randy

