Return-Path: <linux-kselftest+bounces-48493-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 565F5D01D56
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 10:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D90C530550C0
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 09:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E83642CD63;
	Thu,  8 Jan 2026 09:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="TPAhHMSO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-dy1-f227.google.com (mail-dy1-f227.google.com [74.125.82.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0621842A826
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864020; cv=none; b=V1ogH9iwyu0dIundv3HKk/0GazwJoUbUejH5yM+zS57q95oLRwGEE89MNxOttqEBXUyC03UxJwzFh38i0lHBtmK0Yv5so1dwiVqLYE0+52OvxIGWMfIvJISEbO9QcooOFCXZUkeL5v1vtRw8yS392WRdB2m3Oc90w4CPqBqd5us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864020; c=relaxed/simple;
	bh=j0qqe+b6Tp1wsdU1PGQcA4ShpgCikqFMILedh5CXjdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cisMeF/sDcf1of8dQknqdCcUHFvD1ufI/TCDzjiZTW3Rb0NkMyj1SuGBXeWbRL6ePHThstg7PoowSHs8JDFSXbg7BeraZdJ7ljpioCixJ1uaLRCMh2vv15h7gJFgRHJWQawR/LUTPDTVfghv+hrsuZhqQ9jLLm17keo7HuChmQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=TPAhHMSO; arc=none smtp.client-ip=74.125.82.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-dy1-f227.google.com with SMTP id 5a478bee46e88-2ae60d8a05dso54784eec.2
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 01:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767863996; x=1768468796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1BsEwlEe6b4/GC4RnV/DMnhZhqrSG2xlnXLmv4xPAM8=;
        b=TPAhHMSOZUK78HkqiocWIzv0cK3Ooxc0KIPQJUESSYuaOzXw/CPxZBVs04DZK9vP4L
         YLm8RbQeCdNlUpiPoSF81cj2jUCrd+EZRAt1ED52TljSgJsFtWdtjaQYPSC0kqwgVUMZ
         WOFPzMRVacp1S3xdpCynEyjuRMi9VzvxwppttuNpFVvQ0MUM8o9n5VCf0c/CYFEB1xUS
         mbyAojNlL7hSIE8uKRBsrqM0go6ZOUKrRMLe6dAoQl/ZYWeH874KlTvBgagdfScFLPVP
         20JP9QdjGZjKczhZ3NM7qL7t7rxMRzfIabLMk5+pLS35dzDSi/slJovSGsG9sFYgQox+
         eDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863996; x=1768468796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1BsEwlEe6b4/GC4RnV/DMnhZhqrSG2xlnXLmv4xPAM8=;
        b=LoeAoqY7KtiYHIVdMMQRNEkgIGYc/LFmfk8LCgJz3J/lggsGf6g0ndd5hO27fh0QqO
         04lQquhxm0xJh4SAmZUcb86WqwpbphnztkD3Lm9ey6ZUoXSc3rCWHym1SBD3LMPNjBAo
         5eAM+AyP7WT6Sg32mHsNrR0YwEa4s9Ay10H/bpgz1whWp7nH1JB1TG3aUx7TWbhaj0vw
         sx0bGrrZYY20hXGkyokliy4m7pF67YA7UJuTTnedwpm9sIX0veOgEN4JEPsT8nicgw06
         2DTElk4Kt2Hi6Rdy0JhrEYYBL3KgtILyp7ajWqYXJ8S6CjszqaELnfE6wqXfGBeswIT9
         zh7g==
X-Forwarded-Encrypted: i=1; AJvYcCUCHjjzhSkIQ1ddk8wz8/O77gRf28Tx5Vuw7kxwqJo4mudOygCyQSTzXf77GP6VtdkxLxTeK3N2o32Bccsib/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCA+Fcjj6/l1WBlphNHgQDV1LMZU9loLA5kqDbks3N/2k5NQBj
	YBt0Wu+i5ugQ/H4sJ0EsxPlvwcoX0N3XQ+Dd5V1M558j6pKh8xYOOw18kyUPqfJhKpaXJ78ARXg
	ShHEeUWdIyWncYwbC6+NS3mYnAB8y4geKOLM8
X-Gm-Gg: AY/fxX6pfwuNlVyHzJKOb7SVDjAo7DrBFQl9ZkPaq6umSX1XbTNoCF5mRSorFtoc2w6
	4UE3XnDMGLmQWoJLGRIo8QegFBg/J+R6fee/txreP1GRz/aQVPvjm/cLioY93HB6Ad1/FYhNnsK
	utfuEPkW4g36V+sN/L8Xyxwz4CYIRd9QYlY3fPMErb79YhgmbiVj4a3/GiyHAFXeVK0/Xb2jh7k
	6yTF3HIdSSDYCvTHLovguqIeybyIdUa5DHK5P1y6LzZuM7kd//mK1okJYyy26hyBPs5fy7isdkE
	ZNiwNFEodFyqzQmtIIKxK7isZeGUhQoVEh0F4sPp1xUEZF8UfKK7QGc1epaDvyFoAimUfAh6Ngq
	qsQ88+0pQxtOuXmgjyCTOnmveYlI35rUGiCRo4jWozQ==
X-Google-Smtp-Source: AGHT+IFrkMoxXPbkCpAtEJlUUiQgbFuZWtwfN3P60Hvgrr4I9mhxnVUkWYur8ZvQ4vma87yDUMkDhoQj9aJ/
X-Received: by 2002:a05:7300:5505:b0:2ae:5d59:3ef6 with SMTP id 5a478bee46e88-2b17d350045mr1780070eec.9.1767863996418;
        Thu, 08 Jan 2026 01:19:56 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2b170798edesm940360eec.11.2026.01.08.01.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:19:56 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.6.120])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 9166C34223B;
	Thu,  8 Jan 2026 02:19:55 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 8BEFCE42F2C; Thu,  8 Jan 2026 02:19:55 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4 04/19] ublk: set UBLK_IO_F_INTEGRITY in ublksrv_io_desc
Date: Thu,  8 Jan 2026 02:19:32 -0700
Message-ID: <20260108091948.1099139-5-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260108091948.1099139-1-csander@purestorage.com>
References: <20260108091948.1099139-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Indicate to the ublk server when an incoming request has integrity data
by setting UBLK_IO_F_INTEGRITY in the ublksrv_io_desc's op_flags field.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 3 +++
 include/uapi/linux/ublk_cmd.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index b91b2111f280..7310d8761d2b 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1125,10 +1125,13 @@ static inline unsigned int ublk_req_build_flags(struct request *req)
 		flags |= UBLK_IO_F_NOUNMAP;
 
 	if (req->cmd_flags & REQ_SWAP)
 		flags |= UBLK_IO_F_SWAP;
 
+	if (blk_integrity_rq(req))
+		flags |= UBLK_IO_F_INTEGRITY;
+
 	return flags;
 }
 
 static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
 {
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 4c141d7e4710..dfde4aee39eb 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -412,10 +412,12 @@ struct ublksrv_ctrl_dev_info {
  *
  * ublk server has to check this flag if UBLK_AUTO_BUF_REG_FALLBACK is
  * passed in.
  */
 #define		UBLK_IO_F_NEED_REG_BUF		(1U << 17)
+/* Request has an integrity data buffer */
+#define		UBLK_IO_F_INTEGRITY		(1UL << 18)
 
 /*
  * io cmd is described by this structure, and stored in share memory, indexed
  * by request tag.
  *
-- 
2.45.2


