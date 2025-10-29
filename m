Return-Path: <linux-kselftest+bounces-44272-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8050DC19235
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 09:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 85136500236
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 08:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D932B31B81D;
	Wed, 29 Oct 2025 08:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjF6nqiO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E1731B10E
	for <linux-kselftest@vger.kernel.org>; Wed, 29 Oct 2025 08:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726191; cv=none; b=J1WhviVv8pySthbDGlc6iFplWCZsX3DSvbu/q1CfnxPmxIVlg3ixaO+zXgsGZvSCTef9JBh9eAjitDAymQRJGZL3H26kDJQW2/GpEx41KUsYCogfz9nIopIXV1DRRYpusVfyo5GCE5dVmvzHr6AtRGd0pMMRn/qB077LHNlFDyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726191; c=relaxed/simple;
	bh=IFuBS7haZi+1kTM8IJzSktIKoNv8ReAXS+1kQ+tJtak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=agc2iv0yblPDiMdYZSOvwWnYps9mDyRGeu4zS1MqKqzMsh800pYig61UIEv2bl60aObumif5WcDv7HRNVF5cg/qnDxbWZBcMQnLR0XyIQT5kRfn/BvPySDxDbvjUtGtd0gXJRR5k4frtRqKgzbRAWxlr08wudkC4R760ENjNLjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjF6nqiO; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-290b48e09a7so83713015ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Oct 2025 01:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761726189; x=1762330989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aaHhDa8PHuXgCu/CZ7lCayELGigeh4dQ1UWKLOa3cv4=;
        b=jjF6nqiOy5y+9FrxgIVGL3Tt4hE8MQrOVvlig5qPexfEoZAktmRy2nXZoh6l1cEsgh
         GIXCtrEWcJP2rqOF+1+S6VmAh2ZnsL4gatmOWv6Scomak+ZsgJ5R4wtrwEZNH93kAJr6
         2kxx8ojwx81mHvOyoHKEdAyY7y2i0uWz6CLyhYcMPGcfTS+qTMYD8X+BUVQwIeCcpkXL
         7j+ivMP8y9RfxWvECsAR2NeTeTd8dq7hDd0xqrtSXvIeKYFhOV6GqYq+pB6wxUGKpu0w
         40IfIfRYGVDj6kbS7Eb6d8bckinbo4Frxt6WakpmPCdKAmfJt7VKD7wFA5NgUUk1m7mw
         7tpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761726189; x=1762330989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aaHhDa8PHuXgCu/CZ7lCayELGigeh4dQ1UWKLOa3cv4=;
        b=SG5Upfq6Y8yR1J9VDT3YBmwq3GR1uG97nt/xYtuP1lP8ToAuHWfpwyi3NDrV7Reor/
         4MiV8fk0MOIxHi2kGHZrCQS8BcJjehD1KOI//7RMyeiqR8NCNb8AsPB3F1dF+3sT5R8x
         yVD1Ai44ezIOuBu0TVT0C3P8MeNJDyqXMaypDmsMPbEmLsBhWTBDtgBSxte5nn4vJFUY
         VcikFVJRz2gqTXi/8K8sjV+ILppZs1if/R/t42r3OmBWPUS0Xjl/DJw8Z401mPJRASK6
         9CagCsnWMP8q0jyS3VqcqrpeBemzrRxDlsutoOsqF+QIGDMtWUrn564dzFB5EklZ1L7t
         xMog==
X-Forwarded-Encrypted: i=1; AJvYcCXivJaFHg+jTjoffVYpG5lYFEXxTcMyMrzDbomS4DgBjFKsRcaJ4AVAR0TMGHKiMbtFkllgsuh4FsDwJVNirD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YycKCx+1hyoehZZFMN0UFy6cR9ekuzhHi28JInv5NpT774LPIwz
	RITNchkVZQj2dH0qb829HcB9q3sQRKVx24c/et6o3gQP+TPV25k/ykiz
X-Gm-Gg: ASbGncvOnQ74TDvAEPesd5z4uPtf2a6KcxUqcS1xC0DKds2ed8FiW+DmEwNAKOX9uTH
	z3VTO5IZ8C2OXwWEiPu0zauN58CjlllZ2TSdw+I7c9UQ39TPa01aeluqF2G99Qi9mJpaNKlCpSN
	R7oRGSejDLdlKkZyyWGJgijgNVDhMU4IPfRne3syWB6+EX7u7CnwElTnlO/P0LVeecqmqn2XRTG
	OLHkb9IUHuueRxXQxioSYBpEJ7ot4GVtHpFO+/PEMCtYEv9bz7mXRv3T5cNrA6YVPZ5ufIPZ86h
	CedcVf3nTo82oPN5CNrQfdI9HoBpUJ2RIqSw5zeZsHCjLxvNSfAPZYqCOMwwNwVnI1jvIuQAJZ/
	phgtzDYJwOA1/97sDXbiDpOCDvyJ07YJMXq6KGhHr7IvyUuAcnhBvAVIFcteU3WISJEvfijzXPQ
	42fjLA
X-Google-Smtp-Source: AGHT+IGtSlDxg0T2oukXZlxpD3jzIWP+RA1AXUJtoVRhfHR08fUfLWt0lsrBketiOK0arzNKfhB91A==
X-Received: by 2002:a17:902:e78c:b0:252:5220:46b4 with SMTP id d9443c01a7336-294dee991damr22816595ad.37.1761726189151;
        Wed, 29 Oct 2025 01:23:09 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d09958sm141906005ad.24.2025.10.29.01.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:23:08 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jan Stancek <jstancek@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Shuah Khan <shuah@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Petr Machata <petrm@nvidia.com>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 2/3] netlink: specs: update rt-rule src/dst attribute types to support IPv4 addresses
Date: Wed, 29 Oct 2025 08:22:44 +0000
Message-ID: <20251029082245.128675-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251029082245.128675-1-liuhangbin@gmail.com>
References: <20251029082245.128675-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar with other rt-* family specs (rt-route, rt-addr, rt-neigh), change
src and dst attributes in rt-rule.yaml from type u32 to type binary with
display-hint ipv4 to properly support IPv4 address operations.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/netlink/specs/rt-rule.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/rt-rule.yaml b/Documentation/netlink/specs/rt-rule.yaml
index bebee452a950..7ebd95312ee4 100644
--- a/Documentation/netlink/specs/rt-rule.yaml
+++ b/Documentation/netlink/specs/rt-rule.yaml
@@ -96,10 +96,12 @@ attribute-sets:
     attributes:
       -
         name: dst
-        type: u32
+        type: binary
+        display-hint: ipv4
       -
         name: src
-        type: u32
+        type: binary
+        display-hint: ipv4
       -
         name: iifname
         type: string
-- 
2.50.1


