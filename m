Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B902374CFF9
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jul 2023 10:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjGJIdV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 04:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbjGJIct (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 04:32:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CB7E4A;
        Mon, 10 Jul 2023 01:32:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A40C60F18;
        Mon, 10 Jul 2023 08:32:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F16C433C7;
        Mon, 10 Jul 2023 08:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688977960;
        bh=Tg59EI5XYoytzopU9nzX+VHp5yfaRWW7FwRvoJROPmU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=H1kZ2YAN8eg8wu0chSIFRQIS8L6b2LeIAhOwpqmQR01tYAOCo805e1oIGRic6OTVq
         ijq71TKYe+kgTzH3kmYqcS/N13M4hV3J0H2/3cg4yO4oB05/KFLC1AVoSClwe4zmPh
         t7X2g/8RVZaMt6zPfgeoa2G9U749Y6wCTW/QjgKS0tMoYkv4U7KgXoqW3iwdOA6HVZ
         rE3ubulobJj60m4sANZi7xFrlgwDQj1jZeDwQWW1lpt+IM5S97vxO90yB77tCzs4dV
         yq587brvnCC2YkmSoAxDdiboiNI6zjyqlgU94XqtOPgDWLk//MiveDYejPJxeIwCgC
         vZSwBlcpqYh3A==
From:   Benjamin Tissoires <bentiss@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Benjamin Tissoires <bentiss@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230709-fix-selftests-v1-1-57d0878114cc@kernel.org>
References: <20230709-fix-selftests-v1-1-57d0878114cc@kernel.org>
Subject: Re: [PATCH] selftests: hid: fix vmtests.sh not running make
 headers
Message-Id: <168897795922.315593.13314743916178846811.b4-ty@kernel.org>
Date:   Mon, 10 Jul 2023 10:32:39 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, 09 Jul 2023 12:06:56 +0200, Benjamin Tissoires wrote:
> According to commit 01d6c48a828b ("Documentation: kselftest:
> "make headers" is a prerequisite"), running the kselftests requires
> to run "make headers" first.
> 
> Do that in "vmtest.sh" as well to fix the HID CI.
> 
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-6.5/upstream-fixes), thanks!

[1/1] selftests: hid: fix vmtests.sh not running make headers
      https://git.kernel.org/hid/hid/c/f9abdcc617da

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

