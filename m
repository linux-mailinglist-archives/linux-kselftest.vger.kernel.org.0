Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EA372A2FE
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jun 2023 21:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjFITVT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jun 2023 15:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjFITVT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jun 2023 15:21:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51709E62;
        Fri,  9 Jun 2023 12:21:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2074656F6;
        Fri,  9 Jun 2023 19:21:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04D8C4339E;
        Fri,  9 Jun 2023 19:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686338477;
        bh=sSEGVfG+v8CWDd65ui9wgJPVlohhSQJriUCAmoaXyxU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r/wnpri8KtZ+LjIg0X2XNzH+aIMb5TVqVm21DZtm0t/rvW7mL/KquY31CXoNOSL13
         qnFcqqJZyU38ZZYbLu+zNA18wsd4YqynOljJkMcv1nNgdqNWvRKrbZr8gD/GOxLeuI
         F++t0Mipdxq5Y4GcPgofGztW0v1Rg8FBT+zcN6qnLyjTeFpdl1/1p+zexJ6nL5XDpr
         hJrbC+lmbnI59L3YfsxaNS1O0WGu4aREUcOhHODsu2uXBp+aKZA1O03wyhDB30BTa3
         XIN9WEahpdTjMkoEGIuOhWt4kMTsllLoxZh1BFG6Y63KqmHEqNQcKWVctvwvnsBTXc
         BqnmysOSM8QsQ==
Date:   Fri, 9 Jun 2023 12:21:15 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Magali Lemes do Sacramento <magali.lemes@canonical.com>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        shuah@kernel.org, vfedorenko@novek.ru,
        tianjia.zhang@linux.alibaba.com, andrei.gherzan@canonical.com,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/3] selftests: net: tls: check if FIPS mode is
 enabled
Message-ID: <20230609122115.25dca627@kernel.org>
In-Reply-To: <CAO9q4O0KpMxukPLxvhyNj692vBSUzygdLQi3Ek1QUJbeYJhyag@mail.gmail.com>
References: <20230609164324.497813-1-magali.lemes@canonical.com>
        <20230609164324.497813-2-magali.lemes@canonical.com>
        <20230609105307.492cd1f2@kernel.org>
        <CAO9q4O0KpMxukPLxvhyNj692vBSUzygdLQi3Ek1QUJbeYJhyag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 9 Jun 2023 15:52:10 -0300 Magali Lemes do Sacramento wrote:
> > No need to zero init static variables, but really instead of doing
> > the main() hack you should init this to a return value of a function.
> > And have that function read the value.
> 
> I'm not sure I understand what you mean here. I agree we want to avoid
> reading the /proc/sys/crypto/fips_enabled file for every test.
> However, correct me where I'm wrong, if we want to have fips_enabled
> as a static global variable I don't think we can directly initialize
> it from the return value of a function.
> Could you clarify that, please?

Hm, I thought that worked, I must be misremembering.
If it doesn't - let's steal the trick that the harness itself uses and
put the init in a function decorated with __attribute__((constructor)).
