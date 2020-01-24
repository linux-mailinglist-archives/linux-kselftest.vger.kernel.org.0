Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7CA1483E7
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2020 12:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731637AbgAXLiP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jan 2020 06:38:15 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36478 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389526AbgAXL34 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jan 2020 06:29:56 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so1565643wru.3
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jan 2020 03:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=23V7V0bQTVhkXPFpZHbr/dpA6QXlskc4s7MHHF/kg3o=;
        b=wyPpvX1on05Qgb1oTJUYHbUJNqNJVywXnK+eYc/CEFlZ+FYyxqBTorCIgNRAatuedc
         1WogFxqm4Rx0i8D0wQaMEkYW3ZxpGbv9QkI8SDAT6ozhh49OB2EEr2X39omSbAaz9zvK
         y9U+UJQby0rEgCppiEyU3ntbK9vAInHyG7GO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=23V7V0bQTVhkXPFpZHbr/dpA6QXlskc4s7MHHF/kg3o=;
        b=amws2UlKOJkcytTc4n/fSRb0nev+5ZlKHz+GEFH+pVWa4FknV+qhnPp2HkFe5R8lt2
         gMqCcBSbWAfZhryiHcV/5SYg/YeBbpWlHLgBcn/2LzUy+hC4viy3ehNBtjVIShNiBww1
         5g3Da9269A+HbY2DoJfkCWF/SpwhrGri7FeM7LOSI0IjMTKuzuaZqqrh4EaFWO2rqE43
         +c0cxmISY4Mv8N2A0sQDCwa82/W256rciHbfPFLDMCumGhg/c2uAhyN6JlKQ9tPIUewf
         X3F9kYUL827yMuDpc0SGMUvAhuKl0lANF4FX5flUV3qIadWkMfhOS0IKANqpeLze5NEC
         0uUA==
X-Gm-Message-State: APjAAAW0/WfSM0jIX+13WwcNCqS8k0r+pMHLo4xnVCS6fUsRcGLbWcKA
        hs5aAl8M2iyt/BKEaNTNbsTkdg==
X-Google-Smtp-Source: APXvYqxR4PnKJm5OXMmu+YwHZ8oajyip6nFIy5+fZ9y6nFyYA1+taQrddJKco673nEo5N8RV5VfLpA==
X-Received: by 2002:adf:9144:: with SMTP id j62mr3863056wrj.168.1579865394173;
        Fri, 24 Jan 2020 03:29:54 -0800 (PST)
Received: from antares.lan (3.a.c.b.c.e.9.a.8.e.c.d.e.4.1.6.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:614e:dce8:a9ec:bca3])
        by smtp.gmail.com with ESMTPSA id n189sm6808688wme.33.2020.01.24.03.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 03:29:53 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     Lorenz Bauer <lmb@cloudflare.com>, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 2/4] selftests: bpf: ignore FIN packets for reuseport tests
Date:   Fri, 24 Jan 2020 11:27:52 +0000
Message-Id: <20200124112754.19664-3-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124112754.19664-1-lmb@cloudflare.com>
References: <20200123165934.9584-1-lmb@cloudflare.com>
 <20200124112754.19664-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The reuseport tests currently suffer from a race condition: FIN
packets count towards DROP_ERR_SKB_DATA, since they don't contain
a valid struct cmd. Tests will spuriously fail depending on whether
check_results is called before or after the FIN is processed.

Exit the BPF program early if FIN is set.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Fixes: 91134d849a0e ("bpf: Test BPF_PROG_TYPE_SK_REUSEPORT")
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

