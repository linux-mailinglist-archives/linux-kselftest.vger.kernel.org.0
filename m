Return-Path: <linux-kselftest+bounces-1190-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AF4805DE7
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 19:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E01511F21044
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 18:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B63222EF4;
	Tue,  5 Dec 2023 18:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/zEeB1v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B2DD42
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Dec 2023 10:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701801939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJDFBvdZyMbEhZX9FVgN5LIzIoHtC/1z2fjEWFjKgss=;
	b=B/zEeB1vtRJIYeywXziUySBpaX0n59udq84abFZ4cmcCXdI5x1+dDn1dqsxln7M2a7tVF4
	3v1wzx4LVW/QVRLEl5o5anGiyP9vMWt3BACyxsXfSUKRWF12YPFdQ+5wpNccCi0X2uUATA
	2tOLbpr3Lq/U4k1KoLQyy4VWoZv5J/4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-1VBFy5HhNY-2YmDBl_Eb3g-1; Tue, 05 Dec 2023 13:45:36 -0500
X-MC-Unique: 1VBFy5HhNY-2YmDBl_Eb3g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4F85185A786;
	Tue,  5 Dec 2023 18:45:35 +0000 (UTC)
Received: from ruby.redhat.com (unknown [10.39.192.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1C67D492BE6;
	Tue,  5 Dec 2023 18:45:32 +0000 (UTC)
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
Subject: [RFC PATCH v2 01/10] get_maintainer: Survive querying missing files
Date: Tue,  5 Dec 2023 20:02:57 +0200
Message-ID: <20231205184503.79769-2-Nikolai.Kondrashov@redhat.com>
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

Do not die, but only warn when scripts/get_maintainer.pl is asked to
retrieve information about a missing file.

This allows scripts/checkpatch.pl to query MAINTAINERS while processing
patches which are removing files.

Signed-off-by: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
---
 scripts/get_maintainer.pl | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 16d8ac6005b6f..37901c2298388 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -541,7 +541,11 @@ foreach my $file (@ARGV) {
 	if ((-d $file)) {
 	    $file =~ s@([^/])$@$1/@;
 	} elsif (!(-f $file)) {
-	    die "$P: file '${file}' not found\n";
+	    if ($from_filename) {
+		warn "$P: file '${file}' not found\n";
+	    } else {
+		die "$P: file '${file}' not found\n";
+	    }
 	}
     }
     if ($from_filename && (vcs_exists() && !vcs_file_exists($file))) {
-- 
2.42.0


