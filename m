Return-Path: <linux-kselftest+bounces-34005-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69237AC8071
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 17:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C1D37AB9E1
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 15:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDB922D4FD;
	Thu, 29 May 2025 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="SWrf5lir"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD5522D4E7
	for <linux-kselftest@vger.kernel.org>; Thu, 29 May 2025 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748533210; cv=none; b=kjHrXF2LYqI/zpPhXKK8opptjuq8PbrDv9lyrnj/7Mh3Jcyby8QfxPM0O90IH9mSSNqV1y5gLJGpAqM/7NjLuyNqF4hKB4s26mEfP312wftxw+uoClCxeuE89/tOpsUbcK9FXt3IVsZQPwqZUaLl88atNZ2jvMpbuIanCQlQiuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748533210; c=relaxed/simple;
	bh=4EGL7UDbDwh9+TMUTJL1NN8UWmiOn26LXoaURXka3/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LKPvSqVmV3vxxeu7xoceu5mzdm91zwPGlrELj6sGmD9xOug+BoRr5eNM3nf4G3mMIuOc68crwfTsTr26fBylJSF7vuIc4NSItCD/nDzJc/z4HgqkJD/r8W95qpwUtQRsnc3sgaXPECXnK7kqTZjrRXpsmZMF3Rddhm5+kcX8+M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=SWrf5lir; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-31232d5b1deso46206a91.3
        for <linux-kselftest@vger.kernel.org>; Thu, 29 May 2025 08:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1748533207; x=1749138007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8aON0xig5WGpGEqEeXn/pi26djEsycEYnATclzKJlg=;
        b=SWrf5lirEA3tsRa+qhte7EJ79QWQzXt4NYdBztxaPot7k+8/RD4vZaVjaLwcJ/4lPt
         Vn9KiUCLnFm5KR+NbuUWCtgQcq98GTiZWP1s4ZMZqpd/N9g6KFGnEKiJPA8oi3cNhzpD
         zAzU+PpIu2Nx+W4E3gFECokKnaHy/M66bjJAM9LrGoJkwSBeNQgQ/+SrTtkOyPprIRw9
         MyvG5xTV5RGsFFMrjEu9q2WSG0M5joAmlNa75OrG8AT1G67CFDL3Sk2EGxCx9arhhGBV
         +QoKkhlKmMlyROvZdobMluYdVTXWiKj7VPIkvT5qEOx9pMpdi2aGIpLwaDNaIYMTZBvK
         /AlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748533207; x=1749138007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8aON0xig5WGpGEqEeXn/pi26djEsycEYnATclzKJlg=;
        b=TqJK4wmZQb+o6PdbWAqgWbQUOB7YAVgf+e7zp+F8LiphVk3u6ZMXubU10MOuSznb3m
         H7pWrE8qri+6v608LnVd+5YwxsEOTFDPzWwsSJarzFw5IAjMw0SPAUH/Np90C5gWjRcp
         5Y6E5E8CgMduve/tEyMuzDrJbRKWiTQ9wt89/hmw5ZOFj1y9yRcX/NQAMbxsWGrXCTEZ
         VGn9m0UuFdqURHnrToM07AJtUP3pfCedeXL7z7EBzNi26ksrUtqpa3HQ3o4BYeJKBxum
         USVO+KipgHBEAEuFW9B5eeLIxwbM4OKebnhFfC9Pp1zCT/04ueNp2TF5P93rVEGHaNzW
         KkmQ==
X-Forwarded-Encrypted: i=1; AJvYcCU01Cg6wAQsTUKs/zCXwG3hFFZ3kxC1FPFVOsdm/QWxSuL/KNcCYfUBUQUtfqh94nEdrVzVw+yjXiBISPPj95k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEWJw5jXD3A2nLdiy1kH2vlXSe6cuqH+lB5Pb1ZGeKuxhky238
	bGEba1QYWUa4zbRvbLUq+OniQSOu20gIzGBzwOdpQksWf+SacqCfADebbdkv1rX879tCiwl9DX6
	LnMHRROnbd5r30XnMMbQo1RyU3sH9SlTop/ZAkwwreQ==
