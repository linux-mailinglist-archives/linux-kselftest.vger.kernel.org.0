Return-Path: <linux-kselftest+bounces-34056-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C14DCAC8FC6
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 15:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5601C23161
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 13:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D24231C9F;
	Fri, 30 May 2025 13:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VO6PZKdE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2312122C35D
	for <linux-kselftest@vger.kernel.org>; Fri, 30 May 2025 13:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748610453; cv=none; b=awg+hfVAgV8RDQS71Zr33aonHo/3NzQUdG+HyD5aNPXs0sCKLDCKcbGUxNyttnkDvaWlSLf5C8BMoQQ9QllDhHSnPfsAo59hCk+H8FObYiGV21j/EiiwoEuYHQibc0IlC7VzqWoMU0sdSnXUAUM9E8V0OWlj9MGbdmmZlnfEoZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748610453; c=relaxed/simple;
	bh=h4jwctbW8pXg3O6hJrQAv0f+KY+PlydbIAeGTRF0HdE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GEt5EGWB1iZZ916cENQCcJQYk2FjvGewAypQ2SkdssxWzW9b+d9fulf5evhX8HE0Nj1QG0aunOYweWelOxpZ9sHQ9lzQbNMyH2IbviH8MCa26lY/fRpzx/PyayvlJ6hvhzh8YVcaZ2+UheAdNrlVB2r7pBL6S152RM2iys690oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VO6PZKdE; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-86cf3dd8c97so156702839f.2
        for <linux-kselftest@vger.kernel.org>; Fri, 30 May 2025 06:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1748610450; x=1749215250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+zllA0JepvlfuREVmf3nCF0usvpNrfKCbR5PkTeodQ=;
        b=VO6PZKdEzYmCiAL4/bfvM6EAnbxC1HVa8lz2kZMsMzLCRm7p0n9+W8yJD9IH2JxkaR
         nHe5CksjbM8qHonhSykwH0P7+D2ZBc+P8PcJosgYRAl6FzM0UVx+qpXHueJUjPVZlhea
         xd+h6mQNBch6coBDdk/ozPsQFt1hdcOjzdv8RkvcrmpWU01ykoCDZiQf5weiy2Kue1su
         ZICHzVsKoE0ZGEC/Rc9u9csSEljXJy7XRRFnm9dukspZqTQfCvxD+Ip70K6RlDaiaAQJ
         3OYuFoVNxR3ocTp49r7HxVadcFmcDHP+MpaLlDDV051EEu7DYnOrMSvegGUk15UO+JoE
         71IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748610450; x=1749215250;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+zllA0JepvlfuREVmf3nCF0usvpNrfKCbR5PkTeodQ=;
        b=l8jvKA87HWIm+bD9hQxkGn8SlDChv+QKLP+XYR/f9z7blwkG5lsdOOc035+mg9svNl
         L3JmIAU7lQhuCv488XsYNlJYVHQGFW9q591NZgbQS5xNg8jfGxDh8CHDT7ewlNOz4muR
         2LqFSe91pwEN7WhdzRsSZFpm69FErIs16+7NHd9xfKmKJ7mHi02e4F70Lbzh46pskqm8
         i0CJ+zTsm5PhUYZpT9+ZIIG5SXoQwg4JigDXqRETNv/n4ElLhfqQspSmRR4zC1NvoJ8F
         jLNwRiWFaLPWrV17WpN0kEqrzoOPEM/PQISPmY2zaqaem16MkrAieaWZ9s+iFJv52YXT
         Q1gg==
X-Forwarded-Encrypted: i=1; AJvYcCVvwJAqsZfkvfJVcBPpr+IHYU5AeO0R5vqXy2hogv0IRUu5FYoLKUZRwjLuxtmKWY3OYeaqPdmsRX/UByA0hlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhceNCIqumCoo0mOwCtq11ttjtME7NqL6kSxSz7DNlcu0izv1f
	dyB6HA1U+w6+gLp1N0Jt1LvOsjw3oxUU74/QyzDAX6kAsGXKh2TIy7UhhvXov9qXfFY=
