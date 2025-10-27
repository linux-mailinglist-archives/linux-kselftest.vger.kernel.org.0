Return-Path: <linux-kselftest+bounces-44091-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B82BBC0D296
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 12:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0433E19A387E
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 11:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A9E2F9DA2;
	Mon, 27 Oct 2025 11:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfUk1juL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3392F7AA0
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 11:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761564895; cv=none; b=G1ZPdedQMoSLJW6zys2MQLkzQlux/kETinD4QolZNrgGcc/yaSAn6ojCwEJ1+Eu502M7yVeLt6biYb122d3JrT3RcvAuE+74kpSvIg3CIG5a0Eabajm+Gh1YDfO0VPhxbIEQYD+jihfksvw4yHFHMSn/4523AD6AJoBrb50Zw1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761564895; c=relaxed/simple;
	bh=5TBB1dS0xdm96UtguSy0r3N+8c94aYIZTQ5p5Qhj/p8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jz21lhNrjys5bKoJRQz4ED72hwOyxmIRn2zVMz/qXBZdXgqSO1s8dMBr8xoB8qBpXS7qDGAeKWoIbcJEMrzISgHpv4LWoxmXJH2AnaYPSUMqwwAbSCw8588mwsRFwLxpMRY2Xkv0FHCo2stMLM2iAx+pmDuznsxKNKheNHuac6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfUk1juL; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-b6cea7c527bso4413709a12.3
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 04:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761564893; x=1762169693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+bbEtFgvtdD4nIW4Ki4K8L2rFFyWkm5SaPEHBXu2tU4=;
        b=dfUk1juLHkT8khrl2rfPRj/9bV1U7GNpn0ugRjQtcLwJsf9myJ6OXMTgXV9q5M9LyZ
         u+WeCjwmXo3oqPwLRPb9gPMwisK0EPSPSGueIQ2ph1K9G4jDdsdJn/WiHBJvkwFAidt/
         fnPiARrn8BJl7Ujxk4KdFlefz1ckXaDH0G/EDmt9GON9fwNTOSCaaNQ993+bFQ/1OnpY
         g39pJre/LSDS8JKilExBcUgpzDY+B4248fKYveRQuV9/ISZnLXonmLVGFQld4dLRItZ/
         ZdAf8SsZ9VafgvuUGqtJ6x/Cz84s5vvoAhENz6r5f97GdYPyeOwILdhkQZ7efGT1jaD4
         jGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761564893; x=1762169693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+bbEtFgvtdD4nIW4Ki4K8L2rFFyWkm5SaPEHBXu2tU4=;
        b=kh5P2QLgj9Jo8lHRlTETKM69mofNDIMPao1YUgpyRzsCfu6jtVHurZaNAq+2oGlfUC
         wyT/VY4paamwCKXLib5qDeqPDTmni5Femku3KYs215x4Iecrq40ZGVcst0OrO99HCd62
         NJNA8jkBTiM6OTstlxulvQ58GgcO8qIMOlNDx3cpOjrq44Ch68TechrnZXM2ZKMqL7r2
         KrHDy1dM+f3dOuBDXk+qL7rNWwODSrDmub7If0HEj/guRZrK1E8xOKbg/27MRQNL+szt
         IPh3LMnhasOlKDYO/Go/3ksM4M+MPfohxXI0OzXV/izpPJb6kZw1F7zFprdJsiij5kcl
         xjAw==
X-Gm-Message-State: AOJu0Yz1K0ZsdLG26Py9BTZFKXA+odBlyd0hIewoEVAG2RC4RBU4WnhB
	Kz08T0owKAYCWkV8FvoxJkooaAKS9SB61zDOFGbXtwAbW7oXqpKdNEyxU9ZO8ojd2NU=
X-Gm-Gg: ASbGnctap3RsMXL04lbqrzcEkUGW0nLqzs9Uivsvbc5DIQ96OOnYBbL8E5hcKkzLF53
	4d06+L+VL6B00OH7SYQ6aBZCTXChuv+OUqAuzxgfKmnhCDdi1w3Zuyjmf4wSdgbHqMC3e1+IiT/
	xeWf0aMBQR407s/7hiyUPL6h4CCr9avi9OxQm6TVwtAdVM7rm8erCbmRty/Zc+PxywLAmpJMV2Y
	U/3frKojSTLWd9/HQnNZyX0kKEwIYyr8nXXdOBN610zn049n5gwoqCfdARadzhr7qDmMk/vgxiI
	8fZhplrEnGHL3ilXwwT5XqPHC2+vHH1zPwLHy2d6jSb3NFg5532J0FcSjpraPqR4QkkVwKVO9j+
	hPBPNkhveDxbF80nKrNM/s0WakFX64wJsGbksJZ4iraHwmu8qD4yj2rTU0liD6qOi5nlV1gdU0p
	ZYEuAf8hpT/3Aqlgs1Sz/qJXOL486kTsqaAUoXAVT5
X-Google-Smtp-Source: AGHT+IEXotOiXJpTCp/puthxXvnmCrnF43T4sh9Ukdwx3XQqsIiiaQDtaOtYzH9OodVVaE5Vc6YsYQ==
X-Received: by 2002:a17:902:ec90:b0:293:a10:12ee with SMTP id d9443c01a7336-2930a1018a5mr217124005ad.15.1761564892811;
        Mon, 27 Oct 2025 04:34:52 -0700 (PDT)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf33f9sm78216485ad.22.2025.10.27.04.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 04:34:52 -0700 (PDT)
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>
Cc: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Subject: [PATCH] selftests/user_events: Avoid taking address of packed member in perf_test
Date: Mon, 27 Oct 2025 17:04:39 +0530
Message-ID: <20251027113439.36059-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Accessing 'reg.write_index' directly triggers a -Waddress-of-packed-member
warning due to potential unaligned pointer access:

perf_test.c:239:38: warning: taking address of packed member 'write_index'
of class or structure 'user_reg' may result in an unaligned pointer value 
[-Waddress-of-packed-member]
  239 |         ASSERT_NE(-1, write(self->data_fd, &reg.write_index,
      |                                             ^~~~~~~~~~~~~~~ 

Use memcpy() instead to safely copy the value and avoid unaligned pointer
access across architectures.

Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---
 tools/testing/selftests/user_events/perf_test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/user_events/perf_test.c b/tools/testing/selftests/user_events/perf_test.c
index 201459d8094d..e4385f4aa231 100644
--- a/tools/testing/selftests/user_events/perf_test.c
+++ b/tools/testing/selftests/user_events/perf_test.c
@@ -201,6 +201,7 @@ TEST_F(user, perf_empty_events) {
 	struct perf_event_mmap_page *perf_page;
 	int page_size = sysconf(_SC_PAGESIZE);
 	int id, fd;
+	__u32 write_index;
 	__u32 *val;
 
 	reg.size = sizeof(reg);
@@ -236,7 +237,8 @@ TEST_F(user, perf_empty_events) {
 	ASSERT_EQ(1 << reg.enable_bit, self->check);
 
 	/* Ensure write shows up at correct offset */
-	ASSERT_NE(-1, write(self->data_fd, &reg.write_index,
+	memcpy(&write_index, &reg.write_index, sizeof(reg.write_index));
+	ASSERT_NE(-1, write(self->data_fd, &write_index,
 	                    sizeof(reg.write_index)));
 	val = (void *)(((char *)perf_page) + perf_page->data_offset);
 	ASSERT_EQ(PERF_RECORD_SAMPLE, *val);
-- 
2.51.0


