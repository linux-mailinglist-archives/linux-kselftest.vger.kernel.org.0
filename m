Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C167B814A
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Oct 2023 15:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242663AbjJDNr5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Oct 2023 09:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242652AbjJDNrx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Oct 2023 09:47:53 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5D19B;
        Wed,  4 Oct 2023 06:47:49 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9b1ebc80d0aso387874966b.0;
        Wed, 04 Oct 2023 06:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696427268; x=1697032068; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I1zr3QyrRab34YjbDoJeZTwZ877wt83ubKCahPs2NWU=;
        b=lzqMmUI4R+ERWIc7zl1GyhnLuWeI/ZTAUvyejRIEL6jPzshOwy8Rfrfx5h839kJQb7
         EN02cer0HTBhKm1MS9/wbNv9Utk1+kXiwF8i7hl8jEKbJNV//DPKOjHC7pCzWRoor4Q4
         w4NRM9h7yleW2/Jj80rHhgrqMl5YYLT6vzEQ98HcPIkNu1bulX9qtTS96cfM/We2hh2D
         S0XXixR79feHFoqhZtbwNqRqvDarsBkoWcUm0x6Ga/4MJfdb/3VfEzN5c0JRv4UYsxEP
         8ilG4xUZh4mIhxtB0jvYcSjjUSMtpn5DYu277iJk/+YEA0SqEYV93CgNG/LZ9pfJz/ZM
         yp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696427268; x=1697032068;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1zr3QyrRab34YjbDoJeZTwZ877wt83ubKCahPs2NWU=;
        b=IHmcaCreh7oZop+6cgpXt8ZE1Xzg1neaU7CLYMtwPNdpvau+icLRyZ4jJqQdZb7Ibk
         9vKQkCePk+BmtAVUvfvcFeQJTbQpO74moSRh6dYB+UpcOAd4/a2mrPOdkGIVaMOyyr5V
         PzEb3YaO5Cq0ZLKqVDqu/o8aRJrEqVhY/1PJU9+KbNkkAoeqHdmPES6zoDokdw0lTq4u
         k4vmrtGEQJO2Pda4MP6wl8xJbLx5exPSNqZUVeZmrT40uoacCQ5pnaa6v/PfuIUZuWSE
         5ctXEZbjtDjpgu3D5I+UbRim7fcpavwsyce0y5ZWgGenECyRPbgEYPynGsiTclwyBbIW
         M18g==
X-Gm-Message-State: AOJu0YyTsXKK8D57uEgam9OQbbTFZeSydofwN+GiHgDW1y8GFlT20JAW
        cA7Wn3nGiAQp/iJ5zwS+uJamfPqnCgADHw==
X-Google-Smtp-Source: AGHT+IG1GU5Q6WEANAwSOY2AZD1N1CUddHWMbtHL0AB4CjDFJX6kewEa3vy3b/WzbqjYm9gTewmnTQ==
X-Received: by 2002:a17:907:2723:b0:9a5:d657:47ee with SMTP id d3-20020a170907272300b009a5d65747eemr1999081ejl.58.1696427267908;
        Wed, 04 Oct 2023 06:47:47 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id kf1-20020a17090776c100b00992f2befcbcsm2805593ejc.180.2023.10.04.06.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 06:47:47 -0700 (PDT)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date:   Wed, 04 Oct 2023 15:47:43 +0200
Subject: [PATCH 3/3] selftests/dmabuf-heaps: add gitignore file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231004-topic-selftest_gitignore-v1-3-40689bcd23e2@gmail.com>
References: <20231004-topic-selftest_gitignore-v1-0-40689bcd23e2@gmail.com>
In-Reply-To: <20231004-topic-selftest_gitignore-v1-0-40689bcd23e2@gmail.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696427264; l=515;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=Fy8e2jpbkway7o2jXZz31LU68r9YzhJywXlYBNMd5AQ=;
 b=g8xKt1P8ziu97cszgQhL9lABHnX0LODN8p2+cGK2lnngVUPymvVwVS+wiKUsJ3u88vwM6UL7w
 mtdGOlsjjMqClnYnc5PvcdXGpFps8A/sjwdnf1pBrKYQixVyQluWECp
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

dmabuf-heaps builds a dmabuf-heap binary that can be ignored by git.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/dmabuf-heaps/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/dmabuf-heaps/.gitignore b/tools/testing/selftests/dmabuf-heaps/.gitignore
new file mode 100644
index 000000000000..b500e76b9045
--- /dev/null
+++ b/tools/testing/selftests/dmabuf-heaps/.gitignore
@@ -0,0 +1 @@
+dmabuf-heap

-- 
2.39.2

