Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850786DE626
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 23:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjDKVHI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 17:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjDKVHG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 17:07:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46EB5241;
        Tue, 11 Apr 2023 14:07:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2ACF8626BB;
        Tue, 11 Apr 2023 21:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8839C433EF;
        Tue, 11 Apr 2023 21:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681247222;
        bh=lBhnQ7dbcV33KZiMsFreuCnXVxEpl5XmOabAfshIlOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cZWzInoe2B0H2VkubIHbSALz+O5E7G16jgqtIlSJV8dV38acTXy0RLv04XbhA2JJc
         07dFyjduO9/2rf376uQY/ayaUXFa9cQScy3fogN6JQpNrNeIa+qqL4JvV9p/x4wFrl
         fqiIYm7O5RqCfFa2fDvpomglLq2WWDhzKbqcR6M1NVNE/5P65k/9EwHn4DBi2gSONS
         yt0moG42j1c2+yBRbQT3hVrEem4qEI2/aKPHawGnxmX4S4pwIeQTOaYBSUgMjPRrWw
         rbRIAmhhOeeYN5s4MvSp0gYeDnO9NTo8gCEQkRD+OCumriaTXTesrmfs3dj2NH8Lr0
         HL/VCY02n74Cw==
Date:   Tue, 11 Apr 2023 22:06:57 +0100
From:   Will Deacon <will@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     paulmck@kernel.org, Mark Brown <broonie@kernel.org>,
        Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] tools/nolibc/stdio: Implement vprintf()
Message-ID: <20230411210656.GA23890@willie-the-truck>
References: <20230405-kselftest-nolibc-v2-0-2ac2495814b5@kernel.org>
 <20230405-kselftest-nolibc-v2-1-2ac2495814b5@kernel.org>
 <ZC8OwUPAC4s413jP@1wt.eu>
 <cbece9a0-b8d0-4f3e-9a55-9fe87e111392@paulmck-laptop>
 <fc52d5c1-61db-b8e3-e608-12434b0ee740@linuxfoundation.org>
 <9dfb88e8-2a61-47a8-876e-581e4c717217@sirena.org.uk>
 <20230411150320.GA23045@willie-the-truck>
 <0144ab97-f34a-4803-8fdb-52340f2d73f2@sirena.org.uk>
 <6a323775-6274-4d0c-844a-da53146c2abe@paulmck-laptop>
 <e81d0c3b-f301-e2cf-077d-fe9a934e7590@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e81d0c3b-f301-e2cf-077d-fe9a934e7590@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 11, 2023 at 12:54:29PM -0600, Shuah Khan wrote:
> On 4/11/23 10:44, Paul E. McKenney wrote:
> > On Tue, Apr 11, 2023 at 04:13:11PM +0100, Mark Brown wrote:
> > > On Tue, Apr 11, 2023 at 04:03:21PM +0100, Will Deacon wrote:
> > > > On Tue, Apr 11, 2023 at 03:31:10PM +0100, Mark Brown wrote:
> > > 
> > > > > It seems like more of a kselftest change than anything else so probably
> > > > > makes sense for it to go that way?  The example user isn't really even
> > > > > needed.
> > > 
> > > > Fine by me, as long as it doesn't conflict with any other arm64 selftest
> > > > changes you hope to land for 6.4.
> > > 
> > > That shouldn't be an issue.
> > 
> > Shuah, looks to me like this one is yours in kselftest, then.  ;-)
> > 
> > 							Thanx, Paul
> 
> I will pick these up for Linux 6.4

Cheers, Shuah!

Will
