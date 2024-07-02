Return-Path: <linux-kselftest+bounces-13059-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B28B923EF4
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 15:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBD461F22FC0
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 13:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556531B4C5D;
	Tue,  2 Jul 2024 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PHL6HdF6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2E9186E4E
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Jul 2024 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926936; cv=none; b=dB6Pc/rP1lpsmhAEOzdPdoh6tkNvzZjpEvXqmUMhp+nzaIOen7sRvzpqqFQtUBVWR+PZ04yDHZj6UzRcdf3xSQ9IA3Ztnu5pfDECDVXvV47RNlUhy576lEcmmHZBP0IxhuNel5ZheC/n5e40w1od4EtZVwm89vKAdj9Dppg1qb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926936; c=relaxed/simple;
	bh=jyZG55KbeIoMjk6imOGduy5VGWOolxy4yZAD40rYJSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNMgsGHw3RbUKLcKA/LIAluWF/6CeTOF8Z4YWip/Yj7SRpZQwn2CBaUnr7Pihg6mgE5ZKdG/le6mAV0UB5h61A/9Eo7tEnxS1PVrvFMHYbf420rya+IAPAmvbCb/5sAt48DMlVeOjQuPwvA7eRyWjC4f9vVLSTGDIbh9CbZlS9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PHL6HdF6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719926933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+jl2z9/pX2zCRMT6h5qbae+biJ++Up1G2LDt2lVB89I=;
	b=PHL6HdF6DdlLamY7BEc+qPPBCDoovtj9KqEsng1hrJzpntb+2EHZaVfUMkXxuERqrWIaHy
	t4ImSAxda9UF4ppm/5PrKUvIkS8mdW/UeQj+miPrNG3qXVUnqDqpG7UFO0XZ8AFhQJz6l6
	3ZL1UgXBm0oyp2T/FxS8aaZ1FaAmmRs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-4CUHkCvhOzucYTBx6Br-kQ-1; Tue,
 02 Jul 2024 09:28:48 -0400
X-MC-Unique: 4CUHkCvhOzucYTBx6Br-kQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0DC611933182;
	Tue,  2 Jul 2024 13:28:47 +0000 (UTC)
Received: from RHTRH0061144.bos.redhat.com (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4DCE319560AE;
	Tue,  2 Jul 2024 13:28:34 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: netdev@vger.kernel.org
Cc: dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	=?UTF-8?q?Adri=C3=A1n=20Moreno?= <amorenoz@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 1/3] selftests: openvswitch: Bump timeout to 15 minutes.
Date: Tue,  2 Jul 2024 09:28:28 -0400
Message-ID: <20240702132830.213384-2-aconole@redhat.com>
In-Reply-To: <20240702132830.213384-1-aconole@redhat.com>
References: <20240702132830.213384-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

We found that since some tests rely on the TCP SYN timeouts to cause flow
misses, the default test suite timeout of 45 seconds is quick to be
exceeded.  Bump the timeout to 15 minutes.

Signed-off-by: Aaron Conole <aconole@redhat.com>
---
 tools/testing/selftests/net/openvswitch/settings | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/net/openvswitch/settings

diff --git a/tools/testing/selftests/net/openvswitch/settings b/tools/testing/selftests/net/openvswitch/settings
new file mode 100644
index 000000000000..e2206265f67c
--- /dev/null
+++ b/tools/testing/selftests/net/openvswitch/settings
@@ -0,0 +1 @@
+timeout=900
-- 
2.45.1


