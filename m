Return-Path: <linux-kselftest+bounces-9167-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 205F18B8349
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 01:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0FBA281BBE
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 23:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A88200104;
	Tue, 30 Apr 2024 23:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E4eHiHkw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1660E1C2334
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Apr 2024 23:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714521101; cv=none; b=ss643kW6rvg1wifv0KIOiXepgaG1j+XPeDVY4yMLzmIo/UH3Tld3VOYzrR7lb2I2p2Ka+3Br/wdQeKhWhqSoFCBisXR33iYqbtM0c5mZyET9lvqvZ27BjYnahmdvadCh/+X1oqozZeozStkEqClLHJBH7WW3LdigTmkKi69cQBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714521101; c=relaxed/simple;
	bh=D4RXcFdCF4K+k0y+RB2kHekGy6icDi6EgmaQjDFUewc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B71JUUdKSiR6s3BUXbEBe4QLh9sKgtOGZHMRXZ0XQiShxCeXSodVJcWEB09RCPOpfU4jZ61meUkiWglbWPXjW5j4GDNY7yfzT3aARgyj4YKcn16cI0OQAv0Qv5OCiD1aORgHfqhqKtfVSIUYU6Z+s3/TXKA7rfUqDqRQfNTMhE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E4eHiHkw; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5f803c1693aso6805781a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Apr 2024 16:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714521099; x=1715125899; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D4RXcFdCF4K+k0y+RB2kHekGy6icDi6EgmaQjDFUewc=;
        b=E4eHiHkwXmvT12PgrwpkLzPfIMhZGpB3yEvGktCAQKQH6AKioW8quzwUuhhSyDxFZR
         VmKVZInAwOBKM1K8T7euqOT7vR5Cz07O1Ni4Stl26Q7Z6PkPheNXxo599djVYQ7J78S3
         Mmn6BK8j8wTpu/+qF98hqBQEexKvH+4J+nlfVAiqjP2jLqY1lLz67BumekaGoRM7OSua
         QhuUYS/ToDjvMxZtQLppXyPRMFsqXTk/lHzIpPjSVmIJ2iQ0tkJUOpKn3A+flaE9O3/S
         TawjMnEY35uvA42rTFhhr9mlzSFyVLBsDetcwGxvUTfF6c+zL3Nf2SSTYaJ4SBoINu3q
         A1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714521099; x=1715125899;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D4RXcFdCF4K+k0y+RB2kHekGy6icDi6EgmaQjDFUewc=;
        b=LpdHHeUGS/MYUFMwMmVvGD3PgRv7cRDElmZKkYFUYcJah8lvrjI8m8M4PTrp4+hrWf
         S8ZjOS8RKARItyK9n22mylYBMILc5phCUL7HTo50QaIdJIvx344PWa3lhaPmo4b69c3G
         FD6jCboAKTxiBLvZgccFwdj7TIhOF41vbBsWoVf0jb3xNdKtTp3WUAKD2FWGxqvheDfs
         wc1OWfdKVeo/ciYy5lL5LAIdvcVtd26W/AfQUQyAF1xNzdaW+l9Vyj1irRC96EImiZKc
         foPgbWzHcLNHko0NP3ZSva6cL6SxuqBoRC4XbI8I0UxWKV98jfJ+oGf0udLl/ciAxK5Z
         bJKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs8GNYYNxSGevGyoY2k8Zg5d3z2tA0ZT5F/syug3YozgEEEMsOh+i6NJpWsvEabzmXdywXUQjUCAKtxhGdnQKG2VAQhhhyC0km35XXNaik
X-Gm-Message-State: AOJu0Yw6UkuF05vRCoFycTlJY5pC0GqyLD27kn6TbOIeHF1/fAirYpda
	+ygTziXQgqNHDFTwQM44Drrj66nlobhbiHumOX4tUMLg9HLlkFsCWw6AYDyKXayyd67cjzcmkqT
	kEA==
X-Google-Smtp-Source: AGHT+IHFexsRWV/l6g61+fcJ1FS4On2NzfgmRGaO6qc5XtBy09A9jgk6syIBuUu/8hQIpY0RuJdzwtz+xEQ=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a02:696:b0:5db:edca:d171 with SMTP id
 ca22-20020a056a02069600b005dbedcad171mr25940pgb.6.1714521098807; Tue, 30 Apr
 2024 16:51:38 -0700 (PDT)
Date: Tue, 30 Apr 2024 23:50:14 +0000
In-Reply-To: <20240430235057.1351993-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240430235057.1351993-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240430235057.1351993-6-edliaw@google.com>
Subject: [PATCH v1 05/10] selftests/nci: Compile with -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Bongsu Jeon <bongsu.jeon@samsung.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Edward Liaw <edliaw@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-sound@vger.kernel.org, 
	linux-input@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-sgx@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

809216233555 ("selftests/harness: remove use of LINE_MAX") introduced
asprintf into kselftest_harness.h, which is a GNU extension and needs
_GNU_SOURCE to either be defined prior to including headers or with the
-D_GNU_SOURCE flag passed to the compiler.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/nci/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nci/Makefile b/tools/testing/selftests/nci/Makefile
index 47669a1d6a59..f615f5d71f7f 100644
--- a/tools/testing/selftests/nci/Makefile
+++ b/tools/testing/selftests/nci/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-CFLAGS += -Wl,-no-as-needed -Wall
+CFLAGS += -Wl,-no-as-needed -Wall -D_GNU_SOURCE
 LDFLAGS += -lpthread

 TEST_GEN_PROGS := nci_dev
--
2.45.0.rc0.197.gbae5840b3b-goog


