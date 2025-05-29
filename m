Return-Path: <linux-kselftest+bounces-34022-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC7FAC8562
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 01:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0B94500270
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 23:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0276525CC51;
	Thu, 29 May 2025 23:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="DrOiVl4F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f226.google.com (mail-il1-f226.google.com [209.85.166.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8887E258CFA
	for <linux-kselftest@vger.kernel.org>; Thu, 29 May 2025 23:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748562463; cv=none; b=Unm52aPJnHFgoiyafC1YhXr3L9jnbGXco1ZVy+TBt0Ds3CTtOJQVRnCcxGnl373yplJtBXyMDG4pkM+D9o1ERsHDQrHVAghG0Y6wPBFyquic9xfe6iCjm/MfVrQoSZjo0Nbc1ub2Iu1KN6OvZ4VXPyYQ7DUM7S46fvdGlV/vA8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748562463; c=relaxed/simple;
	bh=UlVvBoGqKoKJcf+0ZFrctzlh1+h1AUFzmSOJWeWCcGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ljw5jeR8i8TrZuPnj7Rvd8sCZcmOIFps0lYd1acbBVLAvD8V9eZB2C2AYR5rgJ50PZOooALcaT5jL7xVp0f7wkdBodxLqmGPGI7qRJWCn9XrjLCWhW3Xyzgw4wDU5gcInYfo+Kac95BbM+ruUHCh09cytDpgMm7FbuGrcw3jCik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=DrOiVl4F; arc=none smtp.client-ip=209.85.166.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-il1-f226.google.com with SMTP id e9e14a558f8ab-3da831c17faso4746375ab.3
        for <linux-kselftest@vger.kernel.org>; Thu, 29 May 2025 16:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1748562457; x=1749167257; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EZFCCSYb7OQcdQGIOyhLYDx1YKKptgh0Rjc24K7ab4g=;
        b=DrOiVl4F3p/SU3cW1h8G7I9QsSGv6q+U2rT1UzpWyLIdXfILQiFXqXiv8AZyzB0qxY
         XpjJNvtHJpPYeega7SDHXH1dCkfMLKV1jhxif4C84ds8CrxRFVuMXPKGb0GnwlKWdQif
         uW0Y9xLKwwYVG31cOWZJ54gts4WJRztXOdVdwbUqnKJ8I6yxcS+BnDnXDh6ek//ovOgD
         wnkGUNTYfQY8bZ4kE7SfTsygHtezRYRMQSBnKgb9fUtFXLf4h4hkiATVp8yXtsajGE04
         qTKoV1/8g9qe8FtuuEElNag/8veQAlWmCuNAj8Q4SqVVFUeqsU4felCMf24Hc0Chx/pJ
         e1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748562457; x=1749167257;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZFCCSYb7OQcdQGIOyhLYDx1YKKptgh0Rjc24K7ab4g=;
        b=iI4TrSQLlXOhQdFrP6sVYSXIghc4/zC7l2W9aFeBNN+IJzXoCvrk85hXMNENdOuLCN
         vWJpVgzqp6CfAJTJYmipiorp9XooEYIyDbCfVkF6lMn2/AlyOlZC+bJIf4H5I9LTM7G/
         L5f/vzKhpQzSHQXRgz1wBTdhRwW/THv28rTKmVEzs3BSAo+UZHOswuwxeKkxiGNDtj7W
         JUOiAvWI2fxGP8hMqF/6VheOvjqW0J9yH46mEIYEW0dYubudtyV7nQcgeR2FkyyU3SMI
         oO8KYeBK1LXDxLn7hZBek4xDbA6HoN98lwiwtmZlU8Jym3buEi59lTlUnsaPhqQ8Bu2L
         Bg9A==
X-Forwarded-Encrypted: i=1; AJvYcCW5FnlsuNoGgZM6MmN8gKoyE9nAauVLqqz0vLpCnT+916GLlgtcOajMLn882uRSIpK2pqU3lobCgeccNTf6dbU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2L/W9wsI2A552Q5O/k72iGDYhr+tmUclmEn4izgyNreW+yAOv
	thLSMsQM0kDNgwnsjQNTupIdVmON/72LAoaVBn9LCzJlAPaYGqxBr2OKgo5AkMpx5ZgmuaVm6Fq
	r39KNJr45ief/wmm3KILseQIfKGu+2Ijiq6Ub
X-Gm-Gg: ASbGncur+2EqMTqS7KwYG2zYCXkuceLMeGCAzUWUZGwY9wNobiTG6umlEdo9a/vY6X7
	9gD+eQ6/NI27NIyL+c2waR9P0Lsz+G+iViwnfLf0+dQwm4RMiFK4PQvNvMe/QShix3RLnlb26w7
	zoYSzz3BAEUCu2vikzp9BzhCSoQW+dAwuo/GE0ArT3oLP6qEX1GRsgWr5/Lw00yZKozAC4oRl9w
	oQkSrWoYM0ekCmxM3ZwRgFeVVEtJQ9tesxGUz5KEYBYp1NYdqV/Dpj/3irl/6UlBaPypsvzqI31
	Oi6GiPYkFrxfvoLiCgtNCeDVGLVYGhOCimFW0i89q0WhRg==
