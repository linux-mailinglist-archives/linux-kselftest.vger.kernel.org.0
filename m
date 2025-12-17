Return-Path: <linux-kselftest+bounces-47634-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1B8CC60B8
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 06:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C99553025F83
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 05:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A2827E04C;
	Wed, 17 Dec 2025 05:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="AOhkokyO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F44421772A
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Dec 2025 05:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765949715; cv=none; b=R04hxOCgqTWfL4MLlxSjINpGRMWldkrpcSF1PsR+UjB/raqgDHr7o1MKsk6OOt02seOROYAYfwrdLI7UTXR2s3gMEoseVBgaxUfAfaNLWhpD27g8GhjAl2/HIGRLjWCcQwN4mgxp/g4wAVCzIs7GMBQlZ/skOkc0gp2wb7ESWxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765949715; c=relaxed/simple;
	bh=xUW+aJ0AIyUBNjUOSWrr/v9kRnK+74dQ2K/T8dlAGQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pp2KKDB7hkJ7QHkl4QzWZmCmxQVcpao/aWkkhHdF35CzvzSD7DD4Q8/PQhXDExhzEFSMoKrt32hLlpTWhDTHX+PglX2Ma4/vXyu8PmEUwQVrJPQV/XyBjQAWOUMHCLexaEl/nCAucS6DUC1PG3QU4oCYDFB58cWPV2Stl5FzZbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=AOhkokyO; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-34c567db0a9so448947a91.1
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Dec 2025 21:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765949712; x=1766554512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1W7GaZySinPtNdu/28BmiINfjaLT2swubxXUIgi/0VI=;
        b=AOhkokyOhY9siyDVCEeIP+oj1r0bQGZMWzqEPujYTrRJnJ4dW2mtnDCwnirHJIHtyn
         orVNLqgxOJxiraV60BhgGG8rq6fIuSo3mzP1C5js9b4mxwDZhk42SnnVapxTieKd6sEK
         6Urp8hE7Yw8gMYgIUd9caOLXhimSFDr6pCseArUgrFfuarWSndCfG0DJlqWc3pQ8YDiO
         DABMbI2yN4hIjzHC9pUfDULLhEiqr47sSNtWtL5Ly2nkkxq/o45Q+MYI0uLmzQrsaOUd
         QVbPNjMYLTQpKEhvVsHTw5laGwEjyVvkzJSyCaXyk0JI9Ioxf4xtuoKUP1iozhmVBaEC
         JC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765949712; x=1766554512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1W7GaZySinPtNdu/28BmiINfjaLT2swubxXUIgi/0VI=;
        b=hrwLQEK6jPuKCW+2fMIyU6u3ge76ES+UNEdrHGI/k/C0KjwWKM0+TMw0KmHIu87R5S
         acnWKG01Z+Eug8MT9hpVIjWRwWYChzAG0I9pj/abhSoii21QvkivlEzggVuI0wgW9fOR
         cXSqlHoOwf5UBGsXSH+TkXI6wMigao/vzpw8cpPIRHp/wfgXNpL7Vsv3BJ4je6N91Tvu
         qFYHcqRi7Yh0+QxKSHtku703LEJ1/JZUCQMb0w8d53aLGzx1pkrqWvL0AV7+EKkPOM9T
         XN+8NnrePhHFKMEhIGBLMNRxVtqVgNruffIOM8KE6SanpAp6H3lHmj+xM4ltBv5Tt4im
         WoSg==
X-Forwarded-Encrypted: i=1; AJvYcCWC5hcCMey2/+svQ0B2bk6cRhcV6+Vo8bp5iE7SfOgM5YV1HABhXtFPRK/XDKPBpjFNIbkqYEV18NTuoAG5rlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYVONU8jgacNs+PF/8X4yEyOBQ/gQAt0QzOfQD40AgCUdXGsK3
	y3Gy5z9S5cmpZeoptEv7IASAT3sxqxVrZIaJDJOl/c+6pq1bZCliX9gQ6PaZQspHvSQusBr3ulq
	0iJl3fpWPhPU7VEObUuH4/WWMhox2C+ye2AJkz90NrtdihpJV++07
X-Gm-Gg: AY/fxX7N5nkt1vg8SkbxkWH/vNg5qVZpPphfmRHCFnsgP2vggpocHHvWKYKNylGj4Gx
	Y6plqIj7LO/GbCK9hQnYQvkqaz7ZBgzWwvULquNVRcNTHtZWOZKv7xnkDcUKa89KiFWc4d/sN2b
	Yqq68QD2Qu714Egsdwc3sYrJW03H16ZhGWTUEPJlLI/ZThO9785DOgoWVl6AmZEaF46SQzcTIC7
	Q36nRIuT9wtGxjobu2piuGxgy/XKEmQDYzsYo+n0T56Qzq3JG75wnJ9jWPY/klUQNDS3qCbilcT
	3pXgxWsE1jvnXaR8axD7n5UXYgyeaD3pxyzptZyljbdqnErJEGC0F8tThxqnGRH7aVq1Zc6hv3J
	3T17//1579GpNFuf4Zs+s0inSPIs=
X-Google-Smtp-Source: AGHT+IGmD0xzmGqowX1/sZtnUry9Hv+YVc2UPf0PBiv6bJ1WS1oGm9qgaFTZtLXdzHr346yX/lPuywp6sUBH
X-Received: by 2002:a17:90b:2749:b0:340:e8e4:1166 with SMTP id 98e67ed59e1d1-34abd898fa3mr11743788a91.5.1765949712251;
        Tue, 16 Dec 2025 21:35:12 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-34cfce259ebsm224226a91.0.2025.12.16.21.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 21:35:12 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 8B8103420C0;
	Tue, 16 Dec 2025 22:35:11 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 89402E41A08; Tue, 16 Dec 2025 22:35:11 -0700 (MST)
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
Subject: [PATCH 02/20] block: validate interval_exp integrity limit
Date: Tue, 16 Dec 2025 22:34:36 -0700
Message-ID: <20251217053455.281509-3-csander@purestorage.com>
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

Various code assumes that the integrity interval is at least 1 sector
and evenly divides the logical block size. Add these checks to
blk_validate_integrity_limits(). This guards against block drivers that
report invalid interval_exp values.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 block/blk-settings.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index d138abc973bb..a9e65dc090da 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -191,12 +191,17 @@ static int blk_validate_integrity_limits(struct queue_limits *lim)
 			return -EINVAL;
 		}
 		break;
 	}
 
-	if (!bi->interval_exp)
+	if (!bi->interval_exp) {
 		bi->interval_exp = ilog2(lim->logical_block_size);
+	} else if (bi->interval_exp < SECTOR_SHIFT ||
+		   bi->interval_exp > ilog2(lim->logical_block_size)) {
+		pr_warn("invalid interval_exp %u\n", bi->interval_exp);
+		return -EINVAL;
+	}
 
 	/*
 	 * The PI generation / validation helpers do not expect intervals to
 	 * straddle multiple bio_vecs.  Enforce alignment so that those are
 	 * never generated, and that each buffer is aligned as expected.
-- 
2.45.2


