Return-Path: <linux-kselftest+bounces-3201-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A271831B9B
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 15:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B7AE2874A7
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 14:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA861E884;
	Thu, 18 Jan 2024 14:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzXAhM7+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B768288D5;
	Thu, 18 Jan 2024 14:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705588696; cv=none; b=mqzfjaqRjKPJUSXcQqW6Dqz2LVgnjdowwEGpJKN6J61zIe7WFYhfU6b5t5J2RDZXMLleA6w9gKIFa7UTwm8NVuxGEHkNNDjXBko0+9v3Bg3lb89VZEJa4fYJvnDQp3onJx2BJE4S+EszPc6eT5H1iHLO44lTCZqOMnflHcIxkKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705588696; c=relaxed/simple;
	bh=guptyyOQalkFrWPUTJrIlKr56a+E4jq1Is5W6DKtQj4=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	b=cBrbqdODX3uZiczHu7TfcpKojvQ7rlqpLWdNCu72Rjx4PwWc+8NSQ0mwl/GOuVJmy48ffxIgvTQpbvOmZovaO9a6DXN5nbg5jmsDkrHThMrjBL4jeqT/btG4tcZItOwPvipixt4ZfBHv4+47E6h29iGcZ/AH+kF/plpb8cxbYC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzXAhM7+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3AFC433F1;
	Thu, 18 Jan 2024 14:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705588696;
	bh=guptyyOQalkFrWPUTJrIlKr56a+E4jq1Is5W6DKtQj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mzXAhM7+fcWvAQk9/kZpGzqcaTe1J2wHXx6K79E0F57Wn+xXIeVBoCK0WvgD883Lk
	 Xdf3d1R0d6midMySgh1kU2uf77Iec4SM376aV4i3IskZIc92os1NbBFJLDSD5TCij/
	 M7YCdPEA9nQiR197ZQlgBgcRlG/CLGHFLXsiykQ98msZ98A9jYkjc5EosO1V34Ur2B
	 gT0hUut7FfWOkSJBGoLzQrQkvW69QVQNCph6K56szy5dGeWzVE61cPHsmcb7TPEmjq
	 ViIJOnDwlbzPqtBzER104irvthKCHU9B0j36PcvBpid1tFWsALOibairaydiQ840Mx
	 zj4AYXaH5jnCw==
From: Christian Brauner <brauner@kernel.org>
To: Hu Yadi <hu.yadi@h3c.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	514118380@qq.com,
	jmorris@namei.org,
	serge@hallyn.com,
	shuah@kernel.org,
	mathieu.desnoyers@efficios.com,
	mic@digikod.net
Subject: Re: [PATCH v4] selftests/move_mount_set_group:Make tests build with old libc
Date: Thu, 18 Jan 2024 15:37:56 +0100
Message-ID: <20240118-sezieren-neurologie-6690110057ca@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111113229.10820-1-hu.yadi@h3c.com>
References: <20240111113229.10820-1-hu.yadi@h3c.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1169; i=brauner@kernel.org; h=from:subject:message-id; bh=guptyyOQalkFrWPUTJrIlKr56a+E4jq1Is5W6DKtQj4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSuNL/gYT4jbaGy/4JkroyimR9NvAQn5yqVywfzKjXEO ClZcFd0lLIwiHExyIopsji0m4TLLeep2GyUqQEzh5UJZAgDF6cATGTbBkaG3cbOjneu/Zs677DJ lPNla3//9xYuXh3vkzPXZrfEvLqTrYwMB+NmyzJamd05erEv82GNfvZ/C8ksyVPePndiZnyaWBz LBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 11 Jan 2024 19:32:29 +0800, Hu Yadi wrote:
> Replace SYS_<syscall> with __NR_<syscall>.  Using the __NR_<syscall>
> notation, provided by UAPI, is useful to build tests on systems without
> the SYS_<syscall> definitions.
> 
> Replace SYS_move_mount with __NR_move_mount
> 
> Similar changes: commit 87129ef13603 ("selftests/landlock: Make tests build with old libc")
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] selftests/move_mount_set_group:Make tests build with old libc
      https://git.kernel.org/vfs/vfs/c/0778b0a1a8d2

