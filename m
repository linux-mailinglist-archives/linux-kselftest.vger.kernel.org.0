Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCEA51F965
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 May 2022 12:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbiEIKMt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 May 2022 06:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbiEIKMh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 May 2022 06:12:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C190233A7D;
        Mon,  9 May 2022 03:08:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D74460AB0;
        Mon,  9 May 2022 10:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426A8C385AF;
        Mon,  9 May 2022 10:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652090770;
        bh=PCf4krPgNa/IY5fUBgJeLAYCiLEpbimXw3qnMtZQu1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=end9uHtjBKgnQjOzr66HnJAxoQH7YXKeGFoMz2wzMasIPSaR1FDipiGbJ91A/nlX+
         /9YWfA12nv+WVYFRMAJrbiB9saz0xMr50vPtC28y3dql+66du+SMpWpk5tIOjb9leM
         3CHXjZE6UJJipB7bVsPViTJa1XuEtedP8uFfbAm1TSLtQ6Bbn4Vo1gFY2ifZcaHu+l
         kYE1gtXlTZfIk58uEuEfpBWKXAfA77yXefIQhz5bFw5O6YjF/ABiGqEBnldzCaGd5k
         o6aqp1yMKHHSemu4TzjLwMGsPzd4+fCGNITHDxT77pEYmPkmaiN25Hlrht1/GVahBK
         3C6Oq+Vh9NP4A==
Date:   Mon, 9 May 2022 12:06:04 +0200
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
Subject: Re: [PATCH v2 1/5] binder: add failed transaction logging info
Message-ID: <20220509100604.wswe2xvju2cpwvbn@wittgenstein>
References: <20220429235644.697372-1-cmllamas@google.com>
 <20220429235644.697372-2-cmllamas@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220429235644.697372-2-cmllamas@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 29, 2022 at 11:56:40PM +0000, Carlos Llamas wrote:
> Make sure we log relevant information about failed transactions such as
> the target proc/thread, call type and transaction id. These details are
> particularly important when debugging userspace issues.
> 
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---

Looks good to me,
Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>
