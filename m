Return-Path: <linux-kselftest+bounces-7035-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F5E896283
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 04:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 189781F233CD
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 02:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2800218EA2;
	Wed,  3 Apr 2024 02:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTyHyuD5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0089014AA9;
	Wed,  3 Apr 2024 02:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712111673; cv=none; b=TMp5HvJSQv3hMHfOeMUG2ZCktfhIQdMJdYS7dPog8bcgqP9UB11h5Zt6RX12+tRSU2J0XJz1Wo8XfM9LNHwdTgMMrf+Yvqh00+YGV4vq/VHzynomrafsKxn4zT/1SYjbKs4j2c8qz7ScvCgAclHyrl8nayIy0KtrH+HTwyu3jW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712111673; c=relaxed/simple;
	bh=EojVAvAl6ixmWSth1szeL7sQLEPA7JGoyhvWivDYq0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q5oD9C4CTnTkFLSmp6sFmS3WGkO2Bp8Lp1qIUdhG8aom3IHG+kvbGzMJ5d6xjxYkpB3xafNQ5PGoaB7XBwwBNxRgYPYUyn6KJy3f9pUsS0k0K/s4+SJG5uDs6bAejWxz+aoPCL6hYERiaYgHYBSAaGDaDKykNZTI4+jz4nkV1JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTyHyuD5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251D1C433C7;
	Wed,  3 Apr 2024 02:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712111672;
	bh=EojVAvAl6ixmWSth1szeL7sQLEPA7JGoyhvWivDYq0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UTyHyuD5JAJBK2MZe0vcL4i+Z8Gf848mK9tWdBKW+So98zOW7VgxZCwXsPDaL38bw
	 mfcpnmVF9meWbvkuESSYo1pZA7+no8BxZrN62c8v6G8PqrymleVg1/K3f9E0PDePyu
	 VhGj0raHyxS4TfV5aYkziwG3VBhpzUpAYgAvfymLQwhukB+IE9s8E9j482ilVXnHWu
	 O7fwRxR0le3g1JjqIKzI9u6DOLcOkCdMaFKYty11uRo+3GfhK9kjIRjpnqc3LGVJtk
	 9eRX6spL4D+7V0sw2L/L2CEql5zmd+wpHTXZFg/9aicp9Bny8XsnuEzsz7DNPLg55C
	 iE+sMWcIwWokA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	sdf@google.com,
	donald.hunter@gmail.com,
	linux-kselftest@vger.kernel.org,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 1/7] netlink: specs: define ethtool header flags
Date: Tue,  2 Apr 2024 19:34:20 -0700
Message-ID: <20240403023426.1762996-2-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403023426.1762996-1-kuba@kernel.org>
References: <20240403023426.1762996-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When interfacing with the ethtool commands it's handy to
be able to use the names of the flags. Example:

    ethnl.pause_get({"header": {"dev-index": cfg.ifindex,
                                "flags": {'stats'}}})

Note that not all commands accept all the flags,
but the meaning of the bits does not change command
to command.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - make sure we don't try to code gen enum (add enum-name:)
---
 Documentation/netlink/specs/ethtool.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 197208f419dc..d0e4a47e0f21 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -16,6 +16,11 @@ doc: Partial family for Ethtool Netlink.
     name: stringset
     type: enum
     entries: []
+  -
+    name: header-flags
+    enum-name:
+    type: flags
+    entries: [ compact-bitsets, omit-reply, stats ]
 
 attribute-sets:
   -
@@ -30,6 +35,7 @@ doc: Partial family for Ethtool Netlink.
       -
         name: flags
         type: u32
+        enum: header-flags
 
   -
     name: bitset-bit
-- 
2.44.0


