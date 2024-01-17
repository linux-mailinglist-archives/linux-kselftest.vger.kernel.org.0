Return-Path: <linux-kselftest+bounces-3147-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3813830700
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 14:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 835A0B23B82
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 13:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181461EB4B;
	Wed, 17 Jan 2024 13:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3ltVMKf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6FD1F922;
	Wed, 17 Jan 2024 13:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705497795; cv=none; b=dYd9ZWTS4RzUjDCsB8BMlpqaPY/7o1u9IyV/44unQ7n5OlfpraXyosdjUemBXGu6fhzIyBkQuSAKpbW7GowN6bnZcasc4crHLnHEY+rQbaMD5zmyNlaCwqCDs6DJDM1LEYuBp/TmKvfYAWy9SldK1CkCeFvYrYM3/pX/DoszUTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705497795; c=relaxed/simple;
	bh=RlrKzDkIjIq2TVxqUGllwocF4eW5X7TS+IGUjH/GmNc=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	b=q0FfiZgHt4Vc2RSaQDcmoxGxp6HRSS9c6cO4XfmCA0epFaf4jITmj1BsaMYmVFw66fA64dlmIHXI0sDQWWPMyP/+1JZYsJ2P9EQ0FJg1fUomEy+/rrtxb5Cjq8tddKnhRueETdGfeVyKWMJ9AlUcWs4eOqfllEatQFXWi8zFa3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3ltVMKf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20C4C433F1;
	Wed, 17 Jan 2024 13:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705497794;
	bh=RlrKzDkIjIq2TVxqUGllwocF4eW5X7TS+IGUjH/GmNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O3ltVMKfNpps7jLn6qrK66z9essBMT7uQdldoI41FVeZpP5s2NuWF94UNzHV38/wT
	 eSR3kJEVj8/SMmxrcnL530OJP5anCDb1EHgDiqc/gAARZRJC480B8q8z59Z7WwSeIX
	 DB+oikzFQUKuZSAP02ANo7U/oBqLg1y5FFBpZ3ETmZt9FbhUyxA9/VZVVBfUlMF2q6
	 2wZxrcvQsIBEsb/ZEnid4dpeoYdLdVIDEKUBx2XiuBBLzyJsuV+uxdReK1lNBmNd5p
	 ZEiB5FssjuGIMYYvlvKzvyzXWfP4UDW3dyNgqbQT7YGeFisVysGjiyqpXFcCxPm+Xt
	 qshFMsBJy3xXQ==
From: Christian Brauner <brauner@kernel.org>
To: jmorris@namei.org,
	serge@hallyn.com,
	shuah@kernel.org,
	mathieu.desnoyers@efficios.com,
	mic@digikod.net,
	amir73il@gmail.com,
	avagin@google.com,
	Hu Yadi <hu.yadi@h3c.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	514118380@qq.com
Subject: Re: [PATCH] selftests/filesystems:fix build error in overlayfs
Date: Wed, 17 Jan 2024 14:23:02 +0100
Message-ID: <20240117-strotzen-wegkommen-e7ac317948c6@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112074059.29673-1-hu.yadi@h3c.com>
References: <20240112074059.29673-1-hu.yadi@h3c.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149; i=brauner@kernel.org; h=from:subject:message-id; bh=RlrKzDkIjIq2TVxqUGllwocF4eW5X7TS+IGUjH/GmNc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQuv7LjCodESftWD40ivqbiAKabFjaLcl6GP9prV/e29 GLFPnWzjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImkrmT4ZyJoU8uQpNmaxel0 cVHEorj7uoES5aWCsgslOFZ9NWuwZPjvU3KIJc5SKcVkv9TsJzqCzFd2vt6vLhwkN81lT1BDxEk 2AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 12 Jan 2024 15:40:59 +0800, Hu Yadi wrote:
> One build issue comes up due to both mount.h included dev_in_maps.c
> 
> In file included from dev_in_maps.c:10:
> /usr/include/sys/mount.h:35:3: error: expected identifier before numeric constant
>    35 |   MS_RDONLY = 1,  /* Mount read-only.  */
>       |   ^~~~~~~~~
> In file included from dev_in_maps.c:13:
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

[1/1] selftests/filesystems:fix build error in overlayfs
      https://git.kernel.org/vfs/vfs/c/f67dae6ba174

