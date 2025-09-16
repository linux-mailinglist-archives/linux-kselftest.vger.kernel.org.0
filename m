Return-Path: <linux-kselftest+bounces-41624-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 540DFB5BEF9
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 00:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 145393240DC
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 22:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDC32BE7B1;
	Tue, 16 Sep 2025 22:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="A8q7tEap"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f227.google.com (mail-vk1-f227.google.com [209.85.221.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049DF28467B
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 22:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060372; cv=none; b=tjkl6SCs6W6b00kwaC1tcyB0Dxl9SHFQMm8Z4xl/1a5DwUFBGWVqq8wTGIo1G7eNbEsisme0LtB+1faOHeamzsh601zjczX/iI3z3UzfBR9XwoQgpi7f5IkBDyoCyvmE3HGHNkBecXdMBatAnwyS+xDFWXtcraXfFgLxxxTFIjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060372; c=relaxed/simple;
	bh=0T3RfCRDcnpozJXeQUuhKRw9ET2REuSg2YGW2FlpbJ0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U7aDPvVbqmMJyZFFXT0r/O9PA1AqmBUUoyZ/gQhMdBVdSpUhpaI20zJTd5xzVIwCVg3GG+ItPg/Z/Z9uUkCdFtLfRsZeTTFIVL/9OpMknCMb25g4uH5j+R+nCD0UiiW1/bQYutV7TbZMeE/SyfLgmuSNSgfukCJPnYyHn83QDEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=A8q7tEap; arc=none smtp.client-ip=209.85.221.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-vk1-f227.google.com with SMTP id 71dfb90a1353d-544ad727e87so4261004e0c.2
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 15:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758060370; x=1758665170; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oyhEptnkjYKvTtDaCmbO0qvaJj1u/0HzrshZ6BHXL2g=;
        b=A8q7tEapTkZQ1Ew071AOO8E5XBAjEx6WJ2lhrI3lsktwlpFOlHH8CnF6+F+xVWW/hU
         SD572Aw2BbHYlzptdVQd0ml3K3/+1QGxCcqtworHLXCTPY9H6l4guQqRj6eTzuXD6gHC
         tQm3OR2zO1aZv/Y+Y7BAZNm9YzHq4K1BJmMx28IReb1hh2WFC5XHasrqXQRYzZVv3Ci2
         yqQCdZi461OAPBAovgoI5BeAy9AuyM+F5g5awD72cRive27GwUclALcV/kHUKDUtMR5d
         2iMos0p1GaGm0jvym6/aEShSvDQiG8H6QfYLqWZgnGRij6MXssJb99y3aUS3II4I2fcG
         KAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060370; x=1758665170;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oyhEptnkjYKvTtDaCmbO0qvaJj1u/0HzrshZ6BHXL2g=;
        b=EE34R3FkvCf79DAhwXZbQz1hn6uMZaoyqYlPSeD7+hPy3BmjX7gn/uJI+G7AlKioHl
         0aMtXJl1XCtOwaCcQET5lPjaTfTUUL41XZK5RIr3olZNYjf/YeZ1mXAk0TtoKBc2sQuc
         VJFoyxROh5HdApzo9zH2t1f88WflEsqNh3w88BFGoEMbi8Sn/FqEu0IioVjnu1Bfa46T
         9oUK5cNdBRYDtViKIwrEutff+TAKsIBXum505/uUlXLlJ5kN5min1JKim8RiXExjqAVs
         u/wJdTdbXWSgfeheWb7a6zNTn8IYBcwNBDmHDt9j0wpE6kndoK3r5zo+5uWq36J/c+0B
         Q2DA==
X-Forwarded-Encrypted: i=1; AJvYcCVh2KdOkNJChX56T2DpvZUJGmNfCaEOF5oRvzmISd3HA6wCS4RaSOWZTeGvrHvdjn8wStWJD9NjDdBKK+ti5uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhDxyq3wvm5alCC4z/Zn/dVyDWZ8vyKS1ZNenlcMMpS7fCY4GG
	pnpY/gGmTUQpJj7hsesrvN2AGnanSU8Dv8u2LtKipvW/zPxLnd5SvcVmwKWoQ8WO1L3W4oXF4Fu
	0HOtDiGFVuH6guLnF+vXtdHxhdWb2ASd/yDN0
X-Gm-Gg: ASbGncugYJd1/dSkUpdCOzf9t5or/gPkqVZezi+wFkRdnBRr1++/WTiTpMxKBZt/vaw
	efD+fyyYA/dgt/7nEmw57myfWPRiF/12rdQLhhgyaV8xrv0pZEVytCemYdeHaFjRLfbQoEpkwtA
	C8tX5VeyTLvd9KM15P1xaWGIG8KfFW2BIo4gGE4w0VMVocTL6s1WVXeWuaf6f96ACM1Hi0WhSLY
	KwBye4uRe0097jjG8COcABG6WIr3b7JKQGQhA2/UeaANWIgJ+1zEY2a3YsRIaRlY+YX8Fct2ktL
	QLWQLLTny6jhbwOmB9HiZriUtJ48Bid2IVBqQfqyfVK0Dn30TIYUQ4TN6Iloa5gCRlvMkK7S4g=
	=
X-Google-Smtp-Source: AGHT+IEzFWi2OlWmB6cbeEaJlNpwq3SZVqUGZX2zuzQBFkjFOWfMIWTfg3D9KsLmzXHUiHz5L79IAjQs2mnu
X-Received: by 2002:a05:6122:1795:b0:540:68c4:81a2 with SMTP id 71dfb90a1353d-54a60b8b059mr36111e0c.14.1758060369613;
        Tue, 16 Sep 2025 15:06:09 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-54a0d1b95a0sm1704081e0c.2.2025.09.16.15.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:06:09 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C61A4340853;
	Tue, 16 Sep 2025 16:06:08 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id B6B3FE41646; Tue, 16 Sep 2025 16:06:08 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Subject: [PATCH 0/3] selftests: ublk: kublk: fix feature list
Date: Tue, 16 Sep 2025 16:05:54 -0600
Message-Id: <20250916-ublk_features-v1-0-52014be9cde5@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAELfyWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDS0Mz3dKknOz4tNTEktKi1GJdA/PENJNUYyPDVNNEJaCegqLUtMwKsHn
 RsbW1ANaEpHJfAAAA
X-Change-ID: 20250916-ublk_features-07af4e321e5a
To: Caleb Sander Mateos <csander@purestorage.com>, 
 Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

This patch simplifies kublk's implementation of the feature list
command, fixes a bug where a feature was missing, and adds a test to
ensure that similar bugs do not happen in the future.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
Uday Shankar (3):
      selftests: ublk: kublk: simplify feat_map definition
      selftests: ublk: kublk: add UBLK_F_BUF_REG_OFF_DAEMON to feat_map
      selftests: ublk: add test to verify that feat_map is complete

 tools/testing/selftests/ublk/Makefile           |  1 +
 tools/testing/selftests/ublk/kublk.c            | 32 +++++++++++++------------
 tools/testing/selftests/ublk/test_generic_13.sh | 16 +++++++++++++
 3 files changed, 34 insertions(+), 15 deletions(-)
---
base-commit: da7b97ba0d219a14a83e9cc93f98b53939f12944
change-id: 20250916-ublk_features-07af4e321e5a

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>


