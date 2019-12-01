Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9F710E3E1
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2019 00:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfLAX0D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 1 Dec 2019 18:26:03 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37086 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfLAXZs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 1 Dec 2019 18:25:48 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so10980433wru.4;
        Sun, 01 Dec 2019 15:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vGbeK0zgYCmWlSmgxBPs/jpmt323fVhKZnVym+DQBus=;
        b=oH1SpGE7VHgGjG8/Dx7tPCF0v5UNTNlLI1evs3DIp9Mrjdo+R9sVjlqhEySpi9o2Gq
         mJ9V92jEHiXEhBgon60ow5Ac0gu7sz1RVN5H+6OqEY6YZewPCMHiD+78yV5TRDMwfhHT
         kcw/8sV9z35UWzZlmN5hwrvx45ssjbo/cXtufMTNOxIN3gggaq95pZRyIgdFyXxG8PQE
         cfeTat8Rud86zjOjWH5kJ5QeplJwmtWT7BmnJcTa8yeHASsO9QaT69n7MmnNRdpWoaro
         fbLT2Up3g2SJ3x1dfWzUwtuBPgjekHd+A1UbusFVtu5Vn2bFTHnF/x56PlCw9KeUP1JX
         GW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vGbeK0zgYCmWlSmgxBPs/jpmt323fVhKZnVym+DQBus=;
        b=BQkclDntuFDkWt7QhHlL+8OQIaSu3BJ5IQw0vUrfMODrFTomTEeiBOdjU12zj14tFB
         Pp1l5EJUJBjwfBDHtFt7KZeu0r+AVbndllOT5e0x3+uhJ/nnjRZRGep1KOBoDNfd3drK
         mLja8goCVc1KloEIdoyCtxBtUKXqqGlj857L4G8ag2WXsFSDNv1h5h0sEYvXAIWNOkUL
         2ksSqmgbd40PXzHAEUU4RLCmYP1nQSoJC018fYgamqapahW55sRmEZGh373+e7pqFtOK
         3EYwR8lGYNihga7mDatzYOX7Ymnqcldj38V5WRlNBYwFFZbR+XSHOVD5W+5mnoCIAOpO
         W4gg==
X-Gm-Message-State: APjAAAV33uB5gyQGU/jf2FqXiQ4V9w8mo3RRi/Cp0CAslkcwzXaufjLH
        vNtnXU8OxR8zS6SS7MDymcQ=
X-Google-Smtp-Source: APXvYqwZ/Iti69NVkcCu6wCaCpEPeSP3LVRE1q3go6xDOzFwri5p6l9Qmz/0S07snc3kpBSHyN1qYQ==
X-Received: by 2002:adf:eb42:: with SMTP id u2mr47495946wrn.173.1575242746142;
        Sun, 01 Dec 2019 15:25:46 -0800 (PST)
Received: from localhost.localdomain (cable-86-56-100-90.cust.telecolumbus.net. [86.56.100.90])
        by smtp.gmail.com with ESMTPSA id y6sm37450454wrl.17.2019.12.01.15.25.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Dec 2019 15:25:45 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     brendanhiggins@google.com, shuah@kernel.org
Cc:     corbet@lwn.net, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH 4/6] kunit: Create default config in 'build_dir'
Date:   Mon,  2 Dec 2019 08:25:22 +0900
Message-Id: <1575242724-4937-5-git-send-email-sj38.park@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575242724-4937-1-git-send-email-sj38.park@gmail.com>
References: <1575242724-4937-1-git-send-email-sj38.park@gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

If both '--build_dir' and '--defconfig' are given, the handling of
'--defconfig' ignores '--build_dir' option.  This commit modifies the
behavior to respect '--build_dir' option.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 tools/testing/kunit/kunit.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index f8f2695..1746330 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -114,6 +114,11 @@ def main(argv, linux=None):
 	cli_args = parser.parse_args(argv)
 
 	if cli_args.subcommand == 'run':
+		if cli_args.build_dir:
+			kunit_kernel.KUNITCONFIG_PATH = os.path.join(
+				cli_args.build_dir,
+				kunit_kernel.KUNITCONFIG_PATH)
+
 		if cli_args.defconfig:
 			create_default_kunitconfig()
 
-- 
2.7.4

