Return-Path: <linux-kselftest+bounces-10451-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E62F58CA543
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 01:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E04CD1C20DBB
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 23:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A931386BD;
	Mon, 20 May 2024 23:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="gkMkTpuo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67538A2D
	for <linux-kselftest@vger.kernel.org>; Mon, 20 May 2024 23:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716249549; cv=none; b=jjS0UUZzXHoZMVKFu325U09+ziYwPyewLJC0cW+z1a0qEz9GO5JjixW+Q4Xiqr0vrmQisHXXwNNsD45saK5r8Y+uoCnLSUy5laNrLcX+TchzJkqs9Ma4ButRu5qa6139Ut6dg2Qr2/CpHESDO2T758W4h3BAJSXzkgsF35FCVfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716249549; c=relaxed/simple;
	bh=xiGzFz5+hu1xpjpEUf4HSER5PouTUhVlGDQbTva3RGc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ufj4TXCxOg9TmFahTtcH8ooN2T1sMb7U5vHdZynOVuXTxBs/o12zZwgUy8SUOFNHxsDdWPY5lmVZkfjYO6jbw67x+vYOuNFyDAbYnGHGD8hAMLPAFSzfq3IwHt7HM4trnpiGV0rixGJw1KFh9utDhA2r+ye0NeqSgZIp8EcEyTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=gkMkTpuo; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1edf506b216so88179415ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 20 May 2024 16:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1716249548; x=1716854348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4MSMZDcDirakrNTBU0fNIxBAtvPtCqIO/PWdx7abHpI=;
        b=gkMkTpuodemqcggQX+QS8j0l5j69KRlVLl/ZYmtwb+jylUbVhpJAYPDwzBAiMbv0kK
         M1mBQHqmg5/XNBvKwFVPPwvw2omyLT0NWme67XFACTm1V7P9WWOJJ4bim4M4I4APfk7m
         25q97hqUuUqKSWtajbFFdBUFkM56qr7ObCE6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716249548; x=1716854348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4MSMZDcDirakrNTBU0fNIxBAtvPtCqIO/PWdx7abHpI=;
        b=mooXqqvfw8NZHwLZfGzHFCJv+o6lq4RRL5FY7ahWbLejoRnhoUdCod42+sEg8AkSH8
         0VokVhCgIrK9DLv4/mgquzR5ztUAg2pOCgy6DHnuSjGGR/vrITDKNBzK8fVzBlwt1Grj
         TEWFJnkeRWoFDoj2eEm1IGExXhJLA4cB9HbtEpKxb/iTu2V+YvMB1HOCVab3G6rkveNJ
         I2HuLK8xfeycN8qtxO+xv2qFKiittYeYkudDLEGv8TtNpVdJ5KBQD7yh+ak3NgviKmxV
         /sor+lKzxI5at6xciT0ZOPYgxHuAGrXg/fWmK5P7pVnYcN4JxjGEqZU7N8LcNXfneqyQ
         +X6w==
X-Forwarded-Encrypted: i=1; AJvYcCXulbWZdT7f2FBZx1fiyG6qGtis2XM9CBCqOdfn5PwDRgLW6E0DL/ba45SX5XLMQBNhFKfUF9KkvtqjXIQOnVsnuBT7eZd2tKurqHTJEWIr
X-Gm-Message-State: AOJu0YwTxVog/BuVPTX9++e1wO885CShIhNvibUhD+Dv/fTj6FguNhLc
	hWJqagDmtqCfxdn7jCsd2faQfvd+ffF72hOlnsaCOqVvltt6LglFdMvqbQYC/7E=
X-Google-Smtp-Source: AGHT+IEU8qMZMI8smQVTlaGJaOblB8+OFUaGoNtT7FdaCarnHSQtmXoufAf+oYRHDz0WoQmCt8OpTA==
X-Received: by 2002:a05:6a20:96d2:b0:1af:d07a:37c8 with SMTP id adf61e73a8af0-1afde128be9mr28414750637.37.1716249547566;
        Mon, 20 May 2024 16:59:07 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f66e4a24f4sm11111009b3a.0.2024.05.20.16.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 16:59:07 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: nalramli@fastly.com,
	Joe Damato <jdamato@fastly.com>,
	Shuah Khan <shuah@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH net] testing: net-drv: use stats64 for testing
Date: Mon, 20 May 2024 23:58:43 +0000
Message-Id: <20240520235850.190041-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Testing a network device that has large numbers of bytes/packets may
overflow. Using stats64 when comparing fixes this problem.

