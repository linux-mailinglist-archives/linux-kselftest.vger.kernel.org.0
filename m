Return-Path: <linux-kselftest+bounces-18130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD7697C971
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 14:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F25111F21AF7
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 12:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF6219DF69;
	Thu, 19 Sep 2024 12:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWrAna5P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF78619D08C;
	Thu, 19 Sep 2024 12:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726749859; cv=none; b=M965+VFofJvjYUroAH7DfA3taDEJ3G/I6libWVxIX7Td8jJif8fihYsSXa5DtDDoADkCsrS0gEilgrVYOF0jAoIuMQGUKfj2r7JwfHE4/znWKMXEh4yt18/59BG5F5WbJnuOq6v3/7uU1GVWpqAbYGlSNakSKcXLGbRM6XHMVe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726749859; c=relaxed/simple;
	bh=m7uoFWX/UlEJrIzmzKde9Axz0fo13HUh+VGEZG1CACY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OHtxKI3Olvr6aRtjgBdC8n0zr74Z2R3KeR8ZZBX5803cK3Xc6SNAtNtpoMrKOPyOb/WczDYEnraPQtQ795eNupwKDuNO9XE/0ewrN/gv+WNc/nbSeLo6JDRMNgS5zVPaAC4ZMv65bGwixqbyYou6BhfQdeJiP/lwWYBa4Ossxp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWrAna5P; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-457e153cbdcso7036901cf.2;
        Thu, 19 Sep 2024 05:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726749856; x=1727354656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f8ojNp82anMY4plClHiU9t1AUJZlRm2SyZbGYfRBoIo=;
        b=YWrAna5PsKdxUClobkfI75/CiEACyBLqaCtrh200xTEvaO5JRbRPE9Bk1wvfy2axjU
         b4y8TYPe4Q7DyujI7pnVlZp9oJ7Gpr3WvG4QA1qUVJOX9jNxElFUwaOI37ijqpuAEdmL
         V91AeOQGnuylWO0J04UWoDQdUw+ZGVMBhwJk/PaUEwfy6m0+83yV6Or/JiT/aSS+55kY
         lbkeI7JtkPAExX99gQS6yQYM0y7s2OSsFgtRIHrs5r48p8hW9hejvzpNrpgHOrvqVA8v
         akPfRCMy9Pn7viNfNRX3uB6t3+/mR3p96ifaU+NF+xqkMDb2Cegpbw/4j3BciNFDTEt9
         fWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726749856; x=1727354656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f8ojNp82anMY4plClHiU9t1AUJZlRm2SyZbGYfRBoIo=;
        b=oIvEUMZN/4Xq2aNTMs9XPen8X2G2V84K7gTgJuQkEABtxgMYT1zltWtEBkXqPJUEGP
         FWrAtyP7VgWAIEvZNbDEoAPprYyvmwMeg6wv6PDY5yQu1AcjPRl9ateC9SL0d0p6FMv2
         SjBTKrm6Ikd/Zj/TO2hZ9VbF4s/yaF57BOrNvjh+5DngKr0giD9AJ7cpWSpiuo2n48bG
         vpMCbB6ELN/ScFsHTMGlawtAhhGxz/iRcZeqCCP/I1Kl34X+ai+5uc7EQs/Mig6tNzNT
         58EC0MQocAt5CxLMksOr++KUR0ydJqjYv01a6zOurP9D4WvT5iK5ACwIdkoFAZI8VZFq
         UTfg==
X-Forwarded-Encrypted: i=1; AJvYcCVCT7pMgLUYyr6xTkQ+oTSiiVtUDMpHouGkspwY/RyW/51Lrs39vDdhhKYu9jIi/fGgbLrzahf0gX5nqOprooA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8KAHrsjHEg3WsqpXWC1+fR199Ds49lNYghrCMnH6YzsevPU41
	bYIKKivKJ09XwJijvlAzESUANgFv01dljjxDzX/nZ1Oa7M5DGpBfn+qb7bVG
X-Google-Smtp-Source: AGHT+IE/V6Hg2IZppFFuNCPC7XEaedNfaNyWWEileiDSoZX1E7QU0a7FnuvLwgbQcELWfSo4cglkKA==
X-Received: by 2002:a05:622a:38e:b0:458:1dd3:e3a6 with SMTP id d75a77b69052e-4586030033dmr343391781cf.23.1726749856416;
        Thu, 19 Sep 2024 05:44:16 -0700 (PDT)
Received: from willemb.c.googlers.com.com (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b17878e25sm7155861cf.36.2024.09.19.05.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 05:44:15 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	sdf@fomichev.me,
	matttbe@kernel.org,
	linux-kselftest@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net] selftests/net: packetdrill: increase timing tolerance in debug mode
Date: Thu, 19 Sep 2024 08:43:42 -0400
Message-ID: <20240919124412.3014326-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Some packetdrill tests are flaky in debug mode. As discussed, increase
tolerance.

We have been doing this for debug builds outside ksft too.

Previous setting was 10000. A manual 50 runs in virtme-ng showed two
failures that needed 12000. To be on the safe side, Increase to 14000.

Link: https://lore.kernel.org/netdev/Zuhhe4-MQHd3EkfN@mini-arch/
Fixes: 1e42f73fd3c2 ("selftests/net: packetdrill: import tcp/zerocopy")
Reported-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 tools/testing/selftests/net/packetdrill/ksft_runner.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/packetdrill/ksft_runner.sh b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
index 7478c0c0c9aa..4071c133f29e 100755
--- a/tools/testing/selftests/net/packetdrill/ksft_runner.sh
+++ b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
@@ -30,12 +30,17 @@ if [ -z "$(which packetdrill)" ]; then
 	exit "$KSFT_SKIP"
 fi
 
+declare -a optargs
+if [[ -n "${KSFT_MACHINE_SLOW}" ]]; then
+	optargs+=('--tolerance_usecs=14000')
+fi
+
 ktap_print_header
 ktap_set_plan 2
 
-unshare -n packetdrill ${ipv4_args[@]} $(basename $script) > /dev/null \
+unshare -n packetdrill ${ipv4_args[@]} ${optargs[@]} $(basename $script) > /dev/null \
 	&& ktap_test_pass "ipv4" || ktap_test_fail "ipv4"
-unshare -n packetdrill ${ipv6_args[@]} $(basename $script) > /dev/null \
+unshare -n packetdrill ${ipv6_args[@]} ${optargs[@]} $(basename $script) > /dev/null \
 	&& ktap_test_pass "ipv6" || ktap_test_fail "ipv6"
 
 ktap_finished
-- 
2.46.0.662.g92d0881bb0-goog


