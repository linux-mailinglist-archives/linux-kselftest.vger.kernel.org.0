Return-Path: <linux-kselftest+bounces-15345-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28214952139
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 19:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2221C21347
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 17:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FA81BC092;
	Wed, 14 Aug 2024 17:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQeLuUmG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBFD1BC080;
	Wed, 14 Aug 2024 17:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723656718; cv=none; b=ir1IMmYVdTCURvQrAhkLDu5HwAFLXxWOtITOD1iSmM2otgTPRJBV3A/Aw6zhmruTigbmBt9k+iobpy68dj+M6yDp7FKfNPD8ZidPopr5KsMip+Ex+a4dsPR0FYrHOW3ahvy/aR0L5VVuwaGppEDPJ8N5hYs9ANEeIS6Md0wZNfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723656718; c=relaxed/simple;
	bh=5KiMiGMO0+fP9EAr2iCqOfLLXM7bfW30N/BRrU6S01U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YpyCwl3n15qxMrDtZHzk+LxFf1Mr70ebrNtx/u6DxRfYIEkMLkxJ4ngHmGVdoi6uuDhnIpuvK8Zq9LwjC4H/KcmIK/gswmEyw8ks/eAWAkIplnoa7Zz8p/6ok2MAo92wCqtjDHAJDladB0dAJYWO6qUmcYXm1IfdLUoxkvIvnv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQeLuUmG; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d3b595c18dso465747a91.0;
        Wed, 14 Aug 2024 10:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723656716; x=1724261516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8kNWX28Qr8ufHC9hLkI8IOVeCXr80mqcgSghAfdwkDc=;
        b=KQeLuUmGmvIaHMQGkpkFKFAi0elRv/YlaANDZU3YMsl3HW02J+u54p07CFkkYZ5jLy
         zOOwQfTiWPEOOpdUGLnwwq/CoSfHBwLRqugIN8bCn5UJiiGvM31j0+SM7OOVnxiG6DDt
         oHSES16SP0Sec4PrvJRgLVvBVOpsyCcOMYEeSQolc4gMYXr7RKQqJdicmOBXA4C2+gIC
         bCO/6rzo+AwptOyuZ4BKgYNhFM+IKDlZQiHF6AG8YzQaJJ5oaPrxNBzSIhwYpz+WI4zE
         Ul0kQGbeYUys0nZKPNSnpGR1+qzDjc7DqWHEnqIRZqvPm0nGOYkOCkN9mrlz/67bXKXK
         E++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723656716; x=1724261516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8kNWX28Qr8ufHC9hLkI8IOVeCXr80mqcgSghAfdwkDc=;
        b=td01xQ9pCGZcr/fnH2KVFGyQdwtpoEMGDXV2R+vAJUZECvMg/DBarIR0m2NiZsvOAj
         xryuJ9v4+hB4rxFj4BBjBDoheJeHgKQ5YmGeqTzdRD+qz/xT+W78TO9FQWDrcXt9+N0E
         lIFUwenuNdM6VQ72Np4mVCUUmzluaBWW6IFx8obRnMdKmfbv7KmCCI1/md/zycrGH2Na
         Ox/1ReNp0QbiP/83S9sK+Tw0t4d2F77CK4M29Oi/UnhKSKHszyzPnPhw1I8eaPlAzTaS
         G/y/TZdIoFNdmahDoroZS0V7VGqox/RHiFAQp4YNFztwSV7JzzinySKQ0YpW2HUonWF9
         NRwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlPQXdtrKpcrRX2SRRKsz3Gl2WZOVfrI0uzejUGD7NLqeoKeLUcFAUcSr/DIsjdVbaHwjSXtA1/g6PUXC5kTQtA2gRi01p
X-Gm-Message-State: AOJu0YwF8PQ4oLZvW10MHV+pK88H0E+yMki9lolPHixk/VZcIWjkUWR9
	N9kvlUD3wGczNuFdGclwIxmrxBXgaE8YenPdzrGp4YQt/Sx7vYBu9fgQyjC8nnGyKw==
X-Google-Smtp-Source: AGHT+IGsNZIeex367jr2X1FkXZW5sn89pJQKVvDpmP1iqY8hnU7o/l1FwJA/avJArTxmyFZ17BAnIA==
X-Received: by 2002:a17:90a:db89:b0:2c9:90fa:b9f8 with SMTP id 98e67ed59e1d1-2d3c398cee9mr507140a91.10.1723656715507;
        Wed, 14 Aug 2024 10:31:55 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2d3ac7fed56sm2018706a91.35.2024.08.14.10.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 10:31:54 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kuba@kernel.org,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH] selftests/net/pmtu.sh: Fix typo in error message
Date: Wed, 14 Aug 2024 23:01:21 +0530
Message-ID: <20240814173121.33590-1-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The word 'expected' was spelled as 'exepcted'.
Fixed the typo in this patch.

Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
---
 tools/testing/selftests/net/pmtu.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index cfc849580..62eceb385 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -1347,7 +1347,7 @@ test_pmtu_ipvX_over_bridged_vxlanY_or_geneveY_exception() {
 		size=$(du -sb $tmpoutfile)
 		size=${size%%/tmp/*}
 
-		[ $size -ne 1048576 ] && err "File size $size mismatches exepcted value in locally bridged vxlan test" && return 1
+		[ $size -ne 1048576 ] && err "File size $size mismatches expected value in locally bridged vxlan test" && return 1
 	done
 
 	rm -f "$tmpoutfile"
-- 
2.43.0