X-Google-Smtp-Source: AGHT+IEmapYeqtmTfFncijI4MwHEFzRRnr1f1vhtV+NAcgKtHsK/Gh4LJUu8859z517RtmYPXqkV7MLrHRxh
X-Received: by 2002:a05:6e02:3c84:b0:3dc:8bb8:28b3 with SMTP id e9e14a558f8ab-3dd99bd00fbmr19760835ab.5.1748562457107;
        Thu, 29 May 2025 16:47:37 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3dd9353520dsm1277765ab.7.2025.05.29.16.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 16:47:37 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 2382234057A;
	Thu, 29 May 2025 17:47:35 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id DD5A2E4133C; Thu, 29 May 2025 17:47:34 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Thu, 29 May 2025 17:47:18 -0600
Subject: [PATCH v8 9/9] Documentation: ublk: document UBLK_F_PER_IO_DAEMON
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250529-ublk_task_per_io-v8-9-e9d3b119336a@purestorage.com>
References: <20250529-ublk_task_per_io-v8-0-e9d3b119336a@purestorage.com>
In-Reply-To: <20250529-ublk_task_per_io-v8-0-e9d3b119336a@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 Caleb Sander Mateos <csander@purestorage.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Explain the restrictions imposed on ublk servers in two cases:
1. When UBLK_F_PER_IO_DAEMON is set (current ublk_drv)
2. When UBLK_F_PER_IO_DAEMON is not set (legacy)

Remove most references to per-queue daemons, as the new
UBLK_F_PER_IO_DAEMON feature renders that concept obsolete.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 Documentation/block/ublk.rst | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
index 854f823b46c2add01d0b65ba36aecd26c45bb65d..c368e1081b4111c581567058f87ecb52db08758b 100644
--- a/Documentation/block/ublk.rst
+++ b/Documentation/block/ublk.rst
@@ -115,15 +115,15 @@ managing and controlling ublk devices with help of several control commands:
 
 - ``UBLK_CMD_START_DEV``
 
-  After the server prepares userspace resources (such as creating per-queue
-  pthread & io_uring for handling ublk IO), this command is sent to the
+  After the server prepares userspace resources (such as creating I/O handler
+  threads & io_uring for handling ublk IO), this command is sent to the
   driver for allocating & exposing ``/dev/ublkb*``. Parameters set via
   ``UBLK_CMD_SET_PARAMS`` are applied for creating the device.
 
 - ``UBLK_CMD_STOP_DEV``
 
   Halt IO on ``/dev/ublkb*`` and remove the device. When this command returns,
-  ublk server will release resources (such as destroying per-queue pthread &
+  ublk server will release resources (such as destroying I/O handler threads &
   io_uring).
 
 - ``UBLK_CMD_DEL_DEV``
@@ -208,15 +208,15 @@ managing and controlling ublk devices with help of several control commands:
   modify how I/O is handled while the ublk server is dying/dead (this is called
   the ``nosrv`` case in the driver code).
 
-  With just ``UBLK_F_USER_RECOVERY`` set, after one ubq_daemon(ublk server's io
-  handler) is dying, ublk does not delete ``/dev/ublkb*`` during the whole
+  With just ``UBLK_F_USER_RECOVERY`` set, after the ublk server exits,
+  ublk does not delete ``/dev/ublkb*`` during the whole
   recovery stage and ublk device ID is kept. It is ublk server's
   responsibility to recover the device context by its own knowledge.
   Requests which have not been issued to userspace are requeued. Requests
   which have been issued to userspace are aborted.
 
-  With ``UBLK_F_USER_RECOVERY_REISSUE`` additionally set, after one ubq_daemon
-  (ublk server's io handler) is dying, contrary to ``UBLK_F_USER_RECOVERY``,
+  With ``UBLK_F_USER_RECOVERY_REISSUE`` additionally set, after the ublk server
+  exits, contrary to ``UBLK_F_USER_RECOVERY``,
   requests which have been issued to userspace are requeued and will be
   re-issued to the new process after handling ``UBLK_CMD_END_USER_RECOVERY``.
   ``UBLK_F_USER_RECOVERY_REISSUE`` is designed for backends who tolerate
@@ -241,10 +241,11 @@ can be controlled/accessed just inside this container.
 Data plane
 ----------
 
-ublk server needs to create per-queue IO pthread & io_uring for handling IO
-commands via io_uring passthrough. The per-queue IO pthread
-focuses on IO handling and shouldn't handle any control & management
-tasks.
+The ublk server should create dedicated threads for handling I/O. Each
+thread should have its own io_uring through which it is notified of new
+I/O, and through which it can complete I/O. These dedicated threads
+should focus on IO handling and shouldn't handle any control &
+management tasks.
 
 The's IO is assigned by a unique tag, which is 1:1 mapping with IO
 request of ``/dev/ublkb*``.
@@ -265,6 +266,18 @@ with specified IO tag in the command data:
   destined to ``/dev/ublkb*``. This command is sent only once from the server
   IO pthread for ublk driver to setup IO forward environment.
 
+  Once a thread issues this command against a given (qid,tag) pair, the thread
+  registers itself as that I/O's daemon. In the future, only that I/O's daemon
+  is allowed to issue commands against the I/O. If any other thread attempts
+  to issue a command against a (qid,tag) pair for which the thread is not the
+  daemon, the command will fail. Daemons can be reset only be going through
+  recovery.
+
+  The ability for every (qid,tag) pair to have its own independent daemon task
+  is indicated by the ``UBLK_F_PER_IO_DAEMON`` feature. If this feature is not
+  supported by the driver, daemons must be per-queue instead - i.e. all I/Os
+  associated to a single qid must be handled by the same task.
+
 - ``UBLK_IO_COMMIT_AND_FETCH_REQ``
 
   When an IO request is destined to ``/dev/ublkb*``, the driver stores

-- 
2.34.1


