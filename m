Return-Path: <linux-kselftest+bounces-32616-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDC2AAEE0F
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 23:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C67949E2683
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 21:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FF528FFD8;
	Wed,  7 May 2025 21:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bbe1FQYy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f228.google.com (mail-il1-f228.google.com [209.85.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FE2253B4A
	for <linux-kselftest@vger.kernel.org>; Wed,  7 May 2025 21:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746654595; cv=none; b=hvgYh+rDqRPb9SDJUce+T4OL7Wbq/olq/jiwk53pKKSUMvKkAzbfUyr3cdO57KGpt7eR7qnpBxSlcc+PwDA4Z+5bOaKw2OC65Pq+8SW4DBC4EKxXzMRHHodzXD5X8GqxdyYfj7CpZwBs4VrvkkQFlcvqtM8yv1Se6PHog4CuubQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746654595; c=relaxed/simple;
	bh=GH638GY73r0Mdx5gXs4XdWZrOecOpLJcjLkaiWFYBrs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CIogbQbyAn+McOT1/52ElUbb7a3UX24VXpG+LBpVrlOzn8h4EGfpb63GSmpJn1FFUZSOYkqDLTzdryUcBFIFbuTCvGKix6d0bV/mLITBt+HFQomBbVd436iPrMs+QkEep38tlq9fQAY9JhV2owyX2SHTUjJSV6UslZM7bjhC3dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bbe1FQYy; arc=none smtp.client-ip=209.85.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-il1-f228.google.com with SMTP id e9e14a558f8ab-3da7642b5deso1489485ab.2
        for <linux-kselftest@vger.kernel.org>; Wed, 07 May 2025 14:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1746654590; x=1747259390; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LlFzXt2hHWUpYx58m/1na3BQhxXxvWmUQd43rvkUPu4=;
        b=bbe1FQYyY+njdlft6If1Iumzz7Hs2nR7KiSNbGwUwJJdtSQmKBJuSn68jPgbZXqOkA
         KZo8W0lOQtxJ/r/gT1DaGXswYDZYQI1KwgpG9rB3EI6b7ZjNnUbeJp4zNzYChYAST6xb
         2pHTUT6+0sl9TUBnjr18ccfe7CZoGo4Wp6cRNIfnAVdXDY3mSZ4Gzx70dN0x2TgpmccH
         0grD2X1cZpvNwfUIcWt8ASBEW0V1z4TSw0HoiZ4TXNTf3UJI3x5trVYxK58cg1YvDTk6
         dArhHx1475vg1m5kMk2rMfuSVr80WNQaGXt5/gXBn3tDAbugoLCL2EyTc1Z9JUNjA6qB
         5gCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746654590; x=1747259390;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LlFzXt2hHWUpYx58m/1na3BQhxXxvWmUQd43rvkUPu4=;
        b=Kw8J3/TmfnuCS6CLL+2dpW96L5gRlOca8VmTVfCkjYJ3BIx64d3+UTFzi4ypRBrLh3
         UxQAcMy8HDJIu7N477rZ+OA0SXGDY9VlHd4b7+UBXkW1YlE0bhUzuQGUCtrPHIh3NrH4
         aPmO7iuUiOvavGnyJiZHCWfYxgnUTJYcDWRvyI4wKUn+0tdP3YWcq6tFF0+c7a2KYErW
         fcpwqrdL++CL2Brjsly+mdDrn+oKfyJ2SWjTk1d393ZMDl9f8T23APxaFqpMYlcyBhMF
         rehAFvuVI2KmKdNxAPXpu8uYf/2V+U1fFK+iZH9N/5SMadLhukuv4bZCkHIapELgK5mA
         C5oQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5mHOT/aA+frbkM1RtXgedLpGbvRbXS3REiJ6r96StIz4OYzqIIiVRLrVGFWuGe47mtql7DstTIGNHn+b3UeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjCawBrESYD3rLdbeC4rESzIzxOwaQ0F2pkOo4J6eWS6SVmpdD
	cIITw/Hyj77nPDbdrfXKApA/fru/0B2P8EMbGHLq/z1UqUugEb5RbVy15XRQwjedrM/RI5D5KoK
	BpSoni3xeXE8dwh1m/00837E0ZRhy1xG2
X-Gm-Gg: ASbGncsGseaQn/t+1L8a2L72jzstcCxIyF1x2WIHfTYcjB/qSWAMqjVTTrhsxphl5pf
	lmcRlFTerPlR6oDUYFMyKBrD9M2ovDwZ0CzkO05LKzHHGi45P+mEJCzOqFAj50eVQi/tTZXWxo7
	JLIIhSAuB3w9C8ijvZvuY8tWP/z6ciYlmvwJ6aiigYJ6Tlz2KQMBOZzcTR946N0HEBclGvChJul
	4PuN/qwcsq8GhmVBW0qAAYYxT0pSjdcP6TMaH2Qpphbc/4M6++LgptbduuL+xQUwS2XHSG3CDgJ
	vaar0CVqtCDW6L0NBlxtbRwBkKg+FupRsbdydMFrIw3uyw==
X-Google-Smtp-Source: AGHT+IHiE3AbjUxsTTNoeWc14v4DyZF9G4LPQtQ+ZRF7G5I0SC25C/5ymJCmeOQ+YE/QyiamUzwfJ8o9cF1F
X-Received: by 2002:a05:6e02:1aa6:b0:3da:7176:81c3 with SMTP id e9e14a558f8ab-3da785af2b9mr17210585ab.22.1746654590265;
        Wed, 07 May 2025 14:49:50 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-4f88aa9cf6csm2207849173.69.2025.05.07.14.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 14:49:50 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 6874E340C23;
	Wed,  7 May 2025 15:49:49 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 63DC1E40A46; Wed,  7 May 2025 15:49:49 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Wed, 07 May 2025 15:49:42 -0600
Subject: [PATCH v6 8/8] Documentation: ublk: document UBLK_F_RR_TAGS
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-ublk_task_per_io-v6-8-a2a298783c01@purestorage.com>
References: <20250507-ublk_task_per_io-v6-0-a2a298783c01@purestorage.com>
In-Reply-To: <20250507-ublk_task_per_io-v6-0-a2a298783c01@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 Caleb Sander Mateos <csander@purestorage.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Document the new flag UBLK_F_RR_TAGS along with its intended use case.
Also describe the new restrictions on threading model imposed by
ublk_drv (one (qid,tag) pair is can be served by only one thread), and
remove references to ubq_daemon/per-queue threads, since such a concept
no longer exists.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 Documentation/block/ublk.rst | 83 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 72 insertions(+), 11 deletions(-)

diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
index 854f823b46c2add01d0b65ba36aecd26c45bb65d..e9cbabdd69c5539a02463780ba5e51de0416c3f6 100644
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
@@ -265,6 +266,13 @@ with specified IO tag in the command data:
   destined to ``/dev/ublkb*``. This command is sent only once from the server
   IO pthread for ublk driver to setup IO forward environment.
 
+  Once a thread issues this command against a given (qid,tag) pair, the thread
+  registers itself as that I/O's daemon. In the future, only that I/O's daemon
+  is allowed to issue commands against the I/O. If any other thread attempts
+  to issue a command against a (qid,tag) pair for which the thread is not the
+  daemon, the command will fail. Daemons can be reset only be going through
+  recovery.
+
 - ``UBLK_IO_COMMIT_AND_FETCH_REQ``
 
   When an IO request is destined to ``/dev/ublkb*``, the driver stores
@@ -309,6 +317,59 @@ with specified IO tag in the command data:
   ``UBLK_IO_COMMIT_AND_FETCH_REQ`` to the server, ublkdrv needs to copy
   the server buffer (pages) read to the IO request pages.
 
+Load balancing
+--------------
+
+A simple approach to designing a ublk server might involve selecting a
+number of I/O handler threads N, creating devices with N queues, and
+pairing up I/O handler threads with queues, so that each thread gets a
+unique qid, and it issues ``FETCH_REQ``s against all tags for that qid.
+Indeed, before the introduction of the ``UBLK_F_RR_TAGS`` feature, this
+was essentially the only option (*)
+
+This approach can run into performance issues under imbalanced load.
+This architecture taken together with the `blk-mq architecture
+<https://docs.kernel.org/block/blk-mq.html>`_ implies that there is a
+fixed mapping from I/O submission CPU to the ublk server thread that
+handles it. If the workload is CPU-bottlenecked, only allowing one ublk
+server thread to handle all the I/O generated from a single CPU can
+limit peak bandwidth.
+
+To address this issue, two changes were made:
+
+- ublk servers can now pair up threads with I/Os (i.e. (qid,tag) pairs)
+  arbitrarily. In particular, the preexisting restriction that all I/Os
+  in one queue must be served by the same thread is lifted.
+- ublk servers can now specify ``UBLK_F_RR_TAGS`` when creating a ublk
+  device to get round-robin tag allocation on each queue
+
+The ublk server can check for the presence of these changes by testing
+for the ``UBLK_F_RR_TAGS`` feature.
+
+With these changes, a ublk server can balance load as follows:
+
+- create the device with ``UBLK_F_RR_TAGS`` set in
+  ``ublksrv_ctrl_dev_info::flags`` when issuing the ``ADD_DEV`` command
+- issue ``FETCH_REQ``s from ublk server threads to (qid,tag) pairs in
+  a round-robin manner. For example, for a device configured with
+  ``nr_hw_queues=2`` and ``queue_depth=4``, and a ublk server having 4
+  I/O handling threads, ``FETCH_REQ``s could be issued as follows, where
+  each entry in the table is the pair (``ublksrv_io_cmd::q_id``,
+  ``ublksrv_io_cmd::tag``) in the payload of the ``FETCH_REQ``.
+
+  ======== ======== ======== ========
+  thread 0 thread 1 thread 2 thread 3
+  ======== ======== ======== ========
+  (0, 0)   (0, 1)   (0, 2)   (0, 3)
+  (1, 3)   (1, 0)   (1, 1)   (1, 2)
+
+With this setup, I/O submitted on a CPU which maps to queue 0 will be
+balanced across all threads instead of all landing on the same thread.
+Thus, a potential bottleneck is avoided.
+
+(*) technically, one I/O handling thread could service multiple queues
+if it wanted to, but that doesn't help with imbalanced load
+
 Zero copy
 ---------
 

-- 
2.34.1


