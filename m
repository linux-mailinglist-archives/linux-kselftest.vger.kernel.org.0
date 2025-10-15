Return-Path: <linux-kselftest+bounces-43158-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13238BDC30F
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 04:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED2784201A5
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 02:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09E230C34B;
	Wed, 15 Oct 2025 02:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HozLeFDr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28241146593
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 02:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760496199; cv=none; b=OXB6kfRSNNMCjGkhZsBxB3PpQCDtKrlmwrqsxzFV1hZ7KJJmuQJUcO4jxx1YQRMWXzENs2N6MN1SwHyjuG/Wqg9W7RNRGmrY755n8x9MNihx1MUcJUBmpFSOh5bMqAP1c0Lvt9vHElZr4BQmvgNS7kVKQ/VR9jTMr0AoWS4YqSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760496199; c=relaxed/simple;
	bh=t//g5VVLiPoLZPOOcpwnhEVNvTW5Ewzb8nEaC/GEjNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5tsnSWqXzKqvQFssnJ12iDqrb3bnArdYo1Lqf+yZrWyAYD9QvEW12grcYiYaMMy+RaS5jcytPh9reg3N99BaJB3x/b1hP3nn/kgxRp41sY3OCHbCMhu7f6iKS2BPABE1tsSDrlzYOpB6QveJ40Uej7AM2A4amaGCfLWhkioNg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HozLeFDr; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-782bfd0a977so5023434b3a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 19:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760496197; x=1761100997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ww7AEVPWYxv683vdKSv1Q2nTcJqkJpCk/tVO10MV/Jo=;
        b=HozLeFDrL3ZIq9YXEGs28n9LA+XMP/UyXEOPPrGMbk5Ed7wm8VioizVSmLEBrMSdU/
         uupJgkrcS77G1hLfFhXSCAdfgS6obNHreH5dNelRgOQ0I+rbOypat7RU1xWOD4tJZJhJ
         TyGYMaj9hG+G2itvTAnIr2Sl4d9qLPCNWFP8R/E3BH5iCgbpdEl3a+XS/Xpk6ybxAe8n
         Q1AAcDtVgJ6P9xsoup07sQv6oXpX4qIfblXQ6PU1pQsJTVPGmUKOkhUEfglCvRDrsLie
         qiupedvAK1tIE/7mtuQioLD1Zi7s5HHheZReKHEQJQZk63Fh4edctg7T6V4YFEsQsfnC
         LhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760496197; x=1761100997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ww7AEVPWYxv683vdKSv1Q2nTcJqkJpCk/tVO10MV/Jo=;
        b=p+nuR5iKeT/CS+mWpkPMgjWeBMcsz9g5rweiFAAhN0t6KW+RjhaIJQxslOSBMJZU2E
         IIiuGqCvJLemchXg5ny/UZr6bTdWAeGxhPNAC+aMUBnlq3953C6nqJqosSGkbMeqDdBP
         PlXJLHKz95+aZYaILZZinBJFzpAQxdiT28AO/lhPtnfyH3vuH4lk8V3C3+H4H6LyHw2E
         VljX7SYEwFDAiq9G95UUSA7kpvAVU16qD4E/WIDfY2QGOuqZaSq5Fjmq8JbBXal+PMoJ
         zzpDcE5MyEfP9V6JNzB/zws8lJKcIyDSUpzsff28/tuYT+GO0vbrmT8gD7pOZ23jKDlR
         Nqmw==
X-Forwarded-Encrypted: i=1; AJvYcCXWB/0WBjpYGRChDF98z9f0eMAYJnZXOPo1bpfvGJpmhVTewEvgNKw9PbwK5/YxNcTlokJ7BSymmuWPJRAGOGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YygZENxnBniboslSu6LovizraCBBqdFRqanpK2s+Bt159vl0ZYW
	f8pv9yLj4HtI7O3CUGqodlnAUNdvC0aWrP+XEsHpGynoTGCdnxfhda+u
X-Gm-Gg: ASbGncs/0pIEQ0ta/VPJveBjKBCEzfc6EtI8aAaBCR3Y7EQnHvvVD9xEI4QX11ZTmNf
	53XNbmGD1MJM+vd2OIMXdzUSYtAn2yRufHn1XClU8f4LhczBd+z4M1CtVP3kp6y8NZWInBYLzb+
	oeTgo7b6s4U+3B40j6p8MxRixA+raftxs1qnp4Chnr9gGQZp25SdR26GSlAIgs+1Fcu/NewR2Jl
	HPze0HKNx4WfOvtTilpNX1dPP90QYxVfC1+zW5wU4VaT6o3ProTGvVx4WlHGt+bTwL5ECJJulg6
	JQHJYq/lG44waWLbkfc2VRiA3kIHkf4D6tFbu2B5qJ20efmw/TgIBTOwmDykvzZn9WZTipYRr67
	3cdw01CSGdZuJxOoYzvXKfhl+R1N0lP8iat4iuF1Z+u/dMl7MG77sCKAAV9bcYDgHyFr4V6xvIo
	mMxwBlQ5Sj3xiNsokuFMq6FZvznw==
X-Google-Smtp-Source: AGHT+IEt1SxZtCv1Oh0+AgCvEiPU+i3eNUmwLRgEruP6G09hcjBe8TPswgqdEwYBwFPDhGSlSKpPaQ==
X-Received: by 2002:a05:6a00:2302:b0:77b:943e:7615 with SMTP id d2e1a72fcca58-793878294a4mr30781877b3a.16.1760496197201;
        Tue, 14 Oct 2025 19:43:17 -0700 (PDT)
Received: from laptop.dhcp.broadcom.net ([192.19.38.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e2774sm16660548b3a.63.2025.10.14.19.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 19:43:16 -0700 (PDT)
From: Xing Guo <higuoxing@gmail.com>
To: andrii.nakryiko@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	higuoxing@gmail.com,
	linux-kselftest@vger.kernel.org,
	olsajiri@gmail.com,
	sveiss@meta.com
Subject: [PATCH v2] selftests: arg_parsing: Ensure data is flushed to disk before reading.
Date: Wed, 15 Oct 2025 10:43:07 +0800
Message-ID: <20251015024307.7924-1-higuoxing@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAEf4BzZw_YJKdb4D6Vaj7Vg1koMGuKwcYuEbDvTn35i5tDYEug@mail.gmail.com>
References: <CAEf4BzZw_YJKdb4D6Vaj7Vg1koMGuKwcYuEbDvTn35i5tDYEug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for reviewing! Here's the revised patch.

---
 tools/testing/selftests/bpf/prog_tests/arg_parsing.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
index bb143de68875..0f99f06116ea 100644
--- a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
+++ b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
@@ -140,9 +140,11 @@ static void test_parse_test_list_file(void)
 	fprintf(fp, "testA/subtest2\n");
 	fprintf(fp, "testC_no_eof_newline");
 	fflush(fp);
-
-	if (!ASSERT_OK(ferror(fp), "prepare tmp"))
-		goto out_fclose;
+	if (!ASSERT_OK(ferror(fp), "prepare tmp")) {
+		fclose(fp);
+		goto out_remove;
+	}
+	fclose(fp);
 
 	init_test_filter_set(&set);
 
@@ -160,8 +162,6 @@ static void test_parse_test_list_file(void)
 
 	free_test_filter_set(&set);
 
-out_fclose:
-	fclose(fp);
 out_remove:
 	remove(tmpfile);
 }
-- 
2.51.0


