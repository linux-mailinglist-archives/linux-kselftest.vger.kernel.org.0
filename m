Return-Path: <linux-kselftest+bounces-17990-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3899791ED
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Sep 2024 18:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDFDC1F229A5
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Sep 2024 16:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603291D0499;
	Sat, 14 Sep 2024 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxzAka99"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D020B33E8;
	Sat, 14 Sep 2024 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726329631; cv=none; b=T9mIW+tvUSWumdTmQohLwVkP4v68uUsFap4i8sGApV/wUgIAUoCoNcGz4X8LeGe/+TIOgWOmlmVHELVE6l1nouMnA2R/DRMOkzzDuqWpKf66e8T8CJEwIiqhdZOYPN0u3vsLRzNobfa8nNb3OwM2JYcXltDsQN6+JQ3LdX/tmMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726329631; c=relaxed/simple;
	bh=gmhuqzvzoZsULPOnqM46R1nBOweiWnFl3W8Yd+keNgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=np6PrY59tMm66oRLH7hdcjzgxNnr20QZX19g7F7qx5zUeI2SCQIZrocyQFPzB0j9x3DWUxn+ADKDoSbwNXJOKUT91+Qgx8iaSVsQSgzKafRcxdx5n+3UEswHTqXUaXdwvK+tDX5GbXU8LUon9AhDS/iGUvZYZuF6kg1o9CqU60I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxzAka99; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso3032527276.0;
        Sat, 14 Sep 2024 09:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726329629; x=1726934429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pw8obV4t7WvzYfzFMrurtyNaCLSHnDvfl6MF+sbwPeI=;
        b=hxzAka99G5ZtRgaOD1V7WcUlVFk4yZil5ol2EJEDp3UUdheSmpsmBLpO389v1GGAr3
         q4aE3tUM+kgyX0HsQBpVhML2HcAzCDiXcOyxHoOOgWMCbOl3REV2fMB9/R6t8HZgJnQd
         SDqKaU0sv+yhofch03ktyBRzjKJ8h2EsfAtzZwnWBxJqeVn2tpFd9+R/lXNAq4MuOYw7
         yyXszIgl1q2Ww6kx0mB/qEKX524ePIPzx8Yu+bQZgm0efyanUwtT2+QwPVLaQmi3oYiu
         +3UpHLC4ScQi8+7ln2XcP4kCYhIvWkIYpOlOIzceBQNVBO/5VET6HAsZh2J9AJkWLpP3
         m6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726329629; x=1726934429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pw8obV4t7WvzYfzFMrurtyNaCLSHnDvfl6MF+sbwPeI=;
        b=TCE+K3agqf9KBGjx3dGVHFEyByJGhSR6VlipLrm0Sj5KrJ1y/pM1bYQnVoxcpr2LEy
         3pv6VU8eDImcgkesI16HucPuALhnZRVuavZn5z+F+mlvKh9PCy14Am3Xxlj9rtez/ufW
         WOUy9zsYA97KIunEu/5NbSUv0g3ivdwB3YyVMJg9tjgD6mT0ByPDqxOS8N7MkwuYhm9S
         ljJoXvgBYY3WiWqBlpOH92oB1Po73ViJ3XplOnTlnqK558QaetGH7sCgsrNCzEZMVBZ2
         8OA4smlLS2J0cYKrcPO0rtPesrjHo/4x8u1GjauvdjEF4bzp9cubHwgfrz/woRsgUg8N
         gAWw==
