Return-Path: <linux-kselftest+bounces-34884-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F029EAD899E
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 12:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B33F317E1ED
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 10:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950002D1F5F;
	Fri, 13 Jun 2025 10:40:10 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD822BFC8F;
	Fri, 13 Jun 2025 10:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749811210; cv=none; b=CJznXx+YdY9W2+TZuTxF5umv7ERKFmOTzKXtkywfbFFCakTiLVagwWWJSs9Bq4dvbsclKI8Lfl1HyGFUZYGXzvNOYjxLJ/16ME23Sf6A84tiko7w210M0dhpt8Fv0s6JnU5qFp7Nmta/IqMGuE1G9NPD1yLlytU25/JcFfuZOYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749811210; c=relaxed/simple;
	bh=rSKp47T0t81MXwUdIr7MHyROt2SZQhzDTq0uNM0tYCM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=h0+QCYDBX5WZ9EiHFRUk9LBqlQmXzlngBEbfXTzMIFEcELPLpcCPxxfgq56iNYmh9GdCGMp7jDCQJK9phyh3sWsmJCqrWXwuxdnSOzHxy8LdhHI139bQbQ7ack+M+RuU2B/gwQcRQQw9QooYMIGVPBgNewYnRvZsK+GoA1wp+uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ad572ba1347so305563066b.1;
        Fri, 13 Jun 2025 03:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749811207; x=1750416007;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DpqNzGB/fR3CEzQDcBE8HrcB0lblj+/5iDqn/Pkub0A=;
        b=ZnmGDJGN9vlXR9NKBFeOJs14yY3gw+ULWpYc1h5oqe+wo4D8Ok38plgVNVfAOq813d
         JttYyXXbHh8VVxQWR37Nrk/fo7hxo/MJrLGyNwCDt+I1Dmwj2TCWW3pZ3m4e2vmoznI1
         gv9GCS/B0bs2vbVAi245ZfhJaoibKI3pLxd445JENdsdu5PfMUWh0BMSTd1/Gex/Y6tz
         0hi8E7r1DkK79JIcvatmugMBvx9g2XDAEc984MHgWZdDJm9VccIEeoBmvHf8Wtf0zNPS
         w2xXA7SZ54BhjEzUhKSAwJKn/gfdR7LvjZw404UqtTY4NH1aubyvr/n6cAQiQb8FhNpy
         F0Iw==
X-Forwarded-Encrypted: i=1; AJvYcCU3qSL3QNLJJS2uilAW207qYwHIT7fTINJWVrtJJq87k6/ybSlP6XfSljb9DyuW1vZZuOriPQE6mJ+W9V2JtwA5@vger.kernel.org, AJvYcCXI4IdbixTXHdlxbRBK7nM4eTU3v4tgJsYE6bgpCh3n8nPCmTA10FTAr6FxcM82Vc0Phqip0bhshj8A6pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUr0zn1L0/1HN089BXYY2zI6j6gC/RNH1bDP72B/jqiTUyO1Ck
	RHsYVMOltnKGg4Pl3l9P0xW1/7UdHxKk7o7p1eYTNTDPjo8nEtRcJTwe
X-Gm-Gg: ASbGnct0xQ9ZbVNeQoKq49SXia0Hvs2xjzvzPvUIEtA67D41VOuJeuJGhJVt+xYJnCo
	aEIaC7VQbW7PPx7CS3gzXAuFAYr/2nL5G91UqRM3dvjfzvOFAJVtNB/gz+y7+9T4xrmpLxdUWT9
	+WRk99qCCgAz8pn91elXgZytt0xj+VjarXcn5SI5m+9f61ZV21Ey/kDSOENqw2Dv5oBjCU8iIOF
	w3loarNzL3JXASnDVmRjy2oOGpzRM9cLsD7mQrzheV7aSM7rJDZqUhW/Cc52Itx6zNOTvk4uXN6
	1q1BbQa+vhDuroDAM1XqXzcU+wmBv7NxtkffbCHFSMjl4hLmXSYv
X-Google-Smtp-Source: AGHT+IFgXs2I0yGRlB8yQyaQfKe9oZBQb5w3NUJp4E8+Ex9rdkGREKM3YhDd4R57wFFfdC+g6mDOFQ==
X-Received: by 2002:a17:906:6a15:b0:adb:449c:7621 with SMTP id a640c23a62f3a-adec5c3e795mr279761366b.29.1749811206604;
        Fri, 13 Jun 2025 03:40:06 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec892e756sm107606366b.144.2025.06.13.03.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:40:06 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v2 0/4] netdevsim: implement RX statistics using
 NETDEV_PCPU_STAT_DSTATS
