Return-Path: <linux-kselftest+bounces-7325-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E0489AA29
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 11:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E73F1F2354E
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 09:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A144C627;
	Sat,  6 Apr 2024 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="q5tKbRrb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29DF4AEF5
	for <linux-kselftest@vger.kernel.org>; Sat,  6 Apr 2024 09:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395229; cv=none; b=XT1PX0jhqWBm6O30bQL37GCH4tRGfu7O3z+uK4JQ30IFVy7WaM/XEAEsv0vRhvFX7cPrDlI9F089N6eptP6z6i4bc/cTnQENBIVDJF5oZtjvLwQDdcrMDY9REPbwWQoRfnsvgrRsPvyMMLHQtCUjF+9l9FSZeoxdhpCiAD46NcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395229; c=relaxed/simple;
	bh=wls7Uj9lvj1C2cR+9fWVS8Sq79ZqlDYd8ckzjVd9vKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ky+w2issJ5z2O5OeeXIosHCtTo6mYsFa8ZdmSCpIFvF50HVkg9MS1GA1nhDsvD/ICMXQnmKNDYrXrqfghiDd/h57bPPa975EqvZ8116kJ4bz2257cNLKyjkBigGcQko1kL41brcGlu6OqVHp+yoIpqm1zUr6WJLka5OTRSVqwCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=q5tKbRrb; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 50C833FE1A
	for <linux-kselftest@vger.kernel.org>; Sat,  6 Apr 2024 09:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1712395215;
	bh=yx7vpzXIHTYh5j3nTDQp+mlNbiWJAYHc0w9red4g/BM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=q5tKbRrbGHpGojfGgHsaMjDoDLetvIHPRt0im7kJhwqocece92yWsvf/UgIim9k1b
	 pXvo5/PIRhPr6ryr81hz87Qodp6JfBc6dNH4hHm+isVQH9bkr4TJzk0MavxKHxhiri
	 3wZlRg0Q8nL1KyBg6daNMw/No7vPoJgXUdqDAfur1LnJEgSF05FgDyHbAD5qp+2pEv
	 5FH82iXExetDEjeigwlIYuv7TWShMuBWYgxqInS/h0U1Fydyd1M++WugWPNhWZGhGx
	 c0THrXthn5I/AfFLiQdSmgN4iyzUWBPcNOtPMYyLsDnE/+Doma6oc2mFwa+cXkR6fC
	 NLUCJjKUu8nrw==
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4162bc2da3fso9929575e9.1
        for <linux-kselftest@vger.kernel.org>; Sat, 06 Apr 2024 02:20:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712395212; x=1713000012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yx7vpzXIHTYh5j3nTDQp+mlNbiWJAYHc0w9red4g/BM=;
        b=gP/gLY4l0xptjdElcUHuprAWC5WdT2wqra6pLKXq94UbdlskOtVydHHAnUuorh2Vi7
         zQuqQdgsKSu8E+Ko6eS+KpeWdDjvX9Gr47sVfyj1UU38483gqwdIyrW1J4+ktmMAlH9r
         Okv7kX3hASyysunLNgSfyUBYuFOB3pAHJjwhkRlEACfIdUmNODPOVQjH2nIQVDTZSvJb
         IlH2ws/u7WJAIj/Po1b1MJTMLbYS8hftcCdL20eKzXUTU0Mo9/EhbkJPLajOrqjEZqjz
         yxXMLRQSfjPARhYCuybWdFKEW5cEwB+R0zO9UJSFttf6Z41Oq+ZF2cGRvjzDu/RKDqs3
         ADbA==
X-Forwarded-Encrypted: i=1; AJvYcCW2IiQ+4ZH2nYKB2ZbtEt+Acin3eEDsa23afgSbzZq2Tz1JgPGdw8pMCImBSaXOViz0v3HXsMR2u+BtYYyS8GiWZJn9NXdFJtZSd+D5PEEN
X-Gm-Message-State: AOJu0YxO5W4SsOPpQYACQx5KzUoZgTQZ/uaP0Zkg3DplXoikYffVwxuN
	5PjnkuDnOTS9MQ0k0/TtANQTUWM5NGYBQ6AMi5g4icPvYSnBfhe7RVRj+gTuZX2R041eKwpw4om
	dSq9Imj8lRAeMuxI9VQQmrd/82dg4gYaxcCgWGIPSSqXx/MT/+A/KIaGRvQd72EcIrUHLOtM8G0
	EmJ98lqg==
X-Received: by 2002:a05:600c:4e93:b0:415:691c:f83d with SMTP id f19-20020a05600c4e9300b00415691cf83dmr2852409wmq.33.1712395212480;
        Sat, 06 Apr 2024 02:20:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHit5kOPUjw5jx+vy2tg5jUYvea3lG9TQoPRZVf5aXYZyCaWrS8RAEXac+i+7u4IVkSCPt8Yg==
X-Received: by 2002:a05:600c:4e93:b0:415:691c:f83d with SMTP id f19-20020a05600c4e9300b00415691cf83dmr2852376wmq.33.1712395211958;
        Sat, 06 Apr 2024 02:20:11 -0700 (PDT)
Received: from gpd.station (net-2-39-142-110.cust.vodafonedsl.it. [2.39.142.110])
        by smtp.gmail.com with ESMTPSA id l23-20020a7bc457000000b00414924f307csm5779993wmi.26.2024.04.06.02.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 02:20:11 -0700 (PDT)
From: Andrea Righi <andrea.righi@canonical.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] libbpf: API to partially consume items from ringbuffer
Date: Sat,  6 Apr 2024 11:15:40 +0200
Message-ID: <20240406092005.92399-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce ring__consume_n() and ring_buffer__consume_n() API to
partially consume items from one (or more) ringbuffer(s).

This can be useful, for example, to consume just a single item or when
we need to copy multiple items to a limited user-space buffer from the
ringbuffer callback.

Practical example (where this API can be used):
https://github.com/sched-ext/scx/blob/b7c06b9ed9f72cad83c31e39e9c4e2cfd8683a55/rust/scx_rustland_core/src/bpf.rs#L217

See also:
https://lore.kernel.org/lkml/20240310154726.734289-1-andrea.righi@canonical.com/T/#u

v4:
 - add a selftest to test the new API
 - open a new 1.5.0 cycle

v3:
 - rename ring__consume_max() -> ring__consume_n() and
   ring_buffer__consume_max() -> ring_buffer__consume_n()
 - add new API to a new 1.5.0 cycle
 - fixed minor nits / comments

v2:
 - introduce a new API instead of changing the callback's retcode
   behavior

Andrea Righi (4):
      libbpf: Start v1.5 development cycle
      libbpf: ringbuf: allow to consume up to a certain amount of items
      libbpf: Add ring__consume_n / ring_buffer__consume_n
      selftests/bpf: Add tests for ring__consume_n and ring_buffer__consume_n

 tools/lib/bpf/libbpf.h                           | 12 +++++
 tools/lib/bpf/libbpf.map                         |  6 +++
 tools/lib/bpf/libbpf_version.h                   |  2 +-
 tools/lib/bpf/ringbuf.c                          | 59 ++++++++++++++++++++----
 tools/testing/selftests/bpf/prog_tests/ringbuf.c |  8 ++++
 5 files changed, 76 insertions(+), 11 deletions(-)