X-Gm-Gg: ASbGncsksUAKRC4aWxukwJO79YeU+efMmO8eqdIQu2X3BPZHifjAPW/2iswrZx5I/C+
	nUGXy+qeLF+niRJaZ+GdzuFWctt+m87u+XrzC1M3S0FexT7jM/1mv3AjOkbpW+X/6WJIfARoimQ
	9sIA4wzPcpEQlSLzBEvuxqf5PB4TjG0uPFFyxzea8L58KFf909+VondVO4SpAq9zDQTQ25lVAIO
	8hvwhX4S5EPW8SSlhnaStcuswxGvDkWFU8WRpVtEZSWvtT5qSNeNYvBnoCsiMcLPqUW1rBXGZq5
	gSQ+X6zHrn1yhWeHOfOBPIxN+ZVPHVRvxWDU3uxOnQ==
X-Google-Smtp-Source: AGHT+IFfMvqEazUYtf2SirmN7JtlcpvFyW/az1d0hhAS8lUwYVAN/ahd2bFle1R0bSvbYHbgXjTrew==
X-Received: by 2002:a05:6602:4017:b0:86c:f2c1:70d2 with SMTP id ca18e2360f4ac-86d000aeacdmr411795639f.3.1748610449967;
        Fri, 30 May 2025 06:07:29 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fdd7ed8154sm424022173.100.2025.05.30.06.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 06:07:29 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, 
 Caleb Sander Mateos <csander@purestorage.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Uday Shankar <ushankar@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
In-Reply-To: <20250529-ublk_task_per_io-v8-0-e9d3b119336a@purestorage.com>
References: <20250529-ublk_task_per_io-v8-0-e9d3b119336a@purestorage.com>
Subject: Re: [PATCH v8 0/9] ublk: decouple server threads from
 ublk_queues/hctxs
Message-Id: <174861044873.875376.13955426854748469811.b4-ty@kernel.dk>
Date: Fri, 30 May 2025 07:07:28 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Thu, 29 May 2025 17:47:09 -0600, Uday Shankar wrote:
> This patch set aims to allow ublk server threads to better balance load
> amongst themselves by decoupling server threads from ublk_queues/hctxs,
> so that multiple threads can service I/Os that are issued from a single
> CPU. This can improve performance for workloads in which ublk server CPU
> is a bottleneck, and for which load is issued from CPUs which are not
> balanced across ublk_queues/hctxs.
> 
> [...]

Applied, thanks!

[1/9] ublk: have a per-io daemon instead of a per-queue daemon
      commit: b8af2e5dfcc3314c09a97dabcf6e2b1f644cf820
[2/9] selftests: ublk: kublk: plumb q_id in io_uring user_data
      commit: b9c564b74d8aa549d74f97b6a9f429fedb9a4e97
[3/9] selftests: ublk: kublk: tie sqe allocation to io instead of queue
      commit: c306e71dba79624cee2eb5a80bc5013b47943241
[4/9] selftests: ublk: kublk: lift queue initialization out of thread
      commit: 83f5c5d62905353a1be597c62d82b0ad14f23a7f
[5/9] selftests: ublk: kublk: move per-thread data out of ublk_queue
      commit: f21561bc01bf887c2f620d2e4a9a52b999f776cd
[6/9] selftests: ublk: kublk: decouple ublk_queues from ublk server threads
      commit: 5163fa0f106d7a31c185559f95c7afd3672e69e6
[7/9] selftests: ublk: add functional test for per io daemons
      commit: 5e580d6b7e2004e308148a67d9ade3f26fd5949d
[8/9] selftests: ublk: add stress test for per io daemons
      commit: 6b29c3106a5fc2b4e14facf1ee7e663554f805bd
[9/9] Documentation: ublk: document UBLK_F_PER_IO_DAEMON
      commit: b02f5eedbcabe6e1982fdd7ff3f0ac5d1fddc68f

Best regards,
-- 
Jens Axboe




