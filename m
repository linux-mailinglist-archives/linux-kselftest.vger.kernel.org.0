Return-Path: <linux-kselftest+bounces-43824-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD7EBFEC45
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 03:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 374324E2800
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 01:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6C617B418;
	Thu, 23 Oct 2025 01:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYzhO4nF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB5D175BF
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Oct 2025 01:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181226; cv=none; b=BKT+cUoxca/J6PiFMgdYgt26Q1Sk664lGT1QZYE0Cb9Oc8MqsLyUt4B2vno+9ykYzkzR0nml09O2VcOpL/3HXUZY71divyahxqGTfJ65L2+7liUYE09m0+aRKvzhnHQywijKIWMuX1mVyQJLe6Fj3AkjJmbhZ3PncB0qrpMMoDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181226; c=relaxed/simple;
	bh=OrsxdswB6rrhAmFOBRD5OXXftqbef7SMzTrZcBtK8PE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UynGuYFFjb/BVBf6VPTxQI1meFE56FEXkVyvBo94X29EFH7Wg9AzgwBuNHyR5M17AqppK/apVgw55fb9KJUniDrT3pv87KUT43G5RY9DkSc9Kl+m0gceGSga+Mnuv57dhXr/fb7jqPRnMnzDnS3RDweYJnQz5MSlTBwZtoX02sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYzhO4nF; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-339d7c403b6so263460a91.2
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 18:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181224; x=1761786024; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QcrG5SS8hn1JmYCm2wGF/gyiT6cJxpEJmuxnsfJHsCI=;
        b=kYzhO4nFc+Gx2p2jzIoiE+x+jr9b6XPegQgKkshJYx0bZKoaXTRPJ27RskKeEYSHkP
         Wv9Vt60bB3YfB7ileHm3bLMMqeP418RjoQA0T+rfPyda42UzlCkMfbZ2fvEFqDZV0Fhw
         hWAk5fyNyjPqyalmDHrp4nKejCqxXsO/YOlQJ1b843T0U67+NPuXZNoM/UK7YP83Sruc
         awOzaITnorzX7HhUq7GGNRhqhDAAsWspiW/zsaERcQZPb/0qyTUgOCFw4oFWlBQBbVm+
         Tr6SOZ4CbiwmKZmyUCMbkjRGuwcV28LuReukOW6BeAjkxmeeYRqF58Rxavg7q+oWRYoU
         lCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181224; x=1761786024;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QcrG5SS8hn1JmYCm2wGF/gyiT6cJxpEJmuxnsfJHsCI=;
        b=Exn0alZFYlli4Xd8NRDrqJPyWGT3LsCkRdxsUAF0NEjpULfwz9caMFZICO0LI/X11g
         he+wIFIqTKmXpayfoPMq2U60UdOipjkWxs8FI+Ql6VucdwD5MmdvGPL/nVHqaFHlGCDg
         krT9oTXPtHkk0cxFcihvfi2YbGwamIVJ723lIX4sOCZbtPSHw+vG7n2HxG2ok3Et+GGp
         d1ueIYf8Xxfl8U6/y5lCoNU9n1+x2C0VsslX/TrKl5raeZvKsMp/vZ1zkqwORCmndFGp
         vnnzVwuaNSk03VLCQjFefc/5SaSpoRhS9h0t5GAphcuKseZBA9ic04jE3gJFGi30x7Tz
         9xcw==
X-Forwarded-Encrypted: i=1; AJvYcCVUufHdItUoavVeLqxR3ooYRDNujCkr4ur/KhD/SGbJfPeOm2TqOT0HmPpYKvP12ws+r6+1bjxP6mkAAIuo28s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKZf+PK6DfhJHKICFgbW1/dMtnIQfJiOrUegD+dNWUAsyLemUG
	jxPn2hDxYkccf4SJu19wmf6aaZGMPEsKC1TmR689UqsR4gAR5+u1cvAS
