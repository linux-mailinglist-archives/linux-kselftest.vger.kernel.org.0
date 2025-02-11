Return-Path: <linux-kselftest+bounces-26319-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A43A30183
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 03:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AC53188992C
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 02:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BB717C91;
	Tue, 11 Feb 2025 02:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wmg53bT3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F78326BDA3;
	Tue, 11 Feb 2025 02:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739241206; cv=none; b=Bl2HIkih86lX43rwcoktlcj42JV53P1lKpVi4gLdX9B99rlXQCfrLCBKkZDo45tbjJrW6i5XD51iI0HAd+4otWJAocXNuclhNabGboni6RE6CF+79WsRboCPWYbA/Iy5YMQsRSP6Hgd8XTz0wD4SiO49qUSkD9BInWv8iva4Q10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739241206; c=relaxed/simple;
	bh=e47iR8fyburMallAFhuLe1RTPvkqX9NNf1uJok+lahI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EJfIawbbtnVIsQIjPkpYT8Xc44GOubii3Uk4eVGnRRo5uIh83HrGx5v8tYlltxkCnB1DZHSDdBiJtthhmyP//yhsdnyiyq7HjkZRxes+csoXjFyg2v326dj7qJPSuhQBAhSmxjrqgTPd99DXIrls/GDi2ELtM/EES4c8F0pDqAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wmg53bT3; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5de47cf93dfso5585139a12.2;
        Mon, 10 Feb 2025 18:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739241203; x=1739846003; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6UL9cMSXRLrKUmcSWZ6ehr9HZGcrPjrQbiwbSxeTuc0=;
        b=Wmg53bT3wWKJ9V2RHyGk7AQJty8bNnJ9UWf9pZv/lPdW0BAxcKhlzwhrezz5t/nMBN
         kO26SGQJwgR+zEmE0B5QIZZM3lxLnGxOTSWr3ezrMzYxISmXZnnEiBn83aTP0OT/VsBR
         5gOQGjlhFoEC0wJqiQiZbx5mvQYWQXHHxK20yPujAVqJK+ueh0pW3DUAPAiY8QOyOWEc
         70cUBSeRnpmpP9GgWK3f91NxuZsxNOXqFolmtAyekmuIi0LnXZIYBn6R/b/t0O6WwEij
         MVtaKFpfYfWXMgd3FxRK654n24fka/VqPMtxe9amyq617PmFVuqCksKk5bFwBZQT8XNx
         ESCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739241203; x=1739846003;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6UL9cMSXRLrKUmcSWZ6ehr9HZGcrPjrQbiwbSxeTuc0=;
        b=HpC4wIKAagGI0yIG506Usse6Qr1lKvxfK1SzKLyX4YzV0HI0Azxu+LzKHWPt/lPGg2
         YKy+JNfacqp2JeaIwGwrYnMZW/izdv2eOnIxpJew2Jdpl+OdJmndTNBKXIPLQv0M5tHJ
         QmuCWZqzMTgYL1bhESEI+kBqAuiGH7rKyCA0CBbn4LHeTJoNrH8/NpSnA15Ex+rC3QNU
         tpDQZyQUM21AWLFvpHKGgU1vznDPwP+kUdypXlR62FUn41GWF2WEBYnFQCl5xsZDDnMK
         w/Dq/GTMwEnj50haUNYQFxLzLdwVS7VNdj/BcvEXThynhzd6+MC7YW1FFD26OQKrUkIk
         qxNw==
X-Forwarded-Encrypted: i=1; AJvYcCW/pHnBdK/6sT6N57y7CGWMNA69KjOpYAZlTBdFTOayJyXs4uU1KUhvzoxae/IauTD1/Fb9nbM55gmTb5dxaBlf@vger.kernel.org, AJvYcCWGkaQXl/62esB9nIF5pXkFYTlt2NEcItpTxlGsxPrAcgPVFDpmVhuf97QUtpkER3hSWF6V/JaW1jHJGn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtYDbusOxK7vEGPX31NW6jWZOXhMxoI/ARi0qj4ipbDqKucl5W
	aRff6AixU63nkStUjAq10gOnr89OJ/MlEbKDRwZRntAPrCvkZChU
X-Gm-Gg: ASbGnctkYb+zcfxuyf/Imuuz5q0i2Hqur/vv2CZQiNMnPr0xG5bNJlEo4Yzxh3KL6ts
	aNz0YFp5+zZaTq1o90+2hAdnLXKMGZGWex1m/37SNln/w7pP9g5lSpfuN31WgPvjfxQT69DF5iN
	aks+RbWS1Bj0hvnXK1+rGQ2/irywzd8kW+fZyKWGDR3rR959jO0tY61KgcTECjSna8otyYLUlYv
	qEzVABSn1fpAg304iTiIunbYluXNHLEK6gOhBroXndakFpCHc3w3QZe9Xfs751sPewRAiJ8Llva
	QnRCJ92o
X-Google-Smtp-Source: AGHT+IEbtRQwXdRYjzvNt6JtIsUfluvawcKWNETu3bpc+hBbK+x35bbkv3TuH0v8kzBmn1BIPqCpWQ==
X-Received: by 2002:a05:6402:5290:b0:5dc:ea7e:8c56 with SMTP id 4fb4d7f45d1cf-5de45070792mr39401428a12.22.1739241202764;
        Mon, 10 Feb 2025 18:33:22 -0800 (PST)
Received: from localhost ([45.141.215.21])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ab7b9bfd2c4sm381243166b.43.2025.02.10.18.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 18:33:21 -0800 (PST)
Date: Tue, 11 Feb 2025 04:33:13 +0200
From: Ahmed Salem <x0rw3ll@gmail.com>
To: peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, shuah@kernel.org, 
	skhan@linuxfoundation.org
Cc: linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v2 RESEND] selftests: tpm2: test_smoke: use POSIX-conformant
 expression operator
Message-ID: <ucnzy5kvkseivbofbushyeukzslvberjb7osjlqttzs7pycnsx@evww4qqqgiuh>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use POSIX-conformant operator symbol '=='.

Signed-off-by: Ahmed Salem <x0rw3ll@gmail.com>
---

Changes in v2:
 - Remove snippets pinpointing the issue 
   from commit message

 tools/testing/selftests/tpm2/test_smoke.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/tpm2/test_smoke.sh b/tools/testing/selftests/tpm2/test_smoke.sh
index 168f4b166234..3a60e6c6f5c9 100755
--- a/tools/testing/selftests/tpm2/test_smoke.sh
+++ b/tools/testing/selftests/tpm2/test_smoke.sh
@@ -6,6 +6,6 @@ ksft_skip=4
 
 [ -e /dev/tpm0 ] || exit $ksft_skip
 read tpm_version < /sys/class/tpm/tpm0/tpm_version_major
-[ "$tpm_version" == 2 ] || exit $ksft_skip
+[ "$tpm_version" = 2 ] || exit $ksft_skip
 
 python3 -m unittest -v tpm2_tests.SmokeTest 2>&1
-- 
2.47.2


