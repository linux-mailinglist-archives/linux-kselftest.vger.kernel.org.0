Return-Path: <linux-kselftest+bounces-21627-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C18D9C0D79
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 19:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87FEEB215AD
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 18:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162262170A3;
	Thu,  7 Nov 2024 18:12:17 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160642161E6;
	Thu,  7 Nov 2024 18:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731003137; cv=none; b=mg5ofUrpdxDBa0aYQ5NTFxUSbxzhh4DKXrA1K2km1zN0176siV4N3dTbRfIE9QJ0iPk4uJNhHXg+P6Y+vDhMnh65xgj+iEQOw7/kOf5SDTUReFXTEoUkEQhO/w7dr5Uy8kIROtxSwPz2pcbVeYzkJviF1lSTjDe8l7xq0bH9TxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731003137; c=relaxed/simple;
	bh=QYtEtlkBOrC1Ya90xDLzKFhDn87Z90gjyyAIkP1QK70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aUA2qMxVHUFzezDOoeRv2SWTUpd1BQ0ugzrQsQLBvrCUHDwwPuiKgUFOQ42JPAqgVZAAyWymto9M5o3II9nVsN0HQW2q7q58TcqKwAyBlDNk8tW6MwhSXE//WJsFr8hkGIpcfk7CqskoFvJgaMl8JPK48Aj8ysHDqNtZxphrVoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-720b2d8bb8dso909959b3a.1;
        Thu, 07 Nov 2024 10:12:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731003133; x=1731607933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K5/MXPQVWSfX56FbuibfqKs75bB8Xe6p/3/YF+lSl7s=;
        b=QRZ9YjHtL2cBjbxSbCuG2SLMc8t9FlDuRS+ZZk0HX2B5MuQgqEUgs2f9l8xwXnQ3pZ
         /kkSFEfdKyVgEKAVIfH53SgWRmTbd1A4MKW5ObbHRhioaxfukYE3aAYDAdBL+uwrR5XE
         rhJp8kEHLyY93A7Z02ItlbhMQ+umemv7FQ+pKavEHvow5gLUtlnG/cnyGUc7jyz8WtWg
         tg/XD7MJJgLmjTy33AF0NK7jAVxfDXSNnsKX96fItY4tRrEGhFiOo5tBGpK33zLQCZ5s
         2n3uxZZyC9iOvpLY7BYyHx5YW/hgDHgd6loCyUdLmt1PaTdofxuqzxrqi5SWxesIPss9
         c7YQ==
X-Forwarded-Encrypted: i=1; AJvYcCWB5wMKlWiota9bG6DEjfOddunvhxwyYwlYyssS1ntl0BgzFZL6Euj6+NmO2PAXKDn+7myN8Ah3jyjGHqDl7yaz@vger.kernel.org, AJvYcCWhSF5fxaeB2PniucXgOekDBHplErbi1zU9ENEZn0eWMF+oXnsgIoE0QOyDxlRd+7tuNbb0FSt7GW3DsGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY3TN1kWg8074ghOEJGVLe2jjsVaqxHiZ+jJf66tpbuAu4+dZt
	4hrs/I9PuNZMmckpotvy3caMPQ6BDHIpIS2moZJglsTJ1pUd6CW7qBpH
X-Google-Smtp-Source: AGHT+IGdG/ADT//oanKKwvCNg9rKaGItUG2Tvl7gPeqKOty622zfsDSGIPKVY6X4mOOqSnUGaxK00w==
X-Received: by 2002:a05:6a00:21cc:b0:71e:7a19:7d64 with SMTP id d2e1a72fcca58-72413279ea6mr6087b3a.5.1731003132906;
        Thu, 07 Nov 2024 10:12:12 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a18f51sm1874832b3a.155.2024.11.07.10.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 10:12:12 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	horms@kernel.org,
	almasrymina@google.com,
	sdf@fomichev.me,
	willemb@google.com,
	petrm@nvidia.com,
	jdamato@fastly.com
Subject: [PATCH net-next v8 00/12] selftests: ncdevmem: Add ncdevmem to ksft
Date: Thu,  7 Nov 2024 10:11:59 -0800
Message-ID: <20241107181211.3934153-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The goal of the series is to simplify and make it possible to use
ncdevmem in an automated way from the ksft python wrapper.

ncdevmem is slowly mutated into a state where it uses stdout
to print the payload and the python wrapper is added to
make sure the arrived payload matches the expected one.

v8:
- move error() calls into enable_reuseaddr() (Joe)
- bail out when number of queues is 1 (Joe)
- use socat instead of nc (Joe)
- fix warning about string truncation buf[256]->buf[40] (Jakub)

v7:
- fix validation (Mina)
- add support for working with non ::ffff-prefixed addresses (Mina)

v6:
- fix compilation issue in 'Unify error handling' patch (Jakub)

v5:
- properly handle errors from inet_pton() and socket() (Paolo)
- remove unneeded import from python selftest (Paolo)

v4:
- keep usage example with validation (Mina)
- fix compilation issue in one patch (s/start_queues/start_queue/)

v3:
- keep and refine the comment about ncdevmem invocation (Mina)
- add the comment about not enforcing exit status for ntuple reset (Mina)
- make configure_headersplit more robust (Mina)
- use num_queues/2 in selftest and let the users override it (Mina)
- remove memory_provider.memcpy_to_device (Mina)
- keep ksft as is (don't use -v validate flags): we are gonna
  need a --debug-disable flag to make it less chatty; otherwise
  it times out when sending too much data; so leaving it as
  a separate follow up

v2:
- don't remove validation (Mina)
- keep 5-tuple flow steering but use it only when -c is provided (Mina)
- remove separate flag for probing (Mina)
- move ncdevmem under drivers/net/hw, not drivers/net (Jakub)

Cc: Mina Almasry <almasrymina@google.com>

Stanislav Fomichev (12):
  selftests: ncdevmem: Redirect all non-payload output to stderr
  selftests: ncdevmem: Separate out dmabuf provider
  selftests: ncdevmem: Unify error handling
  selftests: ncdevmem: Make client_ip optional
  selftests: ncdevmem: Remove default arguments
  selftests: ncdevmem: Switch to AF_INET6
  selftests: ncdevmem: Properly reset flow steering
  selftests: ncdevmem: Use YNL to enable TCP header split
  selftests: ncdevmem: Remove hard-coded queue numbers
  selftests: ncdevmem: Run selftest when none of the -s or -c has been
    provided
  selftests: ncdevmem: Move ncdevmem under drivers/net/hw
  selftests: ncdevmem: Add automated test

 .../selftests/drivers/net/hw/.gitignore       |   1 +
 .../testing/selftests/drivers/net/hw/Makefile |   9 +
 .../selftests/drivers/net/hw/devmem.py        |  45 +
 .../selftests/drivers/net/hw/ncdevmem.c       | 789 ++++++++++++++++++
 tools/testing/selftests/net/.gitignore        |   1 -
 tools/testing/selftests/net/Makefile          |   8 -
 tools/testing/selftests/net/ncdevmem.c        | 570 -------------
 7 files changed, 844 insertions(+), 579 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/.gitignore
 create mode 100755 tools/testing/selftests/drivers/net/hw/devmem.py
 create mode 100644 tools/testing/selftests/drivers/net/hw/ncdevmem.c
 delete mode 100644 tools/testing/selftests/net/ncdevmem.c

-- 
2.47.0


