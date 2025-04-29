Return-Path: <linux-kselftest+bounces-31958-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F33BEAA3BA2
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 00:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE3021B67C2E
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 22:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFF5278E53;
	Tue, 29 Apr 2025 22:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="e4efcvoR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f227.google.com (mail-il1-f227.google.com [209.85.166.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2622741D4
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 22:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745966473; cv=none; b=W/7eh7N6y5OoSS4SHtExk+V3OfcIOUqHdDBU3Pp9pFgMuStYQ867S0BzPzn+rx220y/c3fwSS3J3h+SVNSyP5ZvNczV9VuraBCx7vJcPM9z6Xk5JCDDqnl2/gVsKU4wzGGlUXeouRHuYRm+zlJ4GrwEG4G+1aUwPYp76tV4eNxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745966473; c=relaxed/simple;
	bh=9WWclwrCg2TvbbTylHUPNf0AHpKWev2f2XnfjrSo0dg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Tas3ddQM/8SE1xW2gp5zpj5r+3cwLSRWCOV7qvpowLPP62s2jMPj+MNQ1QTbu7HNF0RXt8wbjx/eTbgeDEKzpZuTW031wQ0++btpBk0Tw98LU7Wsxp9Jn8zUZm4klhGGW5sDF6YJJ5f6zhs+g2p0mJGJn8TxB0BogNCrIuDn5W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=e4efcvoR; arc=none smtp.client-ip=209.85.166.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-il1-f227.google.com with SMTP id e9e14a558f8ab-3cda56e1dffso38248585ab.1
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 15:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745966470; x=1746571270; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zfQT2w7zXD5LlB+aHplKgN57RpOC1FTB5zWyhqieJWc=;
        b=e4efcvoR2C8bHWQtUEfzSUSTjBRt/bvr01PClQ13GPLnOvn9YIK+GF4Yiz7ReyOA0Q
         qCmXJDoeCyZwtF2ubcZRYqJg8m+E/pVBUPmzJPlLidwJeDHbOY8y2IdoUm1BOmLmRlrU
         BrCLoTUGpQcqiFHvN9hPcQQ3F4W+a6wKSBH6GBalhE6SwdtO/aLTrLDZF6Z564JhYp1A
         2wAB/IPjKC3Iv63nkIV05vijAgtm/FTRYNuYDcRUamhRmRqeWZFd7a8Q8H2qzxOwqaGR
         WdtKetcFO18I1yk/PJImRLi+VieV1Jx/yClhVWhuJx9TSnmcYcjN3+bS4VPrTBjtvV7D
         Ejrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745966470; x=1746571270;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zfQT2w7zXD5LlB+aHplKgN57RpOC1FTB5zWyhqieJWc=;
        b=JjSzkKH+R/b+bwzzqEs8aiK2QZ5TwrbUIv7zm1CfUhMG0Hdgmwuw9FmlhqKvMJo2KT
         kggFfBBn99f1sPL/hIbkZvvdP8aXvRcK1MOnoqAQlOUgZ2dNlYuMCBnKF81i1hXKyfHG
         RnrMiSwJ7f7BhVU09G6XQjB4+drrBxFeFif3dBbxuk/PfqEIB1Fu8IThejcLiWjpdXgC
         mxACW9zefmAHEJoUF2Q14fgkJ25pHLHHAYNbJJe4SgaGmEGoOL/nhD9gBfqj5oIldllM
         piH6o4NEewt4wYX4j/uG6VODjwgsGdhqLJcMpeFsMikmIzeS1JMTisw9pAYiJfgkJEl0
         J1DA==
X-Forwarded-Encrypted: i=1; AJvYcCVJGhlj+lGDfNBL3ZN9EavxAFwPzgj9B+YEBEN8zxzBJYNdoP+iRutKpo4XdpfAnYPKAUGT4CUw2qr2g4Yq8ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLl3OkJegvc8P5IxX0B73mMDS/VFLLN4cvI+RKUoz27405j3iR
	CsqNSzxNXSjrXcz8XcTWAdVONBFkGoZXC2GwdtJygReYthbPMMY2nElk1WuddVAAo/LtsuO+sPc
	IhXf/l3Qn/F793cIsiQK6jW+SyA/84uls
