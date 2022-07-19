Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD26579540
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 10:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiGSIci (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 04:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiGSIch (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 04:32:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D882C220D1;
        Tue, 19 Jul 2022 01:32:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91E3DB81893;
        Tue, 19 Jul 2022 08:32:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0F3C341C6;
        Tue, 19 Jul 2022 08:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658219554;
        bh=pplzxYz6sIF7Mjy2044C1CiT3gW+EWOdS76ev7aFkFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FwKxrFSVQL3hlswBw4lRRBHWH90KbD1z2uO1coRHKpavqBkt+9nh3n0GtVERzfPc6
         2orAVr7dY8eJGmGWVSVuCLTk6Ot/5ycingm10rYQGCNOgGe7Wpv9VH8fBDB+l+jG+p
         evypO8rjE60vG4OhVd9PuZOD1lpv5dT2Q9YeCVwLkEOfgfN1/objmmgwMMxJHifuOc
         cBNIs743ctJu0UmjVd8O1EnHTemThPNu6vD6imLNjUdzY0AZdlAVMJDyx9rpMtzsGl
         aQQhwgSRaFCIdUVpipsARyiuYboLM1lfvOZG0up8ex3fHmgEDquXiHFdMgzKbFqhp7
         W2NK4/VcUFMNQ==
Date:   Tue, 19 Jul 2022 10:32:29 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] ksefltest: pidfd: Fix wait_states: Test terminated by
 timeout
Message-ID: <20220719083229.b2yn2msrklmo2nb5@wittgenstein>
References: <20220718025826.29148-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220718025826.29148-1-lizhijian@fujitsu.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 18, 2022 at 02:58:39AM +0000, lizhijian@fujitsu.com wrote:
> 0Day/LKP observed that the kselftest blocks forever since one of the
> pidfd_wait doesn't terminate in 1 of 30 runs. After digging into
> the source, we found that it blocks at:
> ASSERT_EQ(sys_waitid(P_PIDFD, pidfd, &info, WCONTINUED, NULL), 0);
> 
> wait_states has below testing flow:
>   CHILD                 PARENT
>   ---------------+--------------
> 1 STOP itself
> 2                   WAIT for CHILD STOPPED
> 3                   SIGNAL CHILD to CONT
> 4 CONT
> 5 STOP itself
> 5'                  WAIT for CHILD CONT
> 6                   WAIT for CHILD STOPPED
> 
> The problem is that the kernel cannot ensure the order of 5 and 5', once
> 5's goes first, the test will fail.
> 
> we can reproduce it by:
> $ while true; do make run_tests -C pidfd; done
> 
> Introduce a blocking read in child process to make sure the parent can
> check its WCONTINUED.
> 
> CC: Philip Li <philip.li@intel.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> I have almost forgotten this patch since the former version post over 6 months
> ago. This time I just do a rebase and update the comments.
> V2: rewrite with pipe to avoid usleep
> ---

Thanks for sticking with this!
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
