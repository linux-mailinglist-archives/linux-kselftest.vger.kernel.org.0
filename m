Return-Path: <linux-kselftest+bounces-4366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F25A884E9E1
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 21:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDF7E1C23FD9
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 20:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E499C4EB4F;
	Thu,  8 Feb 2024 20:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHiYMe/K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472544F206
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Feb 2024 20:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707425338; cv=none; b=hgDy2AhyMO1sj18dxhXGXBwmRZgjrKmUAtSCe9qwrMsbSKvbrKOdvq9Ck6k4JI4LR8QQf/MLoR50k4d5VWSY1shZMpA5A5AiHai7o4Rivj6Qzj5OpV1sSdrEUyVizzVIoEeplTt+mq5TxApI0Dp1PMU0G93TukSIr5bkrco/PQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707425338; c=relaxed/simple;
	bh=6P5K6g9DoGyrYeskFG3ZTud2y0Jy5ES1/MaotkbmBnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=upq4hs5xLvtMq3arYAYyaHE9d24nFExnTdhxntTb3qUTAbpY1uzqdMV2FU5jfFBqklHJkCpgOw/AnlZ2WpfMbrmAF9kN4VzMCXeBln5EPxp/KzmfkIJK3FGjJ/nmHvuM2rIGHRuaHlVkGsOcE3fK5mKv5rmk2CFGt4GAme3VdRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BHiYMe/K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707425336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N1jX8xaWWAWnTKGIXa8/O/uSBdB1VqMshiJadSRg6EY=;
	b=BHiYMe/Kyh7XgvPY+0qdVwQ0SZuX0jsMVQhlEklHlRFpz5BzStijsHGaGrpNHHmXMM3VOx
	vObuxxzQNoAvxEYPNkqDXvspDQrH+zw1ebf3WfaI1gbnPUcWqH6zkpZaGJ0H76m3BoJhVh
	/7v5V+pQwNtONFBQ960pBgNS2m/ukrg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-0BBqA1kPNaKq99Sr2-FHuA-1; Thu, 08 Feb 2024 15:48:52 -0500
X-MC-Unique: 0BBqA1kPNaKq99Sr2-FHuA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7FE3A8432A0;
	Thu,  8 Feb 2024 20:48:51 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A63531C10C0C;
	Thu,  8 Feb 2024 20:48:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v3 2/8] KVM: selftests: x86: sync_regs_test: Get regs structure before modifying it
Date: Thu,  8 Feb 2024 21:48:38 +0100
Message-ID: <20240208204844.119326-3-thuth@redhat.com>
In-Reply-To: <20240208204844.119326-1-thuth@redhat.com>
References: <20240208204844.119326-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

The regs structure just accidentally contains the right values
from the previous test in the spot where we want to change rbx.
It's cleaner if we properly initialize the structure here before
using it.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tools/testing/selftests/kvm/x86_64/sync_regs_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/x86_64/sync_regs_test.c b/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
index 8c3898cf79b31..1cd19dfa0046c 100644
--- a/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
@@ -315,6 +315,7 @@ int main(int argc, char *argv[])
 	run->kvm_valid_regs = 0;
 	run->kvm_dirty_regs = 0;
 	run->s.regs.regs.rbx = 0xAAAA;
+	vcpu_regs_get(vcpu, &regs);
 	regs.rbx = 0xBAC0;
 	vcpu_regs_set(vcpu, &regs);
 	vcpu_run(vcpu);
-- 
2.43.0


