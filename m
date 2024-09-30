Return-Path: <linux-kselftest+bounces-18595-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 102E0989E0E
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 11:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC50D1F22ACB
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 09:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15D018801A;
	Mon, 30 Sep 2024 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1058uve"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A05118787B;
	Mon, 30 Sep 2024 09:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688264; cv=none; b=k9B1YboZm7d1Xmo6Ym+G8Ejhz0C546nRW6FZ9q0hGAyhMdg4ss4CsgW8V2LV3DyRHFSO2LUmJqjLpVPsFt64Oi6LdPLAqoeseRdEtY1NXpaAUeEW08jFHGfcEHxSoBMUoaO23D/w01f23nYHKHOjHcQo9TkFU2k45VqI79LUFCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688264; c=relaxed/simple;
	bh=UuUD1mmGLRcWG4lgXC/eGoPcwYns7RYCu2raVCrWYMY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V7C0QfKuCvhcI+ciqmzCLiFJuXVbg8IHOzdLp7wm6u095pRWAjuG/T5KrpHoZQq16JOD1nuP0AUOW4Dw0RQQH/eIADLTLlZOlvQQUH1yUl3rBdye14luOtS7/wiGb4yHg5GxVI1F8ZWDvXyHWDAQWJZVH93phxwDxZgOo2lDeRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1058uve; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20b6c311f62so10023415ad.0;
        Mon, 30 Sep 2024 02:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727688263; x=1728293063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KSQThFManZM973v4g42OSK+9VEvaDsTlImRBu/q6hPw=;
        b=i1058uveHPhjEMElMInuPcJezJ8iC2r/uPK1rqRtjpLGOUH8vsRJT6DMlMcfkQyOaN
         x1CReE9m7k5SVHfErt86hvGKg0iz2z/YEYkAYluHRzdcCWkCGmw3qhVxsPkVgesiHVv7
         a5WsQjT8C8/aTef6JxuSK1bAut7WH8yJiswiakly2HDupRvCrLZOHvORYZWb7dCLSe3o
         DS6PS44UIsYwD781e8nG0WcWzkCxF8+Z8ZvcaykCPmxiB9AooCL/iob6S2ofHUE3iSdc
         BW6yCr8SQhTAJCD8yyl1ygb41y7kCVDkx+AoCjWnpXl/THLWTufcwdbrZPUBON4Xh1qS
         mWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727688263; x=1728293063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KSQThFManZM973v4g42OSK+9VEvaDsTlImRBu/q6hPw=;
        b=Qfem+K/jHd54BDK+tMIjkHedndoFDXfx7HSGGj6O+ROgOgeaTM3P+uO7roXfj6Mf0u
         jfegRpQcLue0s0P/83nGRfl4ANQ9e0un09YPbOFgHJSyKbR1iy0WoLDupcsKHPdIJVb0
         0dZhe8uLp1+rQEkmiiLdOhKfrioNCyPm7hyh7oYZ0cyCHCvFzUKNngr/UEy8UV3aR/l/
         j0L8dei/Ii2dXVcDX9H3+6W1JRooDAKIxgLlEjuZfeio2uGY1EwDYSMGiFkEzeZ/tbpW
         takIgny4FQ00wrEoZLzCS6+qAM6EjyZTCOkxTmE9mZrtmJAYSKr4mw3mV8bI4t1AoQCV
         DXuA==
X-Forwarded-Encrypted: i=1; AJvYcCXmlzWxOERan1C7fXrX5kPA9sfGqm/NSFgyzzDhvFFPtNCfvKCNd841u96b3H/BtCCpC22ohWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMvQpuizjRkbQvxQVF62VuKlX/BXnq+tdWwYRR5yrG54RYYTDv
	iNTtt7idbm8Tzkh1MfA4xeGVCNfwpgxgdzf73qwaAm10Lcx/y51j
X-Google-Smtp-Source: AGHT+IHADDG4nJOqZSC44gIYC6eEcmLmen6QiWRji9AGN5Gv0tVuYRAPKBIteq72Dij6NKeO/CkREg==
X-Received: by 2002:a17:902:ea12:b0:205:4415:c62d with SMTP id d9443c01a7336-20b3729ca82mr192829725ad.26.1727688262710;
        Mon, 30 Sep 2024 02:24:22 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d5eda4sm51015485ad.48.2024.09.30.02.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 02:24:22 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	shuah@kernel.org,
	willemb@google.com
Cc: linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 0/3] net-timestamp: add some trivial
Date: Mon, 30 Sep 2024 17:24:13 +0800
Message-Id: <20240930092416.80830-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

When reading through the whole feature, I feel we can do these things to
make it more robust. They are trivial changes, not big ones.

Jason Xing (3):
  net-timestamp: add strict check when setting tx flags
  net-timestamp: add OPT_ID_TCP test in selftests
  net-timestamp: namespacify the sysctl_tstamp_allow_data

 include/net/netns/core.h                  |  1 +
 include/net/sock.h                        |  2 --
 net/core/net_namespace.c                  |  1 +
 net/core/skbuff.c                         |  2 +-
 net/core/sock.c                           |  4 ++++
 net/core/sysctl_net_core.c                | 18 +++++++++---------
 tools/testing/selftests/net/txtimestamp.c |  6 ++++++
 7 files changed, 22 insertions(+), 12 deletions(-)

-- 
2.37.3


