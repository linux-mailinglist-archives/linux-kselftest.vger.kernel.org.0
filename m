Return-Path: <linux-kselftest+bounces-29891-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF0BA750FB
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 20:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C61C87A71AE
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 19:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4441E5710;
	Fri, 28 Mar 2025 19:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="XyjY05Iw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9873E1E2821
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Mar 2025 19:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743190994; cv=none; b=SRH21aOUcDxHeF4C94wWsQ8bI5Y9dNyzvktzY5i4G6U3pUPPDuBQ2lz/GwKO/QuVbc8g442kEtEwpdon1bZ1Ka46m1PqSxq7+qzzLqjUJQROIU24nk5DC16gkb7pYJA+zHPCJrd+hpKG1oGTGZU8uZMSw5rPeaGq4PWfc1hjurc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743190994; c=relaxed/simple;
	bh=flOtsZf7EBjh13FNyMsTD/5FQtLGeN9iZpmU8bbk1i0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kc1KsTBp5XbG1vozqPsBPwXIFxWNaHoaRIgI8eo6IMtksd8LPRFMJteva9EWaIEVt8sV9cp6hRPWBvdW1dksx64EmUDqL/H3atbqLqh8/4MdtlqagPxu9fMMHzWpeNK/x69FVXZeEUuFdlP4mxjtxwX7OqiMkvJn66GLk8w2jAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=XyjY05Iw; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-6e8fa2d467fso3630346d6.2
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Mar 2025 12:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743190991; x=1743795791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mx6Kws4EehWQnJaxPytGf8blP84+Tos6v3LWW/hBgTg=;
        b=XyjY05IwJf4CtrRETT91urQ3w1rKNhpRDzT57zdo7OEYwR3ZDB64EyuaT2BxVCt4+s
         jZzpIxPNXfOBGdkbagHa+PPIMyZ0+FV1LJAcHr8C3jEP6+eFilqmlkapncB8zJbQQVWr
         qfx5Q8sWGqkidWiXE6lGInnI/xPnWTSz/5mEd+JLAlC0bKQnTLsp2UgT+RWjsMkAgTuK
         jylwsyFtAexyLd30ltuA04rsZbdK4u7H70y3uiCjeTiFrII9pyyNyytxd89zkhYugIRW
         oiCJ+MlBOnku7vM0Z3Uvzfm9Q028K61jHBqFVvmwtC7zhVfh9oi3mMm2GWvPO+jG1JqH
         HxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743190991; x=1743795791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mx6Kws4EehWQnJaxPytGf8blP84+Tos6v3LWW/hBgTg=;
        b=oR6Kt/syJxFU3UAQ68H+hL9zJ6aSbj+E4fMEelehqsjzHBUKdgLaAoc6KCXGs8CGEG
         A49gXpvOCbYzs5cLa4UpgkmSqhBCP/evD/YS5E+x/1z4CL5xbCSizTNodaLTgvt76hgC
         jRVzrKDi+579BiDebDjvDRYTVLupnu6AIEolMjzUt18j2BqEwsBzIuViXOeaelrBqnuN
         Htl2gLgN/xMiWyBim6IfeAKUXQj104hRL3TDpq2QE9FsjtAZlFVeVPc/gPXY6+ciD1Ii
         UrWhlwTeBrWN9hm1nxD6LwPTWnyC5WN9YoZ6WjekGmUeDGOmLKpERpAyxiOQ1FEHqeGq
         Sfuw==
X-Forwarded-Encrypted: i=1; AJvYcCVIU5Pb0h3aXaqEQoeu66WbPF94AvQN8vaQja7Hjpnhbvl3UyavNGeS0khQtkyyQ4Udz3mQ7TWT+Vj7Jno16rs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWcpYg1mv36mD187xthlSQjLq0RCxq62n9l2Zs0z1IrI6vx+4y
	Pj3+k/6h12xWApxznjz9Nwe6enUOiFdIr4o3kE25Wssc9gMN+xtDAX7eV7hkO3YpgTNsqW4LZjK
	8dmtj9C7y5RnZWTQZjPzUe3pCVugAPHfu
