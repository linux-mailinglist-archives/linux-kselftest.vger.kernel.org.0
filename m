Return-Path: <linux-kselftest+bounces-13044-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDAD923AE0
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 11:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1FB4283E2A
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 09:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B23157465;
	Tue,  2 Jul 2024 09:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aH54K+wS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676E9158A3E
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Jul 2024 09:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719914087; cv=none; b=GbZiMuMxAyORdH38ifM7Ss7mr8FswgTHGNDl01tlcgOAfd8ujSpAikd2d7VcPEOZT3VLLdYzR/634NBsdqaYtsTCEz8gzw7zLLggf9LjxgJt3+r+5rdXdOSY+mpKeOWpkzos0yB+CVtaHwuxTRzjS7IMK/iBHvDTMnBnQ26VtJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719914087; c=relaxed/simple;
	bh=rhrUK4kSWPb2+QOzvaLUotusmiPqRE5EK/ab8QLEDrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FPMs0FMfAVHMhw5CJ5R5JnCurO+BGuroR0qAou4uKR3OfkAQAQQKZrQnTQgb8nrWyTYWC6vmDi2B+WscymPftZGdlwy8Wk9jCD2KI1s3lvBka8ii5cZVpnsVBCLiJb5EYYBkU9UI+XuGDQunxJYmkG0RNE5WPFsZBcVVv3XTJb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aH54K+wS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719914085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TCsarsE51WIWuJR3kqpDN3VLDdV6+uotyzVsuXmGHHw=;
	b=aH54K+wSeQHVH8AGsoxnJfk8jkOcXLoK103NqgbYMnYGJIAR5tWWtdR5TtzGnnLpUfpfpd
	nVzbypa2dAsKdSKeTYgfQNvYNIQIiABSF7VG0r7qC5C+1shPk3dLvROBKxNHV9b3XWeiqz
	M7cFXSZz7nwNf787xxffK/S2uAOr1vw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-Re8wa1oQMmSYvPjrDav5qA-1; Tue,
 02 Jul 2024 05:54:37 -0400
X-MC-Unique: Re8wa1oQMmSYvPjrDav5qA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C79111944D3C;
	Tue,  2 Jul 2024 09:54:35 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.194.50])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F2FC019560A3;
	Tue,  2 Jul 2024 09:54:30 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	horms@kernel.org,
	i.maximets@ovn.org,
	dev@openvswitch.org,
	Adrian Moreno <amorenoz@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v8 09/10] selftests: openvswitch: parse trunc action
Date: Tue,  2 Jul 2024 11:53:26 +0200
Message-ID: <20240702095336.596506-10-amorenoz@redhat.com>
In-Reply-To: <20240702095336.596506-1-amorenoz@redhat.com>
References: <20240702095336.596506-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The trunc action was supported decode-able but not parse-able. Add
support for parsing the action string.

Reviewed-by: Aaron Conole <aconole@redhat.com>
Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 .../testing/selftests/net/openvswitch/ovs-dpctl.py  | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 4ccf26f96327..e8dc9af10d4d 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -863,6 +863,19 @@ class ovsactions(nla):
                 self["attrs"].append(["OVS_ACTION_ATTR_USERSPACE", uact])
                 parsed = True
 
+            elif parse_starts_block(actstr, "trunc(", False):
+                parencount += 1
+                actstr, val = parse_extract_field(
+                    actstr,
+                    "trunc(",
+                    r"([0-9]+)",
+                    int,
+                    False,
+                    None,
+                )
+                self["attrs"].append(["OVS_ACTION_ATTR_TRUNC", val])
+                parsed = True
+
             actstr = actstr[strspn(actstr, ", ") :]
             while parencount > 0:
                 parencount -= 1
-- 
2.45.2


