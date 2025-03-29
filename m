Return-Path: <linux-kselftest+bounces-29913-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 449FBA7561F
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Mar 2025 12:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BD1A7A28DF
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Mar 2025 11:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CBC1C5D61;
	Sat, 29 Mar 2025 11:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="cqVKj5ul"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2173F1C5F3B
	for <linux-kselftest@vger.kernel.org>; Sat, 29 Mar 2025 11:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743249467; cv=none; b=F1KwwHGqqjs2SW7niuC+o7a45XFZbwrHxnfrwxiNWQX0NY+VnISwO6x+fzP3uNfqa4SgL7ykLpp9n5ZVXsmg10igMTohqDBuzLik35x9qtevfbtywlrwimde8GR4r/HFd948Eewpur0psQK609LVhopP6JmsRFtqfcET4kb/zgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743249467; c=relaxed/simple;
	bh=gAeX4mYSCbs5F65smwF8qHZGNb5IzGI1zY2vATp7M+E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=a1dLqvmj+e7thYf4gTTFBbfsiQkKzbGAI3277I5+FTp9v7aKfBo+ZYF4dZj0Woa9YJ/z1xbmoGRlYa2h8TBb5M/3D+mBE03BWXIKbI5zLxEjiJ6XQP0qzAEClnyomGWQkrf0PY0EX2yUN34UztM3CQYCoKPuXsDm1u9BlG6akKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=cqVKj5ul; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3ce886a2d5bso24530515ab.1
        for <linux-kselftest@vger.kernel.org>; Sat, 29 Mar 2025 04:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1743249465; x=1743854265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/g/89MFbZnpWepoRDZCsMQzXVPoAx1wXngDzMRDo6M=;
        b=cqVKj5ululBWNWrNL6eAXyAIEtcYk3w8/C4YQS+P7p2fCiZ+seD+AfEMZ/bPlq6Ggd
         j8IEk7g6TR8T5bfqGmKtWvI5hcSPCshMLEVEvP+CqBDaPFhmeOO2hkYcJaaEp6D21u9k
         gv2JyaLj0aa/fZbZqn1NtmHRQPedHaqcLAC76paCJ2l1ljcAlxNO3q6L4kLqkZCABaj2
         pvd00gXwGVzdCFtcZaGKtDRPYqo1qTvqFQpMlc+bVA7oNCaqH+954j1va74f01MzhS6i
         20QOYMOi+Uh+mrdhrBQfLqSVfVP5Mbcr3O71LzBgNR8l+SecIvYz4KuLsz51dQbyRTdT
         JnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743249465; x=1743854265;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/g/89MFbZnpWepoRDZCsMQzXVPoAx1wXngDzMRDo6M=;
        b=iWXbgxRaLCbaMDdmGoImjro7FZsGG4QogsmlTbxtYJSAeBqHRulkKVvqy4wKQq93Fm
         KRrWGEYH0B90RYfPUyTINUZvEu0dmePci4gYIwairgMlRKGzOeXO0Dm1eVrPsmSj6DgU
         w4AYggTWmY7Ieq98POElfv7XyAgXhj0b8KPKeCzuYSzuwCLajEsspY5nze2ctBzRV6OK
         CTrQxzoCggeqzefQQ69zvWmgNnMAB1hbOb2+opxCjE5qpn4vqpCuy1zszbIjgMMSMccE
         9aU5tunKSrE+/qeadjQBas+8IhQOFnnRDO8Ssqpb+JZf0o/U+YQMtal51cAtEiRh7gKD
         Yg1w==
X-Forwarded-Encrypted: i=1; AJvYcCVK6YCZK8i1c9NMxUcPwLqwASWCJUWtTyWa424k9d3GOqUGJtboMdvK0mVJgvd2SYGIhjNoCXxYOVKPdEXNlm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCcuBAjKgpYcOA6y7T+Qyy3CXDiI9nRpL7QRwR8SfakZxL6aT3
	s2RRKWKfZAKTOUn97uOuviI5x7e19XwXm8QkcoXg6EXZfceV+toJX/Du25uZigA=
X-Gm-Gg: ASbGnctjpFbVYJHEKMIsvDfbwWVLkDW6y3Rc5KoPc+DqSEj+uNPEflzBIvKUJruL38/
	Mg7AQxdR3cUGoDybXVHPwk0KUwrPzCNJWgMfLO1y7uM4ezVRL3bGtk5oBQ9hbh2c0au+4GHDILJ
	V61OjtfGLn9d3Y2M9FRXa3A4YaAfyALCtmKYnq2vAhj9eEmn5+hEp8Cf1iOE3HCVaR8Xoe/trAl
	qGi2WmImuRRB4/ZKotm22CLRIEs1Xavzt8Bh0VXrYM/Asb2k8iJsVxsjwzF5m/uti75UbeNKsjr
	Wi1eVeJWIVLwoutnzHiCTJceL39M1yY/BleF
X-Google-Smtp-Source: AGHT+IG4lRvPyKFfryFcZpb4wMqvD6ztSnUsx1nVX25CHJ96sGhD3D2ZJtP9dRiKL1RUhV42vmjqpw==
X-Received: by 2002:a05:6e02:178f:b0:3d4:6ff4:2608 with SMTP id e9e14a558f8ab-3d5e092a622mr28591325ab.12.1743249465068;
        Sat, 29 Mar 2025 04:57:45 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d5d5a6345esm9616765ab.1.2025.03.29.04.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 04:57:44 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
In-Reply-To: <20250328194230.2726862-1-csander@purestorage.com>
References: <20250328194230.2726862-1-csander@purestorage.com>
Subject: Re: [PATCH 0/2] ublk: specify io_cmd_buf pointer type
Message-Id: <174324946362.1614213.12674397297873310075.b4-ty@kernel.dk>
Date: Sat, 29 Mar 2025 05:57:43 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Fri, 28 Mar 2025 13:42:28 -0600, Caleb Sander Mateos wrote:
> io_cmd_buf points to an array of ublksrv_io_desc structs but its type is
> char *. Indexing the array requires an explicit multiplication and cast.
> The compiler also can't check the pointer types.
> 
> Change io_cmd_buf's type to struct ublksrv_io_desc * so it can be
> indexed directly and the compiler can type-check the code.
> 
> [...]

Applied, thanks!

[1/2] ublk: specify io_cmd_buf pointer type
      commit: 9a45714fc51321ea8f5e5567f70e06753a848f62
[2/2] selftests: ublk: specify io_cmd_buf pointer type
      commit: 25aaa81371e7db34ddb42c69ed4f6c5bc8de2afa

Best regards,
-- 
Jens Axboe




