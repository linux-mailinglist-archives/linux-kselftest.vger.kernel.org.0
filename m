Return-Path: <linux-kselftest+bounces-7484-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6943289DAD3
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 15:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A9161C208B2
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 13:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3654B12FF61;
	Tue,  9 Apr 2024 13:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TEGUOZZ5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26D512FB2F
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Apr 2024 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712670017; cv=none; b=jdiNIM0cLnKmNlBVYlWW4JzTMlvko/sENRdbOu0zy3WBghwK3QXMzWS8ijRFueMuTfJvfAWCQ+MuNzZqkb1CwmerbAjfUBTEXeVAGPE3MoT2QL/V4fxdlXqvJPHBwnus1fowtwcHnhv8oVFtf7tHgPpo/9X3QelheG62uh+oSo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712670017; c=relaxed/simple;
	bh=8YAynhoBcTZH25sdLVIb9gPxNYS9bVlziuWqHn3N3EE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CY8MbLsk3jUt0lJ9JKJZI48QGb+07WroJJZvoIOYaN8WeUoouDVpZDFE7BxP3aQM6mvcRCn5eMDIZ7TquT6VEfqTwlIXeta33wC1QdPffZylQiMHwwYfnmLh3+DAZn09T7j62/hMgJeF0aHnIVThL1QR+O4S9wqVYpf6SDuzXCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pgonda.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TEGUOZZ5; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pgonda.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6ea7f05b543so4063399b3a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Apr 2024 06:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712670015; x=1713274815; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uMEfBjeMsB/RLCKigMRUoYsxAnS7VrosZGuO6YiswGs=;
        b=TEGUOZZ5SFJr7IV9lSgRfIUHw0VwRgQ2Q4MMll7rzmMFLWAX2m8VDxQxY39+SQXd6i
         UHDlCgdHDuxHddLC6GtWWlbctFnizXjPw7V90SnxdsU/FLD+XT22koVCFlgk3XBqjGd3
         ZUPLu/lGGo6vG0IVzRbSxUyLMpuC6rm0rviKqv7p5GL86ooQ8bV38PKLnB4U43u8Hjgh
         p149YnqYgU7/qLXkzSbq3BWPlLPq4oocK5J2NLxsnMbaxN4prEpL5sawzbHFF38WLtzI
         k4vzjPoq4jzryBQFByWIAifhWxFeIt4TZHBQz03MXDOjQt3NGCJsZ8V0Zm1nE3SQ84Pg
         PtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712670015; x=1713274815;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uMEfBjeMsB/RLCKigMRUoYsxAnS7VrosZGuO6YiswGs=;
        b=Kxit4XjGrCKPDU0TyIEjqnAJ0TL7FRCDizV+5h1QcBPt6jN1DVWhd7vzLsQ36rlKJz
         T0tJHlNiLX653fD5o3sRVKYR3TLbEi4Yio6nEuYdiZEz5iu3z7FHFuleXRT8GxjjLinJ
         RSrAJmRsalZsjO/C3xgUxVBKOiK2ZXKiFe9H160sotA69ZO498Ip+D22u0JBLlNhL/5m
         5Diwz3GbMBP84i+l2HNYaXF2kQiRsW1W1Gr56i4n88D2P+oqh6OW1CLoUg0jFnSJ36CE
         0/zpICgDUNhQIcB2pEefwhZ8g0KC5TX543/uJpl3tkorTFvpASpJp2x26UOCxRzg0m2a
         /XCg==
X-Forwarded-Encrypted: i=1; AJvYcCWgLfmw5ALRjsAHuspLNkcfoj3Q58CC1Ws2L0ImRkr0fqIfLVKNmqXatmzKS+6IQkcBiWoTWUmtwB0jkf9llxysMJG8u4I6PvMsNKEWIJ8R
X-Gm-Message-State: AOJu0YyXIdiAzBbblniMvIZW7p8jBZbjlkXOAhBeuTUYnHhMPFpN/+w/
	uvj+t9QMVx45YT6NDjrNT/UDFEp/srj0e/akCmZF6AvdAdn90nSKBAcTk0HfD0xNQiwnCkIntFv
	9nA==
X-Google-Smtp-Source: AGHT+IGRVEIRxXQ5a79kYy7qEqv4mC1lhc2zIbiG+1EbVkZiFBFly1NL20PHEOj07ifmpp84iSHWkw0p5zY=
X-Received: from pgonda1.kir.corp.google.com ([2620:0:1008:15:661d:897e:ea86:704d])
 (user=pgonda job=sendgmr) by 2002:a05:6a00:1828:b0:6ea:e2d9:f2af with SMTP id
 y40-20020a056a00182800b006eae2d9f2afmr1093312pfa.0.1712670014924; Tue, 09 Apr
 2024 06:40:14 -0700 (PDT)
Date: Tue,  9 Apr 2024 06:39:53 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240409133959.2888018-1-pgonda@google.com>
Subject: [PATCH 0/6] Add initial GHCB support for SEV-ES selftests
From: Peter Gonda <pgonda@google.com>
To: pgonda@google.com, seanjc@google.com
Cc: linux-kernel@vger.kernel.org, Vishal Annapurve <vannapurve@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Carlos Bilbao <carlos.bilbao@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Adding GHCB support for selftests. Very similar code to the ucall
functionality, I didn't refactor anything common out since I was unsure
with just two instances that is required. If pulling out common code
between those two is preferred please let me know. The series only adds a
single usage of the GHCB which is a special outsb GHCB exit to allow for
passing the 64-bit ucall pointer. In future series we can test more GHCB
functionality of KVM. I'd like to base some SNP smoke tests off of this
and the current SEV selftest work.

base-commit: 40e09b3ccfacc640d58e1e3d6b8f29b2db0a9848

Cc: Vishal Annapurve <vannapurve@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Carlos Bilbao <carlos.bilbao@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Michael Roth <michael.roth@amd.com>
Cc: kvm@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Peter Gonda <pgonda@google.com>

Peter Gonda (6):
  Add GHCB with setters and getters
  Add arch specific additional guest pages
  Add vm_vaddr_alloc_pages_shared()
  Add GHCB allocations and helpers
  Add is_sev_enabled() helpers
  Add ability for SEV-ES guests to use ucalls via GHCB

 tools/testing/selftests/kvm/Makefile          |   2 +-
 .../selftests/kvm/include/kvm_util_base.h     |   4 +
 .../selftests/kvm/include/x86_64/sev.h        |   7 +
 .../selftests/kvm/include/x86_64/svm.h        | 106 +++++++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c    |  22 ++-
 .../selftests/kvm/lib/x86_64/processor.c      |   8 +
 tools/testing/selftests/kvm/lib/x86_64/sev.c  | 149 ++++++++++++++++++
 .../testing/selftests/kvm/lib/x86_64/ucall.c  |  17 ++
 .../selftests/kvm/x86_64/sev_smoke_test.c     |  22 +--
 9 files changed, 313 insertions(+), 24 deletions(-)

-- 
2.44.0.478.gd926399ef9-goog


