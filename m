Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3E1692B14
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Feb 2023 00:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjBJXX6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Feb 2023 18:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjBJXX5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Feb 2023 18:23:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3C3213C;
        Fri, 10 Feb 2023 15:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AP2TD6OwnYFB37LieArEw/htbLdqYVrISvpIX8EBFdg=; b=X65Rd1uAmhiuyDSNLjQpJsDEsQ
        G4bh0XGxOtNAXgbjackcfpqShmCCJWH2iUhpKKi+AhoKk5NW3Z07078WWbo6XqkrQmv+C9Y/2/Vbq
        zqb4pwIWQT+QtYrheWc2EO0a8ZhtC4AeRJ1qYLoZxkytQMA7JVQVy2tC3H/aTcmZ6CF9e+WghTBtr
        9COe7U3W9+OwzqltMWY+fVDy5oQrG9+DBMTw03CVs/DCpguYzRYKkRBuXM+AGwbxwtnNBNtRJKGX5
        hb5c+GOElZZBfVBrRuFeLWmwFYKqelp8TK99Fb4U5MUqHE1cj9TElbsa2nqSua0Oedn4zbBXwFlpA
        iwabePWw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQcjv-003XoO-Ev; Fri, 10 Feb 2023 23:23:35 +0000
Date:   Fri, 10 Feb 2023 23:23:35 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [RFC PATCH v2 00/19] mm: process/cgroup ksm support
Message-ID: <Y+bR99Ca+7SObeQo@casper.infradead.org>
References: <20230210215023.2740545-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210215023.2740545-1-shr@devkernel.io>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 10, 2023 at 01:50:04PM -0800, Stefan Roesch wrote:
> So far KSM can only be enabled by calling madvise for memory regions. What is
> required to enable KSM for more workloads is to enable / disable it at the
> process / cgroup level.
> 
> Use case:
> The madvise call is not available in the programming language. An example for
> this are programs with forked workloads using a garbage collected language without
> pointers. In such a language madvise cannot be made available.
> 
> In addition the addresses of objects get moved around as they are garbage
> collected. KSM sharing needs to be enabled "from the outside" for these type of
> workloads.

Don't you have source code to the interpreter for this mysterious
language?  Usually that would be where we put calls to madvise()
