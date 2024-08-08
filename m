Return-Path: <linux-kselftest+bounces-15036-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C06394C05F
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 16:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8B7D1F28B74
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 14:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC6718EFC4;
	Thu,  8 Aug 2024 14:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gY05UAfK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AD118F2F6
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Aug 2024 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723129080; cv=none; b=Upq9qqq5dAzio5sXD+Av1ya7qD6pl6WJm4rxERCKhAslkDOvVsu5ailfX3HxDCDSfWNPGBVHOcOOy70TnIUI6MOohV9lh9Dww+zfpMPydz/SRbakZOCocuYJGqe4U5fPGDvBSd1df9xiessBKgMI+ryJNhCnpch/BcdyAxhctaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723129080; c=relaxed/simple;
	bh=C1ZFQfUePYxAYCqmKVS0lTNEqCwkGb0ZLe5aWDLCXns=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NGR+qfVi9vTjdNx4rN45HuRns4fFliM0c+VjNeqZtlQFI2wmyDOeCeZ/ol7cgMtO6MYVT6VT3iupLVmIJfh+4FNNvSAR4/2Cm84KkiQIlAveHMzR1NLDz2poRNuoMwTSFEYAdnk+Y5fdIY/9PW7nzQFiNRnNxZtwH16RqYqTwVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gY05UAfK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723129077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=q1LD+duaEZT3r7HWPwHh97PcJWzAFfeNTcXbwr2Hx5I=;
	b=gY05UAfKTOrmWxKU7Yd299buLdjx2wyyWACN20CThpHOBzr7IRq3y5SFGSdILozJ3oxsvN
	9E7dnXGVUJrtPRiBtFBsmfoah8JEThV8vf63VsqJT7jWq/lu7Tit518swNZ20fS9cRyRpo
	URl+aIkd083YYQFcAXcGk9EFwwiYnF8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-wueuZ8ndOi-seabHp9nYSg-1; Thu,
 08 Aug 2024 10:57:54 -0400
X-MC-Unique: wueuZ8ndOi-seabHp9nYSg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0AD47197700A;
	Thu,  8 Aug 2024 14:57:53 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.45.242.6])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DBADD3000197;
	Thu,  8 Aug 2024 14:57:49 +0000 (UTC)
Date: Thu, 8 Aug 2024 16:57:45 +0200
From: Eugene Syromiatnikov <esyr@redhat.com>
To: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Artem Savkov <asavkov@redhat.com>, linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/alsa/Makefile: fix relative rpath usage
Message-ID: <20240808145639.GA20510@asgard.redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The relative RPATH ("./") supplied to linker options in CFLAGS is resolved
relative to current working directory and not the executable directory,
which will lead in incorrect resolution when the test executables are run
from elsewhere.  Changing it to $ORIGIN makes it resolve relative
to the directory in which the executables reside, which is supposedly
the desired behaviour.

Discovered by the check-rpaths script[1][2] that checks for insecure
RPATH/RUNPATH[3], such as relative directories, during an attempt
to package BPF selftests for later use in CI:

    ERROR   0004: file '/usr/libexec/kselftests/bpf/urandom_read' contains an insecure runpath '.' in [.]

[1] https://github.com/rpm-software-management/rpm/blob/master/scripts/check-rpaths
[2] https://github.com/rpm-software-management/rpm/blob/master/scripts/check-rpaths-worker
[3] https://cwe.mitre.org/data/definitions/426.html

Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 tools/testing/selftests/alsa/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/alsa/Makefile b/tools/testing/selftests/alsa/Makefile
index c1ce39874e2b..0f204da9ea8e 100644
--- a/tools/testing/selftests/alsa/Makefile
+++ b/tools/testing/selftests/alsa/Makefile
@@ -6,7 +6,7 @@ LDLIBS += $(shell pkg-config --libs alsa)
 ifeq ($(LDLIBS),)
 LDLIBS += -lasound
 endif
-CFLAGS += -L$(OUTPUT) -Wl,-rpath=./
+CFLAGS += -L$(OUTPUT) -Wl,-rpath=\$$ORIGIN/
 
 LDLIBS+=-lpthread
 
-- 
2.28.0


