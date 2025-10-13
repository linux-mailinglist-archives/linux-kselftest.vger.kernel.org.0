Return-Path: <linux-kselftest+bounces-42997-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A36CFBD4210
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 17:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4F85A34F0F3
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 15:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFC930DD33;
	Mon, 13 Oct 2025 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VbQxsWiy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EA23093C9
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Oct 2025 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368451; cv=none; b=hF/Pd++Ju39EM01ByJ18Dtk81CxVmtmkLLCIqCHwTSjsu94vuUNck7BYbABouUZszUofx5laLi/O2dJuxduRrdOmUImmB0D1u/OlqjKpi+mSLzDGOv5pMoeKYaGw7TKEMdQ7qr41eew4e+UZT2PJpzeLlMxSlmvZjugman3I5jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368451; c=relaxed/simple;
	bh=+lDhQfO7V28U5h5cFY1SpmGreNn0Wv7q3JC+Ta4qqjU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a46jAcUckqsssyneGoc+Xe4uX0Ucj6CSSEy24nO6xrm2PkwpK1STIkzBGMOuXBkN/BBG6sXOQlo+GuCGuMxn4NZLga+cuoM3xxK11TMoo+QUC8IcGbi/P0+JPshZBSuuPq+b0oQGhdeLQVrTf87rOf0EXh8IGQDhl2PKRHaD+9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VbQxsWiy; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e41c32209so23492025e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Oct 2025 08:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760368447; x=1760973247; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cGDDhoVb2UvH/TA1vgttd7Mn5QwfAy9xVEM4QZu3Sb0=;
        b=VbQxsWiy2iu1NsojBLJmyvDP1SPud0uJfJNouRo7N9aCUlsfBLtcZC7pVsH8uefGdM
         Z9pfQzuqZW96rpjEPxPcKirYxUep2Yq1jBvRYwrkl5rY4o94nk64J1oj0kc8Trd6cqEB
         +9qncKaipgSuD/71LQP9yTZRo7RzqcHi2W3X6ryGo2lXRoyNvOJ5UR/hG5Wr+zBaF7Cj
         JMnqGP1LA5DPqtHnPEMd9Xeg7EE3s0z8EypvyXkk3rPr+Jqwbxue9MiYtzX809HyxwVe
         UdOaG3k3RfnXp1imExzE1lyAbhwPRI+fkou4CJE4f4vNGtZoaBZaklVNfBy9COKszPZh
         bUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760368447; x=1760973247;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cGDDhoVb2UvH/TA1vgttd7Mn5QwfAy9xVEM4QZu3Sb0=;
        b=YZ9VmucKMHTMOWNhLgwFOwLY94/hnQpum54MqO79dkYt4T4pIVQqB8dDA8faDiZSYN
         xg3IPtB0ICB/Shj1EixF6qTONgl6sWrEF11sxMDVHTn/LkYLm1UTGC3SvkgN4cWS7s4Z
         FuqjzJ4WAuUp8MzBzAAzvzJmP8g78VXgg9f2benbKHg0Ua98pRG4va4jt8oRqSk/TSdV
         flN1oKnEpU0V2BTYLUyGuHOlI1Fxll6DPuJG05RqWHhO0mAg0/5hCtk/pOaHZFVisT+3
         XiPXNGSdiv91ccNSTW8gDAmUw/IeIqWDZHYQml9NrxvjpU5ZmaSLmRwLth8QnTqG4Ftj
         CbXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhlCbY/SM3n2pWMIRaHoAGhK1U6755S9Q5PFbH+Yvjt9J4oc6FILEkA8iSMi45qodWGFmkus134emoVwSIKlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmmBSATaoev2CGXiCTXu8r5mIgu4NJvoJtf+QM9V5qtub82qlb
	sNTsaugtohsJFBafOTa7Zj5Zn2+TMaIin387GB2be+aI1oPLMtiWTWqzhtPRUt0tclQJAu39bUU
	NQ5PUjqlw5KAh4w==
X-Google-Smtp-Source: AGHT+IEweTCIAoPBJTGv9sNgJ5ITUY2c9g3SgeMzT1r+mLrP4s3EpEnW/lRyaiHSxsI9RuUdBtXz2FoFIx+xzg==
X-Received: from wmga6.prod.google.com ([2002:a05:600c:2d46:b0:458:bdde:5c9b])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:41f3:b0:46f:c1f4:15a9 with SMTP id 5b1f17b1804b1-46fc1f416f2mr43380555e9.27.1760368447270;
 Mon, 13 Oct 2025 08:14:07 -0700 (PDT)
Date: Mon, 13 Oct 2025 15:13:54 +0000
In-Reply-To: <20251013-l1tf-test-v1-0-583fb664836d@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013-l1tf-test-v1-0-583fb664836d@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20251013-l1tf-test-v1-1-583fb664836d@google.com>
Subject: [PATCH 1/2] selftests: fix installing nested TEST_GEN_MODS_DIR
From: Brendan Jackman <jackmanb@google.com>
To: Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>
Cc: Alexandra Sandulescu <aesa@google.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

Currently all users of TEST_GEN_MODS_DIR set it to a single-element path
like "test_modules". This means that the $(notdir) call in specified to
be a nop.

However in a subsequent patch a user will be added that needs to nest
the module directory under an arch-specific subdirectory, which means
this $(notdir) breaks the modules installation. So remove it.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/lib.mk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 5303900339292e618dee4fd7ff8a7c2fa3209a68..787032a66bd5daf8e6c9d00de1df3773901364fb 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -166,7 +166,7 @@ define INSTALL_RULE
 	$(eval INSTALL_LIST = $(TEST_CUSTOM_PROGS)) $(INSTALL_SINGLE_RULE)
 	$(eval INSTALL_LIST = $(TEST_GEN_PROGS_EXTENDED)) $(INSTALL_SINGLE_RULE)
 	$(eval INSTALL_LIST = $(TEST_GEN_FILES)) $(INSTALL_SINGLE_RULE)
-	$(eval INSTALL_LIST = $(notdir $(TEST_GEN_MODS_DIR))) $(INSTALL_MODS_RULE)
+	$(eval INSTALL_LIST = $(TEST_GEN_MODS_DIR)) $(INSTALL_MODS_RULE)
 	$(eval INSTALL_LIST = $(wildcard config settings)) $(INSTALL_SINGLE_RULE)
 endef
 

-- 
2.50.1


