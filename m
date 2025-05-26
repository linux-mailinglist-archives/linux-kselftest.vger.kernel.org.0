Return-Path: <linux-kselftest+bounces-33789-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3885BAC4069
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 15:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02D9A188D6A7
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 13:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E0020E005;
	Mon, 26 May 2025 13:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SoRLoexI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB8020C47C
	for <linux-kselftest@vger.kernel.org>; Mon, 26 May 2025 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748266110; cv=none; b=l8IQWdMklQkaPV2Z+hBxNWIzQREbHq8uQKasNON9FttXagccg9pP34RFZ/cLEQrHwynqG4CdUWMjYIwmQCkiAmhEbAI5MWlrIMF+dnWhXwJ3tO+ODeE8qmZZo/98uiageJVLoAsmdkKn0NJjonZZbwcTuhn/+q1PIZ12h+9exg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748266110; c=relaxed/simple;
	bh=k/QW8yyThWQYD06PZzn8avBbFa43Ro0Rb4YCVVYWNuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-type; b=Ubwu/U5rL/Ahalawto+qT1wWz0RKtGmwVfo9UMdQvY+krDzkAUtgXAX+X7iJru5+Ix5xmqPfTX7WBMKd3ydT5sgW83AgPW7YcgbLUGhkHq6pgcrLflU0oB+ZLyTtlMp2aLQsWZ7D2wDODpmt/QMsiBBoa1wlRkyeEecVw8sgS8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SoRLoexI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748266107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=piebsVU5QZFL/FeYXj8vMs1AI4HP2ZYK+Wi3o0pUrOA=;
	b=SoRLoexIuA22GzDM+m1pY0TziDLezTdOMGesSucdcQTy7rbuR7a17FIK8pjLkUaExwYcFV
	wmtetzCHu2mUV0e+IRBpEJ4f+7wR0BjBP44QWu1jii3qh5J2c0RyRarqx6nmw9G4MpKT36
	OY5PzLvXPlid++qc1lWXhJTJVKyPu6o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-0NemywDRNYaexD5pjsclTw-1; Mon, 26 May 2025 09:28:26 -0400
X-MC-Unique: 0NemywDRNYaexD5pjsclTw-1
X-Mimecast-MFC-AGG-ID: 0NemywDRNYaexD5pjsclTw_1748266105
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-44a3b5996d2so11054225e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 26 May 2025 06:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748266104; x=1748870904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=piebsVU5QZFL/FeYXj8vMs1AI4HP2ZYK+Wi3o0pUrOA=;
        b=R2H/wNA9mcGuV3vBNIu2XhLmXrfIUrmi+hpTVTIa6OtduEuNjXO98CQH+82smWwUw6
         Q4yZdYqE9BJs+YE4wWjfOfwElrK08+8HeiGcfz0Y0hJpQ39KQkaC1bfca/rI1fhOKO4L
         xWDSRYQnELVbqC5RsewzO/y10UaZ1HmS936Pe7syb8QTXbTjcPIX6ITHFO45Hfz7aOCD
         I5N7VNVME/2QCR4eURKrwU+2/UkQTM4Gd92SmVFwAVsL+uPWKFIWrOSj5Bj3LkId9FhA
         AktBJImbzcZ2bhqwTJHyN1U/qAtvOr+NOBf+wuIaVVF4zU2nPXds4a5G8cEc8mS2AcHc
         UhkA==
X-Gm-Message-State: AOJu0YzwfAZUdNK1Iy36QZye5VM+YZn90kLSiKo/v0d/aeX1pMBfhjQs
	oC5gelbm59QxX5SpZBLrFPfFI8RSnwD4fnuTzcyRCcvhMkLXzGF4vKhKfx9fwcfKWtFyTF1+MAO
	Mr8QGJusAqDbYhea8sVShz7CwTi0erWn/OnYh2iA1vA2ja9N6FyzH+ff5m/fXWjOFKBqSHooIJ3
	WYWnwT3fK3T1lynTcvdwjFBwRFUo2BQr8lW71c6VRr3/7pX/jJPvBf+POq
