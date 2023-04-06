Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AD26D938E
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 12:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbjDFKDa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 06:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236525AbjDFKDE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 06:03:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DCF61BA;
        Thu,  6 Apr 2023 03:02:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2CE562C20;
        Thu,  6 Apr 2023 10:02:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E740FC433EF;
        Thu,  6 Apr 2023 10:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680775371;
        bh=5mLgfj1G2UTDkLCtc+vh8WTGD7CZqzvBlQjTamH7xAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mOBI6Q2jq8/ltgkk5OPPgOPtnsldkhgTvLLJLMdg2uA90ISRCuy3LSfhHcUUEXR7c
         P9fX5UXLQKlC+CPWOYfngOvcQ8brbgaoBahw0rKKxqxdoueG8aDgZzJm+ILPDGYj9P
         jWO4SPqshGeY08HeabclRLQvbaUaW/XqQS4VyxbbTXEv90xNnL4JG4eC1YvmNso79k
         lZ1R0bsNMapZ72c8twYsBv++U9oD73LPSa+aAx6+RxVlDVQ2VSBjKND/JKXMLm+E4c
         0MUzI+HwZfO0or9O6BQEz/gPA2EMJrSzsdNYJs47MNJJV2DFji0ujrh569hK9+0DHP
         LSagKLpUoe4Wg==
From:   Christian Brauner <brauner@kernel.org>
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v2] selftests/clone3: fix number of tests in ksft_set_plan
Date:   Thu,  6 Apr 2023 12:02:37 +0200
Message-Id: <20230406-restlaufzeit-authentisch-a041dd97e122@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230314123414.26907-1-tklauser@distanz.ch> <20230405094349.7fkipggxdmrnn2mo@distanz.ch>
References: <20230314115352.20623-1-tklauser@distanz.ch> <20230314123414.26907-1-tklauser@distanz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=715; i=brauner@kernel.org; h=from:subject:message-id; bh=B5+LtXcP8uVKUrzBHeVvsFC4YFZRP9XQGCBdHP2lIc0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTozViVNDH2vsNHU4OwVnvX+9+12d43LzGPWN7nvGWp+dSQ FfYXO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbiIMDwP/aTS/YNiaojYms2yt/ew3 Xv5baVftvLb87hj4izsJxpL8Hw35/zmPSGz74/7k/qVFvUl9bKpytgU1S+6PwdS+bXbV8LOQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On Tue, 14 Mar 2023 13:34:14 +0100, Tobias Klauser wrote:
> Commit 515bddf0ec41 ("selftests/clone3: test clone3 with CLONE_NEWTIME")
> added an additional test, so the number passed to ksft_set_plan needs to
> be bumped accordingly.
> 
> Also use ksft_finished() to print results and exit. This will catch future
> mismatches between ksft_set_plan() and the number of tests being run.
> 
> [...]

Applied, thanks!

tree: git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git
branch: kernel.fork
[1/1] selftests/clone3: fix number of tests in ksft_set_plan
      commit: d95debbdc528d50042807754d6085c15abc21768

I'm happy to drop it in case this is later picked up by the selftest tree.