Date: Fri, 13 Jun 2025 03:39:57 -0700
Message-Id: <20250613-netdevsim_stat-v2-0-98fa38836c48@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP7/S2gC/13NQQrDIBBA0avIrGNxLFrMqvcooSRxksyipqhIS
 vDuBemq6w/vn5AoMiXoxQmRCifeA/RCdwLmbQwrSfbQC9BKG2VRyUDZU0n8eqY8ZumMc8ZpJHU
 l6AS8Iy18NPABgbIMdGQYOgEbp7zHTzsVbP2H4j9aUCo5I07W3Lyz03L3NPEYLntcYai1fgEv6
 OR3twAAAA==
X-Change-ID: 20250610-netdevsim_stat-95995921e03e
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, joe@dama.to
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1506; i=leitao@debian.org;
 h=from:subject:message-id; bh=rSKp47T0t81MXwUdIr7MHyROt2SZQhzDTq0uNM0tYCM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoTAAE+4yDfkOPtcJyOfRRylFv7/7mbVVbxDmXq
 CzyD1TXcDuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaEwABAAKCRA1o5Of/Hh3
 bZhCD/9dCg7a2PvYhxyNME/DaRSj9p1DWq3pyBDvJKWX2aTvbQ/oHtoGOcEjnuMc4mGMxCR/y/3
 z57HJtYM90pfzRtr/nAVnc98/Mng0sM8M2VNh7b0o7GsV7FtqoiqDktd1Z8315WyuARapeg5Fti
 F0FS0Fv3PB17JPezBbjT61lKiF2cVuKWd3CKYDbD1UgfaPPwvOAS9i14LNXhvOy5Qgoj5AAlFRo
 /3hkJE0OcVQGp5m5rlx+SEgFszsJehniUFSKFbpEXbopGm6Ym8E5OCqHPS7Bk1vljAT42j5qYM8
 YkBA7S1LDbBveytpzV0uyHbyD7YCMRVNLEMktQwLZnpg7uyULXx2kA6P1Bnhz59MS9+JlohgTA7
 prL10BQ7uzYljWjKUI5Y/K3iGdxa3Ru+QFmlHxCyLCzRh1DzW8dvlZP5CC371mCVAvJDxUVv32V
 r4m2AOZPvzMK+grY6VBtRxyZkZrxbd3MYs5onrroISrBknNpAuK42YTN+JScsaSrSUB9Gh7/8+M
 v8U6wIIQclV2IAhMTmNxVn5KRDbmkmpGpk/7fMtI8gcJq1SOE2a1rEqlAJFVk7TP8nTlmaFoRcE
 uoCaI2BplZWq16RgOQr+sODn2+hpEI0WYhsKtuEdwHC0rq4F2D1BIZqbvaTKWy2iCZb4T64g35u
 MxByTtNGgUnMEPw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The netdevsim driver previously lacked RX statistics support, which
prevented its use with the GenerateTraffic() test framework, as this
framework verifies traffic flow by checking RX byte counts.

This patch migrates netdevsim from its custom statistics collection to
the NETDEV_PCPU_STAT_DSTATS framework, as suggested by Jakub. This
change not only standardizes the statistics handling but also adds the
necessary RX statistics support required by the test framework.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Changed the RX collection place from nsim_napi_rx() to nsim_rcv (Joe
  Damato)
- Collect RX dropped packets statistic in nsim_queue_free() (Jakub)
- Added a helper in dstat to add values to RX dropped packets
- Link to v1: https://lore.kernel.org/r/20250611-netdevsim_stat-v1-0-c11b657d96bf@debian.org

---
Breno Leitao (4):
      netdevsim: migrate to dstats stats collection
      netdevsim: collect statistics at RX side
      net: add dev_dstats_rx_dropped_add() helper
      netdevsim: account dropped packet length in stats on queue free

 drivers/net/netdevsim/netdev.c    | 48 ++++++++++++++++-----------------------
 drivers/net/netdevsim/netdevsim.h |  5 ----
 include/linux/netdevice.h         | 10 ++++++++
 3 files changed, 29 insertions(+), 34 deletions(-)
---
base-commit: 6d4e01d29d87356924f1521ca6df7a364e948f13
change-id: 20250610-netdevsim_stat-95995921e03e

Best regards,
-- 
Breno Leitao <leitao@debian.org>


