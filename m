Return-Path: <linux-kselftest+bounces-170-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FEC7EC9E8
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 18:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F5E1C2095C
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 17:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF1E3C070;
	Wed, 15 Nov 2023 17:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="akYvoXPN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB8D1B8
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 09:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700070741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zkma+ytFECSmUGaVR3H0P8/excTRmPEEewT1e65f88Q=;
	b=akYvoXPN8A7XHK9ZBSBA0L43/Dz98fs/a3rL8JujbAAlD35Jj0VfHJOMharxnCUqrAYVgZ
	MsXybdPck+LzEq8eR3U/jtH03osRlz2EY3mgqVGIoGpJk77SY+sBl5uB8gH/nAvzaeidb9
	M+jUPqaY2bnbYFo5/ElwAWQU6XHbCkY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-X-IRN8qTPlG_KX3opGHxDA-1; Wed, 15 Nov 2023 12:52:18 -0500
X-MC-Unique: X-IRN8qTPlG_KX3opGHxDA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 760498007B3;
	Wed, 15 Nov 2023 17:52:17 +0000 (UTC)
Received: from ruby.redhat.com (unknown [10.39.192.56])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0FB741121306;
	Wed, 15 Nov 2023 17:52:14 +0000 (UTC)
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
Subject: [PATCH 2/3] MAINTAINERS: Require kvm-xfstests smoke for ext4
Date: Wed, 15 Nov 2023 19:43:50 +0200
Message-ID: <20231115175146.9848-3-Nikolai.Kondrashov@redhat.com>
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
 Documentation/process/tests.rst | 32 ++++++++++++++++++++++++++++++++
 MAINTAINERS                     |  1 +
 2 files changed, 33 insertions(+)

diff --git a/Documentation/process/tests.rst b/Documentation/process/tests.rst
index 907311e91ec45..9a9ea3fe65c37 100644
--- a/Documentation/process/tests.rst
+++ b/Documentation/process/tests.rst
@@ -33,3 +33,35 @@ particularly useful:
 
 :Source: A URL pointing to the source code of the test suite
 :Docs: A URL pointing to further test suite documentation
+
+xfstests
+--------
+
+:Summary: File system regression test suite
+:Source: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
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
+:Summary: File system smoke tests
+:Superset: xfstests
+:Docs: https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md
+
+The "kvm-xfstests smoke" is a minimal subset of xfstests for testing all major
+file systems, running under KVM.
diff --git a/MAINTAINERS b/MAINTAINERS
index 2565c04f0490e..f81a47d87ac26 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7974,6 +7974,7 @@ L:	linux-ext4@vger.kernel.org
 S:	Maintained
 W:	http://ext4.wiki.kernel.org
 Q:	http://patchwork.ozlabs.org/project/linux-ext4/list/
+V:	kvm-xfstests smoke
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
 F:	Documentation/filesystems/ext4/
 F:	fs/ext4/
-- 
2.42.0


