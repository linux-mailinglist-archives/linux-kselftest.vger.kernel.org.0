Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51FC6146EDD
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2020 18:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbgAWRAC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jan 2020 12:00:02 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45600 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729745AbgAWQ7p (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jan 2020 11:59:45 -0500
Received: by mail-wr1-f65.google.com with SMTP id j42so3864735wrj.12
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2020 08:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g7SvZ9phUNQgBFhv9EVqVUJXNc7V2T/+gA9/uB1lrNY=;
        b=gtrzkuQ3f7nCSsbvZV+79p3YHEpiG55tz/BtLLT1TKC04h4wnV8nBZfVTy/oeleTWI
         FLytsgneqoqPVgRerwb4UmFKfANQw/OyLCbDS9cyI8/FdPksxF1YRxNFYVfCmifcHrmO
         gfDjmiP/5qHzq51cApwjJfE8JvSN2pHsTbzhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g7SvZ9phUNQgBFhv9EVqVUJXNc7V2T/+gA9/uB1lrNY=;
        b=c+7URWq6P/T9r+zg7Pp0m/lXcXMsIoyRjsnLXIAfMjoQpPt1ETIrPeEGcBiGvhx6uv
         IhhD3Q2106RFj5GehulKeRu8dgpnoxPtiHmn3kjoMHqOI6UZPOVDjYejmgfdZDd3aRO7
         pQ2xToWEwwVwNuqKx4vDzranPWzGFJkk0jha+1Iq6Pi3JQl8f3lCmE1E46MUmyXBOQKO
         ak3/j0KfVaTQg2zZJ4lack9gl7laf67EMiC31piCZZ4R9En1OH8WI75c8UznQv7HAk6u
         kULn2hFu+2dLQsbkD/mR9scnP11/Y5j+qcnqLWPk9nntq/YW1vknfN00/19xz0lCjXIS
         jCWA==
X-Gm-Message-State: APjAAAUrjKr5U8Ol4x2/ICvGAG4bux8WWOtKP1T8te6X4JwdlimyfVR1
        WznvQOcZldw9wvSCmwb1IPf9kQ==
X-Google-Smtp-Source: APXvYqxZBMzloyeuvuGWMOXyEMsTRg357vgRAFLanDZW9K3hvo17Oc9CnYfhEOKDJRcCoIGSj/eFaA==
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr18246948wrj.325.1579798783545;
        Thu, 23 Jan 2020 08:59:43 -0800 (PST)
Received: from localhost.localdomain ([2a06:98c0:1000:8250:d0a9:6cca:1210:a574])
        by smtp.gmail.com with ESMTPSA id u1sm3217698wmc.5.2020.01.23.08.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 08:59:42 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     Lorenz Bauer <lmb@cloudflare.com>, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf 2/4] selftests: bpf: ignore RST packets for reuseport tests
Date:   Thu, 23 Jan 2020 16:59:31 +0000
Message-Id: <20200123165934.9584-3-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123165934.9584-1-lmb@cloudflare.com>
References: <20200123165934.9584-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The reuseport tests currently suffer from a race condition: RST
packets count towards DROP_ERR_SKB_DATA, since they don't contain
a valid struct cmd. Tests will spuriously fail depending on whether
check_results is called before or after the RST is processed.

Exit the BPF program early if FIN is set.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 .../selftests/bpf/progs/test_select_reuseport_kern.c        | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c b/tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c
index d69a1f2bbbfd..26e77dcc7e91 100644
--- a/tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c
@@ -113,6 +113,12 @@ int _select_by_skb_data(struct sk_reuseport_md *reuse_md)
 		data_check.skb_ports[0] = th->source;
 		data_check.skb_ports[1] = th->dest;
 
+		if (th->fin)
+			/* The connection is being torn down at the end of a
+			 * test. It can't contain a cmd, so return early.
+			 */
+			return SK_PASS;
+
 		if ((th->doff << 2) + sizeof(*cmd) > data_check.len)
 			GOTO_DONE(DROP_ERR_SKB_DATA);
 		if (bpf_skb_load_bytes(reuse_md, th->doff << 2, &cmd_copy,
-- 
2.20.1

