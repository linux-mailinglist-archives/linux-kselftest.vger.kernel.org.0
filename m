Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B3C72107C
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jun 2023 16:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjFCOjB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 3 Jun 2023 10:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjFCOjA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 3 Jun 2023 10:39:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262E1C2;
        Sat,  3 Jun 2023 07:39:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE3CB617E2;
        Sat,  3 Jun 2023 14:38:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D44AC433D2;
        Sat,  3 Jun 2023 14:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685803139;
        bh=Z99L+dNC5BHG3KIsnry/D3DKzq0TQOplhNDQr6cxMoE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zL5CKap4v2sKAzmMtTqpXfYaEpbrjJ/Vaa2YqLZlXPYTb1mOzrLovC6c8m3K1VgEY
         SpQp+fpyjct211VduIyI/b89Q1R7pA0biAs7M9hDIkBhfV+88o4L5y377YAy5htvXs
         lrrM+iyBPXo7JVReaa+7uHJsfF0qfgVMxlzQlZR4=
Date:   Sat, 3 Jun 2023 16:38:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH RESEND 2/2] drivers: base: Add basic devm tests for
 platform devices
Message-ID: <2023060332-devoutly-elusive-6cd7@gregkh>
References: <20230329-kunit-devm-inconsistencies-test-v1-0-015b1574d673@kernel.org>
 <20230329-kunit-devm-inconsistencies-test-v1-2-015b1574d673@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329-kunit-devm-inconsistencies-test-v1-2-015b1574d673@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 02, 2023 at 05:20:44PM +0200, Maxime Ripard wrote:
> From: Maxime Ripard <maxime@cerno.tech>
> 
> Platform devices show some inconsistencies with how devm resources are
> released when the device has been probed and when it hasn't. Let's add a
> few tests to exercise thos paths and odd cases.

"those" :)

And what are those inconsistencies?  Where are they documented?  Here or
somewhere else?

thanks,

greg k-h
