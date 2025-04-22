Return-Path: <linux-kselftest+bounces-31326-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB11A97184
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 17:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AED1189C020
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 15:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4877428DF13;
	Tue, 22 Apr 2025 15:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2ve8TfL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E91D284B5A;
	Tue, 22 Apr 2025 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745336935; cv=none; b=GPfphZSMwARVJ2yBK3fsSPz82fn92cCtVAHvodMzF9pT+DVnSoRshw/LmJtJsRFPr9ivwIbwCIU+D/2H/Az1z/Zosk4FySNJ2SXSPrdgU+u+XSsDRGe8SXF1KcJJY4dJxjlrkLWWwzOQhzZzBhnOyAp/ShgUdnSMJcLxo2NkgVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745336935; c=relaxed/simple;
	bh=f90SE03H5s+CjjZ4AIiR629Qp83J2dxUvQp5mdrqfqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0SMUmxM2aNQn6xvjjfah8Bz+GDm780aIgfCX8KVpztLTCxeqBYC4ikljNdv+MVjSO86UC3t5B9QdheAlU8FJXDhv1ILY6WgxyA8nt55obXBItOf8z6lds/C9UJCe49NcDHVkDD+bK8Tc65Gn14Nz3J7FZHIYyHPgTsxoyQR50Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2ve8TfL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859D9C4CEEB;
	Tue, 22 Apr 2025 15:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745336933;
	bh=f90SE03H5s+CjjZ4AIiR629Qp83J2dxUvQp5mdrqfqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o2ve8TfL274ZYGeiAaohxOZ7ErqNfGMH+p3xLRcd9ZNsaTt/zgUg9Arf4nQbGlfDy
	 reraeo8/5R7cIktk+O8sKB8fNlhlVNnbfiYcFmGQP/P2H1UAk8IHBCbqRzIyg5fo+R
	 q9e9cm4nVxnAtUzCUN3ye5HWjGb9L7fkBT494jKdDwZ27t5skSdM/zY37vBKZVlk7t
	 cIpn5gOri2vadpDhobt1oo16g9KG/s691K1FzoQmqhhPY2sI/NLChGTVKE+vy1PDy+
	 pXwuieu+OVkX1ZRICMraTQ3iQmU9ueHg6rU0pg6erS8DjYW1IZgL/o9R87DVUgZJD0
	 0Dq/bnAoJOdiA==
From: Kees Cook <kees@kernel.org>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Tamir Duberstein <tamird@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Mark Brown <broonie@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib: Ensure prime numbers tests are included in KUnit test runs
Date: Tue, 22 Apr 2025 08:48:48 -0700
Message-Id: <174533692623.1069298.11025908565962580290.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250422-lib-fix-prime-numbers-kunit-v1-1-4278c1d4a4ae@kernel.org>
References: <20250422-lib-fix-prime-numbers-kunit-v1-1-4278c1d4a4ae@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 22 Apr 2025 16:43:29 +0100, Mark Brown wrote:
> When the select of PRIME_MUMBERS was removed from it's KUnit test
> Kconfig nothing was added to the KUnit configs, meaning that when run
> via the KUnit runner the tests are neither built nor run.  Add
> PRIME_NUMBERS to all_tests.config so they are enabled when the KUnit
> runner builds the kernel.
> 
> 
> [...]

Applied to for-linus/hardening, thanks!

[1/1] lib: Ensure prime numbers tests are included in KUnit test runs
      https://git.kernel.org/kees/c/4ea404fdbc39

Take care,

-- 
Kees Cook


