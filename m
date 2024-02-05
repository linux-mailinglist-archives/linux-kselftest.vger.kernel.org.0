Return-Path: <linux-kselftest+bounces-4158-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A87E84A6C4
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 22:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00E721F28CD0
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 21:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FB255E5F;
	Mon,  5 Feb 2024 19:19:03 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88AA55C1D;
	Mon,  5 Feb 2024 19:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707160743; cv=none; b=Alk0OKZ0dqJAHKI7I2QFO/zPHl2Yhg4Es5GR/Dvg9y6Wym2IaPlxy/3zUe1i5SHK5B2D/s+6XzVZXpgQI6BhIKma3nUF2PN+xK/jtvvZReFAw4z+cr5wDP1z31XWUimYDS5i9OiN2PBkWhjVj9aji8EjDpmb5cde+/eSAocgfxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707160743; c=relaxed/simple;
	bh=ncRsIdJWU7Fb5w1Y11uJGyPE0DAbtzrze6NkIJGNx7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SIWcp5Vdk6uCo/dl0x6vkUUb/ZgED9zZHjgAyHND4oj3EDWZcp93Vu/Uw8BfnhPsZj6YNg+ifHM3uvjh7tru4ewLH0hJS0xB4Vsni+k0z7Y0KH89VX1LsPFEuiBzjQGdqshROQ6o74aagYXuZ95bdLsFFcHJ20EKDuSBVBWUh+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a359e6fde44so3831766b.3;
        Mon, 05 Feb 2024 11:19:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707160740; x=1707765540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WC26n55iZnXbww+34MstvyMYAWzNyFy0JnU0QygjqI=;
        b=fRNVYTUm1EGmkbd5wiEjURxZgyrmAsXeTVzUBylB3K+cPpBynSKzqCyjOOVzW4Iv4w
         DPstoyI1oPat+xWOb/SDzT9I/Liy7W0FTo3Zayp2RYYEtwVxOjJqzA0c+94NIdT6nEbV
         qPKLzPh8UKE/GjL1kPQFPHaob/eaDMnlMQDdr68VGtBF6lkL8e2P2Y+3NJ0+It8/72zK
         XhU0wo3bHCBSRyFXoU0ZzNN+D/jOkjwvJdgGDXYbauVJUFpnCCpW2cxNr8kc4TWn1XLg
         ppq9i7IEvh9mE928TnQ5oTdw/X1bkxS9HLlNd/e3MSVY3ueZaDVBc3+PGGWC79nsJ1+b
         y93A==
X-Gm-Message-State: AOJu0Yw4Koni2auFpfRXqmWlTPyuBONPcnAjMIoYUJJWJzuhAEgDzNH3
	drEy8ntJ7TC25UwEdH3iXApdthOFPs41IW6fDyNMOKUA9LyLpeZJ
X-Google-Smtp-Source: AGHT+IHLc0HadsV/eDekFcvJhQSwC9u5/Jfj7dNNksLZBMHsGXWIlh9ubGXg+AAPmWeKyat/93baTg==
X-Received: by 2002:a17:906:2456:b0:a37:aa39:ea27 with SMTP id a22-20020a170906245600b00a37aa39ea27mr270002ejb.65.1707160739532;
        Mon, 05 Feb 2024 11:18:59 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUnz2Sd1sNKTlh9XUDSn65VAeg6JyD3s7WLIQ/AfZVc3isM/4jwLTT3rCz6D3aOibuSJbNxTV7xdKsyzl43Jl7nwofsacO+7LrqvYEhR0j/SSA/edgIrR9eynGCSYOZldjwSA11NMQiyCmWZJuBLEuTr66gcE+P7xNWzxcKrQo9yuRIANDY3QaLwr6mtiyuFu1CgPqSvlN7mM8gzwRyEM0TBls1KHITRga7eCqYyEOnsQpel/UgZ9zD7Vm/EY9bO2yHahpVWGtWfPGZ7rkiCEFzMNHm4ia7CWCiGPu/tf3zl9LI1n4odRGBVzdW/dpNiHxhM+J/RkIllH8jstVP5BbLt5Kyk5Ti/IZolE2vlpIaPmq7U0tonZ3nm1Ch
Received: from localhost (fwdproxy-cln-018.fbsv.net. [2a03:2880:31ff:12::face:b00c])
        by smtp.gmail.com with ESMTPSA id qb12-20020a1709077e8c00b00a373993b390sm156733ejc.148.2024.02.05.11.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 11:18:59 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: mike.kravetz@oracle.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	muchun.song@linux.dev,
	Shuah Khan <shuah@kernel.org>
Cc: lstoakes@gmail.com,
	willy@infradead.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH v2 2/2] selftests/mm: run_vmtests.sh: add hugetlb_madv_vs_map
Date: Mon,  5 Feb 2024 11:18:42 -0800
Message-Id: <20240205191843.4009640-3-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205191843.4009640-1-leitao@debian.org>
References: <20240205191843.4009640-1-leitao@debian.org>
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
index 246d53a5d7f2..50e2094ed761 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -253,6 +253,7 @@ nr_hugepages_tmp=$(cat /proc/sys/vm/nr_hugepages)
 # For this test, we need one and just one huge page
 echo 1 > /proc/sys/vm/nr_hugepages
 CATEGORY="hugetlb" run_test ./hugetlb_fault_after_madv
+CATEGORY="hugetlb" run_test ./hugetlb_madv_vs_map
 # Restore the previous number of huge pages, since further tests rely on it
 echo "$nr_hugepages_tmp" > /proc/sys/vm/nr_hugepages
 
-- 
2.34.1


