Return-Path: <linux-kselftest+bounces-30669-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C34E8A87E71
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 13:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEC1D1766BF
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 11:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CD528C5AD;
	Mon, 14 Apr 2025 11:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kf1uHmjt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB33280A3E;
	Mon, 14 Apr 2025 11:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744628914; cv=none; b=VraFtLWtxkwno7/vnkwPbYZAZcA9bqzsSBPhXUIyHRQ2veDvUsP5DptC6D6qdd9jSiUAxp1hY6hGaEqsRC/wPX2hSQxGUTJ7fJQv7dYLDFLKHEqqk8sLjb1W7CXg8Yxso4YlSb3IIFxf2bHKI++teo55q4kDhcW+3/z+0JynKiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744628914; c=relaxed/simple;
	bh=Xdy9D5Bqc7njSHzOj1S++m6E2MnsrUv9gGmsdEPEskc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N5PFRLn+3lqNVK/kc40C1hjJ9HbbnRX2kfz8UZ62JgDebF/uDK7pLkDjQZ1zxkIvBYrXA1CikSJ6/7tRNA2K1UxOdZV3CL804rWoxFscIiIKCIe7W9WVO/X8T2/D6/pqZSNCQDr0wqBI/+kGC6WfXZz61DGRY4uBVQa+M1Vphzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kf1uHmjt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1BCC4CEE5;
	Mon, 14 Apr 2025 11:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744628914;
	bh=Xdy9D5Bqc7njSHzOj1S++m6E2MnsrUv9gGmsdEPEskc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kf1uHmjtuyTVJ2dL7Z3InjXnxMN0ij1nMdM0VaxyVCtJ+XVgnbfDG3qUu5giho5if
	 OQAOGBJIoYTzy6MnB8AHsysI1il5NaqC6d7TcDOOjSBAkwxBFtN4g6J2TRdzMgZlYH
	 wpLbRD4k88Bs4tMoRP29I5Cn5OD8FrUktoCwCPiyEIfnzNSqKNKUcKTcQiGkgBpiQI
	 9D+zj6WooQ1Uczqa1qnU+h1BNqq76Crk3fzygpgg1/2RnDQa4wsfJMsdmXg9S3Gy/P
	 PKkaDDlNyD5uUdStZJmyDsU460f9tTEnmOwpBC0yJ2HiToiLlPfuPyKMbKyQj6ybxY
	 +v7v6imwaB+zQ==
From: Christian Brauner <brauner@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] selftests: coredump: Some bug fixes
Date: Mon, 14 Apr 2025 13:08:28 +0200
Message-ID: <20250414-wertigkeit-sozusagen-506b362280cd@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1744383419.git.namcao@linutronix.de>
References: <cover.1744383419.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1275; i=brauner@kernel.org; h=from:subject:message-id; bh=Xdy9D5Bqc7njSHzOj1S++m6E2MnsrUv9gGmsdEPEskc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT/ebM2ve6Eh3GR27Rup9a1XQvOt/6sf/TRn3fPyRzrn 2UBp67YdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyk8hkjQwcTg/+jbPtLS3+z c1s8Wu320IFfKHnFMn2FlR82LEg4lMnIMPHa8uQ9HlclhGz9Ph/LWVfiG/573aHctupcVdNJtip nuAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 11 Apr 2025 17:09:40 +0200, Nam Cao wrote:
> While trying the coredump test on qemu-system-riscv64, I observed test
> failures for various reasons.
> 
> This series makes the test works on qemu-system-riscv64.
> 
> Best regards,
> Nam
> 
> [...]

Applied to the vfs-6.16.coredump branch of the vfs/vfs.git tree.
Patches in the vfs-6.16.coredump branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.16.coredump

[1/3] selftests: coredump: Properly initialize pointer
      https://git.kernel.org/vfs/vfs/c/b3da3c6ce9f6
[2/3] selftests: coredump: Fix test failure for slow machines
      https://git.kernel.org/vfs/vfs/c/05ac92f73615
[3/3] selftests: coredump: Raise timeout to 2 minutes
      https://git.kernel.org/vfs/vfs/c/52cfbe664dc9

