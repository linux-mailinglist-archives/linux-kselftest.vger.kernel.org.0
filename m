Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2293434EC7
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Oct 2021 17:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhJTPPq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Oct 2021 11:15:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230373AbhJTPPp (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Oct 2021 11:15:45 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBBE56137C;
        Wed, 20 Oct 2021 15:13:29 +0000 (UTC)
Date:   Wed, 20 Oct 2021 11:13:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] tracing: Fix operator precedence for hist
 triggers expression
Message-ID: <20211020111328.02c487b7@gandalf.local.home>
In-Reply-To: <CAC_TJvfQCjZPS50-k2Pxo0jCcfxQ7oa1MZxQdADyjnwQ_TBzRA@mail.gmail.com>
References: <20211020013153.4106001-1-kaleshsingh@google.com>
        <20211020013153.4106001-4-kaleshsingh@google.com>
        <20211020102807.0b07bc81@gandalf.local.home>
        <CAC_TJvfQCjZPS50-k2Pxo0jCcfxQ7oa1MZxQdADyjnwQ_TBzRA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 20 Oct 2021 08:06:26 -0700
Kalesh Singh <kaleshsingh@google.com> wrote:

> That's a good idea. It would clean things up a bit and avoid bailing
> out if the user has a sym-offest in an expression string. I can send a
> separate patch for this.

+1

-- Steve
