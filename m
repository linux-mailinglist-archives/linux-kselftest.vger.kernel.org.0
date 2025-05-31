Return-Path: <linux-kselftest+bounces-34097-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BE9AC98B8
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 May 2025 03:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32781BA5EC0
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 May 2025 01:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABB0EAF9;
	Sat, 31 May 2025 01:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIb2ib9a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E03C610D;
	Sat, 31 May 2025 01:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748653672; cv=none; b=eyjMIyWs4WE4j8jHc/cIEUN/UaOXKq354S7ns10iFZDkcvbFUymawpltBrWwOeeOcdq6HeM81YWQ+lpSL34Sx8R72Bl85++eUAu9BDzDOxx/HqP5HcicBMBeN/f6P3fqPEiEj2sY6b8S64XcRcfdZpuK7vXV+DBx9MJUizQkZPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748653672; c=relaxed/simple;
	bh=sAY+KKOh4dL6fGDFlataz+zoSNoAKHS7ZH2uGv8Kobw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IyWhFuZp6/Ow/wZtPamHg+zEutbKfOQDzF3Pc/L3dCgub4INJNewTfqi6N+r2FNrhmtfFl4EQcVkCScEW95hRiwJb8rTSwvMllW8jGt45nddR+VRdc8mTiV1OOGa+evjuSqWp7ubwKmkPR1/VvArxigxMJi4r5eiNzouUrJHD4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIb2ib9a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E30C4CEEB;
	Sat, 31 May 2025 01:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748653671;
	bh=sAY+KKOh4dL6fGDFlataz+zoSNoAKHS7ZH2uGv8Kobw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BIb2ib9aoL4fiOjmLev0FLBO2BW/12tVA39QsLDi6GL5YdTrNJviGnk+zRVPXzT4D
	 ch/GjFguRC02R63ifr7IIj3b9iaJMEzocnJ6BU1WgcYwe8yEtFPce3hbPxCy7t6Ymw
	 I0w6YfvbwKVNlK/bvl2uL2XCgYhs3wstwh0VhtRUbAcB/MHX8O5VFMVYIuQwiy793U
	 R9VCX0EDSufCzfnpkEccl/qbsTYmefPUelTsbmqrokqPhRmWHsiNgCxZp9Jd2DsaIf
	 FD+1MtvvPZgYJYt9WVd3HDjehU+WFJ1Q9rGoS1Z8Yr2X/8fU5rWP7YdyDVNtn6rWb4
	 Cdk4u/7pOZEIw==
Date: Fri, 30 May 2025 18:07:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, brendan.higgins@linux.dev,
 davidgow@google.com, rmoar@google.com, broonie@kernel.org,
 rf@opensource.cirrus.com, mic@digikod.net, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com
Subject: Re: [PATCH net] Revert "kunit: configs: Enable
 CONFIG_INIT_STACK_ALL_PATTERN in all_tests"
Message-ID: <20250530180750.4c722f71@kernel.org>
In-Reply-To: <9628c61e-234f-45af-bc30-ab6db90f09c6@linuxfoundation.org>
References: <20250530135800.13437-1-kuba@kernel.org>
	<9628c61e-234f-45af-bc30-ab6db90f09c6@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 May 2025 10:59:54 -0600 Shuah Khan wrote:
> On 5/30/25 07:58, Jakub Kicinski wrote:
> > This reverts commit a571a9a1b120264e24b41eddf1ac5140131bfa84.
> > 
> > The commit in question breaks kunit for older compilers:  
> > > $ gcc --version  
> >   gcc (GCC) 11.5.0 20240719 (Red Hat 11.5.0-5)
> > 
> > $ ./tools/testing/kunit/kunit.py run  --alltests --json --arch=x86_64
> >   Configuring KUnit Kernel ...
> >   Regenerating .config ...
> >   Populating config with:
> >   $ make ARCH=x86_64 O=.kunit olddefconfig  
> 
> 
> >   ERROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
> >   This is probably due to unsatisfied dependencies.
> >   Missing: CONFIG_INIT_STACK_ALL_PATTERN=y  
> 
> Does adding config option work for you?
> ./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_INIT_STACK_ALL_PATTERN

Nope (with this patch applied):

$ ./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_INIT_STACK_ALL_PATTERN=y
[18:02:47] Configuring KUnit Kernel ...
Regenerating .config ...
Populating config with:
$ make ARCH=um O=.kunit olddefconfig
ERROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
This is probably due to unsatisfied dependencies.
Missing: CONFIG_INIT_STACK_ALL_PATTERN=y
Note: many Kconfig options aren't available on UML. You can try running on a different architecture with something like "--arch=x86_64".

> > Link: https://lore.kernel.org/20250529083811.778bc31b@kernel.org
> > Fixes: a571a9a1b120 ("kunit: configs: Enable CONFIG_INIT_STACK_ALL_PATTERN in all_tests")
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > ---
> > I'd like to take this in via netdev since it fixes our CI.
> > We'll send it to Linus next week.
> >   
> 
> I am good with reverting it for now.
> 
> David, Brendan,
> We will have to enable this at a later time. Also we saw this problem
> before with other configs. Anyway way to fix this for alltests case?

FWIW Richard commented in the linked thread, IIUC this was just for
added coverage but not a hard requirement.