X-Gm-Gg: ASbGncuTkTSvL4ydplI6uV+1/FmXRK6KED7td8rOTq92G6t02bbTgdxFU2WO68rdNCP
	2IWtAPa2IRxGStiRM1nBvJVfIZnEZefr47FvqRUUnfxj866QCDDCs3OhXcWiMYSj31aRpz2FVR8
	Itp2T+1duX+xuWQecQBzeNMnAX2453vG/oas3KvJQs49mnrroS9SgTPnl2OGKuJ70TIZWOraUpa
	5Fj+uLuhvlSHpReGW6saVWIWONb5YqltyzoMFwdoF9j//NTSJIah0XqaUuuKsStVeqR2jYJWb3g
	zqMfcnXndebRAos9eSWmP3mpV+GSfsYbvanj2O4TXuTax4KMgAZJncMRY74JkmXdukzNvilHoLd
	Uy0Rg+OvyLP2BiV8iPg74WPywGRDeSOrIg1FNhyzD2UgEt0taJta0vGOTYgOlYU2Y9zLqcu0Bnb
	WQZPuJGp8=
X-Google-Smtp-Source: AGHT+IGnOv9l1GPF2QRjAQJj6nCOHdYFB+j/jBqimM5n8rIVXUeoQADXI3xEZDsAaop4mPz3EecSjg==
X-Received: by 2002:a17:90b:4c4c:b0:329:e4d1:c20f with SMTP id 98e67ed59e1d1-33bcf873e1bmr28314920a91.9.1761181224284;
        Wed, 22 Oct 2025 18:00:24 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:8::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223e2a48sm3855388a91.6.2025.10.22.18.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:00:23 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next 00/12] selftests/vsock: refactor and improve
 vmtest infrastructure
Date: Wed, 22 Oct 2025 18:00:04 -0700
Message-Id: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABR++WgC/42OQQrCMBREr1L+2i9JbCm68h7SRZr+2KBJSn4Il
 dK7G4oHcDnzhpnZgCk5Yrg1GyQqjl0MVchTA2bW4UnopqpBCdVJoSQWjuaFTG+biTOjdSsx6jC
 h80uKhTyFaouub1th7aishlq2JDqStesBgTIGWjMMlcyOc0yf40GRB/+NqX/HikSBLV37i52Uo
 VHePWV9NtHDsO/7F6ESUlXlAAAA
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

Hey all,

This patch series refactors the vsock selftest VM infrastructure to
improve test run times, reduce false-positives, improve logging
generally, and fix several bugs.

It also prepares for future tests which make heavy usage of these
refactored functions and have new requirements such as simultaneous QEMU
processes.

These patches were broken off from this prior series:
https://lore.kernel.org/all/20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com/

To: Stefano Garzarella <sgarzare@redhat.com>
To: Shuah Khan <shuah@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev
Cc: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

---
Bobby Eshleman (12):
      selftests/vsock: improve logging in vmtest.sh
      selftests/vsock: make wait_for_listener() work even if pipefail is on
      selftests/vsock: reuse logic for vsock_test through wrapper functions
      selftests/vsock: avoid multi-VM pidfile collisions with QEMU
      selftests/vsock: do not unconditionally die if qemu fails
      selftests/vsock: speed up tests by reducing the QEMU pidfile timeout
      selftests/vsock: add check_result() for pass/fail counting
      selftests/vsock: identify and execute tests that can re-use VM
      selftests/vsock: add BUILD=0 definition
      selftests/vsock: avoid false-positives when checking dmesg
      selftests/vsock: add 1.37 to tested virtme-ng versions
      selftests/vsock: add vsock_loopback module loading

 tools/testing/selftests/vsock/vmtest.sh | 345 +++++++++++++++++++++-----------
 1 file changed, 227 insertions(+), 118 deletions(-)
---
base-commit: 962ac5ca99a5c3e7469215bf47572440402dfd59
change-id: 20251021-vsock-selftests-fixes-and-improvements-057440ffb2fa

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


