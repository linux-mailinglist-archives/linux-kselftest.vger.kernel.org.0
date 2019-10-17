Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B46F8DA2B8
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2019 02:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389893AbfJQAcf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Oct 2019 20:32:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbfJQAcf (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Oct 2019 20:32:35 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57CB921848;
        Thu, 17 Oct 2019 00:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571272354;
        bh=x+Xg+um+3arak66QXngQRbWrisF5xOKXVnntskQXOj0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=06Lu8qQ4MsxFbpxc4SctE1Ioaas2QaprGiBHYXpAJxfPb6VnDXnOxBlk5feE6FTRp
         1igHy1IDbzKYW8IhMk96pcqSe1niybDSe0titVIUKbM3otlueY3y8kL0lDwXRgvkCI
         SU7y4LhxzBL+fmVdL/8OuK/4lxWLGnLs4bDNh7uY=
Date:   Wed, 16 Oct 2019 17:32:33 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-kselftest/test v2] lib/list-test: add a test for
 the 'list' doubly linked list
Message-Id: <20191016173233.2bd9c9d47f12453c1cb4a9b7@linux-foundation.org>
In-Reply-To: <CABVgOS=W4cfFoE=JT4mbk1zkUsreucrw_B81R2jwDCFPocomHQ@mail.gmail.com>
References: <20191010185631.26541-1-davidgow@google.com>
        <20191011140727.49160042fafa20d5867f8df7@linux-foundation.org>
        <CABVgOS=UwWxwD97c6y-XzbLWVhznPjBO3qvQEzX=8jTJ-gBi3A@mail.gmail.com>
        <20191011145519.7b7a1d16ecdead9bec212c01@linux-foundation.org>
        <CABVgOS=W4cfFoE=JT4mbk1zkUsreucrw_B81R2jwDCFPocomHQ@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 16 Oct 2019 14:48:59 -0700 David Gow <davidgow@google.com> wrote:

> Since KUnit is not yet in Linus' branch, though, it probably makes
> sense to put this test into the linux-kselftest/test branch, so that
> there aren't any chances of the list test getting in without the KUnit
> infrastructure. Ultimately, once KUnit is upstream, this shouldn't be
> an issue, but it is probably easier to consolidate things for now.
> Does that sound sensible?

Well, whatever.  I have a note that it's dependent on kunit.
