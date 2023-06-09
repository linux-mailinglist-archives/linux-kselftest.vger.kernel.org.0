Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC5F72A2F2
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jun 2023 21:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjFITQa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jun 2023 15:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjFITQ1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jun 2023 15:16:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25191E62;
        Fri,  9 Jun 2023 12:16:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEE8F65B41;
        Fri,  9 Jun 2023 19:16:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A48C4339C;
        Fri,  9 Jun 2023 19:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686338185;
        bh=tJjWk6hGIUwDfmPq3y89WUdeFFNwy2a0cWqN5OR7kJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KF5au+WfV0NuB0ror1osdkBAbZLKNTlIzfO7xdF9/kwLYpsNE6bOUjL7l4mW218XN
         Zswfyuk+qs/TjZiP60VijNjhYEQb3fvxWDeXRcmfeTizhr1nMK7uc4kGXMeveApGzU
         DaTl9qgAo/giDkLqZFy3Kwoh0oLKcXvsOGe9H6wBVmdyAvgdDeHEqTwJ1DoKUB3omv
         EfD04rIlueqhUKXR5cJFhOxX3v44n2ltyE02VWNXRKLAbQryQA5ntHT5YM1gN6JypB
         bVNXhWX34B7ujj5CH/cxteXyMcsiZ18cGgH8ZBt46a3Sw1/kY/GgPhkn5fv+mZ3Lxp
         fhCegvfX8DQJQ==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org,
        Anders Roxell <anders.roxell@linaro.org>, shuah@kernel.org,
        linux-kernel@vger.kernel.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCHv2] selftests: damon: add config file
Date:   Fri,  9 Jun 2023 19:16:22 +0000
Message-Id: <20230609191622.80289-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230412165806.80672-1-sj@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 12 Apr 2023 16:58:06 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hi Anders,
> 
> On Wed, 12 Apr 2023 11:28:54 +0200 Anders Roxell <anders.roxell@linaro.org> wrote:
> 
> > Building and running the subsuite 'damon' of kselftest, shows the
> > following issues:
> >  selftests: damon: debugfs_attrs.sh
> >   /sys/kernel/debug/damon not found
> > 
> > By creating a config file enabling DAMON fragments in the
> > selftests/damon/ directory the tests pass.
> > 
> > Fixes: b348eb7abd09 ("mm/damon: add user space selftests")
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> 
> checkpatch.pl is warning as below:
> 
>     WARNING: Reported-by: should be immediately followed by Link: with a URL to the report
>     #20:
>     Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>     Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> 
> The reason for the warning can be found from commit d7f1d71e5ef6 ("checkpatch:
> warn when Reported-by: is not followed by Link:")'s commit message.  Do you
> have a link to put here?  I guess the report was made inside Linaro, so might
> have no publicly available link.  Maybe better to add some notes or some funny
> tag like "Link: N/A # no publicly-available link of the report" for convincing
> the tool, but I don't think this should be a blocker for this patch.
> 
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>

Shuah, may I ask your opinion on this patch?

I'm also cc-ing Andrew, as he may also interested in picking this patch.


Thanks,
SJ

> 
> 
> Thanks,
> SJ
> 
> > ---
> >  tools/testing/selftests/damon/config | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >  create mode 100644 tools/testing/selftests/damon/config
> > 
> > diff --git a/tools/testing/selftests/damon/config b/tools/testing/selftests/damon/config
> > new file mode 100644
> > index 000000000000..0daf38974eb0
> > --- /dev/null
> > +++ b/tools/testing/selftests/damon/config
> > @@ -0,0 +1,7 @@
> > +CONFIG_DAMON=y
> > +CONFIG_DAMON_SYSFS=y
> > +CONFIG_DAMON_DBGFS=y
> > +CONFIG_DAMON_PADDR=y
> > +CONFIG_DAMON_VADDR=y
> > +CONFIG_DAMON_RECLAIM=y
> > +CONFIG_DAMON_LRU_SORT=y
> > -- 
> > 2.39.2
> 
