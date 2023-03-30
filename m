Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE9B6D0FE1
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Mar 2023 22:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjC3USf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Mar 2023 16:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjC3USc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Mar 2023 16:18:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F7FEFB2;
        Thu, 30 Mar 2023 13:18:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 701D862194;
        Thu, 30 Mar 2023 20:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86117C433EF;
        Thu, 30 Mar 2023 20:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1680207510;
        bh=XTszxfox9oLh3es63wEcoezcgUjjoFrEsUxixhLzQXU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aFp1OijlEuiaqThqnmM/IC7G9txXqyIZawhTv6JwSuKZ1ndYRx3TGiIdi+iWgQgYR
         oVpcE2EX9QtsAZZ9+1ej4ufaI3MK6OOVmFjKGubA0BLMeOAQ374+VqmO4nwixNmWza
         zm6o9QAm8MCvXSbbXfVKqivYsf+Ds+A5uG/kFSX8=
Date:   Thu, 30 Mar 2023 13:18:29 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com,
        linux-mm@kvack.org, riel@surriel.com, mhocko@suse.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        hannes@cmpxchg.org, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v4 0/3] mm: process/cgroup ksm support
Message-Id: <20230330131829.5b5070abf9ef5482aec01c81@linux-foundation.org>
In-Reply-To: <37dcd52a-2e32-c01d-b805-45d862721fbc@redhat.com>
References: <20230310182851.2579138-1-shr@devkernel.io>
        <20230328160914.5b6b66e4a5ad39e41fd63710@linux-foundation.org>
        <37dcd52a-2e32-c01d-b805-45d862721fbc@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 30 Mar 2023 06:55:31 +0200 David Hildenbrand <david@redhat.com> wrote:

> On 29.03.23 01:09, Andrew Morton wrote:
> > On Fri, 10 Mar 2023 10:28:48 -0800 Stefan Roesch <shr@devkernel.io> wrote:
> > 
> >> So far KSM can only be enabled by calling madvise for memory regions. To
> >> be able to use KSM for more workloads, KSM needs to have the ability to be
> >> enabled / disabled at the process / cgroup level.
> > 
> > Review on this series has been a bit thin.  Are we OK with moving this
> > into mm-stable for the next merge window?
> 
> I still want to review (traveling this week), but I also don't want to 
> block this forever.

No hurry, we're only at -rc4.  Holding this series in mm-unstable for
another 2-3 weeks isn't a problem.
