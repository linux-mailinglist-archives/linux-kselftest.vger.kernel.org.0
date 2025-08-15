Return-Path: <linux-kselftest+bounces-39020-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9E5B273AE
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 02:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A13E189F96F
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 00:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933AF15C15F;
	Fri, 15 Aug 2025 00:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8BdORKu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208A11547E7;
	Fri, 15 Aug 2025 00:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755217199; cv=none; b=Jn4kMezvEPAUedgDkvlTNy3aihS3kN93uFYb6nxDyOWPWuFQSrNdvwwp8TofuOmEgRTMF6j81eex2GXcQOen9wOmtZ4xP0QvRVKVUHeupUE3Ay7lvHDNRIGBdWYmSQ80GZaPZIE+ZMDnB2MF5ADTtf9PsxdR+Hx/rCxpq313p+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755217199; c=relaxed/simple;
	bh=4WxO5njFK0+OR3toSx5o2S0JgQhNFZQCIDBPKDxbstg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bc+xL67QahGpmrzBm1Ux86bYWUEio8a6HpMnF4kjCz8tPIuhu7KhYVAopBEVEHEPNuTSgS4Pqk5za3Bb+63jllkoiqUUtca7dvU+FzenxetWpci+cBHv10SAtOM5wLSbrhPdlSAlKUh4cEiD8AvxHOX9TxpJlhtXuvbOVsP5Bdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8BdORKu; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2445827be70so16040115ad.3;
        Thu, 14 Aug 2025 17:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755217197; x=1755821997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9fv3c2HbHHCXhaOug3C2M7cVcHLqE7dP/SrHl96zCY=;
        b=X8BdORKuCdWaHpzlAmUFA8h1mly25qS9yf4EJUqVbQeQTYNNxf38LqcjQx7VjGWKfJ
         t0S2FpGwwdeX0JX6NWJJ4bAUnbbxMwapebd9pL5+iQ+Ge6XBVmA4GAsQJzI3HqjjCmju
         a3V36KFXbeVCKTlNs6+u5z01OL4swiNWoPPN/4yLwg3SHsqm9UDtAzGbM76eQcHEClF2
         ro9jDwF1YxxaEAtDw0BiAGUsSr0zmabeSWWV2d2S5l/qbxYi9XQWpKB01kgIDImD9uxz
         b7GMnMVUBbICK6mqXUJ8aulu76SIOuT71y8SUAYMFQ+m7Ppnjd4/y2zG/OdQaNANq35D
         easg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755217197; x=1755821997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q9fv3c2HbHHCXhaOug3C2M7cVcHLqE7dP/SrHl96zCY=;
        b=VuNUQ7uV1oxf0IIgkK5uD+X23W4vBFk3O9Z+DEL+wvt01Dph0JNCMjOtzm/c5hfvZP
         nXTqGDdfGRRZKYVMv7UG5dNg8nDFQih/JyrYVw+ieJhmdG3m477f+UTybJ1OfRm21Orr
         zo0H3NgJm8v2U08yM5S8x9WyEVferri04SxIapo4A6fgakRGvz3myMTTIyczd8QqSxfr
         DWmmuBLpA/CCBL4K1Qw1u/uR6nwtyzFFTYW6GCo0Z7CUl8kOG/mg5cap1VqKWQECW1SE
         1HIr1B5ZCb29WAzpTdjLJFfAWvuSIzyvzpKV0i/khho5y8WtYLuF06Yba8dgs2OreXRj
         6dUA==
X-Forwarded-Encrypted: i=1; AJvYcCUlS0u2s+80N/qWLbHgrXkdKRUg4nMzlAKuZCTzdv/mkh3ynRm0PYbF4OG14wq/4uEzj9XESSGto6W+OXFu@vger.kernel.org, AJvYcCXmuIHdNlsMPd/1QIAH8NKDZ9s/sK5jQT9mHE8uZrdFgQRTdIo925NBebRzxBIwfvhFES6AvUl6Ah4gHg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1YLDX5szej2YrceBRevAeUuXILOK3buG/k5gKSKV1jAafvsNm
	vUsB31u8pnyonFAW+X77DzmC/m/avgEY1JXCeTnL8AJrRxbMwTkDPdlrPr4mOvLn9B0=
X-Gm-Gg: ASbGncv8xsA7o+wfE3cVY8xgbBjy+XCosMVCnJxqH1ZUdLJtM2lBKPt32DwuiMcpvOm
	o8AfNkXwJ+PoDLQBu4MtcqE5TP2mtA/ENWQ/sX8jWc3Y20FkHzDlcItQzLPg0qJyh+cSKr5HF4j
	9BhQNuy1vmfGy3ecqUm6EzE048T+NDhRSEI/uhguC8LXqSEFqDA+jr8/I+INd9Wersc+TyI9Cf3
	NTBMMLJ9WLqU3g/mvUBcQ9zzI5iZt8n6G1Xb+0rypF/OTHZ/DXI4wPIFbd9gALbfF7iCzTiCGC/
	1olTMxFNcZxa/DHSqOhoGsOSq5QJTxF26h5YOFmDCqINPk/Ucm49BmRMTWYmCGR1EdJyEyps/vT
	YqodYYHsKLhEryMBFbHD9D0JmGs+0gEHhnWwZ8SGm0w==
X-Google-Smtp-Source: AGHT+IE2r0AUduQsrykmHmpUS6XlGtUQsJE/qubvEKPOvnN+jaFYs459i+wdq1r02Cqq4OkDozuRtg==
X-Received: by 2002:a17:903:1b65:b0:242:9bca:863c with SMTP id d9443c01a7336-2446d95508dmr1526625ad.54.1755217196891;
        Thu, 14 Aug 2025 17:19:56 -0700 (PDT)
Received: from soham-laptop.. ([103.182.158.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d5a451esm700745ad.165.2025.08.14.17.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 17:19:56 -0700 (PDT)
From: Soham Metha <sohammetha01@gmail.com>
To: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Soham Metha <sohammetha01@gmail.com>,
	Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 3/6] selftests: ublk: fixed spelling mistake in output
Date: Fri, 15 Aug 2025 05:48:00 +0530
Message-Id: <20250815001803.112924-2-sohammetha01@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250815001803.112924-1-sohammetha01@gmail.com>
References: <20250815000859.112169-1-sohammetha01@gmail.com>
 <20250815001803.112924-1-sohammetha01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

found/fixed following typos

- faile -> failed

in `tools/testing/selftests/ublk/test_common.sh`

Signed-off-by: Soham Metha <sohammetha01@gmail.com>
---
 tools/testing/selftests/ublk/test_common.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index 8a4dbd09feb0..e21476ff1f06 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -358,7 +358,7 @@ run_io_and_recover()
 
 	state=$(_recover_ublk_dev -n "$dev_id" "$@")
 	if [ "$state" != "LIVE" ]; then
-		echo "faile to recover to LIVE($state)"
+		echo "failed to recover to LIVE($state)"
 		return 255
 	fi
 
-- 
2.34.1