X-Gm-Gg: ASbGncvraRrQVujHdJTbzq+kGTcw35fj0F7ttyTVCajTJFlFOJxaLwDOmwF3bycHD9/
	uK7eO1harSgBehlf3buprHcff7pKoLPmAzddIHel3A3IkgkNDlGBZD23DBpwN9ZP1xLcS5nY6HE
	o3NwBTlqktFTQKLmJKunLihcgvrwW9vDMPMojsb+yzXDxv7b54wtz5yYofjfhL49LVnFgBGjadt
	EdLt/Ysf49lqzyaFbLbyz1aQBj3FFHJWzNCjfVqUIxRtiQEvEXoK9sY0QHqU0Lfd+uG7Y5oPoed
	SvrydGjhhYRP2IuDLcLiFBf6HcRJw1PVwuZZ910wQc2vUw==
X-Google-Smtp-Source: AGHT+IHLrjPX8uIJEDj5oQlazw0ZvIAp6m9XfLG15y+LyDl9K6XmhE298LlPMgUlZIHAr8kwO+8SDz8hGUv0
X-Received: by 2002:a05:6602:6a47:b0:85b:476e:ede2 with SMTP id ca18e2360f4ac-8649805ea02mr5457739f.13.1745966470122;
        Tue, 29 Apr 2025 15:41:10 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id ca18e2360f4ac-8648bf34e49sm19972639f.7.2025.04.29.15.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 15:41:10 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id EC0BD3400C9;
	Tue, 29 Apr 2025 16:41:08 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id DE629E40ECE; Tue, 29 Apr 2025 16:41:08 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Subject: [PATCH v2 0/3] selftests: ublk: more misc fixes
Date: Tue, 29 Apr 2025 16:41:02 -0600
Message-Id: <20250429-ublk_selftests-v2-0-e970b6d9e4f4@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH5VEWgC/3WMQQ6DIBAAv2L2XBoEidpT/9GYBnFVUiuGVdLG8
 Pei9x5nkpkdCL1Fglu2g8dgybo5gbhkYEY9D8hslxgEF4oXomJbO72ehFO/Iq3E6kqKgndSS6E
 gRYvH3n7O4aNJPFpanf+e/5Af9u8q5IwzVdaqL1vOTafvy+bxyPWAV+Pe0MQYf5wyVKCyAAAA
X-Change-ID: 20250428-ublk_selftests-983240d3a325
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
X-Mailer: b4 0.14.2

Fix some more minor issues in ublk selftests.

The first patch is from
https://lore.kernel.org/linux-block/20250423-ublk_selftests-v1-0-7d060e260e76@purestorage.com/
with a modification requested by Jens. The others are new.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
Changes in v2:
- Use a test-specific WERROR flag instead of reusing CONFIG_WERROR from
  the kernel build for deciding whether or not to use -Werror for the
  kublk build. The default behavior is to use -Werror (Ming Lei)
- Link to v1: https://lore.kernel.org/r/20250428-ublk_selftests-v1-0-5795f7b00cda@purestorage.com

---
Uday Shankar (3):
      selftests: ublk: kublk: build with -Werror iff WERROR!=0
      selftests: ublk: make test_generic_06 silent on success
      selftests: ublk: kublk: fix include path

 tools/testing/selftests/ublk/Makefile           | 6 +++++-
 tools/testing/selftests/ublk/kublk.h            | 1 -
 tools/testing/selftests/ublk/test_generic_06.sh | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)
---
base-commit: 53ec1abce79c986dc59e59d0c60d00088bcdf32a
change-id: 20250428-ublk_selftests-983240d3a325

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>


