Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220F055F379
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jun 2022 04:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiF2Crg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Jun 2022 22:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiF2Crf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Jun 2022 22:47:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E962C22BD6;
        Tue, 28 Jun 2022 19:47:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA79AB8215E;
        Wed, 29 Jun 2022 02:47:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ECE3C341C8;
        Wed, 29 Jun 2022 02:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656470852;
        bh=o5bHc1W4NKi5ssaTnaKr79/LpMTxQhH99eJscj/wYmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AmPq0o4i/fDifCayAZEDHnYcFMhjh/XkfqqawhepkHl5k818bm2nr35JIQZeVp3GY
         ChFdQ/qqdgEMRJEPljQ7x4bKKwmS1Gp326gjKTpmJn7Qq/CSEsSAsQX6Z2V3KW/a2m
         jiIhhtBNX/kMj4GpPFLBy5MuGZfI/A43SCxhF/FIciepea5vVn6pG3A1oXP1BopKMi
         /GwudNUR9/qW3Z+B3tI8gdtnV6UDNx9TvB4D/QDpwtoeGKcjmelnKPE6dPNHYpAiTC
         jb7xHsJ4bq26hD+dwFAgWz1q9FTFk0RHovzs6Xo5+BF/Uca4ocw1i3r8DNX+YbBR6n
         Dqis4kaB77zAw==
Date:   Wed, 29 Jun 2022 05:47:29 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
Cc:     shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, peterhuewe@gmx.de,
        johannes.holland@infineon.com
Subject: Re: [PATCH v2] selftests/tpm2: increase timeout for kselftests
Message-ID: <Yru9QXQHI212X9zm@kernel.org>
References: <20220628143927.26043-1-stefan.mahnke-hartmann@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628143927.26043-1-stefan.mahnke-hartmann@infineon.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 28, 2022 at 04:39:27PM +0200, Stefan Mahnke-Hartmann wrote:
> From: Johannes Holland <johannes.holland@infineon.com>
> 
> Due to CreatePrimary commands which need to create RSA keys of
> increasing size, the timeout value need to be raised, as well.
> Default is 45s.
> 
> Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
> Signed-off-by: Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
> ---
> Changelog:
>  * v2:
>    * Add maintainter to recipients
>    * Change subject
>  tools/testing/selftests/tpm2/settings | 2 ++
>  1 file changed, 2 insertions(+)
>  create mode 100644 tools/testing/selftests/tpm2/settings
> 
> diff --git a/tools/testing/selftests/tpm2/settings b/tools/testing/selftests/tpm2/settings
> new file mode 100644
> index 000000000000..919bc3803f03
> --- /dev/null
> +++ b/tools/testing/selftests/tpm2/settings
> @@ -0,0 +1,2 @@
> +timeout=600
> +
> -- 
> 2.25.1
> 


Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
