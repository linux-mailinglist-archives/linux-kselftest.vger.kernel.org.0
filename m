Return-Path: <linux-kselftest+bounces-34129-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C13DACAC9E
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 12:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA4D717ED55
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 10:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA2520FAB0;
	Mon,  2 Jun 2025 10:36:57 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9215B207DFD;
	Mon,  2 Jun 2025 10:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748860617; cv=none; b=EyzAJbR+q9Dvm+ydcXJeE1O44L2WfOmresPC2nLshxNaDrIqas00MhjldkAhMV+PQ86cejq4i7m2fQX4nQd3Tyc1fsEmCXAm2DpaEl9VcJkdd5VAR8bWhZubjweO3c51d9d+eB37O+yLVtCOkElc3Z3I5gNN6OcN4CWlyDyp5Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748860617; c=relaxed/simple;
	bh=jHYy7SRVw8kOsoUP3YbbqWHPWND2uFc9ZoIIi+7t6Ro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ncur2epffZKS6O+ZcC/0R0n7xH03B4PU3qmtT4BZbSIivqYOZNfkwysUSOYKcKxKeabB2cV5UJThNF6JyhjRajeHD+0Z1Ac/e0Mtm+mFrAjUfVM9C6LwCrAhOZLKyiq5yIMFbXxIsOicb5gWeqILBBihtMHKQ8CNrSSFloBjuV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad69e4f2100so632589566b.2;
        Mon, 02 Jun 2025 03:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748860614; x=1749465414;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PNyaaF3I5Jl5gayWQ4TRrlN27mA7lyoB8qwWinq5u+c=;
        b=wUsIwwF/DAhnbKj8bVWaIY/h7f3KzRVNN07jknHaX5l/gce8W3udsNbJ8R7sTLCUjE
         7sCaTl/PwnJkWa5q1GRNJYL3tr2rrZyftv3eVeCmxwOkX9J1YN/X8jtRm4fbpMfA0oyX
         hDMyIF9TL+tQQY3eSzaX26838Oba98hOxs3KdUlopH0wMKC3Xo81d6DIEw0+OcGijRCJ
         C/vIQhMMB61WYdMKhBXA06GKIKSdK1+mfgeWDSAvaDrwfL13ldsWeik7ManATunJfBoi
         zHSV85EtAxjSmsQ5yecxZy6ydOjlNIm8kuuj129wL3vQ8FE6/ag7xVodk5lJKDSf010d
         l/lw==
X-Forwarded-Encrypted: i=1; AJvYcCWmJAmfkaWxCSkGXTJJDd+imKcxjAF8lzcPgwvlGtFyf4+OQmxHCpUNeOpFIOUYUSBpyLcAJ/kUiAELvLE=@vger.kernel.org, AJvYcCXCbm7agkr3pJVBiqyajSB37wm0xF0NWAZf3PEmIH4S279z/CYW+NhB5YtJcvKue2LRiZhZifq+AHrzR/7mRCi3@vger.kernel.org
X-Gm-Message-State: AOJu0YzA5IyMbnQWsJDK0XZgjea0D5P/VbomRx8LEpqneS87VW7zpdtP
	OrmphVmKnmo6MDal4veXSHG8+Bm/b4uq/DRlq7gDa+2z9eR41X4VxVKc
X-Gm-Gg: ASbGncuhsaWk3FM6HeBePESQBqshSrI0ubzNV3TA/S2B3eg8gA8nKRbqmzaMw478biE
	0fIJoaGBH3w9NI/IrzIDHlNlGNGbIFJ1+cSjLqPu0nQTttGrXGr4ag+B8Jsdj2bdvRod4cqD51h
	3GRPstrUS+iyjPa3KDQbu7NmLB68fp+opgDZbDaEkIIYLzta+T9Yy7DVP0LCu0vJYeQJ4zCNCKo
	xE+iGilfsT1hFrsB5qlFBmlNf36ULqC8LU8n0zSrPduAWonYRJRGiICWR8K0rQk7c+7i73jTTzV
	aJs8V2Qy573RXBOmRTBv53JedCPQLpKFcTqwA1E79pk=
