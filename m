Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F14C43D838
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Oct 2021 02:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbhJ1AqW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Oct 2021 20:46:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229437AbhJ1AqV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Oct 2021 20:46:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2362610C7;
        Thu, 28 Oct 2021 00:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635381835;
        bh=ms2wN3CfuOl4f9invWVZz5Oi0ljrc8QJ5JepVWRQbhg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QPUO2GZkFT9Fw6KHOgTYYKPOgbUfk+os5J7JOoQqSytc6kmkKjgHR/G4zUv32Ff8b
         dorZI0mYv56jvr/pnEMSIov/28+89Yc6TzKXJnj8g+nWMt5h+bU4fAEx+GvP0RLnsl
         D2RLEgfoBOQPKabt4DMspD4k4DqKfZFuRtkSabVmuviBVW+OLyMY1nc56ajj2AHTfR
         i+3PDedNHsVbX4fmAgaeYKb/kqh8fiHhJ0dVeKbb+nhA/9DOb5o8MlqKALUZ2HPjzu
         4ExIWzRvBx7JbR6NO7TCVYPA0yq88GGtvbunfNyJvQ53G8NewV1ruIzpWcDYw7tkHi
         P8pMuFNMbOBjA==
Date:   Thu, 28 Oct 2021 09:43:51 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Kalesh Singh <kaleshsingh@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, surenb@google.com,
        hridya@google.com, namhyung@kernel.org, kernel-team@android.com,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/3] tracing/kselftests: Remove triggers with references
 before their definitions
Message-Id: <20211028094351.617b7c2ea7c56055ee68d909@kernel.org>
In-Reply-To: <20211027195454.60993c83@rorschach.local.home>
References: <20211027205919.1648553-1-kaleshsingh@google.com>
        <20211027205919.1648553-3-kaleshsingh@google.com>
        <20211028065849.76b1bd7151e440881298b523@kernel.org>
        <CAC_TJvdxEuqkzH+VDNQvWZbLjHj0BKfnCHn647Y9-Ve2UTftRg@mail.gmail.com>
        <20211027195454.60993c83@rorschach.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 27 Oct 2021 19:54:54 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 27 Oct 2021 16:26:00 -0700
> Kalesh Singh <kaleshsingh@google.com> wrote:
> 
> > > Why don't you use 'tac'? I love that idea :)
> > > Did you find any issue?  
> > 
> > Hi Masami,
> > 
> > Thanks for the reviews. As with the first set of patches using tac
> > gives a regression here, though I'm not sure why it doesn't work -- I
> > also thought reversing the order would handle any dependencies
> > correctly.
> 
> Right, because are triggers not added by list_add_rcu() which adds to
> the head of the list.

Oops, so are the triggers shown in the reverse order?
(newer entry is top, older one is bottom)
Then do we need this patch, because we don't care about the
dependency.

> If anything, shouldn't things be removed in order?

Hmm, I think the trigger itself might better to be changed. If any dependency in
the trigger list, it can not be restored from the copied file, like
below may fail.

cat events/foo/bar/trigger > /tmp/foo.bar.trigger
cat /tmp/foo.bar.trigger > events/foo/bar/trigger

(of course we can use 'tac' to restore it ...)

This is 

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
