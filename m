Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A775010E9AC
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2019 12:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfLBLmy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Dec 2019 06:42:54 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:41294 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbfLBLmy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Dec 2019 06:42:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575286974; x=1606822974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=YbPUPuzF4OcGCGbbvQM8HIlqgtczstxhV1wKbI3uy50=;
  b=t9/wIgv5ixkIQ1Uc1TFXTDkEC2kRE2748Xqv5YBbtN80EetpZmCTxJjQ
   Qmcr6icoUoIDxuUNaTXzS8XlIu7Y+UhnWCGu2Jmfu+eWINhBvtm3dGfKo
   m0XOskMYBuLFss7WygkyDoaedioLxZwRDSTw4vh4KisbA+hxF/rDK7kV9
   o=;
IronPort-SDR: AA0fXIKQ/10bIqFM5QBP620q61GOx0tbBX6qQmN17T9tElCs2czzrZ/UWkA+OQ5o8eeX53JJIB
 Mu/c4wnp0Drw==
X-IronPort-AV: E=Sophos;i="5.69,268,1571702400"; 
   d="scan'208";a="12391585"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-119b4f96.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 02 Dec 2019 11:42:47 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-119b4f96.us-west-2.amazon.com (Postfix) with ESMTPS id 090021A122F;
        Mon,  2 Dec 2019 11:42:45 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 2 Dec 2019 11:42:45 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.217) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 2 Dec 2019 11:42:41 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <shuah@kernel.org>, <keescook@chromium.org>
CC:     <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sj38.park@gmail.com>, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH 2/2] kselftest: Support old perl versions
Date:   Mon, 2 Dec 2019 12:42:21 +0100
Message-ID: <20191202114221.827-2-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191202114221.827-1-sjpark@amazon.com>
References: <20191202114221.827-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.217]
X-ClientProxiedBy: EX13D16UWC003.ant.amazon.com (10.43.162.15) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

On an old perl such as v5.10.1, `kselftest/prefix.pl` gives below error
message:

    Can't locate object method "autoflush" via package "IO::Handle" at kselftest/prefix.pl line 10.

This commit fixes the error by explicitly specifying the use of the
`IO::Handle` package.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 tools/testing/selftests/kselftest/prefix.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kselftest/prefix.pl b/tools/testing/selftests/kselftest/prefix.pl
index ec7e48118183..31f7c2a0a8bd 100755
--- a/tools/testing/selftests/kselftest/prefix.pl
+++ b/tools/testing/selftests/kselftest/prefix.pl
@@ -3,6 +3,7 @@
 # Prefix all lines with "# ", unbuffered. Command being piped in may need
 # to have unbuffering forced with "stdbuf -i0 -o0 -e0 $cmd".
 use strict;
+use IO::Handle;
 
 binmode STDIN;
 binmode STDOUT;
-- 
2.17.1

