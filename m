Return-Path: <linux-kselftest+bounces-21466-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 072159BD47A
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 19:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395541C22298
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 18:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDA01E7677;
	Tue,  5 Nov 2024 18:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CpwZqc0G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E8C1E766D
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Nov 2024 18:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730831054; cv=none; b=X6qw4q52x1k6U0HD4L6y+1uEcfYX3/ZrJ2p/Cnl0qkAzjhwF/Qgbunu08ID3Bpn3WbunvudwSkJ3hSZJEE5Rj0/nXo9Fx70ylR4M8TBfpioM0/v8ZCQvYXR6K+0L/TcZr3g5lxmdE/PNMK5TIS20ViNcWejE6QBA5E27QWTQfYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730831054; c=relaxed/simple;
	bh=vr3Sv/+c82v6CtX9a+kMIZ6s1FUOVbpF9h0hlQAI8oU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VJ8rM4huaVQtWt4DGYA9fVxCOmmR2OUloZu3u7zysWbZRTCPGPlNphLkeHI7781+3RsSwknbUWqDKJ6VjyYx5L0UfJVx7NbpbqjcGmjOLaE9VrsKBD/Igs61IA5IEyZAG0kEp30deskj3rYEaU7kEfERJMfDCKpVgTNtg6quv80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CpwZqc0G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730831051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zbAjl2Shden4WnBpQYkGv2fcUa8pXm9RHIlYLMS16Qs=;
	b=CpwZqc0G/07abRZ0gXcKVgaC4Q8p+dkNo0knrr9/cLrS9VPxHjFcvKlkbmcur8yPXALDFH
	3RLaPSoI1jkgPj1kOi0nGycvlhlrLtpuoVpHB+5A6sBcHiHzBJMlsY59R5a2eEOyfrKFCX
	R9rgjoKc8xjIaqqDI3FBiNg9wYvG4Pw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-INp5UxUuMkSxVa2HodlQFw-1; Tue,
 05 Nov 2024 13:24:08 -0500
X-MC-Unique: INp5UxUuMkSxVa2HodlQFw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F18FB19560BD;
	Tue,  5 Nov 2024 18:24:06 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.71])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9658819560AA;
	Tue,  5 Nov 2024 18:24:03 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 net-next 2/2] selftests: net: really check for bg process completion
Date: Tue,  5 Nov 2024 19:23:51 +0100
Message-ID: <0e6f213811f8e93a235307e683af8225cc6277ae.1730828007.git.pabeni@redhat.com>
In-Reply-To: <cover.1730828007.git.pabeni@redhat.com>
References: <cover.1730828007.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

A recent refactor transformed the check for process completion
in a true statement, due to a typo.

As a result, the relevant test-case is unable to catch the
regression it was supposed to detect.

Restore the correct condition.

Fixes: 691bb4e49c98 ("selftests: net: avoid just another constant wait")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/pmtu.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index 569bce8b6383..6c651c880fe8 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -2056,7 +2056,7 @@ check_running() {
 	pid=${1}
 	cmd=${2}
 
-	[ "$(cat /proc/${pid}/cmdline 2>/dev/null | tr -d '\0')" = "{cmd}" ]
+	[ "$(cat /proc/${pid}/cmdline 2>/dev/null | tr -d '\0')" = "${cmd}" ]
 }
 
 test_cleanup_vxlanX_exception() {
-- 
2.45.2


