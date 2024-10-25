Return-Path: <linux-kselftest+bounces-20678-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 120FC9B0971
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 18:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 434991C2288C
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 16:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BE317D896;
	Fri, 25 Oct 2024 16:14:34 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2D121A4C8;
	Fri, 25 Oct 2024 16:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872874; cv=none; b=tB8whbjV6EwEa/9PK5wMyOYQecJEvQbPdvNgMJGI0ekTz+zeItkQus+xkunyEhu2qkwgEvt8RBu9028uMsbSKx0wS0Q8LYfuSex3dZ6KbMNtlOS0+jdJHAt5Al7c8513Kypij6coV+S61EbS/zRC4NUJTS+zUY5U4nW2vSmO4U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872874; c=relaxed/simple;
	bh=QBRg+BAsO4rzPVpUtbFYYnBbh6zPHcJdisFyxAIOJYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s1c+s0l5eWf+7TLgzG2nWX+K3/5vuCQUZZxu89SE7R6fIYtMKfLtQhCu2b0rTiIViUzUuVkyqr/yXWMHecACtkwpCVORRzjwqGYrqxboT9wT0pgvckmOXIM1lZewDki64YHTuNaWABBkOI2nS4aTUXfQ58JTtKcExnevb/0f/NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5cb6704ff6bso2901442a12.3;
        Fri, 25 Oct 2024 09:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729872870; x=1730477670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B2UebL5ZjmVkOrNFeX8IB8xmj1z+yG1JYVmo1T3bbsg=;
        b=l6tZ1DjX7uWNmPTgPB8a/iCpeuNvV1sHDwfUI3wzPvJ8+NVdY5KFx/dT395NXrjOv6
         lYk2gpX2sqZneeZuMYCLe1hwhtQBH1+xEzIfZJZGPIVYNyMdk9ssqicUnNIsVqaaT0SZ
         rOMhYFzz4sZgkHTGvhgS6yVxNFgZLujHUZYawwfU446oYn+wPFRaaRyzYwwDmesOo+rx
         TlvzMEnd4ntpKvv/rLOz1Wtoa3aac5x75KHf5a3H79PbrFCQSCiaxW/OTWRNYxcjQLgg
         ubtmhHz+1wgPyA5e9qwG+DIj/fOt0bYbfEkdJS8Qxutu7gSdy+BZNsLQGSJq0zFOaJtM
         3FQg==
X-Forwarded-Encrypted: i=1; AJvYcCWWjlPY0rmRnHd3GaSVqZeiHVCRkyqrqoDwxcLA6/k3jwebaRXQ4HPLwxwdXy2dZ2cu5ceCgLUB@vger.kernel.org, AJvYcCXIIMEWbZq2im9bwHz1DrtGvGbKHi/YlR5DKYaVX3RCACDQtYVLL6BDWvAc719Z8n8SpIUrHR/Se41OZr3td5DI@vger.kernel.org, AJvYcCXgtWilbTDv3YrsgWIiQ2rLwUk8f6kVXYUwiuOoOwIte6GysaphwcmNzWx9IMQhpXEMx21UlhbTJKB540A=@vger.kernel.org
X-Gm-Message-State: AOJu0YygqZFNTlVCL/fRjNOC6l57a5XUZT2oNunJhT82BzWzpDd7gzxW
	C03jJyclaQpyo0ErPG4ey7KqYOfR0b0Vg8MqBGREMGaNAbqLAGwc
X-Google-Smtp-Source: AGHT+IE3poFlOHNZUFgJKmTjVy6PWsH4AbobGe/sDX62Yt4Gzf44SsC2AS6dDoW+2BjahOSwlVEQaw==
X-Received: by 2002:a05:6402:1e92:b0:5c8:9f3e:1419 with SMTP id 4fb4d7f45d1cf-5cb8ae70636mr9267765a12.5.1729872869962;
        Fri, 25 Oct 2024 09:14:29 -0700 (PDT)
Received: from localhost (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb631b0bcsm757771a12.60.2024.10.25.09.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 09:14:29 -0700 (PDT)
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
Subject: [PATCH net-next 1/2] net: netconsole: selftests: Change the IP subnet
Date: Fri, 25 Oct 2024 09:14:13 -0700
Message-ID: <20241025161415.238215-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
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
index 06021b2059b7..4ad1e216c6b0 100755
--- a/tools/testing/selftests/drivers/net/netcons_basic.sh
+++ b/tools/testing/selftests/drivers/net/netcons_basic.sh
@@ -20,9 +20,9 @@ SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
 
 # Simple script to test dynamic targets in netconsole
 SRCIF="" # to be populated later
-SRCIP=192.168.1.1
+SRCIP=192.168.2.1
 DSTIF="" # to be populated later
-DSTIP=192.168.1.2
+DSTIP=192.168.2.2
 
 PORT="6666"
 MSG="netconsole selftest"
-- 
2.43.5


