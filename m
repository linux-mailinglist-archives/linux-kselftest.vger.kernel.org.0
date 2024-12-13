Return-Path: <linux-kselftest+bounces-23331-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 312719F1224
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 17:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94364188106F
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 16:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6881E3768;
	Fri, 13 Dec 2024 16:29:10 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0D2186294;
	Fri, 13 Dec 2024 16:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734107350; cv=none; b=igGkEC/mCKW9jBzfIu9NcOyffUktTtEE8KfjsaiI9KbiZiOIJiJH+pi5h09AdfkLWXpDYh25EUYKrkY7t7Ed+yCd+x3XDijIIUPRm0rXwvOGT2F4uqY1VDIDDPR0Q9uAhOQr2ezO0V05sKwa5zDGyxdZqHHwkoDm8xhGIm5Gaxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734107350; c=relaxed/simple;
	bh=QcFHDY6oV0PMp2jbTd9qFfBDsuR3V45rOSpfpTaYyIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oVVwikpmLzOeu9dscmqZv8g6KN6E/kncvei6lskDBLJjF5ibD56QcujY0A1yE4rAV3w19W9Vl6R1JCBoLD6o3R9tyWDHpGElIFJ/YbRddKv2nb+kLtUS0HePs4ciGD0TjnKXnE/9+nqNADEbxNU06UEiQJM0ZDqOFF2NamGI1ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D871BC4CED2;
	Fri, 13 Dec 2024 16:29:08 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Weizhao Ouyang <o451686892@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kselftest/arm64: abi: fix SVCR detection
Date: Fri, 13 Dec 2024 16:29:06 +0000
Message-Id: <173410734417.60926.833029036075275376.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241211111639.12344-1-o451686892@gmail.com>
References: <20241211111639.12344-1-o451686892@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 11 Dec 2024 19:16:39 +0800, Weizhao Ouyang wrote:
> When using svcr_in to check ZA and Streaming Mode, we should make sure
> that the value in x2 is correct, otherwise it may trigger an Illegal
> instruction if FEAT_SVE and !FEAT_SME.
> 
> 

Applied to arm64 (for-next/fixes), thanks!

[1/1] kselftest/arm64: abi: fix SVCR detection
      https://git.kernel.org/arm64/c/ce03573a1917

-- 
Catalin


