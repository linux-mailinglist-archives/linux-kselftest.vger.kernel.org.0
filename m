Return-Path: <linux-kselftest+bounces-603-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666347F8957
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Nov 2023 09:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6461C20BE3
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Nov 2023 08:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBC78F6B;
	Sat, 25 Nov 2023 08:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="HozOdHTi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15804E6
	for <linux-kselftest@vger.kernel.org>; Sat, 25 Nov 2023 00:43:08 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1f9e6a8b00aso1040157fac.3
        for <linux-kselftest@vger.kernel.org>; Sat, 25 Nov 2023 00:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700901786; x=1701506586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7HH2pxIh3nFi6PgmibuEVDY9PSlg1zWmdehxfnJOthE=;
        b=HozOdHTidnvXz+6zbgktJW2ePFhpn3MzoGuGF+AEc4ueOTzg68BVWj5IyR0dYsmvDO
         7EZ/UgKmStDBuxM+FU6nvjYVSLA+GDuJYakqYLKzvVFEf7IqgN5MoWzzbpEaf9pzRtA7
         e5aP0lEglX0R0o3Ck4o2TR0PXe371+wwkJN+UTre+XST547MrcvKhSBkZYwxllrFjKWI
         m5gk51cgJx6rQKnqgrBz2yzFW6A9cp5quM9uktbqfIsEL4+uNgYq1W8y6qaQbNKNu/pE
         uXEVpgBMN/uZx4UTtVvd3pe13tRbOwAdWJYuRL8ECikdP5POJ1AXqr1d48IA5I2GT/+q
         CZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700901786; x=1701506586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7HH2pxIh3nFi6PgmibuEVDY9PSlg1zWmdehxfnJOthE=;
        b=qrIH/bUrj+XUaBlqlKU3uKXIFyuX/CkK5Jg4S2CvhLpRdzYxK3Gk+ni420KmhGTgBF
         3GMy/1b76OzY104Mk3NJAcs6gBMc16EKCF2HxDuVi5wGhAJEfHuAoHhjPf8HOmtDcyaM
         GJ1wGMYECcBSGNMd3DttEG/uUNPflxL5toqw8AfVXDLcxWiGcd9C2a7bnwNQB2Jf6vx8
         2UaO34bSkQq7urQlUT5BP/0qy6+M0bUgIsdFamXsfxavEYbpLvwxpslEJo+1e9IOTgUX
         FAHQ9sjV3dPbgFLSoaicjf1dQGG33G33G0Ls7ufwkysqccBSZfG4ZmxNl65fapl1DEAg
         weyQ==
X-Gm-Message-State: AOJu0YxLsxqssLOJGIvAffvySyQnmLrzoM3NmUCvPtbHCTUn8/ePy/43
	anKWYP0KoU3lbntUwatUYSAJ5A==
X-Google-Smtp-Source: AGHT+IFmZhHL5cLpP2WUD/tuxlPb1Nw3FRYAI7O7Swcj6l2uZNuYbQz1/jSNINvtK+tOhi1SIoMNZg==
X-Received: by 2002:a05:6870:7028:b0:1e9:e97e:24e5 with SMTP id u40-20020a056870702800b001e9e97e24e5mr1002542oae.20.1700901786025;
        Sat, 25 Nov 2023 00:43:06 -0800 (PST)
Received: from localhost ([157.82.205.15])
        by smtp.gmail.com with UTF8SMTPSA id e13-20020a170902d38d00b001cf5c99f031sm2451130pld.283.2023.11.25.00.43.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Nov 2023 00:43:05 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Nick Terrell <terrelln@fb.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH bpf-next v5 0/3] selftests/bpf: Use pkg-config to determine ld flags
Date: Sat, 25 Nov 2023 17:42:49 +0900
Message-ID: <20231125084253.85025-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When linking statically, libraries may require other dependencies to be
included to ld flags. In particular, libelf may require libzstd. Use
pkg-config to determine such dependencies.

V4 -> V5: Introduced variables LIBELF_CFLAGS and LIBELF_LIBS.
          (Daniel Borkmann)
          Added patch "selftests/bpf: Choose pkg-config for the target".
V3 -> V4: Added "2> /dev/null".
V2 -> V3: Added missing "echo".
V1 -> V2: Implemented fallback, referring to HOSTPKG_CONFIG.

Akihiko Odaki (3):
  selftests/bpf: Choose pkg-config for the target
  selftests/bpf: Override PKG_CONFIG for static builds
  selftests/bpf: Use pkg-config for libelf

 tools/testing/selftests/bpf/Makefile   | 14 +++++++++-----
 tools/testing/selftests/bpf/README.rst |  2 +-
 2 files changed, 10 insertions(+), 6 deletions(-)

-- 
2.43.0


