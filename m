Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDB669E681
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Feb 2023 18:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjBUR4h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Feb 2023 12:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjBUR4h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Feb 2023 12:56:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C8B3019E;
        Tue, 21 Feb 2023 09:56:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C25F1B80F01;
        Tue, 21 Feb 2023 17:56:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD87DC433D2;
        Tue, 21 Feb 2023 17:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677002174;
        bh=i1G9p2HFfEsGEPBCun+w0p9u3T0NIUNu09S0UeZIsbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ph/VR6MhjStUE0IqlCrdfg+ZiHOln3ZJN4CZxDKzhmqEkqVLEvcWOilw+RDHXXPRF
         K+BfYQ1mbAWBgbv+pMwSDAMJcT91d1yIKpVfkswkoOce16ITtuRye0rBO8thbhxr9z
         1Jhg67DXRU3QC2Pntya3vep1MdKb2mgDuaNJwD1VvWl4crC+rIr+16imofuJQBoVKv
         8N1M60Cn4ax0PljzN4maQtBqblStXdhuQ2EY9GbzmDPobiTRuvsduWe2HV0j2nCPsl
         4aEqnJLjKufeFE0rnMubSnkWGG97hJrXxI8iUumSki/6oqGTa9Mx6FIiDDcLqKKCeO
         Urp3dLtJJmulg==
From:   SeongJae Park <sj@kernel.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     sj@kernel.org, shuah@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests: damon: change scripts to be executable
Date:   Tue, 21 Feb 2023 17:56:12 +0000
Message-Id: <20230221175612.131555-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230221070837.1502935-2-anders.roxell@linaro.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 21 Feb 2023 08:08:37 +0100 Anders Roxell <anders.roxell@linaro.org> wrote:

> When running kselftest-damon The following issues shows up:
> 
> '# Warning: file debugfs_attrs.sh is not executable'
> 
> Changing the scripts so they are executable.

I tried to make similar changes before[1], but resulted in making a change in
kselftest following Greg's comment[2].  So it might make sense to remove the
warning message from kselftest instead of this change, though I think this
change also looks good.  Could I ask others' opinions?

[1] https://lore.kernel.org/mm-commits/20210810112050.22225-1-sj38.park@gmail.com/
[2] https://lore.kernel.org/mm-commits/YRJisBs9AunccCD4@kroah.com/


Thanks,
SJ

> 
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
