Return-Path: <linux-kselftest+bounces-19266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA679959BD
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 00:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A6A91C21D93
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 22:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE202185B9;
	Tue,  8 Oct 2024 22:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPVx3ZA/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7895F2185A4;
	Tue,  8 Oct 2024 22:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728424911; cv=none; b=P/FU/Ui7I4vDw1JwIMqJPlLbJ6cbAmNRsOVs6FmYWWgPQW9cq8PGrYZCXZBKYqE1CggkLV9aQWbkieMTwCobOXESa1OY3WvS7TpneQa1GNO7Y8pCm3n3BIgi74yqLCt5Q7cTYTiOF3pzjQrO258F9pVsdrkDPNz0XqgFrRRTQPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728424911; c=relaxed/simple;
	bh=HxlKc/Ygqvx8mvscuPoL7nSKaG2WOPrulhDeOr5LOKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VLfs9wRG2iK28edQmsw+bsz9eiz3LvnjKrynZlupE0LPwpL+QjY3d0ftEwtFystlm3Q3lMLvuzSEiksfC/OuSV65zhnDyQFqHV6DFIvGf0FDTtNerltmjYmicomHWGRThgOUafCCprQCJIEZzDxFXE4iLcc3rljE5XKCUWRwp2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPVx3ZA/; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37ce8458ae3so5503591f8f.1;
        Tue, 08 Oct 2024 15:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728424908; x=1729029708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9iT4t6likmZ6EV867VVWYvGZ/+8qv062JeJ0/JhHlhs=;
        b=nPVx3ZA/kZkEjsHXqz6zmC52X4eB6pH9pQSQts1TDN1SigluJvg5Pk6JTwSaujl7Ld
         XB9uZ4+XKqzCfgFve1NP66Cr4MzZ5vTurrEFFS/jpOR+iKR6WGBJJAIziSifXoB8Gws8
         YjpaIsYqH7Jgy8C/0LsoxHRl0T3KmwLRXn9ulR7vXcJO3rW0YLm6YxSngosSiU64Ik9g
         2q16lNllkDp9jf9CDuapeRDAHKW5mrVIEF+odgxjBn6ro91ah8j7+IBufr+t7gfev3j/
         G2E1YrL6OpKX1FAhqNZz6IuRUco5Bao4/AvNGFAz8xuMRzR+UvN5rVVo7w9QoBiFEuUu
         icvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728424908; x=1729029708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9iT4t6likmZ6EV867VVWYvGZ/+8qv062JeJ0/JhHlhs=;
        b=ZAZRebO4r8EOsr15+YzLYDW2YEKXW5hx5CE2IFY2MPEPtvt2cRjgcqVQROJiL0CPvX
         5GgrTUL2q9TMYJLkgJqqfCuFv/hv3vY4+iY5ATNERV1pvgpZr1wk9sEAVMYXU8MbbIMI
         R+aNYtKl/lQa4+E3b3glrx+v7onAmZOW56Pn/bqPME/IN7Li0VgCRbv8KgYaknzrUJwj
         QzG07HFUmTvAYsgFqRxKae2+jAuowcBXFP9jNOCnbGyXAF7xuIWAioq6/LLQR0iczJpS
         VA4PFkD0onregFqUQMwzno5scfI+L/zthvYvAFtNZJjSZ5tEw07C2sTebN3Nrgv/NbN2
         U9tQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0wkrBvQbYO6hCWel9hfBP198YjhFJbTu1ZOpnZhXh1YMI1ri/d31hQ53WLU81Zn29iAxBZVTS2Z7Bk0/5DPjj@vger.kernel.org, AJvYcCXj1CBgmPLrIQhq3qq2C7rEQsX+1pzlRs+kyfd/zqs3FhgTHnqWDTmHcw8XqLXo3PeaHNef5jm5@vger.kernel.org, AJvYcCXzmVBU6n9TaxRayh7pucpbakmTHYdCoPg4dazNA5nbe0XlNw0Ky5Qznsk0H/ox8OdKZC2+JU8oJci73j4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKMIhusjQZKV/DWEw3HCqtag9fxK1opf5c1yqQIAOHJbhenBfH
	v71GZ2oBTQH+UI8TI6HlBtWUBE5E5678kLDDOpRCz8HiFtve8BL3
X-Google-Smtp-Source: AGHT+IFPuRDk0r9ueLuuhxbfkB4+EacuR8rQLWAJFXyxwWdoKcIhBC6PRqkhwbzdF4UqaS2JoSH/mw==
X-Received: by 2002:a5d:4e0e:0:b0:374:c8eb:9b18 with SMTP id ffacd0b85a97d-37d3aa570c3mr257037f8f.24.1728424907438;
        Tue, 08 Oct 2024 15:01:47 -0700 (PDT)
Received: from alessandro-pc.station (net-2-44-97-22.cust.vodafonedsl.it. [2.44.97.22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e5bbca1sm557062766b.5.2024.10.08.15.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 15:01:46 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	dw@davidwei.uk,
	martin.lau@kernel.org
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	anupnewsmail@gmail.com
Subject: [PATCH] selftests: drivers: net: fix name not defined
Date: Wed,  9 Oct 2024 00:01:33 +0200
Message-ID: <20241008220137.274660-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fix solves this error, when calling kselftest with targets "drivers/net":

File "tools/testing/selftests/net/lib/py/nsim.py", line 64, in __init__
  if e.errno == errno.ENOSPC:
NameError: name 'errno' is not defined

The module errno makes available standard error system symbols.

Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---
 tools/testing/selftests/net/lib/py/nsim.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/lib/py/nsim.py b/tools/testing/selftests/net/lib/py/nsim.py
index f571a8b3139b..1a8cbe9acc48 100644
--- a/tools/testing/selftests/net/lib/py/nsim.py
+++ b/tools/testing/selftests/net/lib/py/nsim.py
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
+import errno
 import json
 import os
 import random
-- 
2.43.0


