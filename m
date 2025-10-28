Return-Path: <linux-kselftest+bounces-44209-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF24C16A3D
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 20:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FBBA3A899C
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 19:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4634234FF65;
	Tue, 28 Oct 2025 19:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i/HR/dWG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9E834F24B
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 19:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761680435; cv=none; b=BlLxvs2wegva6lWwSDPL73KIStgRwiesY/HyRsJP/uCxNRKmiaaoUCvaboNGGvLgst0EIdQcUYrI58ouvqrZ6MR4wk/fmrBHn/Vy9DwljGvKwk8VX2JZCO+Fmu6GM2Lq9ZfNZVPL9EceyP0oHzCEWHgjq7nP6e/uuMl4YTaYrO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761680435; c=relaxed/simple;
	bh=To5acIYuKxLI7VmWBBln4+MVx0ugLM3XHMdYhItqD6k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YJlMe4yUYbKFNcOBH5nrFs/HgOPbwooEoKWNxP5crDTdycIVbTGCGN34S8kovzH+3McngHIMrKJ/NAq6AeJXIPQL6dvqi7ou2jy0sUMUOw+aylrn11x9T8FnbANWNpYjYsNjg25D6YUV9kzH8Pkajs0KZonEeUjiRWZW+gc+NO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i/HR/dWG; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8a194ded475so408019985a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 12:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761680432; x=1762285232; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=klmAEOBgnK8V0krntMXnjM4cr8IdVdSgq5C2UUbnczQ=;
        b=i/HR/dWGVm3Dmsu8GTZTkgpRirSKGhbSVtGpvnSeAivjw2oQ4/yyYpvA1wIXRz32IO
         FRcV01jX/Pm/gsVAG7FeqGgeBLvUgeGFVqPvKcZDYOMSeEeFgGt6QsjkVrdjCwJCTnpY
         XMPdYusGbdT0cFZDBasuL9AdqQHkonMKOPj/36vCkY8KtgeL/J/q6HrLXPNzYuMdC/6K
         KIm4enTWIOIQbMjKVsBhTI0pjNyYm5f8obmQ7+xoy9C+3xzUG+yUby60BlfrXDtn8axM
         8u0e/eNn3wCv5yROYSu1PfgI5XAFl7rokvxwtwTm6svM74YCLQlWxVjL0ydCY3NONBgb
         BM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761680432; x=1762285232;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=klmAEOBgnK8V0krntMXnjM4cr8IdVdSgq5C2UUbnczQ=;
        b=u3swp7OqpZf54mq7/k+f/m9gKih5IHr+ekIXQIzAQ8G04Z2g3Je0XasMNrRZ1z7PW6
         7nLBMbAdHd5gBeHRXOPUDNUbXIETHJYcHrzKqBNCL2XJBaGuTD32bd6j9JJSOI8V9/u6
         D2Qoxc/+V4BY6AQ/iMuMF3P7PQtBBjvlqfZNi640OPxeaGcM9lo4HEEOjSn0y2S3Daq2
         vOTeI7k0DEb/a7RpkcNcUc9q/XANbvf5ztkOlCmj8wpXIDLea7vr/0JUeSJp+BrQIxcN
         YcLmo7178vQrKm3SS8F+puKz5WgPoHuY+avwhc5IjqVIgE/vOzvmDF9/YZ7RXqRD5RQk
         IXCQ==
X-Gm-Message-State: AOJu0Yx7v3AZJe6fknUM9GW5Zf20VfugavhCd5FJjhR5s0O0x+eyMZXv
	woPM8+0J0LJ+ek7oy7ATZ6K5h9jdk+PkPu7973f8ud37HX8hHjKiNruSljwsO/cKT9t88sACI68
	1dg==
X-Google-Smtp-Source: AGHT+IFVO1CqGnWuA7TXA7gqNnWQ0zNCmjHiQKbhFId0ZmPSRBmELfYFPsXfnUDloIvO5lq/eIrrgreMPw==
X-Received: from qknqa3.prod.google.com ([2002:a05:620a:6483:b0:859:f095:3f58])
 (user=rmoar job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:4016:b0:8a3:f8c2:5f01
 with SMTP id af79cd13be357-8a8e5d92995mr76595385a.72.1761680432512; Tue, 28
 Oct 2025 12:40:32 -0700 (PDT)
Date: Tue, 28 Oct 2025 19:40:10 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028194010.519411-1-rmoar@google.com>
Subject: [PATCH] MAINTAINERS: Update KUnit email address for Rae Moar
From: Rae Moar <rmoar@google.com>
To: shuah@kernel.org, davidgow@google.com
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

Update Rae's email address for the KUnit entry. Also add an entry to
.mailmap to map former google email to current gmail address.

Signed-off-by: Rae Moar <rmoar@google.com>
---
I am leaving Google and am going through and cleaning up my @google.com
address in the relevant places. Note that Friday, November 7 2025 is my
last day at Google after which I will lose access to this email account
so any future updates or comments after Friday will come from my
@gmail.com account.

 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index d2edd256b19d..2fcf7e4a5cfd 100644
--- a/.mailmap
+++ b/.mailmap
@@ -642,6 +642,7 @@ Qais Yousef <qyousef@layalina.io> <qais.yousef@arm.com>
 Quentin Monnet <qmo@kernel.org> <quentin.monnet@netronome.com>
 Quentin Monnet <qmo@kernel.org> <quentin@isovalent.com>
 Quentin Perret <qperret@qperret.net> <quentin.perret@arm.com>
+Rae Moar <raemoar63@gmail.com> <rmoar@google.com>
 Rafael J. Wysocki <rjw@rjwysocki.net> <rjw@sisk.pl>
 Rajeev Nandan <quic_rajeevny@quicinc.com> <rajeevny@codeaurora.org>
 Rajendra Nayak <quic_rjendra@quicinc.com> <rnayak@codeaurora.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index 46126ce2f968..eefcff990987 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13601,7 +13601,7 @@ F:	fs/smb/server/
 KERNEL UNIT TESTING FRAMEWORK (KUnit)
 M:	Brendan Higgins <brendan.higgins@linux.dev>
 M:	David Gow <davidgow@google.com>
-R:	Rae Moar <rmoar@google.com>
+R:	Rae Moar <raemoar63@gmail.com>
 L:	linux-kselftest@vger.kernel.org
 L:	kunit-dev@googlegroups.com
 S:	Maintained

base-commit: 9de5f847ef8fa205f4fd704a381d32ecb5b66da9
-- 
2.51.1.851.g4ebd6896fd-goog


