Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02535770F53
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Aug 2023 12:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjHEKnB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Aug 2023 06:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjHEKnA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Aug 2023 06:43:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FF94689;
        Sat,  5 Aug 2023 03:42:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E96C60C82;
        Sat,  5 Aug 2023 10:42:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06417C433C7;
        Sat,  5 Aug 2023 10:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691232178;
        bh=HjBWjOuejvnkKby6eQoj0qIOEikrbperZEMLEkvwOgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sq4xInJx6GYuCZyOnm6Qyg/yQAu5+YGvLzeQdws0RsT2IthpF0lGYs9kP+ENLxBOq
         CK8yKjHyy4WAqzYJJrELI7wpbZawTwXbjyjHCDUpyG7CDyYaqYeWzZSECYnvpAwVX0
         3mq8PyS8wX33xS8+14xPLoX5Ryel0TRpC6tc2mr696lhafXCWBYh5593l1ZA730AzS
         8m8yb8fZz50HOXlANwYhxfDfEN2J0Pj+oaChh9mEHqo06dtUqznG2ot2cpL02WSxYC
         PJjrB1OBZUzpcopwm+C8Ym54aV+Fs/X94coFewb36VwEXplZHBaRiKEwW2hpz7dC1O
         0EqjnyP7D59dA==
From:   Christian Brauner <brauner@kernel.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Christian Brauner <brauner@kernel.org>, kernel@collabora.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Alexey Gladkov <legion@kernel.org>
Subject: Re: (subset) [PATCH 4/6] selftests: fchmodat2: remove duplicate unneeded defines
Date:   Sat,  5 Aug 2023 12:42:53 +0200
Message-Id: <20230805-nullrunde-tierreich-0d7ab1332b08@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230805073809.1753462-4-usama.anjum@collabora.com>
References: <20230805073809.1753462-1-usama.anjum@collabora.com> <20230805073809.1753462-4-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1122; i=brauner@kernel.org; h=from:subject:message-id; bh=HjBWjOuejvnkKby6eQoj0qIOEikrbperZEMLEkvwOgg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaScU1/l8TBqf7Tokg+7fr2dNp/TSLA0o25bvODkKz+S+i+4 vl1q1FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRDFmGP/xXvgfF+Yt5p6RPcnv5lM O595TLY5tdXtOLLheX20/eVMDIcFXQ9/ra+3nnE/mWqcxxfhF158z6WqmQh9zTmv/85TmjxgsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
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

On Sat, 05 Aug 2023 12:38:02 +0500, Muhammad Usama Anjum wrote:
> These duplicate defines should automatically be picked up from kernel
> headers. Use KHDR_INCLUDES to add kernel header files.
> 
> 

Since the test isn't upstream yet I'm carrying it separately from the
other patches which will go through the selftest tree.

---

Applied to the vfs.fchmodat2 branch of the vfs/vfs.git tree.
Patches in the vfs.fchmodat2 branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fchmodat2

[4/6] selftests: fchmodat2: remove duplicate unneeded defines
      https://git.kernel.org/vfs/vfs/c/712143795327
