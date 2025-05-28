Return-Path: <linux-kselftest+bounces-33961-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BF7AC70E6
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 20:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B6CB1C01381
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 18:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AB228E5FE;
	Wed, 28 May 2025 18:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="DI/xfSLk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C2828E577
	for <linux-kselftest@vger.kernel.org>; Wed, 28 May 2025 18:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748456741; cv=none; b=RqhgcRz0jJHIx9aA9uIIGBozc7rZYzX2Vsx/8ZhIDaRWFFDeDS/yARwQ3Emix3pPp7TcmOBUxt0aIClG/3IycQEJ0fVgdsfc8FcXUr5134IjGzQlD85JFVIKWJH2QZz34QHjeKr6c7HN8QmJQrtmBvpoZvfqZgGbdVfjAcfml4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748456741; c=relaxed/simple;
	bh=2c4RyGcyTBBIaHhq5vhbuQx07DTDPoo7PyvHV+koXWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=twWrvfG14fpkq9PKp4vMnDjJ350/saCu5F8Quh2+SIwxlNxu+MofH80pqU1vODTcnxdFGjjoh2CwJZ9zQcRPjXHh6fwdImkk+LwI6f20e3aOw8HpeaOt2HLXkJ2ySKUtNZmAuqOm2vN4KE2+iNcaFLCyqf0H44P4XdkdmBxip0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=DI/xfSLk; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3032a9c7cfeso7302a91.1
        for <linux-kselftest@vger.kernel.org>; Wed, 28 May 2025 11:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1748456738; x=1749061538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1DgNtNfVgtxZCoAyIGz18OP4Bo5orqBMpRuB4iTX3k=;
        b=DI/xfSLkwhD9aAt4kDul2oUw0gTKuCrXvB6WHkm1SqcP/WsGxfkH1KQKcq2+30nTWL
         H183cIIig3Z6cDaqylzGpk4g4xyYdc9AwKTSROa+/le3geGgYMTqMRAtC2Na9KsigHsP
         nNwGCZVADf9g773SF/gM6mDOwU8gsMarp63m46ZfWyCu1o6T5vEdiaGY7SUNNFkdnE0d
         +1l9z/Kt2Y/N+w0UxcY1jhcZDzJ4zt96VwmVrxjI/0+AYty/duSEiiI/VL7scj7LVVVq
         1UtPja1h7tdsLI5KkKCf+BgYIbEhhlb943vga9rjLqhUu3m0wxfzHtfefzBJ9aopIdrg
         d0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748456738; x=1749061538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1DgNtNfVgtxZCoAyIGz18OP4Bo5orqBMpRuB4iTX3k=;
        b=JLMjfDeSDgcZeVwBJMxYNYz6FgjpSs+5/rK5Ly5S3yiPjpIcbZio/dcSE6HgarNmDc
         yXMKTM7HbCKbBQTrXdebPWsO4uzgvc/VetasONHHFFBhSliEEmmR72P3Oak04eEiVuCt
         6U6npEzzD2sUlRBTavQbsnk3XhUxyO4CSsy/UcPNS3g5U1SzoZigas71u2MSmJfvDxDu
         w0rVvx29Fxe2x3S+le5qXUBfQFauTtXL4AdlvNsP8pQQo8FfQ71sdgwntUHBM6FtEyNu
         0Ky8Aztwi+WxvcJyCB55Z2YmU+gMe6ZQ+8oCpKyD6QirIxzbT/7ZpEEAMq56/Ce74gDx
         krEA==
X-Forwarded-Encrypted: i=1; AJvYcCUuJ7NrtfuxUzjX5MyvoWhAdUY6ibtk5N45hmZ3fMG9LQ6DLUworiXoQWbjA+9lRTr1rsEabsmcUGJ1e+EMC8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhdM4+J3jYaVjoie3FFA/zSSNcGC6hIaV5BGPXyGaTsyk2vgCk
	HIqHpkihcgFaamiZSca2aL1WSURWo96W0C8UJWTweAzjgsnAWqQfsNWUJ4yAL+7XNIvtRLcU9za
	jdhpCeXRWXdIn3SVuzZ4sB/YMwPMa7Z+bRMlHoTDXF/h0ocgSDxUi
X-Gm-Gg: ASbGncuXVYRL6p+Dml61TEJHWbJ8719Iy617ww+4UgkolnMT2g4U7Nj1oJqtLPFOPnl
	fBthNseJg9/OH3iEAelZ30LGe3sK53NGUPPpaQxz6+ZBHAU4fvUnNsJKs9t3Rpwnek4BB6UVnbY
	Ffc00C6dpV992AlQPosF3GTBjTiBKc/umT
X-Google-Smtp-Source: AGHT+IEL1ZmsyEu0mOM9uUeenWGvWnw6r/IpkOg2ZOyaSFG+h5gtxxKjC4pS8VpZXgUHmiU0tBsXCbt6CaOavzqbLmM=
X-Received: by 2002:a17:90b:384a:b0:310:8d79:dfe4 with SMTP id
 98e67ed59e1d1-311e18132a2mr2095484a91.4.1748456737764; Wed, 28 May 2025
 11:25:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527-ublk_task_per_io-v7-0-cbdbaf283baa@purestorage.com> <20250527-ublk_task_per_io-v7-1-cbdbaf283baa@purestorage.com>
In-Reply-To: <20250527-ublk_task_per_io-v7-1-cbdbaf283baa@purestorage.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 28 May 2025 11:25:26 -0700
X-Gm-Features: AX0GCFuRsiYqORRMNhWkxx1ChAuVZ4WWAaGZPWCcLkLjY7VGBp6_rK8DXEjxOFM
Message-ID: <CADUfDZp9CpghO7vXjhptPoxHgO8HFEa5WF=oyiKS=BoPn8pirQ@mail.gmail.com>
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

Still looks good to me.

Best,
Caleb

