Return-Path: <linux-kselftest+bounces-34003-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC9BAC8062
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 17:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACB053B4CAD
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 15:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4E522D4E7;
	Thu, 29 May 2025 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Og1/hzYC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D6D193062
	for <linux-kselftest@vger.kernel.org>; Thu, 29 May 2025 15:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748533046; cv=none; b=ZswgZGUpYLoOpJXdxJ8lmUi8D4g6STPvaoUxLQwxdWtCJA2TbEBcV4V6eZgzadOxpH2EN27E+Rvo3QzwhHhq4/ypCG7wJPjDIrJuRfgpTziczXVLjXWwMdxtdNcHE56JueGV2wlUWSfI6Bz9DYmuFoT2/kdCi3UXL1tpTtC3leI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748533046; c=relaxed/simple;
	bh=ez++nQ6eQ/bNEBedX2r5tJzndip4SHY8CYLiGExrUwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AmLsTfoBaKrZw1TQf3bq26TlwzAlE1+LgTPy9LX9mBRHZQUj0tU4POkP6x/y2EnzKIssMIxvZhK61AWkXQPT9f99SRygT2+B+SGUDuruLBDk9p9xzEs8a+xrN6zglOLfMPk08bvXccoA9M1yBs0KhZUJBzosu1ZZ0iuFXA0/GcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Og1/hzYC; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3032a9c7cfeso155708a91.1
        for <linux-kselftest@vger.kernel.org>; Thu, 29 May 2025 08:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1748533043; x=1749137843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ZgHKofniMCHBPOLmSniYcU9oktNJXk4n2YuyJ8HL1I=;
        b=Og1/hzYC4Miy63T1vfwQWm2ki/PgKri4UnAHd6tQkL55Keqe0TZP737o8FU3IC+4kB
         wHdHECdxWU4/FATHi1LT8Ck/4hr5GtJ1L5DQaqekQmDIuKpEgpFeco2lFJ4kMYt315mC
         AATI2B7kB2aKwdIfmdRlSQQ6aW72iyVRl5w6axBvpbczXXqYoVI2Xlpr/qfJiIkFJas7
         MmJuYhIacyiZoKZSpqgtRFg35TpyovLPN0L5Q0cuDXuH5p8CVsOCkGauo3bb/canYrJf
         kFCJFlk3Bo+2TosthQKQaj//eHBmcab0PvzveR8fmItL5UReeQ7zPiZ/V/Q4CrMJSksA
         /Edw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748533043; x=1749137843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ZgHKofniMCHBPOLmSniYcU9oktNJXk4n2YuyJ8HL1I=;
        b=ecAfTZ6m5hX+66LncUHI8zgln+2TDKj+MDlnNNJPA88PCpHiqUicq3hdO25i19SxTO
         gbGXpnZWswGv5jfUApAPqdvkgjeXBcsNR67SdMeI1vzFGlaI5BCS8AxZp0aF0hYlWwZM
         nu1kJB4Taim1zz1CvEQx5vaG4fMPlZjCRgSFn921eXJgj2sFyp2VSvld35gIsM8AHd74
         XH6PWNUOGSe8WcIKi5pp50ZD53AirzXMNUI9rHmdwnARpVBdxdywD/K2+tflH83e5AU7
         DwrAFeiYn2vINNTrQuCUsgtQfqwzPZ45uB8X0S+GE5J9efgv0Vl8nnzbvMJDoq0j6MML
         8vEw==
X-Forwarded-Encrypted: i=1; AJvYcCXSGzMdQVEsdl5fVnMuDs3d7v04zSv4bEJaiUmXlL1D/VVWfl7YUz1DJucozlH4bgSTSnS9wI3lM3t/HD3VLiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn33nWtn97Fjvf0JV/g4APpzcjCCfx1uOkw/hijQ0htbsDEvul
	NSA1UqgdwgcH7uKesY8BVNXWg1O4hKyqoKVrO1aNvs+Kq0GrfuYHhCgkuw6nmSmxDhz9mAbNeFC
	VUpGmc9Bdu7KxhyO6HP2CJOpN81S5OwhFFQA1VU7rfA==
