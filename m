Return-Path: <linux-kselftest+bounces-37614-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4F3B0AEB0
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 10:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68D2F3B3F0E
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 08:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBFC233713;
	Sat, 19 Jul 2025 08:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ui2PjVOs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C490A145B16;
	Sat, 19 Jul 2025 08:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752913887; cv=none; b=YJ+kTO67ovnaEQkA5V2PmPPkxOl5rayi/2OokbU5rbb19ShXzTN5aneCAW1HJ+m/MXLX5GVctsAfAh72JT1iVi2T9Zxl/P1JPF245eXsdOqh8bKnUEBlZramZV2jr6aBUzHzA0NqKshF3H9t08U/g144sdiXVy+ab42n+1swbvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752913887; c=relaxed/simple;
	bh=zwnxSqe5lR8Z6HseY/ne9r6SGeGP6t2w8+L+UYBZQyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SNJggBXfccMrwijdJ5G2aRMGtR5E+ggrH+SGF8aN36tk/vvxbn2S248YXRLpS0Vcq7CBLMUUgsJkBFHDvSdLeMKCrx3ABqWIlXL9HBlySa5qSCZ3RQFu/1jse0w4yMonBt6QalfIruNpZJ7O87WaO2ZFR5h7R3bEL6220I8CrQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ui2PjVOs; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4563cfac19cso14920275e9.2;
        Sat, 19 Jul 2025 01:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752913883; x=1753518683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=upc4TWlnuNsOW0c1XS4mh7IqE7Z1IE4YYMUxgjQnKz8=;
        b=Ui2PjVOsvtM9yRG+fKp1GiFPVu+H+9RAS2F/tByCJhYdJG/a8n73PwnBfcYZagPsAS
         MjZ+tv6xOYq1tGlbcpCTk4N6JuM9tKlPstAgGRpx9z7VJ61rPyeaHK1cGa0qA049BtDH
         LN1D1Gsh80kJuOEowOOuGHy3iIRd9Px+HZIrBH5OOg8vzf+HlJf02w/2N8ebD80LSggh
         pDTFoiXn1NyFYOT5i4ZZiQfYlZltxrU+YA09tmfN1Z/nIj3ZkO/un9RnuwstRvypOaRr
         biUm1Mdz87wUGRqhuST6BAspLc7aElQY4F4VsTIFKpBobnnBE4IgCZwurEPxcEERzf5q
         X+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752913883; x=1753518683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=upc4TWlnuNsOW0c1XS4mh7IqE7Z1IE4YYMUxgjQnKz8=;
        b=lRUSQTtlYdnUOPQo5ufHoGyN2uqhV7XhtU32yDyUS7j/AhD9DfDFeq/Jep2OWbUIhb
         29cvORACVFgUuZ87sbpPgKVyGKrgfDPfsoH0Izf7PgWdxak0eiGAgltvW/Aci0kEbSPw
         6lmDKVa08nahuhlnmj6s1uzhOlI+7HygC8nnvd9eMORPX7bs7CySu9ce48rdopj74vSW
         U7e6SYpGB1hIfZVlQ83So+056sGuDKwwqP90x9hwzwLkKjZzJZ4hDbp8weu7iyKPFNMd
         14hX0bxyHdmZzP4DGHpgHVHNo9/aPKqUVsJw+my52w8Wbfbk6KpYkGOZw31od5xqD9BW
         Vbng==
X-Forwarded-Encrypted: i=1; AJvYcCUCtHh3+UrxjJST+NVTEJAthZoqyg4XrCy1SxW9AY2CErRbhagMBbjLr/zoPfWp7h7erpg=@vger.kernel.org, AJvYcCVRxDtVu1PC5sSDCKU4F2aY2cJt6uLtt5fdEERqJf8mtG7YsZI/LoSS5TTfXAhp7hhlUFQ/lwY3VpO6W4+bd1nw@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcl89QnZY33Qe2nlzaJw8F+tqyI3ZTsi/blil+fzDMMZhfQFur
	+Cj+tfUg7RAVixZVhO2q2LG2brxLGg68iAcnZkFX9gntIsT9uGtvfMpcRkJ5bdPj
