Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1A07BA4D1
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Oct 2023 18:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237803AbjJEQK6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Oct 2023 12:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238367AbjJEQJ7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Oct 2023 12:09:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBD57D015;
        Thu,  5 Oct 2023 08:56:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13C4C433CC;
        Thu,  5 Oct 2023 15:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696521361;
        bh=3yQpTAu+sxNfHSN9OgsgXUOtauvkvvEyt8XXZhf2+8Q=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=QeBzDi88VBkjZ7kWlDKDGeGHaEjWV1lZkkcsCVKn4dR86Bo+SCfF6chKzIqn7DKRV
         b9XYa8UC0xp3HXw60hOVdxCN9bKqUQXNtk/wRMsmTZRefN+Ihl7uysL6Qx7y/ayFzM
         bizhHSa5OfWRTiQ0koQ/OXHjiaKnWcnqDE0HD3NlKKugmCfC5EObuOsgWNih/ajW+Y
         j0R+Shhw8tStRzMawg2I592r9SBWd8Ifps/l96BWPUWD4Hg0nSiPODvTbDGXAbcKjJ
         r4yUriACcMWAhvsep2awIgcHgRqFi0FOmJSCOADOjZbLgh1cIdRoTTV35Q0Dy09HP1
         oZK9daysQ5s1A==
From:   Benjamin Tissoires <bentiss@kernel.org>
Date:   Thu, 05 Oct 2023 17:55:34 +0200
Subject: [PATCH v3 3/3] selftests/hid: force using our compiled libbpf
 headers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230825-wip-selftests-v3-3-639963c54109@kernel.org>
References: <20230825-wip-selftests-v3-0-639963c54109@kernel.org>
In-Reply-To: <20230825-wip-selftests-v3-0-639963c54109@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Justin Stitt <justinstitt@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696521351; l=861;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=3yQpTAu+sxNfHSN9OgsgXUOtauvkvvEyt8XXZhf2+8Q=;
 b=eIdtTxiPAfLwDHc48vMYIjkvNAImwnjNSqDn15AmjAiyy7B9UA+gvMuOv21ud5O/eowiKvU08
 bAxL8sik++/B3aUqy31juWFTeDemZbh3/XHcdEvYyoq7jXXpJ20+jXq
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Turns out that we were relying on the globally installed headers, not
the ones we freshly compiled.
Add a manual include in CFLAGS to sort this out.

Tested-by: Nick Desaulniers <ndesaulniers@google.com> # Build
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
index a28054113f47..2b5ea18bde38 100644
--- a/tools/testing/selftests/hid/Makefile
+++ b/tools/testing/selftests/hid/Makefile
@@ -22,6 +22,8 @@ CXX ?= $(CROSS_COMPILE)g++
 HOSTPKG_CONFIG := pkg-config
 
 CFLAGS += -g -O0 -rdynamic -Wall -Werror -I$(OUTPUT)
+CFLAGS += -I$(OUTPUT)/tools/include
+
 LDLIBS += -lelf -lz -lrt -lpthread
 
 # Silence some warnings when compiled with clang

-- 
2.39.1

