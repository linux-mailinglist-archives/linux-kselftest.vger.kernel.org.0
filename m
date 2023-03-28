Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBEF6CCDE2
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Mar 2023 01:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjC1XJS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Mar 2023 19:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjC1XJR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Mar 2023 19:09:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE1B2109;
        Tue, 28 Mar 2023 16:09:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A269D619E9;
        Tue, 28 Mar 2023 23:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1244C433D2;
        Tue, 28 Mar 2023 23:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1680044955;
        bh=8Wd0H0r4Y5vxHoD+EkGCPkXRzVkuf1s2NZi8Up9rhqA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W/NE0DcX3GATvg/vghQSAyn7dAM5VACRWZBXY7SJi2E5H2n/lfzrGZhS75RTkaCTi
         FwtIdOOe4c7gDK+ZkY3a21Gt2QbnhV9fIAenplVpRKOdGXkEr/CpwPfrN2foeTgvx9
         kjUyzFil5Vk1WRrUl4Vh9rJFx6zYSiqtR6GcsbT4=
Date:   Tue, 28 Mar 2023 16:09:14 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, hannes@cmpxchg.org
Subject: Re: [PATCH v4 0/3] mm: process/cgroup ksm support
Message-Id: <20230328160914.5b6b66e4a5ad39e41fd63710@linux-foundation.org>
In-Reply-To: <20230310182851.2579138-1-shr@devkernel.io>
References: <20230310182851.2579138-1-shr@devkernel.io>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 10 Mar 2023 10:28:48 -0800 Stefan Roesch <shr@devkernel.io> wrote:

> So far KSM can only be enabled by calling madvise for memory regions. To
> be able to use KSM for more workloads, KSM needs to have the ability to be
> enabled / disabled at the process / cgroup level.

Review on this series has been a bit thin.  Are we OK with moving this
into mm-stable for the next merge window?
