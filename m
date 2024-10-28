Return-Path: <linux-kselftest+bounces-20823-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4559B353F
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 16:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 157591F22888
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 15:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1898E1DE4F3;
	Mon, 28 Oct 2024 15:48:21 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59EA1DE2DC;
	Mon, 28 Oct 2024 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730130500; cv=none; b=ZGlbYgxP5MSfN7mIQLrFu8riyfBSItS22R2Tyrl86TKDpzrX6h/c6d3zkVISwldETkDnT3MsUxzcIYr1d6zedA5FAjvdAuephBbaRYl8kVv6NBuCPaB76xMA6iN0ZR7bWlKX78SklyRftZ60f7M2JWI8hLIuvPaegfZx8mrXT4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730130500; c=relaxed/simple;
	bh=QBRg+BAsO4rzPVpUtbFYYnBbh6zPHcJdisFyxAIOJYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jCwaddNwg5oSI79IGHp2wBUT2ionlUT4HSoFjTsUSvXbwFezODnpFod5/4TKfgPczN2kwG5P9KdLVo8huu0KsYKL4lPy2zpYt8iGK4I/dUsjaTyC4/cLZnOeiUfpyUH0HpseXob4VgJ8Y5zltHdGG1IquUzEl0JG2tcS/YIP1ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a26a5d6bfso684767566b.1;
        Mon, 28 Oct 2024 08:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730130496; x=1730735296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B2UebL5ZjmVkOrNFeX8IB8xmj1z+yG1JYVmo1T3bbsg=;
        b=fbsrT4dKTAvXbcgWdKo+5YNyXIe6LKOcdeaCmoEDWcKPTB64uu3N+cmom5NTJvoPkg
         ykl4nCmmtQzuk9AVi5VchO9P7vxpkNsj2Gw4XYOcCDejlfkljiScYVgsuvW/evf/OQWP
         oZIENMuk8cWHLJ+Jy7b9LjUVFGYeU+xR/Ss1jIl/j+/yYhngqKAXS6wEHXWK3uRI4os0
         0hp3EageP8BWHH183V0SRPowGyxG01rp+UY8DNWmWxKbMkxaKIFYJ0oToWTvRlPuJd+F
         Sdm1+4BgCpUpqlShFxzEdQgFgZS+/k35RVwx4dl2ojyG8h8I271yfsajWjqDpQCQLBOP
         /Q/A==
X-Forwarded-Encrypted: i=1; AJvYcCUXBWpOwTUcPDc1h7CUUvQI/H+S0hDxbgObLgO2T9GGs+XD8zcJrhgipmt6Ztz33VDId6z3PCI4TI2Ct+2Sg5rS@vger.kernel.org, AJvYcCUe0Yru2mWGhkXlKhAlhX63ozkceYoDnTbwMzR1V0pYjbomFfKaVuuHuGWK3EwV6PlEGBn7cHlP@vger.kernel.org, AJvYcCVOsyV8/hLT88+ba3oYzaDaWDSVk2EgdfLyJn2DSceW0R+K/CzJjTSmvanNamFEz703TWgjDOvvW4+TFIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzNBJOwMsnS/qUsynT8a2FSN1kLrKOzD8Oky8v3ke5ed/cfviJ
	Ue2bBH6fXOOIslgujSITQuy/xAA4rMLjsMJ4+ZxqVR6yrBoi4Vmb+uKptw==
X-Google-Smtp-Source: AGHT+IHIvHm/tkjByNPyE/Ey30QLuagKVIz6iBWyY11ifefCD0/p97TVP8Vje4fMCaRiJxpLzBEcGg==
X-Received: by 2002:a17:907:728e:b0:a99:389a:63c2 with SMTP id a640c23a62f3a-a9de61997d9mr859656466b.62.1730130495846;
        Mon, 28 Oct 2024 08:48:15 -0700 (PDT)
Received: from localhost (fwdproxy-lla-115.fbsv.net. [2a03:2880:30ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b30f5899csm389539966b.150.2024.10.28.08.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 08:48:15 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	horms@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	matttbe@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>
Cc: thepacketgeek@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davej@codemonkey.org.uk,
	vlad.wing@gmail.com,
	max@kutsevol.com,
	kernel-team@meta.com,
	aehkn@xenhub.one,
	Petr Machata <petrm@nvidia.com>,
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH net-next 1/2] net: netconsole: selftests: Change the IP subnet
Date: Mon, 28 Oct 2024 08:48:03 -0700
Message-ID: <20241028154805.1394611-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a less populated IP range to run the tests, as suggested by Petr in
Link: https://lore.kernel.org/netdev/87ikvukv3s.fsf@nvidia.com/.

Suggested-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/drivers/net/netcons_basic.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/netcons_basic.sh b/tools/testing/selftests/drivers/net/netcons_basic.sh
index 06021b2059b7..4ad1e216c6b0 100755
--- a/tools/testing/selftests/drivers/net/netcons_basic.sh
+++ b/tools/testing/selftests/drivers/net/netcons_basic.sh
@@ -20,9 +20,9 @@ SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
 
 # Simple script to test dynamic targets in netconsole
 SRCIF="" # to be populated later
-SRCIP=192.168.1.1
+SRCIP=192.168.2.1
 DSTIF="" # to be populated later
-DSTIP=192.168.1.2
+DSTIP=192.168.2.2
 
 PORT="6666"
 MSG="netconsole selftest"
-- 
2.43.5


