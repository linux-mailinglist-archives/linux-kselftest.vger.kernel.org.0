Return-Path: <linux-kselftest+bounces-21393-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8969BBCFC
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 19:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D6A7283146
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 18:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE0F1CACE8;
	Mon,  4 Nov 2024 18:14:34 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1681C2309;
	Mon,  4 Nov 2024 18:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730744074; cv=none; b=QVM9ihnDQS5hdu94cJxTuCCIvB1h1IQP6hnIpm7SK4Tpof1BRtcQRoY2waUxlVOqkjHVEXyioNfymTsRtAKW8JLafGd/EWOKsQSDPbu9KOZk5zMzhHcrP6uatEadw9feuiJsAyXb+I94/DMpetlzch+I7R0TbEjDTwphtcZU88Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730744074; c=relaxed/simple;
	bh=aVxP0jcxO9fNti9CoyzA2eVeDe1PDDS/i8L1u30o3LE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JOgc3KnjCT9UUbZMlLbv7bBFsKUMirejmPcknhz/BXz98tQZxDcg8YAdpbieenuaKL/tTGH5GK+ts6yFVsY0Hl9K5Edqopy+JbLkkUHNb6pRAYe2AFzHckCoHqAnt9MYp5kJEva12LbVKz1WbXs/OXCq3mjzCPHpHClaX3DS3HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so3238762a12.3;
        Mon, 04 Nov 2024 10:14:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730744071; x=1731348871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IAIq1Ui2j9QsUZ4JYb3Wemxk3lhTCIGOK6mHtuKExIM=;
        b=vMoDHGdl3qB9tkFPjT5wUqOuE/TDgdn6D1T7hwgzFCjgZTPbYpcz6UOyLrnDXzwQF3
         ycjdPahGuuQvP5t2rcJd+FlQJX4rmaMb2we2ZVrlBm06CLgZQVmrN3dJb6ZKMQqWvvce
         8YcBfIbGs1CrmxJH+6n6ALAAGBmEs47ZI8kFO/Yvy59BYiW9AgiZ0Q70+xVYmRi7cROG
         1b6RhItBeEDkJ15MqIBDE+rO7yZg6zidXFOkHEyS8KYxRX6ozuyMo0V1vnLBb/FBybf6
         OOJEFSqVyupPMJjixuEFuEEgjylmmNUymD4EL55VCqkM6AgFfekHYFhqq9jTx+FtStmC
         p+XA==
X-Forwarded-Encrypted: i=1; AJvYcCU5Z0BDMdNYMKQeG3+gx3kX6QvpN4JNR8557Fkm1hXeU5CzxMyTB4RMw8VG6pnE9CK+I+gT4JrSeMCqH+g=@vger.kernel.org, AJvYcCVTOBumGPZhasFnPiQwIKi4FGgdLcvFuMjqsKy86Xxuv9lRggqWrfiHIK6D3MrKb8Z4xm3GtB+Ts7EzKFelu5yd@vger.kernel.org
X-Gm-Message-State: AOJu0YyEHgDnnzKU9zDvz/zJGasZw3QWO2x72QcmXfGsqxw1ViXwQWoE
	r9BzovvDe2B3GzxKdoulDwNcM5DpaWDTtCBgE0O1DJCPimtZ/vdIpvuh
X-Google-Smtp-Source: AGHT+IHhN4/EXQ7OS1e/nJAXih/1yqXdu9y3W8NeMwURhM7GYyj7osYLIyn05QRlDWosG5NQnQ9Otg==
X-Received: by 2002:a17:90b:4a42:b0:2e2:b922:492 with SMTP id 98e67ed59e1d1-2e93c174626mr20471167a91.17.1730744071208;
        Mon, 04 Nov 2024 10:14:31 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fbdfc1asm10217617a91.41.2024.11.04.10.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 10:14:30 -0800 (PST)
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
	petrm@nvidia.com
Subject: [PATCH net-next v7 00/12] selftests: ncdevmem: Add ncdevmem to ksft
Date: Mon,  4 Nov 2024 10:14:18 -0800
Message-ID: <20241104181430.228682-1-sdf@fomichev.me>
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
 .../selftests/drivers/net/hw/ncdevmem.c       | 786 ++++++++++++++++++
 tools/testing/selftests/net/.gitignore        |   1 -
 tools/testing/selftests/net/Makefile          |   8 -
 tools/testing/selftests/net/ncdevmem.c        | 570 -------------
 7 files changed, 841 insertions(+), 579 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/.gitignore
 create mode 100755 tools/testing/selftests/drivers/net/hw/devmem.py
 create mode 100644 tools/testing/selftests/drivers/net/hw/ncdevmem.c
 delete mode 100644 tools/testing/selftests/net/ncdevmem.c

-- 
2.47.0


