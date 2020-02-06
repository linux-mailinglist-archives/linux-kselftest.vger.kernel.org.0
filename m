Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50A85154076
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2020 09:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgBFIk1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Feb 2020 03:40:27 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52229 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727768AbgBFIk1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Feb 2020 03:40:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580978426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=uBDHAS9jO7wL9Q7uIyEUt2jbyKsq10Ez0hgJ+7Ofl5s=;
        b=T4rCd5TmVu/W7yc5PhzRR3S0z0WPhBINVd2H3+JxjbCt46wbsY2jasNnDpo97MwZ2iXHsZ
        BQADfXZqKUM7MjJjO+rr5HNGXPrlum/EYlUhGa7Z/h/AlT/Y4RtiHn6jvEgRIGTI6qXCFt
        qHR6UgUSG1T2GraDrJM+10oM02LjUqk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-QcwTXla6Mi2N2O6wbcztMg-1; Thu, 06 Feb 2020 03:40:24 -0500
X-MC-Unique: QcwTXla6Mi2N2O6wbcztMg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 082978010D6;
        Thu,  6 Feb 2020 08:40:23 +0000 (UTC)
Received: from griffin.upir.cz (ovpn-204-182.brq.redhat.com [10.40.204.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 593148DC2C;
        Thu,  6 Feb 2020 08:40:19 +0000 (UTC)
From:   Jiri Benc <jbenc@redhat.com>
To:     linux-kselftest@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH] selftests: allow detection of build failures
Date:   Thu,  6 Feb 2020 09:40:00 +0100
Message-Id: <9929e231f4a0b14e8fd86a0debbee730320b531d.1580978204.git.jbenc@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit 5f70bde26a48 ("selftests: fix build behaviour on targets' failures")
added a logic to track failure of builds of individual targets. However, it
does exactly the opposite of what a distro kernel needs: we create a RPM
package with a selected set of selftests and we need the build to fail if
build of any of the targets fail.

Both use cases are valid. A distribution kernel is in control of what is
included in the kernel and what is being built; any error needs to be
flagged and acted upon. A CI system that tries to build as many tests as
possible on the best effort basis is not really interested in a failure here
and there.

Support both use cases by introducing a FORCE_TARGETS variable. It is
switched off by default to make life for CI systems easier, distributions
can easily switch it on while building their packages.

Reported-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Signed-off-by: Jiri Benc <jbenc@redhat.com>
---
 tools/testing/selftests/Makefile | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 5182d6078cbc..97fca70d2cd6 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -74,6 +74,12 @@ ifneq ($(SKIP_TARGETS),)
 	override TARGETS := $(TMP)
 endif
 
+# User can set FORCE_TARGETS to 1 to require all targets to be successfully
+# built; make will fail if any of the targets cannot be built. If
+# FORCE_TARGETS is not set (the default), make will succeed if at least one
+# of the targets gets built.
+FORCE_TARGETS ?=
+
 # Clear LDFLAGS and MAKEFLAGS if called from main
 # Makefile to avoid test build failures when test
 # Makefile doesn't have explicit build rules.
@@ -148,7 +154,8 @@ all: khdr
 	for TARGET in $(TARGETS); do				\
 		BUILD_TARGET=$$BUILD/$$TARGET;			\
 		mkdir $$BUILD_TARGET  -p;			\
-		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET;	\
+		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET	\
+				$(if $(FORCE_TARGETS),|| exit);	\
 		ret=$$((ret * $$?));				\
 	done; exit $$ret;
 
@@ -202,7 +209,8 @@ ifdef INSTALL_PATH
 	@ret=1;	\
 	for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
-		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET INSTALL_PATH=$(INSTALL_PATH)/$$TARGET install; \
+		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET INSTALL_PATH=$(INSTALL_PATH)/$$TARGET install \
+				$(if $(FORCE_TARGETS),|| exit);	\
 		ret=$$((ret * $$?));		\
 	done; exit $$ret;
 
-- 
2.18.1

