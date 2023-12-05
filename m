Return-Path: <linux-kselftest+bounces-1198-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52566805DF0
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 19:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 084561F21601
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 18:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA5E57880;
	Tue,  5 Dec 2023 18:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JiVzxWnv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEF31B1
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Dec 2023 10:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701801962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=exoyK1hKNkeKJ/W4ZrnMKQalTgLRNTH7G6ksX95r0rA=;
	b=JiVzxWnvvcVBaxEr7Ql3AZ1t3crkjub3bMqfWRQm9DfYg8lAla4nFnAu11Uc2kkDHaP5mQ
	FGVkPS9JIoEsZJC3aGm5aQ9fXl2zUTmynGcBWHGlG4EOlDoTO0HvsdWs+y1Lew/si+oH1y
	iFToKs8wUsQUuxKl7Hz54QvVXBPpR9w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-9yquYDtNNpGO0rBJeaJhYg-1; Tue, 05 Dec 2023 13:45:59 -0500
X-MC-Unique: 9yquYDtNNpGO0rBJeaJhYg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E470B84AEA8;
	Tue,  5 Dec 2023 18:45:58 +0000 (UTC)
Received: from ruby.redhat.com (unknown [10.39.192.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5311A492BE6;
	Tue,  5 Dec 2023 18:45:56 +0000 (UTC)
From: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
To: workflows@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Joe Perches <joe@perches.com>,
	Andy Whitcroft <apw@canonical.com>,
	Theodore Ts'o <tytso@mit.edu>,
	David Gow <davidgow@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mark Brown <broonie@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Cc: kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	Veronika Kabatova <vkabatov@redhat.com>,
	CKI <cki-project@redhat.com>,
	kernelci@lists.linux.dev,
	Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
Subject: [RFC PATCH v2 09/10] MAINTAINERS: Propose kunit tests for regmap
Date: Tue,  5 Dec 2023 20:03:05 +0200
Message-ID: <20231205184503.79769-10-Nikolai.Kondrashov@redhat.com>
In-Reply-To: <20231205184503.79769-1-Nikolai.Kondrashov@redhat.com>
References: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
 <20231205184503.79769-1-Nikolai.Kondrashov@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

From: Mark Brown <broonie@kernel.org>

The regmap core and especially cache code have reasonable kunit
coverage, ask people to use that to test regmap changes.

Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 669b5ff571730..84e90ec015090 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18367,6 +18367,7 @@ REGISTER MAP ABSTRACTION
 M:	Mark Brown <broonie@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
+V:	*kunit
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git
 F:	Documentation/devicetree/bindings/regmap/
 F:	drivers/base/regmap/
-- 
2.42.0


