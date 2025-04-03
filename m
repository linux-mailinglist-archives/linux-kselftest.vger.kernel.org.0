Return-Path: <linux-kselftest+bounces-30042-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E895A79BB9
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 08:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8182B16DCEF
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 06:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA7D19B586;
	Thu,  3 Apr 2025 06:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDbE/yfR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EBC2E3365;
	Thu,  3 Apr 2025 06:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743660277; cv=none; b=mP7hEjYIk67g49BgTkai5EA/lo2RgYWRALpR7vW3I9pKwy+Pgc6LmX1p/7JAWVYlyZMSuKTqaYmU0qtkBVX/QedwDVJaStVzOtAhCXLa1jGuTlC1F65b6AeUOtxWIckgSna6msvFmPWnJD3wWfnkoe2RM6HZ0fXd9g1YXBKSZus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743660277; c=relaxed/simple;
	bh=09yuoNAzSgpF1gyM/BFGlRHErcnoZzh0W4cOwq3zKt0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XvQ8+/IZ3QmduGP5eJWVHbUrS/K2Zg03zf9Wi/DvqIp+7H9larGpA4Yrr/gNjq9GmcZYB9Cmwhw/oJ3o3RHLiptjYF9UFuXiurgWVQc5Wi6R+1x1VnWH0XjdkkbEDsLzV+CandPrvsHRB+BbMJSYW/A9n9USXvyYBmBSlV5b1sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDbE/yfR; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7369ce5d323so425635b3a.1;
        Wed, 02 Apr 2025 23:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743660275; x=1744265075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqmSQmUNw3Cn1jMKNYZ4RD5umYY4llWfEDwUax1wrhQ=;
        b=TDbE/yfRXKHKg1ljXehukflxuUF95wPvE1PnHvhTeT2bqHno3ElENwsOsh8y8OY6dt
         zsYy+uK6qb2Lfyj/ZFmKLVGeqrzu4OkcpoffzWQNnuriFrDU+5O10JwBrU6kTkDXXYTk
         ZXfYewR1SM25/t4fCIkAeUBNNswbMv8nts0OhWmk204hO8wuPcemlHE0K2b6sli4Vueb
         4YR7RkPY1nRWApUpRS60d/EBNf4PCx5DWL32gGwJcaDDN3xO4kFMq9ejww+7+P3E9kol
         gNBfuMDLDukTeUwhkyVm4eB8Cge+xLEkWWn+SMaGIvWUYhrqQl1XQZZofWs7NtT37YLu
         +KvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743660275; x=1744265075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZqmSQmUNw3Cn1jMKNYZ4RD5umYY4llWfEDwUax1wrhQ=;
        b=oxRgJQEMemPgW3hoNhuo35juZKgZGpbNA7hiPitbO5uCYZhEYOEknJz3cuBl3FNuCY
         I40zf7ITWj05v2Smy9Fi2jAbXHlPSmgSrx7pKmSHgcB6GC6fcxelrN+Y1ya1xPb9f8wq
         Kw5ZAQEo+pdQ7rEZ6c8KR/tVw88RB3WIGOTp7qU7RCwgic8KDOi3+jmnil1LcZHU4mJR
         wlT016qZEP2R2Rh4v+rYtAErHsgIAtZQ3lwZ4wOzlZMLWPA7K8H7q91XkHfaA9/lV6l5
         +zG7Abf4ZoMvSPRXXYFgAm4m7oiGmC5qXenwfMZVEy2KfQYdBH8Ec59t2TCX2fv4tiLM
         L9RQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/gWRsymF/y7oVgWLq2/og4RWbtNsQgQ6EzAmectE5Om2m45sZ8q/OVsH6/gDdy5KOZyOcXzF3@vger.kernel.org, AJvYcCXPx69lKraf5PZLQBDXf3iaIybmjcM0H1RgsvcwZgtq0X5l+5lyM883/Qv/wIHyt11c6mL9b1E5OxaF3EogkEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIilSdC0ULLYGrEeJbRyE4PZcYriLZbcYrA6rLjLBvhhANW8fz
	5BDLAxYUh7TyNWQeyqYO9tS9KIpe1jn6c96rEzCEARIXeMHdi/dE
X-Gm-Gg: ASbGncvbQ6BSfuSGgp9CQKMVkSUf92gJuCWIdr2zkYj7eP4ElYqGC8Dac6DyNow7Moz
	WcjSkJ4p50S7GN7lrqicEd1IS9WSCrBp3izNnCiEnW/gdLejyeMc65MoePAi3CWs4Y4zu3EgUIs
	uYh4F/z1CsJbj7v7QkST8JW60BrNerfTMupvb9dDLPNklKpf1Fjp5O0dFse3ua3IuzauxxSWOkt
	5lA2b/MNjaGOvkX+BaGJ8AdGaFBP96mI588of6rdsyeVS8lM1s+qjQCpsrniui2qd4UNlI5HnaI
	7cWDPch93drvPt+L0KtyB/n5ZDMbfGZUOg==
X-Google-Smtp-Source: AGHT+IGZPrwN8XyW2YRI5ZNJZD+er0I5mIU/CkE7Iz66ysPNnwb3d889ms7fqUCXucTC4jhDtv0MHA==
X-Received: by 2002:a05:6a00:1412:b0:736:3fa8:cf7b with SMTP id d2e1a72fcca58-739803bc866mr24734144b3a.13.1743660274876;
        Wed, 02 Apr 2025 23:04:34 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0e3141sm615340b3a.173.2025.04.02.23.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 23:04:34 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: kory.maincent@bootlin.com,
	willemb@google.com,
	aleksander.lobakin@intel.com,
	ecree.xilinx@gmail.com,
	almasrymina@google.com,
	daniel.zahka@gmail.com,
	jianbol@nvidia.com,
	gal@nvidia.com,
	michael.chan@broadcom.com,
	ap420073@gmail.com
Subject: [PATCH net 0/2] fix wrong hds-thresh value setting
Date: Thu,  3 Apr 2025 06:04:21 +0000
Message-Id: <20250403060423.1209435-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A hds-thresh value is not set correctly if input value is 0.
The cause is that ethtool_ringparam_get_cfg(), which is a internal
function that returns ringparameters from both ->get_ringparam() and
dev->cfg can't return a correct hds-thresh value.

The first patch fixes ethtool_ringparam_get_cfg() to set hds-thresh
value correcltly.

The second patch adds random test for hds-thresh value.
So that we can test 0 value for a hds-thresh properly.

Taehee Yoo (2):
  net: ethtool: fix ethtool_ringparam_get_cfg() returns a hds_thresh
    value always as 0.
  selftests: drv-net: test random value for hds-thresh

 net/ethtool/common.c                       |  1 +
 tools/testing/selftests/drivers/net/hds.py | 28 +++++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

-- 
2.34.1