X-Gm-Gg: ASbGncvHIF/0Wt0/4H3HpaTHbEmRkF9wlgOhqSFnGMzOlq2USHw6RHy2DsJDetaCXFA
	lAZerOh4coxjArCTNzBVNa1qZBTDOouzC/Mq8fV5cQ+/vLewkO2ih60C8eJico9l6viuzbVAGQ/
	6L5Dm6LK6Z4Dffctt2lbeYN6/Rnk+88ulvYI+oVqq2za6k5rmD7gEahHD7AWZqWLXjcTB1Uaqnq
	+M4yv1jAMjUm/21Foak4Ia17nu2hJxuh0FC5vGBH9EgjTE8Ya0elGRF5xj5DRtCrMXBEQpdtHJl
	DJAD1jIiMuWZXfFD
X-Received: by 2002:a05:600c:511f:b0:442:f482:c429 with SMTP id 5b1f17b1804b1-44c919e1212mr72338955e9.8.1748266104523;
        Mon, 26 May 2025 06:28:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaaobnHeigG/eBkWZXd1t3qpSgOSBx99XMBgFVTdHMNgY3fiyKRZ23Lqf2VAX1TTWLq2keaQ==
X-Received: by 2002:a05:600c:511f:b0:442:f482:c429 with SMTP id 5b1f17b1804b1-44c919e1212mr72338525e9.8.1748266103966;
        Mon, 26 May 2025 06:28:23 -0700 (PDT)
Received: from lab.hqhome163.com ([81.57.75.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a4c8455e7dsm8836663f8f.9.2025.05.26.06.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 06:28:23 -0700 (PDT)
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
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	dri-devel@lists.freedesktop.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Alessandro Carminati <acarmina@redhat.com>
Subject: [PATCH v5 5/5] kunit: Add documentation for warning backtrace suppression API
Date: Mon, 26 May 2025 13:27:55 +0000
Message-Id: <20250526132755.166150-6-acarmina@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250526132755.166150-1-acarmina@redhat.com>
References: <20250526132755.166150-1-acarmina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit

From: Guenter Roeck <linux@roeck-us.net>

Document API functions for suppressing warning backtraces.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
---
 Documentation/dev-tools/kunit/usage.rst | 30 ++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 22955d56b379..b2f1e56d53b4 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -157,6 +157,34 @@ Alternatively, one can take full control over the error message by using
 	if (some_setup_function())
 		KUNIT_FAIL(test, "Failed to setup thing for testing");
 
+Suppressing warning backtraces
+------------------------------
+
+Some unit tests trigger warning backtraces either intentionally or as side
+effect. Such backtraces are normally undesirable since they distract from
+the actual test and may result in the impression that there is a problem.
+
+Such backtraces can be suppressed. To suppress a backtrace in some_function(),
+use the following code.
+
+.. code-block:: c
+
+	static void some_test(struct kunit *test)
+	{
+		DEFINE_SUPPRESSED_WARNING(some_function);
+
+		KUNIT_START_SUPPRESSED_WARNING(some_function);
+		trigger_backtrace();
+		KUNIT_END_SUPPRESSED_WARNING(some_function);
+	}
+
+SUPPRESSED_WARNING_COUNT() returns the number of suppressed backtraces. If the
+suppressed backtrace was triggered on purpose, this can be used to check if
+the backtrace was actually triggered.
+
+.. code-block:: c
+
+	KUNIT_EXPECT_EQ(test, SUPPRESSED_WARNING_COUNT(some_function), 1);
 
 Test Suites
 ~~~~~~~~~~~
@@ -857,4 +885,4 @@ For example:
 		dev_managed_string = devm_kstrdup(fake_device, "Hello, World!");
 
 		// Everything is cleaned up automatically when the test ends.
-	}
\ No newline at end of file
+	}
-- 
2.34.1


