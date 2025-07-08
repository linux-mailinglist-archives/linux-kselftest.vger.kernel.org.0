Return-Path: <linux-kselftest+bounces-36774-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF8FAFDA82
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 00:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E14951BC04C4
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 22:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74491253F3D;
	Tue,  8 Jul 2025 22:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYfM87pq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3AD253F1B;
	Tue,  8 Jul 2025 22:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752012410; cv=none; b=Uh0li+OQuLrsaEJR3ksbHOoUTTuvahi0GRavhQXpV17v7rOeTkGTiitCAACh1oJ0fgipxmLcUR72WRF8fb2kw3iFNUtNMYtDPxOeIGo0WoFjSDSh9ZLVcoG+iVJtC/8hRt8VfEyFqEb+ynTuM5Y6DvnEBxzDmkFHvmdJ9anFbro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752012410; c=relaxed/simple;
	bh=JhdkkkE2iXOWHF5eo8sGSloUE3RGH+52qAuD10KA5mU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOAMIktRAAnndVgBnu2nKRaTTK0MFoX7blP0YkafAhU2Xax3RGQNw5N8IbU/9QOlwfGQ+QkMJVgIi0AJY2rX4W96okNjQ2hIc1BQ691K/I5HmDLQlJt5qwzZrXxM8opSDhdvBusHFN/3Y5sVmBnsXyiOPMC0+KhYkqskCL4+zV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYfM87pq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FBCDC4CEF5;
	Tue,  8 Jul 2025 22:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752012409;
	bh=JhdkkkE2iXOWHF5eo8sGSloUE3RGH+52qAuD10KA5mU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pYfM87pqexCmm4QfaagbSt4JMRb8QdIgjc7wDBBplwal0o3Y7Ah1rfG41VznlTBOB
	 QZ+qBZh9UNFgtHQw/08ku5r4RQ7qaAI1Fl0m/UkW//Qk0NA79Rq8TtByX6nG6df3iX
	 jm7ccLJgSMwIkVtScs3g33GLjdhs5gdd3D+mgRxzIU2B6xIzE9IepA80ki1owhn2dY
	 7PaTnjn1DuILRvQZ2GA3FQI3TQNiMUC6nhwAFSzKVzcAw25YbpEE+h33n3J54QHFtQ
	 R83zxUp+2VO48dp6/045USo5iMJf5hQ+8spXd5jeeXUcKrJfCG95U7klfWUHDi9I6j
	 THguQa6uuQTIQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	shuah@kernel.org,
	maxime.chevallier@bootlin.com,
	ecree.xilinx@gmail.com,
	gal@nvidia.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/5] tools: ynl: decode enums in auto-ints
Date: Tue,  8 Jul 2025 15:06:37 -0700
Message-ID: <20250708220640.2738464-3-kuba@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708220640.2738464-1-kuba@kernel.org>
References: <20250708220640.2738464-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use enum decoding on auto-ints. Looks like we only had enum
auto-ints for input values until now. Upcoming RSS work will
need this to declare an attribute with flags as a uint.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
---
 tools/net/ynl/pyynl/lib/ynl.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 61deb5923067..7529bce174ff 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -762,6 +762,8 @@ genl_family_name_to_id = None
                     decoded = True
                 elif attr_spec.is_auto_scalar:
                     decoded = attr.as_auto_scalar(attr_spec['type'], attr_spec.byte_order)
+                    if 'enum' in attr_spec:
+                        decoded = self._decode_enum(decoded, attr_spec)
                 elif attr_spec["type"] in NlAttr.type_formats:
                     decoded = attr.as_scalar(attr_spec['type'], attr_spec.byte_order)
                     if 'enum' in attr_spec:
-- 
2.50.0


