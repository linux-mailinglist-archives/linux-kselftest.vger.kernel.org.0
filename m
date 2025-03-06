Return-Path: <linux-kselftest+bounces-28375-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C58F6A54399
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 08:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7BB03AFE0B
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 07:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A179F1C84DC;
	Thu,  6 Mar 2025 07:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyMFoK9D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFB51AAE13;
	Thu,  6 Mar 2025 07:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741245893; cv=none; b=Z6Fi2xxB8yNOt+S4wD4IJCS9xP5Yunz/7wJ41ZrkOxws9kFaYgYXpku1tbK/Ov9NEfBl4cBbmKQI1BSWSa9BCcb0OWs0LbOhvLk1c+bEmycio4uMgV08Z+Rd86wmGaM44YWwIsNLJNliNRb1SWZI7tUVMH92WUm8N0VtGC9vZRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741245893; c=relaxed/simple;
	bh=hG3EeyU+2jUVdt0UYxVRAoTGkWF3x1HGzTV8wWrZGHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qXMQDiipmD+ZnHMfTeaf267BscZ8nDH2XqlRZ9PxMqtHygguPMtGpn4LcXXmr4zEo1GWWuBdFgemfafpt0hj4EDCdrv9mWm2v17dBmSS2IunAARS2erxhYdXjtRvD+rAGDDLjnRTzgh1GziErkF/mNEjx3V7wsnQf44k4g4zjTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyMFoK9D; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ff087762bbso512683a91.3;
        Wed, 05 Mar 2025 23:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741245891; x=1741850691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqURfNYIou125uezA+EAYAmjHbHzvJtt6tWv7wqGDBE=;
        b=FyMFoK9DdP0p6glUSbVBUwPgQ70T0s2TB7/kAQRfVi7K173JdfKYyGC60IopV3TwMq
         Bid74IAXlx6v/iPpS85dLzYM2ckbeVmQSywRmUGrI7QeMMBdI6DYdWlz76M0UilLSqIL
         fB2cInBl9M9Zm09CL8/M3eqSj1EA4l6KDp0P02bUzdTJS40HnFCsV1Dt3mzOavZjRWNp
         T78raVTMRZLlI1WWRDNkRaT9ToiOnzEyGRP4fAfeQE7ifRhTp0brAeEUbh6CQxtMU1UH
         v74BD/7Pg/FKsVmN1Kdd+ONtQmnz88SU30v6iXLQFhwdpqtDXx//XunU9wnmrA1Zres6
         zorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741245891; x=1741850691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqURfNYIou125uezA+EAYAmjHbHzvJtt6tWv7wqGDBE=;
        b=hrBYLzY9zOsW5XUbWD9VPXuy5FHpfTp0by1iPBhjngtUraBtziqmIr1F398/UlKeZT
         aysLsT6hXNDJDcuj1nTGe+R0lYaRPgYV4L0V9Cvk4wo8oVfPUqQa5efSGH9HBo+aK/uC
         5wlOjFTK91QH4caHfgqRC9ylza8vuYLT9dEMWIzdLiY/BENmNbW1TFYBBh9m8TW7FoT7
         BsgZ4GtWQKhJSE86zblmffSjRNieW5gLoJ8R9oHQt1zoPFresdDJ9rztdgew8wuIfKvS
         LtaG/uRfRz2iSAzmLqIYjUpIWKiU7KWbto3IfFEU9C8girI/55hUVHko9dgnv2iBvkkW
         fbWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGiKFkzomZdwTKLmtI33GxCVzDnDMGAsMiJFL5Ydv4ex263qXxUu0rikMgXeb8hIcrHws1bkMZJQ8+H8zmO/Y=@vger.kernel.org, AJvYcCWsfIQOvHAKdtgdIKHAHVvRRJBelhnVFBFB7NyIafOIaz5WGZsZpa/ngxfdO/2JAyQ7aPiKOaff@vger.kernel.org
