Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0FD434D8F
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Oct 2021 16:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhJTOa0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Oct 2021 10:30:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:59748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229570AbhJTOaZ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Oct 2021 10:30:25 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 988AD611B0;
        Wed, 20 Oct 2021 14:28:09 +0000 (UTC)
Date:   Wed, 20 Oct 2021 10:28:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/5] tracing: Fix operator precedence for hist
 triggers expression
Message-ID: <20211020102807.0b07bc81@gandalf.local.home>
In-Reply-To: <20211020013153.4106001-4-kaleshsingh@google.com>
References: <20211020013153.4106001-1-kaleshsingh@google.com>
        <20211020013153.4106001-4-kaleshsingh@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 19 Oct 2021 18:31:40 -0700
Kalesh Singh <kaleshsingh@google.com> wrote:

> +	minus_op = strrchr(str, '-');
> +	if (minus_op) {
> +		/* Unfortunately, the modifier ".sym-offset" can confuse things. */
> +		if (minus_op - str >= 4 && !strncmp(minus_op - 4, ".sym-offset", 11))
> +			goto out;
>  

I was thinking about this, and perhaps we can add this later, but we could
just replace all ".sym-offset" with ".symXoffset" after receiving it from
the user. Then it won't be an issue during prasing.

-- Steve
