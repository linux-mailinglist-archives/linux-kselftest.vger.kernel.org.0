Return-Path: <linux-kselftest+bounces-27934-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 525FFA49F8D
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 17:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97E337A563D
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 16:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4772862AB;
	Fri, 28 Feb 2025 16:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="20PUkHL6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8C928629A
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 16:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740761719; cv=none; b=Zq8Iv5LudiFgsevYCvz9UCi3mMsLINGgOahR389nEdVDe3quHR0tUCpfUZwIPILP4S9GLgPWSZ6hHH5YGOL40J1bVxZ244sKwd9fdE6y/QyFaDnsoNGbMuT9Xgu/ViKpgCkH4kLoa0ajrevADM/qI4EM3X5/arBgkVBbZO3jRsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740761719; c=relaxed/simple;
	bh=KNpskPcxfPhqPpFfjuljLY2fvRa+/kXrp30Qg66iAYQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gRru+SDY7uGDRjfc1YMFS3ckTxkarMmjStY94WWqD90UQpJqP7thmw0OBHCblvUoIghem8f7rMBXKGkVLkP3ssI0M0HJBLeCmOof+Filr6kj2tw+Cx2aYZol5iI7aepmgvVc/QJK/n0DsslrzjRRcgkxue7ABCPJFYn3iUczeM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=20PUkHL6; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-390f000e962so440726f8f.2
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 08:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740761716; x=1741366516; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Ql5hc6LJFV7jS99QKiJbBHefyQj7jLlsETMiqi11w8=;
        b=20PUkHL6q7Ct2ihfse5+vuwCHYBNEyGydEMVwFHcN/3D60tlpDd9dsV+7cBmHmzb02
         JL24YpUTA8JglXWvj3/yO54XU+Fr6YY/JsK1zLJxkIJsIvXGLOqxu3Vsms0A74QI5+KO
         toNFH7h6QX/+RhLH6/affOKV1LF2xc810tDsF/xSSBNypkfHSSkmv0a3AywcTlFKP2rx
         gYvuVFQ9aggFyCrks5p2aGml9nRyUDrK5nfWnmsjEJHa+YkQAjZA4mvQRAXr3s5KD+8E
         DgDmph3RJcB8jOvPxK8J6pulDTijLkMY+0VLn4iZYvH/89hp/PikkaCOlqzVyFl/0WkZ
         jr9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740761716; x=1741366516;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Ql5hc6LJFV7jS99QKiJbBHefyQj7jLlsETMiqi11w8=;
        b=lkZHGxrXt0qamnuPSiKMu7NjHOGQUsOx3qjtEoi+1+JdfOLp9wKb3qDrAbIykrAJbl
         4SDL0/wPqzLinIvoThxSrAuDuLsut4WXjW5Z1drxOWefi+bqoJH8ihTLKk9PbzaxWtT8
         0RIuqa8LL6Vo5NbZnByaycp7Mg9FzdOngRTR6kuhHqk7KaGW2WQUKt5N2NfAIgNOlLCF
         530HJLAUQl3z/HStReMhqhon36FkjiQNiPp6L93jX80lIwsJ2UmRE17IG7BWhxb8tSCh
         ee2Oq0ldrhIJZZbqA1o8V3CNyxt6s/P13MI3SGc8wWSkiIEhJZv5DutBXhbpUZ9P39i5
         0apg==
X-Forwarded-Encrypted: i=1; AJvYcCU1CitOB1UrdIshf8qZ58QbbpxklV9lYQLOoftGHtlrtijN0pSb7i4ps6BlrNd1A8bRzIXX+j62GcpdxY8+MaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqLn2yd8pKcpWXiTLGaXXkq9gsgjrS8wZ5DdhkR/7kPvwABHQ/
	OMVZeBImPG+xclGlYTQE6P+XHyhdf54mlvgeh2M0zyXVfo6c72tFSL0ihRKSJdlOaNSbG35lv1G
	l9n9UFgERJg==
X-Google-Smtp-Source: AGHT+IFB7nITz7U/iMU0tPl/bO9xV6X55cC7dWX52NbyH2lvSNR7sagUxaeaf3fhuxPU57nHGgdGlD6quABXnQ==
X-Received: from wmbbh15.prod.google.com ([2002:a05:600c:3d0f:b0:439:9fd1:8341])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:188c:b0:38f:3224:65ff with SMTP id ffacd0b85a97d-390ec7c6a8emr2890522f8f.5.1740761716612;
 Fri, 28 Feb 2025 08:55:16 -0800 (PST)
Date: Fri, 28 Feb 2025 16:54:58 +0000
In-Reply-To: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250228-mm-selftests-v3-10-958e3b6f0203@google.com>
Subject: [PATCH v3 10/10] selftests/mm: Ensure uffd-wp-mremap gets pages of
 each size
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

This test allocates a page of every available size and doesn't have any
SKIP logic if the allocation fails. So, ensure it's available and skip
the test if we can't do so.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/mm/run_vmtests.sh | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 0f9fe757c3320a6551e39b6d4552fd4874b0bf43..e86ef8cb37d00e572be8cf0ea9cc8246d4eecd7e 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -309,9 +309,30 @@ CATEGORY="userfaultfd" run_test ${uffd_stress_bin} hugetlb "$half_ufd_size_MB" 3
 CATEGORY="userfaultfd" run_test ${uffd_stress_bin} hugetlb-private "$half_ufd_size_MB" 32
 CATEGORY="userfaultfd" run_test ${uffd_stress_bin} shmem 20 16
 CATEGORY="userfaultfd" run_test ${uffd_stress_bin} shmem-private 20 16
-CATEGORY="userfaultfd" run_test ./uffd-wp-mremap
+# uffd-wp-mremap requires at least one page of each size.
+have_all_size_hugepgs=true
+declare -A nr_size_hugepgs
+for f in /sys/kernel/mm/hugepages/**/nr_hugepages; do
+	old=$(cat $f)
+	nr_size_hugepgs["$f"]="$old"
+	if [ "$old" == 0 ]; then
+		echo 1 > "$f"
+	fi
+	if [ $(cat "$f") == 0 ]; then
+		have_all_size_hugepgs=false
+		break
+	fi
+done
+if $have_all_size_hugepgs; then
+	CATEGORY="userfaultfd" run_test ./uffd-wp-mremap
+else
+	echo "# SKIP ./uffd-wp-mremap"
+fi
 
 #cleanup
+for f in "${!nr_size_hugepgs[@]}"; do
+	echo "${nr_size_hugepgs["$f"]}" > "$f"
+done
 echo "$nr_hugepgs" > /proc/sys/vm/nr_hugepages
 
 CATEGORY="compaction" run_test ./compaction_test

-- 
2.48.1.711.g2feabab25a-goog


