Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CA363CBB6
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Nov 2022 00:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiK2XWP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Nov 2022 18:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiK2XWO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Nov 2022 18:22:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A08C31FB8;
        Tue, 29 Nov 2022 15:22:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7825661941;
        Tue, 29 Nov 2022 23:22:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD20CC433C1;
        Tue, 29 Nov 2022 23:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669764132;
        bh=qscdK9baUfkCyNd1PXFSDcTOmUtIGiCg/BFlbFQ972o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lSCW7k80V3NRYpSrdt8ZLevP7kBJnnvpUiJCMevtcX45imo7HVy/JSQhHm5QUaqf4
         gSqxDD1jEDSx+L2EiPUWyQgF369HwMEA34Qg6Ca0x4z0RtVUx+Am9ay81CXg+/r/sR
         F4EPCJtBCmIZbZJZG5xSWagD7gRb7hq700iIG0d5u0vdZ145+S2iFC3hJJaqcjPr0M
         DTMyQmMBCY0FrK5cbdNqTRJIJ0iIvFn+NJvPuQVNqL5gCYBSnxhfgg64ONWcYfCpEf
         HxlTPKgyFKDnCTSzuisBd55wYO508whjjypbH7KmGLyZxUlHHvIoLgurO940155kgc
         fspc6CJrCCsDw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6B7005C0584; Tue, 29 Nov 2022 15:22:12 -0800 (PST)
Date:   Tue, 29 Nov 2022 15:22:12 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v2 0/6] selftests: Use "grep -E" instead of "egrep"
Message-ID: <20221129232212.GG4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <1669165413-12035-1-git-send-email-yangtiezhu@loongson.cn>
 <bf9b26b5-2793-204f-ba9c-4d9cd55b08ad@loongson.cn>
 <dc7cb519-584c-55f1-4baa-44cd4e0bbfe9@linuxfoundation.org>
 <20221129221344.GF4001@paulmck-ThinkPad-P17-Gen-1>
 <d48804d5-2ad5-fbfb-ce17-83fbc450d3d6@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d48804d5-2ad5-fbfb-ce17-83fbc450d3d6@linuxfoundation.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 29, 2022 at 03:24:32PM -0700, Shuah Khan wrote:
> On 11/29/22 15:13, Paul E. McKenney wrote:
> > On Tue, Nov 29, 2022 at 02:39:25PM -0700, Shuah Khan wrote:
> > > On 11/22/22 19:27, Tiezhu Yang wrote:
> > > > It seems that patch #2~#6 has no conflicts with the other related
> > > > git tree, but patch #1 is conflicted with paulmck/linux-rcu.git dev.
> > > > 
> > > > What should I do?
> > > > 
> > > > Shuah, could you please apply patch #2~#6 to your linux-kselftest.git next branch and ignore patch #1?
> > > > 
> > > > And then let me send a seperate patch #1 rebased on paulmck/linux-rcu.git dev branch to rcu@vger.kernel.org.
> > > > 
> > > 
> > > That won't work because linux-kselftest next won't have the linux-rcu content.
> > > I already picked patches 1,2,6
> > > 
> > > Patches 3 (powerpc) and 5 (net) go through powerpc and net trees. Please resend
> > > just those cc'ing the right people. get_maintainers.pl will give you the info.
> > > 
> > > As for patch 1 - perhaps the conflict could be resolved in next.
> > > 
> > > Paul, would you like me to drop rcutorture patch from linux-kselftest next?
> > 
> > I would be happy to carry the rcutorture patch, especially if doing so
> > makes life easier.  ;-)
> > 
> > But please do send me some sort of pointer to the patch.  Otherwise,
> > I guarantee you that I will queue the wrong one.
> 
> I have it queued up in linux-kselftest next for Linux 6.2-rc1 - if it is easier
> we can just resolve the merge in next.

Lazybones that I am, I would rather carry the patch than resolve
conflicts.  Especially given the tendency for new rcutorture patches to
appear, thus changing the conflict resolution.

My guess is that the patch is this one:

https://lore.kernel.org/lkml/1669165413-12035-2-git-send-email-yangtiezhu@loongson.cn/

Or should I be looking elsewhere?

							Thanx, Paul
