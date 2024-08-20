Return-Path: <linux-kselftest+bounces-15790-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A81958F23
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 22:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91B4E2835DA
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 20:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEE2189527;
	Tue, 20 Aug 2024 20:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTLiv6lj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B4E1862;
	Tue, 20 Aug 2024 20:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724185285; cv=none; b=Gi/SL4J6yVbAEDxbNdDXCfgWgiXb8oPXrxxeawtmi5JV/1+vcPvxhjHrOY+kEkgupqJFvnZ9mr7n5YzGNkjKtNjzUU7IlV7c6CNcb2IUJKc6OB3vmbgvVJPboRIezWzdutHOTxip2MBIgH8HWp+Yx2ORMzj4pb5aQ3hXtQliFxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724185285; c=relaxed/simple;
	bh=JNXm6zh8O5hiz+5AL9a6a4NLacnvRdEGlOvyHC/2e5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qpy3A2zpN6NkChCk+N0z/wwrfVh6tETiEzLrCys9zd8uCLNpWriDGEUGvBKRtwvWbP7wvx3+Iy+ZpZEs1nA60s198ZrbMbhVR75nrci993GGxYzQK90FYZjmK5E/87r1QXl6Ll8NcAvKSXlDifXwHd3AOZ8q1CzfdPl1kVopTYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTLiv6lj; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-49297fca3c2so2092832137.1;
        Tue, 20 Aug 2024 13:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724185283; x=1724790083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R/C8RebMTwv4Hl6gkOymdVXtdDOAA7fmhZDVJ5EQS/Y=;
        b=bTLiv6ljSun2YOqP2ZutSrsBZb5EXD4ZB7YW8ifErOyuIjvUflB0R4kRnJIaaT7Zac
         iTtt+7OMVehZwZBmrInYdWUP4eL0DU53Vcq1NT4K7RYaYzA5gQKQrHorWTTRNAe/vbqn
         i/zXuQc6XLcbPssIsO78W+ltq5aGMha9Kyl0hY82ohFV/zFHmH90Tbs7BIbohamrIHJF
         cVXHaZZ+lA5tGupZFTsOSdgI+ZIJnhqMwdLErq78UgLDkuT//gNphojLq1ke65URS4G4
         2+AWv/Tv1N6z2Kfm25pcA38J3jZwRbReJw46ISScEoRG5GRo6PS7evaFlQosJ3Rn6uuM
         XIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724185283; x=1724790083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R/C8RebMTwv4Hl6gkOymdVXtdDOAA7fmhZDVJ5EQS/Y=;
        b=Mr0mfC1oJfxV0Pp+hyaTP6GJE0LaJLK48KxIFhXO9v4kuijnpnSUf9wDqNXDelzRta
         MERNWgnHD7bbQc8UZ4fwn19CuM52O2pfPpkfN7t0VyslVE5oyUJj6P/qvrolKbZVq8I+
         rzSU1X3k3ARKcvyZyjeQTDHvQF/LXCbS1wnLCF1F9c0Q3g3fWwLBEx/rQI+5ZUHZg7wo
         Qp/d4FHpAOH73FjFjV4NQHt1usUdaP+UUaSzhJ7LzxvdT7uyPNn+VnOv5yMhQDNfx09M
         6ALO7QJ0Wim/picla5fceWNhb83LdVm+4If4AFOSyRw+N98Rsn11rWg/TlLvV2fPUDqt
         C6oQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaAeHWs4diMNHqTkSGCLQ5YfIYylA1d4drOWII+tdiclL+kgIHEGjwqqidfBvrZwbLHikFwjErJl3f/5XzsrxO@vger.kernel.org, AJvYcCXfNXvIPSujRExuLwaotvhzkp/wJOO0HHItoxOhU+xL44nl4Og0rCsxzTxEq41ICuGhwzi9pBkIMi7mBAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjWudTN61uYmQ7WYBNZbkDYtHexm8cjt2tWC+4CxORC8Q/VpLM
	fUMikZRpi8KuKzvyJhYEuXIu7QrvmBE/kVutPORLz6hoXUqhYFu7
X-Google-Smtp-Source: AGHT+IGlR9IDLGdqKoGibFyrrU7/zY7z/pqdmRB3n9fnYsxREhK/TqV6/hmuKFKHQHSlOPHO57TD3g==
X-Received: by 2002:a05:6102:2ad1:b0:497:1b98:1f82 with SMTP id ada2fe7eead31-498d2e999d9mr493418137.6.1724185282850;
        Tue, 20 Aug 2024 13:21:22 -0700 (PDT)
Received: from localhost (57-135-107-183.static4.bluestreamfiber.net. [57.135.107.183])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-842fb9d5e85sm1638775241.37.2024.08.20.13.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 13:21:22 -0700 (PDT)
From: David Hunter <david.hunter.linux@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	javier.carrasco.cruz@gmail.com,
	david.hunter.linux@gmail.com
Subject: [PATCH 1/1] Improve missing mods error message and make shell script executable
Date: Tue, 20 Aug 2024 16:21:16 -0400
Message-ID: <20240820202116.6124-1-david.hunter.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the test executable. Currently, tests in this shell script are not
executable, so the scipt file is skipped entirely.

Also, the error message descirbing the required modules is inaccurate.
Currently, only  "SKIP: Need act_mirred module" is shown. As a result,
users might only that module; however, three modules are actually
required and if any of them are missing, the build will fail with the
same message.

Fix the error message to show any/all modules needed for the script file
upon failure.

Signed-off-by: David Hunter <david.hunter.linux@gmail.com>
---
 .../testing/selftests/net/test_ingress_egress_chaining.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)
 mode change 100644 => 100755 tools/testing/selftests/net/test_ingress_egress_chaining.sh

diff --git a/tools/testing/selftests/net/test_ingress_egress_chaining.sh b/tools/testing/selftests/net/test_ingress_egress_chaining.sh
old mode 100644
new mode 100755
index 08adff6bb3b6..b1a3d68e0ec2
--- a/tools/testing/selftests/net/test_ingress_egress_chaining.sh
+++ b/tools/testing/selftests/net/test_ingress_egress_chaining.sh
@@ -13,8 +13,14 @@ if [ "$(id -u)" -ne 0 ];then
 fi
 
 needed_mods="act_mirred cls_flower sch_ingress"
+mods_missing=""
+
+for mod in $needed_mods; do 
+	modinfo $mod &>/dev/null || mods_missing="$mods_missing$mod "
+done
+
 for mod in $needed_mods; do
-	modinfo $mod &>/dev/null || { echo "SKIP: Need act_mirred module"; exit $ksft_skip; }
+	modinfo $mod &>/dev/null || { echo "SKIP: modules needed: $mods_missing"; exit $ksft_skip; }
 done
 
 ns="ns$((RANDOM%899+100))"
-- 
2.43.0


