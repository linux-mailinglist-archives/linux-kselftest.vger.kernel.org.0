Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD099C87D6
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2019 14:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbfJBMER (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Oct 2019 08:04:17 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36693 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfJBMER (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Oct 2019 08:04:17 -0400
Received: by mail-lf1-f65.google.com with SMTP id x80so12553408lff.3
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Oct 2019 05:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TMB6TblY53+4VyVSJtgn0L5ohD/FsUtecY9KXTnnDX4=;
        b=DqsD2s9P1SD/PtORTHEVfyScMUoIU61jGf1MvpZNqMizg2xPfFl/kReztOBlI4GO3e
         z1Go2J83GjLF8pQSMiXB4U4w1NUvICHnzC5UOXJa6j9dnv/CmSOdsXIclmhJu5ouVmiw
         cToPMiZ4rCxpRNxFnHuHNzLsiDwWc6LOOlN33hmZjj6W70SdmDvDd62PT+QmGNFua/B7
         ooS7xH/oMHWaQ+xWj4FiiNRXj3PsjC+LqWib6sHftimrqCDAbyBFNlAuAVZcAXcj4Adn
         h8uW+B5LXmgVaa0IuMpmJC5qHZGVXmUXkW+tsLgrdOjtHofRERJ3R5BekTtFZDNYZVUk
         fx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TMB6TblY53+4VyVSJtgn0L5ohD/FsUtecY9KXTnnDX4=;
        b=Npq7ayvfYuDRVPYMsv4mD3k1gze8SCIKemSE8nb9PXcT0YkOKVCQCDf7VOH3YKc2gj
         M+R4j1gCkVazunulMMlRjqsuB9YYQIHuWP9GmMzwwzl/l3ynUdziCaWAvPHBr1EPCBJp
         4ZzhFoL7FpUAsE4JTyaDjN2pTf/3PWND1jYceeeiK/hrDDrx0DyJMuSFSxdluUBBFoYv
         z69DYpy1YXeRrv4YS8NrmBjj7blM/4mt0q3w6OpC72B0Mm3oQ4X1VHv3I+FVoLrbagLD
         aqa7C2obu2pmSYygIy72qbCW1V4NU5TY7i1LFURV0NS/j8Q9oyqZFEqL5cj2dsJjwEZJ
         hmjw==
X-Gm-Message-State: APjAAAWTk51LSteAjvDpsewsa2XlJSQet1UHUs/Z9gcTtcqt0R1IzFHW
        FTj4PJAfP1j2ELGyJf2Uc6eLiQ==
X-Google-Smtp-Source: APXvYqzf1bxl3vPpwa5mq2B5jjzpp5yAncmvsE9rUg1AJrtdAyaV4drWRLAx9gwUoPb8uqukbTOHWA==
X-Received: by 2002:ac2:4a69:: with SMTP id q9mr2037834lfp.86.1570017855074;
        Wed, 02 Oct 2019 05:04:15 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id x2sm4833827ljj.94.2019.10.02.05.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 05:04:14 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH bpf-next 2/2] selftests/bpf: correct path to include msg + path
Date:   Wed,  2 Oct 2019 15:04:04 +0300
Message-Id: <20191002120404.26962-3-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191002120404.26962-1-ivan.khoronzhuk@linaro.org>
References: <20191002120404.26962-1-ivan.khoronzhuk@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The "path" buf is supposed to contain path + printf msg up to 24 bytes.
It will be cut anyway, but compiler generates truncation warns like:

"
samples/bpf/../../tools/testing/selftests/bpf/cgroup_helpers.c: In
function ‘setup_cgroup_environment’:
samples/bpf/../../tools/testing/selftests/bpf/cgroup_helpers.c:52:34:
warning: ‘/cgroup.controllers’ directive output may be truncated
writing 19 bytes into a region of size between 1 and 4097
[-Wformat-truncation=]
snprintf(path, sizeof(path), "%s/cgroup.controllers", cgroup_path);
				  ^~~~~~~~~~~~~~~~~~~
samples/bpf/../../tools/testing/selftests/bpf/cgroup_helpers.c:52:2:
note: ‘snprintf’ output between 20 and 4116 bytes into a destination
of size 4097
snprintf(path, sizeof(path), "%s/cgroup.controllers", cgroup_path);
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
samples/bpf/../../tools/testing/selftests/bpf/cgroup_helpers.c:72:34:
warning: ‘/cgroup.subtree_control’ directive output may be truncated
writing 23 bytes into a region of size between 1 and 4097
[-Wformat-truncation=]
snprintf(path, sizeof(path), "%s/cgroup.subtree_control",
				  ^~~~~~~~~~~~~~~~~~~~~~~
cgroup_path);
samples/bpf/../../tools/testing/selftests/bpf/cgroup_helpers.c:72:2:
note: ‘snprintf’ output between 24 and 4120 bytes into a destination
of size 4097
snprintf(path, sizeof(path), "%s/cgroup.subtree_control",
cgroup_path);
"

In order to avoid warns, lets decrease buf size for cgroup workdir on
24 bytes with assumption to include also "/cgroup.subtree_control" to
the address. The cut will never happen anyway.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 tools/testing/selftests/bpf/cgroup_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index 4d74f3c4619b..0fb910df5387 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -98,7 +98,7 @@ static int enable_all_controllers(char *cgroup_path)
  */
 int setup_cgroup_environment(void)
 {
-	char cgroup_workdir[PATH_MAX + 1];
+	char cgroup_workdir[PATH_MAX - 24];
 
 	format_cgroup_path(cgroup_workdir, "");
 
-- 
2.17.1

