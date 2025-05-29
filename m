Return-Path: <linux-kselftest+bounces-34004-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D235AC8064
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 17:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67EBD1BC1BBF
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 15:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F23921D5B8;
	Thu, 29 May 2025 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JB5BPeYc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BAE193062;
	Thu, 29 May 2025 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748533093; cv=none; b=rUggtpcIhnY19rpMGp/n53Ly++jqweAb1BfzHuCZfNVurtlFabY1eG6pNZZf4BW2Ca2YRwk85hnO3zWSksEtzGLe109IWUrxpM8yuR6H+uRuFb2OtWHk+kKWm0vTlD3AIF2wUbYak+qkwz23feFIP6Z62nzL1qQnerCpvlNCVVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748533093; c=relaxed/simple;
	bh=QY/uUcRJyfteJmKGYui1rdr+O14scrNoowuHI6u9dwA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PCm/hVCToLwLvAWqoyfeGTOCf/0ED8nGY8cO1GFyl6r1zvZ0GMWmkNcDDBHyEpvLQthbtqlGQlYUYiZK7oboP4rdyYFf8gzowtC8KkkZ+/UGJa2Yvi1kt+MCmteDmpOPW6p3nnDdcDuHrR6+/cq2kyjg0V8vrjF2Ra5XmWFmL1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JB5BPeYc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18702C4CEE7;
	Thu, 29 May 2025 15:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748533092;
	bh=QY/uUcRJyfteJmKGYui1rdr+O14scrNoowuHI6u9dwA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JB5BPeYcPYfUkka330web7NljVOJbydKWX/PIunMFLuxwjOOji3I/GzH4y3yIgard
	 KFxrQogU7wZSJl8QgWmHuFw7DpQgFHBAdgyrnVrp5PCyhZ1p0cHP8dKazUiboytB0d
	 S8ZIgoyZ41TNYZ1tZifqAnsHBrpSHd4Om7Wr5GHTjbNxXRWWV38gjCfWGHcIdPts6Z
	 aKOmVLlawTr2kIL984Ae+uqZ7Zo5POiogQzGcwcf+HAlUdI/+UhcLjXCL1SWmcqmDo
	 7fYkX5MDh50XLNDfYUD3KO8ECfbc6nZ0/nB4CLANdc+b4nmZQU4yJeDI59/g5761Ie
	 It2q81JVBI7fQ==
Date: Thu, 29 May 2025 08:38:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: brendan.higgins@linux.dev, davidgow@google.com, rmoar@google.com,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] kunit: configs: Enable CONFIG_INIT_STACK_ALL_PATTERN in
 all_tests
Message-ID: <20250529083811.778bc31b@kernel.org>
In-Reply-To: <20250411095904.1593224-1-rf@opensource.cirrus.com>
References: <20250411095904.1593224-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Apr 2025 10:59:04 +0100 Richard Fitzgerald wrote:
> Enable CONFIG_INIT_STACK_ALL_PATTERN in all_tests.config. This helps
> to detect use of uninitialized local variables.
> 
> This option found an uninitialized data bug in the cs_dsp test.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  tools/testing/kunit/configs/all_tests.config | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
> index cdd9782f9646..4a60bb71fe72 100644
> --- a/tools/testing/kunit/configs/all_tests.config
> +++ b/tools/testing/kunit/configs/all_tests.config
> @@ -10,6 +10,7 @@ CONFIG_KUNIT_EXAMPLE_TEST=y
>  CONFIG_KUNIT_ALL_TESTS=y
>  
>  CONFIG_FORTIFY_SOURCE=y
> +CONFIG_INIT_STACK_ALL_PATTERN=y

This breaks kunit for older compilers:

$ ./tools/testing/kunit/kunit.py run  --alltests --json --arch=x86_64 
 Configuring KUnit Kernel ...
 Regenerating .config ...
 Populating config with:
 $ make ARCH=x86_64 O=.kunit olddefconfig
 ERROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
 This is probably due to unsatisfied dependencies.
 Missing: CONFIG_INIT_STACK_ALL_PATTERN=y

$ gcc --version
 gcc (GCC) 11.5.0 20240719 (Red Hat 11.5.0-5)

IIUC GCC 11.5 is supported so pattern init can't be a hard requirement.
How about we do this instead? Can you check if it'd work for you?

diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index c17366ce8224..904b99f34cd0 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -113,6 +113,7 @@ choice
                bool "pattern-init everything (strongest)"
+               default KUNIT_ALL_TESTS
                depends on CC_HAS_AUTO_VAR_INIT_PATTERN
                depends on !KMSAN
                help
                  Initializes everything on the stack (including padding)
                  with a specific debug value. This is intended to eliminate

