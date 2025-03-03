Return-Path: <linux-kselftest+bounces-28039-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F80A4C0A2
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 13:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C4921895AC5
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 12:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BFE210F6A;
	Mon,  3 Mar 2025 12:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BLzMT3Ga"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A51B20E714
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Mar 2025 12:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741005844; cv=none; b=YGNCtRwpbtinQ92rVffvrnmaMU4Ew0aSqK5XOmH9iQy6pT/dvO7yjY6z+Y2xre8Lhxb+0JQScDW9uvquB3yeBWDq8uW373yTuC+qP2feV7uiAGPqZj1IUp1AlJKygFbuCg/GlH5g0ZLOyHd0EYDMix36v5sCamVpfvZ/4aFXcc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741005844; c=relaxed/simple;
	bh=pVkArlwes2TAzK9RpR+cWFqfh5RjnveiLwst4i8DyuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVV5yqr6xXgqkUpHnjUIFrECILxEp2PRVphVCXWNWpbfgTD9+UAlKYv855TJD1Kpjn+o1ePLPQzwEUlsR2s8ubWXsY/bvZrwxWV+HX5bdzOgd3V9NNunLCxCeutBsMYJtwHks2o2PXUy4rnGffgsix8EFnbkBg/blP6L3g9dbIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BLzMT3Ga; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741005842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ZDv6iqWcZmreBmD81+btrs67uOL2A4J/nnlM7fxZZE=;
	b=BLzMT3GaBsFOnqV7JKXAi6HI0TihIbEv15/Uufc/+QMdwsNMF61fihNwn9nfMGHTBOgCLq
	cLZdWqNvJWgqZ1ZnpqEqZL46UN4zCRQCzVgCS/xOkVHzQbL5j8N0DeW/ZUwg7OtOOQde0N
	vYYCsuVQ+LxuYB2ADKwh3h+pSHt2Fxs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-QS0ic2L3Md6Y71JS3IwYRA-1; Mon,
 03 Mar 2025 07:43:59 -0500
X-MC-Unique: QS0ic2L3Md6Y71JS3IwYRA-1
X-Mimecast-MFC-AGG-ID: QS0ic2L3Md6Y71JS3IwYRA_1741005838
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA64918004A7;
	Mon,  3 Mar 2025 12:43:57 +0000 (UTC)
Received: from localhost (unknown [10.72.120.23])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E8DA5180035E;
	Mon,  3 Mar 2025 12:43:56 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 04/11] selftests: ublk: fix parsing '-a' argument
Date: Mon,  3 Mar 2025 20:43:14 +0800
Message-ID: <20250303124324.3563605-5-ming.lei@redhat.com>
In-Reply-To: <20250303124324.3563605-1-ming.lei@redhat.com>
References: <20250303124324.3563605-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The argument of '-a' doesn't follow any value, so fix it by putting it
with '-z' together.

Fixes: ed5820a7e918 ("selftests: ublk: add ublk zero copy test")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 24557a3e5508..148355717ee7 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1068,7 +1068,7 @@ int main(int argc, char *argv[])
 		return ret;
 
 	optind = 2;
-	while ((opt = getopt_long(argc, argv, "t:n:d:q:a:z",
+	while ((opt = getopt_long(argc, argv, "t:n:d:q:az",
 				  longopts, &option_idx)) != -1) {
 		switch (opt) {
 		case 'a':
-- 
2.47.0


