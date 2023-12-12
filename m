Return-Path: <linux-kselftest+bounces-1751-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7E880F866
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 21:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCB261C20DA5
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 20:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA0A65A66;
	Tue, 12 Dec 2023 20:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BocrOrrm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135541FE0
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 12:47:48 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-dbcca990ee9so227918276.0
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 12:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702414068; x=1703018868; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TFmE+BG4/EJDZrVEh/xZNdnTy9FeH/PqMcDgQWjrrOU=;
        b=BocrOrrmkssbhlib9beP9WoA7Z7v3DilEbiPuKkZ0DfrgrwhdlpOi2YYApCMtXQnPh
         kq8Iy6y68vFZ0U7TIstBZjX6W8flf5OY5U8khv/L2/BM3vU7saR8yzpJvVINfFQALyu4
         OoIS5ktLUis8Dbx+Fpv48HB5XmuLJsclrY70tmZaKXDKDlNyKwuMo8b/hbO/zc2dywLW
         9/1CQYUn/gv8//TgomMA6k59lBWZMdBUIskZ9xoEKY87C/WsHUgcadDRuJ5Y32OHWLG2
         tERt3TsFvJEJiIyAWBDjUqAq1o/EkFD5MaF1NE2RKENQ6reSo+hLJKygnrdZOdMSENvq
         43Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414068; x=1703018868;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TFmE+BG4/EJDZrVEh/xZNdnTy9FeH/PqMcDgQWjrrOU=;
        b=SKq12mrAL8iiu0WJrhRPha0QAgiEmgy3ktuBE7PgpXuasHpY+n1zbHcIWkSxEh4UiP
         sAgswbbeHrjEvKdMptnmAs4jgo3iPc2crp9RRIgNp0ATEfZWqWDPaYvkEFKRGB3vRFMV
         vPmPF3qmQ7pQoBK+sRAJ05pgVl2s53YwzT9fYTBKKlpQxuTjTFqFqme6BdBU96NfnVs3
         MgwQdwjVPcpQDKWbvayY7NrsedhhA8MqeWu4E2dq0ki0pz8kEr2HOVz4vAA/R4sm+JRQ
         BqWSl3DHBF8W6kgSsH/8B7Epm9k2Zk1xC6dP0bvY4b2xeQgxTR1kGQw9vE9LeMNetSvj
         YTTQ==
X-Gm-Message-State: AOJu0YwxhqWdmrL7x2hu0LPMDKVbSLd/NTrWxNvLCFkxxJbP70Y0N5Nf
	KBrWISQe6IXQt3ioiFDqW9G5b+z0N8qx+U0OMilIV7MnVDHhH4DP6jf9k/q+5ZipeZUqJDfl4EK
	nQVdB0paXo1Jlaid+CphYac8G1Hy94C+KlmEk0sf9FwZKfx0fB/AK9evpzDPQKkDCyTSABZM=
X-Google-Smtp-Source: AGHT+IEfV9mKSOUMKRt6QzMdx4NjK5Xm4g7Lzg/OSBchtLDS9HiwFFeqtcXo/zBjodXwgzfPibVCMzwJXQ==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a25:d204:0:b0:dbc:cbd9:3cd0 with SMTP id
 j4-20020a25d204000000b00dbccbd93cd0mr566ybg.8.1702414067193; Tue, 12 Dec 2023
 12:47:47 -0800 (PST)
Date: Tue, 12 Dec 2023 12:46:42 -0800
In-Reply-To: <20231212204647.2170650-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231212204647.2170650-1-sagis@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231212204647.2170650-28-sagis@google.com>
Subject: [RFC PATCH v5 27/29] KVM: selftests: Propagate KVM_EXIT_MEMORY_FAULT
 to userspace
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>, 
	Ryan Afranji <afranji@google.com>, Erdem Aktas <erdemaktas@google.com>, 
	Sagi Shahar <sagis@google.com>, Isaku Yamahata <isaku.yamahata@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Peter Gonda <pgonda@google.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Roger Wang <runanwang@google.com>, Vipin Sharma <vipinsh@google.com>, jmattson@google.com, 
	dmatlack@google.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Allow userspace to handle KVM_EXIT_MEMORY_FAULT instead of triggering
TEST_ASSERT.

From the KVM_EXIT_MEMORY_FAULT documentation:
Note!  KVM_EXIT_MEMORY_FAULT is unique among all KVM exit reasons in that it
accompanies a return code of '-1', not '0'!  errno will always be set to EFAULT
or EHWPOISON when KVM exits with KVM_EXIT_MEMORY_FAULT, userspace should assume
kvm_run.exit_reason is stale/undefined for all other error numbers.

Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index d024abc5379c..8fb041e51484 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1742,6 +1742,10 @@ void vcpu_run(struct kvm_vcpu *vcpu)
 {
 	int ret = _vcpu_run(vcpu);
 
+	// Allow this scenario to be handled by the caller.
+	if (ret == -1 && errno == EFAULT)
+		return;
+
 	TEST_ASSERT(!ret, KVM_IOCTL_ERROR(KVM_RUN, ret));
 }
 
-- 
2.43.0.472.g3155946c3a-goog


