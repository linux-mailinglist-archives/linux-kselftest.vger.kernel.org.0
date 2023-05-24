Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0A7710138
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 May 2023 00:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237435AbjEXW6f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 18:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbjEXW6e (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 18:58:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3638BB;
        Wed, 24 May 2023 15:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=kJ4Oy2Yrdt9sPa79KIijN8nSLPO32FE6oEphCMooz00=; b=NLhNyk/g75PlT2Vy8EtY+i9Odn
        zZ2va5B8EA39HX8C8P1rIs28BuCofS6gBUo88Y2C68QA68+cdUtM/X1sJiIm6QHolBK1pGnU6ssmt
        hC3RtAjCaEAEY32dHq+Alm5rFbqUpvGdH9E2O0vjtJ9rkkXgEbQ/MwOJzmLET6KhQ4T86vVZZ/dSd
        EiiWPDCZIaVnzkGHpPKyWQERl+aufoelypWlWKlESSS2J979o7eUOvwXuIiqwdZRwxxvk5ld7HXd/
        bz8bY+beCVerWZ7WgrZo8kSknXOL4yaXSR897XrRKAFp7wNunxJZMntX0MIGBRbIfwl4fT3lZLmw3
        6MFiZKwg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1xR7-00EsNL-2V;
        Wed, 24 May 2023 22:58:29 +0000
Date:   Wed, 24 May 2023 15:58:29 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, gregkh@linuxfoundation.org,
        tiwai@suse.de, tianfei.zhang@intel.com, russell.h.weight@intel.com,
        keescook@chromium.org, tweek@google.com, a.manzanares@samsung.com,
        dave@stgolabs.net, vincenzopalazzodev@gmail.com,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH] selftests: allow runners to override the timeout
Message-ID: <ZG6WlUZZN4etzM2k@bombadil.infradead.org>
References: <20230414193845.2494120-1-mcgrof@kernel.org>
 <3f5c5c28-3814-3fea-dfbb-a3c7604e0edc@collabora.com>
 <CAB=NE6Wx=PQ6n__hdseLzahNdkGoyUXDW4w9B5bBLvg-kVxbXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB=NE6Wx=PQ6n__hdseLzahNdkGoyUXDW4w9B5bBLvg-kVxbXA@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 11, 2023 at 08:26:42AM -0700, Luis Chamberlain wrote:
> On Fri, Apr 28, 2023 at 1:34 AM Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
> >
> > On 4/15/23 12:38 AM, Luis Chamberlain wrote:
> > > The default timeout for selftests tests is 45 seconds. Although
> > > we already have 13 settings for tests of about 96 sefltests which
> > > use a timeout greater than this, we want to try to avoid encouraging
> > > more tests to forcing a higher test timeout as selftests strives to
> > > run all tests quickly. Selftests also uses the timeout as a non-fatal
> > > error. Only tests runners which have control over a system would know
> > > if to treat a timeout as fatal or not.
> > >
> > > To help with all this:
> > >
> > >   o Enhance documentation to avoid future increases of insane timeouts
> > >   o Add the option to allow overriding the default timeout with test
> > >     runners with a command line option
> > >
> > > Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
> > > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > Tested-by:Muhammad Usama Anjum <usama.anjum@collabora.com>
> 
> Shuah, just a friendly poke! This is needed to allow me to enable full
> automation for kdevops for selftests.

Shuah, friendly re-poke.

  Luis
