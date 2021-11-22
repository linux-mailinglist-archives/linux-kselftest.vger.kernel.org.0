Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2E9459584
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Nov 2021 20:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239944AbhKVT1D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Nov 2021 14:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235437AbhKVT04 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Nov 2021 14:26:56 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6249C061748
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Nov 2021 11:23:49 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso55688wmr.4
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Nov 2021 11:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=024Wka0E713xsJf700xrx/syeZGUxbWTXnwwd3qHzwY=;
        b=nQUEWX1Sjqxu5MllGICcoGR0Z6fsCaYYLBePnULWxt2XTFRlB5RdSegT2tkjGR5gxd
         p9zdsp9aHfrie0LLPrWODNEy9WaP+UkdP5sd9j6rSOV+AOEJz/uZbCBtL1rL1MhmwCCS
         P1xxwWaL4ED+HSD8YDuogIUO8ldjdG6l6/5g9vAm7gTkkvw+RFLneIZQF0PbT8wDn8VF
         PzfS6xF1XfJJecmu8IBHFGQBW8ZiDw3FXz22zkhEw93JRLZFi2Obf371Y/OFXFbARtHU
         34g/c/WGyV8eENQ/67IRH2zlsQzj6EN0TmihOu1oiXQA79+eM+u5zpdSoDeaFn7XCadi
         cSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=024Wka0E713xsJf700xrx/syeZGUxbWTXnwwd3qHzwY=;
        b=RdRdXTYQ8SVDIg1y1REAd2CgvlShfltj+at2goVonoHnPaomhRdQoU2A7VuC/l+nH0
         Lsu4LXj6pYTJ33cu6e+4ihRx4gh+owVhRrvmlebxdy5uwhbO9gy85gNZHOxGA+KLdWSl
         hPhQbjNmjr1DxS27lRr6GRCfg5ConiFl/VmfPO7zEJSPtGKzJgklOPuDeEg+PE+Mfnr6
         Eo2urziXKZnEhg2z71rUJOrziNw6sDVVc5nseV86f8DypBJN7qiUkwyri61iZVLiF+58
         PLvRriJsTkz993XiJWDunSHc0kRCAxFYBEq3R0ytfPSa5n6vmq9tQOjC2iGI8qNhAdOb
         BaiA==
X-Gm-Message-State: AOAM5329UjmOM4AzwllFtxgTk+hiCug1JRuUBsirQKs+pDkYNKfFovWU
        vfYiD1+8HtoZtxfditcGiNcUxA==
X-Google-Smtp-Source: ABdhPJyQqsAKe+AQBZWsilg7Alcxe1XKYGhBxOi0lA49zI3GSFqu82YPs7xMUFuwO7z2yE9dkODKkg==
X-Received: by 2002:a7b:c10a:: with SMTP id w10mr27444927wmi.183.1637609027959;
        Mon, 22 Nov 2021 11:23:47 -0800 (PST)
Received: from localhost.localdomain (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id b188sm9916150wmd.45.2021.11.22.11.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 11:23:47 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        shuah@kernel.org, nathan@kernel.org, ndesaulniers@google.com
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next 2/6] tools/resolve_btfids: Support cross-building the kernel with clang
Date:   Mon, 22 Nov 2021 19:20:16 +0000
Message-Id: <20211122192019.1277299-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211122192019.1277299-1-jean-philippe@linaro.org>
References: <20211122192019.1277299-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The CROSS_COMPILE variable may be present during resolve_btfids build if
the kernel is being cross-built. Since resolve_btfids is always executed
on the host, we set CC to HOSTCC in order to use the host toolchain when
cross-building with GCC. But instead of a toolchain prefix, cross-build
with clang uses a "-target" parameter, which Makefile.include deduces
from the CROSS_COMPILE variable. In order to avoid cross-building
libbpf, clear CROSS_COMPILE before building resolve_btfids.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 tools/bpf/resolve_btfids/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index 751643f860b2..9ddeca947635 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -19,6 +19,7 @@ CC       = $(HOSTCC)
 LD       = $(HOSTLD)
 ARCH     = $(HOSTARCH)
 RM      ?= rm
+CROSS_COMPILE =
 
 OUTPUT ?= $(srctree)/tools/bpf/resolve_btfids/
 
-- 
2.33.1

