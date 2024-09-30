Return-Path: <linux-kselftest+bounces-18597-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DF3989E11
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 11:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09090281626
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 09:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0536188718;
	Mon, 30 Sep 2024 09:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LC2wfSgx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9AD18787B;
	Mon, 30 Sep 2024 09:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688271; cv=none; b=sGVyGZjLYMV0PfvmLJeXlku5rkspdLcOZLtXLjBd9qkiNnx/nHYe8BDo35S5s6RQth+9dfLBz0WOrALUzpmjWxh07RNFXaHwOkrj14s549n0aBkZRDKh0pXt6empVUaI8fhdfyRMRYbjSBMvaEtm/TzpNXxqjZ8sc/zDPKmyIzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688271; c=relaxed/simple;
	bh=JFzo8GSj7RViSHXEd9I9RdpE1iBtemW32sEVgkUeijg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kqW1wt9GnS6/aMmZ4sJES3Asf46NJRieDm0o7Z7md3Y/s9ORQE30xAWgvTNcfI1yEp7khpi3RTWj4mhwnV2xHdz/A+UnDnSB75klkcrRPfZrRLF7E5Wo9TffaVf9fcICXv03fCaiVFHbB0RhEfRqdAEp41VyvLqTJss9H+b774Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LC2wfSgx; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20b7463dd89so11679005ad.2;
        Mon, 30 Sep 2024 02:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727688269; x=1728293069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6B0dztosjVjHRokhZ63knQhcmW/sP3u/Mb7idJUpAQ=;
        b=LC2wfSgx9LFJCWvdN4yE2jw6iiZn18WA2nvBOH5IWBDWkxauPeaVjnaCpn3mpd2gD8
         e/AfEFqTFXwV16Ui8EdAyLzG3L+CjDuM5GzoP3FFPkBJhxz9Pz2ECTz//j1zwMogDg3R
         ILb22mfdPK6ywtCgCXkdFKIWNDK3RHDsk6Bf6cwIKc2EM2mB/0otyFKcl7ZD/c7JA5Oj
         7uhZG0JqKpUoIraJaLtouoNPbIJ6GUMcMEX8bmpIunl1z32sG4Jn8GCVOW0JHBO4xTZZ
         2K7ecbCS30fQZiJoHXWeynQC3jBESIx/oIguL9kCj7AP8gv64USRA4uVJlFEh2FuIcES
         LPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727688269; x=1728293069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6B0dztosjVjHRokhZ63knQhcmW/sP3u/Mb7idJUpAQ=;
        b=VwXN0G41sFru0mk4im7205NPg4NjO1/rLJ7PMe4Xtq1bIesIY/lItrZxfvELubdGgN
         Te0RlrlLNRxfXPt/d3BVRtJDh+X/qYIbHpIInBZogiFypRN43zD+skLQCkLp0uUESzsr
         jJRwWNiFtBA3Gb5ck1bmpMqjoXUNQ6a5ZxmzJA7XntLUakzMmmeSISwOCOAoWHqAOahp
         Fe7qTwxKYuiGHjbqo32A394dD0Kw9itJy6e+tWMSS8lCxxhrEKpq+ZnNA0pxo1gIr5Mp
         FP2oVZHJlKqgjLWlvqGYT3NB20H5NRmtx3KHgkXxJoDanILItdgwjMwrpz7sc7IgqP/z
         YrZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOgZNflFucnrxbhsVzn4vm9IumV7M1N0Vfb4pWlhdd5Kj8OsSjOoYayoeMgLvtSYoYHp0ifko=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlFOg/NhKEcB8f8ZR3h90il1sDmKg/iLR/3ok+Pdc4hpBe4L+Y
	XZ6y4TVq+wqfcLKy/+waLCWlLkIEcHyIBQYcG7jQlonudemKCxs/
X-Google-Smtp-Source: AGHT+IGVpXlO8FBzsLmeCmptAPd4CknpvFEPLN46IyDSR9aHe0x4kuNy0qfXEaHCgLY0TdnmrFLeMg==
X-Received: by 2002:a17:902:e745:b0:202:38d8:173 with SMTP id d9443c01a7336-20b37b7208fmr176449395ad.29.1727688269502;
        Mon, 30 Sep 2024 02:24:29 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d5eda4sm51015485ad.48.2024.09.30.02.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 02:24:29 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	shuah@kernel.org,
	willemb@google.com
Cc: linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 2/3] net-timestamp: add OPT_ID_TCP test in selftests
Date: Mon, 30 Sep 2024 17:24:15 +0800
Message-Id: <20240930092416.80830-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240930092416.80830-1-kerneljasonxing@gmail.com>
References: <20240930092416.80830-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Introduce a test for SOF_TIMESTAMPING_OPT_ID_TCP for TCP proto so
that we can get aware of whether using write_seq as an initial key
value works as expected.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 tools/testing/selftests/net/txtimestamp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/net/txtimestamp.c b/tools/testing/selftests/net/txtimestamp.c
index d626f22f9550..5f5de79d0e51 100644
--- a/tools/testing/selftests/net/txtimestamp.c
+++ b/tools/testing/selftests/net/txtimestamp.c
@@ -893,6 +893,12 @@ static void do_main(int family)
 		do_test(family, SOF_TIMESTAMPING_TX_SCHED |
 				SOF_TIMESTAMPING_TX_SOFTWARE |
 				SOF_TIMESTAMPING_TX_ACK);
+
+		fprintf(stderr, "\ntest ENQ + SND + ACK with tcp tskey setting\n");
+		do_test(family, SOF_TIMESTAMPING_TX_SCHED |
+				SOF_TIMESTAMPING_TX_SOFTWARE |
+				SOF_TIMESTAMPING_TX_ACK |
+				SOF_TIMESTAMPING_OPT_ID_TCP);
 	}
 }
 
-- 
2.37.3


