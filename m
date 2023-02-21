Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C928D69E5C8
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Feb 2023 18:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbjBURT6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Feb 2023 12:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbjBURT5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Feb 2023 12:19:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FBE298DE;
        Tue, 21 Feb 2023 09:19:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5AE5B8101B;
        Tue, 21 Feb 2023 17:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC12C433D2;
        Tue, 21 Feb 2023 17:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676999993;
        bh=7wiQ/xYyuNw35RKFXPt2R11yI1JBADiHr0Pe0/cFFAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iHAo4FtCP0Gb4wZWxmWcQnfhP6mXjTZ/hOEATZCBUT4xivBT+q2ywg1Qc4T//lg06
         ndLpwV8tcONINacxKE7WYYBVPqp4EhSR0diinFg5Wu1wGQawbT5+329I3MnqNH5R3t
         vatriqnFP7UkWzNBuXUMDtiOOmLtKSRdJ5prFRj8C2xEqrAoID8/2i4Ej+Ccez6yJv
         3V8sHmFog3/wJqIJyFNRocSyOtpJ3rZPK8cvwjAx1Za+gRwIDbplRXeEHCJvlPJ86g
         dHuhJ2wlkFQ0QUzEb0EZ2Lo00xafBWNmEOENedQHOhwmcuoOU0CbF1F8w0kY4AhPCA
         j/yp9vPws5Xqw==
From:   SeongJae Park <sj@kernel.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     sj@kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH 1/2] selftests: damon: add config file
Date:   Tue, 21 Feb 2023 17:19:51 +0000
Message-Id: <20230221171951.131472-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230221070837.1502935-1-anders.roxell@linaro.org>
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

Hi Anders,


Thank you for this patch!

On Tue, 21 Feb 2023 08:08:36 +0100 Anders Roxell <anders.roxell@linaro.org> wrote:

> Building and running the subsuite 'damon' of kselftest, shows the
> following issues:
>  selftests: damon: debugfs_attrs.sh
>   /sys/kernel/debug/damon not found
> 
> By creating a config file enabling DAMON fragments in the
> selftests/damon/ directory the tests pass.
> 

I think we could put Fixes tag as below?

Fixes: b348eb7abd09 ("mm/damon: add user space selftests")

Though this may not need to be merged in stable.

> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  tools/testing/selftests/damon/config | 8 ++++++++
>  1 file changed, 8 insertions(+)
>  create mode 100644 tools/testing/selftests/damon/config
> 
> diff --git a/tools/testing/selftests/damon/config b/tools/testing/selftests/damon/config
> new file mode 100644
> index 000000000000..a6b636e438b9
> --- /dev/null
> +++ b/tools/testing/selftests/damon/config
> @@ -0,0 +1,8 @@
> +CONFIG_DEBUG_SYSFS=y

's/SYS//'?  Or, I guess this is not needed at all?

> +CONFIG_DAMON=y
> +CONFIG_DAMON_SYSFS=y
> +CONFIG_DAMON_DBGFS=y
> +CONFIG_DAMON_PADDR=y
> +CONFIG_DAMON_VADDR=y
> +CONFIG_DAMON_RECLAIM=y
> +CONFIG_DAMON_LRU_SORT=y


Thanks,
SJ

> -- 
> 2.39.1
