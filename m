Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7240D43D7C6
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Oct 2021 01:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbhJ0X5Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Oct 2021 19:57:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229614AbhJ0X5X (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Oct 2021 19:57:23 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E414660F9C;
        Wed, 27 Oct 2021 23:54:55 +0000 (UTC)
Date:   Wed, 27 Oct 2021 19:54:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, surenb@google.com,
        hridya@google.com, namhyung@kernel.org, kernel-team@android.com,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/3] tracing/kselftests: Remove triggers with references
 before their definitions
Message-ID: <20211027195454.60993c83@rorschach.local.home>
In-Reply-To: <CAC_TJvdxEuqkzH+VDNQvWZbLjHj0BKfnCHn647Y9-Ve2UTftRg@mail.gmail.com>
References: <20211027205919.1648553-1-kaleshsingh@google.com>
        <20211027205919.1648553-3-kaleshsingh@google.com>
        <20211028065849.76b1bd7151e440881298b523@kernel.org>
        <CAC_TJvdxEuqkzH+VDNQvWZbLjHj0BKfnCHn647Y9-Ve2UTftRg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 27 Oct 2021 16:26:00 -0700
Kalesh Singh <kaleshsingh@google.com> wrote:

> > Why don't you use 'tac'? I love that idea :)
> > Did you find any issue?  
> 
> Hi Masami,
> 
> Thanks for the reviews. As with the first set of patches using tac
> gives a regression here, though I'm not sure why it doesn't work -- I
> also thought reversing the order would handle any dependencies
> correctly.

Right, because are triggers not added by list_add_rcu() which adds to
the head of the list. If anything, shouldn't things be removed in order?

-- Steve
