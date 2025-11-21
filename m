Return-Path: <linux-kselftest+bounces-46264-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D96C7B43F
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 19:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D7114EB199
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 18:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5F334DB5C;
	Fri, 21 Nov 2025 18:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ttNpkj9T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D9F2E6CD2
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 18:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748882; cv=none; b=lcILhqHT6Sp46aGlct24YOhdYuRHeFvsK65PQP3a53md8NzTFrCzpKbGxxz74IlMnvsps6l2BM/1fPmk5tGC6tivujXlOH/tA6mV7rMR5acTSkFBtxGuDQ37mHjQI020Hw4CDP1Wwg4Ds/7++5VLjquRjNbuuKESEi+9/RTCNlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748882; c=relaxed/simple;
	bh=4jbFW755dBJOKS7c/96o53MFewYxrjS3To1SirYDZ6M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hieZOBUnP9ZMEsWlNcR2lac0BiUymxi7lHqBMKiPFWSvvG9ORZOSUetwJ0+JWo/AoxaLDBYyAmCaTROsK+w9VEq9/1xtwG903oEW3KxqJHbxYvAgam6cYr3fowgdZLbtFbE/xAfajkZruhh8m8Q5VaKwGj6kWBo+fp+cLu+nagA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ttNpkj9T; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7b89c1ce9cfso2580670b3a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 10:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763748880; x=1764353680; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QoH2RYvouNfNzcg9XmRj4HJ+/hSocAJqMJ5WG8meLAE=;
        b=ttNpkj9T+8tU9IZQWaNhAqpogwbZkyql//7P0MeN1nC5nzMilkrPPl4mw9bUkfwjVY
         mCYBTlukOXzCdspsrAKT1ey7onQDpYVdELIFTqYmirkBd886+62mJohoB7qqyHmxJKWs
         n/3lajNawUeNIiZbkF9OneTtuZaqeW7pBaEYYQBJF8lnWpeZLOhR8IOxEIr/mEBXnda0
         D96mKJY6ptCFGGb/jO1yKh6l/TuKVjyXdmt7H4ACnPJaTUPWXTJWiDpNunGiRkEJ1QO4
         wREaH+RQQG9QSAwfPaJgmGtrZEyJmXXBv9HiRIExj2bUDeaqH3Ze0xUjldfvfFm43MjS
         g6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763748880; x=1764353680;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QoH2RYvouNfNzcg9XmRj4HJ+/hSocAJqMJ5WG8meLAE=;
        b=KIe8zB/SQxAqbS3eTuWkx/I84+oMH6Xyd+IDjFvqvCCBfOc6qQrtctbGFbIwNQEpds
         8RjUzzDwiZHRYVvrolQDFJWrmXV7774mKNLlGMlOMyC8yLcX5GwRspgsSE5RYrLHo0ux
         MYPPoI2+n60BUMBKRVIWvUkIiO8fI1j7xOUzz/rbpIt668SvXjsYXMydG5JU8vLCLOlA
         PwfMJ2NxxMcFI7A4MSv4Ul9OmEv3kA7m6EV/Ssxa9MZtcIXiYhLoxvkao6qK8pWNA9eD
         WJP3VZnfq5Om+AgnuhZyrPvfo/Yu1lPWwzhxBvezQaKvGN9CtaHzH35DjONxQdQlBJTW
         7drQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwJj0g/vRRZZwAltJR9Y0ESDtt2OkEoJF4tai8Tx3i0v9V2mWcwNCZlvADfdz1nye9RepvjEboUfBlXY1N3GY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvunnmC5QWxIQZ/olFf8V1Kxh494wxeIxsVOaetMFkx3jpP5yP
	/1EOoBlB7uBHLvfFrjV3sZm88aq2HpInPR+x1S2nKN5goGlPWi8rqPxp2HYO8b6n0/wmmd61lK0
	c9BVNgKMFXZRCKg==
X-Google-Smtp-Source: AGHT+IFYfYykvUE7exbquc/WgJQX81W9GZXkUukUXGA0A/oiKRCw7ky23MadV3qd62uwBzor+3VKId5C5olVdw==
X-Received: from pfbey6.prod.google.com ([2002:a05:6a00:38c6:b0:7ba:e377:7797])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:10d1:b0:77f:4a83:8f9 with SMTP id d2e1a72fcca58-7c58c2a730amr3542935b3a.2.1763748880094;
 Fri, 21 Nov 2025 10:14:40 -0800 (PST)
Date: Fri, 21 Nov 2025 18:14:12 +0000
In-Reply-To: <20251121181429.1421717-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251121181429.1421717-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251121181429.1421717-2-dmatlack@google.com>
Subject: [PATCH v3 01/18] vfio: selftests: Move run.sh into scripts directory
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Alex Mastro <amastro@fb.com>, David Matlack <dmatlack@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Raghavendra Rao Ananta <rananta@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Move run.sh in a new sub-directory scripts/. This directory will be used
to house various helper scripts to be used by humans and automation for
running VFIO selftests.

Opportunistically also switch run.sh from TEST_PROGS_EXTENDED to
TEST_FILES. The former is for actual test executables that are just not
run by default. TEST_FILES is a better fit for helper scripts.

No functional change intended.

Reviewed-by: Alex Mastro <amastro@fb.com>
Tested-by: Alex Mastro <amastro@fb.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/Makefile             | 4 +++-
 tools/testing/selftests/vfio/{ => scripts}/run.sh | 0
 2 files changed, 3 insertions(+), 1 deletion(-)
 rename tools/testing/selftests/vfio/{ => scripts}/run.sh (100%)

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 324ba0175a33..ad7fa4071c20 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -3,7 +3,9 @@ TEST_GEN_PROGS += vfio_dma_mapping_test
 TEST_GEN_PROGS += vfio_iommufd_setup_test
 TEST_GEN_PROGS += vfio_pci_device_test
 TEST_GEN_PROGS += vfio_pci_driver_test
-TEST_PROGS_EXTENDED := run.sh
+
+TEST_FILES += scripts/run.sh
+
 include ../lib.mk
 include lib/libvfio.mk
 
diff --git a/tools/testing/selftests/vfio/run.sh b/tools/testing/selftests/vfio/scripts/run.sh
similarity index 100%
rename from tools/testing/selftests/vfio/run.sh
rename to tools/testing/selftests/vfio/scripts/run.sh
-- 
2.52.0.rc2.455.g230fcf2819-goog


