Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00E050A9A9
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Apr 2022 22:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392168AbiDUUGF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Apr 2022 16:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392165AbiDUUGE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Apr 2022 16:06:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825C649FB7;
        Thu, 21 Apr 2022 13:03:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C00461D1D;
        Thu, 21 Apr 2022 20:03:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352ACC385A1;
        Thu, 21 Apr 2022 20:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1650571393;
        bh=Aq9XfMUM5vNTE1Fx5se8LnP97Njf85xBlqPbEYPalh0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rTK9QaAXRP9bzz5ylD7Y8FPwLWC0cg0IzJhupm4/2Ttqd27Z7Iel+6OTiMI0+jKvi
         ZsQ5HZiIKpghu7h4Ib6dIzxPBWGP/t74oQeef06i+B1jTv6JJ+ft31HzkwiP2Bh9on
         bkDM05lpNu/hr+bNFQu1LOV0im02Ob+tvbC4dKCE=
Date:   Thu, 21 Apr 2022 13:03:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>, shuah@kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] selftest/vm: verify remap destination address in
 mremap_test
Message-Id: <20220421130312.45122e12437c017dcb676342@linux-foundation.org>
In-Reply-To: <76cd8347-a8d0-3b56-a202-17ba2a73503d@linuxfoundation.org>
References: <20220420215721.4868-1-sidhartha.kumar@oracle.com>
        <20220420215721.4868-2-sidhartha.kumar@oracle.com>
        <76cd8347-a8d0-3b56-a202-17ba2a73503d@linuxfoundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 21 Apr 2022 13:31:56 -0600 Shuah Khan <skhan@linuxfoundation.org> wrote:

> Andrew, please let me know if you would like me to take this
> through kselftest tree.

I'm easy.  If it turns up in linux-next via your tree, I drop the -mm copy.
