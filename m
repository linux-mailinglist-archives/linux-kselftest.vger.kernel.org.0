Return-Path: <linux-kselftest+bounces-10458-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9468CA685
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 04:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8A7BB215B5
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 02:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490E818641;
	Tue, 21 May 2024 02:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="COX99QEW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213E2DDD7;
	Tue, 21 May 2024 02:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716260328; cv=none; b=YteJ6wtehQXCt0fQkh/UR7RDuaRIpPkSt0dZdR5rTqhn4UUHREZkzxhNU/nPPJtt96vzrZN0Et4+K+kNnePw/fyIIsk+iO/sxnCk6TJHUaBQVGI/os3xZ0vVA0aB6lfd+qglX0o4aWOF66qw6Ks+x3aovFFAq4ykTybnFVSQVzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716260328; c=relaxed/simple;
	bh=gKlBpkYXOTJwD4p+BNk74tb3Rj9czrLahPewgupALc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XVz42eZIJs2NvUqI4HYMJcMgZ+XrxDm3pWFvfLr3kccQk5CCmNYE0RzkSanEhd/sxmRE3jE7WE5kQZZMeI5+FGZ6zHHjliOoSDLv34kGFO7N7/A2fO1TDrsliB3/AzinQCnfnIQMo+AroJtbjIzh9gFyKV9TjmCUo8lwsrdtyZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=COX99QEW; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1716260322;
	bh=7kHB/B7pdEbxFksZxcWfPUa01xxD95y0BrxFKM1OMoY=;
	h=From:To:Cc:Subject:Date:From;
	b=COX99QEWSMbpjgoX/Hyr0QExd9jKANW/+lqZMj6opdUETQumAc+ytuURis6vetyrK
	 8x9aqVarCqG97FIYFHRUcGo6hOz/ei/hyF1kvxLWx0x/puBoIQFqWoxBZgpMmuS5M9
	 lwHkenJolSQosv5kl5/U5sef0Slpslszdjvqb+uWsV3dTfgvOBQS4zVy5IQVQRZ87d
	 aH3npmjbNPVvGjbhDZ/NwiZ7gg2fd2pLAucO8GdGSP/vc4X7+piLQbG5LxTAiGY8bz
	 hgbaBK05cg6tmRtIwegk8KpArgcuzXRSjuyEYZOUAzxG63PdA5S+kHUI4gpdPwlbdy
	 d2n42LFwj6RgA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VjzfB4yz5z4wjF;
	Tue, 21 May 2024 12:58:42 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linux-kselftest@vger.kernel.org>,
	<skhan@linuxfoundation.org>
Cc: <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] selftests/overlayfs: Fix build error on ppc64
Date: Tue, 21 May 2024 12:26:16 +1000
Message-ID: <20240521022616.45240-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix build error on ppc64:
  dev_in_maps.c: In function ‘get_file_dev_and_inode’:
  dev_in_maps.c:60:59: error: format ‘%llu’ expects argument of type
  ‘long long unsigned int *’, but argument 7 has type ‘__u64 *’ {aka ‘long
  unsigned int *’} [-Werror=format=]

By switching to unsigned long long for u64 for ppc64 builds.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
index 759f86e7d263..2862aae58b79 100644
--- a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
+++ b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #define _GNU_SOURCE
+#define __SANE_USERSPACE_TYPES__ // Use ll64
 
 #include <inttypes.h>
 #include <unistd.h>
-- 
2.45.1


