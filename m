Return-Path: <linux-kselftest+bounces-25898-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6594FA2A4EE
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 10:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016BD162044
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 09:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1307226536;
	Thu,  6 Feb 2025 09:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ykqpxxn6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4D6226531;
	Thu,  6 Feb 2025 09:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738835173; cv=none; b=IEjrSrN0cw7cYrIEQHK4qgPXUc3JGXqkGxoH8Pg8Clf4WF2bKXbwo0xMxSfnjrX77oy+d5dFJ1r97Icn3D0m99zNSKgdJQbYEa8Dgkag7YdE8j0lMf0u1jgPW6KgPrUhnw/bJiJLAki0uKnfUVss4tEusbinT04bEqNd+Fj4FP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738835173; c=relaxed/simple;
	bh=VYV9UQs0A/BrPZxyCyb9mTEls4leGbWtttRDjqq3sGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hbyqn4sxtEty368OKv6F5dGanwWa9J4fWQKfUy/v57KmW9KM7jBWzVhbRVKXVDIvXd40iAGUFrJmDVWQgR6bEM0Oe1crSLkiOfFLp32o1fCEPjeulvL4hkzjvPy0EXzhRupuSz0jUqcsN/ClH3jRFsoXJeBAIgwcu7fs84gSrG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ykqpxxn6; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21f0b5d6c6eso10407215ad.0;
        Thu, 06 Feb 2025 01:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738835171; x=1739439971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mq6iUHsSCPitSDTg3znTzz0IyqhtOizwlSqkgQBCFig=;
        b=Ykqpxxn6S2Y9krBN/iFvUyRUAE9K87Kjf8vPk8nMl53+QKZzK9Y/BkubVZ4O8GZjo+
         jb6VdrhDhvJsuQvlPKEVQ1l/2Wd5HnobFMo9RJRIImsNBaJOjBOU19sfgpTWVGQ7FWT5
         Aw5W9ZvHvkXnq1b1gyPmqsEl4rJU+H/YFItV27e8Qxj0DO0/UtI6aHy3J8udCJ2eiqZy
         moMCLstjFaOWGFzAIc8g7Bkktl1BErUEspwzXEbFSfl1c2C+iEZu139R8MR7X1PpOLmX
         I7PB/h1BRvNmMMSb/fAqb6sCoVGtEcLqVpMzipy79j2uJeozM+HByEd6KQqbCQmGMXDK
         aCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738835171; x=1739439971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mq6iUHsSCPitSDTg3znTzz0IyqhtOizwlSqkgQBCFig=;
        b=LSw78+8fAeJJsSIu+81YFj1Hz1FwitlFiIKl2OrUu8iFsHl+PobQNygGUyRMNtlN2C
         IVOjgWFp4ZPRNTWoC+zxIZZ3ztoExL3GzXZSqaEXbf6Gur8b8SWqefoa5MtE+bI5Gip/
         5CXmUDg4q3TMseDPgGKiurmX+BXmAwNiGJ0J5Z4lf6NhdPTZuQjmur8/kJxBeoTsihAd
         KF1MOt7raNxqwCTi3oAGKkV+rthzviZZCUZV0swzLuwfcDOcp/nE2PdH++NnWIH2N7M+
         VBsT71yXzenweVvapNiGUxkHUZocpVXMIE1RoR96BHYlPeUR1j7nIWo182bY0/BP5PN7
         J2rg==
X-Forwarded-Encrypted: i=1; AJvYcCWFGcap1+7dNgcfbDMycWFZENnN/VsSOtAcl1yAVftpKfNVTJKbzA1tskzvzGs6hfsck4KFaS10zSzH/aMAdsxn@vger.kernel.org, AJvYcCWS1wPDFrm+COvGpOK5R9iyS6n2ffGEVQPk/5IrTom5WVfXh1mUmuq4tNsFFG3fP6doFbeIyEik0GmZ6yQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcRp2iwv3ES5ZkVDTS0vEj7hbFphKYpOigmM/6nvYgnkYDCe0X
	Gl+KFCHy9Sq7PhO1P4G3rNuz9xPjXsoDerF1tI+R/ZMQZotdUQ4eszf3gx/xF7s=
X-Gm-Gg: ASbGncvAqCaZ4qDFiBMihfGMx0llBtRcnjxLq3sDbnXF0zz1RVQjO2QnISUaRs2fmW5
	s6mlPQcVhMvjmgxXwVyF9JHw31XaCpd6epu19uO/hGi39zrSYZ6Kl2PRiXW3gjY7vJstDi19tn5
	mFqsjFQg4HjNRO1+8LhXqXruyQV/qK0MarPQKgE96xM8G7opXWk62HI21i4viPjSxS/xi2GLPeX
	0BKukBdZgVtAZw+MJXlXWqVMHloikkNlo2BVGFe3DS3GlU3ZwU6P3D3fyhGofazZnIxxs8eWBGr
	n8Zr6t2bC0uym5gciapYGbxDGcMrTB28qTU=
X-Google-Smtp-Source: AGHT+IHBF/mdpFPT+oIc5KzecjsGr/mfGctgoQuS1W0jJ99TW0i6qxTPSKL0gUU0zRiN3QEP0CWOxA==
X-Received: by 2002:a17:902:c946:b0:215:ba2b:cd55 with SMTP id d9443c01a7336-21f2f145833mr36462235ad.2.1738835171015;
        Thu, 06 Feb 2025 01:46:11 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f368da60bsm8394695ad.258.2025.02.06.01.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 01:46:10 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>,
	Jianbo Liu <jianbol@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net 0/2] bonding: fix incorrect mac address setting
Date: Thu,  6 Feb 2025 09:45:58 +0000
Message-ID: <20250206094600.357420-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mac address on backup slave should be convert from Solicited-Node
Multicast address, not from bonding unicast target address.

v2: fix patch 01's subject

Hangbin Liu (2):
  bonding: fix incorrect MAC address setting to receive NS messages
  selftests: bonding: fix incorrect mac address

 drivers/net/bonding/bond_options.c                          | 4 +++-
 tools/testing/selftests/drivers/net/bonding/bond_options.sh | 4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.46.0


