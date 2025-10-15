Return-Path: <linux-kselftest+bounces-43160-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8235BDC345
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 04:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62E163C1004
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 02:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9342417DE;
	Wed, 15 Oct 2025 02:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7+Pu+pm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8194A4A08
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 02:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760496657; cv=none; b=tDjA8OPWEPtplUBn4bsoWyThEW/rv+tEqiJoRqKn7RPMJ7yhIMFNIYgWa86CvSz1EFF1iotlZiPsy3gnObFULjXP0G/tLoKuXtPd/K6567gF2IV/aD7LUCvJ8YVrptzNEunVjq1bYlKKVPn58OhKZPs45tvuQWDHTWtTRx/5VYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760496657; c=relaxed/simple;
	bh=SRNf4UNoXj0fG4TsIdCYfur89uC/7Bjg76Zbybn6ais=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n8Waik9OfOTscCwX1NMzsk6Gv5aaCq31zDQnNyn3lmL+F+OTkRo+8TY5B4YNTtIGf42nclIv8blFrwxQRYvBAq9QuNU6AKkU7CQTjmDPgUrEh7xxE0tXY0LrHcE/Yh3TzscdrLZ0SQStHAyf1dzQXpt5s/bAod/1QsO9nV85ajI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7+Pu+pm; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2697899a202so3413235ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 19:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760496656; x=1761101456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMeNinbxn1Ia1bk4viRlQhx3ffdSmm43VBmbl3H22uM=;
        b=h7+Pu+pmif+ywlWZEcPTyRLfVK0h5JdnyVQpFBkriKp6XBVVVichWa8BUIby+HD2+i
         dEz28dIDW7n1Kn4zzQqrfDQV6ScM+OeZTXTX8kLCnOpQMLpYZW6Hw4Y6hPC45LJHVgjR
         GYwbcBRrgh1gjqBN0FzLGcmK+9lR/WWz1cdMUrJ1vM+V3sfGFD1PYhVItXSPE0ENdvhi
         EVl3ZWw+slSZCwTvpqK+gF6rouLkxAjbPeIjR+FolvCR3LIBxrBsqwekeXQasncgKtWy
         fcfcjm0yKVcW+9BTk8pcgeUtYS1EWHuUlDWWE+lBBK8b9bpqWPwSyXCeh65P2ZyCWS8/
         pJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760496656; x=1761101456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JMeNinbxn1Ia1bk4viRlQhx3ffdSmm43VBmbl3H22uM=;
        b=WSuDirTCQeDFeHeo7IDDj/0uWg2Tmvm94CBFS3ufEuvXqb6BHs0yquZMjyRuhlZG3n
         JsxAOQEfZLjN6po92HevxlyUUZg+aIYTrb6kGMTyvh83l+aCn130dYmvZQNEJ3b2Mekd
         coDogFUtJFxBIi8CI7cZj0n0BYhvuVLXD6nJjDoAR4G/yuP52DxK5k6owYjvuEw+GEcr
         kkpQ5g6ZN6Bbg/Lc292H1GERWGzKF7J3zFTP+qYFQozi7jdWWG1AY0HQ9/Uns/SEqVEA
         pCAOrhH3wJ4vMtpjfPgxZSyoASODynzGwfhLYyeFuxM/jFBvF+HT8wpDrMQFObiQRSr/
         mAdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC1zQoEcb7aeHOrx2dzYNEWYzJzgqLBz5iwfG3Ykg3USdm3Vzs4EKtqdaLmjXPU1LcVvcBFlXgKHkeuyt1P1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7QT8jq1nSd/uf1tuApfR89G2XZu9KPcTQAO7om8Wm3iWh2vIz
	f1wln8cVVqshKlQVxtFyWIqSWK3FLjq5RFs1Mk4dZlgCu/OuMWuLY41p
X-Gm-Gg: ASbGncs1EfmyvRa4ijdd17wDlxEJ/2dQNwFtOQo15PYqGYDmt/6zKwTBjRhy5Hoxibb
	R/tGqF/3cXk9ZQ+C85kNsWieDh3IUnNMzF3IDepQuQpv3zxaBs6OuY/x6gHzwfyhF/IaxkSYNIz
	vi3RX6H1kWg0OCDS5GZrWmusXgrehz2dh+WWgWSMcVZymuYxaK5pnvuHkM0db08FXy/3WXWjJIi
	iJ1DyCzz25/9g53wvK8vObKY8nHguOBipNxF4EwK6DDdaTwarK299G++ZAxBfplYQZ2bUtzyYAi
	qkvK2oJS60NnaEa4dYa2acxpDE8+Nt5Q43pA2pqOsTJsZqWNEOGdiv5/B6/gTpWXbD2SbVI6AeH
	XHe0u8bLdmCHdzRjP/3DU8UIhjplG0/+G3FAsfo0YJEq29je6KHpgy3Pzb2ci4J1/8f5T7rqkiv
	otOnuK+oAVstkOHKw=
X-Google-Smtp-Source: AGHT+IGRIAcjywFUyrUMh6UonIN+ZpPlKp8qOaB0t1ePLb+D0r1qb3GCYMQhiAzaFL5teWBbn4+BVA==
X-Received: by 2002:a17:903:3846:b0:265:b60f:d18 with SMTP id d9443c01a7336-29027e5e015mr278711075ad.1.1760496655731;
        Tue, 14 Oct 2025 19:50:55 -0700 (PDT)
Received: from laptop.dhcp.broadcom.net ([192.19.38.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e1cbadsm178887365ad.33.2025.10.14.19.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 19:50:55 -0700 (PDT)
From: Xing Guo <higuoxing@gmail.com>
To: alexei.starovoitov@gmail.com
Cc: andrii.nakryiko@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	higuoxing@gmail.com,
	linux-kselftest@vger.kernel.org,
	olsajiri@gmail.com,
	sveiss@meta.com
Subject: [PATCH v2] selftests: arg_parsing: Ensure data is flushed to disk before reading.
Date: Wed, 15 Oct 2025 10:50:49 +0800
Message-ID: <20251015025049.9492-1-higuoxing@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAADnVQL8PWAqzfdaSYwn0JyX4_TBPWZmCunMn8ZRKJYwgb2KAQ@mail.gmail.com>
References: <CAADnVQL8PWAqzfdaSYwn0JyX4_TBPWZmCunMn8ZRKJYwgb2KAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently, I noticed a selftest failure in my local environment. The
test_parse_test_list_file writes some data to
/tmp/bpf_arg_parsing_test.XXXXXX and parse_test_list_file() will read
the data back.  However, after writing data to that file, we forget to
call fsync() and it's causing testing failure in my laptop.  This patch
helps fix it by adding the missing fsync() call.

Signed-off-by: Xing Guo <higuoxing@gmail.com>
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


