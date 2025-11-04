Return-Path: <linux-kselftest+bounces-44763-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A0BC33432
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 23:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CCBF44EFF20
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 22:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2AE346FBE;
	Tue,  4 Nov 2025 22:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzY0SXqV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F86B3469EC
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Nov 2025 22:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295956; cv=none; b=er3DX57Tuzy3xRKWkaHXkaAwZvogOA0e1lPpezcDmutUkOMQ4X2PvyLmnWdkqq51r8CXV+3TmOpy5t8+2VtB5CJkcmHW0z+NZwPsS6vkA7pS1hFZxoZwUbJ2w5uoJSdhYU07jO9mkP6aADJ4Ow7JLIOuqySrdYsrnu5mjrS3UKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295956; c=relaxed/simple;
	bh=dKYcrUk99CdeL/H3uIfsCxfnuKjJF+qFwDzoOr7kT4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SYYF3tXba0sbVAbFFL9AvPT5yfF57f+JVPnwjjXNYa9XnjAHGg1zq4u2+QvlYhEoO+q+N9sGgWk1vKHa96UsmKVUGmUIpC4LRk6989trQnhmHlyBFzWaPhcAVvXrh17WxcFee+blK+tHWleBielMmF2u4wHsB+jv1f0N6aSeDdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzY0SXqV; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-28e7cd6dbc0so78611815ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Nov 2025 14:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295954; x=1762900754; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UDZPS+JOEPYnU4eck4h/T1RWdETtnpWwlslVEykWAIA=;
        b=CzY0SXqVwyO1GCzWMmjfNiQTq99E/p1LfzZkggbERkoMjPYz9sP/AVKSOa7Hok5Lhl
         vvH5npWNZVEBO/GQeBie7IwylCiwqBtSV+rxXNPrXjLTARr/9f0Wtjrf7Ynnn6uLrsv+
         czHhQA2Zy0xaMT0GJHiwNxlisk/MRuZyTWAsM5eXL3UwHsAtqv6gng0kBY7xEjnui9O3
         YwOnMoUfR7zo2yWTfn1zooEzEMqSRNnTsKjr7eezuKvrEhnfhpUGnCDp9TESuE86vPrb
         BMrke6JwS3NRyH4IlcwT6uq/ITVse6DCjYqMy8YkW5ZJMYiMXS40VkfUd9/ZR9Q5MqPA
         7mqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295954; x=1762900754;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UDZPS+JOEPYnU4eck4h/T1RWdETtnpWwlslVEykWAIA=;
        b=xHboMcmzv4sXzOa2eOuA6vgaH3ssAFtI7gnQMiwPqc7rnDcfSDxe6mt94pFZYNzg4Z
         /WNdC9KIZ9xu1eH35rNLTxemgpfR0vf0BzJzHRR1YftGa5NkBG9ytay5Cj62NMUo6BIX
         IlJfqpY2ilLTjrCDzlyPk9Wlm9DBf2kUIAFgGL3EEAQiRkLgvTrJDIwdMmQoW02pmH2M
         cF7K3Ei0SZHUL0jx4auU7KC72aqIxfaWXoHaOsY9Drb/E8Ch/9Usg0+65EtmcaKPZkdt
         IcIblJ56CxmT0iCFjiE4p8GObY4wiDHpxzBcjga5duBeXAGvwPLcsjpyR7h/S6sWf2g8
         T7rQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1eorhaxQuVpJothI8VetT5jtH8dv0xS1FqBzMZF0I+cyF0iQ4fsHbLWVYXZGp6jmQz6zkVhY+9QmQxug+zJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj8DlUVPUSVttu41ymQUQCsvd7+4fq5rxacEBMzKAYsVerW3Kz
	UhCRSWYeyeKBfkHUOeUS05Ko9c00UMBDnWevFHInvbymMTq6JsAIISG+
X-Gm-Gg: ASbGncuCSIFeM2KF96t5FLJ+sTMQofQVsJTKtduRGkGyG5gmJ4EzgUZXV9RcDfvZkU2
	o3I9Xtqtnrs7vpUJqMns4V9TAXPSpTyK1Qxy0779MOBTdPOmTrpJmd+QjuwB3hASAu7Q5Or2ugq
	zmtqMYbI7YoYco+B45CrYpcL/rs88vpaeI6qR2DYM/l11jB+td3rRdy05JtH4A7JairsZwKlSpH
	/bkP1yPIv7seTmA6ArTbeRgWF8PRtbubFtKHfphEoiOrY+A8+YQVAxfkdD0jb0dNAwENWMlXmF9
	6DLPtQMZBKkPrP8UZoUPbobbsXoPA+kfoHDMwwkZNHOxA+x7/08rFufQ8WI0dFxr32hxTX2l6Z0
	8Esm9fgPZCF4lzlb6gkiu8GbfpPlyzw1pQN5k/ZhchKMUaH37xEcfPEZF6YdsRn2C3h8J3bSP
X-Google-Smtp-Source: AGHT+IGfGmQ8EXplL0hPzNqnOeWP5or72IZ12giPyrZz4vb4nazXJcS6uZFq2FRiYWZU3H7Y1pH3yg==
X-Received: by 2002:a17:902:ce89:b0:290:b14c:4f37 with SMTP id d9443c01a7336-2962ad95560mr17604575ad.30.1762295953856;
        Tue, 04 Nov 2025 14:39:13 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601972a36sm39340475ad.1.2025.11.04.14.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:13 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 14:38:55 -0800
Subject: [PATCH net-next v2 05/12] selftests/vsock: do not unconditionally
 die if qemu fails
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-5-ca2070fd1601@meta.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

If QEMU fails to boot, then set the returncode (via timeout) instead of
unconditionally dying. This is in preparation for tests that expect QEMU
to fail to boot. In that case, we just want to know if the boot failed
or not so we can test the pass/fail criteria, and continue executing the
next test.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 5637c98d5fe8..81656b9acfaa 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -221,10 +221,8 @@ vm_start() {
 		--append "${KERNEL_CMDLINE}" \
 		--rw  &> ${logfile} &
 
-	if ! timeout ${WAIT_TOTAL} \
-		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'; then
-		die "failed to boot VM"
-	fi
+	timeout "${WAIT_TOTAL}" \
+		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'
 }
 
 vm_wait_for_ssh() {

-- 
2.47.3


