Return-Path: <linux-kselftest+bounces-10414-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AEF8C9769
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 01:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 933FA1F210F8
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 May 2024 23:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A4BFC01;
	Sun, 19 May 2024 23:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="o63afiyR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D8C8F4A;
	Sun, 19 May 2024 23:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716162506; cv=none; b=XmiceVk3h4jPKK9dEB2ZKur0YtLsjWafmehjy+DF90jI62PdUZsOJLkc6m8OTP4aheyRKqn/g3ddfPdm7RzrWiI1wpv1rerK5GLoIGaWKATeooFtilb+1iScE81QF2lCPXcDoj7bqymYxr2D0InLIbN+4XEgU6oILG8c3rtBLfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716162506; c=relaxed/simple;
	bh=a5IqfGM8Xs0u8K/8KiCDxhps6dGg21MfbLPXNVbgILw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XwIsQZjI3rhqQIsGQPoxPIcuj/qTLP4nMY2NcMQngSsWeIV4YA0WRtnjFjx7NpBaKZcPHJ7yZ31rVuyg2SX0UYalIWUoSYPLzOl2F5fdKtX/1aB3tFamZlebR4EriGlBp2J7LELL715jZzes59rZG6M5YUeBg10sLVYHQXjoeLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=o63afiyR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D331C32781;
	Sun, 19 May 2024 23:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1716162505;
	bh=a5IqfGM8Xs0u8K/8KiCDxhps6dGg21MfbLPXNVbgILw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o63afiyR83+KBRwq41skI3q3A+V1GfTG/mO0OMqwZKAYVJ/Lu1hFXMVR6BSnO364e
	 ELVQ64z8AJ9n92mv25r+SfyfU2wVgplSoD4yjHe+6dztoXWG1nvMFQePscRHGV/3Mr
	 ZenLf2A1bm11k7GlaTypTAjU5iikZF9IF3pJ4zsU=
Date: Sun, 19 May 2024 16:48:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Dev Jain <dev.jain@arm.com>
Cc: shuah@kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Anshuman.Khandual@arm.com,
 kirill.shutemov@linux.intel.com, AneeshKumar.KizhakeVeetil@arm.com
Subject: Re: [PATCH] selftests/mm: va_high_addr_switch: Do not skip test and
 give warning message post FEAT_LPA2
Message-Id: <20240519164823.8e21acfd2bf9ad13f7798f1a@linux-foundation.org>
In-Reply-To: <20240516035633.143793-1-dev.jain@arm.com>
References: <20240516035633.143793-1-dev.jain@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 May 2024 09:26:33 +0530 Dev Jain <dev.jain@arm.com> wrote:

> Post FEAT_LPA2, Aarch64 extends the 4KB and 16KB translation granule to
> large virtual addresses. Currently, the test is being skipped for said
> granule sizes, because the page sizes have been statically defined; to
> work around that would mean breaking the nice array of structs used for
> adding testcases.

Which array is that?  testcases[]?  If so, we could keep if fairly nice
by doing the array population at runtime.  Something like:

static struct testcase *testcases;

static void init_thing()
{
	struct testcase t[] = {
		...
	};

	testcases = malloc(sizeof(t));
	memcpy(testcases, t, sizeof(t));
}
	
>  
> +#if defined(__aarch64__)
> +void failure_message(void)
> +{
> +	printf("TEST MAY FAIL: Are you running on a pagesize other than 64K?\n");
> +	printf("If yes, please change macros manually. Ensure to change the\n");
> +	printf("address macros too if running defconfig on 16K pagesize,\n");
> +	printf("since userspace VA = 47 bits post FEAT_LPA2.\n");
> +}
> +#else
> +void failure_message(void) {}
> +#endif
> +
>  int main(int argc, char **argv)
>  {
>  	int ret;
> @@ -308,5 +320,8 @@ int main(int argc, char **argv)
>  	ret = run_test(testcases, ARRAY_SIZE(testcases));
>  	if (argc == 2 && !strcmp(argv[1], "--run-hugetlb"))
>  		ret = run_test(hugetlb_testcases, ARRAY_SIZE(hugetlb_testcases));
> +
> +	if (ret)
> +		failure_message();
>  	return ret;
>  }

This seems rather lame :(.  It would be nice to fix this for once and
for all.


