Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A666B95BF
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Mar 2023 14:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjCNNOb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Mar 2023 09:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjCNNOI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Mar 2023 09:14:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41002412B;
        Tue, 14 Mar 2023 06:10:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83C9D61765;
        Tue, 14 Mar 2023 13:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1B2C433D2;
        Tue, 14 Mar 2023 13:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678799403;
        bh=y+Mm4syiQyk9+ReFkQ85/jas9rM1bCuG+6K2YWtPQMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eTpwhRtXO16cDj92+tDLDQSut2EbFbpjfAW7yKtUm9/EdIQjwnHpamaKp7urItELz
         bqoGYcDEPNv7CQVGJmPIQuUI8KQFqT/4zQR8ruFhDtWRsloWNdInqYIhCnls4SzX1z
         ZTILLZeJJTNDsJki8gCtYSA/nGuDAEmxmjeRSepi9SPCOy6diJIJw2rxUtOhRm77r+
         V8BI3cPdgwyAdLyD4kfrILWRgbUu/+YAlukrirPUHmvu98OF/OG+dBxqDg+UpJU1kg
         ZcH5IWclu6f5gUcj5Uuj9GikxdEiXf2/h2tuLCHlncckLNelTekpu/YLjEir4sYaEp
         xxr8/npfmedUg==
Date:   Tue, 14 Mar 2023 14:09:59 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/clone3: fix number of tests in ksft_set_plan
Message-ID: <20230314130959.7gfuagxta6k423kf@wittgenstein>
References: <20230314115352.20623-1-tklauser@distanz.ch>
 <20230314123414.26907-1-tklauser@distanz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230314123414.26907-1-tklauser@distanz.ch>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 14, 2023 at 01:34:14PM +0100, Tobias Klauser wrote:
> Commit 515bddf0ec41 ("selftests/clone3: test clone3 with CLONE_NEWTIME")
> added an additional test, so the number passed to ksft_set_plan needs to
> be bumped accordingly.
> 
> Also use ksft_finished() to print results and exit. This will catch future
> mismatches between ksft_set_plan() and the number of tests being run.
> 
> Fixes: 515bddf0ec41 ("selftests/clone3: test clone3 with CLONE_NEWTIME")
> Cc: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---

Looks good. Thanks for fixing this,
Reviewed-by: Christian Brauner <brauner@kernel.org>

Feel free to take this through the selftests tree, Shuah.
