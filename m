Return-Path: <linux-kselftest+bounces-6962-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CF989488E
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 03:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 950891F22A9A
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 01:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821E079F5;
	Tue,  2 Apr 2024 01:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRi/V0RM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591617490;
	Tue,  2 Apr 2024 01:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712019940; cv=none; b=OukAnGUgrBuHiQGpwpONYP90sGhsQTEh7Adiy7xCnXVBBo3y6NZxkGb+K0K1lzxqlIqkfX0SvohotWfjVDovQy2qJDUYc9lLbT7VaT9UmU9cd6OR+BayeGZZ/lT29tXliQh/rgYqSLc4/IUI987evWOLkmjTwIC+tXpugbvLAV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712019940; c=relaxed/simple;
	bh=QJKk6PY4omTLAaqc+5v7chjkm+B7XrZ45POhQ+8kgTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXRhQ8aMrmLaTiBMApBopTceZrLj4/DO1mknLN73AGqT+GAN7xfJ7LOH4FNwO5g9rdnxL28WwmXrJHAi/baUMccW1RBBNgIGnAxaVH8vaJq8rpJETD0qnLRJxq5EOASRzmD3D/XyBjkvWrTLjpY9C7bPj0g2M19ai0vn1cD0hes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRi/V0RM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F5AC43399;
	Tue,  2 Apr 2024 01:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712019939;
	bh=QJKk6PY4omTLAaqc+5v7chjkm+B7XrZ45POhQ+8kgTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cRi/V0RMIhcuYss+pMPUz8drmYBPdzwWP0LQedlThGdlIwZJRqOOMUcGYXaqc9alj
	 Yw9YBTvvM3NlH4Zui/zVXnXGz0BjLdRsBgJElxdeO+11i1QhY4w8nIidEqjtNcSH4q
	 Aae9WXo++nqIMGa6QqNsWqwbmA32p3jADoR0j5Mf5bAcKUFvoTdgGGCoD0RnUIiBUv
	 nQuKBjXMhSPjesKZE0tE721xo4NbCZ7Zns+4mDNRmpL1UKth/QzP28deu/zF1LD0+4
	 cw/070uu9bhyplGRCbER1/4ivVSuxxHJ53tccukYG3+SPqqySva5jeP0fqfIDCxo62
	 woGO5O4DJ8zPg==
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
Subject: [PATCH net-next 1/7] netlink: specs: define ethtool header flags
Date: Mon,  1 Apr 2024 18:05:13 -0700
Message-ID: <20240402010520.1209517-2-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402010520.1209517-1-kuba@kernel.org>
References: <20240402010520.1209517-1-kuba@kernel.org>
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
 Documentation/netlink/specs/ethtool.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 197208f419dc..616bb3eb545f 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -16,6 +16,10 @@ doc: Partial family for Ethtool Netlink.
     name: stringset
     type: enum
     entries: []
+  -
+    name: header-flags
+    type: flags
+    entries: [ compact-bitsets, omit-reply, stats ]
 
 attribute-sets:
   -
@@ -30,6 +34,7 @@ doc: Partial family for Ethtool Netlink.
       -
         name: flags
         type: u32
+        enum: header-flags
 
   -
     name: bitset-bit
-- 
2.44.0


