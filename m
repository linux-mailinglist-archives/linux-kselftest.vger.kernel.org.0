Return-Path: <linux-kselftest+bounces-3166-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF42B830BB9
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 18:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E52F28B97E
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 17:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190A4225CF;
	Wed, 17 Jan 2024 17:11:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686E7225A1;
	Wed, 17 Jan 2024 17:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705511475; cv=none; b=UvMKZbBTqrxlpsWH0NqYrjXhTZ7AZzhmCEqZjr/fs/ZG3F9VEvjIKXOLbF62kcwS41vInkiu3KYD+e1/RxoXJmilxzMapoRVwNIJawahon63iTY9KxJDbEmgIpLRY4mglhvvd+tbrflHZsg9DcVzgoIWKk0h1iPLDu1Uoovt4cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705511475; c=relaxed/simple;
	bh=PZbG6wx6NcdMWESuC+ecFyqFqTXV45MvcYYsex4YP8g=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=NZEVrEYX4qgqe9DI4BiIBmiGRMcevI1jVDlLN+PxOyDOUxjJ4xXFD39EcDqrD4RyO+q06oppkOpCPQtlhNIata+DvzANbBt2vDM2rsuRaZKNT7/yvincfQtKYR/Iw7Cf54yvPAH+lz6lOwjqinlejPgXIWO1PlToubkLF1COxYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e7f58c5fbso15360504e87.1;
        Wed, 17 Jan 2024 09:11:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705511471; x=1706116271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DP69PvOk+lQM9++boQDvvmgfxQpk6r9vRPbBVvGiiUQ=;
        b=krbpWVZ61mdHvgvJJ3zFaSrZR6Fi7EjCT4579nNbPKPjgZSOJVUzha4tii//XxkVub
         6hdSFHqoQ4yUaPd2lHxZp+2rvS53Hfq2Ky5gYoUH+9vaKXuYzxrG8rJpbLC4K5zUDvII
         K8D3oKrXYSamrutm0oqtH5/lrzIGOQ74ezBW3Nk+Jev4U79TQyyHCdNd5dQEYqT5gqeP
         D9aJ++TH/enRhNN0z3zjScc4/3j7gvH/WIHvoQ37BCS0BBgr8b9cwHBS5OgljhhT6Xll
         DI17cZSy781zwUx8RMiwMea0v+DI9iqCrFHS0Gx5EJNamUgWDlIgq+FWbyJljwL82kD+
         KVmw==
X-Gm-Message-State: AOJu0YzH97Vq5uO9s2o2N0l+1ztyXUyXHYTb+09djTduGpeQcIm5mf7D
	6I8AlP+fe5k3buInp8JrQh8=
X-Google-Smtp-Source: AGHT+IFjaNiYH3oaekOUfuYUMYM7ygcB8kqWaLO9WOSCMI6Gia6+k0oGOt0Aicaumyp4mmYxC/UTew==
X-Received: by 2002:a05:6512:1155:b0:50e:7be3:c707 with SMTP id m21-20020a056512115500b0050e7be3c707mr5552398lfg.19.1705511471369;
        Wed, 17 Jan 2024 09:11:11 -0800 (PST)
Received: from localhost (fwdproxy-cln-005.fbsv.net. [2a03:2880:31ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id p26-20020a1709061b5a00b00a298ade2e72sm7992905ejg.195.2024.01.17.09.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 09:11:11 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: lstoakes@gmail.com,
	willy@infradead.org,
	mike.kravetz@oracle.com,
	linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] selftests/mm: run_vmtests.sh: add hugetlb_madv_vs_map
Date: Wed, 17 Jan 2024 09:10:58 -0800
Message-Id: <20240117171058.2192286-2-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117171058.2192286-1-leitao@debian.org>
References: <20240117171058.2192286-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hugetlb_madv_vs_map selftest was not part of the mm test-suite since we
didn't have a fix for the problem it found.

Now that the problem is already fixed (see previous commit), let's
enable this selftest in the default test-suite.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/mm/run_vmtests.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index a5e6ba8d3579..f41e1978e4d4 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -256,6 +256,7 @@ nr_hugepages_tmp=$(cat /proc/sys/vm/nr_hugepages)
 # For this test, we need one and just one huge page
 echo 1 > /proc/sys/vm/nr_hugepages
 CATEGORY="hugetlb" run_test ./hugetlb_fault_after_madv
+CATEGORY="hugetlb" run_test ./hugetlb_madv_vs_map
 # Restore the previous number of huge pages, since further tests rely on it
 echo "$nr_hugepages_tmp" > /proc/sys/vm/nr_hugepages
 
-- 
2.34.1


