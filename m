Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C6151F98D
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 May 2022 12:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiEIKS2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 May 2022 06:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbiEIKSW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 May 2022 06:18:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48832802F8;
        Mon,  9 May 2022 03:14:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB79F60A55;
        Mon,  9 May 2022 10:05:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E99C385AB;
        Mon,  9 May 2022 10:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652090707;
        bh=3eem/1EKHG9ugSaeMFl25QXI2GAFje6S1BoxzYczquk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F+z2e9nCgzdGQv7rtk1jfhub9LUWpJ+af1Fkl8pF3NYYyIgF7ZbMQpNYAWcIZ5T0L
         Bpfg/Rl5V5bO0UBUhkLrLpD3ypF1GLp2QWhuVyg45ZJ+jNSwOz8BMKQYBBBac8czZv
         dJDFRU/L81fHtvKAjzbag41qMJVrAv/wOo/6tsHnICfVwk7MImLLvM1+KWuNW/nXlu
         noaGx9i+lh3lNfWrSTl4pkcW3MTBQNO/yX4HmadonX4flVEq1Bh5jOEHsZo4hrttJ7
         GpRQWqnKGyR9fDdPkNc1o7j/vH9T4bUHoa5kRCGaV3v5KVUubxbPGx6pMDhYz9zSIb
         ePtcDmmXyM4+w==
Date:   Mon, 9 May 2022 12:04:56 +0200
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
Subject: Re: [PATCH v2 4/5] binder: convert logging macros into functions
Message-ID: <20220509100456.gwov42l7uei4feja@wittgenstein>
References: <20220429235644.697372-1-cmllamas@google.com>
 <20220429235644.697372-5-cmllamas@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220429235644.697372-5-cmllamas@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 29, 2022 at 11:56:43PM +0000, Carlos Llamas wrote:
> Converting binder_debug() and binder_user_error() macros into functions
> reduces the overall object size by 16936 bytes when cross-compiled with
> aarch64-linux-gnu-gcc 11.2.0:
> 
> $ size drivers/android/binder.o.{old,new}
>    text	   data	    bss	    dec	    hex	filename
>   77935	   6168	  20264	 104367	  197af	drivers/android/binder.o.old
>   65551	   1616	  20264	  87431	  15587	drivers/android/binder.o.new
> 
> This is particularly beneficial to functions binder_transaction() and
> binder_thread_write() which repeatedly use these macros and are both
> part of the critical path for all binder transactions.
> 
> $ nm --size vmlinux.{old,new} |grep ' binder_transaction$'
> 0000000000002f60 t binder_transaction
> 0000000000002358 t binder_transaction
> 
> $ nm --size vmlinux.{old,new} |grep binder_thread_write
> 0000000000001c54 t binder_thread_write
> 00000000000014a8 t binder_thread_write
> 
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---

Looks good to me,
Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>