X-Gm-Gg: ASbGncvNOtORusFnKQb3nV6rDRQoNTrl4BeUisX3FD5CqC+dS23vs9Bz/BhrAhs2PDk
	aqUTr4pJ3zG6lfBIqXBYV7Hmd9UIRANOEDYqQBozLPM73AkYWmiaPLp2SI9fhr8C8KA+JWYqPvw
	cHHid16/uDhw0FfZa+V2VmPO2QCe5RaVIK4ipFEeVXmeT+Yff6/DxCNq9+mz+fSX+KkOFCBG5RF
	1gP/pTXte1k3xDdDFxTCWMBPRD81zeRMEjEDA1msZR8x+mbfi/DVxZhg/ANMTQL7LU2Yf8pnoSs
	tTgvo0yTk5c+UDfEosobroH/xYDIW2tNBjbgpyokNYwjYUuPYtv/1eloYJNsAqcnG1EsQLeQRE2
	49Qsczcz4ue2aNY+QJtA1/ETjZvPkpQ==
X-Google-Smtp-Source: AGHT+IGtF8TGIcqmn0ui84fLs1cq0Ilz5RNbdZIoWXiX85pAFJw5eEaw1Zh2+qhIQXEp8vvhvpoVmw==
X-Received: by 2002:a05:600c:310b:b0:453:9b7:c214 with SMTP id 5b1f17b1804b1-4562e29c33emr121180535e9.29.1752913883134;
        Sat, 19 Jul 2025 01:31:23 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:5::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b74f78bsm40594775e9.27.2025.07.19.01.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 01:31:22 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	horms@kernel.org,
	cratiu@nvidia.com,
	noren@nvidia.com,
	cjubran@nvidia.com,
	mbloch@nvidia.com,
	mohsin.bashr@gmail.com,
	jdamato@fastly.com,
	gal@nvidia.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH net-next V6 0/5] selftests: drv-net: Test XDP native support
Date: Sat, 19 Jul 2025 01:30:54 -0700
Message-ID: <20250719083059.3209169-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series add tests to validate XDP native support for PASS,
DROP, ABORT, and TX actions, as well as headroom and tailroom adjustment.
For adjustment tests, validate support for both the extension and
shrinking cases across various packet sizes and offset values.

The pass criteria for head/tail adjustment tests require that at-least
one adjustment value works for at-least one packet size. This ensure
that the variability in maximum supported head/tail adjustment offset
across different drivers is being incorporated.

The results reported in this series are based on netdevsim. However, the
series is tested against multiple other drivers including fbnic.

Note: The XDP support for fbnic will be added later.
---
Change-log:
- Force checksum computation in netdevsim xdp hook
- Update checksum when updating packet for head/tail adjustment cases
- Use 1 as the minimum value for the data growth while adjusting tail

V5: https://lore.kernel.org/netdev/20250715210553.1568963-6-mohsin.bashr@gmail.com
V4: https://lore.kernel.org/netdev/20250714210352.1115230-1-mohsin.bashr@gmail.com
V3: https://lore.kernel.org/netdev/20250712002648.2385849-1-mohsin.bashr@gmail.com
V2: https://lore.kernel.org/netdev/20250710184351.63797-1-mohsin.bashr@gmail.com
V1: https://lore.kernel.org/netdev/20250709173707.3177206-1-mohsin.bashr@gmail.com

Jakub Kicinski (1):
  net: netdevsim: hook in XDP handling

Mohsin Bashir (4):
  selftests: drv-net: Test XDP_PASS/DROP support
  selftests: drv-net: Test XDP_TX support
  selftests: drv-net: Test tail-adjustment support
  selftests: drv-net: Test head-adjustment support

 drivers/net/netdevsim/netdev.c                |  21 +-
 tools/testing/selftests/drivers/net/Makefile  |   1 +
 tools/testing/selftests/drivers/net/xdp.py    | 656 ++++++++++++++++++
 .../selftests/net/lib/xdp_native.bpf.c        | 621 +++++++++++++++++
 4 files changed, 1298 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/drivers/net/xdp.py
 create mode 100644 tools/testing/selftests/net/lib/xdp_native.bpf.c

-- 
2.47.1


