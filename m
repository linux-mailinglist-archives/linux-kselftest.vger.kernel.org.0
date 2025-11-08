Return-Path: <linux-kselftest+bounces-45172-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3306BC42F7D
	for <lists+linux-kselftest@lfdr.de>; Sat, 08 Nov 2025 17:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 109593B0384
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Nov 2025 16:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD3D267B00;
	Sat,  8 Nov 2025 16:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vzlad3n9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F424226863
	for <linux-kselftest@vger.kernel.org>; Sat,  8 Nov 2025 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617723; cv=none; b=rb+fS/u3x1+LkmohTqBIAzEYtYvZ04ycX/XVI6VAqlYeaFTh3Ke7ezBO7f24vCGyT85vAUQVp6Og4W0tPZWZgY6Ubaz8DAAjA7kAtkB4Xhcl/5CcUab2l/x1or9dZ64vMZL3JxgUpA+47cl2B26LE2jY8IG28NRZMnimLgef7ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617723; c=relaxed/simple;
	bh=w7gg8llTsk8i6LDemrCF1OsQjSqJGBnLeZ97AFtyVxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hezeGeA+KTUL0DW64aeRnoK0o+X/vr4dRPD1m6NmGj2cDbHjErYJ0WYdL7gN2EOKIPc9Lo8JucVKIvPfAztzxBKXIBNM5/rtFznJf4K0J07SlIs3DfSjuNSxz7ebEidE4DRBn2kWhDpxbYq/qPkFTZHmEdzjY5cawxnflRLsDHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vzlad3n9; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-297ef378069so2709095ad.3
        for <linux-kselftest@vger.kernel.org>; Sat, 08 Nov 2025 08:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617720; x=1763222520; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ihp9KzVuRiSrcet5QhKAfVQH/3aU+LQAUyp3hAm1VY=;
        b=Vzlad3n9aZsPEf0JRbj4ZO2xRyXLvh7hC7Wx+14o+RX4qHi2P5dzXQOSKeQW+5UhMt
         1unUXywopmn+vwhfMNeKoM+N1TGHrh4twPhhF31FLlrAhxb7bUH9YixAuLS1IPI/N9bj
         Rsly4K4Mm7be2EW3YsnBWG8gPhFy8Z4CWQVSRdSoFJywLqQaPdtBcvzM/PNMZB7K/Q/4
         uDCSVQG1oPrqni7rkdblk/5SSQPL1Bt3/OHL+j/ouxIc82PEpQvCUl6sRjx2MOLk1DLs
         PYJ4xRlJ79hAD9sWoun+TmoqDeSzC7e5jBBVHXbIJuDcKZyyEJPuPh/dtwBh0mzH8UnC
         Mf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617720; x=1763222520;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7ihp9KzVuRiSrcet5QhKAfVQH/3aU+LQAUyp3hAm1VY=;
        b=qoGotNxdzzt1Avlr4rCamErFB4HOIueI+l7OcLp3LIiT2JMQosGM1CwsHowzLWWuch
         pbdHJvYV09r+vfo1kWAcCBloLdHnjOZMWj1y9oiKM37Lufyrd4XSF+Loa5gNMvpPlieU
         r9rBY24xEZKd4epVhuNp4CQCpLv93BWWNvvSvWBU91YM6duzIMarffKiBI1U/TBxHNsB
         G7H1I+TZhJn0FrlVWEVUUVHruNtxOTvYr9fG89carqOHzfXKTHIK1j3XfguUz+5Vw2QP
         /q7w1D8acqKAz8HxdhTEUctyCZQZG8/LZa77B31+KK9VwMFRI0Q7nKT8/8yAd/VD6iZC
         wu/w==
X-Forwarded-Encrypted: i=1; AJvYcCWfD77MupIFHn6NIQ1K67aaegfXaDgHKcWVd5uXHNeuTSMPs0kmyOyuzymnbN61xDF5ANWv7rCcAqps0MUFjJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Cr17LRvb8/WDY377Il3sqXC5W29nv8KMCh6XlY6SzqdULzdk
	1i+RDSg/Q81xPtmaPb/Zglc2eMG6IaHJXSu5F+R7tjS7Oeizb/1xpXtN
X-Gm-Gg: ASbGnct0J3slZxofWBdimZVNxnhu9BLBVO0mDFP2w9pcVbY9y9W6GPJwBDqjcgd0bSu
	Tj+seBOOrFUTjYtSgRfXzZNA1uHoGhlaKGHW40QFW+9oP1NZbX/joR3kGhq2uyRQnPLmRRQXq9a
	yJuYEsemBWTrxS7dN+hEWJZpdC3sb0Dr798UGi3EnxKzvNBD/kSK7g5XNnT0F7q442+tZtF7Wye
	zN4IZnVUNcQXo1QRyLoExxTZK6dDa9NahZlLoUJpaNhbKTFowGgXD4hk833hOUUkHAYkUnjrLRv
	avjVVc+ucc12C1Yxe7DKfOzVZvsI+dNHcV3VYA6yyE+6H3NmOnrwvc3+nUePszvtnFpnHpJu3j2
	1qGF+oNNtZvueOTi5XwEQ4yc3HNaiwpBvy4HPxrUHnxWow/BOJpB/mSfhotA8Fx6cIfkQwWku04
	vK3TVBaZmj
X-Google-Smtp-Source: AGHT+IEsWYP5FLryBdHCq6QBhKzU01pCZcyukJfx4pdeg3dtTL07KkZygsC7aczWVHGVLKqYDFo3Gg==
X-Received: by 2002:a17:903:46c5:b0:246:e1b6:f9b0 with SMTP id d9443c01a7336-297e562489emr34699235ad.18.1762617720451;
        Sat, 08 Nov 2025 08:02:00 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:42::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650968602sm95152215ad.9.2025.11.08.08.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:02:00 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Sat, 08 Nov 2025 08:01:01 -0800
Subject: [PATCH net-next v4 10/12] selftests/vsock: add 1.37 to tested
 virtme-ng versions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-vsock-selftests-fixes-and-improvements-v4-10-d5e8d6c87289@meta.com>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Testing with 1.37 shows all tests passing but emits the warning:

warning: vng version 'virtme-ng 1.37' has not been tested and may not function properly.
	The following versions have been tested: 1.33 1.36

This patch adds 1.37 to the virtme-ng versions to get rid of the above
warning.

Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index e961b65b4c6e..b611172da09e 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -156,7 +156,7 @@ check_vng() {
 	local version
 	local ok
 
-	tested_versions=("1.33" "1.36")
+	tested_versions=("1.33" "1.36" "1.37")
 	version="$(vng --version)"
 
 	ok=0

-- 
2.47.3


