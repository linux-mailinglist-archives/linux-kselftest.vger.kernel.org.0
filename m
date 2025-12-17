Return-Path: <linux-kselftest+bounces-47635-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B209CC60C3
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 06:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAE793012CF2
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 05:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C4D28312D;
	Wed, 17 Dec 2025 05:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="BBaqLx4j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2FA1FF7C7
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Dec 2025 05:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765949716; cv=none; b=CZc7pbENPj+KAPmVmiCiEAhAisrHPyI/Op3wAcGOW2a3M7fPEvQwlxmNZxGwmpJL3jyJGWKaAE3pWVtE6dZprmwnEn5w89URAyAg8PZ7DeSZzPC07shjc/aeVSvRVTaY8VNcVzzGCuRCxY3Gqm5KwXXznP8qqtoV4ZGDHSUEfO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765949716; c=relaxed/simple;
	bh=zNjQrhjX8JZLaXK8gmwe1fdVRs/ji/Di5HGBiJEYyx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kuwG+FbatDHHBUAU/yh5c8o78dVk55ucL9Ef+vTXLrWRF2jGMVswID/2e8mG28aFEEh+UK3nWH2sbIr+FP50wn6SnqDZnldwbCBS7PGUq2v2vX5mzCv/Vo0Ne4OMjzIyOkWxXEe8Q1ZJyudYUS+JPAbAUqoOHqSs78WBRy2UBBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=BBaqLx4j; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-34ab8682357so632924a91.2
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Dec 2025 21:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765949712; x=1766554512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gO9go+VLEnZ5bIbrwPckrpuRlhcnoKEdRdraJ94IRAM=;
        b=BBaqLx4jBKDWsJLkyxRn2FVEEgG9fSwzwFYN/ZiknLb6XqEA6xzuxlf0q/mobGPVAI
         I2C8Am9J4JaqbchMimhryyNBF7/jbw478rWHtO3RqQ3pS/XdyMHUstsw5qbzG0xMANcs
         a5O9TgVn+zdDu5G/EJf7enB5h5Zq8RFhNp+po9LOh+irieSThdOEm+JwnhRNKrF/Fw/k
         ODgU1agA1lGwdzhNNwrmY3B+RQCzl338VSlC9oB4Ob7Z1MxZcQkORAwHoEUIJgoU55c3
         jWOo2h/4IeOlU0oTN1qcRbUQkFBjQM+Tiyh3BxcNsOJ1CrnTdf+O+x7uX9JglB78KAf0
         3IBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765949712; x=1766554512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gO9go+VLEnZ5bIbrwPckrpuRlhcnoKEdRdraJ94IRAM=;
        b=L3IhxNQJCUjy2a5QudrPh37BAZGSQ5c40cTW0Z4KbMix4fUx/uL3fZUMQlomHmRPVN
         nOP286M8h2TtU2u5Q1H0i/Vvd8/gc1Ys8pQ71e4Vj8/jl58eWzEG4ptJ3EaDlKnogPmk
         eNTtLTn4jCLGpToKnluzeaGxIGvm0D+POFQLt99nxug54hUtBf2nVdCI40xbVNb/LR0s
         hCdpwID6wAAGR715I+mL1GHkjVKZauPihCLgQCeV87D1mNhwNgGWjJAOMR5/+Be6qk5c
         SMtI+tv24ySqgazsb90ffSxHyx2WCcky1cJpwuzR0gURhSGiBfQxu+5ppVWZgk2nMDUU
         ojvw==
X-Forwarded-Encrypted: i=1; AJvYcCU5yW8ZinALAstFkOOwjW2Kmy18Z7UaOM8Ew2GmUTEheUZEP91I3d+986u1d4H9f8kgnIq41tK47xn3Ozhx4S8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/oaCHoroQAHh9Emy0ks+0ZB36xZMy0FxrnOmgV5A+KzvqFhJR
	9A7SfRBpgl1hvq5BBy4L2eiLtmwNO1sFMnUJtcN7eEz9urUh9tF5IGQ65kD6z045h/AY3e0t/jd
	vSzRe32BEqB7GLCh4hvWnotCV5SJLnFdiibaq
X-Gm-Gg: AY/fxX5YSlT9EzU7NgKoq4FXDo/Hsdmo1xtEFB20sTUSrG97A5f92D0ED6HIZtv1BrG
	AVBqKubblDyxsd5ca3swVfnIN/tnwfaan1KAP/w5XQ04WCP9mTyel5Zl6KBPxK3HqNDVPDyteWE
	vEuQKbrP5PIZ6LZ9Bxvt6pgdWaKWE1DCMV1qUdorwkJskSw3DQIkbRHFTsWwt6YVDc/9PAa8hUg
	HmjHMt6tfYKh1znBfNS4m2/b7/CdRPqev6H2j1MOs0EUV+YRLncP/WXfPf7FU5lskKCQLHHHmZS
	YiceCWxWQpNNC5cq313LF3cjeFYAta10NVtgJEpNuqmgDK4n3CK4LiCuHsugf/XTHUXrCywarEG
	Fj5vYTgBcirkKF1faMDIwct4+WSAp8kWYQrUXd/vfpg==
