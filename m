Return-Path: <linux-kselftest+bounces-22204-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 560519D1A0B
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 22:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D06B1F223B7
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 21:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C861E7C0A;
	Mon, 18 Nov 2024 21:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="ZhFZjeFb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F12D1E5730
	for <linux-kselftest@vger.kernel.org>; Mon, 18 Nov 2024 21:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731963932; cv=none; b=Y/EsBvmKJsa1zafO1jKzNv5Pwsi4kqz9cWgWoX+B+bxWXuT7/DtdJy0ZmvuXyiFZbeH8w+o/L5bN8+XgY5Agtp0TL9MxVvnZ62YG4M2SYvZy3t30b4bNa5fSXYlEN/2dTM2sJ1qXVAdWzmjennCXKdWZ8NEkIhj9eqWyFVKJryI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731963932; c=relaxed/simple;
	bh=cCmISK6BnKASPnPfisyoQZpkhJsYpv3tV4Awm1tVG+s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lUcFbWNWR0TfnW6cvFH0R0KUCNi8iRxxvTXMheWrUKbm22jx5UO5qi61Hvl3qLudKb2kKkxvc/RDe3rSkzfWvH9r9p//ZaRbtGGM5Wqoz/HAQ91dntdusgoY7IPq0Z3AosKzDLOs/ehook3qodh8sab6ZTX+EtCVIhmU8DT8h/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=ZhFZjeFb; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tD8vv-00007i-SK; Mon, 18 Nov 2024 22:05:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=SZ4ULW7QA2NHTeEfsW9RD+SClsi51owWe7zBsnnPzcM=
	; b=ZhFZjeFbAKKEVzE5Snnwy+OMXz+pUH37PvMQDtjQiKIPcF86lH3EfniXju3sGD6nj1F94p5nt
	IczTht1X+yzrxM5jyuIWiHhh49GqXFt9N0bRzyZypVe+IuBRe+gzNraOtU+8W/drsm/cISeKlVpwY
	t2zstNtLTfZnByxadbEK6dSFwPHUoCIH2FLMOZdAinRpxqB+8KEkFg8AmTZr6ewVHTPE2ws6BrVFG
	CgceAfD1WlmjDyPn4+UWLsH81+8FOetwDJSfnB5sDHVtcy34Jt286B5d4F/ZUpqNO9/n4BlnSs+Mv
	mn+Ozp2R20ZfOvlIMyQ6uPa6n3VXtBWV+U9eCw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tD8vv-0007dS-E1; Mon, 18 Nov 2024 22:05:19 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tD8vd-00DME4-Tz; Mon, 18 Nov 2024 22:05:02 +0100
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH bpf 0/4] bpf, vsock: Fix poll() and close()
Date: Mon, 18 Nov 2024 22:03:40 +0100
Message-Id: <20241118-vsock-bpf-poll-close-v1-0-f1b9669cacdc@rbox.co>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKyrO2cC/x2MQQqAIBAAvxJ7biFNJPpKdChba0lSXIhA+nvSc
 WBmCghlJoGxKZDpZuF4VVBtA+5Yrp2Qt8qgO22UUgPeEt2Ja/KYYgjoQhRCa7zpNdlBk4Oapky
 en387QXVhft8Pku03EmsAAAA=
X-Change-ID: 20241118-vsock-bpf-poll-close-64f432e682ec
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Bobby Eshleman <bobby.eshleman@bytedance.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Two small fixes for vsock: poll() missing a queue check, and close() not
invoking sockmap cleanup.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Michal Luczaj (4):
      bpf, vsock: Fix poll() missing a queue
      selftest/bpf: Add test for af_vsock poll()
      bpf, vsock: Invoke proto::close on close()
      selftest/bpf: Add test for vsock removal from sockmap on close()

 net/vmw_vsock/af_vsock.c                           | 70 ++++++++++++--------
 .../selftests/bpf/prog_tests/sockmap_basic.c       | 77 ++++++++++++++++++++++
 2 files changed, 120 insertions(+), 27 deletions(-)
---
base-commit: 6c4139b0f19b7397286897caee379f8321e78272
change-id: 20241118-vsock-bpf-poll-close-64f432e682ec

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


