Return-Path: <linux-kselftest+bounces-25982-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA62EA2BF52
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 10:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0A81188B6CF
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 09:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478461DE2C3;
	Fri,  7 Feb 2025 09:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrLc6u8u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C685F1A4F12;
	Fri,  7 Feb 2025 09:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738920584; cv=none; b=skB5lL4ux/Pygj+bIncJQrDCtcEhQfFer+sIubL7N3iQi9D4/EjwQcaJJJBEYAFDSippthJ4IwE5RpVTMYUsn0hiy9FAj1GUkOHhO1T3u1fXuaDFcSZ+WRXDt7xUeBf/MSpfygROwa/EC9LFGkdCvfQf62oY+NO0TrQqRSsSglQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738920584; c=relaxed/simple;
	bh=5+Hu9yPHm6Tbc8+g4GvC2gl5dfJ3gk54ZNNsQu7Jkhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TP9t8rpnirHa0lJYRPnDb9lVW6KzDiOClTJSMYImjGX8a6DSlmmuLnszmR6VEd+03cd9mSUBGgsuIwbumki4xE6c4Q2r43FvjhdycaBGtyy4qD96WCx1V2TPjWzwLOFduxthwlTasPPdkyd5XAhHR/tefMLGf36LzgahbyK2vwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrLc6u8u; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-219f8263ae0so36420685ad.0;
        Fri, 07 Feb 2025 01:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738920582; x=1739525382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XAMY22NhtJUvygHrk6l6MtFGnFU5XIJh1OCCZVWggM=;
        b=hrLc6u8u9ZjVyzjGMCwU7ROuxrTROfxNLHySrwJIxu3M76gkVDJk8R4ArnUwZSJZx6
         /P1lK8Jy3PObSAZfw23xKNd6UcdRo6fMZIAORmiDrAgxZXCCsadVPfcWM0YB5cX2E2UO
         dl9LM21Be1T6pqd10iIkaO3NGdJMX8pMN2SGQ/UCOgCoye91iisntx5YqkPoGoKMczNl
         p25C91lShNKENgO1tyfL8TwWtIiu7N/pUc89DYsG42GuZ3kL7p0dvR0gMd4W/Ex9HHf/
         3mYFZGj1Zw+/QYyGcZzxCbt3s4zqWgqL6AW0ekDNcFusrUXB07zckMf3vmhVwQN4mKSZ
         +tBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738920582; x=1739525382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5XAMY22NhtJUvygHrk6l6MtFGnFU5XIJh1OCCZVWggM=;
        b=G7OYMDCBWFE4R7+urxxCgPwEu0zehCPswTTd1Ufrh4yPytji8tnBpKF4jfLJ+4uJZt
         RxWy24+Hx+tMWl2qvHJdZz8dzj4GDPKVjirCstVBFKxPDkPVobsDF6ESsfvhiVGfPbop
         BeDhKIp3SeOCuIj5rS0iZPy+6kh6pyzFVxrdjxkPj76utj+Pn8nJ+SWZWIvxE34uE/sy
         NT8tWD/3qGNJ6hXDmr+HRIbfn/8Bg4nlePAu62Y6/4EgkI4h3tgnc6uzE5GzXYZdclcz
         xbcBuDu02PHgm6Pdgif5FMy2TLAP7jCteQKnzynG4oE5wbXxaRe9l7EI8eJshp704c2b
         GoEA==
X-Forwarded-Encrypted: i=1; AJvYcCU1GlDmvmZ7HK4+CQFVbOgt+fw4RqNmqbjLtfKv68wWVx+1Mv/7YSEPpHxRxt5HaKD7M6roKVFAsuqZZnDq+U4C@vger.kernel.org, AJvYcCW75uJHKw6diTGlhg+Ni1tZVZSYJYsSUhT4+jXJx08LyCC5VesFwcHpFsuC7qMoDncRUQcozMuv9lJz+cE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhuv0FjKpgEkr92qc98XT84Z2BfEXg4Qb3taTSk1lOCr01aozY
	tIxfbhfMgF1JP+m+NMWy7e/xxv++wRsz5NNbQ8Drub7uBT4DNs7E62juZlNsGSU=
X-Gm-Gg: ASbGnctF83YLR3f43kz1n2wuSl/mODQG37UYRoYNvHGs/g2kKUi3aDGD08+nV+R/Q/y
	tprWj0hWyt4aAYQCGaMdRbPgScaIuCDL0dzZ6V5mjyoGA+xQW63nQaCkhLCRVu4jqR5YcWRO6Cx
	vdTBLqqhLO8c5bsum2iXpZDCWFE/Ha1WIxll9l+Fcw+5xVFpD3/MVk3poZ4eaDSmqgQ1Ghe1BvB
	4qKWWjVoQoCcRtf7zPuiRCxZrC54TO1WPdpbuPGyD1qErGuFX77mCumzfS0O2+V1DnT8ulbpjPR
	56hC2LzhYAATBhh9JX/tZTlLWzo+gDB0iG8=
X-Google-Smtp-Source: AGHT+IH1uDgrGRQGn1rCClQ+qLaVqLDm5wMJxw9wouNttApH6dDgfKO6VXsbHLmR0knLp0JOP/zbEw==
X-Received: by 2002:a05:6a20:e68f:b0:1e1:cdff:5f18 with SMTP id adf61e73a8af0-1ee03a2392cmr4617223637.4.1738920581642;
        Fri, 07 Feb 2025 01:29:41 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ae7f84sm2591586b3a.80.2025.02.07.01.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 01:29:41 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>,
	Jianbo Liu <jianbol@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net 2/2] selftests: bonding: fix incorrect mac address
Date: Fri,  7 Feb 2025 09:29:20 +0000
Message-ID: <20250207092920.543458-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250207092920.543458-1-liuhangbin@gmail.com>
References: <20250207092920.543458-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The correct mac address for NS target 2001:db8::254 is 33:33:ff:00:02:54,
not 33:33:00:00:02:54. The same with client maddress.

Fixes: 86fb6173d11e ("selftests: bonding: add ns multicast group testing")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/drivers/net/bonding/bond_options.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/bonding/bond_options.sh b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
index edc56e2cc606..7bc148889ca7 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond_options.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
@@ -11,8 +11,8 @@ ALL_TESTS="
 
 lib_dir=$(dirname "$0")
 source ${lib_dir}/bond_topo_3d1c.sh
-c_maddr="33:33:00:00:00:10"
-g_maddr="33:33:00:00:02:54"
+c_maddr="33:33:ff:00:00:10"
+g_maddr="33:33:ff:00:02:54"
 
 skip_prio()
 {
-- 
2.46.0


