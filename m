Return-Path: <linux-kselftest+bounces-19855-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBF39A0FC0
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 18:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ADD31C22CD5
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 16:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A53218660A;
	Wed, 16 Oct 2024 16:31:07 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E04513D53B;
	Wed, 16 Oct 2024 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729096267; cv=none; b=AMIZ5XVQV1Sc+eWwKsIAodFkYpRxFuO4SgjDrrWWp66XH3MOvjgzmfguUjZC9sCWX4ciJim2R3uzFIXmgrkaoFSZ4ykkTDs9TvYq1eNgGOjbDjzMuGpbchELB3/VrVk7y71dE96LtA1wHuEpby6ZWKZ6oOkL6x6AcXbem18sMMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729096267; c=relaxed/simple;
	bh=TtgA4n2k28+p1a+Nqh0GUqkruIwcGG4mZTLOsxe6cGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I1138ugRduWBvyPPeOrhowyr5Q9YeH50WlM3LSKzo95d/4HovwX0KckX4kKcRmdZA/zLU/Hrt4Lq4oMMn4vLLcf8MHT4NeILJhMmENe2vlR8ykaYmhOcFD91FcXE41NLMTImiLTZOOoClremTAIcLJaq0SqKF4rMsVIwwqyC3ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FDCC4CECF;
	Wed, 16 Oct 2024 16:31:04 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: will@kernel.org,
	muchun.song@linux.dev,
	david@redhat.com,
	akpm@linux-foundation.org,
	shuah@kernel.org,
	Yang Shi <yang@os.amperecomputing.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [v6 PATCH 1/2] hugetlb: arm64: add mte support
Date: Wed, 16 Oct 2024 17:31:02 +0100
Message-Id: <172909625909.3163871.6799257388061799842.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241001225220.271178-1-yang@os.amperecomputing.com>
References: <20241001225220.271178-1-yang@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 01 Oct 2024 15:52:19 -0700, Yang Shi wrote:
> Enable MTE support for hugetlb.
> 
> The MTE page flags will be set on the folio only.  When copying
> hugetlb folio (for example, CoW), the tags for all subpages will be copied
> when copying the first subpage.
> 
> When freeing hugetlb folio, the MTE flags will be cleared.
> 
> [...]

Applied to arm64 (for-next/mte), thanks!

[1/2] hugetlb: arm64: add mte support
      https://git.kernel.org/arm64/c/25c17c4b55de
[2/2] selftests: arm64: add hugetlb mte tests
      https://git.kernel.org/arm64/c/27879e8cb6b0

-- 
Catalin