X-Google-Smtp-Source: AGHT+IG2gaZMnrtuUwE0e3yeoSmxUpr9QSg6vaNvSXYJOUbZXsVgkWvgGHLyHIaCBfPRPU8lfsCDFHynz0Yo
X-Received: by 2002:a17:90b:2692:b0:340:e8ce:7558 with SMTP id 98e67ed59e1d1-34abd3d3a27mr11742349a91.0.1765949712374;
        Tue, 16 Dec 2025 21:35:12 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-34cfce259ebsm224228a91.0.2025.12.16.21.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 21:35:12 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id CC0573420F0;
	Tue, 16 Dec 2025 22:35:11 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id C9387E41A08; Tue, 16 Dec 2025 22:35:11 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 04/20] ublk: add integrity UAPI
Date: Tue, 16 Dec 2025 22:34:38 -0700
Message-ID: <20251217053455.281509-5-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251217053455.281509-1-csander@purestorage.com>
References: <20251217053455.281509-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Zhang <stazhang@purestorage.com>

Add UAPI definitions for metadata/integrity support in ublk.
UBLK_PARAM_TYPE_INTEGRITY and struct ublk_param_integrity allow a ublk
server to specify the integrity params of a ublk device.
The ublk driver will set UBLK_IO_F_INTEGRITY in the op_flags field of
struct ublksrv_io_desc for requests with integrity data.
The ublk server uses user copy with UBLKSRV_IO_INTEGRITY_FLAG set in the
offset parameter to access a request's integrity buffer.

Signed-off-by: Stanley Zhang <stazhang@purestorage.com>
[csander: drop feature flag and redundant pi_tuple_size field,
 add io_desc flag, use block metadata UAPI constants]
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 include/uapi/linux/ublk_cmd.h | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index ec77dabba45b..5bfb9a0521c3 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -129,11 +129,15 @@
 #define UBLK_QID_BITS		12
 #define UBLK_QID_BITS_MASK	((1ULL << UBLK_QID_BITS) - 1)
 
 #define UBLK_MAX_NR_QUEUES	(1U << UBLK_QID_BITS)
 
-#define UBLKSRV_IO_BUF_TOTAL_BITS	(UBLK_QID_OFF + UBLK_QID_BITS)
+/* Copy to/from request integrity buffer instead of data buffer */
+#define UBLK_INTEGRITY_FLAG_OFF		(UBLK_QID_OFF + UBLK_QID_BITS)
+#define UBLKSRV_IO_INTEGRITY_FLAG	(1ULL << UBLK_INTEGRITY_FLAG_OFF)
+
+#define UBLKSRV_IO_BUF_TOTAL_BITS	(UBLK_INTEGRITY_FLAG_OFF + 1)
 #define UBLKSRV_IO_BUF_TOTAL_SIZE	(1ULL << UBLKSRV_IO_BUF_TOTAL_BITS)
 
 /*
  * ublk server can register data buffers for incoming I/O requests with a sparse
  * io_uring buffer table. The request buffer can then be used as the data buffer
@@ -406,10 +410,12 @@ struct ublksrv_ctrl_dev_info {
  *
  * ublk server has to check this flag if UBLK_AUTO_BUF_REG_FALLBACK is
  * passed in.
  */
 #define		UBLK_IO_F_NEED_REG_BUF		(1U << 17)
+/* Request has an integrity data buffer */
+#define		UBLK_IO_F_INTEGRITY		(1U << 18)
 
 /*
  * io cmd is described by this structure, and stored in share memory, indexed
  * by request tag.
  *
@@ -598,10 +604,20 @@ struct ublk_param_segment {
 	__u32 	max_segment_size;
 	__u16 	max_segments;
 	__u8	pad[2];
 };
 
+struct ublk_param_integrity {
+	__u32	flags; /* LBMD_PI_CAP_* from linux/fs.h */
+	__u8	interval_exp;
+	__u8	metadata_size;
+	__u8	pi_offset;
+	__u8	csum_type; /* LBMD_PI_CSUM_* from linux/fs.h */
+	__u8	tag_size;
+	__u8	pad[7];
+};
+
 struct ublk_params {
 	/*
 	 * Total length of parameters, userspace has to set 'len' for both
 	 * SET_PARAMS and GET_PARAMS command, and driver may update len
 	 * if two sides use different version of 'ublk_params', same with
@@ -612,16 +628,18 @@ struct ublk_params {
 #define UBLK_PARAM_TYPE_DISCARD         (1 << 1)
 #define UBLK_PARAM_TYPE_DEVT            (1 << 2)
 #define UBLK_PARAM_TYPE_ZONED           (1 << 3)
 #define UBLK_PARAM_TYPE_DMA_ALIGN       (1 << 4)
 #define UBLK_PARAM_TYPE_SEGMENT         (1 << 5)
+#define UBLK_PARAM_TYPE_INTEGRITY       (1 << 6)
 	__u32	types;			/* types of parameter included */
 
 	struct ublk_param_basic		basic;
 	struct ublk_param_discard	discard;
 	struct ublk_param_devt		devt;
 	struct ublk_param_zoned	zoned;
 	struct ublk_param_dma_align	dma;
 	struct ublk_param_segment	seg;
+	struct ublk_param_integrity	integrity;
 };
 
 #endif
-- 
2.45.2