X-Gm-Gg: ASbGncvD6ZH5iyWlp/egATvrFpyyRQbCa2/mBcBphg/6gta7SHSG4pgf941DVjL9gNw
	S0KBTHpXR/uRkF9q/EmY+BoGScBQmveOaqqWPGS3DiWDUckR6ZCxq6SIFS5+f41VCF1K8WK/1Lb
	OFEJXZZMdSMdTIhQGJAN3JdJRqmFoMvlQ=
X-Google-Smtp-Source: AGHT+IG9fcfF8Yj+alFMVfBsn+HsgNxT1l1z3oGfVPZrgAfBDHDKaeueRlnFLM9n2FdPvWesA69J27u54rc8uvLjplQ=
X-Received: by 2002:a17:90b:17c8:b0:311:9c9a:58e8 with SMTP id
 98e67ed59e1d1-31241b8630dmr22341a91.7.1748533042744; Thu, 29 May 2025
 08:37:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527-ublk_task_per_io-v7-0-cbdbaf283baa@purestorage.com>
 <20250527-ublk_task_per_io-v7-1-cbdbaf283baa@purestorage.com> <aDgwGoGCEpwd1mFY@fedora>
In-Reply-To: <aDgwGoGCEpwd1mFY@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 29 May 2025 08:37:10 -0700
X-Gm-Features: AX0GCFslLVzXTgzehzu0xxEXzgjYd94qs_wIJN308v3oCtCfOOqscgnL5smokBY
Message-ID: <CADUfDZoGyXBeV0DYPqYwSNan4M-oyOcujmt2-_HVm+AtuhFUug@mail.gmail.com>
Subject: Re: [PATCH v7 1/8] ublk: have a per-io daemon instead of a per-queue daemon
To: Ming Lei <ming.lei@redhat.com>
Cc: Uday Shankar <ushankar@purestorage.com>, Jens Axboe <axboe@kernel.dk>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 3:00=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Tue, May 27, 2025 at 05:01:24PM -0600, Uday Shankar wrote:
> > Currently, ublk_drv associates to each hardware queue (hctx) a unique
> > task (called the queue's ubq_daemon) which is allowed to issue
> > COMMIT_AND_FETCH commands against the hctx. If any other task attempts
> > to do so, the command fails immediately with EINVAL. When considered
> > together with the block layer architecture, the result is that for each
> > CPU C on the system, there is a unique ublk server thread which is
> > allowed to handle I/O submitted on CPU C. This can lead to suboptimal
> > performance under imbalanced load generation. For an extreme example,
> > suppose all the load is generated on CPUs mapping to a single ublk
> > server thread. Then that thread may be fully utilized and become the
> > bottleneck in the system, while other ublk server threads are totally
> > idle.
> >
> > This issue can also be addressed directly in the ublk server without
> > kernel support by having threads dequeue I/Os and pass them around to
> > ensure even load. But this solution requires inter-thread communication
> > at least twice for each I/O (submission and completion), which is
> > generally a bad pattern for performance. The problem gets even worse
> > with zero copy, as more inter-thread communication would be required to
> > have the buffer register/unregister calls to come from the correct
> > thread.
> >
> > Therefore, address this issue in ublk_drv by allowing each I/O to have
> > its own daemon task. Two I/Os in the same queue are now allowed to be
> > serviced by different daemon tasks - this was not possible before.
> > Imbalanced load can then be balanced across all ublk server threads by
> > having the ublk server threads issue FETCH_REQs in a round-robin manner=
.
> > As a small toy example, consider a system with a single ublk device
> > having 2 queues, each of depth 4. A ublk server having 4 threads could
> > issue its FETCH_REQs against this device as follows (where each entry i=
s
> > the qid,tag pair that the FETCH_REQ targets):
> >
> > ublk server thread:   T0      T1      T2      T3
> >                       0,0     0,1     0,2     0,3
> >                       1,3     1,0     1,1     1,2
> >
> > This setup allows for load that is concentrated on one hctx/ublk_queue
> > to be spread out across all ublk server threads, alleviating the issue
> > described above.
> >
> > Add the new UBLK_F_PER_IO_DAEMON feature to ublk_drv, which ublk server=
s
> > can use to essentially test for the presence of this change and tailor
> > their behavior accordingly.
> >
> > Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> > Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
>
> This patch looks close to go, just one panic triggered immediately by
> the following steps, I think it needs to be addressed first.
>
> Maybe we need to add one such stress test for UBLK_F_PER_IO_DAEMON too.
>
>
> 1) run heavy IO:
>
> [root@ktest-40 ublk]# ./kublk add -t null -q 2 --nthreads 4 --per_io_task=
s
> dev id 0: nr_hw_queues 2 queue_depth 128 block size 512 dev_capacity 5242=
88000
>         max rq size 1048576 daemon pid 1283 flags 0x2042 state LIVE
>         queue 0: affinity(0 )
>         queue 1: affinity(8 )
> [root@ktest-40 ublk]#
> [root@ktest-40 ublk]# ~/git/fio/t/io_uring -p 0 -n 8 /dev/ublkb0
>
> Or
>
> `fio -numjobs=3D8 --ioengine=3Dlibaio --iodepth=3D128 --iodepth_batch_sub=
mit=3D32 \
>         --iodepth_batch_complete_min=3D32`
>
> 2) panic immediately:
>
> [   51.297750] BUG: kernel NULL pointer dereference, address: 00000000000=
00000
> [   51.298719] #PF: supervisor read access in kernel mode
> [   51.299403] #PF: error_code(0x0000) - not-present page
> [   51.300069] PGD 1161c8067 P4D 1161c8067 PUD 11a793067 PMD 0
> [   51.300825] Oops: Oops: 0000 [#1] SMP NOPTI
> [   51.301389] CPU: 0 UID: 0 PID: 1285 Comm: kublk Not tainted 6.15.0+ #2=
88 PREEMPT(full)
> [   51.302375] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1=
.16.3-1.fc39 04/01/2014
> [   51.303551] RIP: 0010:io_uring_cmd_done+0xa7/0x1d0
> [   51.304226] Code: 48 89 f1 48 89 f0 48 83 e1 bf 80 cc 01 48 81 c9 00 0=
1 80 00 83 e6 40 48 0f 45 c1 48 89 43 48 44 89 6b 58 c7 43 5c 00 00 00 00 <=
8b> 07 f6 c4 08 74 12 48 89 93 e8 00 00 0
> [   51.306554] RSP: 0018:ffffd1da436e3a40 EFLAGS: 00010246
> [   51.307253] RAX: 0000000000000100 RBX: ffff8d9cd3737300 RCX: 000000000=
0000001
> [   51.308178] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000000
> [   51.309333] RBP: 0000000000000001 R08: 0000000000000018 R09: 000000000=
0190015
> [   51.310744] R10: 0000000000190015 R11: 0000000000000035 R12: ffff8d9cd=
1c7c000
> [   51.311986] R13: 0000000000000000 R14: 0000000000000000 R15: 000000000=
0000000
> [   51.313386] FS:  00007f2c293916c0(0000) GS:ffff8da179df6000(0000) knlG=
S:0000000000000000
> [   51.314899] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   51.315926] CR2: 0000000000000000 CR3: 00000001161c9002 CR4: 000000000=
0772ef0
> [   51.317179] PKRU: 55555554
> [   51.317682] Call Trace:
> [   51.318040]  <TASK>
> [   51.318355]  ublk_cmd_list_tw_cb+0x30/0x40 [ublk_drv]
> [   51.319061]  __io_run_local_work_loop+0x72/0x80
> [   51.319696]  __io_run_local_work+0x69/0x1e0
> [   51.320274]  io_cqring_wait+0x8f/0x6a0
> [   51.320794]  __do_sys_io_uring_enter+0x500/0x770
> [   51.321422]  do_syscall_64+0x82/0x170
> [   51.321891]  ? __do_sys_io_uring_enter+0x500/0x770

Maybe we need to keep the ubq !=3D this_q check in ublk_queue_rqs() in
addition to io->task !=3D this_io->task? I'm not quite sure how a single
plug would end up with requests for multiple hctxs on the same ublk
device. But nvme_queue_rqs() checks this too, so presumably it is
possible. And ublk_cmd_list_tw_cb() assumes all requests in
pdu->req_list belong to the same ubq.

Best,
Caleb