X-Gm-Message-State: AOJu0YxfZi30DpBqAN4At0yZ0XAcQx2p+sGqbvhLiTp051p2lRwgxVDA
	hZu29k7PURxmzBoEzOXX8fu6Zla1mzozywhq8tJT3OyqxYFNTWYl
X-Gm-Gg: ASbGncvVayWslXdWCZiFAnrV3JkM+dw003bNq4mg7AMz8JhA2yiEyyeufXGRaRXKdZV
	kkCJc2dx5wyNHV8D88Xgv0yv5E0AoVO0d/xZJHhmfZWsq5FUNFoJSm9TPTtQIxYxUGMQdNoLva+
	kyK17WiIp5tslSv21a/FpTPW+se7MUcYrlVIr+1iHL+KD2w+OcUaLX2q+Y9bR00tmfjVBpWW4Rb
	XXTc0uKh/kpzpZ20Q9Crwi3jV7k0nO0FMw1D7qC5JxNaeRNO19A6fGN5qfUTWH693GVyskeawXD
	C7ZZyl+cvSRC3WwDZCQ9RMZ4xZ95MH08BA==
X-Google-Smtp-Source: AGHT+IEcESA0lNK7cZlQN5XAUKQS4VzinPwSWxd7kuvGboUW6Js7LGvmRYndE2qTdOwAgUFVQWONtA==
X-Received: by 2002:a17:90b:4f4e:b0:2ee:5edc:4b2 with SMTP id 98e67ed59e1d1-2ff497935c5mr10093487a91.20.1741245891339;
        Wed, 05 Mar 2025 23:24:51 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693534f8sm567196a91.17.2025.03.05.23.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 23:24:50 -0800 (PST)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	horms@kernel.org,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: almasrymina@google.com,
	asml.silence@gmail.com,
	willemb@google.com,
	kaiyuanz@google.com,
	skhawaja@google.com,
	sdf@fomichev.me,
	gospo@broadcom.com,
	somnath.kotur@broadcom.com,
	dw@davidwei.uk,
	ap420073@gmail.com
Subject: [PATCH v2 net 3/6] eth: bnxt: do not use BNXT_VNIC_NTUPLE unconditionally in queue restart logic
Date: Thu,  6 Mar 2025 07:24:19 +0000
Message-Id: <20250306072422.3303386-4-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306072422.3303386-1-ap420073@gmail.com>
References: <20250306072422.3303386-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a queue is restarted, it sets MRU to 0 for stopping packet flow.
MRU variable is a member of vnic_info[], the first vnic_info is default
and the second is ntuple.
Only when ntuple is enabled(ethtool -K eth0 ntuple on), vnic_info for
ntuple is allocated in init logic.
The bp->nr_vnics indicates how many vnic_info are allocated.
However bnxt_queue_{start | stop}() accesses vnic_info[BNXT_VNIC_NTUPLE]
regardless of ntuple state.

Fixes: b9d2956e869c ("bnxt_en: stop packet flow during bnxt_queue_stop/start")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v2:
 - No changes.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d09986308582..c9d37fea5d32 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15635,7 +15635,7 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 	cpr = &rxr->bnapi->cp_ring;
 	cpr->sw_stats->rx.rx_resets++;
 
-	for (i = 0; i <= BNXT_VNIC_NTUPLE; i++) {
+	for (i = 0; i <= bp->nr_vnics; i++) {
 		vnic = &bp->vnic_info[i];
 
 		rc = bnxt_hwrm_vnic_set_rss_p5(bp, vnic, true);
@@ -15663,7 +15663,7 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
 	struct bnxt_vnic_info *vnic;
 	int i;
 
-	for (i = 0; i <= BNXT_VNIC_NTUPLE; i++) {
+	for (i = 0; i <= bp->nr_vnics; i++) {
 		vnic = &bp->vnic_info[i];
 		vnic->mru = 0;
 		bnxt_hwrm_vnic_update(bp, vnic,
-- 
2.34.1


