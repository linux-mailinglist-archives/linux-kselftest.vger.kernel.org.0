Return-Path: <linux-kselftest+bounces-947-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BD78004B4
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 08:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ACA3B20F61
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 07:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614EE14276;
	Fri,  1 Dec 2023 07:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUp7DIEj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4076C11CB6;
	Fri,  1 Dec 2023 07:22:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E753C433C7;
	Fri,  1 Dec 2023 07:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701415373;
	bh=cdjeJOqRJegDUJ+r2nXQhJunoNYS7wXNT6uyjhvnUpQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CUp7DIEj3Uk6E/e+5UPwxczCnoCGhssihrB5iXoCB3ghKPamwvj+H8hmTp7rTPWKt
	 GDVxX64IB6e4RryIcjVeyc+OVCHfb0CZHiTfa2TSsVY4+gZKjzmofjUTTKn7TMbhHW
	 FY4d4Xci4ZxLRMgYHg/zTEhlEM1EF1cJnkxhch1Jpw8USZKG37E6VqAiqOMQ8n2OH7
	 ooTRdI058SUhn/HSxt9ZGaz3HlBLnSBDtiUt86YjrJR/W+ifKcRjesBhsVK4c/zzrq
	 1xyb33gF67hf8+53WZsivbA6Fhe4rpDMiIrxZ48NZQwFW9A7I4LkcEt896rbv6jnvr
	 p+wRFSyimCeTg==
Date: Thu, 30 Nov 2023 23:22:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] selftests: tc-testing: remove spurious
 './' from Makefile
Message-ID: <20231130232252.54907127@kernel.org>
In-Reply-To: <20231129222424.910148-3-pctammela@mojatatu.com>
References: <20231129222424.910148-1-pctammela@mojatatu.com>
	<20231129222424.910148-3-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Nov 2023 19:24:22 -0300 Pedro Tammela wrote:
> Patchwork CI didn't like the extra './', so remove it.

Thanks!

