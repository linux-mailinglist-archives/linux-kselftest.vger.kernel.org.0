Return-Path: <linux-kselftest+bounces-19853-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 671159A0FB7
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 18:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B62B282BCF
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 16:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E4A2101AB;
	Wed, 16 Oct 2024 16:30:21 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB8215E5CA;
	Wed, 16 Oct 2024 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729096221; cv=none; b=q1jDcItwdR+ZtqydlBrDE9yntUPbEyy7abaMObgK5YrhKUu/b4LOg/IXUPYnzesEMgXTsAu/rg8I1N+3teR9SuhxvxgP9/l3RtUSfbkdqr+AwfNwY4rRR5ZPeHjqWBsP2ByKv/TRmkDxd1rNZIK1LcenaTAcEzvmYb8Q5g7bTHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729096221; c=relaxed/simple;
	bh=HNOqh7nnETdziHGNfo2HvthKVM7we6fo8qe8+HyE8zE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BYu53vgRgOCJHAz2dqA/TWa/2r8kDcscwuN9EI9MqROoz95dIguf7MC/b1A/GaYUZ5ruTTPwPBCMfby7o2KoN6tBNbznIcalxNmBFhsbCnTNEqqB8CfJ3DAv4AVDOU0F8p57jb3Ux8MqFcpivH13Iv4EnVJ6ml/xx7RnI4VoElI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7217CC4CED0;
	Wed, 16 Oct 2024 16:30:19 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Ensure stable names for GCS stress test results
Date: Wed, 16 Oct 2024 17:30:16 +0100
Message-Id: <172909620948.3163505.7404760502678129111.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241011-arm64-gcs-stress-stable-name-v1-1-4950f226218e@kernel.org>
References: <20241011-arm64-gcs-stress-stable-name-v1-1-4950f226218e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 11 Oct 2024 15:36:25 +0100, Mark Brown wrote:
> The GCS stress test program currently uses the PID of the threads it
> creates in the test names it reports, resulting in unstable test names
> between runs. Fix this by using a thread number instead.
> 
> 

Applied to arm64 (for-next/gcs), thanks!

[1/1] kselftest/arm64: Ensure stable names for GCS stress test results
      https://git.kernel.org/arm64/c/9b9be7825851

-- 
Catalin


