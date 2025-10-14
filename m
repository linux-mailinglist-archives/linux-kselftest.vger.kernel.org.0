Return-Path: <linux-kselftest+bounces-43117-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22734BD815C
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 10:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 649F419239C4
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 08:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C517230F53A;
	Tue, 14 Oct 2025 08:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8JihYcI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A87C155322
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 08:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760429011; cv=none; b=mBZyRmXIJiko+N4VjMsPz1Iz/rcSWRmZqnZPJKSnO8bwY+ZKGa2AkVUnBwqTLKX2Skt0FU2Y86fTOaoPm7kvW11r5WH8m11o7YsGBSkDWbMstqbX4K0cbwzpu1kNk0oALEhgQ+gBlF+ATaCshIZYL6JzeD8OLdkhgTx4n29Hjsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760429011; c=relaxed/simple;
	bh=xcIHiyrY6zpd/QJ5ecaxifkvV6PL2HbfdLFpHH8rkSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QT1259QoyEETDu2LkDGpV27bD5bQPwUpYHoJ4o0XHUQFFtK9DHy4p70XZtm4+AfanyBBp4mCVgMSeFDxuTK4Op9De41EynUR1e0EdiF552TbgoWynZmhp1k3SEGDZRM/crBZcD3/3T1Ne2Y6WQH+8WR0kYwoydFzN4eWk4qJHAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8JihYcI; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3324523dfb2so4878151a91.0
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 01:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760429009; x=1761033809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pZ0YZ6ERdNgsUMAEbLjWSRV62CkKEzgpgQpU/84KBjs=;
        b=i8JihYcIqvmIZJhuIORaE7v2Y7pbqfEaZuru1fH3S8d1haJq9SDJX76PTLf84dFW8c
         AIQfYT6EJhaP6w2pQ6QOue6RVKtShff8SIZwVgkr42BVhNd1/xgoxiZ0xMI/+BZainj6
         NqaaOQUc9JfWBUeAZnlj9Si1FGqcqxosvvpFqWGIVa5LbITzCIJeyVYKqwKEx5+y7GtQ
         SeyPT9d4mBX+RMR88yCYwPkxccp0mbEDt7/iye3eulS5OK9/WGrgT0ZluJ7mM36NgLLh
         zireUlg2nFNYlEczF2HBs73npsPCUiPht7jvUFJEWiWOOFTg61jVMAQHKcfibkXH/dsR
         XT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760429009; x=1761033809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pZ0YZ6ERdNgsUMAEbLjWSRV62CkKEzgpgQpU/84KBjs=;
        b=Y8RWg6RRZr3tuGg942/f0R+xeiU9F3nH5KnMVB7S1+OAznqMU4PPngtkaYwLGlICEx
         syDDE3aGF2035Sjxw45bY2FkQOQYO/q3tpAhJjlSlI9vS2l8y6a+EKvdCODbmgnvtNrx
         splHX65OVCPpv5H9F9ZgIQdOojFfJDVh5F+IZmUqNQyts0mtPXJsZRt9E0r3BBVV76Km
         FrTOlwjFApXBtrZZJKc46ovPhg6mrSHVfOmXztAJjUWnyJoDmgqH+eB/BUg+go+0owvQ
         0xdI1kMEFrWiiLezfDwJUQQtQo36gzDINLQ8urgLyc7mF0LkxP8WggZwfF65RWNhuJvE
         6hQA==
X-Gm-Message-State: AOJu0YwlUaXrVdUT9veQT2tuiYIRg3Tp0CkdQmZJzvsDfdNvld8Zjapg
	RqVuI22jcOjnkyT/pb/pOVbjIOctIshHTbCTfM4eaSa9eFHQRgxqstQ5
X-Gm-Gg: ASbGncv2231GaqNlKcOYyAjam37vFpgdjpmOUWavzjUwt40hYDUXuAlMB/BsYJoDPa/
	jMAt70ujLSFtNR9sihmd1Qdl0Wif9AC6NLFNiSYm8xhd7QcOwqXo1zT8+xtzniAZImtGGbMlTuF
	uXRIP1bh/OmwS4LgK+3ZvJEMfeJVWnCB0qwGvfUsK1q2/RH4lex+moM41M3k3P7y29sd+1MqJSN
	RuJJSxp10dBzO8jqxST5uV80O6NGQGur8zufkHK8iKwcV79E2THox5fpF5k2HVQc40oPOzKjczW
	fc0ANRVXUTY5lSmXVr1zg0luhwKtOwVEetd4AZyI9gPY0bHfih9B+X71dBCUvBTtbURHq91opfy
	YXbTEdYC2A9tINfMLqqnAdRBkLiWI6QMQJgFZvnuQlMbE3BwMtg4A6KWcD3ce
X-Google-Smtp-Source: AGHT+IFPgNTqNpjyUZ+iocqEkYenDoDPdOqlpKuMh6WhWwfOvgcL2peErJ3UypjvuONEB5mk54U2ZQ==
X-Received: by 2002:a17:902:f64a:b0:260:3c5d:9c2 with SMTP id d9443c01a7336-290272e46bfmr292801235ad.48.1760429009236;
        Tue, 14 Oct 2025 01:03:29 -0700 (PDT)
Received: from localhost ([192.19.38.250])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-33b626e8bf5sm14635088a91.23.2025.10.14.01.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 01:03:28 -0700 (PDT)
From: Xing Guo <higuoxing@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	ast@kernel.org,
	sveiss@meta.com,
	andrii@kernel.org,
	Xing Guo <higuoxing@gmail.com>
Subject: [PATCH] selftests: arg_parsing: Ensure data is flushed to disk before reading.
Date: Tue, 14 Oct 2025 16:03:23 +0800
Message-ID: <20251014080323.1660391-1-higuoxing@gmail.com>
X-Mailer: git-send-email 2.51.0
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
 tools/testing/selftests/bpf/prog_tests/arg_parsing.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
index bb143de68875..4f071943ffb0 100644
--- a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
+++ b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
@@ -140,6 +140,7 @@ static void test_parse_test_list_file(void)
 	fprintf(fp, "testA/subtest2\n");
 	fprintf(fp, "testC_no_eof_newline");
 	fflush(fp);
+	fsync(fd);
 
 	if (!ASSERT_OK(ferror(fp), "prepare tmp"))
 		goto out_fclose;
-- 
2.51.0


