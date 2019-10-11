Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 889F9D49A9
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2019 23:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfJKVH2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Oct 2019 17:07:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:54106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbfJKVH2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Oct 2019 17:07:28 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D48C72084C;
        Fri, 11 Oct 2019 21:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570828048;
        bh=aQMqDlsnoBTIz0mNGHdEi8HmeClEvJuYXYfeLOP/bAI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YRWc3z0XqFMKcdH8YJASJPrb1Wb0U8qvQeSzLrWcrT31F5Bp45QNgFpqyH/3fy5Cb
         j745e1AEeuxk6HOXuVMrjUydGry1k7sg7pu4vJnmlj9esz0RTRQwJkff6arYHIt9tx
         UewnqgSFeed2oEBxvkDx7/FEtAK7fmjTmxr3ApQ8=
Date:   Fri, 11 Oct 2019 14:07:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Gow <davidgow@google.com>
Cc:     David Gow <davidgow@google.com>, shuah@kernel.org,
        brendanhiggins@google.com, keescook@chromium.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-kselftest/test v2] lib/list-test: add a test for
 the 'list' doubly linked list
Message-Id: <20191011140727.49160042fafa20d5867f8df7@linux-foundation.org>
In-Reply-To: <20191010185631.26541-1-davidgow@google.com>
References: <20191010185631.26541-1-davidgow@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 10 Oct 2019 11:56:31 -0700 David Gow <davidgow@google.com> wrote:

> Add a KUnit test for the kernel doubly linked list implementation in
> include/linux/list.h
> 
> Each test case (list_test_x) is focused on testing the behaviour of the
> list function/macro 'x'. None of the tests pass invalid lists to these
> macros, and so should behave identically with DEBUG_LIST enabled and
> disabled.
> 
> Note that, at present, it only tests the list_ types (not the
> singly-linked hlist_), and does not yet test all of the
> list_for_each_entry* macros (and some related things like
> list_prepare_entry).
> 
> ...
>
>  MAINTAINERS       |   5 +
>  lib/Kconfig.debug |  12 +
>  lib/Makefile      |   3 +
>  lib/list-test.c   | 738 ++++++++++++++++++++++++++++++++++++++++++++++

Should this be lib/kunit/list-test.c?


