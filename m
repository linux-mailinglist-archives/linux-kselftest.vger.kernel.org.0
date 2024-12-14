Return-Path: <linux-kselftest+bounces-23385-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D080F9F2083
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Dec 2024 20:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1F287A123C
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Dec 2024 19:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DE81991C1;
	Sat, 14 Dec 2024 19:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8x7mGi0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B936383;
	Sat, 14 Dec 2024 19:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734203063; cv=none; b=k4E7QowpXH9Z/TkQMzBYLzj+FDqBIyKh6FbpJBliufDbkVmBDh3SU5+RWMxGKjo4tDnURtsE8rx+bLcsz1cP+tCSY8qP/7XkuruIAgLot3M2YRnTyWAuSpUv1041oJXjZaqK7ghBAxmizgtZGHyEtnG+IkVOv01nNe5nST2+igg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734203063; c=relaxed/simple;
	bh=B1RNJz51W5xd1zQxhBcmajdPgBllmwLlOMZ4T09zqw0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=I5Kw6zqnikyORmKFLr0IXVw9sOIrcKrS0pgOCGtVpzFGqTpCdM9HWtxUmRB+5Kv6xerr6PBEvuLMAiNhIucNDg2y63N6SV/pN9vV6/o3ktMQboLcfGxjApguqwi9oMFXETIyWzAcfrvOnDDhqQ6GdSJRFBViUBgaMVGtd0XwlFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8x7mGi0; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6d8f544d227so16126866d6.1;
        Sat, 14 Dec 2024 11:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734203061; x=1734807861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIFaf3IqmZpscRutdsa3N/P+fgNOiiJ84txE8zqPmqs=;
        b=T8x7mGi0zQ5l8MHjpwx3MARgEGypGxV6wuwpYIfTPoCtUuh6294H00jQtXPGoBzLRs
         ruFGlvSks+RVAE+gA6Pj9p9QclInkj2roW5Ulaiv9CDihf+n+jWl/bB1mbL3HJJjnBlh
         GH1X18ciupb/0rivr7J03KDdKij1TqimQldvLhq5yd5PotzqReNjwNEHTzKF0LrQrS1G
         EGtR++svlxNtfxezPjuPOgwhO1FXy5GBSGObCakGmy4PGvxOJfrsSSoB7KEDUOr85Mj8
         3/MuXU1fFGnRhFBWwsZK+zXzTO/dDtq+2yJAZE4Hycm+JuG/v24KSOP0VmtVB3fYtriJ
         JpVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734203061; x=1734807861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZIFaf3IqmZpscRutdsa3N/P+fgNOiiJ84txE8zqPmqs=;
        b=dTlBCoE1W33GC1pszE6mtS3/rMFK5qpcgMC5EEyxVCqXEchzs37ouKy9j5fzxNbf/L
         4Y24HWyv45MH3fPV62MXSZmi6KjsECEuNkpZnkQI1qwmkH0xxv4cOPz8lbb/PFQy7ye5
         L8C1+MjhpKexjxildm51nLPmv1aK/qX5eYPhVTlieAtSJ6vVJcYLVnckxUvRxx5RWSPt
         Y3T6tGB1rweW3qPx338kUe4cGU1bukN+Cbmr53K9dwrcBDozzru3x2nc/N0mMNhFkNbw
         qUS1LT3AeLktDj//V4ag4a3pu0uEXkqNXZRJG6se5hXgMFpgCcjE5jSFVgITjFr+fq/P
         AUMw==
X-Forwarded-Encrypted: i=1; AJvYcCVOiRsf+EGIKvIYfD0zvxTF/DGKIc9EEgSr5eZ4Cg6+kvDyRuiNSSplMDn2gA8QEb+vBkSzltekIYxt3E6W@vger.kernel.org, AJvYcCWmoy8j4HNiTukCoQE31QIYu5wim/6cfs69i99TlwdxNok/14Cpi+E3QNqGi8qadz1v4cA=@vger.kernel.org, AJvYcCWzcBbkVc7Bc2DHI8ELb/nr43Ab8mMGVcGpsZA3S1rziYx7TFdEdV2poVMxhPb7CC1ydH4NepBL3YiFEw3mNspq@vger.kernel.org
X-Gm-Message-State: AOJu0YyqzEspyBrdlfKPDyQWjsYWTxit/UPBrD6DomlvZaMtoE7SB2gG
	xw5Dla7dJ6bE7q6zz3ma7tJ+XRqNh9ed/eN1j4q0ln4LA9tJo7i0
X-Gm-Gg: ASbGncuDVcpag5Y7VALE0zT+eMtcK1bVdgzZqMSYvEX33FeyXVQRjJpY9VFtB+HEz5y
	NBJiWiapn7AeRjXi38hJx4XzD//OAxaAsd+GLuRD79g2C2vQ0ISsR+FexUAUX0pNBGwdNtxLa6P
	7/D4gZATHIrP8QkQdACgTmecYZjk4EGIVtkWZV/ylwl1x+MQ2BC0xQTy6aFnzMO2QPmkRA1lz1a
	k/zoy8gR2zWARGpU+V8DAeiQcxKedZ595xmPfVKg8/ZN4OvTN/oDNAOS5u4+5AFqsPiZbhOe+In
	zkGKuCqllSeGVNLmLuf5vzRX1+v7Dic=
X-Google-Smtp-Source: AGHT+IGfy6idxNzV0AywpDnpk1WO73Qyp0umcANY89oYah1uTQKTiBn6wsptDdQyRH3eAB5gLphspQ==
X-Received: by 2002:a05:6214:762:b0:6d4:3b7a:313a with SMTP id 6a1803df08f44-6dc9032064dmr102226696d6.32.1734203061026;
        Sat, 14 Dec 2024 11:04:21 -0800 (PST)
Received: from Matan-Desktop.localdomain (ool-457a37de.dyn.optonline.net. [69.122.55.222])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6dccd26d086sm9884376d6.55.2024.12.14.11.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 11:04:19 -0800 (PST)
From: Matan Shachnai <m.shachnai@gmail.com>
To: ast@kernel.org
Cc: harishankar.vishwanathan@gmail.com,
	srinivas.narayana@rutgers.edu,
	santosh.nagarakatte@rutgers.edu,
	m.shachnai@rutgers.edu,
	Matan Shachnai <m.shachnai@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Cupertino Miranda <cupertino.miranda@oracle.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v3 0/2] bpf, verifier: Improve precision of BPF_MUL
Date: Sat, 14 Dec 2024 14:04:09 -0500
Message-Id: <20241214190413.25587-1-m.shachnai@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi All,

This patch-set aims to improve precision of BPF_MUL and add testcases
to illustrate precision gains using signed and unsigned bounds. 

Thanks for taking the time to review and specifically for Eduard's feedback!

Best,
Matan

Changes from v1:
 - Fixed typo made in patch

Changes from v2:
 - Added signed multiplication to BPF_MUL
 - Added test cases to exercise BPF_MUL 
 - Reordered patches in the series.

Matan Shachnai (2):
  bpf, verifier: Improve precision of BPF_MUL
  selftests/bpf: Add testcases for BPF_MUL

 kernel/bpf/verifier.c                         |  72 +++++-----
 .../selftests/bpf/progs/verifier_bounds.c     | 134 ++++++++++++++++++
 2 files changed, 166 insertions(+), 40 deletions(-)

-- 
2.25.1


