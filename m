Return-Path: <linux-kselftest+bounces-1196-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96445805DEE
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 19:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6FE41C21077
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 18:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A555F1FC;
	Tue,  5 Dec 2023 18:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e2b2rfKP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F551B8
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Dec 2023 10:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701801957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Tw8Nu25Hq0JaUs0Dry8PKef5rI7lNs3YX2VOY3hQBs=;
	b=e2b2rfKPxxJF0cH8zsdUoQ7IiDfT9fB0VKTj/MMoNib3yXmN+gYezkW2htCZPpxTMqwTaA
	uzpWfyVX8p18FqG3fExmEt31I39lIiD7oVOxhil98LyEV0wn6dV7JKanKMuqOY35IH6BB5
	0w4mQnN/iQYsKN4oWWJd6dQ43LGA2bE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-kXUIXm0QOPuWl1gHUTkQtA-1; Tue, 05 Dec 2023 13:45:54 -0500
X-MC-Unique: kXUIXm0QOPuWl1gHUTkQtA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D9A285A58B;
	Tue,  5 Dec 2023 18:45:53 +0000 (UTC)
Received: from ruby.redhat.com (unknown [10.39.192.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 811BB492BE6;
	Tue,  5 Dec 2023 18:45:50 +0000 (UTC)
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
Subject: [RFC PATCH v2 07/10] MAINTAINERS: Propose kvm-xfstests smoke for ext4
Date: Tue,  5 Dec 2023 20:03:03 +0200
Message-ID: <20231205184503.79769-8-Nikolai.Kondrashov@redhat.com>
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

Propose the "kvm-xfstests smoke" test suite for changes to the EXT4 FILE
SYSTEM subsystem, as discussed previously with maintainers.

Signed-off-by: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
---
 Documentation/process/tests.rst | 32 ++++++++++++++++++++++++++++++++
 MAINTAINERS                     |  1 +
 2 files changed, 33 insertions(+)

diff --git a/Documentation/process/tests.rst b/Documentation/process/tests.rst
index 4ae5000e811c8..cfaf937dc4d5f 100644
--- a/Documentation/process/tests.rst
+++ b/Documentation/process/tests.rst
@@ -39,3 +39,35 @@ following ones recognized by the tools (regardless of the case):
           (even if only to report what else needs setting up)
 
 Any other entries are accepted, but not processed.
+
+xfstests
+--------
+
+:Summary: file system regression test suite
+:Source: https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
+:Docs: https://github.com/tytso/xfstests-bld/blob/master/Documentation/what-is-xfstests.md
+
+As the name might imply, xfstests is a file system regression test suite which
+was originally developed by Silicon Graphics (SGI) for the XFS file system.
+Originally, xfstests, like XFS was only supported on the SGI's Irix operating
+system. When XFS was ported to Linux, so was xfstests, and now xfstests is
+only supported on Linux.
+
+Today, xfstests is used as a file system regression test suite for all of
+Linux's major file systems: xfs, ext2, ext4, cifs, btrfs, f2fs, reiserfs, gfs,
+jfs, udf, nfs, and tmpfs. Many file system maintainers will run a full set of
+xfstests before sending patches to Linus, and will require that any major
+changes be tested using xfstests before they are submitted for integration.
+
+The easiest way to start running xfstests is under KVM with xfstests-bld:
+https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md
+
+kvm-xfstests smoke
+------------------
+
+:Summary: file system smoke test suite
+:Superset: xfstests
+:Docs: https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md
+
+The "kvm-xfstests smoke" is a minimal subset of xfstests for testing all major
+file systems, running under KVM.
diff --git a/MAINTAINERS b/MAINTAINERS
index 3ed15d8327919..669b5ff571730 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7978,6 +7978,7 @@ L:	linux-ext4@vger.kernel.org
 S:	Maintained
 W:	http://ext4.wiki.kernel.org
 Q:	http://patchwork.ozlabs.org/project/linux-ext4/list/
+V:	*kvm-xfstests smoke
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
 F:	Documentation/filesystems/ext4/
 F:	fs/ext4/
-- 
2.42.0


