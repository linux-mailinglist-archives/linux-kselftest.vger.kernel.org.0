Return-Path: <linux-kselftest+bounces-28747-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1210DA5C25F
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 14:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998AF189260B
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 13:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381D32580C0;
	Tue, 11 Mar 2025 13:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RVRagUag"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0F525743F
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741699123; cv=none; b=Xe8wSrdF0gBAaBm5dw7rcyWuRXOOTBGBdwns1J7fpUM0vMEXnAtUE/W9vCLwuba22Vg7pSNFP84CEdLQopkgix+1tBH0qcxMcWvjgudPX9vKhc87DQeOL3DY9IX5AAnZVIO4JVMIfnDQPPOEoktjPeHX02kHrcvoG5aA45DCA4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741699123; c=relaxed/simple;
	bh=cpB8G5qu+8qB5CaAmCrhUFZfkRWT/4ipT85Ja0ySsMc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lMkAxjZ9ghAjr/MxBNdj5hZgsuYauurmauIWrpDjuDZ4Cudw9IPDlg3TWVyeL90TxAcfmVQiKIuZmqazohumLXgVIQUZj8QCC1XTZce3RVS6Hramj3XMJDQYkKYndJncY/2fveRvjBcmrIuZJQTX9j4AVhwrzDsTun5fAQIBO/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RVRagUag; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43ced8c2eb7so20519665e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 06:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741699120; x=1742303920; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AK0S7bcFsX0odpC5RGhRJMkWaOy0j3srCbmbQDGiiBc=;
        b=RVRagUag7pOLcuZaLduo9a8ik0O+cCOy+ksP98v6w3foNhEejsY7lomibuB1dOzPOv
         B/2agTO6Xv4f1UceU8u22GOEDCt/Su0ToFd7fmHZyF3Nou/aO8TLUBG0X36O4LsyBEwD
         W7IuGpdsAqr3L9LIQMBlQbZcnS9Kn4RjO9Fu/aosnt4oxl0rZN3Tko99wdB9hCnO+2nF
         lqYq1Ep96mzpxVctBwGmPrCkM9RjlWIb9IA4JjE1jOGMi5Z1WXqy6ky54EYv/3aaCIJe
         Jy1XItIpCxdFSnyHE0XAPHLlRRTQ9YA0B1r3cViip5l73r0lYlwHO8Vkm4zhp9sy9lnd
         P7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741699120; x=1742303920;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AK0S7bcFsX0odpC5RGhRJMkWaOy0j3srCbmbQDGiiBc=;
        b=AhjIz9Iy81pNccl/IovKk8R0lQAUt8SsZTuDEdMbHHBjDem5fvJBw4fjhB+i0wconF
         6BLQwuKrMVJ6JwiI06mHMu/WMX6MttXuzWABxDAo6uO1HRiKTB29x6lSkvvxvFVSClce
         zuXHbRfacFQeUdIkegTGBN02bajRDNTLroRctgfjHcQbxERLzuNYfQcCyTxYmipmuiA/
         fAJuUVCKd5vNVfnTdb9ml4bIe/5Xo9wCcCQxkMnWFmGew0ONG70mSkMCSGIX1NxuSrEF
         s6U13uOLpY9T5DRF4HD7DMpESh7X2D9rCs7YEZtqOIXXa+G6fkjISJamyJ4oQ2gTg24u
         SE5g==
X-Forwarded-Encrypted: i=1; AJvYcCWwxQ4xM9lE+kteznzv5EvBesYy9T0X3AMzLymH6kfJKPtwn9zm1B389Y5gjKgtxIex1jML3fK0Q2waMh1QS10=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi4Z5v/WnX8KBCmQf+ERmVXM7KNF3TSiAXr7xy3hDrlYjCSjWL
	tKe+WyGF+DNSXv/XvTkM9yJc2MoFwtrWR9jJA4KzvDi02QUG6CTH8uGKWZ18JOSSeY8E2NVoL5j
	5HIwRjQ54Lw==
X-Google-Smtp-Source: AGHT+IFnEky9E+WTZ67n4oDhD85FHBGvf1ZaUlsC4CSzVhw94LW+c4vdMdF17ZTVjJHaNu8o0hoGt9vNnRMLVA==
X-Received: from wmpz18.prod.google.com ([2002:a05:600c:a12:b0:43c:ebbe:4bce])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:444d:b0:43c:fe15:41cb with SMTP id 5b1f17b1804b1-43cfe154379mr72788015e9.15.1741699119995;
 Tue, 11 Mar 2025 06:18:39 -0700 (PDT)
Date: Tue, 11 Mar 2025 13:18:22 +0000
In-Reply-To: <20250311-mm-selftests-v4-0-dec210a658f5@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250311-mm-selftests-v4-0-dec210a658f5@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250311-mm-selftests-v4-11-dec210a658f5@google.com>
Subject: [PATCH v4 11/12] selftests/mm: Skip mlock tests if nobody user can't
 read it
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

If running from a directory that can't be read by unprivileged users,
executing on-fault-test via the nobody user will fail.

The kselftest build does give the file the correct permissions, but
after being installed it might be in a directory without global execute
permissions.

Since the script can't safely fix that, just skip if it happens. Note
that the stderr of the `ls` command is unfiltered meaning the user sees
a "permission denied" error that can help inform them why the test was
skipped.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/mm/run_vmtests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index e86ef8cb37d00e572be8cf0ea9cc8246d4eecd7e..1467594b594c4fb1dceae875fe7616ecc3cd9382 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -337,7 +337,7 @@ echo "$nr_hugepgs" > /proc/sys/vm/nr_hugepages
 
 CATEGORY="compaction" run_test ./compaction_test
 
-if command -v sudo &> /dev/null;
+if command -v sudo &> /dev/null && sudo -u nobody ls ./on-fault-limit >/dev/null;
 then
 	CATEGORY="mlock" run_test sudo -u nobody ./on-fault-limit
 else

-- 
2.49.0.rc0.332.g42c0ae87b1-goog


