Return-Path: <linux-kselftest+bounces-29917-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 889DCA756ED
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Mar 2025 16:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D70316B7AC
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Mar 2025 15:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3091DB13A;
	Sat, 29 Mar 2025 15:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X17vjgIt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2C817991
	for <linux-kselftest@vger.kernel.org>; Sat, 29 Mar 2025 15:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743260817; cv=none; b=aiyoB4fTcZ6kYmksnrT5rH4u4mRggmZJZ/BXP/yJBIc+gLY0obT01WQfTmV/6QfAPIRpMYyD3NvQf/5TCgmvw2kq0ZewnMya5IyuQwB/jjJtvdYaqFww8F0ksX4yoFZqFkquDja41QU90pcAycpTX7M0TOfHMHvbYu4wR3b+hr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743260817; c=relaxed/simple;
	bh=vhrh+9oSpP0DEWejdyfXK8eNWvvXri7PQXavL0j3KlI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-type; b=mDjfHuqlbZbTpd8gXkAjLM+q8CUG6wg52rL551ejpgPl3jeBEH32hZ2e4BiLl3olHsk6G+t/vaayQ3DVNUNahkimJ3/CoTdl33FsiadKr1IdsKyAVD9Ty6Xk40mys6kdNzUClRJ3MicZkfaTGuHzAb6JXL4ZSFMn22uQ/9jLjyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X17vjgIt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743260815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=S8zI311lqbyq1Z4you2dOBLeU+B8GZ4SBxX1alQksoE=;
	b=X17vjgItLlOkpuzqzi98HCvQxdkhXqaLbZwCcykitPOBQmPJtO+YIW3hzOGz79RYLynUCj
	hJ9GcHQWeKD8KsA+prrpq0r0TJ5YsRYKXDYibR4tyuQQlg8m/7e1BqXpxAmZWbUk+DVgcq
	78Ldd4RIasihkomsictESodKydyIxIA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-6cn1iC6qM3uKATRBUHcc-g-1; Sat, 29 Mar 2025 11:06:53 -0400
X-MC-Unique: 6cn1iC6qM3uKATRBUHcc-g-1
X-Mimecast-MFC-AGG-ID: 6cn1iC6qM3uKATRBUHcc-g_1743260812
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43bd0586a73so26683905e9.2
        for <linux-kselftest@vger.kernel.org>; Sat, 29 Mar 2025 08:06:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743260811; x=1743865611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S8zI311lqbyq1Z4you2dOBLeU+B8GZ4SBxX1alQksoE=;
        b=KywvRmJ9tzoJBxIlRF9jip0F8Byr6do5HG6DL381DKzNXdY8RJz7AOM38vQIXy6B6U
         2oWZi0AOuQG6mk2s/h9GcPJOH8Hv6m86skyqtcjaO9fRDUozwkKTDb8JqCjNaULJwnPt
         GeNkKs42qneVHZJINpe1Z/wYdZdi2PAOBfyQ0F8Oh0D8u8r8tdxaAPg1wCGW+9VAlPuF
         GKZqKUM5qqkS1RzD40YJ+i4EtiEXUHSEioIiF0I1jryR+vRS9BjWsGE83hn9hPCfvXum
         qtVM5YGGUPc7kg4oHCU2521tJSRoFm9dSlMQMZQvYeIqouytSYIDHxdmZ7/imjiCv99e
         guxw==
X-Gm-Message-State: AOJu0YxYmBAHrX6tqgTBcQRpyWvWhb94aLmPL5fmuRNH3T931Pxd/lb1
	3byS8mXD+vJelxnSMsascm7m8YdQUTyf1o83261mPwEml+00igXL34aEgZT6PnmJRxvL8XQ3WGz
	9P+ZrJxMmvoDFFU4wejA5D0qVA0ByBYmna0xvBDX0yav0scLASvL5b2ryMFDc2t5GOmu6pYnfPI
	DfgalH+qNEJC0isMDj+ObPgi6CeDXI9adHdAIAIoHv/imSz8waUEnd
X-Gm-Gg: ASbGncuqiAyzEcmyMhSW00HPiT+hL37VLvQiGP91H/jMXxJ5SJg7UeJlc0KQxb6KWEU
	lY10JmXdBL6blJ8gkhARoxxUFn8Oncfz26m16ih6WO461WiIOxzNr459qrQ3bcxeWbnPVG5ls+D
	v5iKAhVzrxLr7HB3WhT9V7FtuEd23cwSRGEC+D7uu8m+dbaWemXk3it19mgLtOAQQ4SyXJzQBIS
	Ba3do2vy2zFQIpdznlrXwNnKYy5pt/v+P/c4O+oRE0bga9b2/BicIt6iHH5w0pS2c5eTrVQDOw6
	7uHM2UOvnD2bEjES8q8y
X-Received: by 2002:a05:6000:40cd:b0:38d:d666:5457 with SMTP id ffacd0b85a97d-39c12118f51mr2203370f8f.42.1743260811377;
        Sat, 29 Mar 2025 08:06:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IET88jcJ/fUhMkJBzo9iXANXxVp80YEfKLaDkLOIVe2hPzsFQ5lK7sBVk2xeGnWFUm+16DMNw==
X-Received: by 2002:a05:6000:40cd:b0:38d:d666:5457 with SMTP id ffacd0b85a97d-39c12118f51mr2203328f8f.42.1743260810973;
        Sat, 29 Mar 2025 08:06:50 -0700 (PDT)
Received: from lab.hqhome163.com ([81.57.75.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39c0b662850sm5914994f8f.26.2025.03.29.08.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 08:06:50 -0700 (PDT)
From: Alessandro Carminati <acarmina@redhat.com>
To: linux-kselftest@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Kees Cook <keescook@chromium.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	David Gow <davidgow@google.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	Ville Syrjala <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Guenter Roeck <linux@roeck-us.net>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	dri-devel@lists.freedesktop.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org,
	Alessandro Carminati <acarmina@redhat.com>
Subject: [PATCH] kunit: fixes backtrace suppression test module description
Date: Sat, 29 Mar 2025 15:05:29 +0000
Message-Id: <20250329150529.331215-1-acarmina@redhat.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit

Adds module description to the backtrace suppression test

Fixes:  ("19f3496") kunit: add test cases for backtrace warning suppression

Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
---
 lib/kunit/backtrace-suppression-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/kunit/backtrace-suppression-test.c b/lib/kunit/backtrace-suppression-test.c
index 8b4125af2481..d4c5df09bba6 100644
--- a/lib/kunit/backtrace-suppression-test.c
+++ b/lib/kunit/backtrace-suppression-test.c
@@ -102,3 +102,4 @@ static struct kunit_suite backtrace_suppression_test_suite = {
 kunit_test_suites(&backtrace_suppression_test_suite);
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("KUnit test to verify warning backtrace suppression");
-- 
2.34.1


