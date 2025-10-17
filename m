Return-Path: <linux-kselftest+bounces-43361-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C96BE62E3
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 05:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C24AF5E4496
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 03:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060E522B8B6;
	Fri, 17 Oct 2025 03:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bd/hWv6l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4AB1A9FB7
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 03:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760670319; cv=none; b=GdWYaf81j/1zUPRM6iEBZxaTtMFie4Ngmy46fpEFY7Kv9fONgPM6xV4IgZkQSddyIB6wsSkUfW+5+eeyCqnwxHE6dOwIZM+VNqEp99BMRYjXl3E+2RHB+dYSuIt5No/gXu9KY8SLiUspn9E1SRsVTIYZXkpDeYix1ISULXyoia4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760670319; c=relaxed/simple;
	bh=380/EkU9TIh1ez3W2lpQnsgyCmAC9hJZsgc0uthCnTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QDrjYCmNqvrACAnjfb8AtNkfwpbVzIcQ6my8l9UScySqAn+LvNuno7aOp5TMeclCVBgPY8JFxQUSc7quWCQXRndAej1C0FUIBO0w6P0mVUl+tkurKDUhIC4z96IEuJjIw0w4/Z+bDxeky+rarLp+EhPStHRn6NrIPzqKKz1CHqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bd/hWv6l; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-27d3540a43fso15409305ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 20:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760670318; x=1761275118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3r6CrZovcrJts/nM1rIovQa9F5q8RdL0nG42mI0GRg=;
        b=Bd/hWv6lHA481oS9gWWW9xKPgMBbuSj5N7ppHFHbzoij4dcszfkRFiao18Fk6kb+rX
         EBGepO8E8/o/fdMsM+PRPCZABFQ8sLLZijETDRTou6A06tWWQ5hsvzzR1JH0DVPKgluO
         3NYuPBZGs8hlrs4AICEwNC1AuVqOIMjeyDu/sSlsUBceuRMZ9EjljpJN/ojwlzioKkl4
         JojofvRk7L2U2gQv3guMNgfmVZHSLkDsEai9e1t4d4c8Iy7d8/6cM6YAUR0RZsLkZDdB
         v08+GhEQhOqcJXESjqQ0mzdjbKQuwDrmpIuW+ZVf2GM5ww+mMbPXHCXO+Hx8ClmZyUxw
         V0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760670318; x=1761275118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3r6CrZovcrJts/nM1rIovQa9F5q8RdL0nG42mI0GRg=;
        b=QtWC8wu9tLRinN75th5L3TNo/sGa1dU9VfBXXjAt2OdzK/27M2+bSiXn0GKyheU8Is
         EO2WLTN8EfCB3CBfG+3RnzypQfXWJ4Lsv6I4/R2vtgaSSS7IqGVAXq+LP1ztj4WqBM7I
         WmWJFAqxr7kkWH5SAJlDcladT4FnHHMx6HpDUcIrMDSQkbeqYLHRAdmRaqH1npJl9cBx
         JgmcrBOBMmFAPmiR5I/aoE1ih7JdRzaVNHpoVj1NV2fSyxw8qAxugA0ylO251etbG8H1
         8Ch8e8N3vWMmxjtHUCmblTxSMubkXVYLBtNntYW/Oa/zFpar0K2kHk69Fd4R8m3OHdLV
         BwCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjXiZtGLvDq/uqz61166l3/xSrqoud/ZDId0Erw9YX1nfHgwPI6V3z1ae3TThSyib8mOOybwQeQ1hEas1ravE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/89uqfTlxRtbCZrI0uEPmGEWzV92xz+eg4BzVYBAFX0534yY7
	0wQMPwabPddvwYtNmoohnAqpIEjKK5P38+pigOnVHk3q7FY649EQTA7f
X-Gm-Gg: ASbGnctuMSRA5IiQDGUP6A5XRZIwPaZBC6KaDz5ucMfGKKkItKOTxO5TLUIQDO/trsn
	WyA2dD9NiSm/mVazrfcAQYLAL66QUBf+proCl7xdC4PwhxH7JGyJpiCzwXanxFoMMBxNEd9VDEu
	ScmywaJx96PDjkpL8s2R8b2qGjsANKONawTgFDDfQKG1D+igqjK/B7jTS7kd3oeaY/WtAbMLVHR
	RhbqC8aN7q1w4ZZ90Be7lV0pNwL1zjbqvuoUKlSVE0cZQaiK2bTf7qTYuxeCDaTZrHCSfuZLWFA
	7lkWdvNkNu9sSNmvVeGeoUKjOvJtS7Lqd+ZZDrbXQEKHuplUNeoDqJaDb4jejfeYeoOMMTCcOfg
	6EyZdfbSHSxt79zbZYQ8V8nvvQ/8537bIAP8XW7NcQMx964aV8vI2ZCwR//OUkPCUeZbs6lbEB+
	huj1Js
X-Google-Smtp-Source: AGHT+IEhOQFhsYeyl26rjo3iy/25Y8AZgw8NVmq1AbyrV0Op0hzEQnVj9PxbXCkTUc3JRr3t8z0txA==
X-Received: by 2002:a17:903:94e:b0:290:533b:25c9 with SMTP id d9443c01a7336-290c9c8ae4dmr23819055ad.2.1760670317807;
        Thu, 16 Oct 2025 20:05:17 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909939613csm45987225ad.51.2025.10.16.20.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 20:05:17 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH iproute2-next] bond: slave: print master name
Date: Fri, 17 Oct 2025 03:05:09 +0000
Message-ID: <20251017030509.61794-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251017030310.61755-1-liuhangbin@gmail.com>
References: <20251017030310.61755-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new attribute to display the name of the master interface for
each slave.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 ip/iplink_bond_slave.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/ip/iplink_bond_slave.c b/ip/iplink_bond_slave.c
index c88100e248dd..55deaadf5fe2 100644
--- a/ip/iplink_bond_slave.c
+++ b/ip/iplink_bond_slave.c
@@ -92,6 +92,17 @@ static void bond_slave_print_opt(struct link_util *lu, FILE *f, struct rtattr *t
 	if (!tb)
 		return;
 
+	if (tb[IFLA_BOND_SLAVE_MASTER]) {
+		unsigned int ifindex = rta_getattr_u32(tb[IFLA_BOND_SLAVE_MASTER]);
+
+		if (ifindex) {
+			print_string(PRINT_ANY,
+				     "master",
+				     "master %s ",
+				     ll_index_to_name(ifindex));
+		}
+	}
+
 	if (tb[IFLA_BOND_SLAVE_STATE])
 		print_slave_state(f, tb[IFLA_BOND_SLAVE_STATE]);
 
-- 
2.50.1


