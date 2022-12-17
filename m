Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB7464F581
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Dec 2022 01:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiLQADc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Dec 2022 19:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiLQADR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Dec 2022 19:03:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F02750BC;
        Fri, 16 Dec 2022 16:02:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC9C7B81E2C;
        Sat, 17 Dec 2022 00:02:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6065C433EF;
        Sat, 17 Dec 2022 00:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671235376;
        bh=5A1aij+Hegtx0u914TiIF50pW15xVFJBSfDFBSTowrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oKS0sSfQh20gJwHqeDNttj9nsgLT4ClpeLJnQfPM65F0zBz7SrbJPUWoqLnPL1KLH
         BpSb1GvhGZMmg9o1FOEr0ERNKa/D978rJHDBwwi45xlDzY/+0XZa4ALrhUJ2iz/fsj
         eUL2rIvaEw7RXz7kVeqQ3F6/c+hWTq/219sZBF/n139agHMsLCCK022Qt1V//b2c36
         UWo8YHkgd8+Cr8sOCtQfJs978hiEIR1Pgh0Syok9DBnjzvgZS+09f9ZdjHwXJiex61
         wJaaxyYCOd7gyRMVwKUulYc70koddviL8ZHKHzVefySoW06LQv4KYIKrruiru5dwoi
         s9BtTaYLQuZ/w==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] implement DAMOS filtering for anon pages and
Date:   Sat, 17 Dec 2022 00:02:54 +0000
Message-Id: <20221217000254.59126-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221216155948.54023e407679736afcf00d9f@linux-foundation.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 16 Dec 2022 15:59:48 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Mon,  5 Dec 2022 23:08:19 +0000 SeongJae Park <sj@kernel.org> wrote:
> 
> > Subject: [PATCH 00/11] implement DAMOS filtering for anon pages and
> 
> I rewrote this to
> 
> implement DAMOS filtering for anon pages and/or specific memory cgroups

Sounds much better, thank you Andrew!


Thanks,
SJ
