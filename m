Return-Path: <linux-kselftest+bounces-44937-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67092C3A641
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 11:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FD163A8E84
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 10:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB0B2DF3E7;
	Thu,  6 Nov 2025 10:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jz51hmGF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF602C21F6
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Nov 2025 10:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762426174; cv=none; b=c1nH9nY/wxuB+8rz48Zc+lc9iS5q1CBYDnPNUvQUgSqgybROfF/kMJETbtBGYJQqeu/cgGl/AcZbO5JVaTH30DTxZcqtGrAvQSZ7X+XK4po0KFFi/koi9Z/lXhS6I/NiCKGygH/OlGMdNXWkdgvhVEZ+sJXDUi2hFqCafQyNA50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762426174; c=relaxed/simple;
	bh=LVJmw8Znzsk4JC1Z4uTOd7PG1aNTT/KMtESz3mfcO0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nIor6mFXK97AWce+GCpxbWpHvJ1ALKin2lg9aqYx9JkdCmzbQeB5XtwbnIYwwn09LhIbLAeMxt1BfFROY1XAFE1zFEp2ByN6Gbkaf1fhWYgjy1cPIhyzRiRirDuHcSoukTaItMW4MG6TROmL6sT+n9S9JKAPJSomAsKnCPYgJkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jz51hmGF; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso842272b3a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 02:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762426173; x=1763030973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gEdCoMYcdGEjbdHJV0gJG7pdiA99fRZM/09SLOS+hH8=;
        b=Jz51hmGFxwm6OGZgnfeFO5ULqnUt39LHh1+OqSq8zmSFNzdwKsF2dNh+DoOf+WSsVA
         J3+VBNbH44D4B7wavINJJW3+W8p0MR88ouY7i3CmDpRLUdjnNU9vYa2CNqnARQYwVt27
         K2myOHurRtGxUl0U9Qb9JRcvwrbiLhayjQMJXKBljjCoiZxyvnop/eqlMeG+WNtrA/wf
         EG0/QFWV5pcZDiuamR2ITZIgqacaNoDmBNA6xDwd2o2bweig2Hab3BdkpAvv8Ka9auqX
         O1tr2WYokriUbebqyAsQfzT+F0EmG/tUAvNBp67aXZKWnx2qpDmZGBddKVbohdd7w2Vx
         lRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762426173; x=1763030973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gEdCoMYcdGEjbdHJV0gJG7pdiA99fRZM/09SLOS+hH8=;
        b=cNMefIBtfTKNLgThpPnGA01FIoy3ReMNBxzxfquXH5t/7cWnIx7xWc6iiXoPIBqPtK
         zuP8B9LeCj3hD/1+VMOvSgH/CcpkvOrvSCee7pne0HKsJfIuKKkc3lf/v8H+mvUSN/3g
         CE2CLwXH0TUHY/rGw3BiLx0f57XnYCJKcrfY6NGc3P1x9T7iMpsxNStDJrWnXbcIJzPD
         gOnBkGU/U3MlgWIkAFSC3nX3p2OQhpVlaJVRV3ZqJdACjooQmreeyO2NtSvA44urTZK6
         IoEX1L4J6DWqEJ0mmXbIUhDhXkfJJXRrN+EHnt1NEMMvg0UVXKTYTz3nH55eh2WNYiDI
         gD7A==
X-Forwarded-Encrypted: i=1; AJvYcCVeohvSOKf52VsBasIrawxDyv2ZF8/eceO8GmkLEV5b+qO9oM4opVNL7dxVvE74RtjDWk+canScsziHJm4BY7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx40XliKZjGX7jTX+CdKVwkf09lW6qL5a5UAwYXQywt8Afru3YH
	IQExXxI6LOt6zqsFO/FGGe10kp3C9fXVq6yF3WZGd7lj/RXfL9o2D8Ry
X-Gm-Gg: ASbGnctsq6I76/ZKLEcQUGK0ujlKyMOdWJRiLB9p9Uk9FElN5DLeaQ4kXc5vAuPbyer
	bzVk5htPX1Az3WnGp3uHIzpe+iEKdEKiBNSQeSNgRCTEgWH1HbS/eNa88ib89qyXncFG6W3QQwW
	+AIPMFHQXDUQ0qlW5RBWoEfyKjJUoNMh8xe08VW5Mdzcp9wZt/YceNjCpijSwxeYKu+RjF/gDAW
	y7LQqzcR7hAFMAWtle/hWZD6XWISKw024AyoDB5WhKWfpzKs2PVoweeAQXvfplZUaM27bAXN19R
	6Qu8E7KltzTbXVCYYWmlzZMRHl/1sRs3vPVBJ057Erk5h4P9UdvtykVnjazHP6PiRk697Vy+KkQ
	jw9AktujNvmLTfEl5kbItTlUVbLW0C3cDQom6LEetP3rPDG4E3NvkyzXHIVHar8cDIMQ+t3PmF/
	meNvy3J6qvaABkxzUBYuI=
X-Google-Smtp-Source: AGHT+IEtViQepAYL7wHG7yVriIANhlLuj2N596fkhQw4o6rhnkDNFPyu2Q90vL6GWm/MKnzkOWTSPg==
X-Received: by 2002:a05:6a20:918b:b0:347:8414:da90 with SMTP id adf61e73a8af0-34f80c9ebb2mr8516805637.0.1762426172835;
        Thu, 06 Nov 2025 02:49:32 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8f8d7eedcsm2148457a12.2.2025.11.06.02.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 02:49:32 -0800 (PST)
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Subject: [PATCH] selftest/mm: fix pointer comparison in mremap_test
Date: Thu,  6 Nov 2025 16:19:17 +0530
Message-ID: <20251106104917.39890-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pointer arthemitic with 'void * addr' and 'unsigned long long dest_alignment'
triggers following warning:

mremap_test.c:1035:31: warning: pointer comparison always evaluates to
false [-Wtautological-compare]
 1035 |                 if (addr + c.dest_alignment < addr) {
      |                                             ^

typecasting 'addr' to 'unsigned long long' to fix pointer comparison.

Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---
 tools/testing/selftests/mm/mremap_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index a95c0663a011..5ae0400176af 100644
--- a/tools/testing/selftests/mm/mremap_test.c
+++ b/tools/testing/selftests/mm/mremap_test.c
@@ -1032,7 +1032,7 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
 	/* Don't destroy existing mappings unless expected to overlap */
 	while (!is_remap_region_valid(addr, c.region_size) && !c.overlapping) {
 		/* Check for unsigned overflow */
-		if (addr + c.dest_alignment < addr) {
+		if ((unsigned long long) addr + c.dest_alignment < (unsigned long long) addr) {
 			ksft_print_msg("Couldn't find a valid region to remap to\n");
 			ret = -1;
 			goto clean_up_src;
--
2.51.0


