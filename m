Return-Path: <linux-kselftest+bounces-11238-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEF28FC798
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 11:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A296B283ED
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 09:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1C818FC6D;
	Wed,  5 Jun 2024 09:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xd4Bwxh7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE6529401;
	Wed,  5 Jun 2024 09:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717579307; cv=none; b=S8Wd21jYAzt912+ZRPuFCpkOucB9tCAeRkC5bwY6iS4DonbFL8lrymmM7tjDe5XcqPwTw++F6/INDZ+nmFe0URM7WE8yA7KT6SlHPJQrkFfIZm45/qwn+fjj3D0MWXMOtnAPq8/tclTesnq8HGpVCgZzROOTRg5GggtP5GtkZ04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717579307; c=relaxed/simple;
	bh=YDtGg4BsHnCEn4QlYTR6VNrpbrmF3vkmv9Jip9H54PY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nlGhK2Vp04yUn7+B1dR1T6B5NvU7WWAQC0qs5v1uvAhxD7Gh8Dro8w7xk3j2PR0HANwRQzRZK1X3zOVfMuVLZUE5nCMwfndwpASVRVc4hIKQAlBWrFHFUhVeZ2AvJtm3g+sO1R5Ca/R8mnzt4VQJE5jbYBOLohBl6mxUt//O3cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xd4Bwxh7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13080C3277B;
	Wed,  5 Jun 2024 09:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717579306;
	bh=YDtGg4BsHnCEn4QlYTR6VNrpbrmF3vkmv9Jip9H54PY=;
	h=From:Subject:Date:To:Cc:From;
	b=Xd4Bwxh7y1HwvCsqCswFzc2PGPq2iJ5KRAvYZiD+IMiBgnT/PU0fMnF464WGnVfNI
	 2SfiCOXZbAQsv6A67ROLOchznEpXoaMGuuF2s/KnrpOkszHqYjGCncotQ1nlbMMvcY
	 1wFDK5wGD9hwZQuOsV8h4NkdyGgjqQgBbSEBtQwOtY+1Nz7QEQmJw2/NTTxaFHWoav
	 AurLhilKb57r8DK4TPzFkYZibvw6n5+7hE8F8Mm116YVWmkWFvtWBNP6gxo6pklCZK
	 bEssBanKlXQtkD1pvEdKY90NoSUEwdqhcffD3JVXGaQ7yxjhjjJXAiH+2/fDGOlBDY
	 f7soPdq9yJsNg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/3] selftests: net: lib: small fixes
Date: Wed, 05 Jun 2024 11:21:15 +0200
Message-Id: <20240605-upstream-net-20240605-selftests-net-lib-fixes-v1-0-b3afadd368c9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAsuYGYC/z2MSwrCQBAFrxJ6bcNk8BevIi46zos2xDFMjxIIu
 btNFi6r3qMWMhSF0aVZqOCrpu/s0O4auj8lP8CanCmGuA/HcODPZLVAXpxR+W8N41Bh1TY9as+
 DzjA+SReklXPqUiRvTgXb4Mkr+ZVu6/oDDD89RIQAAAA=
To: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Petr Machata <petrm@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org, Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1212; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=YDtGg4BsHnCEn4QlYTR6VNrpbrmF3vkmv9Jip9H54PY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmYC4nf467TLY3VysPNrU7384YestbUI6ojFOUW
 lX8boAo69yJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZmAuJwAKCRD2t4JPQmmg
 c9KmEACYZIpFdTBLEq6/z6VmOlhbroGK12DfHAvehxba+bDCodQjzBVce/XxINeCru+4c6AJQ27
 hdx7K1uoOxQmmgTYRh4rQwdgLpUojU9feq2XrCQ1A5KIF9BNXMhrCOGfeJ5ro1prxN1wug/8jzV
 3ZgD2vowfjLMXl3XfVAEnP+oHGKLjlwLtb0HHEb/PRZqrbAQO1e264LbgIBURcIHRRE6PIVB1Oj
 kWXhmhICnDwg0Tl1YHhMkAind6bndDBk6itzGM2xcDv/SwH6wkZprZ8rMxFR9VqbHkZ316WDuQN
 20/M4cuLWdYfFZzg0YeMIqvjXebQcqEDoFk3q5Oo5KQBKn1aWnCUVNWcY2uQFkHXmdZHtjc7n6y
 fzmOmyXxlRcJiCewkYE68/Dn1kahooXJrKR9rw07cKifFGNhRzP6qF4bsfYqAPZ62pznis0RbdK
 lxUlcWp3TMGXnnn3o5cg4rNsvnltokbX3LHZefvqjuhKLWSmjoyLsZZdDbiQbZIzevZFXh0qR2e
 YlUUTupD5iChNzyrOcokyUj+thWPdmf9TviwvFFAGEdk1L3/N9mFCR9rBJfOkdajRKVRlML5br1
 5OjHNzUC4pL9p0cgkX0Y4tgDjBYOSs8mXSG/u5Mdxib3XWD6NuStPK6NeXrmoQ5K3M8/ZECsW+7
 muNt92yjDxZ3vEA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

While looking at using 'lib.sh' for the MPTCP selftests [1], we found
some small issues with 'lib.sh'. Here they are:

- Patch 1: fix 'errexit' (set -e) support with busywait. 'errexit' is
  supported in some functions, not all. A fix for v6.8+.

- Patch 2: avoid confusing error messages linked to the cleaning part
  when the netns setup fails. A fix for v6.8+.

- Patch 3: set a variable as local to avoid accidentally changing the
  value of a another one with the same name on the caller side. A fix
  for v6.10-rc1+.

Link: https://lore.kernel.org/mptcp/5f4615c3-0621-43c5-ad25-55747a4350ce@kernel.org/T/ [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (3):
      selftests: net: lib: support errexit with busywait
      selftests: net: lib: avoid error removing empty netns name
      selftests: net: lib: set 'i' as local

 tools/testing/selftests/net/lib.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)
---
base-commit: a535d59432370343058755100ee75ab03c0e3f91
change-id: 20240605-upstream-net-20240605-selftests-net-lib-fixes-7a90a1a8d9d2

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