I tripped on this while iterating on a qstats patch for mlx5. See below
for confirmation without my added code that this is a bug.

Before this patch (with added debugging output):

$ NETIF=eth0 tools/testing/selftests/drivers/net/stats.py
KTAP version 1
1..4
ok 1 stats.check_pause
ok 2 stats.check_fec
rstat: 481708634 qstat: 666201639514 key: tx-bytes
not ok 3 stats.pkt_byte_sum
ok 4 stats.qstat_by_ifindex

Note the huge delta above ^^^ in the rtnl vs qstats.

After this patch:

$ NETIF=eth0 tools/testing/selftests/drivers/net/stats.py
KTAP version 1
1..4
ok 1 stats.check_pause
ok 2 stats.check_fec
ok 3 stats.pkt_byte_sum
ok 4 stats.qstat_by_ifindex

It looks like rtnl_fill_stats in net/core/rtnetlink.c will attempt to
copy the 64bit stats into a 32bit structure which is probably why this
behavior is occurring.

To show this is happening, you can get the underlying stats that the
stats.py test uses like this:

$ ./cli.py --spec ../../../Documentation/netlink/specs/rt_link.yaml \
           --do getlink --json '{"ifi-index": 7}'

And examine the output (heavily snipped to show relevant fields):

 'stats': {
           'multicast': 3739197,
           'rx-bytes': 1201525399,
           'rx-packets': 56807158,
           'tx-bytes': 492404458,
           'tx-packets': 1200285371,

 'stats64': {
             'multicast': 3739197,
             'rx-bytes': 35561263767,
             'rx-packets': 56807158,
             'tx-bytes': 666212335338,
             'tx-packets': 1200285371,

The stats.py test prior to this patch was using the 'stats' structure
above, which matches the failure output on my system.

Comparing side by side, rx-bytes and tx-bytes, and getting ethtool -S
output:

rx-bytes stats:    1201525399
rx-bytes stats64: 35561263767
rx-bytes ethtool: 36203402638

tx-bytes stats:      492404458
tx-bytes stats64: 666212335338
tx-bytes ethtool: 666215360113

Note that the above was taken from a system with an mlx5 NIC, which only
exposes ndo_get_stats64.

Based on the ethtool output and qstat output, it appears that stats.py
should be updated to use the 'stats64' structure for accurate
comparisons when packet/byte counters get very large.

To confirm that this was not related to the qstats code I was iterating
on, I booted a kernel without my driver changes and re-ran the test
which shows the qstats are skipped (as they don't exist for mlx5):

NETIF=eth0 tools/testing/selftests/drivers/net/stats.py
KTAP version 1
1..4
ok 1 stats.check_pause
ok 2 stats.check_fec
ok 3 stats.pkt_byte_sum # SKIP qstats not supported by the device
ok 4 stats.qstat_by_ifindex # SKIP No ifindex supports qstats

But, fetching the stats using the CLI

$ ./cli.py --spec ../../../Documentation/netlink/specs/rt_link.yaml \
           --do getlink --json '{"ifi-index": 7}'

Shows the same issue (heavily snipped for relevant fields only):

 'stats': {
           'multicast': 105489,
           'rx-bytes': 530879526,
           'rx-packets': 751415,
           'tx-bytes': 2510191396,
           'tx-packets': 27700323,
 'stats64': {
             'multicast': 105489,
             'rx-bytes': 530879526,
             'rx-packets': 751415,
             'tx-bytes': 15395093284,
             'tx-packets': 27700323,

Comparing side by side with ethtool -S on the unmodified mlx5 driver:

tx-bytes stats:    2510191396
tx-bytes stats64: 15395093284
tx-bytes ethtool: 17718435810

Fixes: f0e6c86e4bab ("testing: net-drv: add a driver test for stats reporting")
Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 tools/testing/selftests/drivers/net/stats.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/stats.py b/tools/testing/selftests/drivers/net/stats.py
index 7a7b16b180e2..820b8e0a22c6 100755
--- a/tools/testing/selftests/drivers/net/stats.py
+++ b/tools/testing/selftests/drivers/net/stats.py
@@ -69,7 +69,7 @@ def pkt_byte_sum(cfg) -> None:
         return 0
 
     for _ in range(10):
-        rtstat = rtnl.getlink({"ifi-index": cfg.ifindex})['stats']
+        rtstat = rtnl.getlink({"ifi-index": cfg.ifindex})['stats64']
         if stat_cmp(rtstat, qstat) < 0:
             raise Exception("RTNL stats are lower, fetched later")
         qstat = get_qstat(cfg)
-- 
2.25.1