X-Gm-Gg: ASbGncu33fwsXOyh+gFQTKtZWwk47edHkgDIdfzwI5Dh0QZnqLIVyVEdSW0C2iCPHgV
	6I7Wn9P5Cf/S3bmHDbEB2wtFGFGWqivLEFzU0ut0sgXCEYiQa8jtoPDJLDAlMRcrhTYd9B/XTrb
	YdMMt6YeFZBd2FdDk0bAYzsIXB49Rux70=
X-Google-Smtp-Source: AGHT+IGodYlEAsoVKQu14v3mpF6pGzUWZbIK8kGZlrJHkgSJbaDmt30Jfh6NJeed3cIf0rPshA27hSimMejN6YL+XMo=
X-Received: by 2002:a17:90b:4ad1:b0:311:b0d3:851 with SMTP id
 98e67ed59e1d1-31241c88090mr25688a91.4.1748533207211; Thu, 29 May 2025
 08:40:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527-ublk_task_per_io-v7-0-cbdbaf283baa@purestorage.com> <20250527-ublk_task_per_io-v7-1-cbdbaf283baa@purestorage.com>
In-Reply-To: <20250527-ublk_task_per_io-v7-1-cbdbaf283baa@purestorage.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 29 May 2025 08:39:55 -0700
X-Gm-Features: AX0GCFsLB4o-4Ph3xOnq9q137mEOpgnwdZYKf2R1fdPx12coFQYruoVDjru0nbE
Message-ID: <CADUfDZrAJQdKS8htMZotwvExCF3KqeX_ogZuehtK0stFy_qnaQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/8] ublk: have a per-io daemon instead of a per-queue daemon
To: Uday Shankar <ushankar@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 4:01=E2=80=AFPM Uday Shankar <ushankar@purestorage.=
com> wrote:
>
> Currently, ublk_drv associates to each hardware queue (hctx) a unique
> task (called the queue's ubq_daemon) which is allowed to issue
> COMMIT_AND_FETCH commands against the hctx. If any other task attempts
> to do so, the command fails immediately with EINVAL. When considered
> together with the block layer architecture, the result is that for each
> CPU C on the system, there is a unique ublk server thread which is
> allowed to handle I/O submitted on CPU C. This can lead to suboptimal
> performance under imbalanced load generation. For an extreme example,
> suppose all the load is generated on CPUs mapping to a single ublk
> server thread. Then that thread may be fully utilized and become the
> bottleneck in the system, while other ublk server threads are totally
> idle.
>
> This issue can also be addressed directly in the ublk server without
> kernel support by having threads dequeue I/Os and pass them around to
> ensure even load. But this solution requires inter-thread communication
> at least twice for each I/O (submission and completion), which is
> generally a bad pattern for performance. The problem gets even worse
> with zero copy, as more inter-thread communication would be required to
> have the buffer register/unregister calls to come from the correct
> thread.
>
> Therefore, address this issue in ublk_drv by allowing each I/O to have
> its own daemon task. Two I/Os in the same queue are now allowed to be
> serviced by different daemon tasks - this was not possible before.
> Imbalanced load can then be balanced across all ublk server threads by
> having the ublk server threads issue FETCH_REQs in a round-robin manner.
> As a small toy example, consider a system with a single ublk device
> having 2 queues, each of depth 4. A ublk server having 4 threads could
> issue its FETCH_REQs against this device as follows (where each entry is
> the qid,tag pair that the FETCH_REQ targets):
>
> ublk server thread:     T0      T1      T2      T3
>                         0,0     0,1     0,2     0,3
>                         1,3     1,0     1,1     1,2
>
> This setup allows for load that is concentrated on one hctx/ublk_queue
> to be spread out across all ublk server threads, alleviating the issue
> described above.
>
> Add the new UBLK_F_PER_IO_DAEMON feature to ublk_drv, which ublk servers
> can use to essentially test for the presence of this change and tailor
> their behavior accordingly.
>
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  drivers/block/ublk_drv.c      | 108 +++++++++++++++++++++---------------=
------
>  include/uapi/linux/ublk_cmd.h |   9 ++++
>  2 files changed, 64 insertions(+), 53 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 1b47341962d095830a02e07418815f633fa9ed8a..60d4a0251339dd0a56760e9c5=
82d394c8b386661 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -69,7 +69,8 @@
>                 | UBLK_F_USER_RECOVERY_FAIL_IO \
>                 | UBLK_F_UPDATE_SIZE \
>                 | UBLK_F_AUTO_BUF_REG \
> -               | UBLK_F_QUIESCE)
> +               | UBLK_F_QUIESCE \
> +               | UBLK_F_PER_IO_DAEMON)
>
>  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
>                 | UBLK_F_USER_RECOVERY_REISSUE \
> @@ -166,6 +167,8 @@ struct ublk_io {
>                 /* valid if UBLK_IO_FLAG_OWNED_BY_SRV is set */
>                 struct request *req;
>         };
> +
> +       struct task_struct *task;
>  };
>
>  struct ublk_queue {
> @@ -173,11 +176,9 @@ struct ublk_queue {
>         int q_depth;
>
>         unsigned long flags;
> -       struct task_struct      *ubq_daemon;
>         struct ublksrv_io_desc *io_cmd_buf;
>
>         bool force_abort;
> -       bool timeout;
>         bool canceling;
>         bool fail_io; /* copy of dev->state =3D=3D UBLK_S_DEV_FAIL_IO */
>         unsigned short nr_io_ready;     /* how many ios setup */
> @@ -1099,11 +1100,6 @@ static inline struct ublk_uring_cmd_pdu *ublk_get_=
uring_cmd_pdu(
>         return io_uring_cmd_to_pdu(ioucmd, struct ublk_uring_cmd_pdu);
>  }
>
> -static inline bool ubq_daemon_is_dying(struct ublk_queue *ubq)
> -{
> -       return !ubq->ubq_daemon || ubq->ubq_daemon->flags & PF_EXITING;
> -}
> -
>  /* todo: handle partial completion */
>  static inline void __ublk_complete_rq(struct request *req)
>  {
> @@ -1275,13 +1271,13 @@ static void ublk_dispatch_req(struct ublk_queue *=
ubq,
>         /*
>          * Task is exiting if either:
>          *
> -        * (1) current !=3D ubq_daemon.
> +        * (1) current !=3D io->task.
>          * io_uring_cmd_complete_in_task() tries to run task_work
> -        * in a workqueue if ubq_daemon(cmd's task) is PF_EXITING.
> +        * in a workqueue if cmd's task is PF_EXITING.
>          *
>          * (2) current->flags & PF_EXITING.
>          */
> -       if (unlikely(current !=3D ubq->ubq_daemon || current->flags & PF_=
EXITING)) {
> +       if (unlikely(current !=3D io->task || current->flags & PF_EXITING=
)) {
>                 __ublk_abort_rq(ubq, req);
>                 return;
>         }
> @@ -1341,13 +1337,12 @@ static void ublk_cmd_list_tw_cb(struct io_uring_c=
md *cmd,
>         } while (rq);
>  }
>
> -static void ublk_queue_cmd_list(struct ublk_queue *ubq, struct rq_list *=
l)
> +static void ublk_queue_cmd_list(struct ublk_io *io, struct rq_list *l)
>  {
> -       struct request *rq =3D rq_list_peek(l);
> -       struct io_uring_cmd *cmd =3D ubq->ios[rq->tag].cmd;
> +       struct io_uring_cmd *cmd =3D io->cmd;
>         struct ublk_uring_cmd_pdu *pdu =3D ublk_get_uring_cmd_pdu(cmd);
>
> -       pdu->req_list =3D rq;
> +       pdu->req_list =3D rq_list_peek(l);
>         rq_list_init(l);
>         io_uring_cmd_complete_in_task(cmd, ublk_cmd_list_tw_cb);
>  }
> @@ -1355,13 +1350,10 @@ static void ublk_queue_cmd_list(struct ublk_queue=
 *ubq, struct rq_list *l)
>  static enum blk_eh_timer_return ublk_timeout(struct request *rq)
>  {
>         struct ublk_queue *ubq =3D rq->mq_hctx->driver_data;
> +       struct ublk_io *io =3D &ubq->ios[rq->tag];
>
>         if (ubq->flags & UBLK_F_UNPRIVILEGED_DEV) {
> -               if (!ubq->timeout) {
> -                       send_sig(SIGKILL, ubq->ubq_daemon, 0);
> -                       ubq->timeout =3D true;
> -               }
> -
> +               send_sig(SIGKILL, io->task, 0);
>                 return BLK_EH_DONE;
>         }
>
> @@ -1429,24 +1421,25 @@ static void ublk_queue_rqs(struct rq_list *rqlist=
)
>  {
>         struct rq_list requeue_list =3D { };
>         struct rq_list submit_list =3D { };
> -       struct ublk_queue *ubq =3D NULL;
> +       struct ublk_io *io =3D NULL;
>         struct request *req;
>
>         while ((req =3D rq_list_pop(rqlist))) {
>                 struct ublk_queue *this_q =3D req->mq_hctx->driver_data;
> +               struct ublk_io *this_io =3D &this_q->ios[req->tag];
>
> -               if (ubq && ubq !=3D this_q && !rq_list_empty(&submit_list=
))
> -                       ublk_queue_cmd_list(ubq, &submit_list);
> -               ubq =3D this_q;
> +               if (io && io->task !=3D this_io->task && !rq_list_empty(&=
submit_list))
> +                       ublk_queue_cmd_list(io, &submit_list);
> +               io =3D this_io;
>
> -               if (ublk_prep_req(ubq, req, true) =3D=3D BLK_STS_OK)
> +               if (ublk_prep_req(this_q, req, true) =3D=3D BLK_STS_OK)
>                         rq_list_add_tail(&submit_list, req);
>                 else
>                         rq_list_add_tail(&requeue_list, req);
>         }
>
> -       if (ubq && !rq_list_empty(&submit_list))
> -               ublk_queue_cmd_list(ubq, &submit_list);
> +       if (io && !rq_list_empty(&submit_list))

Since you're already touching this, I think you can drop the ubq/io
check entirely. If submit_list is nonempty, the loop must have
executed at least once, so io/ubq couldn't be NULL.

Best,
Caleb

> +               ublk_queue_cmd_list(io, &submit_list);
>         *rqlist =3D requeue_list;
>  }
>
> @@ -1474,17 +1467,6 @@ static void ublk_queue_reinit(struct ublk_device *=
ub, struct ublk_queue *ubq)
>         /* All old ioucmds have to be completed */
>         ubq->nr_io_ready =3D 0;
>
> -       /*
> -        * old daemon is PF_EXITING, put it now
> -        *
> -        * It could be NULL in case of closing one quisced device.
> -        */
> -       if (ubq->ubq_daemon)
> -               put_task_struct(ubq->ubq_daemon);
> -       /* We have to reset it to NULL, otherwise ub won't accept new FET=
CH_REQ */
> -       ubq->ubq_daemon =3D NULL;
> -       ubq->timeout =3D false;
> -
>         for (i =3D 0; i < ubq->q_depth; i++) {
>                 struct ublk_io *io =3D &ubq->ios[i];
>
> @@ -1495,6 +1477,17 @@ static void ublk_queue_reinit(struct ublk_device *=
ub, struct ublk_queue *ubq)
>                 io->flags &=3D UBLK_IO_FLAG_CANCELED;
>                 io->cmd =3D NULL;
>                 io->addr =3D 0;
> +
> +               /*
> +                * old task is PF_EXITING, put it now
> +                *
> +                * It could be NULL in case of closing one quiesced
> +                * device.
> +                */
> +               if (io->task) {
> +                       put_task_struct(io->task);
> +                       io->task =3D NULL;
> +               }
>         }
>  }
>
> @@ -1516,7 +1509,7 @@ static void ublk_reset_ch_dev(struct ublk_device *u=
b)
>         for (i =3D 0; i < ub->dev_info.nr_hw_queues; i++)
>                 ublk_queue_reinit(ub, ublk_get_queue(ub, i));
>
> -       /* set to NULL, otherwise new ubq_daemon cannot mmap the io_cmd_b=
uf */
> +       /* set to NULL, otherwise new tasks cannot mmap io_cmd_buf */
>         ub->mm =3D NULL;
>         ub->nr_queues_ready =3D 0;
>         ub->nr_privileged_daemon =3D 0;
> @@ -1783,6 +1776,7 @@ static void ublk_uring_cmd_cancel_fn(struct io_urin=
g_cmd *cmd,
>         struct ublk_uring_cmd_pdu *pdu =3D ublk_get_uring_cmd_pdu(cmd);
>         struct ublk_queue *ubq =3D pdu->ubq;
>         struct task_struct *task;
> +       struct ublk_io *io;
>
>         if (WARN_ON_ONCE(!ubq))
>                 return;
> @@ -1791,13 +1785,14 @@ static void ublk_uring_cmd_cancel_fn(struct io_ur=
ing_cmd *cmd,
>                 return;
>
>         task =3D io_uring_cmd_get_task(cmd);
> -       if (WARN_ON_ONCE(task && task !=3D ubq->ubq_daemon))
> +       io =3D &ubq->ios[pdu->tag];
> +       if (WARN_ON_ONCE(task && task !=3D io->task))
>                 return;
>
>         if (!ubq->canceling)
>                 ublk_start_cancel(ubq);
>
> -       WARN_ON_ONCE(ubq->ios[pdu->tag].cmd !=3D cmd);
> +       WARN_ON_ONCE(io->cmd !=3D cmd);
>         ublk_cancel_cmd(ubq, pdu->tag, issue_flags);
>  }
>
> @@ -1930,8 +1925,6 @@ static void ublk_mark_io_ready(struct ublk_device *=
ub, struct ublk_queue *ubq)
>  {
>         ubq->nr_io_ready++;
>         if (ublk_queue_ready(ubq)) {
> -               ubq->ubq_daemon =3D current;
> -               get_task_struct(ubq->ubq_daemon);
>                 ub->nr_queues_ready++;
>
>                 if (capable(CAP_SYS_ADMIN))
> @@ -2084,6 +2077,7 @@ static int ublk_fetch(struct io_uring_cmd *cmd, str=
uct ublk_queue *ubq,
>         }
>
>         ublk_fill_io_cmd(io, cmd, buf_addr);
> +       WRITE_ONCE(io->task, get_task_struct(current));
>         ublk_mark_io_ready(ub, ubq);
>  out:
>         mutex_unlock(&ub->mutex);
> @@ -2179,6 +2173,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd =
*cmd,
>                                const struct ublksrv_io_cmd *ub_cmd)
>  {
>         struct ublk_device *ub =3D cmd->file->private_data;
> +       struct task_struct *task;
>         struct ublk_queue *ubq;
>         struct ublk_io *io;
>         u32 cmd_op =3D cmd->cmd_op;
> @@ -2193,13 +2188,14 @@ static int __ublk_ch_uring_cmd(struct io_uring_cm=
d *cmd,
>                 goto out;
>
>         ubq =3D ublk_get_queue(ub, ub_cmd->q_id);
> -       if (ubq->ubq_daemon && ubq->ubq_daemon !=3D current)
> -               goto out;
>
>         if (tag >=3D ubq->q_depth)
>                 goto out;
>
>         io =3D &ubq->ios[tag];
> +       task =3D READ_ONCE(io->task);
> +       if (task && task !=3D current)
> +               goto out;
>
>         /* there is pending io cmd, something must be wrong */
>         if (io->flags & UBLK_IO_FLAG_ACTIVE) {
> @@ -2449,9 +2445,14 @@ static void ublk_deinit_queue(struct ublk_device *=
ub, int q_id)
>  {
>         int size =3D ublk_queue_cmd_buf_size(ub, q_id);
>         struct ublk_queue *ubq =3D ublk_get_queue(ub, q_id);
> +       int i;
> +
> +       for (i =3D 0; i < ubq->q_depth; i++) {
> +               struct ublk_io *io =3D &ubq->ios[i];
> +               if (io->task)
> +                       put_task_struct(io->task);
> +       }
>
> -       if (ubq->ubq_daemon)
> -               put_task_struct(ubq->ubq_daemon);
>         if (ubq->io_cmd_buf)
>                 free_pages((unsigned long)ubq->io_cmd_buf, get_order(size=
));
>  }
> @@ -2923,7 +2924,8 @@ static int ublk_ctrl_add_dev(const struct ublksrv_c=
trl_cmd *header)
>         ub->dev_info.flags &=3D UBLK_F_ALL;
>
>         ub->dev_info.flags |=3D UBLK_F_CMD_IOCTL_ENCODE |
> -               UBLK_F_URING_CMD_COMP_IN_TASK;
> +               UBLK_F_URING_CMD_COMP_IN_TASK |
> +               UBLK_F_PER_IO_DAEMON;
>
>         /* GET_DATA isn't needed any more with USER_COPY or ZERO COPY */
>         if (ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_=
COPY |
> @@ -3188,14 +3190,14 @@ static int ublk_ctrl_end_recovery(struct ublk_dev=
ice *ub,
>         int ublksrv_pid =3D (int)header->data[0];
>         int ret =3D -EINVAL;
>
> -       pr_devel("%s: Waiting for new ubq_daemons(nr: %d) are ready, dev =
id %d...\n",
> -                       __func__, ub->dev_info.nr_hw_queues, header->dev_=
id);
> -       /* wait until new ubq_daemon sending all FETCH_REQ */
> +       pr_devel("%s: Waiting for all FETCH_REQs, dev id %d...\n", __func=
__,
> +                header->dev_id);
> +
>         if (wait_for_completion_interruptible(&ub->completion))
>                 return -EINTR;
>
> -       pr_devel("%s: All new ubq_daemons(nr: %d) are ready, dev id %d\n"=
,
> -                       __func__, ub->dev_info.nr_hw_queues, header->dev_=
id);
> +       pr_devel("%s: All FETCH_REQs received, dev id %d\n", __func__,
> +                header->dev_id);
>
>         mutex_lock(&ub->mutex);
>         if (ublk_nosrv_should_stop_dev(ub))
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.=
h
> index 56c7e3fc666fc578a545d15a9767e58f3a4a2f3b..77d9d6af46da878cf30df6e3e=
31758a6f8f61afa 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -272,6 +272,15 @@
>   */
>  #define UBLK_F_QUIESCE         (1ULL << 12)
>
> +/*
> + * If this feature is set, ublk_drv supports each (qid,tag) pair having
> + * its own independent daemon task that is responsible for handling it.
> + * If it is not set, daemons are per-queue instead, so for two pairs
> + * (qid1,tag1) and (qid2,tag2), if qid1 =3D=3D qid2, then the same task =
must
> + * be responsible for handling (qid1,tag1) and (qid2,tag2).
> + */
> +#define UBLK_F_PER_IO_DAEMON (1ULL << 13)
> +
>  /* device state */
>  #define UBLK_S_DEV_DEAD        0
>  #define UBLK_S_DEV_LIVE        1
>
> --
> 2.34.1
>