X-Forwarded-Encrypted: i=1; AJvYcCUpMQ/Sp87dDowuE48of0Hr5gdNSxZW/FspSRdR6/LCVAWdD8dH1t/u+FpvuaYE5uMyvRetqIYY14JX2Yc=@vger.kernel.org, AJvYcCWV66gI/GO5BRLo8uXQEVgEkbRu9H8T3gnUQVWBfMntd+BpceyN4iWvJCf1WLE9wDdzgeURRykqcJ/WWcnqRSUB@vger.kernel.org, AJvYcCXCTq+/o34XqSzh2oNItt6+0H5XDftc51+dmsRgZytOAVGG8LNEAaWGUcjxpJVBBtHI9aaJMr/A@vger.kernel.org
X-Gm-Message-State: AOJu0YwVEJbiGNRSOE20pc8mFE+dTGU3m0Syn/r8W4Oe2uQ2uWsZaelx
	kejUaavU4JZZ6IINeaJPQqkGAmZOUg9GVXJsskUSJtTiNlNdFttLtMT5EA==
X-Google-Smtp-Source: AGHT+IGFT+SYdQRRuCDaUGQGbIE6pE5mxpTXkPQVIUtM63s57kbgKD6W0SBd7MNUld8Cxw//MO5jGw==
X-Received: by 2002:a05:690c:83:b0:6af:6762:eba1 with SMTP id 00721157ae682-6dbb6b35d38mr84461067b3.20.1726329627172;
        Sat, 14 Sep 2024 09:00:27 -0700 (PDT)
Received: from localhost ([2600:1700:6165:1c10:eecb:23b8:cac:4583])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6dbe2e25833sm2709327b3.59.2024.09.14.09.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 09:00:26 -0700 (PDT)
From: David Hunter <david.hunter.linux@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org
Cc: David Hunter <david.hunter.linux@gmail.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1 V4] selftests: net: improve missing modules error message
Date: Sat, 14 Sep 2024 12:00:04 -0400
Message-ID: <20240914160007.62418-1-david.hunter.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The error message describing the required modules is inaccurate.
Currently, only  "SKIP: Need act_mirred module" is printed when any of
the modules are missing. As a result, users might only include that
module; however, three modules are required.

Fix the error message to show any/all modules needed for the script file
to properly execute.

Signed-off-by: David Hunter <david.hunter.linux@gmail.com>
---

V1 
	- https://lore.kernel.org/all/20240820202116.6124-1-david.hunter.linux@gmail.com/
V2
	- https://lore.kernel.org/all/20240823054833.144612-1-david.hunter.linux@gmail.com/
	- included subject prefixes
	- split the patch into two separate patches (one for each issue)
	- fixed typos in message body
	- removed second, unnecessary for loop
V3
	- https://lore.kernel.org/all/20240827205629.51004-1-david.hunter.linux@gmail.com/#r
	- fixed subject prefix (omit capitilization)
	- fixed spelling mistake in commit message
	- fixed coding style based on recommendations
---
 .../selftests/net/test_ingress_egress_chaining.sh    | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/test_ingress_egress_chaining.sh b/tools/testing/selftests/net/test_ingress_egress_chaining.sh
index 08adff6bb3b6..007a5d04c3e1 100644
--- a/tools/testing/selftests/net/test_ingress_egress_chaining.sh
+++ b/tools/testing/selftests/net/test_ingress_egress_chaining.sh
@@ -13,10 +13,20 @@ if [ "$(id -u)" -ne 0 ];then
 fi
 
 needed_mods="act_mirred cls_flower sch_ingress"
+mods_missing=""
+numb_mods_needed=0
+
 for mod in $needed_mods; do
-	modinfo $mod &>/dev/null || { echo "SKIP: Need act_mirred module"; exit $ksft_skip; }
+	modinfo $mod &>/dev/null && continue
+	mods_missing="$mods_missing$mod "
+	numb_mods_needed=$(expr $numb_mods_needed + 1)
 done
 
+if [ $numb_mods_needed -gt 0 ]; then
+	echo "SKIP: $numb_mods_needed modules needed: $mods_missing"
+	exit $ksft_skip
+fi
+
 ns="ns$((RANDOM%899+100))"
 veth1="veth1$((RANDOM%899+100))"
 veth2="veth2$((RANDOM%899+100))"
-- 
2.43.0