X-Gm-Gg: ASbGncuDNGi/9KaFS5Nm9QQiV70M87VSiC5/4oDGRNSr05jx5Go+DDq57IwSfdW9Vzy
	JmZxXRl24hVCAi7GaP2kONPcAZoGxcJdLyiukQBHER4zn5tDn+PkITNqw3V2tWqjfkQ6Npp9fwm
	T2GCLFyJO8LgKw3mVq1zDvaEGOlXY8v32LBu/gBmnzPQ0pVKStKCXkiOsRaRnrQq925ofcPdaW/
	wYHhwyje6g2lEe/Xm36HU1HbVPudGJHiI5DkBwoIOrnbMIswRDJ4b0L8nE5F/5KZKnm8T+3UW2j
	dnJQwHgLxBMhZ2lg9OW9vCjV4VrmluLICLLXmeyP376B5FAe
X-Google-Smtp-Source: AGHT+IFQh9Pcs5CAbScmakAUo+ucuKKnoyChirklEpCbSZtv64yiMBBKapJk+vPUTDfe74Ad8xyLWKkPfmB2
X-Received: by 2002:ad4:596f:0:b0:6e8:9ed4:140c with SMTP id 6a1803df08f44-6eed61f0b0bmr1762166d6.7.1743190991334;
        Fri, 28 Mar 2025 12:43:11 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6eec963b60bsm2865306d6.17.2025.03.28.12.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 12:43:11 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 479CE3402DD;
	Fri, 28 Mar 2025 13:43:10 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 3CDC7E40DF3; Fri, 28 Mar 2025 13:42:40 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 2/2] selftests: ublk: specify io_cmd_buf pointer type
Date: Fri, 28 Mar 2025 13:42:30 -0600
Message-ID: <20250328194230.2726862-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250328194230.2726862-1-csander@purestorage.com>
References: <20250328194230.2726862-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Matching the ublk driver, change the type of io_cmd_buf from char * to
struct ublksrv_io_desc *.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 tools/testing/selftests/ublk/kublk.c | 2 +-
 tools/testing/selftests/ublk/kublk.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 05147b53c361..83756f97c26e 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -320,11 +320,11 @@ static int ublk_queue_init(struct ublk_queue *q)
 		q->state |= UBLKSRV_ZC;
 	}
 
 	cmd_buf_size = ublk_queue_cmd_buf_sz(q);
 	off = UBLKSRV_CMD_BUF_OFFSET + q->q_id * ublk_queue_max_cmd_buf_sz();
-	q->io_cmd_buf = (char *)mmap(0, cmd_buf_size, PROT_READ,
+	q->io_cmd_buf = mmap(0, cmd_buf_size, PROT_READ,
 			MAP_SHARED | MAP_POPULATE, dev->fds[0], off);
 	if (q->io_cmd_buf == MAP_FAILED) {
 		ublk_err("ublk dev %d queue %d map io_cmd_buf failed %m\n",
 				q->dev->dev_info.dev_id, q->q_id);
 		goto fail;
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index f31a5c4d4143..760ff8ffb810 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -126,11 +126,11 @@ struct ublk_queue {
 	int q_depth;
 	unsigned int cmd_inflight;
 	unsigned int io_inflight;
 	struct ublk_dev *dev;
 	const struct ublk_tgt_ops *tgt_ops;
-	char *io_cmd_buf;
+	struct ublksrv_io_desc *io_cmd_buf;
 	struct io_uring ring;
 	struct ublk_io ios[UBLK_QUEUE_DEPTH];
 #define UBLKSRV_QUEUE_STOPPING	(1U << 0)
 #define UBLKSRV_QUEUE_IDLE	(1U << 1)
 #define UBLKSRV_NO_BUF		(1U << 2)
@@ -300,11 +300,11 @@ static inline void ublk_mark_io_done(struct ublk_io *io, int res)
 	io->result = res;
 }
 
 static inline const struct ublksrv_io_desc *ublk_get_iod(const struct ublk_queue *q, int tag)
 {
-	return (struct ublksrv_io_desc *)&(q->io_cmd_buf[tag * sizeof(struct ublksrv_io_desc)]);
+	return &q->io_cmd_buf[tag];
 }
 
 static inline void ublk_set_sqe_cmd_op(struct io_uring_sqe *sqe, __u32 cmd_op)
 {
 	__u32 *addr = (__u32 *)&sqe->off;
-- 
2.45.2


