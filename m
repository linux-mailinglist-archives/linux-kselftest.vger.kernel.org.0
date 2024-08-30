Return-Path: <linux-kselftest+bounces-16831-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE057966690
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 18:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ABB01F23283
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 16:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0761B8EB3;
	Fri, 30 Aug 2024 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OE6a5UTp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9460B1B8EA1;
	Fri, 30 Aug 2024 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725034348; cv=none; b=pWuqpRn006RyDsMQlMtIbYEIAU4jfQvmUHmMnTqXGPKqNBEakR+11RvFdm7Yqu6Rq3EtYmcXYKxicqtv/n/qZxeL3N0co9xXZ7uQh24LUYkvBhZQ+LtekpkTu9xbgprZOCWxGVehIhoYPfjmD0bvLqV/BKcDH0ULL+tlV4hr48c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725034348; c=relaxed/simple;
	bh=4olgMWFnqRfGAJn/hf7MsiFxqfy7g60SbC+PBtuV+5o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XmPINmoUoOTyuFFxBZw81agdMm5JgxDtmOcZeHKgWKwpESeVZ57I1fZmjqwsE6rzJc+krEC1qTH/PoRdvf5p96vdVDTrdE6MrxKABhbLBcBEM7qJ/bDvGcgWM11Z2poF59+wnDqcxB2SzbM425n2c99UK7KaFJmxaDaIeeBKD7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OE6a5UTp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE75C4CEC5;
	Fri, 30 Aug 2024 16:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725034348;
	bh=4olgMWFnqRfGAJn/hf7MsiFxqfy7g60SbC+PBtuV+5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OE6a5UTpOBfCZY9myh8N9H06FPMjyUTF6rUP/qRbibt+0DssVH2OGW20sKA6nhpCJ
	 swbRqJdN3agDCvSLCL+mx0lBXrR7rpBUITdTRznmFpIYNlOTUSS0iKIEP+wzV7/au/
	 f8VjuCYG1iSNh+bYNdqDIOX8Ysmhl3A3bQLqqtAOT237tlPVXWgv/jBEpgyYMjw96F
	 /mmRCkF2yV0NwEvBq3EtDZKONDJCyNJMya0rURSSlKH1rcmHcpWlJ1x+gYvAtuZLpQ
	 v+KbPVdqcRkgNakRTJmC3PqaBG9XP+SHrgAqnMsc45DoL3fpWMSguQ341naPAwm2cd
	 OrSOEgqno9mug==
From: Will Deacon <will@kernel.org>
To: shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Catalin.Marinas@arm.com,
	Dev Jain <dev.jain@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	broonie@kernel.org,
	ryan.roberts@arm.com,
	Anshuman.Khandual@arm.com,
	aneesh.kumar@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Fix build warnings for ptrace
Date: Fri, 30 Aug 2024 17:12:10 +0100
Message-Id: <172503160799.3257459.1776623794579336427.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240830052911.4040970-1-dev.jain@arm.com>
References: <20240830052911.4040970-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 30 Aug 2024 10:59:11 +0530, Dev Jain wrote:
> A "%s" is missing in ksft_exit_fail_msg(); instead, use the newly
> introduced ksft_exit_fail_perror().
> 
> 

Applied to arm64 (for-next/selftests), thanks!

[1/1] kselftest/arm64: Fix build warnings for ptrace
      https://git.kernel.org/arm64/c/d736d4fc7630

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

