Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9973B7B7FA4
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Oct 2023 14:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242469AbjJDMss (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Oct 2023 08:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242481AbjJDMss (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Oct 2023 08:48:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBF7D8;
        Wed,  4 Oct 2023 05:48:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98219C433C8;
        Wed,  4 Oct 2023 12:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696423724;
        bh=6WYm0QAkHROFtznZ1wtrRyn0Hg3tizoNA4DjPeeCKhQ=;
        h=From:To:Cc:Subject:Date:From;
        b=id+lIPc/S1N9uh1vYCyOj8zuYxrHSja3cnTjcJQWVwZGp148U0se12TmgjWVVSn4r
         uB864HMagHQTift/X0AsbICKwd8SG00N8OfNGhvxuhM74Xhzf394sOWXAMQUPwZiG3
         uJVuq79glRRC0ZddkQ+c9zjCRPK38GoGskZ4cOg7Oa59ixC+zEqrhknPSpK11XuDOI
         DB2Ol/aUC/X3jr+tvPDwYlE0u5NTYnPpUdbmglZr0b4PHdspFA7DF8wVYJnxquHJpd
         hPVOvWwfaWrQgj3SaOcZ0PDWz/Ew2GRBIjgVdFlY6O10ycUiRjsOeput3usxmd/DmT
         ghbIfw6Du3CEg==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 0/2] kbuild: kselftest-merge target improvements
Date:   Wed,  4 Oct 2023 14:48:35 +0200
Message-Id: <20231004124837.56536-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Björn Töpel <bjorn@rivosinc.com>

Two minor changes to the kselftest-merge target:

1. Let builtin have presedence over modules when merging configs
2. Merge per-arch configs, if available


Björn

Björn Töpel (2):
  kbuild: Let builtin have precedence over modules for kselftest-merge
  kbuild: Merge per-arch config for kselftest-merge target

 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
-- 
2.39.2

