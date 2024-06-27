Return-Path: <linux-kselftest+bounces-12879-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DF991AFDC
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 21:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E421C2223A
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 19:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F2A19AD7B;
	Thu, 27 Jun 2024 19:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncJYO6dW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3966D2D047;
	Thu, 27 Jun 2024 19:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719517901; cv=none; b=A4tt0b9N0S/6pUnXINAza0S26GNADWy+udktmqeolW3oEKXYRky3QQwbfEK3sk+8ko+0KwQwiQtxIgHHa8E7KynLMIjXJBxW4L83w5vfUrJhkxUnW30HSX/3xQH/Mlqdn/ZAWTbEpDtb6JM+AiOopr5Zkq6opPcXRlUrQng6GQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719517901; c=relaxed/simple;
	bh=Nu1MRTR8v5XZDzasqGr9q3u/QsN2RJit7rTafzcIyNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rs9ZVj6qi430hk++56IJDB4AlSIreaIdcoE28XbPkfUPyWuAbuevisUOkEbfAbRgdLcwlrM7t17wIILSsePY0aW5O5ZQgfxX9bCF4PE1drDsyUs/071dvWHXq30IrJ79xiY9Ew9C9QjSXAvS1EO3mahzhA87uahXCwOVj+NhF5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncJYO6dW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1951C2BBFC;
	Thu, 27 Jun 2024 19:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719517900;
	bh=Nu1MRTR8v5XZDzasqGr9q3u/QsN2RJit7rTafzcIyNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ncJYO6dWOutz3bVPLug/SKtimLBtIFl2hZJ2Q1YZ9intQ04YU2is9yRqu0Y99Cbd5
	 bhfVqX9W4LqJW5DuwPbvxYXYV0R7nPVcFMa6dGisKLYI/xFZhUoPRzf5o9Mvf5g0aK
	 9BYglQSXNObyOf3Blf200WvjFm5/5SJWGy1FEGPC+5xyRzljYw3AIvhZm3tpmo8K40
	 fgg3vpGa1XWzyRpRP/ytzSwx8C27OhzvU4ogPO6JytvVMANzjksPoQraxajkzt3QEc
	 GO/AE0Qfah2TTBZEvKhq1xM0ExorUyyjmLiTpb0gllKaR3BBYMXMCfRNDPMcN4b6zw
	 RJ5Y6tvKiuZzw==
Date: Thu, 27 Jun 2024 12:51:40 -0700
From: Kees Cook <kees@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Mark Rutland <mark.rutland@arm.com>, David Gow <davidgow@google.com>,
	Vitor Massaru Iha <vitor@massaru.org>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Rae Moar <rmoar@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 1/2] kunit: test: Add vm_mmap() allocation resource
 manager
Message-ID: <202406271250.A227529@keescook>
References: <20240612195412.make.760-kees@kernel.org>
 <20240612195921.2685842-1-kees@kernel.org>
 <d32df98c-fd3c-466b-bc8f-47cec1c7bebf@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d32df98c-fd3c-466b-bc8f-47cec1c7bebf@roeck-us.net>

On Sat, Jun 22, 2024 at 06:47:39AM -0700, Guenter Roeck wrote:
> Hi,
> 
> On Wed, Jun 12, 2024 at 12:59:18PM -0700, Kees Cook wrote:
> > For tests that need to allocate using vm_mmap() (e.g. usercopy and
> > execve), provide the interface to have the allocation tracked by KUnit
> > itself. This requires bringing up a placeholder userspace mm.
> > 
> > This combines my earlier attempt at this with Mark Rutland's version[1].
> > 
> > Normally alloc_mm() and arch_pick_mmap_layout() aren't exported for
> > modules, so export these only for KUnit testing.
> > 
> > Link: https://lore.kernel.org/lkml/20230321122514.1743889-2-mark.rutland@arm.com/ [1]
> 
> FWIW, not sure I understand what the above link has to do with this patch.

Both the above Link and this patch were implementing KUnit usercopy
tests (and the required infrastructure).

> 
> > Co-developed-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Reviewed-by: David Gow <davidgow@google.com>
> > Signed-off-by: Kees Cook <kees@kernel.org>
> 
> This patch results in a build failure for nommu_kc705_defconfig if kunit tests
> are also enabled.
> 
> ERROR: modpost: vmlinux: local symbol 'arch_pick_mmap_layout' was exported
> 
> If CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT=n, CONFIG_MMU=n, and
> CONFIG_KUNIT=y, arch_pick_mmap_layout is exported. However, if
> CONFIG_MMU=n, it is declared as static inline function.

I replied in the other thread too, but this has had a fix pending:
https://lore.kernel.org/lkml/202406271005.4E767DAE@keescook/

I pinged the patch again today.

-Kees

-- 
Kees Cook