X-Google-Smtp-Source: AGHT+IEErZsEJ+3LgEt1erTRdszgY0LxPb4vNqMSUTo+55ma6tkZjHzCI17HovLcnMSbILIu7u0hUQ==
X-Received: by 2002:a17:907:9692:b0:ad8:8621:924f with SMTP id a640c23a62f3a-adb36c28fe2mr1149327066b.56.1748860613569;
        Mon, 02 Jun 2025 03:36:53 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:40::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5dd045bbsm769909866b.118.2025.06.02.03.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 03:36:53 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 02 Jun 2025 03:34:43 -0700
Subject: [PATCH net-next v2 3/4] selftests: netconsole: Do not exit from
 inside the validation function
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-netcons_ext-v2-3-ef88d999326d@debian.org>
References: <20250602-netcons_ext-v2-0-ef88d999326d@debian.org>
In-Reply-To: <20250602-netcons_ext-v2-0-ef88d999326d@debian.org>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 gustavold@gmail.com, Usama Arif <usamaarif642@gmail.com>, 
 linux-kselftest@vger.kernel.org, kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1841; i=leitao@debian.org;
 h=from:subject:message-id; bh=jHYy7SRVw8kOsoUP3YbbqWHPWND2uFc9ZoIIi+7t6Ro=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoPX6/Vvh+kKzqbAn1lZ8ia6lgWyhg1tBA6YG6R
 4NBCybhWIeJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaD1+vwAKCRA1o5Of/Hh3
 bVucD/4tRKVUN9jzvtPi5g+YocIQhGCqZGl59sEJdJavc7BbIXkSHmBdp9xS6K96sVFxh0nSBlE
 qVj/XeK358zTNqpKw+kolGKN3eSlDxiLES3g9jnyMYUzCUwmlVx0IaXtbGOhKYa9I7LK4hgxXly
 rm167sd79ay0blMBiN/UOGZA2XzFueBwIsKUBiLaFILTvaR+kzbwlK35vacCgl6dAu/iqTa2LKV
 sbwRWz4ToDNtTLgHOz7lw0+2T5SuAYWx+RKuFpnw3PXtf67VaGbve4Mqzp8MBxkreAD4WmV+MOA
 TsiFS76DKBS1seYskxyaIa5xSTRPIF7nfoAQ6g4bh5nJrLlndJ2kJbQv/fSoSXfoIENWd129zPi
 icwipyEiCLVBaZRatgfXUhZV0FlqLaOh9u90sZV4FpEC8bItEc0hBJJ0V+B4U3XedP/TWksH4in
 F5BTevKpeH7BcfI57/kmANONvG+0iEBNBtiwWYyQnTFoAILRbLhTDTivQ0W+ihejabPxCv/ZNaC
 koO3oVpnb5iuAyKePzVdj17hwtOxjiaxSosohRtDKUnhdOZxboDI9yn/SIaSDEmStEJUXBvUAG2
 MZ57RMlTlIIeK9INRTSRKNCFZs6xbsDHNoMpPmr2dF7YFB0RWZKndmBFcFqsBMR19CoUjtDVNTp
 qxfiSgC1lHB87tA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Remove the exit call from validate_result() function and move the
test exit logic to the main script. This allows the function to
be reused in scenarios where the test needs to continue execution
after validation, rather than terminating immediately.

The validate_result() function should focus on validation logic
only, while the calling script maintains control over program
flow and exit conditions. This change improves code modularity
and prepares for potential future enhancements where multiple
validations might be needed in a single test run.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh | 1 -
 tools/testing/selftests/drivers/net/netcons_basic.sh      | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
index 3c96b022954db..1b508131a6461 100644
--- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
@@ -186,7 +186,6 @@ function validate_result() {
 	# Delete the file once it is validated, otherwise keep it
 	# for debugging purposes
 	rm "${TMPFILENAME}"
-	exit "${ksft_pass}"
 }
 
 function check_for_dependencies() {
diff --git a/tools/testing/selftests/drivers/net/netcons_basic.sh b/tools/testing/selftests/drivers/net/netcons_basic.sh
index fe765da498e84..ada6b899c5282 100755
--- a/tools/testing/selftests/drivers/net/netcons_basic.sh
+++ b/tools/testing/selftests/drivers/net/netcons_basic.sh
@@ -50,3 +50,5 @@ busywait "${BUSYWAIT_TIMEOUT}" test -s "${OUTPUT_FILE}"
 # Make sure the message was received in the dst part
 # and exit
 validate_result "${OUTPUT_FILE}"
+
+exit "${ksft_pass}

-- 
2.47.1


