Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49FC44DBA4
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Nov 2021 19:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbhKKSgw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Nov 2021 13:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbhKKSgw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Nov 2021 13:36:52 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AC3C061767
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Nov 2021 10:34:02 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id h62-20020a25a544000000b005c5d9b06e57so10556001ybi.6
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Nov 2021 10:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=DESeEF7SdR9UNYveOTPLprv35taR3AHUVFjTWAt72+s=;
        b=CanF6peffIh1bkeDS+6QZwFe/gVwt6sqLVD4E3sctTuUDeytoW8gei09i6qvDe/w5h
         /BiyidEWMsr/9HOeW1umDg8GI+uO3wG321IU92JS6wnmCckJmyq3GQpoyaDc5HfV9qne
         g/i9X8+npWWUDwP+aQBSJONS289xpO2ZTH8gu445SeA8O+7NgALvg2iC+WI/erolK0nx
         k51CqxjQ5VZlDzU4cDyI2XVWWAo/MDSSiO7nzJwZBOdlzeMq55lVNLtDojAYZ66P1hgm
         GbOrfftWCJMwXtxTX9nYvt7k8QY4y2HkIto7bjZzKE5qZSMz6/JhydWEBk83ehX13dtx
         1nPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DESeEF7SdR9UNYveOTPLprv35taR3AHUVFjTWAt72+s=;
        b=MktoTGkffu69e/bLQEcay0TgY0ZPqFcP+8eMyFW3s90yJGsoMA4frE+gDEcnCwKBrl
         dez/S7x4tayTw5pmV2uv4/1q4suMiBIk60YpMgCnsN2V1ClC88adeMOJADem3lAUuywg
         sKCsnC60ekGW1ez2+FkXgZI2WqHMHNumumoMDpqs11nUx0dD4XBN7A3YgyakifDXf3WM
         dc7yuTSORd7RNklfo/yLSKgyRkmCZmGVMwHcSRvDJZP/VTTa5pDsczacG8RMpyoEWpZR
         qeX3S0W2XXaDfdsqAWiH/IuF62jrypTOXblk/OMpqZk4IAyJaPjiI39qjOEaNS5bNXAI
         x9AA==
X-Gm-Message-State: AOAM531UhpbOPZNUJcva6HFGZP3BFhGFNvGSS1QBOkiSe3IHKoKl4qmO
        stLGXpdg8T4E+Baq3lhMorLtIfwDpr+u5w==
X-Google-Smtp-Source: ABdhPJwXO3yPskee9ladbnf++H8/0IrZ+7Iv8PD1eTUA6DKosc6VIemY97pt4AkUvE1dOFlq2NyTasuPhgM8Vw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:468f:6ab3:7243:11d5])
 (user=dlatypov job=sendgmr) by 2002:a25:bb8c:: with SMTP id
 y12mr10508240ybg.542.1636655642210; Thu, 11 Nov 2021 10:34:02 -0800 (PST)
Date:   Thu, 11 Nov 2021 10:33:56 -0800
Message-Id: <20211111183356.4073001-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH] kunit: tool: revamp message for invalid kunitconfig
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The current error message is precise, but not very clear if you don't
already know what it's talking about, e.g.

> $ make ARCH=um olddefconfig O=.kunit
> ERROR:root:Provided Kconfig is not contained in validated .config. Following fields found in kunitconfig, but not in .config: CONFIG_DRM=y

Try to reword the error message so that it's
* your missing options usually have unsatisified dependencies
* if you're on UML, that might be the cause (it is, in this example)

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---

Note: this is based on https://lore.kernel.org/linux-kselftest/20211106013058.2621799-1-dlatypov@google.com/
There's a fairly trivial merge conflict between these two patches (that
patch changes the line above where this diff starts).

---
 tools/testing/kunit/kunit_kernel.py | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 7d459d6d6ff2..350883672be0 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -266,15 +266,17 @@ class LinuxSourceTree(object):
 	def validate_config(self, build_dir) -> bool:
 		kconfig_path = get_kconfig_path(build_dir)
 		validated_kconfig = kunit_config.parse_file(kconfig_path)
-		if not self._kconfig.is_subset_of(validated_kconfig):
-			invalid = self._kconfig.entries() - validated_kconfig.entries()
-			message = 'Provided Kconfig is not contained in validated .config. Following fields found in kunitconfig, ' \
-					  'but not in .config: %s' % (
-					', '.join([str(e) for e in invalid])
-			)
-			logging.error(message)
-			return False
-		return True
+		if self._kconfig.is_subset_of(validated_kconfig):
+			return True
+		invalid = self._kconfig.entries() - validated_kconfig.entries()
+		message = 'Not all Kconfig options selected in kunitconfig were in the generated .config.\n' \
+			  'This is probably due to unsatisfied dependencies.\n' \
+			  'Missing: ' + ', '.join([str(e) for e in invalid])
+		if self._arch == 'um':
+			message += '\nNote: many Kconfig options aren\'t available on UML. You can try running ' \
+				   'on a different architecture with something like "--arch=x86_64".'
+		logging.error(message)
+		return False
 
 	def build_config(self, build_dir, make_options) -> bool:
 		kconfig_path = get_kconfig_path(build_dir)

base-commit: c949316af0a7c2103521aaa39be85392e2f02bab
-- 
2.34.0.rc1.387.gb447b232ab-goog

