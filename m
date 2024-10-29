Return-Path: <linux-kselftest+bounces-20913-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B16A39B452A
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 10:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66CCD1F22A53
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 09:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD1F204097;
	Tue, 29 Oct 2024 09:02:46 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C35204025;
	Tue, 29 Oct 2024 09:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730192566; cv=none; b=EGXKmOQfRfGETAa+TtTEUlzTqZfHamE47/5v+wos/53XpaSGhl6JsRcj6LRIP3GnDSCnJLAnZfRhe7Ie+Eq7hTfTvcNWzX7Gkv/ggLgGohIP4BVXTL6Op4mOG4NrXF7oiYCMhN9TqggLKcewYLDduwuFxvGIT7Zgy0/qz58wmFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730192566; c=relaxed/simple;
	bh=cZmCWXnEMFuEvbiRjQJjkisQxM2pI7bde0PEaidilag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2l9fSqcMBoUtB98L/EvU8XrX/23pge0FiD2/JSuKRiMIVLV6ulPhOl45N/w+AERuI0lQZ2ZMHW2Uekf4l7CQfHqWggLntG/fVQ1o/rDdKEevaRHzXqv+cMxnuipeTXje2Z6MUJuViv0149Tp9dZ5hAoUda2N/2qxTEra+KlLZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c94c4ad9d8so6523616a12.2;
        Tue, 29 Oct 2024 02:02:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730192563; x=1730797363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+qogARyrPHsNa4LKKggrQIs6Ul7expLA2YsGcgM5ac=;
        b=i2NgtLw1QJXaCaRGk8M53UFPyA17HnQWGt1apCLbELNn4uxkSISPF45Q/0v0JHrsnf
         /Pt8EmSXv+JV5B+NaPowLfUgwZaaYl6j2phRMUDJhI1hrwe3d0Mu8YEQENrwiWGwWW4o
         MoOtKkFCCnlKYfjuzPgFuwFTe3V0QH9sS0VEIFxUpR0X+/lTKdKczyQuibtydp7TiHLV
         3kHJPHHyOlFf4W+DEUJTG+Lak8dAswlTCKJZCh3u7ashMeVBGsq3VQy3cYDrz/gfaYVU
         uCKHBXD7dqNHIQDHTEDdGoaN55NQIUAjhXHqz1qmIvXPnTc8Laomq6csfGd9mrDZEpVJ
         D/+A==
X-Forwarded-Encrypted: i=1; AJvYcCUxVIQNxV9Zw8JZeVxk8sap4n+1hagC6IcS+eXfw+9yAiigd5Js6KMmPPGeelAP9ctHZHR0dGvx@vger.kernel.org, AJvYcCVw9BemAY4O+mw+A/NOVGLCfLVlqcExVJJSOBC5vqrCDRX2ep7A0ApMqDAHAwW5kPt/HcdxdebKApIy0P4=@vger.kernel.org, AJvYcCXTUx+ngA+czBCh/9fnn0aRap/ptmH/yfFvPx0rz7ZYsAKrX4UJ3cNUW86Q67CjceM+m0Ocps76XQ819u01DfcP@vger.kernel.org
X-Gm-Message-State: AOJu0YyzWkxGkBvXetQ2mRdBXs1d57cgpUYOC4m1a6/noOiPBh2nutyN
	xC/g1FfbbRgp3YPcnKSgBYr72kF5bmjpmcFaWtQb1YT4Nnv9QsHW
X-Google-Smtp-Source: AGHT+IERrA80HJeonAD2Mz4knSrWKBx5dAcJsAWmKh5+iYjrJGCmt3Qtfpd4lCqJly6frlH3YmRckA==
X-Received: by 2002:a05:6402:4413:b0:5cb:b66f:908 with SMTP id 4fb4d7f45d1cf-5cbbf886472mr7590824a12.7.1730192562448;
        Tue, 29 Oct 2024 02:02:42 -0700 (PDT)
Received: from localhost (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb63197bdsm3751228a12.70.2024.10.29.02.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 02:02:41 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	horms@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	matttbe@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>
Cc: thepacketgeek@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davej@codemonkey.org.uk,
	vlad.wing@gmail.com,
	max@kutsevol.com,
	kernel-team@meta.com,
	aehkn@xenhub.one,
	Petr Machata <petrm@nvidia.com>,
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH net-next v2 1/2] net: netconsole: selftests: Change the IP subnet
Date: Tue, 29 Oct 2024 02:00:28 -0700
Message-ID: <20241029090030.1793551-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241029090030.1793551-1-leitao@debian.org>
References: <20241029090030.1793551-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a less populated IP range to run the tests, as suggested by Petr in
Link: https://lore.kernel.org/netdev/87ikvukv3s.fsf@nvidia.com/.

Suggested-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/drivers/net/netcons_basic.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/netcons_basic.sh b/tools/testing/selftests/drivers/net/netcons_basic.sh
index 06021b2059b7..8d28e5189e91 100755
--- a/tools/testing/selftests/drivers/net/netcons_basic.sh
+++ b/tools/testing/selftests/drivers/net/netcons_basic.sh
@@ -20,9 +20,9 @@ SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
 
 # Simple script to test dynamic targets in netconsole
 SRCIF="" # to be populated later
-SRCIP=192.168.1.1
+SRCIP=192.0.2.1
 DSTIF="" # to be populated later
-DSTIP=192.168.1.2
+DSTIP=192.0.2.2
 
 PORT="6666"
 MSG="netconsole selftest"
-- 
2.43.5


