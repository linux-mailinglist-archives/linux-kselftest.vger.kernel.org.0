Return-Path: <linux-kselftest+bounces-39383-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86370B2E16D
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 17:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0259E5A0BB7
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 15:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7A92E8B74;
	Wed, 20 Aug 2025 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ym6cbr/Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9878E280325;
	Wed, 20 Aug 2025 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755704644; cv=none; b=mO5ae6ZxQmDRx489voYZTQ1wCbWIsVw+rFF+/IYkHNABQC4CmNCKy3CnHT4Lk0lJkefke1QixuQAObdaOv1fckALumOvT46J5Ugi1ZJGD//a0FN8l3PPPRPrw+ca/3FNK71xbGFn/QhTZ3Afv4W1VjWrGo7/AwUdq41gea+Bugo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755704644; c=relaxed/simple;
	bh=ksVrbv0ANSstCuaUNpZ6lY5WdHlGllFDmru27C7xkrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XZgLZpj4KzTAGSivA7sPc0SR83fatl5lAzNTAQ4W3uN3sgFTLW2m8nJAIIDLff6V1EYs6Dxsbe+GIHgIHYRXj+2omsrWsFcqImb7UhBqRiXnQpiLhBjlhnV7EdSQwGJCthDOqnkg2AV0o/1wIujFlVt/WQZcbLDcsWUk9Hfhmcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ym6cbr/Q; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-323266b6ff5so40231a91.0;
        Wed, 20 Aug 2025 08:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755704643; x=1756309443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bKzYlK8zQ8ggkStKH3hXym6+TYxzBzWA/D1b6WG96R0=;
        b=Ym6cbr/QhG8+1st3dSafmLiPklqrSyjj9gQJShixiIvGwvyih3y8T5T9e3uc3VUyR6
         SWsY4/4TKcWASLHRJWLXy3sToRJQS9ZtMGKikrqtogb3Wg+7umEQjaWiJmX13Q4c+LfK
         Ev9A3s05992KmmBGhRw9lC6GvlwDfn8IZgVPQEBxJFweBgf2hsjl22kvXSCUUXAVpX1l
         yiDsckLgtYJM0+kGYXlgU8ZM+7AHlHvhjt0aPmo7wpKzwPYBBhuBYCDS1oIXQF8v1MbS
         wV7X6VzBzizZ6aX8gfKu262CutjWA9dIAdDPbvJ8A7+c4NZU/V0tHfkkjQGKULEmiLgl
         Mfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755704643; x=1756309443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bKzYlK8zQ8ggkStKH3hXym6+TYxzBzWA/D1b6WG96R0=;
        b=f2/D+JsupqN6Fen1sDBN+TPy1WmV6+8TkWsanKgZohuxy9JRjg1oRrz9sySTnlOIlz
         qH92D0pH2idepp+2DJXW8wekT4R6Qvn/F7vxwUkhoEASdgzfA2qT8HJJeFrZjszD4Vpq
         Td5b0xiW2tPiG7P9oM8Ry/tOt2TLztR9Wg6ye8/RnMikALHzKbS7j+4Jt+6jXueX7yFV
         SE8MaeaZZp0oST6u7DElSOkcCF2LZ65mPXSEYr8rnhgYaeTB/GSO80eqxiPCb3H8o11F
         cizRgBWBPBKAMv8wXZFG+TRhwV2R66aeYo3RFvKgzsu1wnnZ3AnnUoIlYhAup7cl4fJW
         JEFA==
X-Forwarded-Encrypted: i=1; AJvYcCVEV/58mua98YXbwCKKssxtOU2dwcvoGmKvKC/KTUFK1odmRB23Hlmcp+XrxukdAINuahRuKTodHyIQCWkatmQf@vger.kernel.org, AJvYcCX9idJVeDAhmbN9890HJz0419oSsnK07j74tXQtKEX2GVi1/PlMNWcSkbBS0Ta5J1H60uGvrkPB1zst+MU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZcmlSQSvc5Wswqpk2ehCumx5M61ARfHRMgNE7zDUs1ioO6dYj
	tDzzGdNUvtutnKpXCir/i+SSj042aEvRTEtNorpleW3ghRLHnEwfooPf
X-Gm-Gg: ASbGnctAP4nmEnBAniSbkRJYtOTFzpRXXduvI5FuwOROa9R2eHlNH/J0GwWr+2gOuk5
	GtiJ28dxE4AmySnBPkgbZjAWWfz9lOsu7VxAZ5QGPChRKYm+oCwG2RDh0vqkdglSWecqdJSjgSf
	KeADPT2Bf4p6OQEBG7PAShnv2oFzoowbMG+iA3yAF5gwL76eMPNEnu/f24bBJHJlyyOojj8IIqP
	T7UHVqwe6uOKXymrfftNEnx0Zv4YhEOyl05voxsMsa8eCpGruHwhPnXEsv5pgl6wLjnXmEMj6Wt
	nSm6/6eMiOHxPfHR4x5VXu+mHPpGcKW4EzX7fSAu6aw3PcMd58pTIRJCs0dbMVCBKgeUA3oqmuP
	Gzo0OT0DrB9YYokG+nUUlUxUz05jHUQXRg2VQMDWqjjzKOyGT4w==
X-Google-Smtp-Source: AGHT+IEoK3LgcqM2J5L6HXT4MC6WDaOmGnQgjZAHypS37Lz0UAIZ1bbDVcpUZ0pnm0v2X4bZSb9tAw==
X-Received: by 2002:a17:90b:4c11:b0:30a:3e8e:ea30 with SMTP id 98e67ed59e1d1-324eb9de67dmr39919a91.11.1755704642819;
        Wed, 20 Aug 2025 08:44:02 -0700 (PDT)
Received: from localhost.localdomain ([202.164.136.133])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324e254ca61sm2719944a91.15.2025.08.20.08.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 08:44:02 -0700 (PDT)
Received: (nullmailer pid 70722 invoked by uid 1000);
	Wed, 20 Aug 2025 15:42:37 -0000
From: Kathara Sasikumar <katharasasikumar007@gmail.com>
To: skhan@linuxfoundation.org, linux-kselftest@vger.kernel.org
Cc: linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org, katharasasikumar007@gmail.com
Subject: [PATCH] selftests/netfilter: fix typo in comment
Date: Wed, 20 Aug 2025 15:41:10 +0000
Message-ID: <20250820154109.70598-2-katharasasikumar007@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct spelling of address in conntrack_icmp_related.sh comment. This
patch fixes a minor typo in the selftest script for netfilter.

Signed-off-by: Kathara Sasikumar <katharasasikumar007@gmail.com>
---
 tools/testing/selftests/net/netfilter/conntrack_icmp_related.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/netfilter/conntrack_icmp_related.sh b/tools/testing/selftests/net/netfilter/conntrack_icmp_related.sh
index c63d840ead61..f63b7f12b36a 100755
--- a/tools/testing/selftests/net/netfilter/conntrack_icmp_related.sh
+++ b/tools/testing/selftests/net/netfilter/conntrack_icmp_related.sh
@@ -171,7 +171,7 @@ table inet filter {
 }
 EOF
 
-# make sure NAT core rewrites adress of icmp error if nat is used according to
+# make sure NAT core rewrites address of icmp error if nat is used according to
 # conntrack nat information (icmp error will be directed at nsrouter1 address,
 # but it needs to be routed to nsclient1 address).
 ip netns exec "$nsrouter1" nft -f - <<EOF
-- 
2.47.2


