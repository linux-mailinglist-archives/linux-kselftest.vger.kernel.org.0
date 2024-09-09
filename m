Return-Path: <linux-kselftest+bounces-17504-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4545B9710C8
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 10:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF276B22752
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 08:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923861B581C;
	Mon,  9 Sep 2024 07:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkzGmUUQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8431B5311;
	Mon,  9 Sep 2024 07:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868627; cv=none; b=HXWCN48CsuKBkKSIUjycScsLdcI2TlRfjvwXac+ck3v9R/O5m5rGQT1++UR05B2tuNzzW0VTxcoUY9iD8WfA0PJTJxpMMqcH5PZ3qjcEvTPniN81ZPzndMoUHqysDpdiHYyGr0zJtvGNSC0objNqaK0ArJg4crhHttvU1p7VC/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868627; c=relaxed/simple;
	bh=BARq6CI0sUrpiqbRLZJwneAW1VIp6GJNRMTfyDTLnB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SFHsNsi5qHZJJeggLO8U/ORBTMdYRCtePJLdhqdrklUwbnR/tymHLw3MSPVAQB98IObb+idodG0oAq8ExzVTldQPDNrporkpPm7LM4URb2QnZbmlxb4X2gTVaqJCr7g3uahB00j1E2p4w8aXAZKsO6hV8Jaoe5DGTgtCTc392ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkzGmUUQ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-374c7e64b60so2351720f8f.2;
        Mon, 09 Sep 2024 00:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725868624; x=1726473424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Pq3OAvpMN/C/2QwAD8pzV8PNMpLIVHwySHZrZo9G7g=;
        b=FkzGmUUQI99gmjz2r4QuyPr5Xlykm5sJUlU2L4dInj5aG0teDDge9m8r3NzVdi9vMK
         nMlWOdOmAFzlhI1NwFP9/lME++pL8TWFluAWTOaHqmvAKkC+xqdvtw37E7RqdbK6Mylh
         whCIpj6d5+FGOCxiFoC6EhvDPqDhQrNMA8lVEzrjxxM+ldYCJt23dy1W+ZQWUUlVK/di
         Bdhc67H4KtQKFkpVd1zOX3NpfedkU809jErYKu9Tyf34QI0MgJU0HwTaJ8GJbcqGMGst
         EHo2TVr+JCLE/bHaz4eOUKR4HI6nsbFiri7IBOv1BelQf1L+OHlH0zbfIYwtR+B7wDjL
         WR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725868624; x=1726473424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Pq3OAvpMN/C/2QwAD8pzV8PNMpLIVHwySHZrZo9G7g=;
        b=hrFemkKvprwbZpuSlnWGiY/V0DvkrU6ImaxR520sMm2zNaUklfNlIGKqg5pm3GJOLq
         4Zz0KbtLO19DwsG8k2MzFolzQm/ZGgImg0+/ERHteh2hqe9LIN/J/hy0l7MtMeGf9vSB
         gebWw1cPLWJ83xADI6gmtPYeMNBXjU18fUOCcTtvzHTHaGw+wsm80eVSA6QrcKr7tinx
         tT9fRgrWNxXci2WihfIyignVb3YOIza09IbZtlJvQOHpDb4uPkiYBg7W+RDbRMzI4hiC
         ZAIh+VH+I3uzGaB6de4dVIWDJ6h8EeUyLIZi2W3njYuREmvGZqkNrJ3/c4ckBed+JNxQ
         7caA==
X-Forwarded-Encrypted: i=1; AJvYcCUwjV0R7NCxpfh1UbGRVXwhmCgO6BHyKkunwT9j7yQC1W1EelW+kCVLl+CwqzPw840Em7KEIJzy91FW+1oH+ApL@vger.kernel.org, AJvYcCVBh74nJqi68Gz4kpTVHoCZLYsnldgdEJW5ZmFx6Cll0mtAleuNKnXBE6Ky/pWYScTtT5ftoRE1isCCEoGq@vger.kernel.org, AJvYcCVDZtTwvKTEcQaeQT46nQ4EbEN7D1AH+GtvPGbLSTpEvFt3oPcEom+6NuP0R4fkTlm5CU7trrlNZ22QbSU=@vger.kernel.org, AJvYcCVOhyJROLmtxVcj3PABSXGqIR0YR6sLuOfjcc4rBpCg0VBASuKDQK31aoxiVSpELtwr0HleXHBiz81dXsba@vger.kernel.org, AJvYcCVvOBNGum51vRAvRRL3STlXt0Yp+loCSHIfp5Xj+CQHPtL/zkrDXLbtnTFT83yhI3i2spg=@vger.kernel.org, AJvYcCWdg9Jrp508VVmRiFN36oGaNoAEWoS1xnqK5MKx6SBNzW2uqAHHxNxFgQufHdAB9cT1TBW3Szf0s3C+wUPoLA==@vger.kernel.org, AJvYcCXXUXX/YfCGKpf1XteYft0xBvrp2CWTmVmH1fdcmsr+q9n/qUeU4idwD14EU6IftqXZO5RcdmOQp895GQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhNRxo9GyYQXbvSpscNU3QX7ljoqp8EUZC9LWnQ+HVtyJjogUH
	GwDCpi1HRIktR1w5FykoTmDfl+dSeyLDP8wgopNA52thjGS5EQvGh9QGZ580rJg=
X-Google-Smtp-Source: AGHT+IHsh4JSj0n795jllGPCHtcshmYEB9h2vcO7+qPsciOrvVvisGOWJv6LsOPnSs3/6a6/hCfK3Q==
X-Received: by 2002:a05:6000:bca:b0:374:c847:848 with SMTP id ffacd0b85a97d-378896a5c24mr6994466f8f.36.1725868623978;
        Mon, 09 Sep 2024 00:57:03 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895675b7esm5303001f8f.50.2024.09.09.00.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:57:03 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-crypto@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-fscrypt@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>
Subject: [PATCH RESEND v2 11/19] kunit: string-stream-test: Include <linux/prandom.h> instead of <linux/random.h>
Date: Mon,  9 Sep 2024 09:53:54 +0200
Message-ID: <20240909075641.258968-12-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909075641.258968-1-ubizjak@gmail.com>
References: <20240909075641.258968-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Substitute the inclusion of <linux/random.h> header with
<linux/prandom.h> to allow the removal of legacy inclusion
of <linux/prandom.h> from <linux/random.h>.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
---
 lib/kunit/string-stream-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
index 7511442ea98f..7734e33156f9 100644
--- a/lib/kunit/string-stream-test.c
+++ b/lib/kunit/string-stream-test.c
@@ -9,6 +9,7 @@
 #include <kunit/static_stub.h>
 #include <kunit/test.h>
 #include <linux/ktime.h>
+#include <linux/prandom.h>
 #include <linux/slab.h>
 #include <linux/timekeeping.h>
 
-- 
2.46.0


