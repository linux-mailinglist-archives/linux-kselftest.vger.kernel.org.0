Return-Path: <linux-kselftest+bounces-43274-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAA9BE14D1
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 04:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C253A4E433B
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 02:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884D2213E7A;
	Thu, 16 Oct 2025 02:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbHQB4xf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1872986329
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 02:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760582241; cv=none; b=qIpDJkCZ39nNteHPs2AmVeGW0bkVNZN4Rg6FyDH6R4BM7AobAebRo2mW/jb3RD6H0185DNfRhsx/vgBqVHQugSFtbOBJVGS1Orpqz6RC7/AQ8yXHSi/M2fwSliugoWHDTSTklH9c+0J7uJLP4soL0RqP0tgGYL6Dm/L9iVAhJrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760582241; c=relaxed/simple;
	bh=LP1O6z1IQDBpbTbRpeF8L3pbsetSmzmu2sMTOE7s14w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ADBGL8uC3AnKZ6W7cqlskb6AEbEJBBfq1cRfxii0flXRlmSmuC8B3oTVP0iYXY0RpEvKKup981myrprZYfEk93TPCmVLWE/5PizDF6Ayh7kK/wH3u2pbMNpYFfGRDkhgLDz4ZRNoCwqhJFG9p/Uc98R+ahCFfe/oHmLQnP9cBLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbHQB4xf; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77f343231fcso150550b3a.3
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 19:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760582239; x=1761187039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQYI9aMN/71Ae7zrFJ51S5MhKJWD3D6+joKw3dHdQmA=;
        b=HbHQB4xfaL4lhaMeZksPft8LhPnvZEYO9dD0QKNCnNW2UWRM8o0+qmXvFJg2UOlNqi
         QPjW1GbMeV+3xo0eWTXwK1hGOSjA5cnP2zZ4kIWwqzPpI9oWMGJX+KrZphP4EBeC4UVT
         bs570qad8kyBp5/ZwkhBZPrZrhecPi8YUZUH4053WnJNr8du0iCPsmihdYOraZ72n8a0
         DtUCHrGixS8Pyaigq9/zWT832ORvX1zmaFmL2NNoMfN6hCGwZ09/xXSfy0cU6mo7+lvx
         rr7vb8606TqWfVKw16aq9oeZwEXnMSHvnXCsvhSZBW3khpSE0v7oOUofixrVHX7htksW
         3gRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760582239; x=1761187039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQYI9aMN/71Ae7zrFJ51S5MhKJWD3D6+joKw3dHdQmA=;
        b=KNZQWmsz7ik8F3kxTBKNc1ovcsT0tawY1Cqjkb3LtYATDyYMilEQwQnUvoWqv8755L
         CXUm8xtzgJ7fyrJKJyTgYoFtVIOd2A/jVRCmXiQah0gS/J0fySNUbH5A30ovve9rHlap
         uflKUPzUibEkeKodSvFM80rKC0tPTi/tm8MysWi9xH2Y7mvVDXbzuq1EMl0rYP/WcwQg
         zoTylwX4+xQut0w/S+d3vS19Z77NVsOOKNnL04Oci9Y9fYX2T4SAPGduB7lb8pxENS/9
         tlg/bUjM/qJb8X7bBg10xLBS5aNNUaDI3ylRs+q8dBesbq+c0Fx7+F038UDGESk+QmNU
         AjEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwmnGDj21AP9dCkyiimCh7OPt4jKPua80y2eMK8Aeb7Q8uDXWKtpHAlcLg2TEydhFxaVgRRXMdzbl6fiXbY0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFkZlwf7jS2bOn3m2E4aLqApsh0ewK3ThVmFQ3BNkSUrUcjjRH
	+vFrCUOPtPCDM9/vxsQA5ArZCNMwPcEnK+zuhgF1OchoC4UxpBQMXQo/
X-Gm-Gg: ASbGncvFD0lfUZUcIczHr7A7A+YFGDYiTMMsKjxnPXi+HaxicT9TVjBeSWURfWXNN6x
	2pKhwRPlxaX1EJvGupvTymgKKSkBd+sOkqerNDykQyajERfUy3CPV8Hxazf4+RgemLiAHpYBp0r
	FMxDY4DaxRbUOskjtdAgMXP2i+T1TQemTpaNAc1fMKE7QYQbovDT+ovbZA56tJ25mLePmUyVOqR
	bCguTvg9kXmVPr2F8FYxN+tL5CqXUfAGGLuVPyJw+Pay4adlsHD7PQn/6LIEP/Oga9CnCBDgpcG
	K8gxfuYHD//PQ5tIc1ZUrSgiIbVjMEKUlW0nLBhXlTd52CSNSiTmf/rYe7ZzBrI1lgJ3lN92XhV
	6Ada74wbOKXLELFZof4Mmkur46zGKPtwDdUvAmg3sgKZNc+GQPTnpABAQDeu26ygKl0/ks/qRkN
	04iWW1CSowtvIU6erGWzy/wfotfXpumDtmojzkgfE=
X-Google-Smtp-Source: AGHT+IHB9sg160F5k8dcHqIO0vcnHYw7I/jKUXvzXeKcOMzujX0FrGkAzwRwRRp7T5XkI8hrihXiVA==
X-Received: by 2002:a05:6300:40d:b0:32d:b925:74ea with SMTP id adf61e73a8af0-32db9258839mr25138406637.11.1760582239322;
        Wed, 15 Oct 2025 19:37:19 -0700 (PDT)
Received: from laptop.dhcp.broadcom.net ([192.19.38.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61a1d7e4sm21751956a91.3.2025.10.15.19.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 19:37:18 -0700 (PDT)
From: Xing Guo <higuoxing@gmail.com>
To: andrii.nakryiko@gmail.com
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	higuoxing@gmail.com,
	linux-kselftest@vger.kernel.org,
	olsajiri@gmail.com,
	sveiss@meta.com
Subject: [PATCH bpf v4] selftests: arg_parsing: Ensure data is flushed to disk before reading.
Date: Thu, 16 Oct 2025 10:37:13 +0800
Message-ID: <20251016023713.3153209-1-higuoxing@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAEf4BzaSPbsWGw9XiFq7qt7P0m0Yoquuxca39QrvorKFeS+LAg@mail.gmail.com>
References: <CAEf4BzaSPbsWGw9XiFq7qt7P0m0Yoquuxca39QrvorKFeS+LAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test_parse_test_list_file writes some data to
/tmp/bpf_arg_parsing_test.XXXXXX and parse_test_list_file() will read
the data back.  However, after writing data to that file, we forget to
call fsync() and it's causing testing failure in my laptop.  This patch
helps fix it by adding the missing fsync() call.
---
 tools/testing/selftests/bpf/prog_tests/arg_parsing.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
index fbf0d9c2f58b..e27d66b75fb1 100644
--- a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
+++ b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
@@ -144,6 +144,9 @@ static void test_parse_test_list_file(void)
 	if (!ASSERT_OK(ferror(fp), "prepare tmp"))
 		goto out_fclose;
 
+	if (!ASSERT_OK(fsync(fileno(fp)), "fsync tmp"))
+		goto out_fclose;
+
 	init_test_filter_set(&set);
 
 	if (!ASSERT_OK(parse_test_list_file(tmpfile, &set, true), "parse file"))
-- 
2.51.0


