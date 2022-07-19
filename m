Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8011857A5E4
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 19:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239602AbiGSR5m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 13:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239450AbiGSR5k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 13:57:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3189491FD;
        Tue, 19 Jul 2022 10:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zzUIRIht87i87ejebhFC7TuGYg8/m8IXVZ2t8R4E70E=; b=v7nB5fNt3NhPau+HZvZwUrXh1y
        5PYC7VRvq2fnz8wNEsBqCtXBXNBcTJcsBW/QOihGsRrDjKFHRkHPbZjg3usQUpq7IlBqJVUcePTiv
        BZw491C86/FjMnF9x+x1QHCAsqy2t/lfZalKis8Cjpp07uVVYImb2JOKXt33uG42J2JjN7rcQIvU1
        LlhoBciJsGLYVRnyk+Di84HdHX/3HH1utyz4DuEXo4iYZUJ1j+oqlTUG2qIyEVGPtqOBH1wZLofzM
        Az/ep1Pkw8Oel4zHsaYIDCWD9c69ntBe/Rkh2wbxF+9j5MgJ75XLZr7O0f/OnIRQF8kItfdknnt/W
        ekvvBYfg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDrTP-00B2IY-DK; Tue, 19 Jul 2022 17:57:31 +0000
Date:   Tue, 19 Jul 2022 10:57:31 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        linux-modules@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] module: kunit: Load .kunit_test_suites section when
 CONFIG_KUNIT=m
Message-ID: <YtbwixbViJr9zkv8@bombadil.infradead.org>
References: <20220713005221.1926290-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713005221.1926290-1-davidgow@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 13, 2022 at 08:52:20AM +0800, David Gow wrote:
> The new KUnit module handling has KUnit test suites listed in a
> .kunit_test_suites section of each module. This should be loaded when
> the module is, but at the moment this only happens if KUnit is built-in.
> 

This commit log does not describe what functionality is broken exactly
without this commit. What functionality from kunit is provided when
.kunit_test_suites is available?

> Also load this when KUnit is enabled as a module: it'll not be usable
> unless KUnit is loaded, 

What benefit is there to load a kunit module without kunit?

> but such modules are likely to depend on KUnit
> anyway, so it's unlikely to ever be loaded needlessly.
>
> Fixes: 3d6e44623841 ("kunit: unify module and builtin suite definitions")
> Signed-off-by: David Gow <davidgow@google.com>
