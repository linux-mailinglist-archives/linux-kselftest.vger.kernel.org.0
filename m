Return-Path: <linux-kselftest+bounces-45691-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBAAC6039C
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Nov 2025 12:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F18E54E3FA6
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Nov 2025 11:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EF5298CB2;
	Sat, 15 Nov 2025 11:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQk7llZh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C6B205AB6
	for <linux-kselftest@vger.kernel.org>; Sat, 15 Nov 2025 11:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763204928; cv=none; b=ptye8MUjmBlCSWU9AXHVRb3ypW957AKY3zLyIz4DH7b+RU8JUNbHcDdrtEu9RsQGoNPMGygqD53Q/Py7Oq0k4/lvWgxMkse70nMM7GAhV25RUZ9SICm43khjcTBq2nYrHDLb/8UjsnQNaTlYSGDl8n9sVqqMO95StnmyDCb0Ejc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763204928; c=relaxed/simple;
	bh=QtvTn81Ua3FPrkbPOmPO0Brx/q079uamkttCqZ3CW1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J9P+hjpfKAuEE2YhzUO87y4Rpy+E85q2FNgZFhtXbd91uY9pVuQX2iFU4To6F7xEGYSDVB2szZX1ixBbad9W0zZ2gZ0mlp0zV8A+AkamZ5m9I4kWS9r+JorW2sxlUGHLb4QbM3PHr3T7eSXFxe1ululAx087Gr/tnvhdRkg31/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQk7llZh; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2980d9b7df5so27839545ad.3
        for <linux-kselftest@vger.kernel.org>; Sat, 15 Nov 2025 03:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763204926; x=1763809726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rDnL4NHaav+5ZUQoJnC9lyriFUqkD8Usoc9H6SDFlGg=;
        b=QQk7llZh8JWGVi90vuDrQ4AFX/S1+4PWCJ32xdlj6yU5W2NDXz/Va/YjvrVzLIAvBh
         zlNN6dtsbdO3rEwkpKiX5VMXwuyhjqcooxiabpYKpKw8BuDsmNq+Mmv3gSmfcSHy59hA
         cM1J9ow0jJgwFtG09bdGVDxaQouzyiO+jd9UCxZm0kOAzXCfb226UN3yIVFJel7Mr8uD
         wIHtLBVQIi32f0hnvY2Er/WrthQ4Ceab6OxVp2rFxtC68PBA4dui+7p5Uffh3fOQlv7f
         Eb8RDcahEU9G0TCDnMNetP4bLXbVnhIPtOMNQJ96d16agZ6JYbd19MTEFSsOGNoWFH5l
         4CgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763204926; x=1763809726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDnL4NHaav+5ZUQoJnC9lyriFUqkD8Usoc9H6SDFlGg=;
        b=sAjL6d4swCRiSHOOgvKv5bt6hR4GbQnnj+6S/CemZMRUg2PKlrxrnK2m+Wma0g/PVO
         WUIQP88qOhDR3k+Q1sfB2y9/2ptRIyaVxeNesZHQzpMdkDmwJFsqr/EOLkqAzG5Cr5iO
         +YKFfGyyLK2UeGf+kNAd/fKSCvBqnMdI+AZ4VsOqD0+2E0m5zG3+NdIRz6liCWUfStV2
         V0uuTzLlQ/8JTl4VGm7E3ic7lIaIk8Ewo6W6snn76W/fVnCzw8BZMqicgX5O5rJ9galD
         KttAYlFiloP1nvp0JGoi4J1JHtHlNnvI3Zo43x13fFQi+mPJwy2NdiuDR19hb/SOaeQ+
         apZA==
X-Forwarded-Encrypted: i=1; AJvYcCUtklguyi+q5fQeV1+FhOspw/0Ei2Dt3G9zmcN9XbJQmXzrKALnGJnS8QrCMn7y/l6SXbUnSNCIBcorcH2HKnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjTiUAA5R6gbruBP7wnbnD0LuCa1WyEsEmMZ89qBmcDFnm6Esv
	zCIrJDRu64a53PIkpez3Ldwa7HQwB0KtB5YIv0c9o64y5UdbFPylB+Nu
X-Gm-Gg: ASbGncs6X8Z5ASOhHZdNozPYRNFEdyF3/KXJ58PFOXNUnVOSVwVRsToZi2+nv4TT1QF
	ITAHdINBhltZ7H+gAHTPiMDh9TW5yzX5siuDuObdlmulrNjgX0gAF8zk+IUXHWRxf0ytA6LICfv
	OLZkGrtoRuFLuafyu/f9d13PK/h/uErILjiZ/z8r+7BqGeYhVxYNyQ8QpjeFAj/93usMfINA4kd
	utvoKIPfafFNyhlow+JZGS1F2g7vtudOZ9Pqn0uqpZAerEaGdY86uMbWxFZQfRIaR6QcmSQcoZb
	Z/0t9+YQN4txnhPy2SP5mrDNQGyfvAn8DWD1Wy+8YsPx6tNRLqW9WlsmvsrQxhuqDMcz/YAj9Rk
	iQLTitfaEHOh2VQx6bK3xZRjAdjD+CbQ4knnDdJnROWEQlVHqQ1laXo6mwlQewmi2kGLp8txzfI
	YR3xSJtHn/0lEFKqusxg0=
X-Google-Smtp-Source: AGHT+IFIJ8mHDNSkemnB2t7aJI0eDgMICqUE0flQlOmzI1znoGOCkGrq0gi0iwMEPY6C4gHGcgK06A==
X-Received: by 2002:a17:903:196b:b0:267:f7bc:673c with SMTP id d9443c01a7336-2986a752a74mr61755755ad.44.1763204925585;
        Sat, 15 Nov 2025 03:08:45 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2bed5asm83839075ad.88.2025.11.15.03.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 03:08:45 -0800 (PST)
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@vger.kernel.org,
	Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Subject: [PATCH] KVM: selftests: Include missing uapi header for *_VECTOR definitions
Date: Sat, 15 Nov 2025 16:38:29 +0530
Message-ID: <20251115110830.26792-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The exception vector constants CP_VECTOR, HV_VECTOR, VC_VECTOR, and
SX_VECTOR are used in ex_str(), but the header that defines
them is not included. Other exception vectors are picked up through
indirect includes, but these four are not, which leads to unresolved
identifiers during selftest builds.

    lib/x86/processor.c: In function ‘ex_str’:
    lib/x86/processor.c:52:17: error: ‘CP_VECTOR’ undeclared
    lib/x86/processor.c:53:17: error: ‘HV_VECTOR’ undeclared
    lib/x86/processor.c:54:17: error: ‘VC_VECTOR’ undeclared
    lib/x86/processor.c:55:17: error: ‘SX_VECTOR’ undeclared

These vector definitions live in:

    tools/arch/x86/include/uapi/asm/kvm.h

Add the missing include the userspace API exception vector constants.

Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---
 tools/testing/selftests/kvm/lib/x86/processor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index b418502c5ecc..fb589f07f2a4 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -4,6 +4,7 @@
  */

 #include "linux/bitmap.h"
+#include "uapi/asm/kvm.h"
 #include "test_util.h"
 #include "kvm_util.h"
 #include "pmu.h"
--
2.51.1


