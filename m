Return-Path: <linux-kselftest+bounces-30001-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A7FA7838F
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 22:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6D5316D923
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 20:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5762163B9;
	Tue,  1 Apr 2025 20:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="eOe4Qc5Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f230.google.com (mail-pl1-f230.google.com [209.85.214.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94560215045
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Apr 2025 20:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743540560; cv=none; b=i+h97q3VJqb/Dqg9Owz2xbGAPvXxEgXyrrCXiGAGvWL/iNpZ/IQax/tKmcwjeQpjfBFeC301+rR92UqCY+B5GMnmjRPPtPqmtrNteVX2KR8WXX4eV3fXrblTiwDK7Fzj6llLEQxk2h7Uz1mxkDPPGDTqspzmHodzyOw+FQI/0zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743540560; c=relaxed/simple;
	bh=30PV2+70FCQMUCz+gunbFAvwdSKP+yMM0OGPlJ/I0uY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=F9SoCX/MkqrmWttBzSZ59IcyBt7JztePYw9LEOPMmJnqttQLQR6ySrvyiHWLxmgDr16LJZlYf7Rqeh/wU751KaobAxhlot9A8hNTiAXcBQPBKGOvYSx3UOphlYxn82O99Q649jeA3FL62tcWZdNKgRGhFO8W64qyopjA7N+no7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=eOe4Qc5Z; arc=none smtp.client-ip=209.85.214.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f230.google.com with SMTP id d9443c01a7336-2240b4de12bso99427175ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Apr 2025 13:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743540557; x=1744145357; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mstT9j25mjz8aUy9IpCZAB9h1zoQsbNBC0c7IzzYKmM=;
        b=eOe4Qc5ZL6PxBdceX4WZA0jY4bi3HOOTm0/symgIiB4WNyTjHs3G47jdkpEJZ4bZ/E
         Mq1sg2WjUcPDnuGgHYCiviD2KBTt6RG+8SEqUlKlyq7Sn22CbkFRJkb26Nn5aeIYCCtw
         txeJg+gN+1U70zPMXe2vLzJGsjybG0V3lJB6uKE5/nwpv2FZrZl7u6tNswAt2Sa38ter
         +4wkb89FRx/+L4vqAC+Xcm/a44TyjUjRfsDwFhs4yiLNvcvXU9NTE0qJ4dkqXUkLcYzG
         Vn+1OdI+dZ5NLL6LkwzX+N/VjVy94zX1GknIiLYko4Nkm4Bh3N+xiXOhG2zUAZK2tRUM
         eRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743540557; x=1744145357;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mstT9j25mjz8aUy9IpCZAB9h1zoQsbNBC0c7IzzYKmM=;
        b=qb3MGj80+TpcyoGCym1mE7rY/tGHlAKdlOgFJfJhQWgZ75ke73TMra6WJmRyOmQTAe
         XfO3LtFdzhRl2y9kwrUpHQzjM5+oF19EeI/neVwgvjtlnuNaeQS6EqndQa+9oXG6uXvK
         WGljHcmi3j3szkEMFOvoP/O2jvtZ19KUlFUZ7KnFYEpSKLiTRiMGrbqKGZDSlcEuYTch
         WL2djvDsrUUIUswSNhd7/0Rx2z9XR4TITM9g0ZyIxP31JTZLll0CGD52+flmJYOxnYzA
         haAVPx/yG9b+bOtLc1E3ItH1ZMrtF+zRXfvh/hlXZgcMh+jItFN+bJRZ348rWHpai6Hi
         k8VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX2EhO7CeethF4vbglzdgSf/MzYm0V/Vj3D1uBvjq4VTVTuas4xm72300hJI9mtg1QXknNpuHh6BlhjAB2qYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhXldv5Tx61XRr+nlzAarMxBvWc57eGmP55Jwa9VdNz4PQ5pYW
	kvgbNLZWTOx+4Qe8vvd6aOUx/MXPNlhmd5oQQCfxHN5nKk2pWL39zNUPOBVCdW7thSbw/tVMMXN
	YfL4n4nduvmrzOUr5juWv7w4m6088bG1p6j0lR2HSyWz/4VOY
X-Gm-Gg: ASbGnctXlCKCB+f6lNS/GKtQQZQxc95NSbQm09SAksaehaMWRQU3NEtWUBN+BKgTVyK
	M9TdzmzOKdcIb01OXvBCLVnWAGoNSmIXcczVA3a0q9duuM1SH6Tj+5jl6qfxSUzKrxAN4I4dexV
	4aIQMx+7ojbaCHeFT/awOMQBo65o9Op7IllIlSr6X92c1QBrWNpRV7u1DfnDMypjyEZUUWGIAgE
	oIymFUXUw5fpK52k87Ao/WhtxKlG8ZgBDVUeaXceJcyb0nBMeqVXvRhfszJPkD0yXj2HfC+JOzR
	tx3sNFgHDQatbVO8SREEFgAyltRsHbENzWQ=
X-Google-Smtp-Source: AGHT+IGs2poYi76n3mLJWXhUA0XPnz0aQSm3PIe6uqP21P4f4eb9jq7kzrwsD2tGzgMq7M/2nrRv9Bzd3IVu
X-Received: by 2002:a05:6a00:3a1d:b0:736:3d7c:236c with SMTP id d2e1a72fcca58-739803990admr19199141b3a.14.1743540556836;
        Tue, 01 Apr 2025 13:49:16 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-739710cb596sm757975b3a.20.2025.04.01.13.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 13:49:16 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 104C43400D7;
	Tue,  1 Apr 2025 14:49:16 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 038EAE4034D; Tue,  1 Apr 2025 14:49:15 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Subject: [PATCH 0/2] ublk: fixes for selftests
Date: Tue, 01 Apr 2025 14:49:07 -0600
Message-Id: <20250401-ublk_selftests-v1-0-98129c9bc8bb@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAENR7GcC/x3MQQqAIBBA0avErBPMmBZdJSIyxxoSC6ciiO6et
 HyL/x8QSkwCbfFAoouFt5hRlQVMyxhnUuyywWiDujaoThvWQSj4g+QQ1Ywa0Xk7IVrI0Z7I8/0
 Pu/59P8Y+ip1gAAAA
X-Change-ID: 20250325-ublk_selftests-6a055dfbc55b
To: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Fix a couple of issues I saw when developing selftests for ublk. These
patches are split out from the following series:

https://lore.kernel.org/linux-block/20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com/T/#t

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
Uday Shankar (2):
      selftests: ublk: kublk: use ioctl-encoded opcodes
      selftests: ublk: kublk: fix an error log line

 tools/testing/selftests/ublk/kublk.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
---
base-commit: 4cfcc398357b0fb3d4c97d47d4a9e3c0653b7903
change-id: 20250325-ublk_selftests-6a055dfbc55b

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>


