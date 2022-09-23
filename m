Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86175E7C30
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Sep 2022 15:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbiIWNrF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Sep 2022 09:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbiIWNrE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Sep 2022 09:47:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D69126B6B;
        Fri, 23 Sep 2022 06:46:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A8F0021A5A;
        Fri, 23 Sep 2022 13:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663940812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8vGCZfchEFFjpHwi1/o54WkcrU8R1sIbEuaLYYPinG4=;
        b=uTbh1d1JcX4/yC2tkEubaGmOun2VRv+6BNfCsGPpqyPSml4Se6ReudOBTcb9u6QFqDOCNM
        AOdFHOuTYuEilieIh87JkcMUZ2Jr2Qt9GjMTeBa+rSL+5VlmLEB77QMB1h3Lehezg7RpoZ
        1wSVqz9eqlAS6DX0DbIMNRf7XdX0UI8=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8769C2C15A;
        Fri, 23 Sep 2022 13:46:52 +0000 (UTC)
Date:   Fri, 23 Sep 2022 15:46:49 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>,
        Yannick Cote <ycote@redhat.com>, Dennis Li <denli@redhat.com>
Subject: Re: [PATCH] selftests/livepatch: normalize sysctl error message
Message-ID: <Yy24yV+xd9KTBMBb@alley>
References: <20220811212138.182575-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811212138.182575-1-joe.lawrence@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu 2022-08-11 17:21:38, Joe Lawrence wrote:
> The livepatch kselftests rely on comparing expected and actual output
> from such commands as sysctl.  A recent commit in procps-ng v4.0.0 [1]
> changed sysctl's output to emit key pathnames like:
> 
>   sysctl: setting key "/proc/sys/kernel/ftrace_enabled": Device or resource busy
> 
> versus previous dotted output:
> 
>   sysctl: setting key "kernel.ftrace_enabled": Device or resource busy
> 
> The modification in output was later reverted [2], but since the change
> has been tagged in procps-ng v4.0.0, update the livepatch kselftest to
> handle either case.
> 
> [1] https://gitlab.com/procps-ng/procps/-/commit/6389deca5bf667f5fab5912acde78ba8e0febbc7
> [2] https://gitlab.com/procps-ng/procps/-/commit/b159c198c9160a8eb13254e2b631d0035b9b542c
> 
> Reported-by: Dennis(Zhuoheng) Li <denli@redhat.com>
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>

JFYI, the patch has been committed into livepatching.git, branch
for-6.1/fixes.

Best Regards,
Petr
