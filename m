Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A9650DD2B
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Apr 2022 11:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbiDYJxQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Apr 2022 05:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240932AbiDYJxH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Apr 2022 05:53:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2313E0E6;
        Mon, 25 Apr 2022 02:50:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1766CB811AC;
        Mon, 25 Apr 2022 09:50:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DA8C385A4;
        Mon, 25 Apr 2022 09:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650880199;
        bh=JVAQ5gkZLZo+XCl0pVA/MBO5F3Pm37Lwl9hXUsz8POE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VAhDmXHjAjyEI/jK26+pTYrdu8hM2U+KkH3A/lbw+Ujyr8l/p79A90CbRlWGDZM6K
         w5t75jowt+GT28CqVur/4tXWIcP74tbZRx79bXdkE6RW/l8/0cpWmGJsNYs6MSi1B5
         nJcUjpt6DtngZ/oeJ2k/7cEqngkmrN+68P5Nggef/Ec4+8yp/886JhffwTesnOfYy9
         +qlYRBviuwEWgCO49DPGYfN9zf7hleRKoeiZ0Aiwr9XehXIQ60ENRcpgAmHmh8gywL
         2qtnJLx49RESBFqwaZbWOpsgR89nDDHMk3kbxy34onHot0dzJ3rTGrkMsWpXrs1shv
         PV4ADAqkrbt7g==
Date:   Mon, 25 Apr 2022 11:49:55 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Karthik Alapati <mail@karthek.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Carlos Llamas <cmllamas@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/binderfs: Improve message to provide more info
Message-ID: <20220425094955.ti3hw7asp6h5funn@wittgenstein>
References: <YmOSQv2U8+Hs5WjP@karthik-strix-linux.karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YmOSQv2U8+Hs5WjP@karthik-strix-linux.karthek.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Apr 23, 2022 at 11:14:34AM +0530, Karthik Alapati wrote:
> Currently the binderfs test says what failure it encountered
> without saying why it may occurred when it fails to mount
> binderfs. So, Warn about enabling CONFIG_ANDROID_BINDERFS in the
> running kernel.
> 
> Signed-off-by: Karthik Alapati <mail@karthek.com>
> ---

Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
