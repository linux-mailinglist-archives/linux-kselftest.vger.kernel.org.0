Return-Path: <linux-kselftest+bounces-3261-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED53C8330E0
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 23:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C1C01F2260A
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 22:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E3156B86;
	Fri, 19 Jan 2024 22:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+MEbsh0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB758CA4E;
	Fri, 19 Jan 2024 22:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705704543; cv=none; b=PtZ8VZyzcskf4kDwLnew2cUs/9vBkEjYVnoc9UOt+jc8J58OFWd266Ib0CUTdig3uGnTqDapLEjECynPBHK/hC5njLPvROwwtZIfwWffWsGKF3YLdE4CJ3gQGarlZyB3hVaXdlXgQPX/AMjhWps5k95ynD54Ho4I6nXWBdcN03U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705704543; c=relaxed/simple;
	bh=SMPwXZlCA1geouFhZGx41DIFw/PoGVbaQI+MWP6O53M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZOU+bjMOfNtkHmpAmXCgGR7fkdZ1QOnfcVD/nvLDc0Qd+oWwGr23kUyGk0OCIZd4qIzonxaTHky82Jc+3J42uAHE8SnfuJkHt2/HVitynacenqIb/UTntj2wTEDzsy09WuzUSgFWBqmH8RsX8mWqaR70i8LBvWUWHp9DvNq5caM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+MEbsh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC73C433C7;
	Fri, 19 Jan 2024 22:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705704543;
	bh=SMPwXZlCA1geouFhZGx41DIFw/PoGVbaQI+MWP6O53M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F+MEbsh0lEt/2sDb2dsTJigO8+wri3QdjMliOyauL7yJJb0l3ypH9pR9nz960jhfH
	 X989yhgg6V3mdJnblspMoyhdAljlrCuSEnN8dyKa/2z4O33Oa1zkRH8D1Pfje+wuJL
	 tfRLx5KFgMrxrUZWaZaDEzf3DVNKRAR0HGI3hDJx5rGhJqQkbABhdTH23VcklRJnsK
	 WyIdQquejiOviLKQ5aScGJpjT5ZRMThwd3r+Q3+WeBNeyancJdE0NGdUPiiiVeJX/Z
	 +QzQrHpHr8hPdZGLFLL56bTh/TeyDM2hTUW6W34PeMsCMkiwFi0H3bqb1rG1FFJ7JQ
	 3rFJ8aY5zzQAQ==
Date: Fri, 19 Jan 2024 14:49:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: net: fix rps_default_mask with >32 CPUs
Message-ID: <20240119144901.15bfdcc1@kernel.org>
In-Reply-To: <20240119210719.GA110182@kernel.org>
References: <20240119151248.3476897-1-kuba@kernel.org>
	<20240119210719.GA110182@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jan 2024 21:07:19 +0000 Simon Horman wrote:
> AFAIK this will only remove the first incidence of a comma.
> So I'm assuming this breaks with >64 CPUs.

Good point! I'll use ${var//,} in v2.
-- 
pw-bot: cr

