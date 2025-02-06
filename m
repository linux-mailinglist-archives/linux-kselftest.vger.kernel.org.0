Return-Path: <linux-kselftest+bounces-25900-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 315A7A2A4F8
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 10:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E762918890A7
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 09:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763E3227B95;
	Thu,  6 Feb 2025 09:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rp7dPDQ4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008C9227594;
	Thu,  6 Feb 2025 09:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738835184; cv=none; b=OzyfEWz9QdAIhSsS3PkCR6SDEYnQ/HXT/3rQFmFPCK0lI8ao29/JCcEh1+aDEyWTePVfZLIpvQ63G5+Oa6IQuRpj3QB+XeCDJUYWOyYWdUSFs6iNwNqpKFa2BFnfuW6W7OHOdptuAieiGNQGNRanjY867DdMQfnHg97k0g1cydc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738835184; c=relaxed/simple;
	bh=5+Hu9yPHm6Tbc8+g4GvC2gl5dfJ3gk54ZNNsQu7Jkhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AXQNAqZg9gxFo8WtjrWLQWVz1/QSE4etQzVmFFV+um6q3/cC2X0gN8lMbzdqy2k5+nK/99p4NGsHX6EZYvdPuSwpiyrZyrQFwDKJle5u/zMWyvTCuIv/xkurpmHJfycENwxXN/lOEgnk6EPtOwKrdIGEV5Le9UMKXNYmImPWh9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rp7dPDQ4; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f44e7eae4so74405ad.2;
        Thu, 06 Feb 2025 01:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738835182; x=1739439982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XAMY22NhtJUvygHrk6l6MtFGnFU5XIJh1OCCZVWggM=;
        b=Rp7dPDQ4AeEFR7a9UXaeb/Q+xfVEQRtBgeNfulhWOlQ6HwtbKKdkaz6AMRhTBbCTfv
         zU0MaTDR9XcVeFbvzDBBYkT4K6+3BsGd/YJkXM5z34Wr2PtjXKfIAPtLFGquNHlzfyZH
         HTl+iuCJAOYEXju84vEZFKfsevotgi3ChK3T4+CJ0Hr1nx7EAEGazJYGXLrBDKdRTzSM
         quuCJbSFKjvBSKOMcKSdTcZYEQI1XBHLPQOzjoiMoSxsf4f51f2bAl1pF0pbFu41kSly
         Wi7XsHC/bBR63oT32qLWKo93Iak0FjW804hqqRSx8w/cd0gkY43fbEZDHpKW49/RCytZ
         9vQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738835182; x=1739439982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5XAMY22NhtJUvygHrk6l6MtFGnFU5XIJh1OCCZVWggM=;
        b=byl++kOd6wUwAjQRJV5/ZEGF/KpnEzK8uR6IjZ4+itrDJ6M84sWbJ9Zh0KhbSZCrhi
         gboyU0NuoTDpTC02rGHi4DecyGCA+VU8QObLZmckRT/qINILUuD5xO2fLB4yUcpy1ObU
         CEtQ1BDqwbCMZHb/JCZ+raB55/orNdplYVd+1rFeIj7uVls3D6D6aHJD6bvinmZ5ETA1
         aS17fYoKJuBcpbDDmIPQKzHecaLEJaD2SNajxy+QOcFZHK2UbRMKw2XOHvAT66ueqcw+
         hedaZSXngOiLdXfUPCmrbYGw5kKzz5p93wgTQvTwFV0wJ1K3KtpBnDpelxfO/m3y/y72
         V6BA==
X-Forwarded-Encrypted: i=1; AJvYcCUHfN86C8dLdreMLCiQCRAkVA8XMxChAR5+6ecLfeEfePVJPG3jl1tWQYKwTaKX6L97SKSnMMjltqvSnGE=@vger.kernel.org, AJvYcCW9xPQHPioI4UAB54DQtXoKDqTfiGCRNEErwgkUDN8/7kdmrdeitwJlwxvMlNep8qQLh8fcX7wexmM8UUlBGepO@vger.kernel.org
X-Gm-Message-State: AOJu0YytEn1A9u2uQSXUJdz6xkch07XOUOwPAiF2reZF2L3To2jQn8yp
	fihgjR/CQLfMGOaVZZWBv3BomsfczIJlc9RLeqz6723hPKZQZDU8pIY7f+p8GS4=
X-Gm-Gg: ASbGncvUIlqkq1dn9tBlPCSIBbg7P+SRoRMUQpt+PQ5KBYGzJerRMeL2ck3y2zf/sN2
	WSaHCCB3GFnO275GjcR536m7t9/qlDO22e9jI648AbuOBNvMfSjYbiQvwpkj6mS/hGZ4L2SeiMV
	yUD+IKpe9tnQ1vDDqXtfYq7Sq8yo1Irh+AHEXDeLR64aPSyaUkwe+aFDh/sDiV07dIp1EQ7FfuW
	7NC9ukIEDYf3TXjQESgT6FL/nDhLcVaI7VBaYqipZukWHODgpQoW481jkkIg/uiwn+nq3NVUV33
	BBDjhTezwWAtysJqUvcmkOykPYf7ypF+jlA=
X-Google-Smtp-Source: AGHT+IF2PTC4qDrLZkEG/Ey4snC5KU4C4VuN+6aytoybzb7swJS3Q2Nzh9+LRfnwBVm8Sol8/kSERA==
X-Received: by 2002:a17:902:e5c7:b0:21f:db8:262d with SMTP id d9443c01a7336-21f17f02bdcmr118633625ad.35.1738835181898;
        Thu, 06 Feb 2025 01:46:21 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f368da60bsm8394695ad.258.2025.02.06.01.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 01:46:21 -0800 (PST)
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
Subject: [PATCHv2 net 2/2] selftests: bonding: fix incorrect mac address
Date: Thu,  6 Feb 2025 09:46:00 +0000
Message-ID: <20250206094600.357420-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250206094600.357420-1-liuhangbin@gmail.com>
References: <20250206094600.357420-1-liuhangbin@gmail.com>
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


