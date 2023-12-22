Return-Path: <linux-kselftest+bounces-2332-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 712F681C2EF
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 02:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A72E1C23E15
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 01:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43104A49;
	Fri, 22 Dec 2023 01:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="aqrUVaTx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DECA53
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Dec 2023 01:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40d2376db79so11078515e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Dec 2023 17:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1703210354; x=1703815154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DnhmxqI5A0SFMclqCKs8iiIVTuFKdRL1nASfS8N9wgs=;
        b=aqrUVaTxWuWBFCnplGFPyqDkhj1Rt/JZDuiXycAXOQVc2jYA0pFxT+q4hyRNrgXhnJ
         cacdC1ErF3gpe121mxYsU4Z1MJQKlFONpt5I7bYv/BEbudRfVZeIA+MAkfFb6ppwNY3Z
         HEH/n+1oV8oUjVBj8saIhv1DquJLrnXUC1NyeN188RbpFIaaXEqJcOIQ5awFl25VXKD3
         rFaC+ktGj+z7kgghWkOEsCXjMl0wf8hbm3EdtP0kym5WJvF5Xorvy5RHH6v/ZED6sSl2
         QliwgLkjCiCQrYifTnUBlGgjPSAdU2R+3T6LfzjrkGYnsfs6FIMA+Ptp+FOkvx1qz3Ho
         MYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703210354; x=1703815154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DnhmxqI5A0SFMclqCKs8iiIVTuFKdRL1nASfS8N9wgs=;
        b=NgPKlaXuwgNwLMw8hVgN53TfPlLGczb51C1I0POxjGcs1lMfscP1BMyRkxnDVdVvO5
         maXJyz6ckxu+ovQgbcZh95jleuoLrBHDWR1b80674uRY5nxaHS2ll1xVUlceCt1oCmgz
         //5ahnFYQzCVG1WZbLonxt3BDM51tPwaiAR5En0glBI1dwudQOcAmKV/b2GTbiodQfjY
         qTXTcwbP9789s5eQ4wNqqHXavH5cq0wmpSLzv8FiiZSsypY1WJwWTbCbT1bmMz4npA+S
         KOlbRoQ4962DrTH8xbVS+XpPPF5RsrYw2w+wHeSfGnECEWHIPqtUNWPYnR34n78Xq+EW
         y8jQ==
X-Gm-Message-State: AOJu0Yw+V1h00uV7p3iFRImmsgLqvSsVCAPjUmoGNakM1HyZsOZfq8TW
	j6pebAnkR4Rx0DfDaiwT/A0m3FPORLht
X-Google-Smtp-Source: AGHT+IFAzprbtRHfTqzpISfMH7fcNxTgqcaGc5Ga2GIcCZlCzG1vlXs8jGP1e3JHI+dNr6tImncGEw==
X-Received: by 2002:a05:600c:3f9b:b0:40d:4412:7994 with SMTP id fs27-20020a05600c3f9b00b0040d44127994mr273443wmb.30.1703210354129;
        Thu, 21 Dec 2023 17:59:14 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id g3-20020a05600c310300b0040c6b2c8fa9sm12991667wmo.41.2023.12.21.17.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 17:59:13 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Dmitry Safonov <dima@arista.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 0/2] selftest/net: Some more TCP-AO selftest post-merge fixups
Date: Fri, 22 Dec 2023 01:59:05 +0000
Message-ID: <20231222-selftests-tcp-ao-fixups-v1-0-39c73817c372@arista.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-b6b4b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703210346; l=936; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=9D8yHEJAZ8MeKLphgF17Qmq/tuo4/PZoNH30uZQ6pUQ=; b=p8O3AejAko950exU0gI0L06CYoD2cHwNjCsV32Zs1cW9cn/kgtuu+5YUO8OE2R9j05WC/RI8S 8NYu2EbzjUVA1wbC7W5E7MFqN7Ah1oKS2eYV7io1WmrTGabf3iwXPAw
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

Note that there's another post-merge fix for TCP-AO selftests, but that
doesn't conflict with these, so I don't resend that:

https://lore.kernel.org/all/20231219-b4-tcp-ao-selftests-out-of-tree-v1-1-0fff92d26eac@arista.com/T/#u

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
Dmitry Safonov (2):
      selftest/tcp-ao: Set routes in a proper VRF table id
      selftest/tcp-ao: Work on namespace-ified sysctl_optmem_max

 tools/testing/selftests/net/tcp_ao/bench-lookups.c |  4 ++-
 tools/testing/selftests/net/tcp_ao/lib/netlink.c   |  4 +--
 tools/testing/selftests/net/tcp_ao/lib/setup.c     | 35 +++++++++++++++++-----
 tools/testing/selftests/net/tcp_ao/unsigned-md5.c  | 11 ++++---
 4 files changed, 36 insertions(+), 18 deletions(-)
---
base-commit: 857647efa9be89a13cf8963c7e167fab062b28bb
change-id: 20231222-selftests-tcp-ao-fixups-ce70a60e6f57

Best regards,
-- 
Dmitry Safonov <dima@arista.com>


