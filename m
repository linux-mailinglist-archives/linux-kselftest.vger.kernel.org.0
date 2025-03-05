Return-Path: <linux-kselftest+bounces-28328-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFE9A50B7A
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 20:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 669BA1891855
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 19:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED09C253B70;
	Wed,  5 Mar 2025 19:28:45 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54E4253B4F
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Mar 2025 19:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741202925; cv=none; b=tAwyXsfUNJJoDhORjVchTUkG+t6PSYLt5E6BTIsJyNp833ntm0zMJYRTQ8bjZCiX/JkSWByGOv77ybwJE/e6xO8kSCC1p1ywSnrAQknal3q8z5b9DohVl0+1fgyFGPFIV4y69V+oSy64wEBvr2k/lSHdduQlJd724uir1EY3ja0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741202925; c=relaxed/simple;
	bh=Nr9i4hJFZw/i4laWEeqpxfChSibrtUoYSwiZC5YdNr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TPnyyN/H7pJ1QCP7DrO4IxtSDXpeHUw27uGJMIfdplCdLzvnF/iDui/ngNtwK703Az4Xs3LHabbysY+WORzSORzm8V+8Y2CbTG1AJBwYdF1WDWiHgNxM0K9koodYUe8qXBmcBV2Pn583OR6p3fsM1gqAe4N+pOrBaBiylZmgsGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0237EC4CEE8;
	Wed,  5 Mar 2025 19:28:43 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Yang Shi <yang@os.amperecomputing.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 0/2] kselftest/arm64: mte: Minor fixes to the MTE hugetlb test
Date: Wed,  5 Mar 2025 19:28:41 +0000
Message-Id: <174120291692.1422545.4418874969040688067.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250221093331.2184245-1-catalin.marinas@arm.com>
References: <20250221093331.2184245-1-catalin.marinas@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 21 Feb 2025 09:33:29 +0000, Catalin Marinas wrote:
> The first patch makes use of the correct terminology for synchronous and
> asynchronous errors. The second patch checks whether PROT_MTE is
> supported on hugetlb mappings before continuing with the tests. Such
> support was added in 6.13 but people tend to use current kselftests on
> older kernels. Avoid the failure reporting on such kernels, just skip
> the tests.
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/2] kselftest/arm64: mte: Use the correct naming for tag check modes in check_hugetlb_options.c
      https://git.kernel.org/arm64/c/7ae95109c64d
[2/2] kselftest/arm64: mte: Skip the hugetlb tests if MTE not supported on such mappings
      https://git.kernel.org/arm64/c/306219d59b72

-- 
Catalin


