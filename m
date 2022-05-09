Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E58151F956
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 May 2022 12:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbiEIKLf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 May 2022 06:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbiEIKL2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 May 2022 06:11:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7AE17943B;
        Mon,  9 May 2022 03:07:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8BF4B810F1;
        Mon,  9 May 2022 10:03:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3209C385AB;
        Mon,  9 May 2022 10:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652090633;
        bh=SAaxmh7JCTQ5AyunYOWk9KzOOZpZ1/HBEY1fJLv6yEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q0Mri90rjbpyyTTkaq7YMQRWkne1VJDNrszIq+6KPlG3KFBqw9OvbULy3/Ssoi1HH
         dEcOEBaawAV4lJtj95wcs1RRWcvNNYIAV0Zm5Nm8fRvPCJtfWeIsBxyqEeg9bgxhXZ
         YDpz7kRrgtMiSiZwDdy8nwTLI8w+g04IxNHiQLg3e6ZunjrcCv8I9Ruyl2qNimNqJI
         5bDoy3tNU61BUksdBfsO0sJq3PRcxC4ef/T92nIujKx8iTOOtRAl5ghXYCBBi3VfbL
         Xki4JCbYFs3YmgJBjFeCwRUW3Hjc3ZhpzKyZde+aaYCSlItRArEmr2Nc8BQ8kBPqEj
         Nd0ndpffXni4Q==
Date:   Mon, 9 May 2022 12:03:46 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Hridya Valsaraju <hridya@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Li Li <dualli@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/5] binderfs: add extended_error feature entry
Message-ID: <20220509100346.s3hnvub7pjl7vmp2@wittgenstein>
References: <20220429235644.697372-1-cmllamas@google.com>
 <20220429235644.697372-4-cmllamas@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220429235644.697372-4-cmllamas@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 29, 2022 at 11:56:42PM +0000, Carlos Llamas wrote:
> Add extended_error to the binderfs feature list, to help userspace
> determine whether the BINDER_GET_EXTENDED_ERROR ioctl is supported by
> the binder driver.
> 
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---

Looks good to me,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
