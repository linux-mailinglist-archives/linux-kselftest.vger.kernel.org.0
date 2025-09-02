Return-Path: <linux-kselftest+bounces-40532-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2296CB3F8CC
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 10:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CFB816BC55
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 08:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496142EF665;
	Tue,  2 Sep 2025 08:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fzotpgz8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E692EF65E
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Sep 2025 08:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802160; cv=none; b=qRaNDbbmtlyJrZeLddANxVnpbj3phHg8y4oTFguUbjHVuuUbXJ7gb9uZZq3pmnZX4HFhet1ibaMf8g7cLIsIu1nwAaZjGmsSiW4qiFvrL6LsZOpMhMOPKAvKuwfOrkakK5K0HCECfndwcLVMtLIheHR6rhXzT1orCwiKPsZ9MVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802160; c=relaxed/simple;
	bh=zb4E8uuoHVDpJ7rFSQK0VoPBhUtoN+UJDYEdPHtBTuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XiSy6eThUXXf48eYmeX+vbZHsHiopZBlelYjj890C8OvRemw2cOQoIk973Z+7lRHQpPLiSDULSyEPMjLHBLBhkk9vCOzzChkhZKu2zQoLPnSe4YQ8gj3TNd1N42IACIN13C/ZrNHab+Vjj3p6vWAdL+/SgaH6WeR+u0BQ6xWvoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fzotpgz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44009C4CEED;
	Tue,  2 Sep 2025 08:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756802159;
	bh=zb4E8uuoHVDpJ7rFSQK0VoPBhUtoN+UJDYEdPHtBTuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fzotpgz8MS2XODqEHSKAxg1fvBHmGoRF66jm2IKSMBJETbeJlYOvt71Nz2si/7RXe
	 w2ZqXkAH/9UsSv3ZDgfZ67YTAzyNJTsJDM4R6OBCAQMarqalHTLtnVN5SUBzF/mZas
	 yEVh7Q3GfGMHJ6D4xUWlUVuqYixsLpMIvKQnfSL623b5eVXYMfMQmG/Hm2qPGJrkz8
	 Y9LojSMCfE7lIqpIHpc0BSuHXvjikiQW0ItLbaVwRFzIzvAXO8G8XpFBD70hKQk7pd
	 jDzme3Tk3kOBSyj2rJT2Ywvn8jQsFpQM69XWDVJitUsZVnANIYOHHiDeKp6hcgKvl8
	 zIjMsp6OQ65HQ==
From: Christian Brauner <brauner@kernel.org>
To: linux-kselftest@vger.kernel.org,
	Xing Guo <higuoxing@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	shuah@kernel.org,
	jhubbard@nvidia.com,
	amir73il@gmail.com
Subject: Re: [PATCH] selftests/fs/mount-notify: Fix compilation failure.
Date: Tue,  2 Sep 2025 10:35:52 +0200
Message-ID: <20250902-zumachen-sonst-f19e67e9b1e2@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250813031647.96411-1-higuoxing@gmail.com>
References: <20250813031647.96411-1-higuoxing@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1216; i=brauner@kernel.org; h=from:subject:message-id; bh=zb4E8uuoHVDpJ7rFSQK0VoPBhUtoN+UJDYEdPHtBTuE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRsW5M9x/piWdCSdetqKz89afoqoBoe5+/z8ctCz1/+S qeKjt3+21HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARq70M/+w1rrR4NVztznd/ 8S7SX1Mjje1ySZXOwZ+bLYWrX3WzajP8z1ZaIr7qTXhy4/ZtBumefQuS7naaLd7EvD/r43vf/y+ m8AEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 13 Aug 2025 11:16:47 +0800, Xing Guo wrote:
> Commit c6d9775c2066 ("selftests/fs/mount-notify: build with tools include
> dir") introduces the struct __kernel_fsid_t to decouple dependency with
> headers_install.  The commit forgets to define a macro for __kernel_fsid_t
> and it will cause type re-definition issue.
> 
> 

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] selftests/fs/mount-notify: Fix compilation failure.
      https://git.kernel.org/vfs/vfs/c/e51bd0e59547
[1/1] selftests/fs/mount-notify: Fix compilation failure.
      https://git.kernel.org/vfs/vfs/c/e51bd0e59547

