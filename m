Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9175A6429
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Aug 2022 14:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiH3M4V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 08:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiH3M4E (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 08:56:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D9FAEDAE;
        Tue, 30 Aug 2022 05:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kzUIqwLwyoAHe13fdSfoFA6rcHGHeXti2XRC8Z2C/Qw=; b=E3HCE5rED8f/4ky5V4p+vTFtiC
        681+hpGie25wwfbhi/FmGLlR6tzZZknPrqv6JW4zsAq1XdnQeGGGf5Avd2QRtAgMrcnE3U4DSC4If
        TVVHZJSP6HkVJJP1vP2YL/ZlBoTySkPfbwKRlOJp/vd4kyw8KgAZLnuBCZnyCZlKGoXpmkbNzJrLN
        XA+zXlDQht7BBu31aHWgxNUT7RqF8FZxBelCu3MTpvvi4BllU5gY/BsCwfP2E/d5rw0bPNxTklAaM
        ICE40rUDMvz/TkH4pwo8DIuz7gSiw8luunvNe6UEHC3OpbIA5lqYyESQBhrSvOsKctUc7e88SUzvD
        p59gK1eg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oT0lZ-00433h-Rw; Tue, 30 Aug 2022 12:54:53 +0000
Date:   Tue, 30 Aug 2022 13:54:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     frowand.list@gmail.com
Cc:     David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, Tim.Bird@sony.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Corbet <corbet@lwn.net>, rmr167@gmail.com,
        guillaume.tucker@collabora.com, dlatypov@google.com,
        kernelci@groups.io, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] ktap_v2: change version to 2-rc in KTAP
 specification
Message-ID: <Yw4InUF5TpR/wdwb@casper.infradead.org>
References: <20220829233150.3564612-1-frowand.list@gmail.com>
 <20220829233150.3564612-2-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829233150.3564612-2-frowand.list@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 29, 2022 at 06:31:49PM -0500, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Prepare KTAP Specification for the process of creating version 2.
> 
> The version will remain "2-rc" until the final commit to complete
> Version 2.  Adding the "-rc" ensures that none of the development
> versions will be mistaken for the completed version 2.
> 
> After this commit, Sphinx complains that we now need more '=' signs:
> 
>   Documentation/dev-tools/ktap.rst:3: WARNING: Title overline too short.
>   ===================================================
>   The Kernel Test Anything Protocol (KTAP), version 2-rc
>   ===================================================

Hey Frank, you can actually use overlength lines to prevent this kind of
problem from occurring.  eg, this is perfectly acceptable:

===================================================================
Hi
===================================================================

I wonder if we should prefer this style to avoid the rash of complaints
when a headline is changed.
