Return-Path: <linux-kselftest+bounces-23649-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 841829F8ECC
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 10:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E17641648F5
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 09:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7F41A0737;
	Fri, 20 Dec 2024 09:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="iQvitzp/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD6D17A586
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Dec 2024 09:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734686262; cv=none; b=QbNP4MB8JXAmdstZ4Ng15Xc6NVf768AMI5hod/hEvTSJEQjQOjeYoD3NvaXfwILU9PQV80x+MX6RPgCVGp+2J+Lo5qifAtLiJAjWxr7/QaiinTWJjVbRmMq+ySuI4DLuSHN5ADmEOBg0ce0uVU1yGgPs2lgrDlLVAwvRz7LVzio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734686262; c=relaxed/simple;
	bh=AG6+eJr0Mbzez0KtXoCqfIavWO8Gn+3oa2Wd2UkGx9o=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ICaAQr/bBSM/uDhEfFeVhYa81oj1Bt9cW8+6wuVVS36C32U4r0PPTI9I1ep3NmJGq/9PLUM7PmpP0Mdi0WT6guBOPv4jp2SJ7uPTvd9BO7rS0ktVOFyarZM9oq7GPuSK6EOptjefNtYoZSJmrPizZZukvrB3GThRNmJkUeVo9as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=iQvitzp/; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21631789fcdso18824765ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Dec 2024 01:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1734686260; x=1735291060; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3/pQg0zm2SguUnaI+KvC8TUPNnGrAf3nJLy+WwujVE=;
        b=iQvitzp/qLV7bzi+pGRFnB4EK56AzMzul6x05O08ATWP0m7lj/FLnf0VJBkuMnDy4R
         qFHzosnuun5h2QThc4s5c1Z6hcgZASCRqmelss5dYOoUVYn9P4FWSN9IjtLVcJlwZmZE
         VwzNUj4Q7EGixDvnF6JPgzcvRSI+P5VTiXySJW0LbZXTNTSFe2vNgyA2ZfPWEl+5gY90
         +9AxKllW3EcRlsZ4vGrLBWbN9KTBy2cWJYSzEnDQwbCHkwAOx3/35IggXTBYDkCIxYtR
         U1bZquvtjMhns5yPjom3KzPmwhAbcCmhZnh1gHfvQe0gEc6qzZcDYvEel/CwS+JTFDyK
         vteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734686260; x=1735291060;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3/pQg0zm2SguUnaI+KvC8TUPNnGrAf3nJLy+WwujVE=;
        b=nzxKbeYsmDte3W9mUhvaCQC5bk4Jp48lPTPP4gIczH9nyt00EFBppRdQ4JtNMVRU34
         Vs6je9Pnipi0E3KWn+31Ko89p0p9ig79XgA44UOHJnrdtnukfrroinUl/rtSBpA61YdV
         IhNBF8AORXpNSB58oWmoP1JdyliiRy835n79WRtof741WBaRT9teV1wiYSFvYnuQwWib
         G+ltv/otReU2X1RapQRpzZ0TemlIlz8RW0SZCWJGh/92yjg/mx6s/wRNpiKr0V4e2xPe
         PhTuUUyNYXqt20tDrpVYZsK1XnbcvbLQc+THnR9aRjuzVnremfikk92BolH7VwOV2w6v
         UYfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV87OWCTUJqTjwJtquKX+jwy4htw77YMzdX+5z0NdPWTcEbr6U1Vw0I9bLJFf9oqNP1FSYkVR0P6hqQacvSG+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFWW94W8NNihHInMK9cgufmKXCau31YP+h9Q85owKdUJjr+TXg
	+5DPppRwCO4JGUMNwFNNZaVJPqUYvqBw15C1+zkT4h4NXjE4t6//+RA2b3KDKEM=
X-Gm-Gg: ASbGncuWJPDmcX1DkLtWsQeUJt0qUgbFkynE9y8SseBglnKWWmaNphcWRrRjYRmdiFK
	yYs6JbK/0CgHWWBOVRnF7FHmqCs4SX1RPFnJjHWXDBBZQOR7mJ3O2NQ1nt9aB2rcV10DGVuOHsX
	XFDSPYMHFZH/QnrpijkbYCFmC91FARAuR3tjomHDX+qBDEWlgh1KtxTSgwWpz+z+l9OsFLSRGQi
	ZIFSVi9tBuEhzpOvGZ3kbOX6hHTUwHyyWx4RKgcZVZkMB+kCWHa7zI3TcMolBRA0Q6JWAIFciK3
	x58AwI69T5c=
X-Google-Smtp-Source: AGHT+IEpWrI68w5QRrLBoY3vfRKd52xvFFKYthd/wAZMcbSGE0+mpNFqrjN4EfZqZx+jg34DnfmINw==
X-Received: by 2002:a17:90b:1f84:b0:2ef:ad27:7c1a with SMTP id 98e67ed59e1d1-2f44353f193mr9310703a91.2.1734686260013;
        Fri, 20 Dec 2024 01:17:40 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f4478accb3sm2806715a91.51.2024.12.20.01.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 01:17:39 -0800 (PST)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: greentime.hu@sifive.com,
	vincent.chen@sifive.com,
	andybnac@gmail.com,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH 0/2] selftest: fix riscv/vector tests
Date: Fri, 20 Dec 2024 17:17:25 +0800
Message-Id: <20241220091730.28006-1-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

Add test counts and pass message to remove warning of riscv/vector tests.

Yong-Xuan Wang (2):
  tools: selftests: riscv: Add pass message for v_initval_nolibc
  tools: selftests: riscv: Add test count for vstate_prctl

 tools/testing/selftests/riscv/vector/v_initval_nolibc.c | 4 ++++
 tools/testing/selftests/riscv/vector/vstate_prctl.c     | 2 ++
 2 files changed, 6 insertions(+)

-- 
2.17.1


