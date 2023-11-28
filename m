Return-Path: <linux-kselftest+bounces-687-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5937FAFFA
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 03:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1FEBB210C3
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 02:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89E24A3B;
	Tue, 28 Nov 2023 02:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uEw0olYp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D6020E5;
	Tue, 28 Nov 2023 02:15:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7249CC433C7;
	Tue, 28 Nov 2023 02:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701137729;
	bh=XfJwlAwJtcgZM2kH0vH5xqAnbMPT8rha/PkVQK+7j9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uEw0olYpKxEmA/M0Qq5UT/ckq6DKdhxOr/lbSRS7jI8DWBNYFiGzEb9s3541kpcqG
	 vLIXH7B0JZEl75RiD/3nN/OQiE34CbZqG6QpvJ5l7kZY4DDTEuIXbUWjUKw3qo3SrL
	 9lpub5+3MNRtSt0X/sNEAxiIWgulV+RRLuc55Y97yhfUDnEj1ZnOPWnyOw6X7et/fx
	 ZS0YDkbs+FJeUk6iAPCIgkqHifW/ZjjoBxDi8Te8LKGSpNmmP0zGhjQfR6pcPU9fJi
	 lwcWXCqENtfCmlsQGC0igjBNjg16lY8DA2+kh+0F4WNGp0EU//WQU0rdmRrT0FOLup
	 GqWpNEc5MAiEA==
Date: Mon, 27 Nov 2023 18:15:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 llvm@lists.linux.dev, Davide Caratti <dcaratti@redhat.com>
Subject: Re: [PATCH net-next 1/5] selftests: tc-testing: remove buildebpf
 plugin
Message-ID: <20231127181527.1101e015@kernel.org>
In-Reply-To: <20231124154248.315470-2-pctammela@mojatatu.com>
References: <20231124154248.315470-1-pctammela@mojatatu.com>
	<20231124154248.315470-2-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Nov 2023 12:42:44 -0300 Pedro Tammela wrote:
> diff --git a/tools/testing/selftests/tc-testing/Makefile b/tools/testing/selftests/tc-testing/Makefile
> index b1fa2e177e2f..e8b3dde4fa16 100644
> --- a/tools/testing/selftests/tc-testing/Makefile
> +++ b/tools/testing/selftests/tc-testing/Makefile
> @@ -1,31 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
> -include ../../../scripts/Makefile.include
>  
> -top_srcdir = $(abspath ../../../..)
> -APIDIR := $(top_scrdir)/include/uapi
> -TEST_GEN_FILES = action.o
> +TEST_PROGS += ./tdc.sh

nit: could you try to remove the ./ prefix, as a follow up? 
     I think it's not necessary and it confuses one of patchwork checks.

