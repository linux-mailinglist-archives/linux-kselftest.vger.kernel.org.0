Return-Path: <linux-kselftest+bounces-172-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 560A87EC9EA
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 18:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB354B2099A
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 17:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB8B3FB0F;
	Wed, 15 Nov 2023 17:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sag0OzX5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E422127
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 09:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700070743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OG/PdxLPzgrb2SSqLq85wNnPv1wHigzKlm1PKA/CjnI=;
	b=Sag0OzX5Nz3cSUqbAdodwmnbvTTOlKGR89n+VTXmyJ1AEKdtMfmPtFRxCXsn9E6bJ3iOk9
	d9jrlYV8yTPNE196CcVSIpDlcT6gQsJrfLA1rBSSM4uTqlGtgnOdySKOP9AhDPikpz0MO+
	dbNa3WMBbveUAGCaOGS7+tpOUacvVRk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-1_fhHc8YNcmXv39uhnoUYw-1; Wed, 15 Nov 2023 12:52:21 -0500
X-MC-Unique: 1_fhHc8YNcmXv39uhnoUYw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C039D834FC6;
	Wed, 15 Nov 2023 17:52:20 +0000 (UTC)
Received: from ruby.redhat.com (unknown [10.39.192.56])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B96FA1121306;
	Wed, 15 Nov 2023 17:52:17 +0000 (UTC)
From: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
To: workflows@vger.kernel.org,
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
Subject: [PATCH 3/3] MAINTAINERS: Require kunit core tests for framework changes
Date: Wed, 15 Nov 2023 19:43:51 +0200
Message-ID: <20231115175146.9848-4-Nikolai.Kondrashov@redhat.com>
In-Reply-To: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
References: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Signed-off-by: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
---
 Documentation/process/tests.rst | 13 +++++++++++++
 MAINTAINERS                     |  1 +
 2 files changed, 14 insertions(+)

diff --git a/Documentation/process/tests.rst b/Documentation/process/tests.rst
index 9a9ea3fe65c37..56a7911f69031 100644
--- a/Documentation/process/tests.rst
+++ b/Documentation/process/tests.rst
@@ -65,3 +65,16 @@ kvm-xfstests smoke
 
 The "kvm-xfstests smoke" is a minimal subset of xfstests for testing all major
 file systems, running under KVM.
+
+kunit
+-----
+
+:Summary: The complete set of KUnit unit tests
+:Command: tools/testing/kunit/kunit.py run --alltests
+
+kunit core
+----------
+
+:Summary: KUnit tests for the framework itself
+:Superset: kunit
+:Command: tools/testing/kunit/kunit.py run --kunitconfig lib/kunit
diff --git a/MAINTAINERS b/MAINTAINERS
index f81a47d87ac26..5f3261e96c90f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11626,6 +11626,7 @@ L:	linux-kselftest@vger.kernel.org
 L:	kunit-dev@googlegroups.com
 S:	Maintained
 W:	https://google.github.io/kunit-docs/third_party/kernel/docs/
+V:	kunit core
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git kunit
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git kunit-fixes
 F:	Documentation/dev-tools/kunit/
-- 
2.42.0


