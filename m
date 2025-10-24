Return-Path: <linux-kselftest+bounces-44016-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B00C075E3
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 18:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E27EA356F8D
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 16:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAC22D979D;
	Fri, 24 Oct 2025 16:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxh+zobt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC83258CF0;
	Fri, 24 Oct 2025 16:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761324240; cv=none; b=icYezhHlIMI/bLp/G33Y5isWjWpK8tmoTy+cCOoAGs4zE/9t5OCYra9nqbPD+ZeggjmWp8Ly5JIN7+iMeJoYEN8ABh/utXVfYR0zgX69MJvq9zF77zN67+ZMWkTcFh/uBFZ8IvUxtJZ1IlkbQheJ2Nqi387kbZfK2lSRpvfp7n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761324240; c=relaxed/simple;
	bh=6wsAeq8NmsFB5M1le8QxIbGbQvgkIjtIBo3EHQtqiNM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rhcMX1a4vdbjfoC3UwwHxrweayZSrNe92IQbPjByfOu0wmSaFW59A3l1U77yr0bko7AC+kBAV4c27CcNaAAoNEmiteTnHLv9UdEan5DAmOMlhIwp0UgoX7KE2ij6pdUSsSJL4en/V4aPB2fa5DP+wcFRKfvRy3RLuOKKWIb6O3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxh+zobt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90494C4CEF1;
	Fri, 24 Oct 2025 16:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761324239;
	bh=6wsAeq8NmsFB5M1le8QxIbGbQvgkIjtIBo3EHQtqiNM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=sxh+zobt1sZ6r7fdusWMcQ9a34ICY3fKF0DU9+8P3wIb8rWNDxg/X28leHLnzBOQn
	 +D/SWhQvI+utyR86YTZ+cA6xhdwTatlc87cp24QQHM8eN7NaJWnT7PmISbSgxQVQM2
	 EXShaWM5XGz6dCGUPk11QQcn99MbL5Lyefk+mxQk/5z+urV431jqq4WIrAuh+8VOTE
	 lP3voBB1K13z8XVR5AhWJiTBwkRH8VhaB1/8ykSxsZSPPjnvt04B+E0wyZQ8MhvzlR
	 BaTXE/B2imangiup6YxQsqtHq4gG0nv+500OwiyM692wrmfRf4Kxvay5WE9SJA2T3l
	 kgJxTifEsBh1g==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org,  brauner@kernel.org,  corbet@lwn.net,
  graf@amazon.com,  jgg@ziepe.ca,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-mm@kvack.org,
  masahiroy@kernel.org,  ojeda@kernel.org,  pratyush@kernel.org,
  rdunlap@infradead.org,  rppt@kernel.org,  tj@kernel.org
Subject: Re: [PATCH v8 8/8] memblock: Unpreserve memory in case of error
In-Reply-To: <20251024161002.747372-9-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Fri, 24 Oct 2025 12:10:02 -0400")
References: <20251024161002.747372-1-pasha.tatashin@soleen.com>
	<20251024161002.747372-9-pasha.tatashin@soleen.com>
Date: Fri, 24 Oct 2025 18:43:56 +0200
Message-ID: <mafs03478dzcj.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Oct 24 2025, Pasha Tatashin wrote:

> If there is an error half way through KHO memory preservation, we should
> rollback and unpreserve everything that is partially preserved.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Suggested-by: Pratyush Yadav <pratyush@kernel.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

