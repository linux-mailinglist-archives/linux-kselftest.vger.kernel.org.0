Return-Path: <linux-kselftest+bounces-22713-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2D49E0D46
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 21:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF8F52822F2
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 20:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63381DEFD0;
	Mon,  2 Dec 2024 20:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IO/neEPO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF9C1DE892
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Dec 2024 20:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733172368; cv=none; b=dERyAkmfBaWQ/nikdeeOqSL3nmiEW5VYbOW2hD/GnQ/BnOUY+FdxH15cVARpngJO0Tbwh6BOfdvTc4nSf02Jj5MZrUmc3V5u3OZgkzYDQEIWg886nF5zVqWLbLGp4hCJIq1mVA6JhwyJmAj67ACCGVCmReqoK5ccPBSWZVaDlLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733172368; c=relaxed/simple;
	bh=7w5jtlMySZQoS+zMq475MlmmQftq+ycbDtwSTI+LilA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AeCwRsd6r1+5IJIjknaVzbWjo1byylqRRMEcob1zsb4Ik/RTVHKvuAuzd09kkqBry9skB4fuIV2DjkQxy6tZ4WCMb+RleQGllNX1a+Z3azf1ooUEKP1IStgh9ou8IWNEOS29D18ZSKI/K81J9yCmp7v7lMRfRkX4Pc3witd9G88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--leogrande.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IO/neEPO; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--leogrande.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ee6900147cso2922882a91.1
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Dec 2024 12:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733172367; x=1733777167; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=++YWSthJPN+yl8B4rg8mre41jdfYSO6YhO5ASg1YrDo=;
        b=IO/neEPO5XnN1QXJuN8fK3ssgNK8HbVLczId8D2R+ZDo3JJP4yya1UGwXF87m0/YuE
         HxqAnE4F+y8YgJFtqq4llptfrEoeZEwfWQZziiozNRVkauVGHu6HX+qReOTuaj56KcQ9
         nmYVvis28hRaCF9+HzDaEFGhSt/pf6JQ+yBxH4tsTkgeo3mvQjQib9DKl5eHbpy4hWBs
         OU0MESMhgBzu9eAwWzSrdCzpP7B3Hbt3SAEbRKVk4bhZdCRigdbpU57/WzocHKSKNnSu
         Tx1kU6+tniCNbkFsVuItf3KSpbKt4z2DYFd74ORTEK1pDwpWS5MUGfm44O93agE0Xcat
         2dRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733172367; x=1733777167;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=++YWSthJPN+yl8B4rg8mre41jdfYSO6YhO5ASg1YrDo=;
        b=eEBa3Ayyj6xEYxvAEPlOInERCGNnuS3c74SKxEUxMXXHY54rh/ltiGgSzRPJVXm/L4
         nnOkJJOhN5Jnq8M+OAKK5mXVqBMWZbqhs/WvFzRZ4sJayobgbfLt52aPpm6VMMLibhrG
         vOh00r0ML8wy5G8nm8ovaMWH7JLukpNP2rcF7CkONX6sGyge02TchRIspYIEsnLlc8np
         OqsRClDSspTZ0CwD2ue98dm5GJNN8wQRDsNLy07PBKAqiynLjTdlHQVdiDC9koZLG3wt
         bCdcmJHS4STnvFzdpX7+MYbZghtvbUSMV2+3CdgXUNcNToVEz8zaEHMeSWPkNJF5rtJG
         CHqg==
X-Forwarded-Encrypted: i=1; AJvYcCVLNJX94CfdpJfl19NL8FP8UbbYGJFGEiRbx9v/H4YZT9pnXnN7W99dzu+DKB4SMdYqG32d4ZaYn0uRyx0rWSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPmXvcUzMOn3+PzGNZqgGb5bUz2NO6daRI1SOeuqVWDzyLf3io
	N7Rb01vucde8UE/ZblSsAARJ3pz008aAxY1DlBOveWht5JTvtHw9mcP2tdYG9aSJfGkbqjxzY+F
	a5ft/AYG5sLG3Zg==
X-Google-Smtp-Source: AGHT+IHi3CKqhjk1y4/ah/p9hu+6bIeHbWyM875rhMinItzIxmg3+i5QKD66Ne7FIqUVR0zKYvLu23a38o+QpG0=
X-Received: from pjbsz16.prod.google.com ([2002:a17:90b:2d50:b0:2e2:44f2:9175])
 (user=leogrande job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1d11:b0:2ee:8008:b583 with SMTP id 98e67ed59e1d1-2ee8008b80bmr17580578a91.16.1733172366857;
 Mon, 02 Dec 2024 12:46:06 -0800 (PST)
Date: Mon,  2 Dec 2024 12:45:30 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241202204530.1143448-1-leogrande@google.com>
Subject: [PATCH bpf-next] tools/testing/selftests/bpf/test_tc_tunnel.sh: Fix
 wait for server bind
From: Marco Leogrande <leogrande@google.com>
To: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	"Alessandro Carminati (Red Hat)" <alessandro.carminati@gmail.com>
Cc: willemb@google.com, zhuyifei@google.com, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Marco Leogrande <leogrande@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit f803bcf9208a ("selftests/bpf: Prevent client connect before
server bind in test_tc_tunnel.sh") added code that waits for the
netcat server to start before the netcat client attempts to connect to
it. However, not all calls to 'server_listen' were guarded.

This patch adds the existing 'wait_for_port' guard after the remaining
call to 'server_listen'.

Fixes: f803bcf9208a ("selftests/bpf: Prevent client connect before server bind in test_tc_tunnel.sh")
Signed-off-by: Marco Leogrande <leogrande@google.com>
---
 tools/testing/selftests/bpf/test_tc_tunnel.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/test_tc_tunnel.sh b/tools/testing/selftests/bpf/test_tc_tunnel.sh
index 7989ec6084545..cb55a908bb0d7 100755
--- a/tools/testing/selftests/bpf/test_tc_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tc_tunnel.sh
@@ -305,6 +305,7 @@ else
 	client_connect
 	verify_data
 	server_listen
+	wait_for_port ${port} ${netcat_opt}
 fi
 
 # serverside, use BPF for decap
-- 
2.47.0.338.g60cca15819-goog


