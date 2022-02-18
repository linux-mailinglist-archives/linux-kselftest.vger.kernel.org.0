Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5134BB3C0
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Feb 2022 09:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiBRIBc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Feb 2022 03:01:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiBRIBb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Feb 2022 03:01:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DD31738F9;
        Fri, 18 Feb 2022 00:01:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00B7A612AF;
        Fri, 18 Feb 2022 08:01:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C17FC340E9;
        Fri, 18 Feb 2022 08:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645171274;
        bh=wlMKj3Vczzg2CXtGVuAuaNfHplfiJXvDzqzkB6AONQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=meXSLvfjyeKjeSTO3/guG9OP9lyEqngjge5GQ4Jkxme5Qsg30IPN13Pvt8KgZTiG6
         8jrbmMG2+B60qLx5jS/DdONcm3Bj6042Q8asqr4Xv77To8xrSFuhAeihzNjv9roia8
         vxbCvnM8bS6LDYfhP1+S+1eLUAnyBuZKkx60qOD4=
Date:   Fri, 18 Feb 2022 09:01:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Yuanchu Xie <yuanchu@google.com>, Shuah Khan <shuah@kernel.org>,
        Markus Boehme <markubo@amazon.de>, rientjes@google.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/damon: make selftests executable
Message-ID: <Yg9SR88j0JV/0gKJ@kroah.com>
References: <20220218001017.3500673-3-yuanchu@google.com>
 <20220218075254.11467-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218075254.11467-1-sj@kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 18, 2022 at 07:52:54AM +0000, SeongJae Park wrote:
> Hello Yuanchu,
> 
> Thank you for this patch!
> 
> On Fri, 18 Feb 2022 00:10:17 +0000 Yuanchu Xie <yuanchu@google.com> wrote:
> 
> > The damon selftests do not have the executable bit on. We fix that by
> > setting the x bits on the .sh files similar to other existing shell
> > selftests.
> > 
> > Fixes: 9ab3b0c8ef62 ("selftests/damon: split test cases")
> > Signed-off-by: Yuanchu Xie <yuanchu@google.com>
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>

This type of change does not work outside of git, so why not just make
the tool that calls these scripts not care about the executable bit like
we do for other scripts?

thanks,

greg k-h
