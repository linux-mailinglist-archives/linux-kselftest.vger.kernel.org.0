Return-Path: <linux-kselftest+bounces-28037-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0ED2A4C091
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 13:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C8D53AAB9B
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 12:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6CD20370D;
	Mon,  3 Mar 2025 12:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MtFRwbhn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90D020E032
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Mar 2025 12:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741005833; cv=none; b=NOExaOUvvRjzjksrEt/x9HiqtA/IcKTbvX3dGLF6aWieb668qcf1hYdK3MnTLdIWfa5bwCl0D1DlTEhjWg2D5CQ36Oju68rQFBGujjE7qAmvzLNuIVCWx5T2/NmP6EuVflfv8QeUZcpHLU30yXSB5I2B5yzCMLEAzM1g5cgc2j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741005833; c=relaxed/simple;
	bh=Ex46o5OERtFZl/wNpZxxHVLaZLO6qBZqtfrS4KZ9bqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RIpamsxbATG8rb1yqezfq3xUJi2LBXGmFqkVaoqmIHNcGzYAKbxmbddK3LwtSA5ykSJ5RZF+h/E0sHHHjR180BujOw+QleaARbtttxB/bxvsU2yLsJJ0Ws0+10lPb/Xpc38d5biV+XUeOiag0n3275zuDu7QZ4Fg2v5NpOLikCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MtFRwbhn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741005830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UB/acPgMwoK4vkq5V9SDm36yvXOIYaejIqPgfs9rmpU=;
	b=MtFRwbhnvUVFyLqMw6uxUr4cE0kRThTLweu/CQp8HWcYeLD5DwL4u++hV33IvSgoStbOXD
	g3TbCx0aC12OksNj1FO3l5r82w60CstvAzTXkPQ467TlKnexN+mz2kkRnPUEnmSBj9czgn
	Bl88KRZJa0cV1WTmBAFrPEnjedzBNlc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-EW1Pyuq8OxOTmkY3XSTvGw-1; Mon,
 03 Mar 2025 07:43:49 -0500
X-MC-Unique: EW1Pyuq8OxOTmkY3XSTvGw-1
X-Mimecast-MFC-AGG-ID: EW1Pyuq8OxOTmkY3XSTvGw_1741005828
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64EC9180087A;
	Mon,  3 Mar 2025 12:43:48 +0000 (UTC)
Received: from localhost (unknown [10.72.120.23])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2805719560AD;
	Mon,  3 Mar 2025 12:43:46 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 02/11] selftests: ublk: fix build failure
Date: Mon,  3 Mar 2025 20:43:12 +0800
Message-ID: <20250303124324.3563605-3-ming.lei@redhat.com>
In-Reply-To: <20250303124324.3563605-1-ming.lei@redhat.com>
References: <20250303124324.3563605-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Fixes the following build failure:

ublk//file_backed.c: In function ‘backing_file_tgt_init’:
ublk//file_backed.c:28:42: error: ‘O_DIRECT’ undeclared (first use in this function); did you mean ‘O_DIRECTORY’?
   28 |                 fd = open(file, O_RDWR | O_DIRECT);
      |                                          ^~~~~~~~
      |                                          O_DIRECTORY

when trying to reuse this same utility for liburing test.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 8e43aebf7dfc..8f48eb8568ab 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -12,6 +12,7 @@
 #include <getopt.h>
 #include <limits.h>
 #include <poll.h>
+#include <fcntl.h>
 #include <sys/syscall.h>
 #include <sys/mman.h>
 #include <sys/ioctl.h>
-- 
2.47.0


