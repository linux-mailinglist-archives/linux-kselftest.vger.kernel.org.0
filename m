Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727E851F973
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 May 2022 12:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiEIKOF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 May 2022 06:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbiEIKOC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 May 2022 06:14:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132C4237266;
        Mon,  9 May 2022 03:10:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 181B560ABC;
        Mon,  9 May 2022 10:06:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19415C385AB;
        Mon,  9 May 2022 10:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652090805;
        bh=QzkMLjT1rOqOza+MZUJwpgWcVa9l/57yvp1guEUS1qw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tU+FTu+4vYjYnrI1KJU+jqWTkfjBpB+IeBMiyj0ffy4S8v6tfZHRA6JYAw4d5oXio
         w9psrS2628omHe0e8/jy3ZjRHh8kTR5/TJNJPop7+vrxhYhAq3/2taQuIVeaRomD1O
         jjkDR+ngZnxDmyRO1lGKqhTC6KI7CfKWm38bO45EjUlLxMl8pFNw8yVu7EvLJQixWd
         gt66y+2E7M2njOrPwpWR0g3/w+ArCjQ3luhRpFdbdxTsqJp7JgI8rDNkWHFaDKVqY0
         82YFcqfF0qJ9EiwocJkp1f/tqq/Ir6l50zazDm/2zLpDJaWM6Fh8806d3jRN1pEMuU
         OJ+JTHuWep3KQ==
Date:   Mon, 9 May 2022 12:06:39 +0200
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
Subject: Re: [PATCH v2 5/5] binder: additional transaction error logs
Message-ID: <20220509100639.y5qwofnyqlnooeig@wittgenstein>
References: <20220429235644.697372-1-cmllamas@google.com>
 <20220429235644.697372-6-cmllamas@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220429235644.697372-6-cmllamas@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 29, 2022 at 11:56:44PM +0000, Carlos Llamas wrote:
> Log readable and specific error messages whenever a transaction failure
> happens. This will ensure better context is given to regular users about
> these unique error cases, without having to decode a cryptic log.
> 
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---

Looks good to me,
Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>
