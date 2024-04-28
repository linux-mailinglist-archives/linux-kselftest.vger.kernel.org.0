Return-Path: <linux-kselftest+bounces-8996-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF7B8B4AC8
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Apr 2024 10:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38FDFB2114B
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Apr 2024 08:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2560C5491E;
	Sun, 28 Apr 2024 08:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVLjgRT/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD5854906;
	Sun, 28 Apr 2024 08:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714294764; cv=none; b=W/s6g2HdSQ3TU1S+39tHNPniTFifGGsre1CfsoBerIdEG2OCWs2L9iA1qFcx4q+XApmG278R1u6oQzTEne/BjS0jHtfvPSr+wnWn4tD9iXYux/WI4+FfsYHzLZYOYUqiw99+aCfCIf03j0qDASgS+ih3K6rNViE+rPrQ8rN+EqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714294764; c=relaxed/simple;
	bh=+XmLAK2h7eiQ5qB5M3YIDoAcxhCoxznnjXBKeXbt+ck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pyACTJjU/4SBjcqKg+Hba+iaWQbMGRLDS8rz0KAubrxFuYrycDYS8iyURS9UlUumo0DWn0qyTA4WS/6jngzgCpV+j0ND8PjM0Wawgjdz113lXYe2fMES/lPEEbfNgxikVRhZ2R2WEVCOcqXR/5hqeU3qk4cgiU0OmiUBqWS0r4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVLjgRT/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF15C113CC;
	Sun, 28 Apr 2024 08:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714294763;
	bh=+XmLAK2h7eiQ5qB5M3YIDoAcxhCoxznnjXBKeXbt+ck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TVLjgRT/ZS9Q1EXAs9WywPFCu7uCwyB/R9CU+OjpbkAY6LKsgVlIVaTJ+vKt/yhs+
	 cI+Rk0tvya2m228thdoc+0Og7KKQyl71HZoxAWkouOi7D3hwMHm6l+oJflA5yG2kOD
	 0vuu9HuUBLPtnjntM73Ul8bVcZXo7ZxWVf7ZP4uKFIIt2LpBrFeHnwCte5ABHjlrcS
	 V2cO47rpG6SEuG8c03ho/4YS32BTqs68/Q6knc7XWuFiHH1A/Z6CEADTJTo9U5N9fB
	 VinN+EsoIZ8xp2SF+Q1pJg5dmQXF0ryLAw0Ec3qeW9ir54c5FJAmy0JX2t/5oAgBAt
	 tSvi72XtRJVWw==
From: Will Deacon <will@kernel.org>
To: kunwu.chan@hotmail.com,
	catalin.marinas@arm.com,
	shuah@kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest: arm64: Add a null pointer check
Date: Sun, 28 Apr 2024 09:59:13 +0100
Message-Id: <171429017935.1716809.10906291781915903062.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240423082102.2018886-1-chentao@kylinos.cn>
References: <20240423082102.2018886-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 23 Apr 2024 16:21:02 +0800, Kunwu Chan wrote:
> There is a 'malloc' call, which can be unsuccessful.
> This patch will add the malloc failure checking
> to avoid possible null dereference and give more information
> about test fail reasons.
> 
> 

Applied to arm64 (for-next/selftests), thanks!

[1/1] kselftest: arm64: Add a null pointer check
      https://git.kernel.org/arm64/c/80164282b362

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

