Return-Path: <linux-kselftest+bounces-28559-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D76A58496
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Mar 2025 14:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47645188D19B
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Mar 2025 13:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151661DB365;
	Sun,  9 Mar 2025 13:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9V5a1Rw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C178BE7;
	Sun,  9 Mar 2025 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741527814; cv=none; b=ZCIJz0egcLWJ7ezU00g6gdYPlD/y4a0CxAIW4y2ufy1Pl/yUeGOo3gc1ArZ+nX248HDSwEJqZnxJvIy2srSfCgu1moM5+NCjdQnlFSjFAFhR75IgGmjDuI0x9aTo/g3U+68JpkIuNefjnswdh8E3ZUDL7LvUU/ir2E+ku16lg9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741527814; c=relaxed/simple;
	bh=V4S5Wbszx9Crg4SSCv4LIzdq3NnCxeq6NI4NrTWmsJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fVw5dfVuGrjYpoM923gxCcfL6CW0SDqUfClYaIqzBj+FIxxWlp1Dsh9F2MtJCbd1i/O9BPUrMVnNFLoxUKCoxe8DDuxpadZn/vdqEJAolapWsP3pvn30cyCYn0gvBYsZLkNJFhlwvRucV5elkryVOsHQEb/Ll8k/WCzaFOiqaT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9V5a1Rw; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22337bc9ac3so64257985ad.1;
        Sun, 09 Mar 2025 06:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741527812; x=1742132612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbw+UcRX79oqiVRatXCi24pAZdme3lZtLxWT1phm2sY=;
        b=R9V5a1RwvYzx2BloQGDQilbDxoQ61Hk+sppOi1mRrxqV4jVfmEQr5/Ntbi8qpemX7r
         pADekivh/kOjOBQT2Gpf67f/K0jDhPkniIhV5YRnRb6LJ0nG8Fd33bKuJj0ASPhqN8ez
         6c1YOb06v42kJIWbiacx1/MMOijrxSZHq9o0NHWxFg0KxLCc4iqbhKjsFBGy/rNb37wB
         5WNSNXmXevxwWfeMsZXicge4sB95cATVUWdq/v++bybTxsKHUUqvFqFxikpRNwLG+SQa
         ctZ352cLP2QXl2yhFrSxhanEjcRioswT46xyKiQqMf/5xvmJtzXIcgQzp3rM/qocg5tF
         NUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741527812; x=1742132612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbw+UcRX79oqiVRatXCi24pAZdme3lZtLxWT1phm2sY=;
        b=pFMihfdGP2CJcaLgPDvLVvt1TFcq2J+Rr625fJu3SyeHhKT5Mwb/XiOQ0G03jqToyf
         uzR1V+447GMX61yEfwR/N6NyoB4SyQ7WhMuF6ZuEK0b9MACstLbWCn9K0i8Fg+OjX1Hu
         3vYK6/29ir16rJLr5AMwV2s22gEil1Yfo6qGYgXya/oV8V0s23Pcdl27oJe/9kF8Zccg
         cG08Od0+B7XRdUiB/LQmSsaGhPQnJgd3RFJYNw9HzTyBWFIGl02KKMQQSwny+YbR7eIA
         ofKr7bU1fdpKIdAGbDaY+S/2nXsLNw5464wACQFlvYiI/gckfCqAGF0SNiGXj6bVd6us
         T2cQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgoKMLqPZTYR/27HL7C8Foyjucfjz4+haq4sSyKrZhbsfyWV8jUqrNnNJCE+8U5qRttyxc17lz@vger.kernel.org, AJvYcCXlGbxktWYhg3CS0ZLoLhZ+o1fsMgwH/VfrWl5lYledj4t83YilIO475t6S9SyyIe1RHTtlSaiX++iCOd/a+kg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/ZfEDrF2bEcbbsfHLyf4yoTqIQiT6ZIqupbS3hLQ8lKWSULCE
	v294l5e/dAGk8Yb3f0lghDQj/A3MkkGdXs0AqKiVhwKcUWSaoAU+
X-Gm-Gg: ASbGnctLKPiAcSiUtsSQ6x/Hg5O/74GMclbsFgw+gRmDh6TqmP99QbcxHqnsA8WzuXc
	TuHoOfE8NVrD7hynSVtDrmuzbJHAvPGMNeRcPYfKT5OzDOVU9F4IzO0GSm8rG7NN6hP+k7xFnw2
	rAz97i0ge8/Wqq4MLYNvTFznPJfqVpHY0UYlCneiiRxWGgbR8M5mQI5K535udm7ILHNMBKaNyh7
	P/Br+ZMsh/5x4mrN+77DoJapV1EKelV4mfpydELRmNBoyDRqxCpp+8tz8z3Ma808fQ7bXPaf7ZD
	AM/gPzszppXqOxXyKJ4k0499zH6UG04UZQ==
X-Google-Smtp-Source: AGHT+IGjJ+iLm6xXFkB3FceVjdYPK1rqjIyWbKpSrKB+/cJ3+hcrq/RxW54Dr18RqXt/EJRMm+OKzQ==
X-Received: by 2002:a05:6a00:13a9:b0:736:3be3:3d77 with SMTP id d2e1a72fcca58-736aaac69ddmr12943998b3a.16.1741527811937;
        Sun, 09 Mar 2025 06:43:31 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736c41dda7csm2296841b3a.85.2025.03.09.06.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 06:43:31 -0700 (PDT)
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
	amritha.nambiar@intel.com,
	xuanzhuo@linux.alibaba.com,
	ap420073@gmail.com
Subject: [PATCH v3 net 3/8] eth: bnxt: do not use BNXT_VNIC_NTUPLE unconditionally in queue restart logic
Date: Sun,  9 Mar 2025 13:42:14 +0000
Message-Id: <20250309134219.91670-4-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250309134219.91670-1-ap420073@gmail.com>
References: <20250309134219.91670-1-ap420073@gmail.com>
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

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Fixes: b9d2956e869c ("bnxt_en: stop packet flow during bnxt_queue_stop/start")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v3:
 - Add Review tags from Somnath.

v2:
 - No changes.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index acb9500ef930..218109ee1c23 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15643,7 +15643,7 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 	cpr = &rxr->bnapi->cp_ring;
 	cpr->sw_stats->rx.rx_resets++;
 
-	for (i = 0; i <= BNXT_VNIC_NTUPLE; i++) {
+	for (i = 0; i <= bp->nr_vnics; i++) {
 		vnic = &bp->vnic_info[i];
 
 		rc = bnxt_hwrm_vnic_set_rss_p5(bp, vnic, true);
@@ -15671,7 +15671,7 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
 	struct bnxt_vnic_info *vnic;
 	int i;
 
-	for (i = 0; i <= BNXT_VNIC_NTUPLE; i++) {
+	for (i = 0; i <= bp->nr_vnics; i++) {
 		vnic = &bp->vnic_info[i];
 		vnic->mru = 0;
 		bnxt_hwrm_vnic_update(bp, vnic,
-- 
2.34.1


