Return-Path: <linux-kselftest+bounces-16976-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A658D968944
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 15:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58B561F221A5
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 13:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5949B20FA8B;
	Mon,  2 Sep 2024 13:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZaG7VmH1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9FF20127D;
	Mon,  2 Sep 2024 13:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725285463; cv=none; b=amiyl7CAfbLJcJiq5fccY1u3+sDgO1Jv+svIjZyVTLehoV5OqiXYbhono45ijOp5L6VXARirLV4NeG5eRQv1KyNip6nQ7/20NrRPxriyK6WzisAh7sKj2byQzWDPlD9yUDNTNgBlqbNOE7c7YahWwzgDmuXoDpUyZ8tk1TFmgTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725285463; c=relaxed/simple;
	bh=K3Nz0t56Y4xmMOv2gO7zRPgnO0PXH8nPl6/yC/1uBoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZU5SHmNNVS4RrFCgUDMw1JJJts+Ve42Bh8+s6XDVDYnl3VsE4Cm3uzcRobyD8DuuERDLp+fvbO+KgKFVSrkMzquUofF/IRdznsnjgBcF/uDeO6dzC8JRt3DkA5LHqTynbWnzGBYYbczvVDMORzXfjFjsqeFKRjCUDRUiZF0sDXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=ZaG7VmH1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C830C4CEC2;
	Mon,  2 Sep 2024 13:57:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZaG7VmH1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725285459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2QnrBZwa4ejRMDjXi2anDzBPi6AUjES+ZWZ/N14PmWg=;
	b=ZaG7VmH1Gu8z1MTPddZIqchgCHOgTeb2+WrfVBW/ZLRDJtpXfCQxsBz60gtsLPQvFWlpMW
	8dAbQ1PRk87pD3dXTztw9DGQZ5tTqQ58snrY4+mmztFjCmWeKlFIN/+XUeoGCjojeTfsNW
	9xIL7vKNkD2mkhqb9uqAIYikaI5qIZU=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 65390bb6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Sep 2024 13:57:39 +0000 (UTC)
Date: Mon, 2 Sep 2024 15:57:37 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH] selftests: vDSO: Do not rely on $ARCH for
 vdso_test_getrandom && vdso_test_chacha
Message-ID: <ZtXEUZC_jRBSAG9k@zx2c4.com>
References: <ddf594c81787dba708fc392cb03027470dee64fb.1725124064.git.christophe.leroy@csgroup.eu>
 <ZtRqp-uZe5C07qOF@zx2c4.com>
 <fe8ea6a6-71d7-4cfc-b20b-fa0a7f39a4be@csgroup.eu>
 <ec7bfeb4-30aa-4874-98b7-7877a12cb98f@sirena.org.uk>
 <ffc5600d-362f-4400-8f8b-a1ea77ca51bf@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ffc5600d-362f-4400-8f8b-a1ea77ca51bf@csgroup.eu>

On Mon, Sep 02, 2024 at 03:23:47PM +0200, Christophe Leroy wrote:
> 
> 
> Le 02/09/2024 à 14:37, Mark Brown a écrit :
> > On Mon, Sep 02, 2024 at 02:22:38PM +0200, Christophe Leroy wrote:
> > 
> >> When vdso_test_getcpu doesn't find the vDSO entry point, it prints an error
> >> text and returns KSFT_SKIP
> > 
> >> I thought it would be more correct to have the same behaviour on
> >> vdso_test_getrandom instead of trying to build it only when the underlying
> >> kernel supports it.
> > 
> > The problem is that the test incorporates assembler code so it simply
> > won't build for architectures without explicit porting, the issue isn't
> > if the target kernel supports it but rather that the test won't compile
> > in the first place.
> 
> Yes indeed and that was the purpose of my patch, have a macro in 
> vdso_config.h to tell where the assembler code is:
> 
> diff --git a/tools/testing/selftests/vDSO/vdso_config.h 
> b/tools/testing/selftests/vDSO/vdso_config.h
> index 740ce8c98d2e..693920471160 100644
> --- a/tools/testing/selftests/vDSO/vdso_config.h
> +++ b/tools/testing/selftests/vDSO/vdso_config.h
> @@ -47,6 +47,7 @@
>   #elif defined(__x86_64__)
>   #define VDSO_VERSION		0
>   #define VDSO_NAMES		1
> +#define VDSO_GETRANDOM	 
> "../../../../arch/x86/entry/vdso/vgetrandom-chacha.S"
>   #elif defined(__riscv__) || defined(__riscv)
>   #define VDSO_VERSION		5
>   #define VDSO_NAMES		1
> 
> 
> And then:
> 
> diff --git a/tools/testing/selftests/vDSO/vdso_test_chacha-asm.S 
> b/tools/testing/selftests/vDSO/vdso_test_chacha-asm.S
> new file mode 100644
> index 000000000000..8e704165f6f2
> --- /dev/null
> +++ b/tools/testing/selftests/vDSO/vdso_test_chacha-asm.S
> @@ -0,0 +1,7 @@
> +#include "vdso_config.h"
> +
> +#ifdef VDSO_GETRANDOM
> +
> +#include VDSO_GETRANDOM
> +
> +#endif
> 
> I thought it was a lot easier to handle if through necessary #ifdefs in 
> vdso_config.h that implementing an additional logic in Makefiles.

Yet it still tripped up the test robot, right?

In general I'm not crazy about this approach.

