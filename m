Return-Path: <linux-kselftest+bounces-25328-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB66A20EC9
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 17:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD4B2167647
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 16:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13271DE3B1;
	Tue, 28 Jan 2025 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OQLDKcse"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616291DE3B3
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Jan 2025 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738082379; cv=none; b=ok0huyKEWgEiXRuHf3JQW8Fy1L3VC4KpVNFtV6ZJSluNqQGRq4LQX0xNSwhShISRSReDQeymxX1BtlwrIKKGbqBWLpRuhI+6cYwmrTJHGapUQ9zFaCbge8pJq40hw87fy4YucSPJwkRIBelip15G1oz4ZkQwAHvuAaLQLmo/pck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738082379; c=relaxed/simple;
	bh=LG8n3miZYclcHNS+6JY2e+S4GP1ksWsI7kF8xUhji2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQ1KUEUJvfE5/9ZarQCVjvO47ZSAlnhyCbFHC0U1gpq3MEdXEuYAlgLHFcbFlt1m1o2XOidAOm47xz0URJzlPBf0KPC/ujfYKZ2rZGaQ/2ZKoSkBAwPzImx2KhseTzSOvh6ycbEiz0kW2CdiezDOueOdp1VqyPc/YanYr840cZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OQLDKcse; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738082377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M2Ve77QJmE41Ot0UBKq5NH4Iw6Uhwg4TTTg428aDJSU=;
	b=OQLDKcseagwtgQci3L1TWFaTfAzwb1apNiLx/JxwI4HYjMRSky8vgECAYGNbRRPPc95q8A
	q7PUK5iQ6yqR33gYuIlUOV6D4BVwb9oGKnQK8edIgbooc2J+pD2r/2FSN+UvhMBw/lY2Zy
	xCIpkzKu6aIEb2yK2ljop22Zge+qN14=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-fvPVB1yJMdCWjwHQO-bn9Q-1; Tue,
 28 Jan 2025 11:39:34 -0500
X-MC-Unique: fvPVB1yJMdCWjwHQO-bn9Q-1
X-Mimecast-MFC-AGG-ID: fvPVB1yJMdCWjwHQO-bn9Q
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 044671955DC6;
	Tue, 28 Jan 2025 16:39:32 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.225.106])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2C04518008C8;
	Tue, 28 Jan 2025 16:39:29 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Shuah Khan <shuah@kernel.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	linux-bcachefs@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 12/21] bcachefs: convert eytzinger0_find to be 1-based
Date: Tue, 28 Jan 2025 17:38:49 +0100
Message-ID: <20250128163859.1883260-13-agruenba@redhat.com>
In-Reply-To: <20250128163859.1883260-1-agruenba@redhat.com>
References: <20250128163859.1883260-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Several of the algorithms on eytzinger trees are implemented in terms of
the eytzinger0 primitives.  However, those algorithms can just as easily
be expressed in terms of the eytzinger1 primitives, and that leads to
better and easier to understand code.  Start by converting
eytzinger0_find().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/bcachefs/eytzinger.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/bcachefs/eytzinger.h b/fs/bcachefs/eytzinger.h
index f25c895aa184..d3e8b9edf335 100644
--- a/fs/bcachefs/eytzinger.h
+++ b/fs/bcachefs/eytzinger.h
@@ -307,17 +307,17 @@ static inline int eytzinger0_find_ge(void *base, size_t nr, size_t size,
 
 #define eytzinger0_find(base, nr, size, _cmp, search)			\
 ({									\
-	void *_base		= (base);				\
+	size_t _size		= (size);				\
+	void *_base1		= (base) - _size;			\
 	const void *_search	= (search);				\
 	size_t _nr		= (nr);					\
-	size_t _size		= (size);				\
-	size_t _i		= 0;					\
+	size_t _i		= 1;					\
 	int _res;							\
 									\
-	while (_i < _nr &&						\
-	       (_res = _cmp(_search, _base + _i * _size)))		\
-		_i = eytzinger0_child(_i, _res > 0);			\
-	_i;								\
+	while (_i <= _nr &&						\
+	       (_res = _cmp(_search, _base1 + _i * _size)))		\
+		_i = eytzinger1_child(_i, _res > 0);			\
+	_i - 1;								\
 })
 
 void eytzinger0_sort_r(void *, size_t, size_t,
-- 
2.48.1


