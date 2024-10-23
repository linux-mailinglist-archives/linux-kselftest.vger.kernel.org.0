Return-Path: <linux-kselftest+bounces-20470-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A199ACF23
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 17:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E41BB22612
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 15:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638361C9B65;
	Wed, 23 Oct 2024 15:44:07 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0A019DFB5;
	Wed, 23 Oct 2024 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729698247; cv=none; b=ZcDOePO6SGqTaztT3wGRUHkhAXtSpq5QfKs9vJSsJ60mfJuuYkyTp/irDQh2mktJfUfdmXfBUIDjmFQSSPvE7YDXfJjfGk4mXcUuXS86PbHoANg4e13GyseemOuYPMy3p/J5ECT2Oz/tVcW8jVGI4EF/ekUlUJb4EaeFMdem3to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729698247; c=relaxed/simple;
	bh=ycPj+FS/NUPzRF4ulU9fnt6FAmTyDx+kmAUaFxJePwk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tJq6ajkpmNJs7uU59KwQI+h+Aa+6aeKrCpxjCh4M9yYwkf0ZaxDcvHJJs5X/IOknmmfo0Od52TTTk+68qhq3nTV0OqLUUNK2CNxxYaKlQzCxtgo6J88pg6HS2rFOKJfIu1xHkMtRtv4+TI+eAjOIvZV/J5KoDJVM4CwIm6Fxr2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e18293a5efso4674190a91.3;
        Wed, 23 Oct 2024 08:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729698245; x=1730303045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=efAFmm/rvjXAbZLeEA0ZhIu8ih14XiKCa6umoMNYbRI=;
        b=smCnCYBHaVE3tejFzeWo6x3PABu8SFMInXAbK/pUTZ8GnKXffw+GcMmPU9tNTyuE6O
         uWw5iculkSUx+bRl7oY0L+xn+TXuSdIwp8BdDalMoNMArRALYvbW6Lce4M6lbOA8k8BO
         ADlghY9am6xyTjKMZW7CgjL6MPl6BvaJuI6Kh0VWkiylz2GyOKSFFVp8AkR9nCeM/iG3
         Jh9BWsXPytLkugDjgtkH4PimqTVrLbosiHcC8HyJmPJpIbmLE7Y1MTG/cuSbued2m1jd
         uG68TnSADz3jC5EDoF+mK2JOZHPd2f/Tvz4R4TrgsJQQBuBdJJ9dtBQIgfWV41VW1edO
         jWvg==
X-Forwarded-Encrypted: i=1; AJvYcCVovn0p9GbdORFrPSedAOFUnYawoBSlD9nBGWDs9IfFu7ZLli6CDpycygc7whAUL3RKeKKE1wxz436aR7I=@vger.kernel.org, AJvYcCVqFJGxhnxcL8pmMeZ2FghFWlIaH5KFlg8Cc0JNSvw6Fx7oB9FE2CZGA4oJ71aq36FmTLNFv+ScToh+75OyqMkf@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy5jLPdyoMEtafqtvaywZsx6+Skbq2+TWKG9QtSE3sKZiDQKql
	xCQP96C6xtzCfNNlpeWiRasYwfmSzMYK0IOvhAiA1fQwNfjghVRCF3hH1pI=
X-Google-Smtp-Source: AGHT+IEwCb1mlT1+RvS9ZMWVwlL/C2aa86O4MH/6R91LTW5vCTuvo29v720vFrIe7aXxdyHToC3Tdw==
X-Received: by 2002:a17:90a:2eca:b0:2e1:e19f:609b with SMTP id 98e67ed59e1d1-2e76b628edfmr3325011a91.24.1729698243124;
        Wed, 23 Oct 2024 08:44:03 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e76df72591sm1580326a91.17.2024.10.23.08.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 08:44:02 -0700 (PDT)
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
	almasrymina@google.com,
	sdf@fomichev.me,
	willemb@google.com,
	petrm@nvidia.com
Subject: [PATCH net-next v5 00/12] selftests: ncdevmem: Add ncdevmem to ksft
Date: Wed, 23 Oct 2024 08:43:50 -0700
Message-ID: <20241023154402.441510-1-sdf@fomichev.me>
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


