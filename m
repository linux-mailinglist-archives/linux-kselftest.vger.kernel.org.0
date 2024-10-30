Return-Path: <linux-kselftest+bounces-21108-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 296F49B65BC
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 15:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B30B1C22691
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 14:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A863D1F429A;
	Wed, 30 Oct 2024 14:27:28 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C1E1F1318;
	Wed, 30 Oct 2024 14:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730298448; cv=none; b=WH1fbLC+bBcG1EVzd5aXnziT1hiRq38JGeZ/rH8d6pInDiuPSNqq0MRUjJM790xS8j9LaeXtvVi1woLMx+x5zi2ERbkI8xFuQyGPfmiAtJUfEKpDE06t3SCjKMlPjGceu22oBnDjfmDNcO+LVGW3w1F1+cGnVsjOblxUdGATS7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730298448; c=relaxed/simple;
	bh=fdTlufCbZhiUYgshLzgCtmAceM3onaTjAgEf6R64lN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JKOi/KGOQGeA9B8OFvobmDFKA/oFfbFxypX2FSqrouuBZ2SzXN1yzKR6K10V6NmrBFrvpo9T5TUvtymTYgczk2ZbUjqPZhXSS5Q2iIkOYM6xddyTnO3f9PUo/9Fi0SGPB7WRS3Yw99ZjzXZWiievHlbOvGv82SEHBAPd6CTj6RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7eb0bc007edso3438576a12.3;
        Wed, 30 Oct 2024 07:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730298445; x=1730903245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ALb0tBs4NDBt4u3K1Ou6MF9SiXOV/Onh0/EFY/ivrUI=;
        b=UQcbluAHG2wg/M1j5MpWEhCpCfbg1v0NEnQa/9tfViEyNMNgnxQRXKz6esOEpyFNUa
         RlvefZ212lgwMbpqPRVLrnP9tg7WPSx2I2brHABICnYGkvXmbHZCG6RszQmqEMowtuGT
         sltV+S6VbFRB3dXf9vLNazQdNFeMnUBDTjYPOac2NFQVgs4JYmpAmiin/PMenMpml/C9
         QxfNr/HSf4MjgQtj348xP15NrRbr5ciuLh5Durpm5HLwWyk0H2c3YFfrnYOJQAF+NDPJ
         i8zGy3a0QkG/nYOImD9acIHbJT/F/y1a4stGgc4anCp25dEWCFc3qw091F9U5rwiPWsa
         B61w==
X-Forwarded-Encrypted: i=1; AJvYcCUlYO8D6AL8lJ76AvTdklfB+os45vyIeN5d6z4ffVf53HeP0cQDDQOkfpX5s9jr3INQ6zXrIA8iblF7+DY=@vger.kernel.org, AJvYcCWVdWYShCwnwii4YB0BfdTWlYA5bnz+rgyhSW21SKMXUhB5K343q54CQeRXI0PuSjykHJ7P99IfYi7MTZ+T+LgF@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvj0dk5ucZ9jJRa3n9kyGYCytC/NefU67SCGqm2G6CmLrzPpbS
	PWNd3Qkdedr1EjavTOqsuy8RgnVI2kh1rV0sF5tBEDafPuCpem4BiPlXi5k=
X-Google-Smtp-Source: AGHT+IF7CE5jtvVBGnU/qez672fRz6aDeNOCseUmK9IyiVNs1IRC6vimUzOVgVduDPxsQ1l8jiXnMA==
X-Received: by 2002:a05:6a21:3941:b0:1d9:69cd:ae22 with SMTP id adf61e73a8af0-1d9a8431ab7mr16966490637.30.1730298443893;
        Wed, 30 Oct 2024 07:27:23 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0b82asm9311008b3a.111.2024.10.30.07.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 07:27:23 -0700 (PDT)
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
	sdf@fomichev.me,
	almasrymina@google.com,
	willemb@google.com,
	petrm@nvidia.com
Subject: [PATCH net-next v6 00/12] selftests: ncdevmem: Add ncdevmem to ksft
Date: Wed, 30 Oct 2024 07:27:10 -0700
Message-ID: <20241030142722.2901744-1-sdf@fomichev.me>
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
 .../selftests/drivers/net/hw/ncdevmem.c       | 773 ++++++++++++++++++
 tools/testing/selftests/net/.gitignore        |   1 -
 tools/testing/selftests/net/Makefile          |   8 -
 tools/testing/selftests/net/ncdevmem.c        | 570 -------------
 7 files changed, 828 insertions(+), 579 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/.gitignore
 create mode 100755 tools/testing/selftests/drivers/net/hw/devmem.py
 create mode 100644 tools/testing/selftests/drivers/net/hw/ncdevmem.c
 delete mode 100644 tools/testing/selftests/net/ncdevmem.c

-- 
2.47.0


