Return-Path: <linux-kselftest+bounces-19668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C78799D587
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 19:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A46FD1C22F59
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 17:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8471B85E4;
	Mon, 14 Oct 2024 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWyROY0a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999C929A0;
	Mon, 14 Oct 2024 17:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728926522; cv=none; b=JHWSQFHt94bKzCHjTIgmyioni7gYtyCHc8gsU3b0DK+SJ2FV8oxp+7x5LNmQzSt682MJeeSEWEVm8+ZD6CKxdWNkwCRHPPkAjMmVJGxNrc/7vGhNq5fu1lhWaao7LAw84iUOXMZx694iwKBvewdH4vmUDNm5pvp+IZ/dOmjF9eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728926522; c=relaxed/simple;
	bh=A0wIU0wbss796ESeJ1cO2gBHEngRLWGWi73Dp+fHP3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cjP0mzlVtpNAqwHJuARcsOpC1ctwcje31nq3iDEPtQqFMN1P8bM8ljBbFMlBUVtr035EBGvRmiBu1hxrO/9/Nsher9OJPYTZ3+CshB5RPpGpUOnoDX6W787plBYk+nsDAiz/z3O1VA0BaW9ZgPSqvPL9yMZyzvwqwNwtmazHWSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWyROY0a; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539e63c8678so2102120e87.0;
        Mon, 14 Oct 2024 10:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728926519; x=1729531319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ojk1sFGNt5wipYN0VKoCuCaWbOyLE0HFi3RwNF3zwiE=;
        b=QWyROY0apnSPtIr88kRbPveXLjbcV6FnUZ1hW5rQEcNTbl10x97gjjWP+0jR29H62m
         AhmIgSYQtZmxzDZKfRbH9321UtM5Q3uxPgEhDr0B2xuilUmk/aVpSUsKdXTxrEYnPs4i
         3lZLC8Jq0ryX/a0McbLkYfjGYsNRBaE+ZCOVnuxnHnFmbgEdTS+OTDq3NznEI/PD1BPC
         4ExlE7DHTJ2Y2l9xT516hHNGD6nYz5z8ltKVE1IM+641iUfIiZYG0UcqpyYGPuyC7nhd
         xBSjm/ZTJJFDlu7Fc5KXcM9H3pDOR06JeNK1wDsaP6oQGUJN1CeBhAfUoZwETA53wLuT
         WOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728926519; x=1729531319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ojk1sFGNt5wipYN0VKoCuCaWbOyLE0HFi3RwNF3zwiE=;
        b=G/IKJruSDEZqoHaqVVEjXr6whmwCT5qIpSHSi+aJUDrBpb3lrLJ0Jt0wCGXZDV4SID
         nr5/5yQC1l+LBLrI5tgSzt4Gc+0pAEKNXFEQllzg2MaHkb/hRTPzfJEj9ZII1IVSegKo
         RHViOR4Unl/MJn+ykDsVFTpXBsndxNYNI7NZeze1y6Vh8sldRtdma/NkerLuW8nRpK49
         MW0OXeM1FWPdKUq87Tbo+6sRM4Pg9xZS1nFTr90XDmLCYjLxK1NcDpo6cQTwExCFzL8f
         sXM7QEUSuvYoFfbUJR2hzoocmMeQOfrjeAyEGs/oVQbg4eZ1sos+4fFAg3iYCPPUasIg
         cgGg==
X-Forwarded-Encrypted: i=1; AJvYcCUxNN1btRD4AEt9yp0zzxZWApLlLWBrC/otHTJ7lls6+tFh7/ojWlogeDuPth+TTgWpeNhD14GYIKJLxdOPxmdH@vger.kernel.org, AJvYcCXzIkCs/dgDOQC88vjI3NeuwuOzPVtGnCaK6qChMdBfAmJi81qBI9q68J0xP2vQZMBp0DoMHj/OJE87Lf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy14EZXTePQCcabcJy+EgMmuNt8Bva898ic5PZMt3a6jJef1JPB
	MUT6pxRliFn6uAmIdRk/Nv5tIx5MHumkIpb5fQR469dTIF+KuE+G
X-Google-Smtp-Source: AGHT+IFMn9I47i07y9r52ikhp/svSnkYkY9XEbiUj9WO5bhzbbK+iw6V4uI7gkdixzlRKu6j/+y9Bg==
X-Received: by 2002:a05:6512:3b26:b0:539:8a9a:4e63 with SMTP id 2adb3069b0e04-539e571ce0emr4181110e87.42.1728926518334;
        Mon, 14 Oct 2024 10:21:58 -0700 (PDT)
Received: from alessandro-pc.station (net-2-44-97-22.cust.vodafonedsl.it. [2.44.97.22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6cfa60sm11877859f8f.61.2024.10.14.10.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 10:21:57 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: shuah@kernel.org
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	anupnewsmail@gmail.com
Subject: [PATCH v2] selftests/intel_pstate: fix operand expected
Date: Mon, 14 Oct 2024 19:21:47 +0200
Message-ID: <20241014172149.324639-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fix solves theses errors, when calling kselftest with
targets "intel_pstate":

./run.sh: line 90: / 1000: syntax error: operand expected (error token is "/ 1000")

./run.sh: line 92: / 1000: syntax error: operand expected (error token is "/ 1000")

To error was found by running tests manually with the command:
make kselftest TARGETS=intel_pstate

Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---

Notes:
    v2: removed debug echos

 tools/testing/selftests/intel_pstate/run.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/intel_pstate/run.sh b/tools/testing/selftests/intel_pstate/run.sh
index e7008f614ad7..0c1b6c1308a4 100755
--- a/tools/testing/selftests/intel_pstate/run.sh
+++ b/tools/testing/selftests/intel_pstate/run.sh
@@ -87,9 +87,9 @@ mkt_freq=${_mkt_freq}0
 
 # Get the ranges from cpupower
 _min_freq=$(cpupower frequency-info -l | tail -1 | awk ' { print $1 } ')
-min_freq=$(($_min_freq / 1000))
+min_freq=$((_min_freq / 1000))
 _max_freq=$(cpupower frequency-info -l | tail -1 | awk ' { print $2 } ')
-max_freq=$(($_max_freq / 1000))
+max_freq=$((_max_freq / 1000))
 
 
 [ $EVALUATE_ONLY -eq 0 ] && for freq in `seq $max_freq -100 $min_freq`
-- 
2.43.0


