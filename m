Return-Path: <linux-kselftest+bounces-17208-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8DB96D040
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 09:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF5DB284F3D
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 07:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E9419309E;
	Thu,  5 Sep 2024 07:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBnL9IaC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91B8193075;
	Thu,  5 Sep 2024 07:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725520687; cv=none; b=OHhi9WCRJhVAQWA7ufg8gsVcIXqMlt5YWyfMvGDo17nLb6f51hFfCvGeSkVi8Le3WbvqBvPxF7dIv2Ug8izfuSXxDl/szC+a8uOVjUU+W7VLLsR7MGv2zwW61ReN6tNO0rsDYZcv4DYpIatehs1V+XAkpzq8KUCH03IIUuw+OaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725520687; c=relaxed/simple;
	bh=QnK91DuJeGoRFoqM9GpuoJH5kC8osPkheLOM+tzeYmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K12YIx1A0vy4hA6I5/Bb2nvoMeWcZENxRaUMMqYQUw2bBtqm1v3X/Sym+6lhSML0JBBSbZ/Cq7W+3EhwfP4sgiptiL+WPB+OPzOlkqM8pYkyqAnc9+CaGKfHHy92cshOXqvEt+AzTCrneThXN7DxWbFOe3ndAHpdM7HWuIpqDmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBnL9IaC; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2054feabfc3so4676095ad.1;
        Thu, 05 Sep 2024 00:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725520685; x=1726125485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nOX2YMvtf/OrIDC6qncA+oTCXoL26pma70Wab3JtoU=;
        b=LBnL9IaCw80Su8YdDjNqPpmGN5fhojg4YsLen6mQqQw3l7/+SopMvRbk665ZBJYNlj
         gSYh8prZYrOmbUy9szRqHYSbXMvIbdZtJmjqP+hJ8Tt4VDX093Yu77oOE7Hq37c0+3xk
         Rxg3bL+QnpnMPIAyN+QhLMVmpU0c1SjFfgaMZWxQtlEngLuURh5pbo1gvr6ppwx1Qgix
         qtDuIVhpVgOpSlFOgGgH5/Ym/P2b46yLzzEkaJdYlEduyU813VxEWGwt+hsFXQeLGllj
         vgZjXtZm3A1XLj+dBN1Igr7XG5cJ5VS+ScjaBievlQigHtDcOC4fIJmIEkOO+GQVi6Kp
         nlMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725520685; x=1726125485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3nOX2YMvtf/OrIDC6qncA+oTCXoL26pma70Wab3JtoU=;
        b=YR/n6uIquAuIgHSKrdq3S4y9vdwggvOO8vo+ScM9hIE6Vh5nUYQ+J+PTu6cOFVsexC
         Eze33tBNzkdkAgslxUHbvf4U6DPofAGFR8Gn7PDya1Szb75WCMheZcni+09uk482VXyH
         8aL311JHgYEcLv8mTaCPMlHDzEySIjwt9IornEFjyvm+nIRiiIe+BjtqA7csPPMW8Ymj
         GSxrS2hcetuxiHnCmnRo+LZnNtiGqjyqTvCwmR/R9ZQyBMRCE+9qRdlsBjC4J23ZWPYe
         b3Ieh/FqKyVCmBaEjYHXHlRw2MwN56Zl9Bl6G8BD5ed29Dnvxnkm2G9NJM+fwOpog++M
         tiVw==
X-Forwarded-Encrypted: i=1; AJvYcCUZ+3ISfaljsR13xljxasSwKqeIkcXcVbykTlZsCArQH/VafDQVs24NhA4OHH6hN/w46yNR2dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwjgT/9/YssLRhhawrpO9uuXx94fm4JVw08ntQOqNr1uWRj4aq
	L/eke55ISoeaa8HgUlF7j+yz4KV3DDlHU0dz+ztisKoETTfj+7bO
X-Google-Smtp-Source: AGHT+IGfKXNaQsFQrovWzbgLjoQs7RD65xHlqTQBOlsXCiB0U+VGNJNZGDu709if11WU3Y08pXCw3A==
X-Received: by 2002:a17:902:e74e:b0:206:bbaa:84e7 with SMTP id d9443c01a7336-206bbaa92afmr53884455ad.40.1725520685001;
        Thu, 05 Sep 2024 00:18:05 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae913b19sm22929425ad.61.2024.09.05.00.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 00:18:04 -0700 (PDT)
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
Subject: [PATCH net-next v4 4/4] rxtimestamp.c: add the test for SOF_TIMESTAMPING_OPT_RX_FILTER
Date: Thu,  5 Sep 2024 15:17:37 +0800
Message-Id: <20240905071738.3725-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240905071738.3725-1-kerneljasonxing@gmail.com>
References: <20240905071738.3725-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Test when we use SOF_TIMESTAMPING_OPT_RX_FILTER with software
or hardware report flag. The expected result is no rx timestamp
report.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 tools/testing/selftests/net/rxtimestamp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/net/rxtimestamp.c b/tools/testing/selftests/net/rxtimestamp.c
index 9eb42570294d..9760abdb6e05 100644
--- a/tools/testing/selftests/net/rxtimestamp.c
+++ b/tools/testing/selftests/net/rxtimestamp.c
@@ -57,6 +57,7 @@ static struct sof_flag sof_flags[] = {
 	SOF_FLAG(SOF_TIMESTAMPING_SOFTWARE),
 	SOF_FLAG(SOF_TIMESTAMPING_RX_SOFTWARE),
 	SOF_FLAG(SOF_TIMESTAMPING_RX_HARDWARE),
+	SOF_FLAG(SOF_TIMESTAMPING_OPT_RX_FILTER),
 };
 
 static struct socket_type socket_types[] = {
@@ -97,6 +98,16 @@ static struct test_case test_cases[] = {
 			| SOF_TIMESTAMPING_RX_HARDWARE },
 		{}
 	},
+	{
+		{ .so_timestamping = SOF_TIMESTAMPING_RAW_HARDWARE
+			| SOF_TIMESTAMPING_OPT_RX_FILTER },
+		{}
+	},
+	{
+		{ .so_timestamping = SOF_TIMESTAMPING_SOFTWARE
+			| SOF_TIMESTAMPING_OPT_RX_FILTER },
+		{}
+	},
 	{
 		{ .so_timestamping = SOF_TIMESTAMPING_SOFTWARE
 			| SOF_TIMESTAMPING_RX_SOFTWARE },
-- 
2.37.3


