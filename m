Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B584F4BB417
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Feb 2022 09:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbiBRIYx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Feb 2022 03:24:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiBRIYw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Feb 2022 03:24:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EA73E0FB;
        Fri, 18 Feb 2022 00:24:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE6DDB824A3;
        Fri, 18 Feb 2022 08:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D9AC340E9;
        Fri, 18 Feb 2022 08:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645172674;
        bh=pae/aN5UV9dv8pK4WMcI2r3n2XoZK9a73URkWMOsIU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=nPho2b8erTCNwqyeEtsBRpmMOA28WSKNSM80QMXGtOhqnxS2kscFrpozFk8dcvKwY
         nE7zdwKqDVye4p7zcmikDqBFAlzORK6kp/bxSPS+BgbM2DeBlz1DqdxqRXOgaLB+49
         O7keRvG2n1Ptmcq2EEkKETwDL8s8mzTOIkcywNC+qVvzKXi5bFPsUTYbCpQWYK7YNt
         KxEegVdCS0DfHem1JyXAfAToN3P6yOiqwtSSw//xb7JZj/5zdyeSZZSmMxEfwZWRvL
         9dxeR+iTzVorcXVjxdRx8kVjefAY7Us2ULfGSsKh6eYbpa9aB3tLqFYJoZC12BJiIt
         F1e2fDqDWMDXw==
From:   SeongJae Park <sj@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Yuanchu Xie <yuanchu@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Markus Boehme <markubo@amazon.de>, rientjes@google.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/damon: make selftests executable
Date:   Fri, 18 Feb 2022 08:24:28 +0000
Message-Id: <20220218082428.11699-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <Yg9SR88j0JV/0gKJ@kroah.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 18 Feb 2022 09:01:11 +0100 Greg KH <gregkh@linuxfoundation.org> wrote:

> On Fri, Feb 18, 2022 at 07:52:54AM +0000, SeongJae Park wrote:
> > Hello Yuanchu,
> > 
> > Thank you for this patch!
> > 
> > On Fri, 18 Feb 2022 00:10:17 +0000 Yuanchu Xie <yuanchu@google.com> wrote:
> > 
> > > The damon selftests do not have the executable bit on. We fix that by
> > > setting the x bits on the .sh files similar to other existing shell
> > > selftests.
> > > 
> > > Fixes: 9ab3b0c8ef62 ("selftests/damon: split test cases")
> > > Signed-off-by: Yuanchu Xie <yuanchu@google.com>
> > 
> > Reviewed-by: SeongJae Park <sj@kernel.org>
> 
> This type of change does not work outside of git, so why not just make
> the tool that calls these scripts not care about the executable bit like
> we do for other scripts?

Actually, we made kselftest receives scripts having no executable bit[1],
though it still prints warning.  I guess Yuanchu wants to remove the warning?

To remove the warning, simply making kselftest (runner.sh) stop printing the
warning message might make more sense.  Nevertheless, it's also true that
letting some scripts have executable bits while others not looks inconsistent
to me.  That's why I left the warning message there.  Should we remove the
warning from kselftest and remove executable bits from other selftest test
scripts?  Or, let the inconsistency be?  I have no real opinion here, so just
wanted to hear others' opinion if possible.

BTW, similar issue is also in Kconfig's 'shell' macro.  For example,
'runst-version.sh' on -mm tree bothered me before[2], and now
'pahole-version.sh'.  I might make change in 'scrips/Kconfig/preprocess.c'
later.

[1] https://lore.kernel.org/linux-kselftest/20210810164534.25902-1-sj38.park@gmail.com/
[2] https://lore.kernel.org/all/20220110085952.6137-1-sj@kernel.org/


Thanks,
SJ

> 
> thanks,
> 
> greg k-h
